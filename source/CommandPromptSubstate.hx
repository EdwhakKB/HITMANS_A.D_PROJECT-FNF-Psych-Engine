package;

import flixel.input.FlxKeyManager;
import flixel.addons.ui.FlxInputText;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.ui.FlxUIInputText;
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

import flixel.util.FlxSave;
using StringTools;

class CommandPromptSubstate extends MusicBeatSubstate
{
	private var camPromptBG:FlxCamera;
	private var camPromptText:FlxCamera;
	private var camPromptFrame:FlxCamera;
	private var camOutside:FlxCamera;

	//some stuff
	public var stopWorking:Bool = false;
	public var changingNickname:Bool = false;
	public var resetWarning:Bool = false;
	public var resetting:Bool = false;
	public var capsLOCK:Bool = false;
	public var lastCMD:String = '';

	var prompt:FlxSprite;
	
	private var specialGuest:Array<String> = ['AnbyFox', 'Hazard24', 'Luna', 'EdwhakKB', 'Glowsoony', 'Slushi']; //this is to enable some extra functions
	private var passWords:Array<String> = ['FoxOs', 'InhumanOs', 'POFT', '4NN1HILAT3', 'MISCECONMODCHART', 'S2LUZE9ASHI']; //TF WITH THE PASSWORDS LMAO -Ed
	private var neededPassword:String = ''; //so when you try access it ask for dev password and NEED be the dev password
	private var devNameEnabled:Bool = false; //so if you add one of those developer mode will be enabled if password match
	private var currentDEVName:String = '';
	private var developerImage:FlxSprite;
	private var tryingLogOut:Bool = false; //so they must make sure they will logout before it just log them out (just a dynamic visual LOL)

	var currentName:String = '';

	var changingUserName:Bool = false;

	var promptText:FlxText;
	var promptInfoText:FlxText;
	var promptFrame:FlxSprite;

	var micrashPercent:Float = 0.0; 
    var fuckYouCommand:Bool = false;
    var valueSpeed:Float = 20.0;
    var micrashPercentText:FlxText;

	var commandsArray:Array<String> = [
		'help', 'debug', 'options', 'credits', 'storymode', 'freeplay', 'mods', 'awards', //basic commands
		'login', 'logout', 'reset data', 'restart', 'exit', 'clear', //system commands
		'hello', 'fuck you', //misc commands
		'love', 'mercyless', 'redacted info', 'fallen memories', 'test', //game commands
		'yes', 'no' //funny
	]; //i use this to add all commands to be readed instead of being loaded manually in CMD ig?

	var keyInput:String = '';
	var keyList:Array<String> = [
		'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
		'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE', 'ZERO', 'SPACE', 
		'PLUS', 'MINUS', 'GRAVEACCENT', 'COMMA', 'LBRACKET', 'RBRACKET', 'QUOTE', 'SLASH', 'BACKSLASH', 'SEMICOLON', 'PERIOD',
		'NUMPADONE', 'NUMPADTWO', 'NUMPADTHREE', 'NUMPADFOUR', 'NUMPADFIVE', 'NUMPADSIX', 'NUMPADSEVEN', 'NUMPADEIGHT', 'NUMPADNINE', 'NUMPADZERO', 
		'NUMPADPLUS', 'NUMPADMINUS', 'NUMPADMULTIPLY', 'NUMPADPERIOD'
	];
	var commandsInfo:Array<String> = [
		'Opened the help menu', 'These are the lastes changes inside the system' ,'Executing Configuration.hx...', 'Executing MemberList.hx...', 
		'Executing Security.hx...', 'Executing Free Mode.hx...', 'Executing DiskReaded.hx...', 'Executing HallOfFame.hx...', //basic commands

		'Here are the Login results', 'Here are the Logout results', 'Are you sure you want to reset all data (y/n)?',
		'Restarting...', 'See you next time...', 'if you see this it didnt work', //system commands

		'Hello there!', '...', //misc commands

		'Opening Edwhak folder', 'Get ready for a massacre...', 'They where a good company before their death', 'I still remember that day', 'Opening Test Log', //game commands
		'You was succesfuly logged out', 'Okay, enjoy your stay' //i forgot those :skull:
	];

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Desktop", 'Command Prompt', null);
		#end

		camPromptBG = new FlxCamera();
		camPromptBG.bgColor.alpha = 0;
		camPromptText = new FlxCamera();
		camPromptText.bgColor.alpha = 0;
		camPromptFrame = new FlxCamera();
		camPromptFrame.bgColor.alpha = 0;

		camOutside = new FlxCamera();
		camOutside.bgColor.alpha = 0;

		FlxG.cameras.add(camPromptBG, false);
		FlxG.cameras.add(camPromptText, false);
		FlxG.cameras.add(camPromptFrame, false);
		FlxG.cameras.add(camOutside, false);

		persistentUpdate = persistentDraw = true;

        super.create();

		camPromptBG.setScale(0.75, 0.75);
		camPromptText.setScale(0.75, 0.75);
		camPromptFrame.setScale(0.75, 0.75);

		prompt = new FlxSprite().loadGraphic(Paths.image('MenuShit/CMD'));
		prompt.scrollFactor.set(0);
		prompt.screenCenter();
		prompt.antialiasing = ClientPrefs.globalAntialiasing;
		add(prompt);

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

		promptInfoText = new FlxText(prompt.x + 30, FlxG.height - 565, FlxG.width, "", 21);
		promptInfoText.setFormat(Paths.font("pixel.otf"), 21, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
		promptInfoText.scrollFactor.set(0);
		promptInfoText.borderSize = 2.5;
		add(promptInfoText);

		promptText = new FlxText(prompt.x + 30, FlxG.height - 490, FlxG.width, "", 21);
		promptText.setFormat(Paths.font("pixel.otf"), 21, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.TRANSPARENT);
		promptText.scrollFactor.set(0);
		promptText.borderSize = 2.5;
		add(promptText);

		if (ClientPrefs.edwhakMode){
			// infoText.text = "Hola Eddy! :3, como estas? que vamos a hacer hoy?";
			// promptText.text = "Hitmans Corporation [Virus Glitcher V5.5]\nEspero tengas un gran y maravilloso dia Eddy!";
			developerImage.visible = true;
		}else if (ClientPrefs.developerMode){
			// infoText.text = "Wellcome Developer - " + ClientPrefs.userName + "! what are we going to test today?";
			// promptText.text = "Hitmans Corporation [DEVELOPER]\nHave a nice day!";
			developerImage.visible = true;
		}
		currentName = ClientPrefs.userName; //to have a backUp of this in case player want play a nonDev mode edition (dev mode will be everywhere LOL)

		keyInput = '';
		lastCMD = '';

		promptText.text = '';

		prompt.cameras = [camPromptBG];
		developerImage.cameras = [camPromptBG];
		promptInfoText.cameras = [camPromptText];
		promptText.cameras = [camPromptText];
		// promptFrame.cameras = [camPromptFrame];
    }

	var selectedSomethin:Bool = false;
	var holdTime:Float = 0;
	var keyName:String = '';

	function checkCommand(command:String)
	{
		var resultCommand:String = ""; //i preload is as nothing first
		if (commandsArray.contains(command)){
			resultCommand = commandsArray[commandsArray.indexOf(command)]; //so it returns the actual command
			trace('IndexCommand is: ' + commandsArray.indexOf(command));
			updatePromptText(commandsInfo[commandsArray.indexOf(command)]); //to make this work, both arrays should be the same lenght
			applyCommand(resultCommand);
		}else{
			resultCommand = 'notFound';
		}
		trace('Input command is: ' + resultCommand);
		keyInput = ''; //i reset the input here so it will work again
		return resultCommand; //so i make game load the command correclty or nothing
	}

	function updatePromptText(text:String)
	{
		promptText.text += text +'\n\n'; //way opt than before!
	}

	function applyCommand(command:String)
	{
		switch(command){
			case 'clear':
				promptText.text = '';
			case 'help':
				promptText.text += "'clear'           - Clear Prompt."
				+ "\n'debug'           - Open the list of changes."
				+ "\n'report'          - Report a bug/error."
				+ "\n'login/logout'    - Change nickname."
				+ "\n'reset data'      - Reset all Progress and Data."
				+ "\n'restart'         - Restart the program."
				+ "\n'exit'            - Exit the program.\n\n";
			case 'debug':
				promptText.text += "Updated Hallucination Duality and Operating - (modchart and visuals)."
				+ "\nImproved gameplay system - (visuals)"
				+ "\nNew hud 'lovely'  - Accesible with commands."
				+ "\nFixed game crashing - it will go back 1 state.";
			case 'exit':
				stopWorking = true;
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
			case 'options':
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					MainMenuState.inCMD = false;
					LoadingState.loadAndSwitchState(new options.OptionsState());
				});
			case 'freeplay':
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				new FlxTimer().start(1, function(tmr:FlxTimer) 
				{
					MainMenuState.inCMD = false;
					MusicBeatState.switchState(new FreeplayState());
				});
			case 'storymode':
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				new FlxTimer().start(1, function(tmr:FlxTimer) 
				{
					MainMenuState.inCMD = false;
					MusicBeatState.switchState(new StoryMenuState());
				});
			case 'credits':
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				new FlxTimer().start(1, function(tmr:FlxTimer) 
				{
					MainMenuState.inCMD = false;
					MusicBeatState.switchState(new CreditsState());
				});
			case 'mods':
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				new FlxTimer().start(1, function(tmr:FlxTimer) 
				{
					MainMenuState.inCMD = false;
					#if MODS_ALLOWED
					MusicBeatState.switchState(new ModsMenuState());
					#else

					#end
				});
			case 'awards':
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				new FlxTimer().start(1, function(tmr:FlxTimer) 
				{
					MainMenuState.inCMD = false;
					MusicBeatState.switchState(new achievements.AchievementsMenuState());
				});
			case 'login':
				if (!changingUserName){
					if (ClientPrefs.userName == 'Guess'){
						changingUserName = true;
						updatePromptText('Please type your new username');
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					}else{
						updatePromptText('You are already logged in as '+ ClientPrefs.userName +' try "Logout" to change userName');
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					}
				}
			case 'logout':
				if (!changingUserName){
					if (ClientPrefs.userName != 'Guess' && !ClientPrefs.edwhakMode && !ClientPrefs.developerMode){
						updatePromptText("You was successfully logged out");
						ClientPrefs.userName = 'Guess';
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					}else if (ClientPrefs.userName != 'Guess' && ClientPrefs.edwhakMode || ClientPrefs.developerMode){
						updatePromptText("Are you sure you want to logout? "+ ClientPrefs.userName + " You must login again");
						tryingLogOut = true;
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					}else if (ClientPrefs.userName == 'Guess'){
						updatePromptText("You can't logout on a Guess account");
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
					}
				}
			case 'yes':
				if (tryingLogOut){
					updatePromptText("You was successfully logged out");
					tryingLogOut = false;
					ClientPrefs.edwhakMode = false;
					ClientPrefs.developerMode = false;
					ClientPrefs.userName = 'Guess';
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				}else{
					updatePromptText("No.");
				}
			case 'no':
				if (tryingLogOut){
					updatePromptText("Ok "+ ClientPrefs.userName +" enjoy your stay");
					tryingLogOut = false;
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				}else{
					updatePromptText("Yes.");
				}
			case 'reset data':
				updatePromptText('All Progress and Data will be reset.\nAre you sure about that? Y/N');
				keyInput = '';
				resetWarning = true;
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
			case 'restart':
				stopWorking = true;
				updatePromptText('Restarting...');
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
			case 'fuck you':
				stopWorking = true;
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
			case 'love':
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
			case 'redacted info':
				new FlxTimer().start(1, function(tmr:FlxTimer) 
					{
						updatePromptText("Sorry if i can't provide info about them");
					}
				);
				new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						updatePromptText("It is redacted...");
					}
				);
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
			case 'fallen os':
				new FlxTimer().start(2, function(tmr:FlxTimer) 
					{
						updatePromptText("Still wondering, how did that happend");
					}
				);
				new FlxTimer().start(4, function(tmr:FlxTimer)
					{
						updatePromptText("It a true mistery");
					}
				);
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
			case 'test':
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
			case 'beatmod': //unused
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
				// updatePromptText("");

		}
	}
	override function update(elapsed:Float)
	{
		promptInfoText.text = "Hitmans Corporation [v"+MainMenuState.psychEngineVersion+"] - Status: Active.\nCurrent Time: " + DateTools.format(Date.now(), "%H:%M - %d.%m.%y");

		var justPressedKey:FlxKey = FlxG.keys.firstJustPressed();
		var pressedKey:FlxKey = FlxG.keys.firstPressed();

		if(fuckYouCommand)
		{
			lime.app.Application.current.window.fullscreen = true;
			micrashPercent += valueSpeed * elapsed;

			micrashPercentText.text = Math.round(micrashPercent) + "%";

			if(micrashPercent >= 100){
				Sys.exit(1);
			}
		}

		if(!stopWorking){
				if (FlxG.keys.firstJustPressed() != FlxKey.NONE){
					keyName = Std.string(justPressedKey);
					if (keyList.contains(keyName)){
						updateKeys();
						holdTime = 0;
						if (capsLOCK || FlxG.keys.pressed.SHIFT){
							keyInput += keyName;
							promptText.text += keyName;
						} else {
							keyInput += keyName.toLowerCase();
							promptText.text += keyName.toLowerCase();
						}
	
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					}
				} else if (FlxG.keys.firstPressed() != FlxKey.NONE){
					keyName = Std.string(pressedKey);
					if (keyList.contains(keyName)){
						updateKeys();
						var checkLastHold:Int = Math.floor((holdTime - 0.25) * 20);
						holdTime += elapsed;
						var checkNewHold:Int = Math.floor((holdTime - 0.25) * 20);
						if (holdTime > 0.5 && checkNewHold - checkLastHold > 0){
							if (capsLOCK || FlxG.keys.pressed.SHIFT){
								keyInput += keyName;
								promptText.text += keyName;
							} else {
								keyInput += keyName.toLowerCase();
								promptText.text += keyName.toLowerCase();
							}
						}
					}
				}
		
				if (FlxG.keys.justPressed.CAPSLOCK) capsLOCK = !capsLOCK;
			
				if (FlxG.keys.justPressed.UP){
					if (lastCMD != ''){
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
						keyInput = lastCMD;
						promptText.text += lastCMD;
					}
				}
		
				if (FlxG.keys.justPressed.BACKSPACE){
					if (keyInput != ''){
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
						keyInput = keyInput.substring(0, keyInput.length - 1);
						promptText.text = promptText.text.substring(0, promptText.text.length - 1);
						holdTime = 0;
					}
				} else if (FlxG.keys.pressed.BACKSPACE){
					if (keyInput != ''){
						var checkLastHold:Int = Math.floor((holdTime - 0.25) * 20);
						holdTime += elapsed;
						var checkNewHold:Int = Math.floor((holdTime - 0.25) * 20);
						if (holdTime > 0.5 && checkNewHold - checkLastHold > 0){
							keyInput = keyInput.substring(0, keyInput.length - 1);
							promptText.text = promptText.text.substring(0, promptText.text.length - 1);
						}
					}
				}
		
				if (FlxG.keys.justPressed.ESCAPE){
					FlxG.sound.play(Paths.sound('scrollMenu'));
					close();
					MainMenuState.inCMD = false;
					#if desktop
					// Updating Discord Rich Presence
					DiscordClient.changePresence("Main Menu", null);
					#end
				}
				
				if (FlxG.keys.justPressed.ENTER){
					lastCMD = keyInput;

					var cmdCheck = keyInput.toLowerCase();
					if(cmdCheck != '') promptText.text += '\n\n'; 

					if(!changingUserName && !resetWarning && cmdCheck != ''){
						checkCommand(keyInput.toLowerCase()); //i can check if it is a command or something else such as ClientPrefs or something else
					}

					if(!changingUserName && resetWarning){
						if(keyInput.toLowerCase() == 'y'){
							keyInput = '';
							stopWorking = true;
							FlxG.sound.play(Paths.sound('scrollMenu'));
		
							var save:FlxSave = new FlxSave();
							save.bind('controls_v2', 'ninjamuffin99');
							save.erase();
							FlxG.save.erase();
		
							TitleState.initialized = false;
							TitleState.closedState = false;
							FlxG.sound.music.fadeOut(0.3);
							if (FreeplayState.vocals != null){
								FreeplayState.vocals.fadeOut(0.3);
								FreeplayState.vocals = null;
							}
		
							camOutside.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
						} else {
							updatePromptText('Cancelled "Reset" command');
							keyInput = '';
							resetWarning = false;
							FlxG.sound.play(Paths.sound('scrollMenu'));
						}
					}
				}
			}
		super.update(elapsed);
	}

	function updateKeys() //the funny LMAO
	{
		if (keyName == 'ONE') FlxG.keys.pressed.SHIFT ? keyName = '!' : keyName = '1';
		else if (keyName == 'TWO') FlxG.keys.pressed.SHIFT ? keyName = '@' : keyName = '2';
		else if (keyName == 'THREE') FlxG.keys.pressed.SHIFT ? keyName = '#' : keyName = '3';
		else if (keyName == 'FOUR') FlxG.keys.pressed.SHIFT ? keyName = '$' : keyName = '4';
		else if (keyName == 'FIVE') FlxG.keys.pressed.SHIFT ? keyName = '%' : keyName = '5';
		else if (keyName == 'SIX') FlxG.keys.pressed.SHIFT ? keyName = '^' : keyName = '6';
		else if (keyName == 'SEVEN') FlxG.keys.pressed.SHIFT ? keyName = '&' : keyName = '7';
		else if (keyName == 'EIGHT') FlxG.keys.pressed.SHIFT ? keyName = '*' : keyName = '8';
		else if (keyName == 'NINE') FlxG.keys.pressed.SHIFT ? keyName = '(' : keyName = '9';
		else if (keyName == 'ZERO') FlxG.keys.pressed.SHIFT ? keyName = ')' : keyName = '0';
		else if (keyName == 'MINUS') FlxG.keys.pressed.SHIFT ? keyName = '_' : keyName = '-';
		else if (keyName == 'PLUS') FlxG.keys.pressed.SHIFT ? keyName = '+' : keyName = '=';
		else if (keyName == 'GRAVEACCENT') FlxG.keys.pressed.SHIFT ? keyName = '~' : keyName = '`';
		else if (keyName == 'LBRACKET') FlxG.keys.pressed.SHIFT ? keyName = '{' : keyName = '[';
		else if (keyName == 'RBRACKET') FlxG.keys.pressed.SHIFT ? keyName = '}' : keyName = ']';
		else if (keyName == 'QUOTE') FlxG.keys.pressed.SHIFT ? keyName = '"' : keyName = '\'';
		else if (keyName == 'SLASH') FlxG.keys.pressed.SHIFT ? keyName = '?' : keyName = '/';
		else if (keyName == 'BACKSLASH') FlxG.keys.pressed.SHIFT ? keyName = '\\' : keyName = '|';
		else if (keyName == 'SEMICOLON') FlxG.keys.pressed.SHIFT ? keyName = ':' : keyName = ';';
		else if (keyName == 'PERIOD') FlxG.keys.pressed.SHIFT ? keyName = '>' : keyName = '.';
		else if (keyName == 'COMMA') FlxG.keys.pressed.SHIFT ? keyName = '<' : keyName = ',';
		else if (keyName == 'NUMPADONE') keyName = '1';
		else if (keyName == 'NUMPADTWO') keyName = '2';
		else if (keyName == 'NUMPADTHREE') keyName = '3';
		else if (keyName == 'NUMPADFOUR') keyName = '4';
		else if (keyName == 'NUMPADFIVE') keyName = '5';
		else if (keyName == 'NUMPADSIX') keyName = '6';
		else if (keyName == 'NUMPADSEVEN') keyName = '7';
		else if (keyName == 'NUMPADEIGHT') keyName = '8';
		else if (keyName == 'NUMPADNINE') keyName = '9';
		else if (keyName == 'NUMPADZERO') keyName = '0';
		else if (keyName == 'NUMPADPLUS') keyName = '+';
		else if (keyName == 'NUMPADMINUS') keyName = '-';
		else if (keyName == 'NUMPADMULTIPLY') keyName = '*';
		else if (keyName == 'NUMPADSLASH') keyName = '/';
		else if (keyName == 'NUMPADPERIOD') keyName = '.';
		else if (keyName == 'SPACE') keyName = ' ';
	}
}
