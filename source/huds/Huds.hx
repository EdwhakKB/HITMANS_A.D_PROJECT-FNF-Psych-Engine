package huds;

import flixel.group.FlxGroup;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;
import flixel.util.FlxStringUtil;

using StringTools;

/**
 *	usually this class would be way more simple when it comes to objects
 *	but due to this mod being a literal giant in terms of content, I had to make it
 *	the way it currently is, while also transferring some PlayState stuff to here aside from the
 *	actual hud -BeastlyGhost
**/
class Huds extends FlxGroup
{
	// health
    public var healthBarHit:AttachedSprite;
    public var healthHitBar:FlxBar;
	public var healthBarBG:AttachedSprite;
	public var healthBar:FlxBar;
	public var health:Float = 1;
	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;
	public var coloredHealthBar:Bool;

	// timer
	public var timeBarBG:AttachedSprite;
	public var timeBar:FlxBar;
	public var timeBarUi:String;
	public var updateTimePos:Bool = true;

	public var timeTxt:FlxText;
	public var songName:String = "";

	public var updateTime:Bool = false;
	public var songPercent:Float = 0;

	// score bla bla bla
	public var scoreTxt:FlxText;
    public var scoreTxtHit:FlxText;
	public var scoreTxtTween:FlxTween;
    public var scoreTxtHitTween:FlxTween;

	public var botplaySine:Float = 0;
	public var botplayTxt:FlxText;

    //made these 2 for Player and Enemy (usually both plays at the same time but when its vs Ed he usually play enemy so...)
    public var ratings:FlxSprite;
    public var ratingsBumpTween:FlxTween;
    public var ratingsBumpTween2:FlxTween;
    public var ratingsBumpTimer:FlxTimer;

    public var ratingsOP:FlxSprite;
    public var ratingsOPBumpTween:FlxTween;
    public var ratingsOPBumpTween2:FlxTween;
    public var ratingsOPBumpTimer:FlxTimer;

    public var noteScore:FlxText;
    public var noteScoreOp:FlxText;
    public var noteRatingTween:FlxTween;
    public var noteRatingTweenOp:FlxTween;

	var hudadded:Bool = false;

	public function new()
	{
		super();
		create();
	}

	function create():Void
	{
		if (!hudadded)
		{
			// set up the Time Bar
			songName = PlayState.SONG.song.replace("-", " ").replace("_", " ");

            //Hitmans Ratings (Kinda Better LOL, sorry if separated i can't use array due keyboard bug)
            //570 x and 200 y (just in case)
            ratings = new FlxSprite(850, 230);
            ratings.frames = Paths.getSparrowAtlas('judgements');
            ratings.animation.addByPrefix('fantastic', 'Fantastic', 1, true);
            ratings.animation.addByPrefix('excellent Late', 'Excellent late', 1, true);
            ratings.animation.addByPrefix('excellent Early', 'Excellent early', 1, true);
            ratings.animation.addByPrefix('great Early', 'Great early', 1, true);
            ratings.animation.addByPrefix('great Late', 'Great late', 1, true);
            ratings.animation.addByPrefix('decent Early', 'Decent early', 1, true);
            ratings.animation.addByPrefix('decent Late', 'Decent late', 1, true);
            ratings.animation.addByPrefix('way Off Early', 'Way off early', 1, true);
            ratings.animation.addByPrefix('way Off Late', 'Way off late', 1, true);
            ratings.animation.addByPrefix('miss', 'Miss', 1, true);
            ratings.antialiasing = true;
            ratings.updateHitbox();
            ratings.scrollFactor.set();
            ratings.visible = false;
            add(ratings);

            ratingsOP = new FlxSprite(180, 230);
            ratingsOP.frames = Paths.getSparrowAtlas('judgements');
            ratingsOP.animation.addByPrefix('fantastic', 'Fantastic', 1, true);
            ratingsOP.animation.addByPrefix('excellent Late', 'Excellent late', 1, true);
            ratingsOP.animation.addByPrefix('excellent Early', 'Excellent early', 1, true);
            ratingsOP.animation.addByPrefix('great Early', 'Great early', 1, true);
            ratingsOP.animation.addByPrefix('great Late', 'Great late', 1, true);
            ratingsOP.animation.addByPrefix('decent Early', 'Decent early', 1, true);
            ratingsOP.animation.addByPrefix('decent Late', 'Decent late', 1, true);
            ratingsOP.animation.addByPrefix('way Off Early', 'Way off early', 1, true);
            ratingsOP.animation.addByPrefix('way Off Late', 'Way off late', 1, true);
            ratingsOP.animation.addByPrefix('miss', 'Miss', 1, true);
            ratingsOP.antialiasing = true;
            ratingsOP.updateHitbox();
            ratingsOP.scrollFactor.set();
            ratingsOP.visible = false;
            add(ratingsOP);

            noteScoreOp = new FlxText(ratingsOP.x, 0, FlxG.width, '', 36);
            noteScoreOp.setFormat(Paths.font("pixel.otf"), 36, 0xff000000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
            noteScoreOp.borderSize = 2;
            noteScoreOp.scrollFactor.set();
            noteScoreOp.visible = false;
            add(noteScoreOp);

            noteScore = new FlxText(ratings.x, 0, FlxG.width, '', 36);
            noteScore.setFormat(Paths.font("pixel.otf"), 36, 0xff000000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
            noteScore.borderSize = 2;
            noteScore.scrollFactor.set();
            noteScore.visible = false;
            add(noteScore);

            var showTime:Bool = (ClientPrefs.timeBarType != 'Disabled');
            timeTxt = new FlxText(PlayState.STRUM_X + (FlxG.width / 2) - 248, 19, 400, "", 32);
            timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            timeTxt.scrollFactor.set();
            timeTxt.alpha = 0;
            timeTxt.borderSize = 2;
            timeTxt.visible = showTime;
            if(ClientPrefs.downScroll) timeTxt.y = FlxG.height - 44;
    
            if(ClientPrefs.timeBarType == 'Song Name')
            {
                timeTxt.text = PlayState.SONG.song;
            }
            updateTime = showTime;
    
            timeBarBG = new AttachedSprite('timeBar');
            timeBarBG.x = timeTxt.x;
            timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
            timeBarBG.scrollFactor.set();
            timeBarBG.alpha = 0;
            timeBarBG.visible = showTime;
            timeBarBG.color = FlxColor.BLACK;
            timeBarBG.xAdd = -4;
            timeBarBG.yAdd = -4;
            add(timeBarBG);
    
            timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), this,
                'songPercent', 0, 1);
            timeBar.scrollFactor.set();
            timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
            timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
            timeBar.alpha = 0;
            timeBar.visible = showTime;
            add(timeBar);
            add(timeTxt);
            timeBarBG.sprTracker = timeBar;

            if(ClientPrefs.timeBarType == 'Song Name')
		    {
			    timeTxt.size = 24;
			    timeTxt.y += 3;
		    }

            healthBarBG = new AttachedSprite('healthBar');
            healthBarBG.y = FlxG.height * 0.89;
            healthBarBG.screenCenter(X);
            healthBarBG.scrollFactor.set();
            healthBarBG.visible = !ClientPrefs.hideHud;
            healthBarBG.xAdd = -4;
            healthBarBG.yAdd = -4;
            add(healthBarBG);
            if (ClientPrefs.hudStyle == 'HITMANS'){
                healthBarBG.visible = false;
            }
    
            if(ClientPrefs.downScroll) healthBarBG.y = 0.11 * FlxG.height;
    
            healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
                'health', 0, 2);
            healthBar.scrollFactor.set();
            // healthBar
            healthBar.visible = !ClientPrefs.hideHud;
            healthBar.alpha = ClientPrefs.healthBarAlpha;
            add(healthBar);
            if (ClientPrefs.hudStyle == 'HITMANS'){
                healthBar.visible = false;
            }
            healthBarBG.sprTracker = healthBar;
    
            healthBarHit = new AttachedSprite('healthBarHit');
            if(!ClientPrefs.downScroll) healthBarHit.y = FlxG.height * 0.9;
            if(ClientPrefs.downScroll) healthBarHit.y = 0 * FlxG.height;
            healthBarHit.screenCenter(X);
            healthBarHit.visible = !ClientPrefs.hideHud;
            healthBarHit.alpha = ClientPrefs.healthBarAlpha;
            healthBarHit.flipY = false;
            if (!ClientPrefs.downScroll){
                healthBarHit.flipY = true;
            }
            healthHitBar = new FlxBar(350, healthBarHit.y + 15, RIGHT_TO_LEFT, Std.int(healthBarHit.width - 120), Std.int(healthBarHit.height - 30), this,
                'health', 0, 2);
            // healthBar
            healthHitBar.visible = !ClientPrefs.hideHud;
            healthHitBar.alpha = ClientPrefs.healthBarAlpha;
            add(healthHitBar);
            add(healthBarHit);
            if (ClientPrefs.hudStyle == 'Classic'){
                healthHitBar.visible = false;
                healthBarHit.visible = false;
            }
    
            iconP1 = new HealthIcon(PlayState.instance.boyfriend.healthIcon, true);
            iconP1.y = healthBar.y - 75;
            iconP1.visible = !ClientPrefs.hideHud;
            iconP1.alpha = ClientPrefs.healthBarAlpha;
            add(iconP1);
    
            iconP2 = new HealthIcon(PlayState.instance.dad.healthIcon, false);
            iconP2.y = healthBar.y - 75;
            iconP2.visible = !ClientPrefs.hideHud;
            iconP2.alpha = ClientPrefs.healthBarAlpha;
            add(iconP2);
            reloadHealthBarColors();
    
            scoreTxt = new FlxText(0, healthBarBG.y + 36, FlxG.width, "", 20);
            scoreTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            scoreTxt.scrollFactor.set();
            scoreTxt.borderSize = 1.25;
            scoreTxt.visible = !ClientPrefs.hideHud;
            if (ClientPrefs.hudStyle == 'Classic'){
            add(scoreTxt);
            }
    
            scoreTxtHit = new FlxText(0, 0, FlxG.width, "", 20);
            scoreTxtHit.setFormat(Paths.font("DEADLY KILLERS.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            if(!ClientPrefs.downScroll) scoreTxtHit.y = healthBarHit.y - 33;
            if(ClientPrefs.downScroll) scoreTxtHit.y = healthBarHit.y + 66;
            scoreTxtHit.scrollFactor.set();
            scoreTxtHit.borderSize = 1.25;
            scoreTxtHit.visible = !ClientPrefs.hideHud;
            if (ClientPrefs.hudStyle == 'HITMANS'){
            add(scoreTxtHit);
            }
    
            botplayTxt = new FlxText(400, timeBarBG.y + 55, FlxG.width - 800, "BOTPLAY", 32);
            botplayTxt.setFormat(Paths.font("DEADLY KILLERS.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            botplayTxt.scrollFactor.set();
            botplayTxt.borderSize = 1.25;
            botplayTxt.visible = PlayState.instance.cpuControlled;
            add(botplayTxt);
            if(ClientPrefs.downScroll) {
                botplayTxt.y = timeBarBG.y - 78;
            }

			hudadded = true;
			reloadHealthBarColors();
			updateScore();
		}
	}

    var iconOffset:Int = 26;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (hudadded)
		{
			health = PlayState.instance.health;

            var mult:Float = FlxMath.lerp(1, iconP1.scale.x, CoolUtil.boundTo(1 - (elapsed * 9 * PlayState.instance.playbackRate), 0, 1));
			iconP1.scale.set(mult, mult);
			iconP1.updateHitbox();

			var mult:Float = FlxMath.lerp(1, iconP2.scale.x, CoolUtil.boundTo(1 - (elapsed * 9 * PlayState.instance.playbackRate), 0, 1));
			iconP2.scale.set(mult, mult);
			iconP2.updateHitbox();
    
            if (ClientPrefs.hudStyle == 'HITMANS'){
                iconP1.x = (FlxG.width - 160);
                iconP2.x = (0);
            }
            if (ClientPrefs.hudStyle == 'Classic'){
                iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) + (150 * iconP1.scale.x - 150) / 2 - iconOffset;
                iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * iconP2.scale.x) / 2 - iconOffset * 2;
            }
            if (ClientPrefs.hudStyle == 'Classic'){
                if (healthBar.percent < 20)
                    iconP1.animation.curAnim.curFrame = 1;
                else
                    iconP1.animation.curAnim.curFrame = 0;

                if (healthBar.percent > 80)
                    iconP2.animation.curAnim.curFrame = 1;
                else
                    iconP2.animation.curAnim.curFrame = 0;
            }
    
            if (ClientPrefs.hudStyle == 'HITMANS'){
                if (healthHitBar.percent < 20)
                    iconP1.animation.curAnim.curFrame = 1;
                else
                    iconP1.animation.curAnim.curFrame = 0;
        
                if (healthHitBar.percent > 80)
                    iconP2.animation.curAnim.curFrame = 1;
                else
                    iconP2.animation.curAnim.curFrame = 0;
            }

			if (botplayTxt.visible)
			{
				botplaySine += 180 * elapsed;
				botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
			}

        	//noteRating shit ig but only for x and y LOL
            noteScore.alpha = PlayState.instance.combo <= 3 ? 0 : 1;
            noteScore.text = Std.string(PlayState.instance.combo);

            switch (PlayState.instance.edwhakIsEnemy || PlayState.SONG.bossFight){
                case true:
                    noteScoreOp.text = Std.string(PlayState.instance.comboOp);
                    noteScoreOp.alpha = PlayState.instance.comboOp <= 3 ? 0 : 1;
                case false:
                    noteScoreOp.text = Std.string(PlayState.instance.combo);
                    noteScoreOp.alpha = PlayState.instance.combo <= 3 ? 0 : 1;
            }

            noteScore.x = ratings.x-510;
            noteScoreOp.x = ratingsOP.x-510;

            noteScore.y = ratings.y+100;
            noteScoreOp.y = ratingsOP.y+100;

			if (updateTime)
			{
				var curTime:Float = Conductor.songPosition - ClientPrefs.noteOffset;
				var secondsTotal:Int = Math.floor(curTime / 1000);
				if (curTime < 0)
					curTime = 0;

				songPercent = (curTime / PlayState.instance.songLength);

				if (secondsTotal < 0)
					secondsTotal = 0;

				timeTxt.text = FlxStringUtil.formatTime(secondsTotal, false);

				if (updateTimePos)
					timeTxt.screenCenter(X);
			}
		}
	}

	public var tempScore:String = "";
	public var scoreSeparator:String = ' | ';
	public var displayRatings:Bool = true;

	public function updateScore()
	{
		if (hudadded)
		{
			var songScore:Int = PlayState.instance.songScore;
			var songMisses:Int = PlayState.instance.songMisses;
			var ratingName:String = PlayState.instance.ratingName;
			var ratingPercent:Float = PlayState.instance.ratingPercent;
			var ratingFC:String = PlayState.instance.ratingFC;

			// of course I would go back and fix my code, of COURSE @BeastlyGhost;
			tempScore = 'Score: ' + songScore;
			var ratingString = '';
            
            if (displayRatings)
			{
				ratingString = scoreSeparator + 'Misses: ' + songMisses;
				ratingString += scoreSeparator + 'Rating: ' + ratingName;
				ratingString += (ratingName != '?' ? ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' : '');
				ratingString += (ratingFC != null && ratingFC != '' ? ' - ' + ratingFC : '');
			}

			tempScore += ratingString + '\n';
			scoreTxt.text = tempScore;
            scoreTxtHit.text = tempScore;
		}
	}

	public function reloadHealthBarColors()
	{
		if (hudadded)
		{
			var dadHealthColorArray:Array<Int> = PlayState.instance.dad.healthColorArray;
			var bfHealthColorArray:Array<Int> = PlayState.instance.boyfriend.healthColorArray;

			var dadcolor:FlxColor = FlxColor.fromRGB(dadHealthColorArray[0], dadHealthColorArray[1], dadHealthColorArray[2]);
			var bfcolor:FlxColor = FlxColor.fromRGB(bfHealthColorArray[0], bfHealthColorArray[1], bfHealthColorArray[2]);

			healthBar.createFilledBar(dadcolor, bfcolor);
			healthBar.updateBar();

            healthHitBar.createFilledBar(dadcolor, bfcolor);
		    healthHitBar.updateBar();
		}
	}

	public function beatHit()
	{
		if (hudadded)
		{
			iconP1.scale.set(1.2, 1.2);
			iconP2.scale.set(1.2, 1.2);

			iconP1.updateHitbox();
			iconP2.updateHitbox();
		}
	}

    public function ratingsBumpScale() {

		if(ratingsBumpTween != null) {
			ratingsBumpTween.cancel();
		}
		if(ratingsBumpTween2 != null) {
			ratingsBumpTween2.cancel();
		}
		if(ratingsBumpTimer != null) {
			ratingsBumpTimer.cancel();
		}
		if(noteRatingTween != null) {
			noteRatingTween.cancel(); // like scoreTxt scale tween
		}
		ratings.scale.x = 1.5;
		ratings.scale.y = 1.5;
		ratingsBumpTween = FlxTween.tween(ratings.scale, {x: 1.3, y: 1.3}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				ratingsBumpTween = null;
				ratingsBumpTimer = new FlxTimer().start(1, function(flxTimer:FlxTimer){
						ratingsBumpTween2 = FlxTween.tween(ratings.scale, {x: 0, y: 0}, 0.1, {ease:FlxEase.circIn,
						onComplete: function(twn:FlxTween) {
							ratingsBumpTimer = null;
							ratingsBumpTween2 = null;
						}
					});			
				
				});
			}
		});
		noteScore.scale.x = 1.125;
		noteScore.scale.y = 1.125;
		noteRatingTween = FlxTween.tween(noteScore.scale, {x: 1, y: 1}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				noteRatingTween = null;
			}
		});

		// FlxTween.tween(numScoreOp, {alpha: 0}, 0.2 / playbackRate, {
		// 	onComplete: function(tween:FlxTween)
		// 	{
		// 		numScoreOp.destroy();
		// 	},
		// 	startDelay: Conductor.crochet * 0.001 / playbackRate
		// });
		if (ClientPrefs.hudStyle == 'HITMANS'){
			ratings.visible = true;
			noteScore.visible = true;
		}
	}

	public function ratingsBumpScaleOP() {

		if(ratingsOPBumpTween != null) {
			ratingsOPBumpTween.cancel();
		}
		if(ratingsOPBumpTween2 != null) {
			ratingsOPBumpTween2.cancel();
		}
		if(ratingsOPBumpTimer != null) {
			ratingsOPBumpTimer.cancel();
		}
		if(noteRatingTweenOp != null) {
			noteRatingTweenOp.cancel(); // like scoreTxt scale tween
		}
		ratingsOP.scale.x = 1.5;
		ratingsOP.scale.y = 1.5;
		ratingsOPBumpTween = FlxTween.tween(ratingsOP.scale, {x: 1.3, y: 1.3}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				ratingsOPBumpTween = null;
				ratingsOPBumpTimer = new FlxTimer().start(1, function(flxTimer:FlxTimer){
						ratingsOPBumpTween2 = FlxTween.tween(ratingsOP.scale, {x: 0, y: 0}, 0.1, {ease:FlxEase.circIn,
						onComplete: function(twn:FlxTween) {
							ratingsOPBumpTimer = null;
							ratingsOPBumpTween2 = null;
						}
					});			
				
				});
			}
		});
		noteScoreOp.scale.x = 1.125;
		noteScoreOp.scale.y = 1.125;
		noteRatingTweenOp = FlxTween.tween(noteScoreOp.scale, {x: 1, y: 1}, 0.1, {ease:FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				noteRatingTweenOp = null;
			}
		});

		// FlxTween.tween(numScoreOp, {alpha: 0}, 0.2 / playbackRate, {
		// 	onComplete: function(tween:FlxTween)
		// 	{
		// 		numScoreOp.destroy();
		// 	},
		// 	startDelay: Conductor.crochet * 0.001 / playbackRate
		// });
		if (ClientPrefs.hudStyle == 'HITMANS'){
			ratingsOP.visible = true;
			noteScoreOp.visible = true;
		}
	}

	public function setRatingAnimation(rat:Float){
		if (rat >= 0){
			if (rat <= ClientPrefs.marvelousWindow){
				ratings.animation.play("fantastic");
			} else if (rat <= ClientPrefs.sickWindow){
				ratings.animation.play("excellent Early");
			}else if (rat >= ClientPrefs.sickWindow && rat <= ClientPrefs.goodWindow){
				ratings.animation.play("great Early");
			}else if (rat >= ClientPrefs.goodWindow && rat <= ClientPrefs.badWindow){
				ratings.animation.play("decent Early");
			}else if (rat >= ClientPrefs.badWindow){
				ratings.animation.play("way Off Early");
			}
		} else {
			if (rat >= ClientPrefs.marvelousWindow * -1){
				ratings.animation.play("fantastic");
			} else if (rat >= ClientPrefs.sickWindow * -1){
				ratings.animation.play("excellent Late");
			}else if (rat <= ClientPrefs.sickWindow * -1 && rat >= ClientPrefs.goodWindow * -1){
				ratings.animation.play("great Late");
			}else if (rat <= ClientPrefs.goodWindow * -1 && rat >= ClientPrefs.badWindow * -1){
				ratings.animation.play("decent Late");
			}else if (rat <= ClientPrefs.badWindow * -1){
				ratings.animation.play("way Off Late");
			}
		}
	}

	public function setRatingImageOP(rat:Float){
		if (rat >= 0){
			if (rat <= ClientPrefs.marvelousWindow){
				ratingsOP.animation.play("fantastic");
			} else if (rat <= ClientPrefs.sickWindow){
				ratingsOP.animation.play("excellent Early");
			}else if (rat >= ClientPrefs.sickWindow && rat <= ClientPrefs.goodWindow){
				ratingsOP.animation.play("great Early");
			}else if (rat >= ClientPrefs.goodWindow && rat <= ClientPrefs.badWindow){
				ratingsOP.animation.play("decent Early");
			}else if (rat >= ClientPrefs.badWindow){
				ratingsOP.animation.play("way Off Early");
			}
		} else {
			if (rat >= ClientPrefs.marvelousWindow * -1){
				ratingsOP.animation.play("fantastic");
			} else if (rat >= ClientPrefs.sickWindow * -1){
				ratingsOP.animation.play("excellent Late");
			}else if (rat <= ClientPrefs.sickWindow * -1 && rat >= ClientPrefs.goodWindow * -1){
				ratingsOP.animation.play("great Late");
			}else if (rat <= ClientPrefs.goodWindow * -1 && rat >= ClientPrefs.badWindow * -1){
				ratingsOP.animation.play("decent Late");
			}else if (rat <= ClientPrefs.badWindow * -1){
				ratingsOP.animation.play("way Off Late");
			}
		}
	}
}
