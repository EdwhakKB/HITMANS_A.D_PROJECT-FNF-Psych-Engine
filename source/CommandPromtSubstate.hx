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
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import flixel.util.FlxTimer;
import flash.system.System;
import openfl.Lib;

using StringTools;

class CommandPromtSubstate extends MusicBeatSubstate
{
	private var camGame:FlxCamera;

	var camFollow:FlxObject;
	var camFollowPos:FlxObject;

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

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

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

		prompt = new FlxSprite().loadGraphic(Paths.image('MenuShit/folder'));
		prompt.scrollFactor.set(0);
		prompt.screenCenter();
		prompt.antialiasing = ClientPrefs.globalAntialiasing;
		add(prompt);
		prompt.alpha = 1;

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
		helpText.screenCenter();
		helpText.x += 105;
		helpText.y -= 65;
		helpText.borderSize = 2.5;
		helpText.alpha = 1;
		add(helpText);	

		wordText = new FlxText(0, 0, FlxG.width, "", 32);
		wordText.setFormat(Paths.font("pixel.otf"), 32, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		wordText.scrollFactor.set();
		wordText.screenCenter();
		wordText.x += 105;
		wordText.y += 275;
		wordText.borderSize = 2.5;
		add(wordText);	

		infoText = new FlxText(0, 0, FlxG.width, "", 16);
		infoText.setFormat(Paths.font("pixel.otf"), 16, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.scrollFactor.set();
		infoText.screenCenter();
		infoText.x += 105;
		infoText.y += 100;
		infoText.borderSize = 2.5;
		add(infoText);	

		promptText = new FlxText(0, 0, FlxG.width, "Hitmans Corporation [C.D.B]\nWarning: Modify anything can be very unestable\ncontinue by your own risk", 16);
		promptText.setFormat(Paths.font("pixel.otf"), 16, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		promptText.scrollFactor.set();
		promptText.screenCenter();
		promptText.x += 105;
		promptText.y -= 235;
		promptText.borderSize = 2.5;
		add(promptText);	
	}

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

		var resetting:Bool = false;
		if(prompt.alpha == 1)
			{

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
						wordText.text = '';
						infoText.text = '';
						helpText.alpha = 0;
                        close();
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
										infoText.text = "HITMANS A.D PROJECT V1\n
                                        Hello everyone its me Edwhak, the coder\n
                                        This Hitmans version its a demo of the mod itself\n
                                        Remember watch this every time you want to check whats new\n
                                        -Added Better modchart system (from zoro modcharting tools)\n
                                        -Fixed crash in the engine (finally)\n
                                        -Note Skins\n
                                        -Updated HUD and menu\n
                                        -Added Casual mode (SKILL ISSUE MODE LMAO)\n
                                        Thats all i can say\n
                                        ENJOY!";
									});
							}
							
						else if(wordText.text == 'SET')
							{
								infoText.text = 'PLEASE WAIT...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = "THIS IS STILL UNDER DEVELOPMENT\n
                                        COME BACK LATER";
									});
							}

						else if(wordText.text == 'LOGIN')
							{
								infoText.text = 'PLEASE WAIT...';
								wordText.text = '';
								FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
								new FlxTimer().start(1, function(tmr:FlxTimer) 
									{
										infoText.text = "THIS IS STILL UNDER DEVELOPMENT\n
                                        COME BACK LATER";
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
								        var songLowercase:String = 'Tutorial';
								        var poop:String = Highscore.formatSong(songLowercase, 2);
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
									            LoadingState.loadAndSwitchState(new ChartingState());
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
	}
}
