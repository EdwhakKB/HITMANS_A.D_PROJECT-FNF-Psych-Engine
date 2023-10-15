package;

import flixel.system.FlxSound;
import flixel.input.FlxInput;
import flixel.util.FlxAxes;
import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;
import MainMenuState;
import FreeplayState;
import LoadingState;
import OFLSprite;
import Highscore;
import WeekData;
import Ratings;
import HelperFunctions;
import flixel.FlxCamera;
import HitGraph;
import Note;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import editors.ChartingState;
import Controls.Control;
import openfl.ui.Keyboard;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxSave;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSubState;
import flixel.input.FlxKeyManager;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class ResultsScreenKade extends MusicBeatSubstate
{
	public var background:FlxSprite;
	public var text:FlxText;

	public var graph:HitGraph;
	public var graphSprite:OFLSprite;

	public var comboText:FlxText;
	public var contText:FlxText;
	public var settingsText:FlxText;

	public var songText:FlxText;
	public var music:FlxSound;

	public var modifiers:String;

	public var activeMods:FlxText;

	public var superMegaConditionShit:Bool;

	public static var instance:ResultsScreenKade = null;

	private var game:PlayState = PlayState.instance;

	public var end:Void->Void;

	var ended:Bool = false;

	public function new()
	{
		super();
		instance = this;

		openCallback = refresh;

		background = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		background.scrollFactor.set();

		if (!PlayState.isStoryMode)
		{
			modifiers = 'Active Modifiers:\n${(HelperFunctions.truncateFloat(game.healthLoss,2) != 1 ? '- HP Loss ${HelperFunctions.truncateFloat(game.healthLoss, 2)}x\n':'')}${(game.instakillOnMiss ? '- No Misses mode\n' : '')}${(game.practiceMode ? '- Practice Mode\n' : '')}${(game.notITGMod ? '- Modchart\n' : '')}${(game.cpuControlled ? '- Botplay\n' : '')}${(HelperFunctions.truncateFloat(game.healthGain,2) != 1 ? '- HP Gain ${HelperFunctions.truncateFloat(game.healthGain, 2)}x\n': '')}';
			if (modifiers == 'Active Modifiers:\n')
				modifiers = 'Active Modifiers: None';
			activeMods = new FlxText(FlxG.width - 500, FlxG.height - 450, FlxG.width, modifiers);
			activeMods.size = 24;
			activeMods.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
			activeMods.scrollFactor.set();
		}

		text = new FlxText(20, -55, 0, "Song Cleared!");
		text.size = 34;
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		text.color = FlxColor.WHITE;
		text.scrollFactor.set();

		if (PlayState.isStoryMode)
		{
			text.text = 'Week Cleared on ${game.storyDifficultyText.toUpperCase()}!';
		}
		comboText = new FlxText(20, -75, 0, '');

		if (!PlayState.isStoryMode)
		{
			songText = new FlxText(20, -65, FlxG.width,
				'Played on ${PlayState.SONG.song} - [${CoolUtil.difficultyString().toLowerCase()}]');
			songText.size = 34;
			songText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
			songText.color = FlxColor.WHITE;
			songText.scrollFactor.set();
		}

		comboText.size = 28;
		comboText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		comboText.color = FlxColor.WHITE;
		comboText.scrollFactor.set();

		contText = new FlxText(FlxG.width - 525, FlxG.height + 50, 0, 'Click or Press ENTER to continue.');

		contText.size = 24;
		contText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		contText.color = FlxColor.WHITE;
		contText.scrollFactor.set();

		graph = new HitGraph(FlxG.width - 600, 45, 525, 180);

		settingsText = new FlxText(20, FlxG.height + 50, 0, '');
		settingsText.size = 16;
		settingsText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2, 1);
		settingsText.color = FlxColor.WHITE;
		settingsText.scrollFactor.set();

		/*if (onResults)
			startResults();*/
	}

	var camResults:FlxCamera;
	var mean:Float = 0;

	override public function create()
	{
		camResults = new FlxCamera();
		FlxG.cameras.add(camResults, false);
        //FlxCamera.defaultCameras = [camResults];
		FlxG.cameras.setDefaultDrawTarget(camResults, true);

		music = new FlxSound().loadEmbedded(Paths.inst(PlayState.SONG.song), true, true);
		music.volume = 0;

		add(background);
		if (PlayState.inResultsScreen)
		{
			music.pitch = game.playbackRate;
			music.play(false, FlxG.random.int(0, Std.int(music.length / 2)));
			FlxG.sound.list.add(music);
		}

		add(activeMods);

		background.alpha = 0;

		add(text);

		if (!PlayState.isStoryMode)
			add(songText);

		var score = game.songScore;
		var acc = game.updateAcc;

		if (PlayState.isStoryMode)
		{
			acc = PlayState.campaignAccuracy;
			score = PlayState.campaignScore;
		}

		var marvelouss = PlayState.isStoryMode ? PlayState.campaignMarvelouss : PlayState.marvelouss;
		var sicks = PlayState.isStoryMode ? PlayState.campaignSicks : PlayState.sicks;
		var goods = PlayState.isStoryMode ? PlayState.campaignGoods : PlayState.goods;
		var bads = PlayState.isStoryMode ? PlayState.campaignBads : PlayState.bads;
		var shits = PlayState.isStoryMode ? PlayState.campaignShits : PlayState.shits;

		comboText.text = 'Judgements:\nSwags - ${marvelouss}\nSicks - ${sicks}\nGoods - ${goods}\nBads - ${bads}\nShits - ${shits}\n\nCombo Breaks: ${PlayState.isStoryMode ? PlayState.campaignMisses : game.songMisses}\nScore: $score\n${PlayState.isStoryMode ? 'Average Accuracy' : 'Accuracy'}: ${acc}% \nRank: ${game.ratingFC} \nRate: ${game.playbackRate}x\n\nH - Replay song';

		add(comboText);

		#if mobile
		contText.text = "Touch to continue";
		#end

		add(contText);

		graph.update();

		graphSprite = new OFLSprite(graph.xPos, graph.yPos, Std.int(graph._width), Std.int(graph._rectHeight), graph);
		FlxSpriteUtil.drawRect(graphSprite, 0, 0, graphSprite.width, graphSprite.height, FlxColor.TRANSPARENT, {thickness: 1.5, color: FlxColor.WHITE});

		graphSprite.scrollFactor.set();
		graphSprite.alpha = 0;

		add(graphSprite);

		var marvelouss = HelperFunctions.truncateFloat(PlayState.marvelouss / PlayState.sicks, 1);
		var sicks = HelperFunctions.truncateFloat(PlayState.sicks / PlayState.goods, 1);
		var goods = HelperFunctions.truncateFloat(PlayState.goods / PlayState.bads, 1);

		if (marvelouss == Math.POSITIVE_INFINITY)
			marvelouss = 0;
		if (sicks == Math.POSITIVE_INFINITY)
			sicks = 0;
		if (goods == Math.POSITIVE_INFINITY)
			goods = 0;

		if (marvelouss == Math.POSITIVE_INFINITY || marvelouss == Math.NaN)
			marvelouss = 0;
		if (sicks == Math.POSITIVE_INFINITY || sicks == Math.NaN)
			sicks = 0;
		if (goods == Math.POSITIVE_INFINITY || goods == Math.NaN)
			goods = 0;

		var legitTimings:Bool = true;
		for (rating in Ratings.timingWindows)
		{
			if (rating.timingWindow != rating.defaultTimingWindow)
			{
				legitTimings = false;
				break;
			}
		}

		superMegaConditionShit = legitTimings
			&& game.notITGMod
			&& !game.cpuControlled
			&& !game.practiceMode
			&& !PlayState.chartingMode
			&& HelperFunctions.truncateFloat(game.healthGain, 2) <= 1
			&& HelperFunctions.truncateFloat(game.healthLoss, 2) >= 1;

		if (superMegaConditionShit)
		{
			var percent:Float = game.ratingPercent;
			if(Math.isNaN(percent)) percent = 0;
			Highscore.saveScore(PlayState.SONG.song, game.songScore, PlayState.storyDifficulty, percent);
		}

		mean = HelperFunctions.truncateFloat(mean / game.playerNotes, 2);
		var acceptShit:String = (superMegaConditionShit ? '| Accepted' : '| Rejected');

		#if debug
		acceptShit = '| Debug';
		#end

		if (PlayState.isStoryMode)
			acceptShit = '';

		settingsText.text = 'Mean: ${mean}ms (';
		var reverseWins = Ratings.timingWindows.copy();
		reverseWins.reverse();
		for (i in 0...reverseWins.length)
		{
			var timing = reverseWins[i];
			settingsText.text += '${timing.name.toUpperCase()}:${timing.timingWindow}ms';
			if (i != reverseWins.length - 1)
				settingsText.text += ',';
		}
		settingsText.text += ') $acceptShit';

		add(settingsText);

		FlxTween.tween(background, {alpha: 0.5}, 1.4);
		if (!PlayState.isStoryMode)
		{
			FlxTween.tween(songText, {y: 65}, 1.4, {ease: FlxEase.expoInOut});
		}
		FlxTween.tween(activeMods, {y: FlxG.height - 400}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(text, {y: 20}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(comboText, {y: 145}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(contText, {y: FlxG.height - 70}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(settingsText, {y: FlxG.height - 35}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(graphSprite, {alpha: 1}, 1.4, {ease: FlxEase.expoInOut});

		//cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var frames = 0;

	override function update(elapsed:Float)
	{
		if (music != null && PlayState.inResultsScreen)
			if (music.volume < 0.8)
				music.volume += 0.04 * elapsed;

		// keybinds

		if ((controls.ACCEPT || FlxG.mouse.pressed) && PlayState.inResultsScreen)
		{
			ended = true;
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.changedDifficulty = false;
			PlayState.inResultsScreen = false; //just to make sure it allows countDown again lmao
			
			if (PlayState.chartingMode)
			{
				persistentUpdate = false;
				PlayState.instance.paused = true;
				PlayState.cancelMusicFadeTween();
				MusicBeatState.switchState(new ChartingState());
				PlayState.chartingMode = true;
			
				#if desktop
					DiscordClient.changePresence("Chart Editor", null, null, true);
				#end
				return;
			}

			FlxG.sound.play(Paths.sound('scrollMenu'));
			PlayState.cancelMusicFadeTween();
			if (music != null)
				music.fadeOut(0.3, 0, { 
					onComplete ->
					{
						if(PlayState.isStoryMode)
						{
							PlayState.campaignScore += PlayState.instance.songScore;
							PlayState.campaignMisses += PlayState.weekMisses;
	
							PlayState.storyPlaylist.remove(PlayState.storyPlaylist[0]);
	
							if (PlayState.storyPlaylist.length <= 0)
							{
								WeekData.loadTheFirstEnabledMod();
								FlxG.sound.playMusic(Paths.music('freakyMenu'));
								#if desktop DiscordClient.resetClientID(); #end
								PlayState.cancelMusicFadeTween();
								if(FlxTransitionableState.skipNextTransIn) {
									CustomFadeTransition.nextCamera = null;
								}
								MusicBeatState.switchState(new StoryMenuState());
	
								if(!ClientPrefs.getGameplaySetting('practice', false) && !ClientPrefs.getGameplaySetting('botplay', false)  && !ClientPrefs.getGameplaySetting('modchart', true)) {
									StoryMenuState.weekCompleted.set(WeekData.weeksList[PlayState.storyWeek], true);
	
									if (PlayState.SONG.validScore)
									{
										Highscore.saveWeekScore(WeekData.getWeekFileName(), PlayState.campaignScore, PlayState.storyDifficulty);
									}
	
									FlxG.save.data.weekCompleted = StoryMenuState.weekCompleted;
									FlxG.save.flush();
								}
								PlayState.changedDifficulty = false;
							}
							else
							{
								var difficulty:String = CoolUtil.getDifficultyFilePath();
	
								trace('LOADING NEXT SONG');
								trace(Paths.formatToSongPath(PlayState.storyPlaylist[0]) + difficulty);	
	
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
	
								PlayState.prevCamFollow = PlayState.instance.camFollow;
								PlayState.prevCamFollowPos = PlayState.instance.camFollowPos;
	
								PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0] + difficulty, PlayState.storyPlaylist[0]);
								FlxG.sound.music.stop();
	
								PlayState.cancelMusicFadeTween();
								LoadingState.loadAndSwitchState(new PlayState());
							}
						}else{
							MusicBeatState.switchState(new FreeplayState());
						}
						FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
						FlxG.sound.music.fadeIn(4, 0, 0.7);
						MusicBeatState.switchState(new FreeplayState());
						ended = false;
					}
				});
		}

		if (FlxG.keys.justPressed.H && PlayState.inResultsScreen)
		{
			ended = true;
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.changedDifficulty = false;
			PlayState.inResultsScreen = false; //just to make sure it allows countDown again lmao
			
			if (PlayState.chartingMode)
			{
				persistentUpdate = false;
				PlayState.instance.paused = true;
				PlayState.cancelMusicFadeTween();
				MusicBeatState.switchState(new ChartingState());
				PlayState.chartingMode = true;
			
				#if desktop
					DiscordClient.changePresence("Chart Editor", null, null, true);
				#end
				return;
			}

			FlxG.sound.play(Paths.sound('scrollMenu'));
			PlayState.cancelMusicFadeTween();
			if (music != null)
				music.fadeOut(0.3, 0, {
					onComplete ->
					{	
						if(PlayState.isStoryMode)
						{
							PlayState.campaignScore += PlayState.instance.songScore;
							PlayState.campaignMisses += PlayState.weekMisses;
	
							PlayState.storyPlaylist.remove(PlayState.storyPlaylist[0]);
	
							if (PlayState.storyPlaylist.length <= 0)
							{
								WeekData.loadTheFirstEnabledMod();
								FlxG.sound.playMusic(Paths.music('freakyMenu'));
								#if desktop DiscordClient.resetClientID(); #end
								PlayState.cancelMusicFadeTween();
								if(FlxTransitionableState.skipNextTransIn) {
									CustomFadeTransition.nextCamera = null;
								}
								MusicBeatState.switchState(new StoryMenuState());
	
								if(!ClientPrefs.getGameplaySetting('practice', false) && !ClientPrefs.getGameplaySetting('botplay', false)  && !ClientPrefs.getGameplaySetting('modchart', true)) {
									StoryMenuState.weekCompleted.set(WeekData.weeksList[PlayState.storyWeek], true);
	
									if (PlayState.SONG.validScore)
									{
										Highscore.saveWeekScore(WeekData.getWeekFileName(), PlayState.campaignScore, PlayState.storyDifficulty);
									}
	
									FlxG.save.data.weekCompleted = StoryMenuState.weekCompleted;
									FlxG.save.flush();
								}
								PlayState.changedDifficulty = false;
							}
							else
							{
								var difficulty:String = CoolUtil.getDifficultyFilePath();
	
								trace('LOADING NEXT SONG');
								trace(Paths.formatToSongPath(PlayState.storyPlaylist[0]) + difficulty);
	
	
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
	
								PlayState.prevCamFollow = PlayState.instance.camFollow;
								PlayState.prevCamFollowPos = PlayState.instance.camFollowPos;
	
								PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0] + difficulty, PlayState.storyPlaylist[0]);
								FlxG.sound.music.stop();
	
								PlayState.cancelMusicFadeTween();
								LoadingState.loadAndSwitchState(new PlayState());
							}
						}else{
							MusicBeatState.switchState(new FreeplayState());
						}
						FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
						FlxG.sound.music.fadeIn(4, 0, 0.7);
						MusicBeatState.switchState(new FreeplayState());
						ended = false;
					}
				});
		}

		super.update(elapsed);
	}

	public function registerHit(note:Note, isMiss:Bool = false, isBotPlay:Bool = false, missNote:Float)
	{
		var noteRating = note.rating;
		var noteDiff = note.strumTime - Conductor.songPosition;
		var noteStrumTime = note.strumTime;

		if (isMiss)
			noteDiff = missNote;

		if (isBotPlay)
			noteDiff = 0;
		// judgement

		if (noteDiff != missNote)
			mean += noteDiff;

		graph.addToHistory(noteDiff, noteRating, noteStrumTime);
	}

	override function destroy()
	{
		instance = null;
		graph.destroy();
		graph = null;
		graphSprite.destroy();
		super.destroy();
	}

	private function refresh()
	{	
	}
}
