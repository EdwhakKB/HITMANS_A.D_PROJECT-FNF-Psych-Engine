package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import flixel.util.FlxTimer;
import flash.system.System;
import openfl.Lib;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.2.5'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var enable:Bool = false;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	public var pcTime:FlxText;
	
	var dateThings = DateTools.format(Date.now(), "%Y-%m-%d | %H:%M");
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if MODS_ALLOWED 'mods', #end
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		// #if !switch 'donate', #end
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	//used for "Pc" visuals in the mod!
	var storyMode:FlxSprite;
	var freeplay:FlxSprite;
	var awards:FlxSprite;
	var credits:FlxSprite;
	var settings:FlxSprite;
	public var folder:FlxSprite;
	// prompt shit
	var prompt:FlxSprite;
	var allowedKeys:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var allowedNums:Array<String> = ['ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE', 'ZERO', 'SPACE']; //mhm
    var allowedSpecials:Array<String> = ['.', ',', '(', ')', '-', '_', '*', '=', '+', '/']; //hitmans will need this so, lmao

	var helpText:FlxText;
	var wordText:FlxText;
	var wordCode:Int = 0;
	var infoText:FlxText;

	var promptText:FlxText;

	//made this for the variables for "folders" (won't be used once i make the fix for mouse and things) -Ed
	var inFolder:Bool = false;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;
		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('MenuShit/wallPaper'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		storyMode = new FlxSprite(50, 20);
		storyMode.frames = Paths.getSparrowAtlas('MenuShit/story');
        storyMode.animation.addByPrefix('normal', 'story normal', 48, true);
		storyMode.animation.addByPrefix('selected', 'story selected', 48, true);
		storyMode.scale.x = 0.7;
		storyMode.scale.y = 0.7;
		storyMode.updateHitbox();
		storyMode.antialiasing = ClientPrefs.globalAntialiasing;
		add(storyMode);

		freeplay = new FlxSprite(50, storyMode.y +130);
		freeplay.frames = Paths.getSparrowAtlas('MenuShit/freeplay');
        freeplay.animation.addByPrefix('normal', 'freeplay normal', 48, true);
		freeplay.animation.addByPrefix('selected', 'freeplay selected', 48, true);
		freeplay.scale.x = 0.7;
		freeplay.scale.y = 0.7;
		freeplay.updateHitbox();
		freeplay.antialiasing = ClientPrefs.globalAntialiasing;
		add(freeplay);

		awards = new FlxSprite(50, freeplay.y +130);
		awards.frames = Paths.getSparrowAtlas('MenuShit/mods');
        awards.animation.addByPrefix('normal', 'mods normal', 48, true);
		awards.animation.addByPrefix('selected', 'mods selected', 48, true);
		awards.scale.x = 0.7;
		awards.scale.y = 0.7;
		awards.updateHitbox();
		awards.antialiasing = ClientPrefs.globalAntialiasing;
		add(awards);

		credits = new FlxSprite(50, awards.y +130);
		credits.frames = Paths.getSparrowAtlas('MenuShit/credits');
        credits.animation.addByPrefix('normal', 'credits normal', 48, true);
		credits.animation.addByPrefix('selected', 'credits selected', 48, true);
		credits.scale.x = 0.7;
		credits.scale.y = 0.7;
		credits.updateHitbox();
		credits.antialiasing = ClientPrefs.globalAntialiasing;
		add(credits);

		settings = new FlxSprite(50, credits.y +130);
		settings.frames = Paths.getSparrowAtlas('MenuShit/settings');
        settings.animation.addByPrefix('normal', 'settings normal', 48, true);
		settings.animation.addByPrefix('selected', 'settings selected', 48, true);
		settings.scale.x = 0.7;
		settings.scale.y = 0.7;
		settings.updateHitbox();
		settings.antialiasing = ClientPrefs.globalAntialiasing;
		add(settings);

		folder = new FlxSprite(200, 40).loadGraphic(Paths.image('MenuShit/folder'));
		folder.updateHitbox();
		folder.alpha = 0;
		folder.antialiasing = ClientPrefs.globalAntialiasing;
		add(folder);

		var pcInterfas:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('MenuShit/PCInterfas'));
		pcInterfas.updateHitbox();
		pcInterfas.screenCenter();
		pcInterfas.antialiasing = ClientPrefs.globalAntialiasing;
		add(pcInterfas);

		pcTime = new FlxText(970, 670, Std.int(FlxG.width * 0.6), "0:00", 25);
        pcTime.setFormat(Paths.font("vcr.ttf"), 25, 0xffffffff);
		pcTime.alpha = 1;
		add(pcTime);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		prompt = new FlxSprite().loadGraphic(Paths.image('MenuShit/CMD'));
		prompt.scrollFactor.set(0);
		prompt.screenCenter();
		prompt.antialiasing = ClientPrefs.globalAntialiasing;
		add(prompt);
		prompt.alpha = 0;

		helpText = new FlxText(0, 0, FlxG.width, 
		    "'DEBUG'      - Watch last debug\n
			'OPTIONS'    - Launch Options.exe\n
			'RESTART'   - Restart the whole system (unestable)\n
			'RESETDATA' - Reset your Data\n
			'LOGIN'     - Login into your corporation profile\n
			'TEST'      - Load THE TUTORIAL Song\n
			'OPTIONS'   - Open the options\n
			'EXIT'      - Exit the system", 12);
		helpText.setFormat(Paths.font("pixel.otf"), 12, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		helpText.scrollFactor.set();
		helpText.screenCenter();
		helpText.x += 185;
		helpText.y += 85;
		helpText.borderSize = 2.5;
		helpText.alpha = 0;
		add(helpText);	

		wordText = new FlxText(0, 0, FlxG.width, "", 32);
		wordText.setFormat(Paths.font("pixel.otf"), 32, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		wordText.scrollFactor.set();
		wordText.screenCenter();
		wordText.x += 175;
		wordText.y += 240;
		wordText.borderSize = 2.5;
		add(wordText);	

		infoText = new FlxText(0, 0, FlxG.width, "", 16);
		infoText.setFormat(Paths.font("pixel.otf"), 16, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.scrollFactor.set();
		infoText.screenCenter();
		infoText.x += 175;
		infoText.y -= 100;
		infoText.borderSize = 2.5;
		add(infoText);	

		promptText = new FlxText(0, 0, FlxG.width, "Hitmans Corporation [C.D.B]\nWarning: Modifying anything can be very unstable, continue at your own risk", 16);
		promptText.setFormat(Paths.font("pixel.otf"), 16, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		promptText.scrollFactor.set();
		promptText.screenCenter();
		promptText.x += 175;
		promptText.y -= 165;
		promptText.borderSize = 2.5;
		add(promptText);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
			menuItem.alpha = 0;
		}

		// FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Hitmans Engine ver " + psychEngineVersion, 24);
		versionShit.scrollFactor.set();
		versionShit.setFormat("Assassin Nation Regular", 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 24);
		versionShit.scrollFactor.set();
		versionShit.setFormat("Assassin Nation Regular", 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		wordText.alpha = prompt.alpha;
		infoText.alpha = prompt.alpha;
		promptText.alpha = prompt.alpha;

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		dateThings = DateTools.format(Date.now(), "%Y-%m-%d | %H:%M");

		if (prompt.alpha == 0){

			#if desktop
			// Updating Discord Rich Presence
			DiscordClient.changePresence("USER MENU", null);
			#end

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				if (!inFolder){
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new TitleState());
				}else{
					folder.alpha = 0;
					inFolder = false;
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					awards.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(storyMode)) {
				if (FlxG.mouse.justPressed) {
					MusicBeatState.switchState(new StoryMenuState());
					folder.alpha = 0;
					inFolder = true;
					storyMode.animation.play('selected');
					freeplay.animation.play('normal');
					awards.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(freeplay)) {
				if (FlxG.mouse.justPressed) {
					MusicBeatState.switchState(new FreeplayState());
					folder.alpha = 0;
					inFolder = true;
					freeplay.animation.play('selected');
					storyMode.animation.play('normal');
					awards.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(awards)) {
				if (FlxG.mouse.justPressed) {
					MusicBeatState.switchState(new AchievementsMenuState());
					folder.alpha = 0;
					inFolder = true;
					awards.animation.play('selected');
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(credits)) {
				if (FlxG.mouse.justPressed) {
					MusicBeatState.switchState(new CreditsState());
					folder.alpha = 0;
					inFolder = true;
					credits.animation.play('selected');
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					awards.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(settings)) {
				if (FlxG.mouse.justPressed) {
					LoadingState.loadAndSwitchState(new options.OptionsState());
					folder.alpha = 0;
					inFolder = true;
					settings.animation.play('selected');
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					awards.animation.play('normal');
					credits.animation.play('normal');
				}
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					// CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 0.05, 0.05, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			if (FlxG.keys.justPressed.CONTROL && !selectedSomethin)
				{
					FlxTween.tween(prompt, {alpha: 1}, 0.25, {ease: FlxEase.circOut});
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end

		}
		}

		var resetting:Bool = false;
		if(prompt.alpha == 1)
			{

				#if desktop
				// Updating Discord Rich Presence
				DiscordClient.changePresence("COMMAND PROMPT", null);
				#end

				if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
					{
						var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
						var keyName:String = Std.string(keyPressed);
						if(allowedKeys.contains(keyName) || allowedNums.contains(keyName)) {
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
                                        case '.':
                                            keyName = '.';
                                        case ',':
                                            keyName = ',';
                                        case '(':
                                            keyName = '(';
                                        case ')':
                                            keyName = ')';
                                        case '-':
                                            keyName = '-';
                                        case '_':
                                            keyName = '_';
                                        case '*':
                                            keyName = '*';
                                        case '=':
                                            keyName = '=';
                                        case '+':
                                            keyName = '+';
                                        case '/':
                                            keyName = '/';
                                    }
									wordText.text += keyName;
									FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								}
						}
					}

				if (FlxG.keys.justPressed.BACKSPACE)
					{
						if(wordText.text != '')
							{
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								wordText.text = '';
							}
					}

				if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.CONTROL)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
						FlxTween.tween(prompt, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
						wordText.text = '';
						infoText.text = '';
						helpText.alpha = 0;
					}

				else if (FlxG.keys.justPressed.ENTER)
					{
						if(wordText.text == 'HELP')
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

						else if(wordText.text == 'DEBUG')
							{
								infoText.text = 'PLEASE WAIT...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = 
										"HITMANS A.D PROJECT V1\nHello everyone it's me Edwhak, the coder\nThis Hitmans version is a demo of the mod itself\nRemember to check this everytime you want to see what's new\n
                                        -Added Better modchart system (ZoroModTools)\n
                                        -Fixed crash in the engine (finally)\n
                                        -Updated HUD and menu\n
                                        -Added Casual mode (SKILL ISSUE MODE LMAO)\n
                                        ENJOY!";
									});
							}
							
						else if(wordText.text == 'OPTIONS')
							{
								infoText.text = 'EXECUTING...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = " ";
										LoadingState.loadAndSwitchState(new options.OptionsState());
									});
							}

						else if(wordText.text == 'LOGIN')
							{
								infoText.text = 'PLEASE WAIT...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = "THIS IS STILL UNDER DEVELOPMENT\nCOME BACK LATER";
									});
							}

					    else if(wordText.text == 'RESETDATA')
							{
								infoText.text = 'Your Settings and Controls were reset.';
								wordText.text = '';
								resetting = true;
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}

					    else if(wordText.text == 'RESTART')
							{
								infoText.text = 'Restarting...';
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
										FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
									});
							}

						else if(wordText.text == 'EXIT')
							{
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
							}

					    else if(wordText.text == 'HELLO')
							{
								infoText.text = 'Oh, hello there!\nI hope you like this mod!\nTrying to find all commands, aren\'t you?\nHa-ha, anyway, have fun!';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}

					    else if(wordText.text == 'PASSWORD')
							{
								infoText.text = 'Nope!\nYou have to guess for yourself!\nIt\'s not that hard!';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}

						else if(wordText.text == 'FUCK YOU')
							{
								infoText.text = 'Rude! >:\'<';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
										FlxTween.tween(prompt, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
										wordText.text = '';
										infoText.text = '';
										helpText.alpha = 0;
										new FlxTimer().start(0.25, function(tmr:FlxTimer) 
											{
												infoText.text = 'Don\'t do that again. :\'<';
											});
									});
							}

						else if(wordText.text == 'SORRY' && infoText.text == 'Don\'t do that again. :\'<')
							{
								infoText.text = 'Aww, okay!\nApologies are accepted :3';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}

						else if(wordText.text == 'BALLS')
							{
								infoText.text = 'Balls everywhere!';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}

						else if(wordText.text == 'HAZARD24')
							{
								infoText.text = 'Cute! OwO';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}

						else if(wordText.text == '77')
							{
								infoText.text = 'I think you wanted to say 150.\nYeah. 150.';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
							}

					    else if(wordText.text == 'TEST')
							{
								infoText.text = 'Loading Testing Song...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										persistentUpdate = false;
								        var songLowercase:String = 'Operating';
								        var poop:String = Highscore.formatSong(songLowercase, 0);
								        trace(poop);
								        PlayState.SONG = Song.loadFromJson(poop, songLowercase);
								        PlayState.isStoryMode = false;
								        PlayState.storyDifficulty = 0;

										if(FreeplayState.vocals != null)
											{
												FreeplayState.vocals.fadeOut(0.3);
												FreeplayState.vocals = null;
											}
								
								        if (FlxG.keys.pressed.SHIFT){
									            LoadingState.loadAndSwitchState(new editors.ChartingState());
								            }else{
									            LoadingState.loadAndSwitchState(new PlayState());
								            }
					
								        FlxG.sound.music.volume = 0;
									}
									);
							}

						else if(wordText.text == 'COMPLETE')
							{
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
									
								var hazardBlack:BGSprite = new BGSprite(null, -FlxG.width, -FlxG.height, 0, 0);
								hazardBlack.makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
								hazardBlack.scrollFactor.set(1);
					
								var hazardBG:BGSprite = new BGSprite('hazard/cheat-bg');
								hazardBG.setGraphicSize(FlxG.width, FlxG.height);
								//hazardBG.x += (FlxG.width/2); //Mmmmmm scuffed positioning, my favourite!
								//hazardBG.y += (FlxG.height/2) - 20;
								hazardBG.updateHitbox();
								hazardBG.scrollFactor.set(1);
								hazardBG.screenCenter();
					
								var cheater:BGSprite = new BGSprite('hazard/cheat', -600, -480, 0.5, 0.5);
								cheater.setGraphicSize(Std.int(cheater.width * 1.5));
								cheater.updateHitbox();
								cheater.scrollFactor.set(1);
								cheater.screenCenter();	
					
								add(hazardBlack);
								add(hazardBG);
								add(cheater);
								FlxG.camera.shake(0.05,5);
								FlxG.sound.play(Paths.sound('cheatercheatercheater'), 1, true);
								#if desktop
								// Updating Discord Rich Presence
								DiscordClient.changePresence("CHEATER CHEATER CHEATER","CHEATER CHEATER CHEATER", null);
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
							}
						else
							{
								if(wordText.text != '')
									{
										infoText.text = 'Invalid command.\nTry to type again.';
										wordText.text = '';
										FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
									}
							}
					}
			}

			if(resetting == true)
				{
					ClientPrefs.noteSkin = 'HITMANS';
					ClientPrefs.hudStyle = 'HITMANS';
					ClientPrefs.downScroll = false;
					ClientPrefs.middleScroll = true;
					ClientPrefs.opponentStrums = false;
					//ClientPrefs.showFPS = true; -- does not work for some reason
					ClientPrefs.flashing = true;
					ClientPrefs.globalAntialiasing = true;
					ClientPrefs.noteSplashes = true;
					ClientPrefs.lowQuality = false;
					ClientPrefs.shaders = true;
					ClientPrefs.framerate = 60;
					ClientPrefs.cursing = true;
					ClientPrefs.violence = true;
					ClientPrefs.camZooms = true;
					ClientPrefs.hideHud = false;
					ClientPrefs.noteOffset = 0;
					ClientPrefs.arrowHSV = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
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
				}
		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
		pcTime.text = dateThings;
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
