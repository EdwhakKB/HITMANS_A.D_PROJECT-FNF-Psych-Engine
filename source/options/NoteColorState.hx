package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxCamera;
import flixel.FlxObject;

using StringTools;

class NoteColorState extends MusicBeatState
{
	public static var needToUpdate:Bool = false;
	public static var curNoteSelected:Int = 0;
	public static var noteTypeSelected:Int = 0;
	public var onColorMenu:Bool = true;
	public var onPresets:Bool = false;

	private var camGame:FlxCamera;
	private var camNoteColor:FlxCamera;
	private var camHUD:FlxCamera;
	private var camNoteFollow:FlxObject;
	private var camNoteFollowPos:FlxObject;

	var curNoteValue:Float = 0;
	var holdTime:Float = 0;
	var nextAccept:Int = 5;

	private var grpNumbers:FlxTypedGroup<Alphabet>;
	private var grpNotes:FlxTypedGroup<Note>;
	private var grpHolds:FlxTypedGroup<Note>;
	private var grpHoldEnds:FlxTypedGroup<Note>;
	private var shaderNoteArray:Array<ColorSwap> = [];

	private static var presetSelected:Int = 0;
	public var hsvPreset:Array<String> = [
		'Fallen', 'Funkin', 'Nostalgia', 'Soft', 'Pastel', 'Sunrise', 'Midnight',
		'QT', 'Inhuman', 'Hitman', 'Groovin', 'Mami', 
		'Anby', 'Hazard', 'Luis', 'Natumi', 'Crystarlya', 'Luna', 'Custom'];
	public var curHSVPreset = [[-85, -20, 0], [-125, -35, 0], [180, -50, 0], [-125, -75, 0], [-95, 0, 0]];
	public var noteSplash:FlxSprite;
	public var hurtSplash:FlxSprite;
	var skins:Array<String> = ['HITMANS', 'INHUMAN', 'FNF', 'ITHIT', 'MANIAHIT', 'FUTURE', 'CIRCLE', 'STEPMANIA', 'NOTITG']; //There must be a better way but for now with this im okay -Ed
	private static var curNum:Int = 0;

	var noteBar:FlxSprite;
	var noteHSVText:FlxText;

	public var titleText:FlxText;
	public var descText:FlxText;
	public var optionsText:FlxText;
	private var noteDescBox:FlxSprite;
	private var noteDescText:FlxText;
	public var noteTypeStuff:Array<String> = ['Left Note', 'Down Note', 'Up Note', 'Right Note', 'Hurt Note'];

	public var noteSplashSkin:String = null;
	public var notePack:String = null;
	public var noteSplashAlpha:Float = 0.6;
	public var hurtNoteAlpha:Float = 0.6;
	public var sustainNoteAlpha:Float = 0.6;

	override public function create()
	{
		#if desktop
		DiscordClient.changePresence('Options','Note Colors', null);
		#end

		presetSelected = 0;

		camGame = new FlxCamera();
		camNoteColor = new FlxCamera();
		camNoteColor.bgColor.alpha = 0;
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camNoteColor, false);
		FlxG.cameras.add(camHUD, true);

		camNoteFollow = new FlxObject(0, 0, 1, 1);
		camNoteFollowPos = new FlxObject(0, 0, 1, 1);
		add(camNoteFollow);
		add(camNoteFollowPos);

		super.create();
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('MenuShit/wallPaper'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		bg.cameras = [camGame];
		add(bg);

		var optbg:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width/1.5), FlxG.height, FlxColor.BLACK);
		optbg.alpha = 0;
		optbg.screenCenter();
		optbg.cameras = [camGame];
		add(optbg);

		var noteSuffix:String = ClientPrefs.notesSkin[0].toLowerCase();
		var hurtNoteSuffix:String = ClientPrefs.notesSkin[1].toLowerCase();
		var holdSuffix:String = ClientPrefs.notesSkin[2].toLowerCase(); //tho this one its unnused
		if(ClientPrefs.notesSkin[1].toLowerCase() == 'mimic') hurtNoteSuffix = noteSuffix;
		
		// usual color setting

		noteBar = new FlxSprite(0).makeGraphic(FlxG.width, 140, FlxColor.BLACK);
		noteBar.alpha = 0.6;
		noteBar.cameras = [camNoteColor];
		noteBar.screenCenter();
		noteBar.x -= FlxG.width/2;
		noteBar.y -= 400;
		add(noteBar);

		grpHolds = new FlxTypedGroup<Note>();
		add(grpHolds);
		grpHoldEnds = new FlxTypedGroup<Note>();
		add(grpHoldEnds);
		grpNotes = new FlxTypedGroup<Note>();
		add(grpNotes);
		grpNumbers = new FlxTypedGroup<Alphabet>();
		add(grpNumbers);

		updateNotes();

		// visuals

		camNoteColor.follow(camNoteFollowPos, null, 1);
		camNoteColor.visible = true;

		var titleBG:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 90, FlxColor.BLACK);
		titleText = new FlxText(25, 16, FlxG.width, '< Note Options >', 48);
		titleText.setFormat(Paths.font("vcr.ttf"), 56, FlxColor.WHITE, CENTER);
		titleText.scrollFactor.set();
		titleText.screenCenter(X);
		titleText.cameras = [camHUD];
		titleBG.cameras = [camHUD];
		add(titleBG);
		add(titleText);

		var descBG:FlxSprite = new FlxSprite(0, FlxG.height - 45).makeGraphic(FlxG.width, 51, FlxColor.BLACK);
		descText = new FlxText(descBG.x, descBG.y + 12, FlxG.width, "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors", 18);
		descText.setFormat(Paths.font("vcr.ttf"), 18, FlxColor.WHITE, CENTER);
		descText.scrollFactor.set();
		descText.cameras = [camHUD];
		descBG.cameras = [camHUD];
		add(descBG);
		add(descText);
		
		optionsText = new FlxText(0, 0, FlxG.width, "Options", 48);
		optionsText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, CENTER);
		optionsText.screenCenter();
		optionsText.x += 450;
		optionsText.y -= 300;
		optionsText.scrollFactor.set();
		optionsText.cameras = [camHUD];
		add(optionsText);

		var swapButton:FlxSprite = new FlxSprite(0, 95).loadGraphic(Paths.image('menuStuff/menuSwap'));
		swapButton.frames = Paths.getSparrowAtlas('menuStuff/menuSwap');
		swapButton.animation.addByPrefix('1', 'selected-1', 1, true);	
		swapButton.animation.addByPrefix('2', 'selected-2', 1, true);	
		swapButton.antialiasing = ClientPrefs.globalAntialiasing;
		swapButton.scale.set(0.85, 0.85);
		swapButton.updateHitbox();
		swapButton.screenCenter();
		swapButton.animation.play("1");
		swapButton.x += 545;
		swapButton.y += 235;
		swapButton.cameras = [camHUD];
		add(swapButton);

		noteDescBox = new FlxSprite().makeGraphic(FlxG.width, 1, FlxColor.BLACK);
		noteDescBox.alpha = 0;
		noteDescBox.cameras = [camHUD];
		add(noteDescBox);

		noteDescText = new FlxText(50, 600, 1180, "", 32);
		noteDescText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		noteDescText.scrollFactor.set();
		noteDescText.borderSize = 2.4;
		noteDescText.alpha = 0;
		noteDescText.cameras = [camHUD];
		add(noteDescText);

		setSelections();
	}

	var changingNote:Bool = false;
	var changingQuant:Bool = false;
	override function update(elapsed:Float) {
		Conductor.songPosition = FlxG.sound.music.time;

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		//camNoteFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxMath.lerp(camNoteFollowPos.y, camNoteFollow.y, lerpVal));

		if(FlxG.keys.justPressed.SPACE && noteDescBox.alpha == 0) {
			FlxTween.tween(noteDescBox, {alpha: 0.6}, 0.25, {ease: FlxEase.circOut});
			FlxTween.tween(noteDescText, {alpha: 1}, 0.25, {ease: FlxEase.circOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
		} else if(FlxG.keys.justPressed.SPACE && noteDescBox.alpha == 0.6) {
			FlxTween.tween(noteDescBox, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
			FlxTween.tween(noteDescText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(controls.UI_UP_P) {
			changeSelection(-1);
			// reloadSplash();
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(controls.UI_DOWN_P) {
			changeSelection(1);
			// reloadSplash();
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(FlxG.mouse.wheel != 0) {
			changeSelection(-1 * FlxG.mouse.wheel);
			// reloadSplash();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		}

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			onChangeSkin(controls.UI_LEFT_P ? -1 : 1);
			updateNotes();
			changeSelection();
			ClientPrefs.saveSettings();

			titleText.text = '< "'+ '' +'" Preset >';
			titleText.screenCenter(X);

			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
			
		if(controls.BACK || ((changingNote || changingQuant) && controls.ACCEPT)) {
			if(onColorMenu) {
				descText.text = "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors";
				if(!changingNote) MusicBeatState.switchState(new MainMenuState());
				else changeSelection();
				changingNote = false;
			} else {
				descText.text = "SHIFT - Note Colors | SPACE - Show/Hide Description | RESET - Reset Colors";
				if(!changingQuant) MusicBeatState.switchState(new MainMenuState());
				else changeSelection();
				changingQuant = false;
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}

		if(FlxG.keys.justPressed.CONTROL) {
			persistentUpdate = false;
		}

		if(FlxG.keys.justPressed.SHIFT && !onPresets) {
			onColorMenu = !onColorMenu;
			if(onColorMenu) {
				titleText.text = '< Note Colors >';
				noteDescText.text = noteTypeStuff[curNoteSelected];
				descText.text = "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors";
			} else {
				titleText.text = '< Note Quantization >';
				noteDescText.text = noteTypeStuff[curNoteSelected];
				descText.text = "SHIFT - Note Colors | SPACE - Show/Hide Description | RESET - Reset Colors";
			}
			titleText.screenCenter(X);

			noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
			noteDescBox.y = noteDescText.y - 10;
			noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
			noteDescBox.updateHitbox();

			camNoteColor.visible = onColorMenu;

			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(FlxG.keys.justPressed.TAB)
			if(onColorMenu && !changingNote) {
				onPresets = !onPresets;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				if(onPresets) {
					titleText.text = '< "'+ '' +'" Preset >';
					descText.text = "TAB - Note Colors | SPACE - Show/Hide Description";
				} else {
					titleText.text = '< Note Colors >';
					descText.text = "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors";
				}
				titleText.screenCenter(X);
			}

		if(needToUpdate) updateNotes();
		if(nextAccept > 0) nextAccept -= 1;
		if(onColorMenu) {
			if(noteSplash != null) {
				switch(noteSplash.animation.curAnim.name) {
					case '1' | '2' : if(noteSplash.animation.curAnim.finished) noteSplash.alpha = 0;
				}
			}
			if(hurtSplash != null) {
				switch(hurtSplash.animation.curAnim.name) {
					case '1' | '2' : if(hurtSplash.animation.curAnim.finished) hurtSplash.alpha = 0;
				}
			}
		} else {
			
		}

		super.update(elapsed);
	}

	function setSelections() {
		//updateValue();

		for(i in 0...grpNumbers.length) {
			var item = grpNumbers.members[i];
			item.alpha = 0.6;
			if((curNoteSelected * 3) + noteTypeSelected == i) {
				item.alpha = 1;
				// camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
			}
		}

		for(i in 0...grpNotes.length) {
			var item = grpNotes.members[i];
			item.alpha = 0.6;
			item.scale.set(0.5, 0.5);
			if(curNoteSelected == i) {
				item.alpha = 1;
				item.scale.set(0.75, 0.75);
				noteBar.y = item.y-50;
				// camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
			}
		}

		for(i in 0...grpHolds.length) {
			var item = grpHolds.members[i];
			item.alpha = sustainNoteAlpha * (3/5);
			item.setGraphicSize(Std.int(item.width*2), Std.int(FlxG.height/1.005));
			if(curNoteSelected == i) {
				item.alpha = sustainNoteAlpha;
				item.setGraphicSize(Std.int(item.width*2.95), Std.int(FlxG.height/1.005));
			}
		}

		for(i in 0...grpHoldEnds.length) {
			var item = grpHoldEnds.members[i];
			item.alpha = sustainNoteAlpha * (3/5);
			item.scale.set(0.5, 0.5);
			if(curNoteSelected == i) {
				item.alpha = sustainNoteAlpha;
				item.scale.set(0.75, 0.75);
				item.x = grpHolds.members[i].x + grpHolds.members[i].height + 380;
			}
		}

		if(onColorMenu) noteDescText.text = noteTypeStuff[curNoteSelected];
		else noteDescText.text = noteTypeStuff[curNoteSelected];

		noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
		noteDescBox.y = noteDescText.y - 10;
		noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
		noteDescBox.updateHitbox();
	}

	function changeSelection(change:Int = 0) {
		if(onColorMenu) {
			curNoteSelected += change;
			//updateValue();
	
			for(i in 0...grpNumbers.length) {
				var item = grpNumbers.members[i];
				item.alpha = 0.6;
				if((curNoteSelected * 3) + noteTypeSelected == i) {
					item.alpha = 1;
					// camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
				}
			}

			for(i in 0...grpNotes.length) {
				var item = grpNotes.members[i];
				item.alpha = 0.6;
				item.scale.set(0.5, 0.5);
				if(curNoteSelected == i) {
					if(i == 4) item.alpha = hurtNoteAlpha;
					else item.alpha = 1;
					item.scale.set(0.75, 0.75);
					noteBar.y = item.y-50;
					// camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
				}
			}

			for(i in 0...grpHolds.length) {
				var item = grpHolds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				item.setGraphicSize(Std.int(item.width*2), Std.int(FlxG.height/1.005));
				if(curNoteSelected == i) {
					item.alpha = sustainNoteAlpha;
					item.setGraphicSize(Std.int(item.width*2.95), Std.int(FlxG.height/1.005));
				}
			}

			for(i in 0...grpHoldEnds.length) {
				var item = grpHoldEnds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				item.scale.set(0.5, 0.5);
				if(curNoteSelected == i) {
					item.alpha = sustainNoteAlpha;
					item.scale.set(0.75, 0.75);
					item.x = grpHolds.members[i].x + grpHolds.members[i].height + 380;
				}
			}
		} else {
		
		}

		if(onColorMenu) noteDescText.text = noteTypeStuff[curNoteSelected];
		else noteDescText.text = noteTypeStuff[curNoteSelected];

		noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
		noteDescBox.y = noteDescText.y - 10;
		noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
		noteDescBox.updateHitbox();
	}

	function changeType(change:Int = 0) {
		if(onColorMenu) {
			noteTypeSelected += change;
			if(noteTypeSelected < 0) noteTypeSelected = 2;
			if(noteTypeSelected > 2) noteTypeSelected = 0;

			//updateValue();
	
			for(i in 0...grpNumbers.length) {
				var item = grpNumbers.members[i];
				item.alpha = 0.6;
				if((curNoteSelected * 3) + noteTypeSelected == i) item.alpha = 1;
			}
		} else {

		}
	}

	function defaultValue(selected:Int, type:Int) {
		if(onColorMenu) {
			
		} 
	}

	function updateValue(change:Float = 0) {
		if(onColorMenu) {
			curNoteValue += change;
			var roundedValue:Int = Math.round(curNoteValue);
			var max:Float = 180;
			switch(noteTypeSelected) {
				case 1 | 2: max = 100;
			}
	
			if(roundedValue < -max) curNoteValue = -max;
			if(roundedValue > max) curNoteValue = max;

			roundedValue = Math.round(curNoteValue);
	
			switch(noteTypeSelected) {
				// case 0: shaderNoteArray[curNoteSelected].hue = roundedValue / 360;
				// case 1: shaderNoteArray[curNoteSelected].saturation = roundedValue / 100;
				// case 2: shaderNoteArray[curNoteSelected].brightness = roundedValue / 100;
			}
	
			var item = grpNumbers.members[(curNoteSelected * 3) + noteTypeSelected];
			item.text = Std.string(roundedValue);
	
			var add = (40 * (item.letters.length - 1)) / 2;
			for(letter in item.letters) {
				letter.offset.x += add;
				if(roundedValue < 0) letter.offset.x += 10;
			}
		} else {

		}
	}

	function resetValue(selected:Int, type:Int) {
		if(onColorMenu) {
			curNoteValue = 0;
			switch(type) {
				case 0: shaderNoteArray[selected].hue = 0;
				case 1: shaderNoteArray[selected].saturation = 0;
				case 2: shaderNoteArray[selected].brightness = 0;
			}
	
			var item = grpNumbers.members[(selected * 3) + type];
			item.text = '0';
	
			var add = (40 * (item.letters.length - 1)) / 2;
			for(letter in item.letters) letter.offset.x += add;
		} else {

		}
	}

	function updateNotes() {
		grpNotes.clear();
		grpHolds.clear();
		grpHoldEnds.clear();

		for(i in 0...4) {
			var yPos:Float = (105 * i) - 155;

			var note:Note = new Note(0, i, false, true); //new FlxSprite(230, yPos - 40);
			note.x = -550;
			note.y = yPos - 40;
			var hold:Note = new Note(0, i, true, true);
			hold.x = note.x;//+215;
			hold.y = note.y;//+50;
			var holdend:Note = new Note(0, i, true, true);
			holdend.x = hold.x;
			holdend.y = hold.y;

			var animations:Array<String> = ['purple', 'blue', 'green', 'red'];
			if(i < 4) {
				note.antialiasing = ClientPrefs.globalAntialiasing;
				note.cameras = [camNoteColor];

				hold.antialiasing = ClientPrefs.globalAntialiasing;
				hold.cameras = [camNoteColor];
				hold.angle = 90;
				hold.setGraphicSize(Std.int(hold.width*2), Std.int(FlxG.height/1.005));
				hold.x += 340 + (note.width/2);
				hold.y = note.y + (note.height/2)-(hold.width/2);

				holdend.antialiasing = ClientPrefs.globalAntialiasing;
				holdend.cameras = [camNoteColor];
				holdend.angle = 90;
				holdend.x = hold.x + hold.height+380;
				holdend.animation.play(animations[i]+'holdend', true);
				holdend.y = hold.y;

				hold.alpha = 1;
				holdend.alpha = 1;

				grpHolds.add(hold);
				grpHoldEnds.add(holdend);
				grpNotes.add(note);
			}
		}
		var yPos2:Float = (105 * 4) - 155;

		var note2:Note = new Note(0, 0, false, true); //new FlxSprite(230, yPos - 40);
		note2.noteType = 'Hurt Note';
		note2.x = -550;
		note2.y = yPos2 - 40;
		var hold2:Note = new Note(0, 0, true, true);
		hold2.noteType = 'Hurt Note';
		hold2.x = note2.x;//+215;
		hold2.y = note2.y;//+50;
		var holdend2:Note = new Note(0, 0, true, true);
		holdend2.noteType = 'Hurt Note';
		holdend2.x = hold2.x;
		holdend2.y = hold2.y;

		note2.antialiasing = ClientPrefs.globalAntialiasing;
		note2.cameras = [camNoteColor];

		hold2.antialiasing = ClientPrefs.globalAntialiasing;
		hold2.cameras = [camNoteColor];
		hold2.angle = 90;
		hold2.setGraphicSize(Std.int(hold2.width*2), Std.int(FlxG.height/1.005));
		hold2.x += 340 + (note2.width/2);
		hold2.y = note2.y + (note2.height/2)-(hold2.width/2);

		holdend2.antialiasing = ClientPrefs.globalAntialiasing;
		holdend2.cameras = [camNoteColor];
		holdend2.angle = 90;
		holdend2.x = hold2.x + hold2.height+380;
		holdend2.animation.play('purpleholdend', true);
		holdend2.y = hold2.y;

		hold2.alpha = 1;
		holdend2.alpha = 1;

		grpHolds.add(hold2);
		grpHoldEnds.add(holdend2);
		grpNotes.add(note2);
		
		needToUpdate = false;
	}

	function spawnSplash(forceAnim:Bool = false) {
		var item:FlxSprite;
		if(onColorMenu) {
			item = grpNotes.members[curNoteSelected];
			if(curNoteSelected != 4) {
				noteSplash.setPosition(item.x - Note.swagWidth * 0.8, item.y - Note.swagWidth * 0.85);
				noteSplash.frames = Paths.getSparrowAtlas('splashes/splashes-'+noteSplashSkin.toLowerCase());
				noteSplash.animation.addByPrefix("1", "note splash purple 1", 24, false);
				noteSplash.animation.addByPrefix("2", "note splash purple 2", 24, false);
		
				var animNum:Int = FlxG.random.int(1, 2);
				noteSplash.animation.play(Std.string(animNum), forceAnim);
				noteSplash.alpha = noteSplashAlpha;
			} else {
				hurtSplash.setPosition(item.x - Note.swagWidth * 0.8, item.y - Note.swagWidth * 0.85);
				hurtSplash.frames = Paths.getSparrowAtlas('splashes/hurt/splashes-hurt');
				hurtSplash.animation.addByPrefix("1", "note splash purple 1", 24, false);
				hurtSplash.animation.addByPrefix("2", "note splash purple 2", 24, false);
		
				var animNum:Int = FlxG.random.int(1, 2);
				hurtSplash.animation.play(Std.string(animNum), forceAnim);
				hurtSplash.alpha = noteSplashAlpha;
			}
		} else {

		}
	}

	function reloadSplash() {
			if(onColorMenu) {

			} else {

			}
			// spawnSplash(true);
	}

	function onChangeSkin(?val:Int = 0){
		curNum += val; //So it does a "change" lmao, i still need get some variables such as grab the current skin and load a number -Ed

		if (curNum < 0)
			curNum = skins.length - 1;
		if (curNum >= skins.length)
			curNum = 0;

		ClientPrefs.notesSkin[0] = skins[curNum];
		// skinIndicator.text = skins[curNum];
	}

	var lastStepHit:Int = -1;
	override function stepHit()
	{
		super.stepHit();

		if(curStep == lastStepHit) return;
		// if(curStep % 4 == 2) spawnSplash(false);
		
		lastStepHit = curStep;
	}

	var lastBeatHit:Int = -1;
	var noteThing:Int = 0;
	override public function beatHit()
	{
		super.beatHit();

		if(lastBeatHit == curBeat) return;
		if(curBeat % 2 == 0) {
			var item = grpNotes.members[0];
			item.noteData = noteThing;
			noteThing ++;
			if (noteThing > 3) {
				noteThing = 0; //reset
			}
			// if(ClientPrefs.notesSkin[1] == 'Note') {
			// 	switch(item.angle) {
			// 		case 0: item.angle = -90;
			// 		case -90: item.angle = 90;
			// 		case 90: item.angle = -180;
			// 		case -180: item.angle = 0;
			// 	}
			// }
		}

		lastBeatHit = curBeat;
	}
}