package;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import options.GraphicsSettingsSubState;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import flixel.FlxCamera;
import StrumNote;

using StringTools;
class WindowsState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
	public static var testing:Bool = true; //just to test this shit ig

	public static var initialized:Bool = false;

	var bg:FlxSprite;
	var vignette:FlxSprite;

	var gameText:FlxText;
	var anticrash:Bool = true; //TF!?
	var wordText:FlxText;
	var tipText:FlxText;

	private var camGame:FlxCamera;
	private var camHUD:FlxCamera;
	private var camOther:FlxCamera;

	var yesText:FlxText;
	var noText:FlxText;
	var onYes:Bool = false;
	var startCustomization:Bool = false;

	var gameNickname:String = ClientPrefs.userName;
	var playerStep:Int = 0;
	public var capsLOCK:Bool = false;

	private var strumLine:FlxSprite;
	public var strumLineNotes:FlxTypedGroup<StrumNote>;
	public var opponentStrums:FlxTypedGroup<StrumNote>;
	public var playerStrums:FlxTypedGroup<StrumNote>;
	public static var STRUM_X = 42;
	public static var STRUM_X_MIDDLESCROLL = -278;

	var allowedKeys:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var allowedNums:Array<String> = ['ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE', 'ZERO', 'SPACE']; //mhm
    var allowedSpecials:Array<String> = ['PERIOD', 'COMMA', 'LBRACKET', 'RBRACKET', 'NUMPADMINUS', '_', 'NUMPADMULTIPLY', 'EQUAL', 'NUMPADPLUS', 'SLASH']; //hitmans will need this so, lmao

	private var specialGuest:Array<String> = ['AnbyFox', 'Hazard24', 'Luna', 'EdwhakKB', 'Glowsoony', 'Slushi']; //this is to enable some extra functions
	private var passWords:Array<String> = ['FoxOs', 'InhumanOs', 'POFT', '4NN1HILAT3', 'MISCECONMODCHART', 'S2LUZE9ASHI']; //TF WITH THE PASSWORDS LMAO -Ed
	private var neededPassword:String = ''; //so when you try access it ask for dev password and NEED be the dev password
	private var devNameEnabled:Bool = false; //so if you add one of those developer mode will be enabled if password match
	private var currentDEVName:String = '';
	private var developerImage:FlxSprite;
	/*
	Idea:
	Game talks +helps to customize stuff
	Customization starts:

	1) FLASHING LIGHTS
	2) NoteSkin
	3) Downscroll/Upscroll
	4) Middlescroll
	5) Opponent Strums
	6) Shaders and other main effect options
	7) HUD Settings.
	*/
	override public function create():Void
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Paths.pushGlobalMods();
		#end
		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		WeekData.loadTheFirstEnabledMod();

		//trace(path, FileSystem.exists(path));

		/*#if (polymod && !html5)
		if (sys.FileSystem.exists('mods/')) {
			var folders:Array<String> = [];
			for (file in sys.FileSystem.readDirectory('mods/')) {
				var path = haxe.io.Path.join(['mods/', file]);
				if (sys.FileSystem.isDirectory(path)) {
					folders.push(file);
				}
			}
			if(folders.length > 0) {
				polymod.Polymod.init({modRoot: "mods", dirs: folders});
			}
		}
		#end*/

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		PlayerSettings.init();

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

		super.create();

		FlxG.save.bind('funkin', 'ninjamuffin99');

		ClientPrefs.loadPrefs();

		#if CHECK_FOR_UPDATES
		if(ClientPrefs.checkForUpdates && !closedState) {
			trace('checking for update');
			var http = new haxe.Http("https://raw.githubusercontent.com/ShadowMario/FNF-PsychEngine/main/gitVersion.txt");

			http.onData = function (data:String)
			{
				updateVersion = data.split('\n')[0].trim();
				var curVersion:String = MainMenuState.psychEngineVersion.trim();
				trace('version online: ' + updateVersion + ', your version: ' + curVersion);
				if(updateVersion != curVersion) {
					trace('versions arent matching!');
					mustUpdate = true;
				}
			}

			http.onError = function (error) {
				trace('error: $error');
			}

			http.request();
		}
		#end

		Highscore.load();

		if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
				//trace('LOADED FULLSCREEN SETTING!!');
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		#if desktop
		if (!DiscordClient.isInitialized)
		{
			DiscordClient.initialize();
			Application.current.onExit.add (function (exitCode) {
				DiscordClient.shutdown();
			});
		}
		#end

		super.create();
		trace(testing);
		ClientPrefs.loadPrefs();

		//changing states incase if nickname != null
		if(ClientPrefs.isLogged && ClientPrefs.userName != '' && !testing) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new TitleState());
			trace('wellcome back');
		} else {
			trace('wellcome');
			bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
			bg.scrollFactor.set(0);
			bg.screenCenter();
			bg.antialiasing = ClientPrefs.globalAntialiasing;
			bg.alpha = 0;
			bg.cameras = [camGame];
			add(bg);
	
			vignette = new FlxSprite().loadGraphic(Paths.image('hitmans/vignette'));
			vignette.scrollFactor.set(0);
			vignette.screenCenter();
			vignette.antialiasing = ClientPrefs.globalAntialiasing;
			vignette.cameras = [camHUD];
			add(vignette);
	
			// other stuff
			gameText = new FlxText(0, 0, FlxG.width, "", 16);
			gameText.setFormat(Paths.font("pixel.otf"), 16, 0xFF8D8D8D, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
			gameText.scrollFactor.set();
			gameText.screenCenter();
			gameText.borderSize = 2.5;
			gameText.alpha = 1;
			gameText.cameras = [camHUD];
			add(gameText);	
	
			wordText = new FlxText(0, 0, FlxG.width, "", 32);
			wordText.setFormat(Paths.font("pixel.otf"), 32, 0xFFFFFFFF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
			wordText.scrollFactor.set();
			wordText.screenCenter();
			wordText.y += 250;
			wordText.borderSize = 2.5;
			wordText.alpha = 0;
			wordText.cameras = [camHUD];
			add(wordText);	
	
			tipText = new FlxText(0, 0, FlxG.width, "Type your nickname. Minimum lenght = 3 letters.\n[CAPSLOCK] - Capital/Lowercase letters.\n[BACKSPACE] - Remove letter.", 16);
			tipText.setFormat(Paths.font("pixel.otf"), 16, 0xFF666666, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
			tipText.scrollFactor.set();
			tipText.screenCenter();
			tipText.y += 300;
			tipText.borderSize = 2.5;
			tipText.alpha = 0;
			tipText.cameras = [camHUD];
			add(tipText);	
	
			yesText = new FlxText(0, 0, 0, "YES", 32);
			yesText.setFormat(Paths.font("pixel.otf"), 32, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
			yesText.screenCenter();
			yesText.x -= 105;
			yesText.y += 250;
			yesText.borderSize = 2.5;
			yesText.cameras = [camHUD];
			add(yesText);
			noText = new FlxText(0, 0, 0, "NO", 32);
			noText.setFormat(Paths.font("pixel.otf"), 32, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
			noText.screenCenter();
			noText.x += 105;
			noText.y += 250;
			noText.borderSize = 2.5;
			noText.cameras = [camHUD];
			add(noText);
			updateOptions();
			yesText.alpha = 0;
			noText.alpha = 0;
	
			gameText.text = "...";
			tipText.text = "[ENTER] - Continue.";
			FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut, startDelay: 0.5});
			FlxTween.tween(tipText, {alpha: 1}, 0.5, {ease: FlxEase.circOut, startDelay: 0.5});
	
			//in case if it didnt work
			gameNickname = ClientPrefs.userName;
			
			// switch(ClientPrefs.pauseMusic){
			// 	case 'Sweet Home':
			// 		Conductor.changeBPM(90);
			// 	case 'Funkin':
			// 		Conductor.changeBPM(102);
			// 	case 'Recreated':
			// 		Conductor.changeBPM(70);
			// }
			strumLine = new FlxSprite(STRUM_X, 50).makeGraphic(FlxG.width, 10);
			// if(ClientPrefs.downScroll) strumLine.y = FlxG.height - 150;
			strumLine.scrollFactor.set();

			opponentStrums = new FlxTypedGroup<StrumNote>();
			playerStrums = new FlxTypedGroup<StrumNote>();

			strumLineNotes = new FlxTypedGroup<StrumNote>();
			add(strumLineNotes);

			strumLineNotes.cameras = [camHUD];
		}
	}

	public function gameTalks()
		{
			if(startCustomization){
				switch(playerStep)
				{
					case 0:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(noText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(yesText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Alright! Let's get started.";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circInOut});

								generateStaticArrows(0); //so it instant creates notes and stuff!
								generateStaticArrows(1);

								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										FlxTween.tween(gameText, {y: gameText.y - 250}, 2, {ease: FlxEase.circOut});
										new FlxTimer().start(2, function(tmr:FlxTimer) 
											{
												FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
												new FlxTimer().start(0.5, function(tmr:FlxTimer) 
													{
														FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
														FlxTween.tween(bg, {alpha: 0.5}, 0.5, {ease: FlxEase.circOut});
														FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
														FlxG.sound.music.fadeIn(4, 0, 0.7);
														gameText.text = "DownScroll - puts your notes down, instead of up.\nDo you want me to enable this?";
														if(onYes){
															FlxTween.tween(noText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
															FlxTween.tween(yesText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
														} else {
															FlxTween.tween(noText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
															FlxTween.tween(yesText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
														}
													});
											});
									});
							});
					case 1:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(noText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(yesText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "MiddleScroll - gets your notes centered.\nDo you want me to enable this?";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								if(onYes){
									FlxTween.tween(noText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								} else {
									FlxTween.tween(noText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
								}
							});
					case 2:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(noText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(yesText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Also, you can hide opponent notes, if they bother you.\nDo you want me to hide them?";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								if(onYes){
									FlxTween.tween(noText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								} else {
									FlxTween.tween(noText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
								}
							});
					case 3:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(noText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(yesText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Alright. That's all for now.\nHave fun playing this game! (remember this is experimental and not done yet)";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 4:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(1, function(tmr:FlxTimer) 
							{
								MusicBeatState.switchState(new TitleState());
							});
				}
			} else {
				switch(playerStep)
				{
					case 1:
						FlxTween.tween(tipText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Oh, hello there!";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 2:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "(So you are the one, who I was informed about...)";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 3:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Welcome to A-25H!";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 4:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "I'm T.A.O.S. - Tool Assisted Operation System";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 5:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Nice to meet you.";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 6:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								if (!testing){
									gameText.text = "What is your name?";
									tipText.text = "Type your nickname. Minimum length = 3 letters.\n[CAPSLOCK] - Capital/Lowercase letters.\n[BACKSPACE] - Remove letter.";
									FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(tipText, {alpha: 1}, 0.5, {ease: FlxEase.circOut, startDelay: 0.5});
									FlxTween.tween(wordText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								}else{
									gameText.text = "You are testing. What is your name?";
									tipText.text = "Type your nickname. Minimum length = 3 letters.\n[CAPSLOCK] - Capital/Lowercase letters.\n[BACKSPACE] - Remove letter.";
									FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(tipText, {alpha: 1}, 0.5, {ease: FlxEase.circOut, startDelay: 0.5});
									FlxTween.tween(wordText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								}
							});
					case 7:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(tipText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(wordText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = gameNickname +"...";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 8:
						var random = FlxG.random.int(1,2);
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								switch(random)
								{
									case 1:
										gameText.text = "Your name has been set as, " + gameNickname +"!";
									case 2:
										gameText.text = "What a beautiful name, " + gameNickname + "!";
								}
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 9:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "I'm the system, which you're in.";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 10:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "I'm just taking operational orders and stabilizing the operating system.";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 11:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "So, " + gameNickname + ".";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 12:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Do you want me to help you to setup?";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								if(onYes){
									FlxTween.tween(noText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								} else {
									FlxTween.tween(noText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
								}
							});
					case 13:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(noText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(yesText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Okay. Remember, you can always change things in the settings!";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 14:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Also remember: you can communicate with me by using the prompt/command prompt,\nin case if you need something.";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 15:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Okay, the last thing.";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 16:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Are you sensetive to Flashing Lights?";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								if(onYes){
									FlxTween.tween(noText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
								} else {
									FlxTween.tween(noText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
									FlxTween.tween(yesText, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut});
								}
							});
					case 17:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(noText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						FlxTween.tween(yesText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Alright.";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 18:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								gameText.text = "Have fun playing this game!";
								FlxTween.tween(gameText, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
							});
					case 19:
						FlxTween.tween(gameText, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
						new FlxTimer().start(0.5, function(tmr:FlxTimer) 
							{
								MusicBeatState.switchState(new TitleState());
							});
				}
			}
		}

	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if(startCustomization){
			if(gameText.alpha == 1 && playerStep > 2){
				if(FlxG.keys.justPressed.ENTER){
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					playerStep += 1;
					gameTalks();
				}
			}

			else if(gameText.alpha == 1 && playerStep == 0){
				if(noText.alpha > 0.5 && yesText.alpha > 0.5){
					if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
						FlxG.sound.play(Paths.sound('scrollMenu'), 1);
						onYes = !onYes;
						updateOptions();
					}
					
					if(FlxG.keys.justPressed.ENTER) {
						if(onYes) {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.downScroll = true;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						} else {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.downScroll = false;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						}
					}
				}
			}

			else if(gameText.alpha == 1 && playerStep == 1){
				if(noText.alpha > 0.5 && yesText.alpha > 0.5){
					if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
						FlxG.sound.play(Paths.sound('scrollMenu'), 1);
						onYes = !onYes;
						updateOptions();
					}
					
					if(FlxG.keys.justPressed.ENTER) {
						if(onYes) {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.middleScroll = true;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						} else {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.middleScroll = false;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						}
					}
				}
			}

			else if(gameText.alpha == 1 && playerStep == 2){
				if(noText.alpha > 0.5 && yesText.alpha > 0.5){
					if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
						FlxG.sound.play(Paths.sound('scrollMenu'), 1);
						onYes = !onYes;
						updateOptions();
					}
					
					if(FlxG.keys.justPressed.ENTER) {
						if(onYes) {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.opponentStrums = false;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						} else {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.opponentStrums = true;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						}
					}
				}
			}
		} else {
			if(anticrash || gameText.alpha == 1 && playerStep != 6 && playerStep != 12 && playerStep != 16){
				if(FlxG.keys.justPressed.ENTER){
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					playerStep += 1;
					gameTalks();
					anticrash = false; //idk why it works like this
				}
			} 

			else if(gameText.alpha == 1 && playerStep == 6){
				if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
					{
						var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
						var keyName:String = Std.string(keyPressed);
						if(allowedKeys.contains(keyName) || allowedNums.contains(keyName) || allowedSpecials.contains(keyName)) {
							if(wordText.text.length < 12)
								{
									//Optimized this thing LMAO -Ed
                                    switch (keyName)
                                    {
                                        case 'ONE':
                                            keyName = '1';
                                        case 'TWO':
                                            keyName = '2';
                                        case 'THREE':
                                            keyName = '3';
                                        case 'FOUR':
                                            keyName = '4';
                                        case 'FIVE':
                                            keyName = '5';
                                        case 'SIX':
                                            keyName = '6';
                                        case 'SEVEN':
                                            keyName = '7';
                                        case 'EIGHT':
                                            keyName = '8';
                                        case 'NINE':
                                            keyName = '9';
                                        case 'ZERO':
                                            keyName = '0';
                                        case 'SPACE':
                                            keyName = ' ';

                                        //This ones are to make sure it works lmao
                                        case 'PERIOD':
                                            keyName = '.';
                                        case 'COMMA':
                                            keyName = ',';
                                        case 'LBRACKET':
                                            keyName = '(';
                                        case 'RBRACKET':
                                            keyName = ')';
                                        case 'NUMPADMINUS':
                                            keyName = '-';
                                        case '_':
                                            keyName = '_';
                                        case 'NUMPADMULTIPLY':
                                            keyName = '*';
                                        case 'EQUAL':
                                            keyName = '=';
                                        case 'NUMPADPLUS':
                                            keyName = '+';
                                        case 'SLASH':
                                            keyName = '/';
                                    }
									if(capsLOCK) wordText.text += keyName;
									else if(!capsLOCK) wordText.text += keyName.toLowerCase();
									FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								}
						}
					}
	
				if (FlxG.keys.justPressed.BACKSPACE)
					{
						if(wordText.text != '')
							{
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
								wordText.text = wordText.text.substring(0, wordText.text.length - 1);
								holdTime = 0;
							}
					}
	
				if (FlxG.keys.pressed.BACKSPACE)
					{
						if(wordText.text != '')
							{
								var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
								holdTime += elapsed;
								var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
				
								if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
								{
									FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
									wordText.text = wordText.text.substring(0, wordText.text.length - 1);
								}
							}
					}
	
				if (FlxG.keys.justPressed.CAPSLOCK){
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					capsLOCK = !capsLOCK;
				}
	
				if (FlxG.keys.justPressed.ENTER)
					{
						if(wordText.text.length > 2 && wordText.text != ''){
							gameNickname = wordText.text;
							if (!testing){
								ClientPrefs.userName = wordText.text;
								ClientPrefs.isLogged = true;
								ClientPrefs.saveSettings();
							}
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							playerStep += 1;
							gameTalks();
						} else {
							wordText.text = '';
							FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
						}
	
					}
			} 
			
			else if(gameText.alpha == 1 && playerStep == 12) {
				if(noText.alpha > 0.5 && yesText.alpha > 0.5){
					if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
						FlxG.sound.play(Paths.sound('scrollMenu'), 1);
						onYes = !onYes;
						updateOptions();
					}
					
					if(FlxG.keys.justPressed.ENTER) {
						if(onYes) {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							startCustomization = true;
							playerStep = 0;
							gameTalks();
						} else {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							playerStep += 1;
							gameTalks();
						}
					}
				}
			} 
			
			else if(gameText.alpha == 1 && playerStep == 16) {
				if(noText.alpha > 0.5 && yesText.alpha > 0.5){
					if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
						FlxG.sound.play(Paths.sound('scrollMenu'), 1);
						onYes = !onYes;
						updateOptions();
					}
	
					if(FlxG.keys.justPressed.ENTER) {
						if(onYes) {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.flashing = false;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						} else {
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							ClientPrefs.flashing = true;
							ClientPrefs.saveSettings();
							playerStep += 1;
							gameTalks();
						}
					}
				}
			}
		}
		super.update(elapsed);
	}
	

	function updateOptions() {
		var scales:Array<Float> = [1, 1.1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
	}

	// cube particles
	var bigCube:FlxSprite;
	var mediumCube:FlxSprite;
	var smallCube:FlxSprite;
	function cubeEffect()
	{
		if(!ClientPrefs.lowQuality) {
			bigCube = new FlxSprite().makeGraphic(64, 64, FlxColor.BLACK);
			bigCube.antialiasing = ClientPrefs.globalAntialiasing;
			bigCube.y = FlxG.height;
			bigCube.x = FlxG.random.int(0, FlxG.width);
			bigCube.cameras = [camGame];
			add(bigCube);
	
			mediumCube = new FlxSprite().makeGraphic(48, 48, FlxColor.BLACK);
			mediumCube.antialiasing = ClientPrefs.globalAntialiasing;
			mediumCube.y = FlxG.height;
			mediumCube.x = FlxG.random.int(0, FlxG.width);
			mediumCube.cameras = [camGame];
			add(mediumCube);
	
			smallCube = new FlxSprite().makeGraphic(32, 32, FlxColor.BLACK);
			smallCube.antialiasing = ClientPrefs.globalAntialiasing;
			smallCube.y = FlxG.height;
			smallCube.x = FlxG.random.int(0, FlxG.width);
			smallCube.cameras = [camGame];
			add(smallCube);
	
			FlxTween.tween(bigCube, {angle: 360}, 5, {ease: FlxEase.quadInOut});
			FlxTween.tween(bigCube, {y: 0}, 2.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(bigCube, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
	
			FlxTween.tween(mediumCube, {angle: 360}, 10, {ease: FlxEase.quadInOut});
			FlxTween.tween(mediumCube, {y: 0}, 3, {ease: FlxEase.quadInOut});
			FlxTween.tween(mediumCube, {alpha: 0}, 1.5, {ease: FlxEase.quadInOut});
	
			FlxTween.tween(smallCube, {angle: 360}, 7.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(smallCube, {y: 0}, 5, {ease: FlxEase.quadInOut});
			FlxTween.tween(smallCube, {alpha: 0}, 1.25, {ease: FlxEase.quadInOut});
		}
	}

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var targetAlpha:Float = 1;
			// if (player < 1)
			// {
			// 	if(!ClientPrefs.opponentStrums) targetAlpha = 0;
			// 	else if(ClientPrefs.middleScroll) targetAlpha = 0.35;
			// }

			var babyArrow:StrumNote = new StrumNote(STRUM_X, strumLine.y, i, player, 'Skins/Notes/'+ClientPrefs.noteSkin+'/NOTE_assets');
			// babyArrow.downScroll = ClientPrefs.downScroll;
			// if (!isStoryMode && !skipArrowStartTween)
			// {
				//babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {/*y: babyArrow.y + 10,*/ alpha: targetAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			// else
			// {
			// 	babyArrow.alpha = targetAlpha;
			// }

			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}
			else
			{
				// if(ClientPrefs.middleScroll)
				// {
				// 	babyArrow.x += 310;
				// 	if(i > 1) { //Up and Right
				// 		babyArrow.x += FlxG.width / 2 + 25;
				// 	}
				// }
				opponentStrums.add(babyArrow);
			}

			strumLineNotes.add(babyArrow);
			babyArrow.postAddedToGroup();
		}
	}

	var lastStepHit:Int = -1;
	override function stepHit()
	{
		super.stepHit();

		if(curStep == lastStepHit) {
			return;
		}

		if(curStep % 2 == 0){
			if(!ClientPrefs.lowQuality) {
				cubeEffect();
			}
		}

		lastStepHit = curStep;
	}

	var zoomTween:FlxTween;
	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
	public static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if(startCustomization){
			if(curBeat % 4 == 0){
				camGame.zoom = 1.075;

				if(zoomTween != null) zoomTween.cancel();
				zoomTween = FlxTween.tween(camGame, {zoom: 1}, 1, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween)
					{
						zoomTween = null;
					}
				});
			}
		}

		if(!closedState) {
			sickBeats++;
		}
	}
}