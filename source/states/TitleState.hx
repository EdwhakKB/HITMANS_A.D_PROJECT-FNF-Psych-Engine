package states;

import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import options.GraphicsSettingsSubState;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;

import flixel.system.ui.FlxSoundTray;
import lime.app.Application;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;

import textbox.*;
import flixel.system.FlxAssets;

using StringTools;
typedef TitleData =
{

	titlex:Float,
	titley:Float,
	startx:Float,
	starty:Float,
	gfx:Float,
	gfy:Float,
	backgroundSprite:String,
	bpm:Int
}
class TitleState extends MusicBeatState
{
	var tbox:Textbox;
	var tbox2:Textbox;
	var dacursor:DemoTextCursor;
	var cursorTween:FlxTween;
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	public static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;
	
	private var camGame:FlxCamera;
	private var camHUD:FlxCamera;
	private var camOther:FlxCamera;

	var fearThing:FlxSprite;
	var titleTextColors:Array<FlxColor> = [0xFF33FFFF, 0xFF3333CC];
	var titleTextAlphas:Array<Float> = [1, .64];

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	var mustUpdate:Bool = false;

	var titleJSON:TitleData;

	public var logoBl:FlxSprite;

	public static var updateVersion:String = '';

	override public function create():Void
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		// CAM SHIT
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camOther = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camOther, false);

		FlxG.cameras.setDefaultDrawTarget(camOther, true);
		FlxG.camera = camOther;

		FlxG.game.focusLostFramerate = 60;
		ClientPrefs.toggleVolumeKeys(true);
		FlxG.keys.preventDefaultKeys = [TAB];

		FlxG.autoPause = false;

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		swagShader = new ColorSwap();
		super.create();

		// IGNORE THIS!!!
		titleJSON = Json.parse(Paths.getTextFromFile('images/gfDanceTitle.json'));

		if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
				//trace('LOADED FULLSCREEN SETTING!!');
			}
			persistentUpdate = true;
			persistentDraw = true;
			Alphabet.AlphaCharacter.loadAlphabetData();
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		FlxG.mouse.visible = false;
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		} else {
			#if desktop
			if (!DiscordClient.isInitialized)
			{
				DiscordClient.initialize();
				Application.current.onExit.add (function (exitCode) {
					DiscordClient.shutdown();
				});
			}
			#end

			if (initialized)
				startIntro();
			else
			{
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					startIntro();
				});
			}
		}
		#end
	}

	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxText;
	var swagShader:ColorSwap = null;
	var startedIntro:Bool = false;

	function startIntro()
	{
		if (!initialized)
		{
			/*var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;*/

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();

			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('bloodstained'), 0);
			}
		}

		Conductor.bpm = titleJSON.bpm;
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(Paths.image('menuBG'));
		bg.cameras = [camGame];
		add(bg);

		logoBl = new FlxSprite(110, 280).loadGraphic(Paths.image('HitmansLogo'));
		logoBl.scale.x = 1.3;
		logoBl.scale.y = 1.3;
		logoBl.antialiasing = ClientPrefs.data.antialiasing;
		logoBl.alpha = 0;
		logoBl.updateHitbox();

		swagShader = new ColorSwap();
		add(logoBl);

		titleText = new FlxText(0, FlxG.height - 250, FlxG.width, "Press Start", 64);
		titleText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 64, 0xff920000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleText.antialiasing = ClientPrefs.data.antialiasing;
		titleText.updateHitbox();
		// titleText.screenCenter(X);
		add(titleText);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = ClientPrefs.data.antialiasing;

		fearThing = new FlxSprite(0, 0).loadGraphic(Paths.image('Hitmans/FearMe'));
		fearThing.screenCenter();
		fearThing.scale.set(0.53, 0.53);
		fearThing.alpha = 1;
		fearThing.antialiasing = ClientPrefs.data.antialiasing;
		fearThing.cameras = [camOther];
		add(fearThing);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		credTextShit = new Alphabet(0, 0, "", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = ClientPrefs.data.antialiasing;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		startedIntro = true;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = OpenFLAssets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;
	private static var playJingle:Bool = false;
	
	var newTitle:Bool = false;
	var titleTimer:Float = 0;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);
		if (startedIntro)
			logoBl.y = Math.sin((Conductor.songPosition/Conductor.crochet*0.25)*Math.PI) * 6;

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}
		
		if (newTitle) {
			titleTimer += FlxMath.bound(elapsed, 0, 1);
			if (titleTimer > 2) titleTimer -= 2;
		}

		// EASTER EGG

		if (initialized && !transitioning && skippedIntro)
		{
			if (newTitle && !pressedEnter)
			{
				var timer:Float = titleTimer;
				if (timer >= 1)
					timer = (-timer) + 2;
				
				timer = FlxEase.quadInOut(timer);
				
				titleText.color = FlxColor.interpolate(titleTextColors[0], titleTextColors[1], timer);
				titleText.alpha = FlxMath.lerp(titleTextAlphas[0], titleTextAlphas[1], timer);
			}
			
			if(pressedEnter)
			{
				MusicBeatState.switchState(new MainMenuState());
				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

				transitioning = true;
				// FlxG.sound.music.stop();

				closedState = true;
				// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
			}
		}

		if (initialized && pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		if(swagShader != null)
		{
			if(controls.UI_LEFT) swagShader.hue -= elapsed * 0.1;
			if(controls.UI_RIGHT) swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:String, ?offset:Float = 0)
	{
		var money:FlxText = new FlxText(0, 0, FlxG.width, textArray, 64);
		money.alpha = 0;
		money.setFormat(Paths.font("DEADLY KILLERS.ttf"), 64, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		money.screenCenter(XY);
		if(credGroup != null && textGroup != null) {
			credGroup.add(money);
			textGroup.add(money);
			FlxTween.tween(money, {alpha: 1}, 1, {ease: FlxEase.smoothStepOut});
		}
	}

	function addMoreText(text:String, ?offset:Float = 0)
	{
		if(textGroup != null && credGroup != null) {
			var coolText:FlxText = new FlxText(0, 0, FlxG.width, text, 64);
			coolText.alpha = 0;
			coolText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 64, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			coolText.screenCenter(XY);
			credGroup.add(coolText);
			textGroup.add(coolText);
			FlxTween.tween(coolText, {alpha: 1}, 1, {ease: FlxEase.smoothStepOut});
		}
	}

	function deleteCoolText()
	{
		if (textGroup.members.length > 0)
		{
			FlxTween.tween(textGroup.members[0], {alpha: 0}, 1, {
				ease: FlxEase.smoothStepIn,
				onComplete: function(twn:FlxTween)
					{
						credGroup.remove(textGroup.members[0], true);
						textGroup.remove(textGroup.members[0], true);
					}
				});
		}
	}

	var noteColor:Array<FlxColor> = [FlxColor.RED, FlxColor.ORANGE, FlxColor.YELLOW, FlxColor.GREEN, FlxColor.BLUE, FlxColor.PURPLE];
	function noteEffect()
	{
		if(!ClientPrefs.data.lowQuality) {
			var note:FlxSprite = new FlxSprite().loadGraphic(Paths.image('DANOTE'));
			note.antialiasing = ClientPrefs.data.antialiasing;
			note.cameras = [camGame];
			note.scale.set(1, 1);
			note.updateHitbox();
			note.y = -200;
			note.x = FlxG.random.int(0, FlxG.width);
			note.angle = FlxG.random.int(0, 360);
			note.alpha = 0.5;
			note.color = FlxColor.BLACK;
			add(note);

			var currentColor:Int = FlxG.random.int(0, 5);
			var noteTrail = new FlxTrail(note, null, 5, 7, 0.25, 0.05);
			noteTrail.cameras = [camGame];
			noteTrail.alpha = 0.5;
			noteTrail.color = noteColor[currentColor];
			insert(members.indexOf(note), noteTrail);
			FlxTween.tween(noteTrail, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
			FlxTween.tween(note, {x: note.x -125, y: 730, angle: note.angle + 360, alpha: 0}, 2, {ease: FlxEase.quadInOut, 
				onComplete: function(twn:FlxTween)
				{
					remove(note);
					remove(noteTrail);
				}
			});
	
		}
	}
	function noteEffectUp()
		{
			if(!ClientPrefs.data.lowQuality) {
				var note:FlxSprite = new FlxSprite().loadGraphic(Paths.image('DANOTE'));
				note.antialiasing = ClientPrefs.data.antialiasing;
				note.cameras = [camGame];
				note.scale.set(1, 1);
				note.updateHitbox();
				note.y = FlxG.height + 100;
				note.x = FlxG.random.int(0, FlxG.width);
				note.angle = FlxG.random.int(0, 360);
				note.alpha = 0.5;
				note.color = FlxColor.BLACK;
				add(note);
	
				var currentColor:Int = FlxG.random.int(0, 5);
				var noteTrail = new FlxTrail(note, null, 5, 7, 0.25, 0.05);
				noteTrail.cameras = [camGame];
				noteTrail.alpha = 0.5;
				noteTrail.color = noteColor[currentColor];
				insert(members.indexOf(note), noteTrail);
				FlxTween.tween(noteTrail, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
				FlxTween.tween(note, {x: note.x -125, y: 0, angle: note.angle + 360, alpha: 0}, 2, {ease: FlxEase.quadInOut, 
					onComplete: function(twn:FlxTween)
					{
						remove(note);
						remove(noteTrail);
					}
				});
		
			}
		}
	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
	public static var closedState:Bool = false;
	override function stepHit()
	{
		super.stepHit();
		if (curStep %4 == 2){
			noteEffect();
		}else if (curStep %4 == 0){
			noteEffectUp();
		}
	}
	override function beatHit()
	{
		super.beatHit();

		if(!closedState) {
			sickBeats++;
			switch (sickBeats)
			{
				case 1:
					//FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.music('bloodstained'), 0);
					FlxG.sound.music.fadeIn(4, 0, 0.7);
				case 5:
					createCoolText("In a forgotten place");
				case 10:
					deleteCoolText();
				case 15:
					createCoolText("Where the blood flows");
				case 20:
					deleteCoolText();
				case 25:
					createCoolText("And the dark shines");
				case 30:
					deleteCoolText();
				case 35:
					createCoolText("All the memories");
				case 40:
					deleteCoolText();
				case 45:
					createCoolText("The mistakes");
				case 50:
					deleteCoolText();
				case 55:
					createCoolText("The lost hopes");
				case 60:
					deleteCoolText();
				case 65:
					createCoolText("And the broken dreams");
				case 70:
					deleteCoolText();
				case 75:
					createCoolText("Stays where the peace leads");
				case 80:
					deleteCoolText();
				case 85:
					createCoolText("Where the last man stands");
				case 90:
					deleteCoolText();
				case 95:
					createCoolText("Waiting for a chance");
				case 100:
					deleteCoolText();
				case 105:
					createCoolText("To bring everyone back");
				case 110:
					deleteCoolText();
				case 115:
					createCoolText("To finally take his revenge");
				case 120:
					deleteCoolText();
				case 125:
					createCoolText("And make everyone know the...");
				case 127:
					deleteCoolText();
				case 130:
					skipIntro();
			}
		}
	}

	var skippedIntro:Bool = false;
	var increaseVolume:Bool = false;
	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			if (playJingle) //Ignore deez
			{
				remove(ngSpr);
				remove(credGroup);
				playJingle = false;
			}
			else //Default! Edit this one!!
			{
				remove(ngSpr);
				remove(credGroup);
				FlxTween.tween(blackScreen, {alpha: 0}, 1, {
					ease: FlxEase.smoothStepIn,
					onComplete: function(twn:FlxTween)
						{
							remove(blackScreen);
						}
				});
			}
			FlxTween.tween(logoBl, {alpha: 1}, 1, {ease: FlxEase.smoothStepIn});
			skippedIntro = true;
		}
	}
}

class DemoTextCursor extends FlxSprite
{
	public override function new(X:Float, Y:Float)
	{
		super(X, Y);
		makeGraphic(8, 4);

		ownCharacterCallback = function(character:textbox.Text)
		{
			characterCallbackInternal(character);
		};
	}


	public function attachToTextbox(textbox:Textbox)
	{
		textbox.characterDisplayCallbacks.push(ownCharacterCallback);
	}

	public function detachFromTextbox(textbox:Textbox)
	{
		textbox.characterDisplayCallbacks.remove(ownCharacterCallback);
	}

	private function characterCallbackInternal(character:textbox.Text)
	{
		x = character.x + character.width + 2;

		// I noted an issue : the character height is 0 if targetting javascript.
		if (character.text != " ")
		{
			y = character.y + character.height - 4;
		}
		color = character.color;
	}

	private var ownCharacterCallback:textbox.Text->Void = null;
}