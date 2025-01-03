package;

import Discord;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;

import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxTimer;
import flixel.util.FlxStringUtil;

using StringTools;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Resume', 'Restart Song', 'Change Difficulty', 'Options', 'Gameplay Modifiers', 'Exit to menu'];
	var difficultyChoices = [];
	var curSelected:Int = 0;
	var unPauseTimer:FlxTimer;

	public static var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);

	var countdownGet:FlxSprite;
	var countdownReady:FlxSprite;
	var countdownSet:FlxSprite;
	var countdownGo:FlxSprite;

	var inCountDown:Bool = false;

	var antialias:Bool = ClientPrefs.globalAntialiasing;
	public var notes:FlxTypedGroup<Note>;

	public static var goToOptions:Bool = false;
    public static var goBack:Bool = false;
	//var botplayText:FlxText;

	var missingTextBG:FlxSprite;
	var missingText:FlxText;
	public static var songName:String = '';

	public static var goToModifiers:Bool = false;
    public static var goBackToPause:Bool = false;

	public function new(x:Float, y:Float)
	{
		super();
		if(CoolUtil.difficulties.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!

		if(PlayState.checkpointHistory.length > 0) //must add the "restartFromCheckpoint" option if there is a checkpoint inside song ig?
		{
			menuItemsOG.insert(3, 'Restart From Checkpoint');
		}
		if(PlayState.chartingMode)
		{
			menuItemsOG.insert(2, 'Leave Charting Mode');
			
			var num:Int = 0;
			if(!PlayState.instance.startingSong)
			{
				num = 1;
				menuItemsOG.insert(4, 'Skip Time');
			}
			menuItemsOG.insert(4 + num, 'End Song');
			menuItemsOG.insert(5 + num, 'Toggle Practice Mode');
			menuItemsOG.insert(6 + num, 'Toggle Botplay');
		}
		menuItems = menuItemsOG;

		for (i in 0...CoolUtil.difficulties.length) {
			var diff:String = '' + CoolUtil.difficulties[i];
			difficultyChoices.push(diff);
		}
		difficultyChoices.push('BACK');

		if (pauseMusic != null)
		{
			pauseMusic = null;
		}

		pauseMusic = new FlxSound();
		try
		{
			var pauseSong:String = getPauseSong();
			if(pauseSong != null) pauseMusic.loadEmbedded(Paths.music(pauseSong), true, true);
		} catch(e:Dynamic) {}
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 64, 0, "", 32);
		blueballedTxt.text = "Deaths: " + PlayState.deathCounter;
		blueballedTxt.scrollFactor.set();
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		blueballedTxt.updateHitbox();
		add(blueballedTxt);

		practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(20, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = PlayState.chartingMode;
		add(chartingText);

		var notITGText:FlxText = new FlxText(20, 15 + 101, 0, "MODCHART DISABLED", 32);
		notITGText.scrollFactor.set();
		notITGText.setFormat(Paths.font('vcr.ttf'), 32);
		notITGText.x = FlxG.width - (notITGText.width + 20);
		notITGText.y = FlxG.height - (notITGText.height + 60);
		notITGText.updateHitbox();
		notITGText.visible = !PlayState.instance.notITGMod;
		add(chartingText);

		blueballedTxt.alpha = 0;
		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);

		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

		addCameraOverlay();
		regenMenu();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.indexOf(PlayState.instance.camOther)]];
	}

	function getPauseSong()
	{
		var formattedSongName:String = (songName != null ? Paths.formatToSongPath(songName) : '');
		var formattedPauseMusic:String = Paths.formatToSongPath(ClientPrefs.pauseMusic);
		if(formattedSongName == 'none' || (formattedSongName != 'none' && formattedPauseMusic == 'none')) return null;

		return (formattedSongName != '') ? formattedSongName : formattedPauseMusic;
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;

	var stoppedUpdatingMusic:Bool = false;
	override function update(elapsed:Float)
	{
		cantUnpause -= elapsed;
		if (!stoppedUpdatingMusic){ //Reason to no put != null outside is to not confuse the game to not "stop" when intended.
			if (pauseMusic != null && pauseMusic.volume < 0.5)
				pauseMusic.volume += 0.01 * elapsed;
		}else{
			if (pauseMusic != null)
				pauseMusic.volume = 0;
		}

		super.update(elapsed);
		updateSkipTextStuff();

		if (!inCountDown)
		{
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			var accepted = controls.ACCEPT;

			if (upP)
			{
				changeSelection(-1);
			}
			if (downP)
			{
				changeSelection(1);
			}

			var daSelected:String = menuItems[curSelected];
			switch (daSelected)
			{
				case 'Skip Time':
					if (controls.UI_LEFT_P)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
						curTime -= 1000;
						holdTime = 0;
					}
					if (controls.UI_RIGHT_P)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
						curTime += 1000;
						holdTime = 0;
					}

					if(controls.UI_LEFT || controls.UI_RIGHT)
					{
						holdTime += elapsed;
						if(holdTime > 0.5)
						{
							curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
						}

						if(curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
						else if(curTime < 0) curTime += FlxG.sound.music.length;
						updateSkipTimeText();
					}
			}

			if (accepted && (cantUnpause <= 0 || !ClientPrefs.controllerMode))
			{
				if (menuItems == difficultyChoices)
				{
					try{
						if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {

							var name:String = PlayState.SONG.song;
							var poop = Highscore.formatSong(name, curSelected);
							Song.loadFromJson(poop, name);
							PlayState.storyDifficulty = curSelected;
							MusicBeatState.resetState();
							FlxG.sound.music.volume = 0;
							PlayState.changedDifficulty = true;
							PlayState.chartingMode = false;
							PlayState.resetPlayData();
							return;
						}					
					}catch(e:Dynamic){
						trace('ERROR! $e');

						var errorStr:String = e.toString();
						if(errorStr.startsWith('[file_contents,assets/data/')) errorStr = 'Missing file: ' + errorStr.substring(27, errorStr.length-1); //Missing chart
						missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
						missingText.screenCenter(Y);
						missingText.visible = true;
						missingTextBG.visible = true;
						FlxG.sound.play(Paths.sound('cancelMenu'));

						super.update(elapsed);
						return;
					}

					menuItems = menuItemsOG;
					regenMenu();
				}

				switch (daSelected)
				{
					case "Resume":
						inCountDown = true;
						hideCameraOverlay(true);
						unPauseTimer = new FlxTimer().start(Conductor.crochet / 1000, function(hmmm:FlxTimer)
						{
							if (unPauseTimer.loopsLeft == 4)
							{
								pauseCountDown('3');
							}
							else if (unPauseTimer.loopsLeft == 3)
							{
								pauseCountDown('2');
							}
							else if (unPauseTimer.loopsLeft == 2)
							{
								pauseCountDown('1');
							}
							else if (unPauseTimer.loopsLeft == 1)
							{
								pauseCountDown('go');
							}
							else if (unPauseTimer.finished && unPauseTimer.loopsLeft == 0)
							{
								PlayState.instance.modchartTimers.remove('hmmm');
								if (PlayState.SONG.song.toLowerCase() == "cyber" && PlayState.storyDifficulty != 0)
									PlayWindow.reset();
								close();
							}
						}, 5);
						pauseMusic.volume = 0;
						pauseMusic.destroy();
						pauseMusic = null;
						menuItems = [];
						deleteSkipTimeText();
						stoppedUpdatingMusic = true;
						regenMenu();
					case 'Restart From Checkpoint':
						if(PlayState.checkpointHistory.length > 0){
							FlxG.mouse.visible = false;
							PlayState.seenCutscene = true; //Keep this the same tho
							restartSong(false, true);
						}else{
							FlxG.sound.play(Paths.sound('cancelMenu')); //in case it still spawns don't crash the song
						}
					case 'Change Difficulty':
						menuItems = difficultyChoices;
						deleteSkipTimeText();
						regenMenu();
					case 'Toggle Practice Mode':
						PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
						PlayState.changedDifficulty = true;
						practiceText.visible = PlayState.instance.practiceMode;
					case "Restart Song":
						restartSong(false, true);
						PlayState.resetPlayData();
					case "Leave Charting Mode":
						restartSong(false, true);
						PlayState.chartingMode = false;
					case 'Skip Time':
						if(curTime < Conductor.songPosition)
						{
							PlayState.startOnTime = curTime;
							restartSong(true);
						}
						else
						{
							if (curTime != Conductor.songPosition)
							{
								PlayState.instance.clearNotesBefore(curTime);
								PlayState.instance.setSongTime(curTime);
							}
							pauseMusic.stop();
							close();
						}
					case "End Song":
						close();
						PlayState.instance.finishSong(true);
						PlayState.resetPlayData();
					case 'Toggle Botplay':
						PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
						PlayState.changedDifficulty = true;
						PlayState.instance.hitmansHUD.botplayTxt.visible = PlayState.instance.cpuControlled;
						PlayState.instance.hitmansHUD.botplayTxt.alpha = 1;
						PlayState.instance.hitmansHUD.botplaySine = 0;
					case 'Options':
						stoppedUpdatingMusic = true;
						pauseMusic.volume = 0;
						pauseMusic.destroy();
						goToOptions = true;
						close();
					case 'Gameplay Modifiers':
						goToModifiers = true;
						pauseMusic.volume = 0;
						pauseMusic.destroy();
						close();
					case "Exit to menu":
						#if desktop DiscordClient.resetClientID(); #end
						PlayState.deathCounter = 0;
						PlayState.seenCutscene = false;

						stoppedUpdatingMusic = true;
						pauseMusic.volume = 0;
						pauseMusic.destroy();

						Mods.loadTopMod();
						if(PlayState.isStoryMode) {
							MusicBeatState.switchState(new StoryMenuState());
						} else {
							MusicBeatState.switchState(new FreeplayState());
						}
						PlayState.cancelMusicFadeTween();
						FlxG.sound.playMusic(Paths.music('bloodstained'));
						PlayState.changedDifficulty = false;
						PlayState.chartingMode = false;
						PlayState.resetPlayData();
				}
			}
		}
	}

	function pauseCountDown(Number:String)
	{
		var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
		introAssets.set('default', ['get', 'ready', 'set', 'go']);

		var introAlts:Array<String> = introAssets.get('default');

		switch (Number)
		{
			case '3':
				countdownGet = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
				countdownGet.scrollFactor.set();
				countdownGet.updateHitbox();
				countdownGet.screenCenter();
				add(countdownGet);
				FlxTween.tween(countdownGet, {/*y: countdownGet.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						remove(countdownGet);
						countdownGet.destroy();
					}
				});
				FlxG.sound.play(Paths.sound('intro3'), 1);
					
			case '2':
				countdownReady = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
				countdownReady.scrollFactor.set();
				countdownReady.updateHitbox();
				countdownReady.screenCenter();
				add(countdownReady);
				FlxTween.tween(countdownReady, {/*y: countdownReady.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						remove(countdownReady);
						countdownReady.destroy();
					}
				});
				FlxG.sound.play(Paths.sound('intro2'), 1);
			case '1':
				countdownSet = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
				countdownSet.scrollFactor.set();
				countdownSet.updateHitbox();
				countdownSet.screenCenter();
				add(countdownSet);
				FlxTween.tween(countdownSet, {/*y: countdownSet.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						remove(countdownSet);
						countdownSet.destroy();
					}
				});
				FlxG.sound.play(Paths.sound('intro1'), 1);
			case 'go':
				countdownGo = new FlxSprite().loadGraphic(Paths.image(introAlts[3]));
				countdownGo.scrollFactor.set();
				countdownGo.updateHitbox();
				countdownGo.screenCenter();
				add(countdownGo);
				FlxTween.tween(countdownGo, {/*y: countdownGo.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						remove(countdownGo);
						countdownGo.destroy();
					}
				});
				FlxG.sound.play(Paths.sound('introGo'), 1);
		}
	}

	function deleteSkipTimeText()
	{
		if(skipTimeText != null)
		{
			skipTimeText.kill();
			remove(skipTimeText);
			skipTimeText.destroy();
		}
		skipTimeText = null;
		skipTimeTracker = null;
	}

	public static function restartSong(noTrans:Bool = false, ?isReset:Bool = false)
	{
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			if (!isReset)
				MusicBeatState.resetState();
			else
				LoadingState.loadAndSwitchState(new PlayState(), true, true, 0.5);
		}
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));

				if(item == skipTimeTracker)
				{
					curTime = Math.max(0, Conductor.songPosition);
					updateSkipTimeText();
				}
			}
		}
	}

	function regenMenu():Void {
		for (i in 0...grpMenuShit.members.length) {
			var obj = grpMenuShit.members[0];
			obj.kill();
			grpMenuShit.remove(obj, true);
			obj.destroy();
		}

		for (i in 0...menuItems.length) {
			var item = new Alphabet(90, 320, menuItems[i], true);
			item.isMenuItem = true;
			item.targetY = i;
			grpMenuShit.add(item);

			if(menuItems[i] == 'Skip Time')
			{
				skipTimeText = new FlxText(0, 0, 0, '', 64);
				skipTimeText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				skipTimeText.scrollFactor.set();
				skipTimeText.borderSize = 2;
				skipTimeTracker = item;
				add(skipTimeText);

				updateSkipTextStuff();
				updateSkipTimeText();
			}
		}
		curSelected = 0;
		changeSelection();
	}
	
	function updateSkipTextStuff()
	{
		if(skipTimeText == null || skipTimeTracker == null) return;

		skipTimeText.x = skipTimeTracker.x + skipTimeTracker.width + 60;
		skipTimeText.y = skipTimeTracker.y;
		skipTimeText.visible = (skipTimeTracker.alpha >= 1);
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}