package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import haxe.Json;
import haxe.format.JsonParser;
import Alphabet;
#if sys
import sys.FileSystem;
import sys.io.File;
#end
import openfl.utils.Assets;

using StringTools;

typedef DialogueCharacterFile = {
	var image:String;
	var dialogue_pos:String;
	var no_antialiasing:Bool;

	var animations:Array<DialogueAnimArray>;
	var position:Array<Float>;
	var scale:Float;
}

typedef DialogueAnimArray = {
	var anim:String;
	var loop_name:String;
	var loop_offsets:Array<Int>;
	var idle_name:String;
	var idle_offsets:Array<Int>;
}

// Gonna try to kind of make it compatible to Forever Engine,
// love u Shubs no homo :flushedh4:
typedef DialogueFile = {
	var dialogue:Array<DialogueLine>;
	var background:Array<DialogueBackground>;
}

typedef DialogueBackground = {
	var bgName:Null<String>;
	var bg:Null<String>;
	var xPos:Null<Float>;
	var yPos:Null<Float>;
	var scale:Array<Float>;
	var graphicScale:Array<Float>;
	var includeDefaultAnimations:Bool;
	var animations:Array<DialogueBackgroundAnimsArray>;
}

typedef DialogueBackgroundAnimsArray = {
	var anim:String;
	var name:String;
	var fps:Int;
	var loop:Bool;
	var indices:Array<Int>;
	var offsets:Array<Float>;
}

typedef DialogueLine = {
	var portrait:Null<String>;
	var expression:Null<String>;
	var text:Null<String>;
	var boxState:Null<String>;
	var speed:Null<Float>;
	var sound:Null<String>;
	var curDiaBg:Null<String>;
	var backgroundBg:Null<String>;
	var backgroundScale:Array<Float>;
	var backgroundGraphicScale:Array<Float>;
}

class DialogueCharacter extends FlxSprite
{
	private static var IDLE_SUFFIX:String = '-IDLE';
	public static var DEFAULT_CHARACTER:String = 'bf';
	public static var DEFAULT_SCALE:Float = 0.7;

	public var jsonFile:DialogueCharacterFile = null;
	public var dialogueAnimations:Map<String, DialogueAnimArray> = new Map();

	public var startingPos:Float = 0; //For center characters, it works as the starting Y, for everything else it works as starting X
	public var isGhost:Bool = false; //For the editor
	public var curCharacter:String = 'bf';
	public var skiptimer = 0;
	public var skipping = 0;
	public function new(x:Float = 0, y:Float = 0, character:String = null)
	{
		super(x, y);

		if(character == null) character = DEFAULT_CHARACTER;
		this.curCharacter = character;

		reloadCharacterJson(character);
		frames = Paths.getSparrowAtlas('dialogue/' + jsonFile.image);
		reloadAnimations();

		antialiasing = ClientPrefs.globalAntialiasing;
		if(jsonFile.no_antialiasing == true) antialiasing = false;
	}

	public function reloadCharacterJson(character:String) {
		var characterPath:String = 'images/dialogue/' + character + '.json';
		var rawJson = null;

		#if MODS_ALLOWED
		var path:String = Paths.modFolders(characterPath);
		if (!FileSystem.exists(path)) {
			path = Paths.getPreloadPath(characterPath);
		}

		if(!FileSystem.exists(path)) {
			path = Paths.getPreloadPath('images/dialogue/' + DEFAULT_CHARACTER + '.json');
		}
		rawJson = File.getContent(path);

		#else
		var path:String = Paths.getPreloadPath(characterPath);
		rawJson = Assets.getText(path);
		#end
		
		jsonFile = cast Json.parse(rawJson);
	}

	public function reloadAnimations() {
		dialogueAnimations.clear();
		if(jsonFile.animations != null && jsonFile.animations.length > 0) {
			for (anim in jsonFile.animations) {
				animation.addByPrefix(anim.anim, anim.loop_name, 24, isGhost);
				animation.addByPrefix(anim.anim + IDLE_SUFFIX, anim.idle_name, 24, true);
				dialogueAnimations.set(anim.anim, anim);
			}
		}
	}

	public function playAnim(animName:String = null, playIdle:Bool = false) {
		var leAnim:String = animName;
		if(animName == null || !dialogueAnimations.exists(animName)) { //Anim is null, get a random animation
			var arrayAnims:Array<String> = [];
			for (anim in dialogueAnimations) {
				arrayAnims.push(anim.anim);
			}
			if(arrayAnims.length > 0) {
				leAnim = arrayAnims[FlxG.random.int(0, arrayAnims.length-1)];
			}
		}

		if(dialogueAnimations.exists(leAnim) &&
		(dialogueAnimations.get(leAnim).loop_name == null ||
		dialogueAnimations.get(leAnim).loop_name.length < 1 ||
		dialogueAnimations.get(leAnim).loop_name == dialogueAnimations.get(leAnim).idle_name)) {
			playIdle = true;
		}
		animation.play(playIdle ? leAnim + IDLE_SUFFIX : leAnim, false);

		if(dialogueAnimations.exists(leAnim)) {
			var anim:DialogueAnimArray = dialogueAnimations.get(leAnim);
			if(playIdle) {
				offset.set(anim.idle_offsets[0], anim.idle_offsets[1]);
				//trace('Setting idle offsets: ' + anim.idle_offsets);
			} else {
				offset.set(anim.loop_offsets[0], anim.loop_offsets[1]);
				//trace('Setting loop offsets: ' + anim.loop_offsets);
			}
		} else {
			offset.set(0, 0);
			trace('Offsets not found! Dialogue character is badly formatted, anim: ' + leAnim + ', ' + (playIdle ? 'idle anim' : 'loop anim'));
		}
	}

	public function animationIsLoop():Bool {
		if(animation.curAnim == null) return false;
		return !animation.curAnim.name.endsWith(IDLE_SUFFIX);
	}
}

class BackgroundSprite extends FlxSprite
{
	public var animOffsets:Map<String, Array<Float>>;
	public var name:String = "";
	public function new(X:Float, Y:Float, name:String)
	{
		animOffsets = new Map<String, Array<Float>>();
		this.name = name;
		super(X, Y);
	}

	public function playAnim(anim:String, force:Bool = false, reversed:Bool = false, startFrame:Int = 0)
	{
		animation.play(anim, force, reversed, startFrame);
		var daOffset = animOffsets.get(anim);
		if (animOffsets.exists(anim))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
	}

	public function addOffset(name:String, x:Float, y:Float)
	{
		animOffsets[name] = [x, y];
	}
}

// TO DO: Clean code? Maybe? idk
class DialogueBoxPsych extends FlxSpriteGroup
{
	var dialogue:TypedAlphabet;
	var dialogueList:DialogueFile = null;

	public var finishThing:Void->Void;
	public var nextDialogueThing:Void->Void = null;
	public var skipDialogueThing:Void->Void = null;
	var bgFade:FlxSprite = null;
	var textToType:String = '';

	var arrayCharacters:Array<DialogueCharacter> = [];

	var currentText:Int = 0;
	var offsetPos:Float = -600;

	var textBoxTypes:Array<String> = ['normal', 'angry'];
	
	var curCharacter:String = "";
	//var charPositionList:Array<String> = ['left', 'center', 'right'];
	var boxs:FlxTypedSpriteGroup<BackgroundSprite> = new FlxTypedSpriteGroup<BackgroundSprite>();

	public function new(dialogueList:DialogueFile, ?song:String = null)
	{
		super();

		if(song != null && song != '') {
			FlxG.sound.playMusic(Paths.music(song), 0);
			FlxG.sound.music.fadeIn(2, 0, 1);
		}
		
		bgFade = new FlxSprite(-500, -500).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
		bgFade.scrollFactor.set();
		bgFade.visible = true;
		bgFade.alpha = 0;
		add(bgFade);

		this.dialogueList = dialogueList;
		spawnCharacters();

		for (i in 0...dialogueList.background.length)
		{
			var box = new BackgroundSprite(
				dialogueList.background[i].xPos != null ? dialogueList.background[i].xPos : 70, 
				dialogueList.background[i].yPos != null ? dialogueList.background[i].yPos : 370, 
				dialogueList.background[i].bgName != null ? dialogueList.background[i].bgName : 'box_$i'
			);
			box.frames = Paths.getSparrowAtlas(dialogueList.background[i].bg != null ? dialogueList.background[i].bg : 'speech_bubble');
			box.scrollFactor.set();
			box.antialiasing = ClientPrefs.globalAntialiasing;
			if (dialogueList.background[i].includeDefaultAnimations)
			{
				box.animation.addByPrefix('normal', 'speech bubble normal', 24);
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('angry', 'AHH speech bubble', 24);
				box.animation.addByPrefix('angryOpen', 'speech bubble loud open', 24, false);
				box.animation.addByPrefix('center-normal', 'speech bubble middle', 24);
				box.animation.addByPrefix('center-normalOpen', 'Speech Bubble Middle Open', 24, false);
				box.animation.addByPrefix('center-angry', 'AHH Speech Bubble middle', 24);
				box.animation.addByPrefix('center-angryOpen', 'speech bubble Middle loud open', 24, false);
			}
			if (dialogueList.background[i].animations != null || dialogueList.background[i].animations.length > 0)
			{
				for (anim in dialogueList.background[i].animations)
				{
					var animAnim:String = '' + anim.anim;
					var animName:String = '' + anim.name;
					var animFps:Int = anim.fps;
					var animLoop:Bool = !anim.loop; // Bruh
					var animIndices:Array<Int> = anim.indices;
					if (animIndices != null && animIndices.length > 0)
						box.animation.addByIndices(animAnim, animName, animIndices, "", animFps, animLoop);
					else
						box.animation.addByPrefix(animAnim, animName, animFps, animLoop);
					if(anim.offsets != null && anim.offsets.length > 1) box.addOffset(anim.anim, anim.offsets[0], anim.offsets[1]);
					else box.addOffset(anim.anim, 0, 0);
				}
			}
			box.animation.play('normal', true);
				
			box.visible = false;

			var scale:Array<Float> = dialogueList.background[i].scale;
			var graphicScale:Array<Float> = dialogueList.background[i].graphicScale;
			if (scale != null && scale.length > 0) 
			{
				box.scale.set(scale[0] != 0 ? scale[0] : 1, scale[1] != 0 ? scale[1] : 1);
			}
			if (graphicScale != null && graphicScale.length > 0)
			{
				box.setGraphicSize(Std.int(graphicScale[0] != 0 ? graphicScale[0] : FlxG.width), Std.int(graphicScale[1] != 0 ? graphicScale[1] : FlxG.height));
			}
			if (scale != null && graphicScale != null && (graphicScale.length == 0 && scale.length == 0))
				box.setGraphicSize(Std.int(box.width * 0.9));
			box.updateHitbox();
			boxs.add(box);
		}
		add(boxs);

		daText = new TypedAlphabet(DEFAULT_TEXT_X, DEFAULT_TEXT_Y, '');
		daText.scaleX = 0.7;
		daText.scaleY = 0.7;
		add(daText);

		startNextDialog();
	}

	var dialogueStarted:Bool = false;
	var dialogueEnded:Bool = false;

	public static var LEFT_CHAR_X:Float = -60;
	public static var RIGHT_CHAR_X:Float = -100;
	public static var DEFAULT_CHAR_Y:Float = 60;

	function spawnCharacters() {
		var charsMap:Map<String, Bool> = new Map();
		for (i in 0...dialogueList.dialogue.length) {
			if(dialogueList.dialogue[i] != null) {
				var charToAdd:String = dialogueList.dialogue[i].portrait;
				if(!charsMap.exists(charToAdd) || !charsMap.get(charToAdd)) {
					charsMap.set(charToAdd, true);
				}
			}
		}

		for (individualChar in charsMap.keys()) {
			var x:Float = LEFT_CHAR_X;
			var y:Float = DEFAULT_CHAR_Y;
			var char:DialogueCharacter = new DialogueCharacter(x + offsetPos, y, individualChar);
			char.setGraphicSize(Std.int(char.width * DialogueCharacter.DEFAULT_SCALE * char.jsonFile.scale));
			char.updateHitbox();
			char.scrollFactor.set();
			char.alpha = 0.00001;
			add(char);

			var saveY:Bool = false;
			switch(char.jsonFile.dialogue_pos) {
				case 'center':
					char.x = FlxG.width / 2;
					char.x -= char.width / 2;
					y = char.y;
					char.y = FlxG.height + 50;
					saveY = true;
				case 'right':
					x = FlxG.width - char.width + RIGHT_CHAR_X;
					char.x = x - offsetPos;
			}
			x += char.jsonFile.position[0];
			y += char.jsonFile.position[1];
			char.x += char.jsonFile.position[0];
			char.y += char.jsonFile.position[1];
			char.startingPos = (saveY ? y : x);
			arrayCharacters.push(char);
		}
	}

	public static var DEFAULT_TEXT_X = 175;
	public static var DEFAULT_TEXT_Y = 432;
	public static var LONG_TEXT_ADD = 24;
	var scrollSpeed = 4000;
	var daText:TypedAlphabet = null;
	var ignoreThisFrame:Bool = true; //First frame is reserved for loading dialogue images

	public var closeSound:String = 'dialogueClose';
	public var closeVolume:Float = 1;
	override function update(elapsed:Float)
	{
		if(ignoreThisFrame) {
			ignoreThisFrame = false;
			super.update(elapsed);
			return;
		}
		boxs.forEachAlive(function(box:BackgroundSprite) {
			if(!dialogueEnded) {
				bgFade.alpha += 0.5 * elapsed;
				if(bgFade.alpha > 0.5) bgFade.alpha = 0.5;

				if(PlayerSettings.player1.controls.ACCEPT) {
					if(!daText.finishedText) {
						daText.finishText();
						if(skipDialogueThing != null) {
							skipDialogueThing();
						}
					} else if(currentText >= dialogueList.dialogue.length) {
						dialogueEnded = true;
						for (i in 0...textBoxTypes.length) {
							var checkArray:Array<String> = ['', 'center-'];
							var animName:String = box.animation.curAnim.name;
							for (j in 0...checkArray.length) {
								if(animName == checkArray[j] + textBoxTypes[i] || animName == checkArray[j] + textBoxTypes[i] + 'Open') {
									box.animation.play(checkArray[j] + textBoxTypes[i] + 'Open', true);
								}
							}
						}

						box.animation.curAnim.curFrame = box.animation.curAnim.frames.length - 1;
						box.animation.curAnim.reverse();
						if(daText != null)
						{
							daText.kill();
							remove(daText);
							daText.destroy();
						}
						updateBoxOffsets(box);
						FlxG.sound.music.fadeOut(1, 0);
					} else {
						startNextDialog();
					}
					FlxG.sound.play(Paths.sound(closeSound), closeVolume);
				} else if(daText.finishedText) {
					var char:DialogueCharacter = arrayCharacters[lastCharacter];
					if(char != null && char.animation.curAnim != null && char.animationIsLoop() && char.animation.finished) {
						char.playAnim(char.animation.curAnim.name, true);
					}
				} else {
					var char:DialogueCharacter = arrayCharacters[lastCharacter];
					if(char != null && char.animation.curAnim != null && char.animation.finished) {
						char.animation.curAnim.restart();
					}
				}

				if(box.animation.curAnim.finished) {
					for (i in 0...textBoxTypes.length) {
						var checkArray:Array<String> = ['', 'center-'];
						var animName:String = box.animation.curAnim.name;
						for (j in 0...checkArray.length) {
							if(animName == checkArray[j] + textBoxTypes[i] || animName == checkArray[j] + textBoxTypes[i] + 'Open') {
								box.animation.play(checkArray[j] + textBoxTypes[i], true);
							}
						}
					}
					updateBoxOffsets(box);
				}

				if(lastCharacter != -1 && arrayCharacters.length > 0) {
					for (i in 0...arrayCharacters.length) {
						var char = arrayCharacters[i];
						if(char != null) {
							if(i != lastCharacter) {
								switch(char.jsonFile.dialogue_pos) {
									case 'left':
										char.x -= scrollSpeed * elapsed;
										if(char.x < char.startingPos + offsetPos) char.x = char.startingPos + offsetPos;
									case 'center':
										char.y += scrollSpeed * elapsed;
										if(char.y > char.startingPos + FlxG.height) char.y = char.startingPos + FlxG.height;
									case 'right':
										char.x += scrollSpeed * elapsed;
										if(char.x > char.startingPos - offsetPos) char.x = char.startingPos - offsetPos;
								}
								char.alpha -= 3 * elapsed;
								if(char.alpha < 0.00001) char.alpha = 0.00001;
							} else {
								switch(char.jsonFile.dialogue_pos) {
									case 'left':
										char.x += scrollSpeed * elapsed;
										if(char.x > char.startingPos) char.x = char.startingPos;
									case 'center':
										char.y -= scrollSpeed * elapsed;
										if(char.y < char.startingPos) char.y = char.startingPos;
									case 'right':
										char.x -= scrollSpeed * elapsed;
										if(char.x < char.startingPos) char.x = char.startingPos;
								}
								char.alpha += 3 * elapsed;
								if(char.alpha > 1) char.alpha = 1;
							}
						}
					}
				}
			} else { //Dialogue ending
				if(box != null && box.animation.curAnim.curFrame <= 0) {
					box.alive = false;
					box.active = false;
					box.visible = false;
					box.kill();
					boxs.remove(box);
					box.destroy();
				}
			}
		});

		if (dialogueEnded)
		{
			for (i in 0...arrayCharacters.length) {
				var leChar:DialogueCharacter = arrayCharacters[i];
				if(leChar != null) {
					switch(arrayCharacters[i].jsonFile.dialogue_pos) {
						case 'left':
							leChar.x -= scrollSpeed * elapsed;
						case 'center':
							leChar.y += scrollSpeed * elapsed;
						case 'right':
							leChar.x += scrollSpeed * elapsed;
					}
					leChar.alpha -= elapsed * 10;
				}
			}
			if(bgFade != null) {
				bgFade.alpha -= 0.5 * elapsed;
				if(bgFade.alpha <= 0) {
					bgFade.kill();
					remove(bgFade);
					bgFade.destroy();
					bgFade = null;
				}
			}
			if(boxs.members[0] == null && bgFade == null) {
				trace('start finish thing');
				for (i in 0...arrayCharacters.length) {
					var leChar:DialogueCharacter = arrayCharacters[0];
					if(leChar != null) {
						arrayCharacters.remove(leChar);
						leChar.kill();
						remove(leChar);
						leChar.destroy();
					}
				}
				finishThing();
				kill();
			}
		}
		super.update(elapsed);
	}

	var lastCharacter:Int = -1;
	var lastBoxType:String = '';
	function startNextDialog():Void
	{
		var curDialogue:DialogueLine = null;
		do {
			curDialogue = dialogueList.dialogue[currentText];
		} while(curDialogue == null);

		if(curDialogue.text == null || curDialogue.text.length < 1) curDialogue.text = ' ';
		if(curDialogue.boxState == null) curDialogue.boxState = 'normal';
		if(curDialogue.speed == null || Math.isNaN(curDialogue.speed)) curDialogue.speed = 0.05;
		if(curDialogue.curDiaBg == null) curDialogue.curDiaBg = "speech_bubble";
		if(curDialogue.backgroundBg == null) curDialogue.backgroundBg = "default";

		for (i in 0...boxs.members.length) boxs.members[i].visible = (boxs.members[i].name == curDialogue.curDiaBg);
		
		var bg:String = curDialogue.backgroundBg;
		var scale:Array<Float> = curDialogue.backgroundScale;
		var graphic:Array<Float> = curDialogue.backgroundGraphicScale;
		if (bg != "default" && bg != "" && bg != null) 
		{
			bgFade.loadGraphic(Paths.image(bg));
			if (scale != null && scale.length > 0) bgFade.scale.set(scale[0] != 0 ? scale[0] : 1, scale[1] != 0 ? scale[1] : 1);
			if (graphic != null && graphic.length > 0)
				bgFade.setGraphicSize(Std.int(graphic[0] != 0 ? graphic[0] : FlxG.width), Std.int(graphic[1] != 0 ? graphic[1] : FlxG.height));
			if (scale != null && graphic != null && (graphic.length == 0 && scale.length == 0)) bgFade.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
			bgFade.alpha = 1;
		}
		else {
			bgFade.makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
			bgFade.alpha = 0.7;
		}

		var animName:String = curDialogue.boxState;
		var boxType:String = textBoxTypes[0];
		for (i in 0...textBoxTypes.length) {
			if(textBoxTypes[i] == animName) {
				boxType = animName;
			}
		}

		var character:Int = 0;
		for (i in 0...arrayCharacters.length) {
			if(arrayCharacters[i].curCharacter == curDialogue.portrait) {
				character = i;
				break;
			}
		}
		var centerPrefix:String = '';
		var lePosition:String = arrayCharacters[character].jsonFile.dialogue_pos;
		if(lePosition == 'center') centerPrefix = 'center-';

		for (i in 0...boxs.members.length)
		{
			var box:BackgroundSprite = boxs.members[i];
			if(character != lastCharacter) {
				box.animation.play(centerPrefix + boxType + 'Open', true);
				updateBoxOffsets(box);
				box.flipX = (lePosition == 'left');
			} else if(boxType != lastBoxType) {
				box.animation.play(centerPrefix + boxType, true);
				updateBoxOffsets(box);
			}
		}
		lastCharacter = character;
		lastBoxType = boxType;

		daText.text = curDialogue.text;
		daText.sound = curDialogue.sound;
		if(daText.sound == null || daText.sound.trim() == '') daText.sound = 'dialogue';
		
		daText.y = DEFAULT_TEXT_Y;
		if(daText.rows > 2) daText.y -= LONG_TEXT_ADD;

		var char:DialogueCharacter = arrayCharacters[character];
		if(char != null) {
			char.playAnim(curDialogue.expression, daText.finishedText);
			if(char.animation.curAnim != null) {
				var rate:Float = 24 - (((curDialogue.speed - 0.05) / 5) * 480);
				if(rate < 12) rate = 12;
				else if(rate > 48) rate = 48;
				char.animation.curAnim.frameRate = rate;
			}
		}
		currentText++;

		if(nextDialogueThing != null) {
			nextDialogueThing();
		}
	}

	public static function parseDialogue(path:String):DialogueFile {
		#if MODS_ALLOWED
		if(FileSystem.exists(path))
		{
			return cast Json.parse(File.getContent(path));
		}
		#end
		return cast Json.parse(Assets.getText(path));
	}

	public static function updateBoxOffsets(box:FlxSprite) { //Had to make it static because of the editors
		box.centerOffsets();
		box.updateHitbox();
		if(box.animation.curAnim.name.startsWith('angry')) {
			box.offset.set(50, 65);
		} else if(box.animation.curAnim.name.startsWith('center-angry')) {
			box.offset.set(50, 30);
		} else {
			box.offset.set(10, 0);
		}
		
		if(!box.flipX) box.offset.y += 10;
	}
}
