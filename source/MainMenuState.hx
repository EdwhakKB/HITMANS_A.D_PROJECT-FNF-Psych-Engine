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
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

import flixel.util.FlxTimer;
import flash.system.System;
import openfl.Lib;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.4.5 (DEMO)'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var enable:Bool = false;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	private var camPC:FlxCamera;
	private var camInsidePC:FlxCamera;

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
	var notes:FlxSprite;
	public var folder:FlxSprite;
	public var pcThing:FlxSprite;
	public var pcInside:FlxSprite;

	var versionShit1:FlxText;

	//made this for the variables for "folders" (won't be used once i make the fix for mouse and things) -Ed
	public static var inFolder:Bool = false;
	public static var inCMD:Bool = false;

	override function create()
	{
		Paths.setCurrentLevel('shared'); //LMAO LMAO
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;
		FlxG.mouse.visible = true;

		// camGame = new FlxCamera();
		// camAchievement = new FlxCamera();
		camPC = new FlxCamera();
		camPC.bgColor.alpha = 0;
		camInsidePC = new FlxCamera();
		camInsidePC.bgColor.alpha = 0;

		FlxG.cameras.add(camInsidePC, false);
		FlxG.cameras.add(camPC, false);

		camInsidePC.setScale(0.6,0.6);

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('MenuShit/wallPaper'));
		bg.updateHitbox();
		bg.screenCenter();
		//bg.cameras = [camInsidePC];
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		storyMode = new FlxSprite(50, 20);
		storyMode.frames = Paths.getSparrowAtlas('MenuShit/story');
        storyMode.animation.addByPrefix('normal', 'story normal', 48, true);
		storyMode.animation.addByPrefix('selected', 'story selected', 48, true);
		storyMode.scale.x = 0.7;
		storyMode.scale.y = 0.7;
		storyMode.updateHitbox();
		//storyMode.cameras = [camInsidePC];
		// storyMode.alpha = 0.4;
		storyMode.antialiasing = ClientPrefs.globalAntialiasing;
		add(storyMode);

		freeplay = new FlxSprite(50, storyMode.y +130);
		freeplay.frames = Paths.getSparrowAtlas('MenuShit/freeplay');
        freeplay.animation.addByPrefix('normal', 'freeplay normal', 48, true);
		freeplay.animation.addByPrefix('selected', 'freeplay selected', 48, true);
		freeplay.scale.x = 0.7;
		freeplay.scale.y = 0.7;
		freeplay.updateHitbox();
		// freeplay.alpha = 0.4;
		//freeplay.cameras = [camInsidePC];
		freeplay.antialiasing = ClientPrefs.globalAntialiasing;
		add(freeplay);

		mods = new FlxSprite(50, freeplay.y +130);
		mods.frames = Paths.getSparrowAtlas('MenuShit/mods');
        mods.animation.addByPrefix('normal', 'mods normal', 48, true);
		mods.animation.addByPrefix('selected', 'mods selected', 48, true);
		mods.scale.x = 0.7;
		mods.scale.y = 0.7;
		mods.updateHitbox();
		// mods.alpha = 0.4;
		//mods.cameras = [camInsidePC];
		mods.antialiasing = ClientPrefs.globalAntialiasing;
		add(mods);

		credits = new FlxSprite(50, mods.y +130);
		credits.frames = Paths.getSparrowAtlas('MenuShit/credits');
        credits.animation.addByPrefix('normal', 'credits normal', 48, true);
		credits.animation.addByPrefix('selected', 'credits selected', 48, true);
		credits.scale.x = 0.7;
		credits.scale.y = 0.7;
		credits.updateHitbox();
		//credits.cameras = [camInsidePC];
		credits.antialiasing = ClientPrefs.globalAntialiasing;
		add(credits);

		settings = new FlxSprite(50, credits.y +130);
		settings.frames = Paths.getSparrowAtlas('MenuShit/settings');
        settings.animation.addByPrefix('normal', 'settings normal', 48, true);
		settings.animation.addByPrefix('selected', 'settings selected', 48, true);
		settings.scale.x = 0.7;
		settings.scale.y = 0.7;
		settings.updateHitbox();
		// settings.cameras = [camInsidePC];
		settings.antialiasing = ClientPrefs.globalAntialiasing;
		add(settings);

		notes = new FlxSprite(FlxG.width - 150, 20);
		notes.frames = Paths.getSparrowAtlas('MenuShit/notes');
        notes.animation.addByPrefix('normal', 'notes normal', 48, true);
		notes.animation.addByPrefix('selected', 'notes selected', 48, true);
		notes.scale.x = 0.7;
		notes.scale.y = 0.7;
		notes.updateHitbox();
		// storyMode.alpha = 0.4;
		// notes.cameras = [camInsidePC];
		notes.antialiasing = ClientPrefs.globalAntialiasing;
		add(notes);

		folder = new FlxSprite(200, 40).loadGraphic(Paths.image('MenuShit/folder'));
		folder.updateHitbox();
		folder.alpha = 0;
		// folder.cameras = [camInsidePC];
		folder.antialiasing = ClientPrefs.globalAntialiasing;
		add(folder);

		var pcInterfas:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('MenuShit/PCInterfas'));
		pcInterfas.updateHitbox();
		pcInterfas.screenCenter();
		// pcInterfas.cameras = [camInsidePC];
		pcInterfas.antialiasing = ClientPrefs.globalAntialiasing;
		add(pcInterfas);

		pcTime = new FlxText(970, 670, Std.int(FlxG.width * 0.6), "0:00", 25);
        pcTime.setFormat(Paths.font("vcr.ttf"), 25, 0xffffffff);
		pcTime.alpha = 1;
		pcTime.antialiasing = ClientPrefs.globalAntialiasing;
		pcTime.updateHitbox();
		// pcTime.cameras = [camInsidePC];
		add(pcTime);

		pcInside = new FlxSprite(0).loadGraphic(Paths.image('MenuShit/TVinside'));
		pcInside.setGraphicSize(1300, 937);
		pcInside.updateHitbox();
		pcInside.antialiasing = ClientPrefs.globalAntialiasing;
		//pcInside.screenCenter();
		//add(pcInside);

		pcThing = new FlxSprite(0).loadGraphic(Paths.image('MenuShit/HitmansTV'));
		pcThing.setGraphicSize(1300, 937);
		pcThing.updateHitbox();
		// pcThing.cameras = [camPC];
		pcThing.antialiasing = ClientPrefs.globalAntialiasing;
		//pcThing.screenCenter();
		//add(pcThing);

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

		//FlxG.camera.setScrollBoundsRect(0, 0, pcThing.width, pcThing.height, true);
		//FlxG.camera.follow(camFollowPos, FlxCameraFollowStyle.TOPDOWN_TIGHT);
		// camPC.setScrollBoundsRect(0, 0, pcThing.width, pcThing.height, true);
		// camPC.follow(camFollowPos, FlxCameraFollowStyle.TOPDOWN_TIGHT);

		// camInsidePC.setScrollBoundsRect(0, 0, pcThing.width, pcThing.height, true);
		// camInsidePC.follow(camFollowPos, FlxCameraFollowStyle.TOPDOWN_TIGHT);
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

		if (lastDifficultyName == '')
			{
				lastDifficultyName = CoolUtil.defaultDifficulty;
			}
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

		#if (ACHIEVEMENTS_ALLOWED && MODS_ALLOWED)
		Achievements.reloadList();
		#end

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null){
			if (FlxG.sound.music.volume < 0.8)
			{
				FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
				if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
			}
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, FlxG.mouse.x, lerpVal), FlxMath.lerp(camFollowPos.y, FlxG.mouse.y, lerpVal));

		dateThings = DateTools.format(Date.now(), "%Y-%m-%d | %H:%M");

		#if desktop
		// Updating Discord Rich Presence
		if (!inCMD){
			DiscordClient.changePresence("Desktop", null);
		}
		#end

		if (!selectedSomethin)
		{
			/*if (controls.UI_UP_P && !inCMD)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P && !inCMD)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}*/

			if (controls.BACK && !inCMD)
			{
				if (!inFolder){
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new TitleState());
				}else{
					storyMode.animation.play('normal');
					freeplay.animation.play('normal');
					mods.animation.play('normal');
					credits.animation.play('normal');
					settings.animation.play('normal');
					notes.animation.play('normal');
				}
			}
			if (!inFolder){
				if (FlxG.mouse.overlaps(storyMode)) {
					if (FlxG.mouse.justPressed) {
						new FlxTimer().start(1, function(tmrS:FlxTimer)
						{
							MusicBeatState.switchState(new StoryMenuState());
						});
						storyMode.animation.play('selected');
						freeplay.animation.play('normal');
						mods.animation.play('normal');
						credits.animation.play('normal');
						settings.animation.play('normal');
						notes.animation.play('normal');
					}
				}
				if (FlxG.mouse.overlaps(freeplay)) {
					if (FlxG.mouse.justPressed) {
						new FlxTimer().start(1, function(tmrF:FlxTimer)
							{
								MusicBeatState.switchState(new FreeplayState());
							});
						freeplay.animation.play('selected');
						storyMode.animation.play('normal');
						mods.animation.play('normal');
						credits.animation.play('normal');
						settings.animation.play('normal');
						notes.animation.play('normal');
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
						mods.animation.play('selected');
						storyMode.animation.play('normal');
						freeplay.animation.play('normal');
						credits.animation.play('normal');
						settings.animation.play('normal');
						notes.animation.play('normal');
					}
				}
				if (FlxG.mouse.overlaps(credits)) {
					if (FlxG.mouse.justPressed) {
						new FlxTimer().start(1, function(tmrC:FlxTimer)
							{
								MusicBeatState.switchState(new CreditsState());
							});
						credits.animation.play('selected');
						storyMode.animation.play('normal');
						freeplay.animation.play('normal');
						mods.animation.play('normal');
						settings.animation.play('normal');
						notes.animation.play('normal');
					}
				}
				if (FlxG.mouse.overlaps(settings)) {
					if (FlxG.mouse.justPressed) {
						new FlxTimer().start(1, function(tmrSe:FlxTimer)
							{
								openSubState(new OptionsMenu());
							});
						inFolder = true;
						settings.animation.play('selected');
						storyMode.animation.play('normal');
						freeplay.animation.play('normal');
						mods.animation.play('normal');
						credits.animation.play('normal');
						notes.animation.play('normal');
					}
				}
				// if (FlxG.mouse.overlaps(notes)) {
				// 	if (FlxG.mouse.justPressed) {
				// 		new FlxTimer().start(1, function(tmrSe:FlxTimer)
				// 			{
				// 				MusicBeatState.switchState(new options.NoteColorState());
				// 			});
				// 		//inFolder = true;
				// 		notes.animation.play('selected');
				// 		settings.animation.play('normal');
				// 		storyMode.animation.play('normal');
				// 		freeplay.animation.play('normal');
				// 		mods.animation.play('normal');
				// 		credits.animation.play('normal');
				// 	}
				// }
			}

			// if (controls.ACCEPT && !inCMD && !inFolder)
			// {
			// 	if (optionShit[curSelected] == 'donate')
			// 	{
			// 		// CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
			// 	}
			// 	else
			// 	{
			// 		selectedSomethin = true;
			// 		FlxG.sound.play(Paths.sound('confirmMenu'));

			// 		menuItems.forEach(function(spr:FlxSprite)
			// 		{
			// 			if (curSelected != spr.ID)
			// 			{
			// 				FlxTween.tween(spr, {alpha: 0}, 0.4, {
			// 					ease: FlxEase.quadOut,
			// 					onComplete: function(twn:FlxTween)
			// 					{
			// 						spr.kill();
			// 					}
			// 				});
			// 			}
			// 			else
			// 			{
			// 				FlxFlicker.flicker(spr, 0.05, 0.05, false, false, function(flick:FlxFlicker)
			// 				{
			// 					var daChoice:String = optionShit[curSelected];

			// 					switch (daChoice)
			// 					{
			// 						case 'story_mode':
			// 							MusicBeatState.switchState(new StoryMenuState());
			// 						case 'freeplay':
			// 							MusicBeatState.switchState(new FreeplayState());
			// 						#if MODS_ALLOWED
			// 						case 'mods':
			// 							MusicBeatState.switchState(new ModsMenuState());
			// 						#end
			// 						#if ACHIEVEMENTS_ALLOWED
			// 						case 'awards':
			// 							MusicBeatState.switchState(new AchievementsMenuState());
			// 						#end
			// 						case 'credits':
			// 							MusicBeatState.switchState(new CreditsState());
			// 						case 'options':
			// 							LoadingState.loadAndSwitchState(new options.OptionsMenuState());
			// 					}
			// 				});
			// 			}
			// 		});
			// 	}
			// }
			if (FlxG.keys.justPressed.CONTROL && !selectedSomethin && !inCMD && !inFolder)
			{
				inCMD = true;
				openSubState(new CommandPromptSubstate());
			}
			if (FlxG.keys.justPressed.ONE && !selectedSomethin && !inCMD && !inFolder)
			{
				MusicBeatState.switchState(new NewFreeplay());
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys) && !inCMD)
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
