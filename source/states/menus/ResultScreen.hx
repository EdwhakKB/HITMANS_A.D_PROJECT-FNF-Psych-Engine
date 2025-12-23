package states.menus;

import openfl.ui.Keyboard;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxSave;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSubState;
import flixel.input.FlxKeyManager;
import haxe.ds.StringMap;
import flixel.addons.transition.FlxTransitionableState;
import editors.ChartingState;

class ResultScreen extends MusicBeatSubstate
{
	private var camRate:FlxCamera;

	var bgFade:FlxSprite;
	var background:FlxSprite;
	var topUp:FlxSprite;
	var topDown:FlxSprite;
	var numbers:FlxText;

	var gameInstance:PlayState = PlayState.instance;
	var game:PlayState;

	var song:FlxText;

	public static var rsNoteData:StringMap<Dynamic> = new StringMap();

	var ratingColours = {
		marvelous: 0xFF00CCFF,
		sick: 0xFFFFE600,
		good: 0xFF00B400,
		bad: 0xFF8C00FF,
		shit: 0xFFFF4800,
		miss: 0xFFFF0000
	}

	var result:Float;
	var colorChoosen:FlxColor;
	var note:FlxSprite;

	var onDiffMode:Bool = false;
	public static var noteId:Int = -1;

	var newBest:FlxText;
	var acctxt:FlxText;
	var comtxt:FlxText;

	var hitGraphBG:FlxSprite;
	var zeroMs:FlxText;
	var topMs:FlxText;
	var bottomMs:FlxText;

	var music:FlxSound;

	var fantastictxt:FlxText;
	var excelenttxt:FlxText;
	var greattxt:FlxText;
	var wayofftxt:FlxText;
	var decenttxt:FlxText;
	var misstxt:FlxText;

	var rating:FlxSprite;

	var ranking:FlxText;

	var panel:FlxSprite;

	var lerpscore:Int = 0;
	var lerpacc:Float = 0;
	var lerpcom:Int = 0;

	var dascore:Int;
	var daacc:Float;
	var dacom:Int;
	var daBest:Int;

	var character:FlxSprite;
	var noModchart:FlxSprite;

	var ended:Bool = false;

	var theEnemy:String = '';
	var imagenPath:String = 'hitmans/vs/';
	var imagePH:String = 'placeHolder';

	public var end:Void->Void;

	public function new(score:Int, oldBest:Int, maxc:Int, acc:Float, fantastic:Int, excelent:Int, great:Int, decent:Int, wayoff:Int, miss:Int)
	{
		super();

		camRate = new FlxCamera();
		FlxG.cameras.add(camRate, false);
		FlxG.cameras.setDefaultDrawTarget(camRate, false);

		dascore = score;
		daacc = acc;
		dacom = maxc;
		daBest = oldBest;

		background = new FlxSprite(0,0).loadGraphic(Paths.getPath('images/rating/wallPaper.png', IMAGE));
		background.alpha = 1;
		add(background);

		panel = new FlxSprite(30, 160).loadGraphic(Paths.getPath('images/Edwhak/Hitmans/gameOver/DeathPanel.png', IMAGE));
        panel.scale.y = 1;
        panel.scale.x = 1;
        panel.antialiasing = ClientPrefs.data.antialiasing;
        add(panel);

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFF000000);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0.7;
		add(bgFade);
	

		switch(gameInstance.dad.curCharacter.toLowerCase()){
			case 'edwhak':
				theEnemy = "edwhak";
			case 'he':
				theEnemy = "edwhak";
			case 'edwhakbroken':
				theEnemy = "edwhak";
			case 'edkbmassacre':
				theEnemy = "edwhak";
			default:
				theEnemy = gameInstance.dad.curCharacter.toLowerCase();
		}

		character = new FlxSprite();
		character.loadGraphic(Paths.image(imagenPath+theEnemy));
		if(character.graphic == null) //if no graphic was loaded, then load the placeholder
			character.loadGraphic(Paths.image(imagenPath+imagePH));
		character.scale.y = 1.3;
        character.scale.x = 1.3;
		character.updateHitbox();
		character.x = 780;
		character.screenCenter(Y);
		character.y += 42;
		character.scale.y = 1.3;
        character.scale.x = 1.3;
        character.antialiasing = ClientPrefs.data.antialiasing;
        add(character);

		numbers = new FlxText(390, 210, Std.int(FlxG.width * 0.6), "0", 80);
		numbers.font = "Assassin Nation Regular";
		numbers.color = 0xffff0000;
		numbers.alpha = 0;
		add(numbers);

		newBest = new FlxText(390, 290, Std.int(FlxG.width * 0.6), "0", 30);
		newBest.font = "Assassin Nation Regular";
		newBest.color = 0xffff0000;
		newBest.alpha = 0;
		add(newBest);

		song = new FlxText(0, 50, FlxG.width,"", 88);
		song.setFormat(Paths.font("DEADLY KILLERS.ttf"), 88, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		song.screenCenter(X);
        song.borderSize = 4;
		song.alpha = 0;
		add(song);

		ranking = new FlxText(450, 550, Std.int(FlxG.width * 0.6),"Rank ", 40);
		ranking.font = "Assassin Nation Regular";
		ranking.alpha = 0;
		add(ranking);

		acctxt = new FlxText(70, 480, Std.int(FlxG.width * 0.6), "Accuracy: 0%", 50);
		acctxt.font = "Assassin Nation Regular";
		
		acctxt.alpha = 0;
		add(acctxt);

		comtxt = new FlxText(70, 540, Std.int(FlxG.width * 0.6), "Max Combo: 0", 60);
		comtxt.font = "Assassin Nation Regular";

		comtxt.alpha = 0;
		add(comtxt);

		noModchart = new FlxText(650,330).loadGraphic(Paths.getPath('images/rating/noModchart.png', IMAGE));
		noModchart.scale.x = 0.5;
		noModchart.scale.y = 0.5;
		noModchart.updateHitbox();
		noModchart.alpha = 0;
		add(noModchart);

		rating = new FlxSprite(440,330);
		rating.frames = Paths.getSparrowAtlas('rating/ratings');
		rating.animation.addByPrefix('fantastic', 'Rating-H', 24, true);
		rating.animation.addByPrefix('S', 'Rating-S', 24, true);
		rating.animation.addByPrefix('A', 'Rating-A', 24, true);
		rating.animation.addByPrefix('B', 'Rating-B', 24, true);
		rating.animation.addByPrefix('C', 'Rating-C', 24, true);
		rating.animation.addByPrefix('D', 'Rating-D', 24, true);
        rating.animation.addByPrefix('E', 'Rating-E', 24, true);
        rating.animation.addByPrefix('F', 'Rating-F', 24, true);
		rating.scale.x = 0.9;
		rating.scale.y = 0.9;
		rating.antialiasing = true;
		rating.updateHitbox();
		rating.scrollFactor.set();
		add(rating);

		fantastictxt = new FlxText(70, 220, Std.int(FlxG.width * 0.6), "PERFECTS: " + fantastic, 30);
		fantastictxt.font = "Assassin Nation Regular";
		fantastictxt.autoSize = false;
		fantastictxt.alpha = 0;
		add(fantastictxt);

		excelenttxt = new FlxText(70, 260, Std.int(FlxG.width * 0.6), "AMAZINGS: " + excelent, 30);
		excelenttxt.font = "Assassin Nation Regular";
		excelenttxt.autoSize = false;
		excelenttxt.alpha = 0;
		add(excelenttxt);

		greattxt = new FlxText(70, 300, Std.int(FlxG.width * 0.6), "GREATS: " + great, 30);
		greattxt.font = "Assassin Nation Regular";
		greattxt.alpha = 0;
		add(greattxt);

		wayofftxt = new FlxText(70, 340, Std.int(FlxG.width * 0.6), "LATE: " + decent, 30);
		wayofftxt.font = "Assassin Nation Regular";
		wayofftxt.alpha = 0;
		add(wayofftxt);

		decenttxt = new FlxText(70, 380, Std.int(FlxG.width * 0.6), "WAY LATE: " + wayoff, 30);
		decenttxt.font = "Assassin Nation Regular";
		decenttxt.alpha = 0;
		add(decenttxt);

		misstxt = new FlxText(70, 420, Std.int(FlxG.width * 0.6), "ERROR: " + miss, 30);
		misstxt.font = "Assassin Nation Regular";
		misstxt.alpha = 0;
		add(misstxt);

		if (FlxG.sound.music != null) FlxG.sound.music.stop();

		if(ClientPrefs.data.pauseMusic != 'None') music = new FlxSound().loadEmbedded(Paths.music(convertPauseMenuSong(ClientPrefs.data.pauseMusic)), true);
		music.volume = 0.5;
		FlxG.sound.list.add(music);
		music.play();
		// FlxG.sound.playMusic(Paths.music('result'));
	}

	public function switchResult(diff:Bool)
	{
		if (!diff){
			numbers.visible = true;
			newBest.visible = true;
			ranking.visible = true;

			rating.visible = true;
			acctxt.visible = true;
			comtxt.visible = true;
			noModchart.visible = true;

			fantastictxt.visible = true;
			excelenttxt.visible = true;
			greattxt.visible = true;
			wayofftxt.visible = true;
			decenttxt.visible = true;
			misstxt.visible = true;
		}else{
			numbers.visible = false;
			newBest.visible = false;
			ranking.visible = false;

			rating.visible = false;
			acctxt.visible = false;
			comtxt.visible = false;
			noModchart.visible = false;

			fantastictxt.visible = false;
			excelenttxt.visible = false;
			greattxt.visible = false;
			wayofftxt.visible = false;
			decenttxt.visible = false;
			misstxt.visible = false;
		}
	}

	public function convertPauseMenuSong(name:String) {
		name = name.toLowerCase();
		name = StringTools.replace(name, ' ', '-');
		return name;
	}

	override function update(elapsed:Float)
	{
		PlayState.instance.camZooming = false;
		lerpscore = Math.round(FlxMath.lerp(lerpscore, dascore, 0.5));
		lerpacc = Math.round(FlxMath.lerp(lerpacc, daacc, 1) * 100) / 100;
		lerpcom = Math.round(FlxMath.lerp(lerpcom, Math.abs(dacom), 1.5));
		if (Math.abs(lerpscore - dascore) < 5)
		{
			lerpscore = dascore;
			lerpacc = daacc;
			lerpcom = Math.floor(Math.abs(dacom));
		}
		numbers.text = "" + lerpscore;
			newBest.text = (lerpscore > daBest ? "(NEW BEST " : "(HIGH SCORE ")
				+ daBest
				+ (lerpscore > daBest ? " +" : " ")
				+ (lerpscore - daBest)
				+ ")";
		newBest.alpha += 0.1;
		acctxt.text = "Accuracy: " + lerpacc + "%";
		comtxt.text = "Max Combo: " + lerpcom;
		if (dacom < 0 && lerpcom == Math.abs(dacom))
		{
			comtxt.text += "(FULL COMBO!)";
			comtxt.color = 0xFFffff00;
		}
		song.text = PlayState.SONG.song;
		numbers.alpha += 0.1;
		acctxt.alpha += 0.1;
		comtxt.alpha += 0.1;
		ranking.alpha += 0.1;
		song.alpha += 0.1;
		if (!PlayState.instance.notITGMod){
			noModchart.alpha += 0.1;
		}
		if (lerpscore == dascore)
		{
			if (rating.animation.curAnim == null)
			{
				if (daacc == 100)
					rating.animation.play("fantastic");
				else if (daacc >= 95)
					rating.animation.play("S");
				else if (daacc >= 90)
					rating.animation.play("A");
				else if (daacc >= 80)
					rating.animation.play("B");
				else if (daacc >= 70)
					rating.animation.play("C");
				else if (daacc >= 60)
					rating.animation.play("D");
                else if (daacc >= 50)
					rating.animation.play("E");
                else if (daacc <= 40)
					rating.animation.play("F");
				else if (daacc <= 30)
					rating.animation.play("F");
			}
			
				if (daacc == 100)
						ranking.text = "ranking: HITMAN";
				else if (daacc >= 95)
						ranking.text = "ranking: LEGENDARY";
				else if (daacc >= 90)
						ranking.text = "ranking: MASTER";
				else if (daacc >= 80)
						ranking.text = "ranking: GOOD";
				else if (daacc >= 70)
						ranking.text = "ranking: NICE";
				else if (daacc >= 60)
						ranking.text = "ranking: BAD";
				else if (daacc >= 50)
						ranking.text = "ranking: SHIT";
				else if (daacc <= 40)
						ranking.text = "ranking: ANNIHILATED";
				else if (daacc <= 1)
						ranking.text = "ranking: BOTPLAY";
				
			fantastictxt.alpha += 0.05;
			excelenttxt.alpha += 0.05;
			greattxt.alpha += 0.05;
			wayofftxt.alpha += 0.05;
			decenttxt.alpha += 0.05;
			misstxt.alpha += 0.05;

			if ((FlxG.keys.justPressed.CONTROL) && !ended)
			{
				onDiffMode = !onDiffMode;
				switchResult(onDiffMode);
			}
			if ((FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed) && !ended)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				camRate.fade(FlxColor.BLACK, 0.5, false, function()
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

					PlayState.cancelMusicFadeTween();
					if(PlayState.isStoryMode)
					{
						PlayState.campaignScore += PlayState.instance.songScore;
						PlayState.campaignMisses += PlayState.weekMisses;

						PlayState.storyPlaylist.remove(PlayState.storyPlaylist[0]);

						if (PlayState.storyPlaylist.length <= 0)
						{
							Mods.loadTopMod();
							FlxG.sound.playMusic(Paths.music('bloodstained'));
							#if desktop DiscordClient.resetClientID(); #end
							PlayState.cancelMusicFadeTween();
							if(FlxTransitionableState.skipNextTransIn) {
								CustomFadeTransition.nextCamera = null;
							}
							MusicBeatState.switchState(new StoryMenuState());

							if(!ClientPrefs.getGameplaySetting('practice', true) && !ClientPrefs.getGameplaySetting('botplay', true)  && !ClientPrefs.getGameplaySetting('modchart', false)) {
								StoryMenuState.weekCompleted.set(WeekData.weeksList[PlayState.storyWeek], true);

								Highscore.saveWeekScore(WeekData.getWeekFileName(), PlayState.campaignScore, PlayState.storyDifficulty);

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

							Song.loadFromJson(PlayState.storyPlaylist[0] + difficulty, PlayState.storyPlaylist[0]);
							FlxG.sound.music.stop();

							PlayState.cancelMusicFadeTween();
							LoadingState.loadAndSwitchState(new PlayState(), true, 0.75);
						}
					}else{
						Mods.loadTopMod();
						FlxG.sound.playMusic(Paths.music('bloodstained'), 0);
						FlxG.sound.music.fadeIn(4, 0, 0.7);
						MusicBeatState.switchState(new FreeplayState());
					}
				});	
			}
		}

		super.update(elapsed);
	}
}