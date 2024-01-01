package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import achievements.Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import flixel.util.FlxTimer;
import flash.system.System;
import openfl.Lib;

using StringTools;

class CommandPromptSubstate extends MusicBeatSubstate
{
	private var camGame:FlxCamera;

	var camFollow:FlxObject;
	var camFollowPos:FlxObject;

	// prompt shit
	var capsLOCK:Bool = false;
	var prompt:FlxSprite;
	var allowedKeys:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var allowedNums:Array<String> = ['ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE', 'ZERO', 'SPACE']; //mhm
    var allowedSpecials:Array<String> = ['PERIOD', 'COMMA', 'LBRACKET', 'RBRACKET', 'NUMPADMINUS', '_', 'NUMPADMULTIPLY', 'EQUAL', 'NUMPADPLUS', 'SLASH']; //hitmans will need this so, lmao

	private var specialGuest:Array<String> = ['AnbyFox', 'Hazard24', 'Luna', 'EdwhakKB', 'Glowsoony', 'Slushi']; //this is to enable some extra functions
	private var passWords:Array<String> = ['FoxOs', 'InhumanOs', 'POFT', '4NN1HILAT3', 'MISCECONMODCHART', 'S2LUZE9ASHI']; //TF WITH THE PASSWORDS LMAO -Ed
	private var neededPassword:String = ''; //so when you try access it ask for dev password and NEED be the dev password
	private var devNameEnabled:Bool = false; //so if you add one of those developer mode will be enabled if password match
	private var currentDEVName:String = '';
	private var developerImage:FlxSprite;
	private var tryingLogOut:Bool = false; //so they must make sure they will logout before it just log them out (just a dynamic visual LOL)

	var currentName:String = '';
	var helpText:FlxText;
	var debugText:FlxText;
	var wordText:FlxText;
	var wordCode:Int = 0;
	var holdTime:Float = 0;
	var infoText:FlxText;

	var changingUserName:Bool = false;

	var promptText:FlxText;


	var micrashPercent:Float = 0.0; 
    var fuckYouCommand:Bool = false;
    var valueSpeed:Float = 20.0;
    var micrashPercentText:FlxText;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("COMMAND PROMPT", null);
		#end
        super.create();
    }
    public function new()
    {
        super();

		camGame = new FlxCamera();

		FlxG.cameras.reset(camGame);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		persistentUpdate = persistentDraw = true;

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		// FlxG.camera.follow(camFollowPos, null, 1);

		prompt = new FlxSprite().loadGraphic(Paths.image('MenuShit/CMD'));
		prompt.scrollFactor.set(0);
		prompt.screenCenter();
		prompt.antialiasing = ClientPrefs.globalAntialiasing;
		add(prompt);
		prompt.alpha = 1;

		developerImage = new FlxSprite(0,160).loadGraphic(Paths.image('Edwhak/Hitmans/developerStuff/Edwhak'));
		developerImage.scrollFactor.set(0);
		developerImage.scale.x = 0.5;
		developerImage.scale.y = 0.5;
		developerImage.updateHitbox();
		developerImage.screenCenter(X);
		developerImage.antialiasing = ClientPrefs.globalAntialiasing;
		developerImage.visible = false;
		developerImage.x += 420;
		developerImage.alpha = 0.5;
		add(developerImage);

		wordText = new FlxText(0, 0, FlxG.width, "", 32);
		wordText.setFormat(Paths.font("pixel.otf"), 32, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		wordText.scrollFactor.set();
		wordText.screenCenter();
		wordText.x += 155;
		wordText.y += 255;
		wordText.borderSize = 2.5;
		add(wordText);	

		promptText = new FlxText(0, 0, FlxG.width, "Hitmans Corporation [TAOS]\nWarning: Modify anything can be very unestable - continue by your own risk", 16);
		promptText.setFormat(Paths.font("pixel.otf"), 16, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		promptText.scrollFactor.set();
		promptText.screenCenter();
		promptText.x += 155;
		promptText.y -= 165;
		promptText.borderSize = 2.5;
		add(promptText);

		infoText = new FlxText(0, 0, FlxG.width, "Wellcome - " + ClientPrefs.userName, 16);
		infoText.setFormat(Paths.font("pixel.otf"), 16, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.scrollFactor.set();
		infoText.screenCenter(X);
		infoText.x += 155;
		infoText.y = promptText.y+70;
		infoText.borderSize = 2.5;
		add(infoText);	

		helpText = new FlxText(0, 0, FlxG.width, 
		    "'DEBUG'      - Watch last debug\n
			'SET'       - Change a variable inside the systems\n
			'RESTART'   - Restart the whole system (unestable)\n
			'RESETDATA' - Reset your Data\n
			'LOGIN'     - Login into your corporation profile\n
			'TEST'      - Load THE TUTORIAL Song\n
			'OPTIONS'   - Open the options\n
			'EXIT'      - Exit the system", 12);
		helpText.setFormat(Paths.font("pixel.otf"), 12, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		helpText.scrollFactor.set();
		helpText.screenCenter(X);
		helpText.x += 155;
		helpText.y = infoText.y+50;
		helpText.borderSize = 2.5;
		helpText.alpha = 0;
		add(helpText);

		debugText = new FlxText(0, 0, FlxG.width, 
		    "-Improved songs such as HerNameIs and Hallucination\n
        -Added more songs\n
        -Main menu and freeplay rework\n
        -Notes Options are now in a different exclusive state\n
        -Better GameOver state\n
        -Performance improvements", 12);
		debugText.setFormat(Paths.font("pixel.otf"), 12, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		debugText.scrollFactor.set();
		debugText.screenCenter(X);
		debugText.x += 155;
		debugText.y = infoText.y+50;
		debugText.borderSize = 2.5;
		debugText.alpha = 0;
		add(debugText);

		if (ClientPrefs.edwhakMode){
			infoText.text = "Hola Eddy! :3, como estas? que vamos a hacer hoy?";
			promptText.text = "Hitmans Corporation [Virus Glitcher V5.5]\nEspero tengas un gran y maravilloso dia Eddy!";
			developerImage.visible = true;
		}
		currentName = ClientPrefs.userName; //to have a backUp of this in case player want play a nonDev mode edition (dev mode will be everywhere LOL)
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		wordText.alpha = prompt.alpha;
		infoText.alpha = prompt.alpha;
		promptText.alpha = prompt.alpha;

		if(fuckYouCommand)
			{
				lime.app.Application.current.window.fullscreen = true;
				micrashPercent += valueSpeed * elapsed;

				micrashPercentText.text = Math.round(micrashPercent) + "%";

				if(micrashPercent >= 100){
					Sys.exit(1);
				}
			}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (FlxG.keys.justPressed.CAPSLOCK){
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
			capsLOCK = !capsLOCK; //public var capsLock:Bool = false;
		}

		var resetting:Bool = false;
		if(prompt.alpha == 1)
			{

				if (FlxG.keys.justPressed.ESCAPE)
					{
						close(); //closes this substate to make mainMenu works again
					}

				#if desktop
				// Updating Discord Rich Presence
				DiscordClient.changePresence("COMMAND PROMPT", null);
				#end

				if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
					{
						var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
						var keyName:String = Std.string(keyPressed);
						if(allowedKeys.contains(keyName) || allowedNums.contains(keyName) || allowedSpecials.contains(keyName)) {
							if(wordText.text.length < 24)
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

					//Thanks anby!

				if (FlxG.keys.justPressed.ESCAPE)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
						FlxTween.tween(prompt, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
						wordText.text = '';
						infoText.text = '';
						helpText.alpha = 0;
					}

				else if (FlxG.keys.justPressed.ENTER)
				{
					if(!changingUserName){
						if(wordText.text.toLowerCase() == 'help')
							{
								if(helpText.alpha == 0)
									{
										helpText.alpha = 1;
										infoText.text = 'This is the list of common commands.\nType \'HELP\' to hide the list.';
										wordText.text = '';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}
								else if(helpText.alpha == 1)
									{
										infoText.text = 'Hid the list of commands.\nType \'HELP\' to show the list.';
										helpText.alpha = 0;
										wordText.text = '';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}
							}
							else{
								helpText.alpha = 0;
							}
						if(wordText.text.toLowerCase() == 'debug')
							{
								infoText.text = 'PLEASE WAIT...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = 'HITMANS A.D PROJECT V (0.4.0)';
										debugText.alpha = 1;
									});
							}
							else{
								debugText.alpha = 0;
							}

						switch(wordText.text.toLowerCase()){
							case 'options':
								infoText.text = 'EXECUTING...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer)
									{
										infoText.text = " ";
										LoadingState.loadAndSwitchState(new options.OptionsState());
									});
							case 'freeplay':
								infoText.text = 'EXECUTING...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = " ";
										MusicBeatState.switchState(new FreeplayState());
									});
							case 'storymode':
								infoText.text = 'NOT IN DEMO';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								// new FlxTimer().start(1, function(tmr:FlxTimer) 
								// 	{
								// 		infoText.text = " ";
								// 		MusicBeatState.switchState(new StoryMenuState());
								// 	});
							case 'credits':
								infoText.text = 'EXECUTING...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = " ";
										MusicBeatState.switchState(new CreditsState());
									});
							case 'mods':
								infoText.text = 'EXECUTING...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										#if MODS_ALLOWED
										infoText.text = " ";
										MusicBeatState.switchState(new ModsMenuState());
										#else
										infoText.text = "SYSTEM DON'T SUPPORT ANY MODIFICATION";
										#end
									});
							case 'awards':
								infoText.text = 'EXECUTING...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = " ";
										MusicBeatState.switchState(new achievements.AchievementsMenuState());
									});
							case 'login':
								if (!changingUserName){
									if (ClientPrefs.userName == 'Guess'){
										changingUserName = true;
										infoText.text = "Please introduce your username";
										wordText.text = '';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}else{
										infoText.text = 'You are already logged in as '+ ClientPrefs.userName +' try "Logout" to change userName';
										wordText.text = '';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}
								}
							case 'logout':
								if (!changingUserName){
									if (ClientPrefs.userName != 'Guess' && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
										infoText.text = "You was successfully logged out";
										wordText.text = '';
										ClientPrefs.userName = 'Guess';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}else if (ClientPrefs.userName != 'Guess' && ClientPrefs.edwhakMode || ClientPrefs.developerMode){
										infoText.text = "Are you sure you want to logout? "+ ClientPrefs.userName + " You must login again";
										tryingLogOut = true;
										wordText.text = '';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}else if (ClientPrefs.userName == 'Guess'){
										infoText.text = "You can't logout on a Guess account";
										wordText.text = '';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}
								}
							case 'yes':
								if (tryingLogOut){
									infoText.text = "You was successfully logged out";
									wordText.text = '';
									tryingLogOut = false;
									ClientPrefs.edwhakMode = false;
									ClientPrefs.developerMode = false;
									ClientPrefs.userName = 'Guess';
									FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								}
							case 'no':
								if (tryingLogOut){
									infoText.text = "Ok "+ ClientPrefs.userName +" enjoy your stay";
									wordText.text = '';
									tryingLogOut = false;
									FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								}
							case 'reset data':
								infoText.text = 'Reseting...';
								wordText.text = '';
								resetting = true;
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										// TitleState.initialized = false;
										// TitleState.closedState = false;
										FlxG.sound.music.fadeOut(0.3);
										if(FreeplayState.vocals != null)
										{
											FreeplayState.vocals.fadeOut(0.3);
											FreeplayState.vocals = null;
										}
										FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
										new FlxTimer().start(1, function(tmr:FlxTimer) 
											{
												infoText.text = " ";
												MusicBeatState.switchState(new WindowsState());
											});
									});
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							// case 'reset data --debug':
							// 	infoText.text = 'Reseting(safeMode)...';
							// 	wordText.text = '';
							// 	ClientPrefs.userName = '';
							// 	ClientPrefs.isLogged = false;
							// 	new FlxTimer().start(1, function(tmr:FlxTimer) 
							// 		{
							// 			FlxG.sound.music.fadeOut(0.3);
							// 			if(FreeplayState.vocals != null)
							// 			{
							// 				FreeplayState.vocals.fadeOut(0.3);
							// 				FreeplayState.vocals = null;
							// 			}
							// 			FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
							// 		});
							// 	new FlxTimer().start(1.5, function(tmr:FlxTimer) 
							// 		{
							// 			ClientPrefs.saveSettings();
							// 			infoText.text = " ";
							// 			// TitleState.initialized = false;
							// 			// TitleState.closedState = false;
							// 			WindowsState.initialized = false;
							// 			WindowsState.closedState = false;
							// 			WindowsState.testing = true;
							// 			MusicBeatState.switchState(new WindowsState());
							// 		});
							// 	FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							case 'restart':
								infoText.text = 'Restarting...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										TitleState.initialized = false;
										TitleState.closedState = false;
										FlxG.sound.music.fadeOut(0.3);
										if(FreeplayState.vocals != null)
										{
											FreeplayState.vocals.fadeOut(0.3);
											FreeplayState.vocals = null;
										}
										FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
									});
							case 'exit':
								infoText.text = 'Exitting...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							    new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										//MusicBeatState.switchState(new TitleState());
										TitleState.initialized = false;
										TitleState.closedState = false;
										FlxG.sound.music.fadeOut(0.3);
										if(FreeplayState.vocals != null)
										{
											FreeplayState.vocals.fadeOut(0.3);
											FreeplayState.vocals = null;
										}
										FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function(){System.exit(0);}, false);
									});
							case 'hello':
								infoText.text = 'Oh, hello there!\nI hope you like this mod!\nTrying to find all commands, aren\'t you?\nHa-ha, anyway, have fun!';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							case 'fuck you':

							fuckYouCommand = true;

							var errors:Array<String> = 
							[
								"SYSTEM_THREAD_EXCEPTION_NOT_HANDLED",
								"CRITICAL_OBJECT_TERMINATION",
								"UNMOUNTABLE_BOOT_VOLUME",
								"KERNEL_MODE_EXCEPTION_NOT_HANDLED_M",
								"WINLOGON_FATAL_ERROR",
								"VIDEO_TDR_FAILURE"
							];
		
							lime.app.Application.current.window.fullscreen = true;
							lime.app.Application.current.window.resizable = false;
		
							if(FlxG.sound.music != null){
								FlxG.sound.music.stop();
							}
		
							FlxG.mouse.visible = false;
							Main.fpsVar.visible = false;
		
							var miCrash = new FlxSprite();
							miCrash.makeGraphic(FlxG.width, FlxG.height, 0xff0874ab);
							add(miCrash);
		
							if(lime.system.System.platformLabel != null && lime.system.System.platformLabel != "")
								{
									if(lime.system.System.platformLabel.contains("Windows 10"))
										{
											miCrash.color = 0xff0078d7;
										}
									else if(lime.system.System.platformLabel.contains("Windows 11"))
										{
											miCrash.color = 0xff000000;
										}
									
									if(lime.system.System.platformLabel.contains("Insider"))
									{
										miCrash.color = 0xff246f24;
									}
								}
		
							var caritatriste:FlxText = new FlxText(0, 0, 0, ":(");
							caritatriste.setFormat(Paths.font("Consolas-Bold.ttf"), 150, FlxColor.WHITE, LEFT, FlxColor.BLACK);
							caritatriste.scrollFactor.set();
							caritatriste.screenCenter();
							caritatriste.x -= 360;
							caritatriste.y -= 160;
							caritatriste.antialiasing = true;
							add(caritatriste);
							
							var text:FlxText = new FlxText(caritatriste.x, caritatriste.y + 180, 0, "");
							text.setFormat(Paths.font("Consolas-Bold.ttf"), 20, FlxColor.WHITE, LEFT,FlxColor.BLACK);
							text.scrollFactor.set();
							text.antialiasing = true;
							text.text = "Your device ran into a problem and needs to restart. We're just \ncollecting some error info, and then we'll restart for you.";
							add(text);
		
							var completeText:FlxText = new FlxText(text.x + 40, text.y + 75, 0, "complete");
							completeText.setFormat(Paths.font("Consolas-Bold.ttf"), 20, FlxColor.WHITE, LEFT,FlxColor.BLACK);
							completeText.scrollFactor.set();
							completeText.antialiasing = true;
							add(completeText);
		
							micrashPercentText = new FlxText(text.x, completeText.y, 0, "");
							micrashPercentText.setFormat(Paths.font("Consolas-Bold.ttf"), 20, FlxColor.WHITE, LEFT,FlxColor.BLACK);
							micrashPercentText.scrollFactor.set();
							micrashPercentText.antialiasing = true;
							add(micrashPercentText);
		
							var moreInfo:FlxText = new FlxText(text.x + 130, text.y + 140, 0, "");
							moreInfo.setFormat(Paths.font("Consolas-Bold.ttf"), 12, FlxColor.WHITE, LEFT, FlxColor.BLACK);
							moreInfo.scrollFactor.set();
							moreInfo.antialiasing = true;
							moreInfo.text = "For more information about this issue and possible fixes, visit \nhttps://www.windows.com/stopcode \n\n\nIf you call a support person, give them this info: \nStop Code: ";
							add(moreInfo);
							moreInfo.text += errors[Std.random(errors.length)];
		
							var miQR:FlxSprite = new FlxSprite(-230, 0);
							miQR.loadGraphic(Paths.getPath('images/MenuShit/WhenTeRickrolean.png', IMAGE));
							miQR.scrollFactor.set(0, 0);
							miQR.setGraphicSize(Std.int(miQR.width * 0.1));
							miQR.antialiasing = true;
							add(miQR);
							FlxG.sound.play(Paths.sound('Edwhak/bluescreenofdeath'), 1, true);
								//I asked a hacker to do this lmao
							case 'balls':
								infoText.text = 'Balls everywhere!';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							case 'love':
								infoText.text = "Loading Edwhak's secret folder...";
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										persistentUpdate = false;
										PlayState.SONG = Song.loadFromJson('mylove', 'mylove');
								        PlayState.isStoryMode = false;
								        PlayState.storyDifficulty = 1;

										if(FreeplayState.vocals != null)
											{
												FreeplayState.vocals.fadeOut(0.3);
												FreeplayState.vocals = null;
											}

									        LoadingState.loadAndSwitchState(new PlayState());
								            
					
								        FlxG.sound.music.volume = 0;
									}
									);
							case 'mercyless':
								infoText.text = 'Loading "C18H27NO3" project...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										persistentUpdate = false;
										PlayState.SONG = Song.loadFromJson('c18h27no3-demo', 'c18h27no3-demo');
								        PlayState.isStoryMode = false;
								        PlayState.storyDifficulty = 1;

										if(FreeplayState.vocals != null)
											{
												FreeplayState.vocals.fadeOut(0.3);
												FreeplayState.vocals = null;
											}

									        LoadingState.loadAndSwitchState(new PlayState());
								            
					
								        FlxG.sound.music.volume = 0;
									}
									);
							case 'experiment1213':
								infoText.text = 'REDACTED';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							case 'redacted info':
								infoText.text = 'I forgot about them...';
								wordText.text = '';
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = "Sorry if i can't provide info about them";
									}
								);
								new FlxTimer().start(2, function(tmr:FlxTimer)
									{
										infoText.text = "It is redacted...";
									}
								);
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							case 'fallen os':
								infoText.text = "Interesting people, I would say. Wish I could meet Fillie more";
								wordText.text = '';
								new FlxTimer().start(2, function(tmr:FlxTimer) 
									{
										infoText.text = "Still wondering, how did we knew each other?";
									}
								);
								new FlxTimer().start(4, function(tmr:FlxTimer)
									{
										infoText.text = "It a true mistery";
									}
								);
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							case 'test':
								infoText.text = 'Loading Testing Song...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										persistentUpdate = false;
										PlayState.SONG = Song.loadFromJson('test', 'test');
								        PlayState.isStoryMode = false;
								        PlayState.storyDifficulty = 1;

										if(FreeplayState.vocals != null)
											{
												FreeplayState.vocals.fadeOut(0.3);
												FreeplayState.vocals = null;
											}

									        LoadingState.loadAndSwitchState(new PlayState());

					
								        FlxG.sound.music.volume = 0;
									}
									);
							case 'beatmod':
								infoText.text = '';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								if (FlxG.sound.music.playing)
									{
										if(FreeplayState.vocals != null)
											{
												FreeplayState.vocals.fadeOut(0.3);
												FreeplayState.vocals = null;
											}
										FlxG.sound.music.pause();
									}
									
									var edwhakBlack:BGSprite = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
									edwhakBlack.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
									edwhakBlack.scrollFactor.set(1);
						
									var edwhakBG:BGSprite = new BGSprite('Edwhak/Hitmans/unused/cheat-bg');
									edwhakBG.setGraphicSize(FlxG.width, FlxG.height);
									//edwhakBG.x += (FlxG.width/2); //Mmmmmm scuffed positioning, my favourite!
									//edwhakBG.y += (FlxG.height/2) - 20;
									edwhakBG.updateHitbox();
									edwhakBG.scrollFactor.set(1);
									edwhakBG.screenCenter();
									edwhakBG.x=0;
						
									var cheater:BGSprite = new BGSprite('Edwhak/Hitmans/unused/cheat', -600, -480, 0.5, 0.5);
									cheater.setGraphicSize(Std.int(cheater.width * 1.5));
									cheater.updateHitbox();
									cheater.scrollFactor.set(1);
									cheater.screenCenter();	
									cheater.x+=50;
						
									add(edwhakBlack);
									add(edwhakBG);
									add(cheater);
									FlxG.camera.shake(0.05,5);
									FlxG.sound.play(Paths.sound('Edwhak/cheatercheatercheater'), 1, true);
									#if desktop
									// Updating Discord Rich Presence
									DiscordClient.changePresence("CHEATER CHEATER CHEATER CHEATER CHEATER CHEATER ", null);
									#end
						
									//Stolen from the bob mod LMAO
									new FlxTimer().start(0.01, function(tmr:FlxTimer)
										{
											Lib.application.window.move(Lib.application.window.x + FlxG.random.int( -10, 10),Lib.application.window.y + FlxG.random.int( -8, 8));
										}, 0);
						
									new FlxTimer().start(1.5, function(tmr:FlxTimer) 
									{
										//trace("Quit");
										System.exit(0);
									});
							default:
								infoText.text = 'Invalid command.\nTry to type again.';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}
						}			
						else
						{
							if(wordText.text == '')
							{
								infoText.text = 'Invalid Username.\nTry to type again.';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}else if (specialGuest.contains(wordText.text)){
								infoText.text = 'Please put the password '+ wordText.text;
								currentDEVName = wordText.text; //so game does a switch searching for this name and then the password needed
								devNameEnabled = true;
								wordText.text = '';	
							}else{
								if (!devNameEnabled){
									changingUserName = false;
									infoText.text = 'Your username has been set as ' + wordText.text;
									ClientPrefs.userName = wordText.text;
									ClientPrefs.edwhakMode = false;
									ClientPrefs.developerMode = false;
									ClientPrefs.saveSettings();
									new FlxTimer().start(0.01, function(tmr:FlxTimer) 
									{
										wordText.text = '';	
									});
									FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								}else{
									if (wordText.text == 'FoxOs' && currentDEVName == 'AnbyFox'){
										infoText.text = 'Wellcome Sir ' + currentDEVName + ' enjoy your stay';
										ClientPrefs.userName = currentDEVName;
										ClientPrefs.developerMode = true; //so its set to true once you do this lmao
										ClientPrefs.saveSettings();
									}else if (wordText.text == 'InhumanOs' && currentDEVName == 'Hazard24'){
										infoText.text = 'Wellcome Ms ' + currentDEVName + ' enjoy your stay';
										ClientPrefs.userName = currentDEVName;
										ClientPrefs.developerMode = true; //so its set to true once you do this lmao
										ClientPrefs.saveSettings();
									}else if (wordText.text == 'POFT' && currentDEVName == 'Luna'){
										infoText.text = 'Wellcome Ms ' + currentDEVName + ' enjoy your stay';
										ClientPrefs.userName = currentDEVName;
										ClientPrefs.developerMode = true; //so its set to true once you do this lmao
										ClientPrefs.saveSettings();
									}else if (wordText.text == 'MISCECONMODCHART' && currentDEVName == 'Glowsoony'){
										infoText.text = 'Wellcome Mr ' + currentDEVName + ' enjoy your stay';
										ClientPrefs.userName = currentDEVName;
										ClientPrefs.developerMode = true; //so its set to true once you do this lmao
										ClientPrefs.saveSettings();
									}else if (wordText.text == 'S2LUZE9ASHI' && currentDEVName == 'Slushi'){
										infoText.text = 'Bienvenido al sistema ' + currentDEVName + ' disfruta tu estadia';
										ClientPrefs.userName = currentDEVName;
										ClientPrefs.developerMode = true; //so its set to true once you do this lmao
										ClientPrefs.saveSettings();
									}else if (!passWords.contains(wordText.text)){
										infoText.text = 'INVALID PASSWORD';
										new FlxTimer().start(1, function(tmr:FlxTimer) 
											{
												FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
												FlxTween.tween(prompt, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
												wordText.text = '';
												infoText.text = '';
												helpText.alpha = 0;
												close();
											});
									}else if (wordText.text == '4NN1HILAT3' && currentDEVName == 'EdwhakKB'){
										infoText.text = 'Bienvenido de nuevo Eddy! que hacemos hoy :3?';
										ClientPrefs.userName = currentDEVName;
										ClientPrefs.developerMode = false;
										ClientPrefs.edwhakMode = true; //so its set to true once you do this lmao
										ClientPrefs.saveSettings();
									}else{
										ClientPrefs.edwhakMode = false;
										ClientPrefs.developerMode = false;
									}
								}
							}
						}
				}
			}

			if(resetting)
				{
					ClientPrefs.notesSkin[0] = 'HITMANS';
					ClientPrefs.notesSkin[1] = 'MIMIC';
					ClientPrefs.hudStyle = 'HITMANS';
					ClientPrefs.downScroll = false;
					ClientPrefs.middleScroll = true;
					ClientPrefs.opponentStrums = false;
					ClientPrefs.casualMode = false;
					//ClientPrefs.showFPS = true; -- does not work for some reason
					ClientPrefs.flashing = true;
					ClientPrefs.globalAntialiasing = true;
					ClientPrefs.lowQuality = false;
					ClientPrefs.shaders = true;
					ClientPrefs.framerate = 60;
					ClientPrefs.cursing = true;
					ClientPrefs.violence = true;
					ClientPrefs.camZooms = true;
					ClientPrefs.hideHud = false;
					ClientPrefs.noteOffset = 0;
					ClientPrefs.arrowHSV = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
					ClientPrefs.arrowRGB = [
						[0xFFC24B99, 0xFFFFFFFF, 0xFF3C1F56],
						[0xFF00FFFF, 0xFFFFFFFF, 0xFF1542B7],
						[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
						[0xFFF9393F, 0xFFFFFFFF, 0xFF651038]
					];
					ClientPrefs.hurtRGB = [
						[0xFF101010, 0xFFFF0000, 0xFF990022],
						[0xFF101010, 0xFFFF0000, 0xFF990022],
						[0xFF101010, 0xFFFF0000, 0xFF990022],
						[0xFF101010, 0xFFFF0000, 0xFF990022]
					];
					ClientPrefs.userName = '';
					ClientPrefs.isLogged = false;
					ClientPrefs.edwhakMode = false;
					ClientPrefs.developerMode = false;
					ClientPrefs.quantization = false;
					ClientPrefs.ghostTapping = true;
					ClientPrefs.timeBarType = 'Time Left';
					ClientPrefs.scoreZoom = true;
					ClientPrefs.noReset = false;
					ClientPrefs.healthBarAlpha = 1;
					ClientPrefs.controllerMode = false;
					ClientPrefs.hitsoundVolume = 0;
					ClientPrefs.pauseMusic = 'Tea Time';
					ClientPrefs.checkForUpdates = true;
					ClientPrefs.comboStacking = false;
					ClientPrefs.gameplaySettings = [
						'scrollspeed' => 1.0,
						'scrolltype' => 'multiplicative', 
						'songspeed' => 1.0,
						'healthgain' => 1.0,
						'healthloss' => 1.0,
						'instakill' => false,
						'practice' => false,
                        'modchart' => true,
						'botplay' => false,
						'opponentplay' => false
					];
					ClientPrefs.comboOffset = [100, 75, 205, 140];
					ClientPrefs.ratingOffset = 0;
					ClientPrefs.marvelousWindow = 22.5;
					ClientPrefs.sickWindow = 45;
					ClientPrefs.goodWindow = 90;
					ClientPrefs.badWindow = 135;
					ClientPrefs.safeFrames = 10;
					ClientPrefs.keyBinds = [
						//Key Bind, Name for ControlsSubState
						'note_left'		=> [A, LEFT],
						'note_down'		=> [S, DOWN],
						'note_up'		=> [W, UP],
						'note_right'	=> [D, RIGHT],
						
						'ui_left'		=> [A, LEFT],
						'ui_down'		=> [S, DOWN],
						'ui_up'			=> [W, UP],
						'ui_right'		=> [D, RIGHT],
						
						'accept'		=> [SPACE, ENTER],
						'back'			=> [BACKSPACE, ESCAPE],
						'pause'			=> [ENTER, ESCAPE],
						'reset'			=> [R, NONE],
						
						'volume_mute'	=> [ZERO, NONE],
						'volume_up'		=> [NUMPADPLUS, PLUS],
						'volume_down'	=> [NUMPADMINUS, MINUS],
						
						'debug_1'		=> [SEVEN, NONE],
						'debug_2'		=> [EIGHT, NONE],
                        'debug_3'		=> [SIX, NONE]
					];
					ClientPrefs.defaultKeys = null;
					ClientPrefs.defaultKeys = ClientPrefs.keyBinds.copy();
					ClientPrefs.saveSettings();
				}
		super.update(elapsed);
	}
}
