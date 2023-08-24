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
import flixel.FlxSubState;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import flixel.util.FlxTimer;
import flash.system.System;
import openfl.Lib;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.3.5'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var enable:Bool = false;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	public var pcTime:FlxText;

	var curDifficulty:Int = -1;

	private static var lastDifficultyName:String = '';

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
	var mods:FlxSprite;
	var credits:FlxSprite;
	var settings:FlxSprite;
	public var folder:FlxSprite;

	var versionShit1:FlxText;

	//made this for the variables for "folders" (won't be used once i make the fix for mouse and things) -Ed
	var inFolder:Bool = false;
	var inCMD:Bool = false;

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

		mods = new FlxSprite(50, freeplay.y +130);
		mods.frames = Paths.getSparrowAtlas('MenuShit/mods');
        mods.animation.addByPrefix('normal', 'mods normal', 48, true);
		mods.animation.addByPrefix('selected', 'mods selected', 48, true);
		mods.scale.x = 0.7;
		mods.scale.y = 0.7;
		mods.updateHitbox();
		mods.antialiasing = ClientPrefs.globalAntialiasing;
		add(mods);

		credits = new FlxSprite(50, mods.y +130);
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

		versionShit1 = new FlxText(72, FlxG.height - 50, 0, "HITMANS " + psychEngineVersion, 16);
		versionShit1.setFormat(Paths.font("pixel.otf"), 16, 0xffffffff, LEFT);
		versionShit1.scrollFactor.set();
		add(versionShit1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 24);
		versionShit.scrollFactor.set();
		versionShit.setFormat("Assassin Nation Regular", 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.visible = false;
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

		if (lastDifficultyName == '')
			{
				lastDifficultyName = CoolUtil.defaultDifficulty;
			}
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

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

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		dateThings = DateTools.format(Date.now(), "%Y-%m-%d | %H:%M");

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

			if (controls.BACK && !inCMD)
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
					mods.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(storyMode)) {
				if (FlxG.mouse.justPressed) {
					new FlxTimer().start(1, function(tmrS:FlxTimer)
					{
						MusicBeatState.switchState(new StoryMenuState());
					});
					folder.alpha = 0;
					inFolder = true;
					storyMode.animation.play('selected');
					freeplay.animation.play('normal');
					mods.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(freeplay)) {
				if (FlxG.mouse.justPressed) {
					new FlxTimer().start(1, function(tmrF:FlxTimer)
						{
							MusicBeatState.switchState(new FreeplayState());
						});
					folder.alpha = 0;
					inFolder = true;
					freeplay.animation.play('selected');
					storyMode.animation.play('normal');
					mods.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(mods)) {
				if (FlxG.mouse.justPressed) {
					#if MODS_ALLOWED
					new FlxTimer().start(1, function(tmrA:FlxTimer)
						{
							MusicBeatState.switchState(new ModsMenuState());
						});
					#end
					folder.alpha = 0;
					inFolder = true;
					mods.animation.play('selected');
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(credits)) {
				if (FlxG.mouse.justPressed) {
					new FlxTimer().start(1, function(tmrC:FlxTimer)
						{
							MusicBeatState.switchState(new CreditsState());
						});
					folder.alpha = 0;
					inFolder = true;
					credits.animation.play('selected');
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					mods.animation.play('normal');
					settings.animation.play('normal');
				}
			}
			if (FlxG.mouse.overlaps(settings)) {
				if (FlxG.mouse.justPressed) {
					new FlxTimer().start(1, function(tmrSe:FlxTimer)
						{
							LoadingState.loadAndSwitchState(new options.OptionsState());
						});
					folder.alpha = 0;
					inFolder = true;
					settings.animation.play('selected');
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					mods.animation.play('normal');
					credits.animation.play('normal');
				}
			}

			if (controls.ACCEPT && !inCMD)
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
									case 'awards':
										MusicBeatState.switchState(new ModsMenuState());
										// MusicBeatState.switchState(new AchievementsMenuState());
									#end
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
			if (FlxG.keys.justPressed.CONTROL && !selectedSomethin && !inCMD)
				{
					inCMD = true;
					openSubState(new CommandPromptSubstate());
				}
			if (FlxG.keys.justPressed.ESCAPE && inCMD)
				{
					inCMD = false;
				}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end

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
