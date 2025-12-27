package huds;

import flixel.ui.FlxBar;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.text.FlxText.FlxTextBorderStyle;

using StringTools;

/**
 *	usually this class would be way more simple when it comes to objects
 *	but due to this mod being a literal giant in terms of content, I had to make it
 *	the way it currently is, while also transferring some PlayState stuff to here aside from the
 *	actual hud -BeastlyGhost
**/

/*
	so this is going to be OPT ig?
	i don't like how it currently looks so i'll try to improve it
	so if you want to add something to it, feel free to make this easier ed
	-Edwhak
*/


//Same classes new variable
class EditedFlxBar extends FlxBar
{
	public var separated:Bool = false;
}

class EditedFlxText extends FlxText
{
	public var separated:Bool = false;
}

class EditedHealthIcon extends HealthIcon
{
	public var separated:Bool = false;
}

class EditedAttachedSprite extends AttachedSprite
{
	public var separated:Bool = false;
}

class EditedFlxSprite extends FlxSprite
{
	public var separated:Bool = false;
}

class Huds extends FlxGroup
{
	// health
	public var healthBarBG:EditedAttachedSprite;
	public var healthBar:EditedFlxBar;
	public var health:Float = 1;
	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;
	public var coloredHealthBar:Bool;

	// timer
	public var timeBarBG:EditedAttachedSprite;
	public var timeBar:EditedFlxBar;
	public var timeBarUi:String;
	public var updateTimePos:Bool = true;

	public var timeTxt:EditedFlxText;
	public var songName:String = "";

	public var updateTime:Bool = false;
	public var songPercent:Float = 0;

	// score bla bla bla
	public var scoreTxt:EditedFlxText;
	public var scoreTxtTween:FlxTween;

	public var botplaySine:Float = 0;
	public var botplayTxt:EditedFlxText;

    //made these 2 for Player and Enemy (usually both plays at the same time but when its vs Ed he usually play enemy so...)
    public var ratings:EditedFlxSprite;
    public var ratingsBumpTween:FlxTween;
    public var ratingsBumpTween2:FlxTween;
    public var ratingsBumpTimer:FlxTimer;

    public var ratingsOP:EditedFlxSprite;
    public var ratingsOPBumpTween:FlxTween;
    public var ratingsOPBumpTween2:FlxTween;
    public var ratingsOPBumpTimer:FlxTimer;

    public var noteScore:EditedFlxText;
    public var noteScoreOp:EditedFlxText;
    public var noteRatingTween:FlxTween;
    public var noteRatingTweenOp:FlxTween;

	var hudadded:Bool = false;

	var hudUsed:String = ClientPrefs.data.hudStyle.toLowerCase(); //so it grabs the hud you want and stuff (for now only like this, in a future it will be way complex)
	var ratingsScaleMultiplier:Float = 1.0;
	var comboOffset:Array<Float> = [0,0];
	var ratingsPoss:Array<Float> = [0,0];
	var iconsYOffset:Array<Float> = [0,0];
	var scoreOffset:Array<Float> = [0,0]; //upscroll/Downscroll
	// var hudRating:String = ClientPrefs.data.hudStyle.toLowerCase();

	public var songScore:Int = 0;
	public var songMisses:Int = 0;
	public var ratingName:String = "";
	public var ratingPercent:Float = 0;
	public var ratingFC:String = "";
	
	public var ratingString = '';

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


			switch(hudUsed){
				case 'hitmans':
					ratingsScaleMultiplier = 1;
					comboOffset[0] = 0;
					comboOffset[1] = 0;
					ratingsPoss[0] = 850;
					ratingsPoss[1] = 230;
					iconsYOffset[0] = !ClientPrefs.data.downScroll ? -75 : -30;
					iconsYOffset[1] = !ClientPrefs.data.downScroll ? -75 : -30;
					scoreOffset[0] = -33;
					scoreOffset[1] = 66;
				case 'classic':
					ratingsScaleMultiplier = 0.5;
					comboOffset[0] = 65;
					comboOffset[1] = 50;
					ratingsPoss[0] = 780;
					ratingsPoss[1] = 180;
					iconsYOffset[0] = -65;
					iconsYOffset[1] = -65;
					scoreOffset[0] = 36;
					scoreOffset[1] = 36;
				default:
					ratingsScaleMultiplier = 1;
					comboOffset[0] = 0;
					comboOffset[1] = 0;
					ratingsPoss[0] = 850;
					ratingsPoss[1] = 230;
					iconsYOffset[0] = 90;
					iconsYOffset[1] = 90;
					scoreOffset[0] = -33;
					scoreOffset[1] = 66;
			}
            //Hitmans Ratings (Kinda Better LOL, sorry if separated i can't use array due keyboard bug)
            //570 x and 200 y (just in case)
            ratings = new EditedFlxSprite(ratingsPoss[0], ratingsPoss[1]);

            ratings.frames = Paths.getSparrowAtlas('Huds/ratings/'+hudUsed+'/judgements');
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

            ratingsOP = new EditedFlxSprite(ratings.x - 700, ratings.y);

            ratingsOP.frames = Paths.getSparrowAtlas('Huds/ratings/'+hudUsed+'/judgements');
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

            noteScoreOp = new EditedFlxText(ratingsOP.x-510 + scoreOffset[0], ratingsOP.y+100 + scoreOffset[1], FlxG.width, '', 36);

            noteScoreOp.setFormat(Paths.font("pixel.otf"), 36, 0xff000000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
			noteScoreOp.font = (hudUsed == 'hitmans') ? Paths.font("pixel.otf") : Paths.font("Phantomuff.ttf");
			noteScoreOp.size = (hudUsed == 'hitmans') ? 36 : 72;
            noteScoreOp.borderSize = 2;
            noteScoreOp.scrollFactor.set();
            noteScoreOp.visible = false;
            add(noteScoreOp);

            noteScore = new EditedFlxText(ratings.x-510 + comboOffset[0], ratings.y+100 + comboOffset[1], FlxG.width, '', 36);

            noteScore.setFormat(Paths.font("pixel.otf"), 36, 0xff000000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
			noteScore.font = (hudUsed == 'hitmans') ? Paths.font("pixel.otf") : Paths.font("Phantomuff.ttf");
			noteScore.size = (hudUsed == 'hitmans') ? 36 : 72;
            noteScore.borderSize = 2;
            noteScore.scrollFactor.set();
            noteScore.visible = false;
            add(noteScore);
    
			var showTime:Bool = (ClientPrefs.data.timeBarType != 'Disabled');

            timeBarBG = new EditedAttachedSprite('timeBar');
			timeBarBG.screenCenter(X);
            timeBarBG.y = !ClientPrefs.data.downScroll ? 20 : 676;
            timeBarBG.scrollFactor.set();
            timeBarBG.alpha = 0;
            timeBarBG.visible = showTime;
            timeBarBG.color = FlxColor.BLACK;
            add(timeBarBG);
    
            timeTxt = new EditedFlxText(timeBarBG.x + (timeBarBG.width/2) + (if(ClientPrefs.data.timeBarType == 'Song Name') 3 else 0), timeBarBG.y - 10, 400, "", 32);

            timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            timeTxt.scrollFactor.set();
            timeTxt.alpha = 0;
            timeTxt.borderSize = 2;
            timeTxt.visible = showTime;
    
            if(ClientPrefs.data.timeBarType == 'Song Name')
            {
				timeTxt.size = 24;
                timeTxt.text = PlayState.SONG.song;
            }
            updateTime = showTime;

            timeBar = new EditedFlxBar(timeBarBG.x + 4, timeBarBG.y + 4, LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), this, 'songPercent', 0, 1);

            timeBar.scrollFactor.set();
            timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
            timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
            timeBar.alpha = 0;
            timeBar.visible = showTime;
            add(timeBar);
            add(timeTxt);
            // timeBarBG.sprTracker = timeBar;

            healthBarBG = new EditedAttachedSprite(ClientPrefs.data.hudStyle == 'HITMANS' ? 'healthBarHit' : 'healthBarEmpty');
			if (ClientPrefs.data.hudStyle == 'HITMANS'){
				// healthBarBG.flipY = false;
				healthBarBG.y = ClientPrefs.data.downScroll ? 10 : 650;
            }else{
				healthBarBG.y = ClientPrefs.data.downScroll ? 100 : 610;
				healthBarBG.xAdd = -4;
				healthBarBG.yAdd = -4;
			}
            healthBarBG.screenCenter(X);
           	// if (ClientPrefs.data.hudStyle == 'CLASSIC') healthBarBG.scrollFactor.set();
            healthBarBG.visible = !ClientPrefs.data.hideHud;
    
            healthBar = new EditedFlxBar(
				ClientPrefs.data.hudStyle == 'HITMANS' ? healthBarBG.x + 50 : healthBarBG.x + 4, 
				ClientPrefs.data.hudStyle == 'HITMANS' ? healthBarBG.y + 20 : healthBarBG.y + 4, 
				RIGHT_TO_LEFT, 
				ClientPrefs.data.hudStyle == 'HITMANS' ? Std.int(healthBarBG.width - 100) : Std.int(healthBarBG.width - 8), //593
				ClientPrefs.data.hudStyle == 'HITMANS' ? Std.int(healthBarBG.height - 40) : Std.int(healthBarBG.height - 8), //11
				this,
				'health', 0, 2
			);
			healthBar.numDivisions = 10000;
            // if (ClientPrefs.data.hudStyle == 'CLASSIC') healthBar.scrollFactor.set();
            // healthBar
            healthBar.visible = !ClientPrefs.data.hideHud;
            healthBar.alpha = ClientPrefs.data.healthBarAlpha;
            add(healthBar);
			// if (ClientPrefs.data.hudStyle == 'CLASSIC') healthBarBG.sprTracker = healthBar;
			add(healthBarBG);

			var edwhakVariable:Array<String> = ['Edwhak', 'he', 'edwhakBroken', 'edkbmassacre'];
			switch(edwhakVariable.contains(PlayState.instance != null ? PlayState.instance.boyfriend.curCharacter : (PlayState.SONG != null ? PlayState.SONG.player1 : 'bf'))){
				case true:
					iconP1 = new EditedHealthIcon('icon-edwhak-pl', true);
				case false:
					iconP1 = new EditedHealthIcon(PlayState.instance != null ? PlayState.instance.boyfriend.healthIcon : (PlayState.SONG != null ? PlayState.SONG.player1 : 'bf'), true);
				default:
					iconP1 = new EditedHealthIcon(PlayState.instance != null ? PlayState.instance.boyfriend.healthIcon : (PlayState.SONG != null ? PlayState.SONG.player1 : 'bf'), true); //if it crash for some reazon?
			}
            iconP1.y = healthBar.y + iconsYOffset[0];
            iconP1.visible = !ClientPrefs.data.hideHud;
            iconP1.alpha = ClientPrefs.data.healthBarAlpha;
            add(iconP1);
    
            iconP2 = new EditedHealthIcon(PlayState.instance != null ? PlayState.instance.dad.healthIcon : (PlayState.SONG != null ? PlayState.SONG.player2 : 'dad'), false);
            iconP2.y = healthBar.y + iconsYOffset[1];
            iconP2.visible = !ClientPrefs.data.hideHud;
            iconP2.alpha = ClientPrefs.data.healthBarAlpha;
            add(iconP2);
            reloadHealthBarColors();
    
            scoreTxt = new EditedFlxText(0, healthBarBG.y + (!ClientPrefs.data.downScroll ? scoreOffset[0] : scoreOffset[1]), FlxG.width, "", 20);

            scoreTxt.setFormat(ClientPrefs.data.hudStyle == 'HITMANS' ? Paths.font("DEADLY KILLERS.ttf") : Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            scoreTxt.scrollFactor.set();
            scoreTxt.borderSize = 1.25;
            scoreTxt.visible = !ClientPrefs.data.hideHud;
            add(scoreTxt);
    
            botplayTxt = new EditedFlxText(400, timeBarBG.y + 55, FlxG.width - 800, "BOTPLAY", 32);
            botplayTxt.setFormat(Paths.font("DEADLY KILLERS.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			botplayTxt.font = (hudUsed == 'hitmans') ? Paths.font("DEADLY KILLERS.ttf") : Paths.font("vcr.ttf");
            botplayTxt.scrollFactor.set();
            botplayTxt.borderSize = 1.25;
            botplayTxt.visible = PlayState.instance != null ? PlayState.instance.cpuControlled : false;
            add(botplayTxt);
            if(ClientPrefs.data.downScroll) {
                botplayTxt.y = timeBarBG.y - 78;
            }

			hudadded = true;
			reloadHealthBarColors();
		}
	}

	// public function changeVariables(items:Array<Dynamic>, variablesToChange:Array<String>, variables:Array<Dynamic>, tweenPos:Bool = true):Void
	// {
	// 	for (i in 0...items.length) Reflect.setProperty(items[i], variablesToChange[i], variables[i]);
	// }

	public var separateBarMovement:Bool = false;
	public var separateTimeMovement:Bool = false;
	public var separateScoreMovement:Bool = false;

    var iconOffset:Int = 26;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (hudadded)
		{
            // var mult:Float = FlxMath.lerp(1, iconP1.scale.x, CoolUtil.boundTo(1 - (elapsed * 9 * PlayState.instance.playbackRate), 0, 1));
			// iconP1.scale.set(mult, mult);
			// iconP1.updateHitbox();

			// var mult:Float = FlxMath.lerp(1, iconP2.scale.x, CoolUtil.boundTo(1 - (elapsed * 9 * PlayState.instance.playbackRate), 0, 1));
			// iconP2.scale.set(mult, mult);
			// iconP2.updateHitbox();
    
			iconP1.x = (hudUsed == 'hitmans') ? (FlxG.width - 160) : healthBar.x + (healthBar.width * (FlxMath.remapToRange(percent, 0, 100, 100, 0) * 0.01)) + (150 * iconP1.scale.x - 150) / 2 - iconOffset;
			iconP2.x = (hudUsed == 'hitmans') ? 0 : healthBar.x + (healthBar.width * (FlxMath.remapToRange(percent, 0, 100, 100, 0) * 0.01)) - (150 * iconP2.scale.x) / 2 - iconOffset * 2;
			
            if (healthBar.percent < 20)
				iconP1.animation.curAnim.curFrame = 1;
			else
				iconP1.animation.curAnim.curFrame = 0;

			if (healthBar.percent > 80)
				iconP2.animation.curAnim.curFrame = 1;
			else
				iconP2.animation.curAnim.curFrame = 0;

			if (botplayTxt.visible)
			{
				botplaySine += 180 * elapsed;
				botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
			}

        	//noteRating shit ig but only for x and y LOL

			if (!separateScoreMovement){
				noteScore.x = (ratings.x-510) + comboOffset[0];
				noteScoreOp.x = (ratingsOP.x-510) + comboOffset[0];

				noteScore.y = (ratings.y+100) + comboOffset[1];
				noteScoreOp.y = (ratingsOP.y+100) + comboOffset[1];
			}

			if (!separateBarMovement){
				if (hudUsed == 'hitmans'){
					healthBar.x = healthBarBG.x + 50;
					healthBar.y = healthBarBG.y + 20;
				}else{
					healthBar.x = healthBarBG.x + 4;
					healthBar.y = healthBarBG.y + 4;
				}

				iconP1.y = healthBar.y + iconsYOffset[0];
				iconP2.y = healthBar.y + iconsYOffset[1];
			}

			if (!separateTimeMovement){
				timeBar.x = timeBarBG.x + 4;
				timeBar.y = timeBarBG.y + 4;

				timeTxt.y = timeBarBG.y - 10;
			}
		}
	}

	public var tempScore:String = "";
	public var scoreSeparator:String = ' | ';
	public var displayRatings:Bool = true;

	public function setScore(score:Int, misses:Int, ratingn:String, ratingp:Float, fc:String, comboPL:Int, comboOP:Int, separateCombo:Bool){
		if (hudadded)
		{
			songScore = score;
			songMisses = misses;
			ratingName = ratingn;
			ratingPercent = ratingp;
			ratingFC = fc;

			// of course I would go back and fix my code, of COURSE @BeastlyGhost;
			tempScore = 'Score: ' + songScore;
			
			if (displayRatings)
			{
				ratingString = scoreSeparator + 'Misses: ' + songMisses;
				ratingString += scoreSeparator + 'Rating: ' + ratingName;
				ratingString += (ratingName != '?' ? ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' : '');
				ratingString += (ratingFC != null && ratingFC != '' ? ' - ' + ratingFC : '');
			}

			tempScore += ratingString + '\n';
			scoreTxt.text = tempScore;

			noteScore.alpha = comboPL <= 3 ? 0 : 1;
			noteScore.text = Std.string(comboPL);

			if (separateCombo){
				noteScoreOp.alpha = comboOP <= 3 ? 0 : 1;
				noteScoreOp.text = Std.string(comboOP);
			}else{
				noteScoreOp.text = Std.string(comboPL);
				noteScoreOp.alpha = comboPL <= 3 ? 0 : 1;
			}
		}
	}

	public function setTime(time:Float){
		if (updateTime)
		{
			var curTime:Float = Conductor.songPosition - ClientPrefs.data.noteOffset;
			var secondsTotal:Int = Math.floor(curTime / 1000);
			if (curTime < 0)
				curTime = 0;

			songPercent = (curTime / time);

			if (secondsTotal < 0)
				secondsTotal = 0;

			timeTxt.text = FlxStringUtil.formatTime(secondsTotal, false);

			if (updateTimePos)
				timeTxt.screenCenter(X);
		}
	}

	var percent:Float = 1;
	public function setHealth(curHealth:Float, elapsed:Float, playbackRate:Float){
		if (hudadded){
			health = curHealth;
			percent = FlxMath.lerp(percent, (health*50), (elapsed * 10));
			healthBar.percent = percent;
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
		}
	}

	var checkpointMarkersOnTimebar:Array<AttachedSprite> = [];
	public function markCheckpointOnTimebar(time:Float, hidden:Bool = false){
		if(!hidden){ //Is it hidden? Don't create the marker in the first place then lol
			var marker:AttachedSprite = new AttachedSprite('checkPoint');
			marker.sprTracker = timeBar;
			marker.scrollFactor.set();
			marker.visible = true;
			marker.cameras = [PlayState.instance.camInterfaz];

			marker.color = FlxColor.RED;

			//calculate percent where checkpoint is
			var songLengthDummy = getSongLengthFake();
			
			var curTime:Float = time;

			if(curTime < 0) curTime = 0;
			var whatPercent:Float = (curTime / songLengthDummy);

			trace("Checkpoint at percent " + whatPercent);

			//placing checkpoint on bar
			var timebarWidth:Float = timeBar.width;
			marker.xAdd = (timebarWidth*whatPercent)-2;
			marker.yAdd = -5;
			add(marker);
			checkpointMarkersOnTimebar.push(marker);
		}
	}

	function getSongLengthFake():Float{
		var songLengthDummy = PlayState.instance.songLength;
		return songLengthDummy;
	}

	public function beatHit()
	{
		// if (hudadded)
		// {
		// 	iconP1.scale.set(1.2, 1.2);
		// 	iconP2.scale.set(1.2, 1.2);

		// 	iconP1.updateHitbox();
		// 	iconP2.updateHitbox();
		// }
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
		ratings.scale.x = 1.5 * ratingsScaleMultiplier;
		ratings.scale.y = 1.5 * ratingsScaleMultiplier;
		ratingsBumpTween = FlxTween.tween(ratings.scale, {x: 1.3 * ratingsScaleMultiplier, y: 1.3 * ratingsScaleMultiplier}, 0.1, {ease:FlxEase.circOut,
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
		// if (ClientPrefs.data.hudStyle == 'HITMANS'){
			ratings.visible = true;
			noteScore.visible = true;
		// }
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
		ratingsOP.scale.x = 1.5 * ratingsScaleMultiplier;
		ratingsOP.scale.y = 1.5 * ratingsScaleMultiplier;
		ratingsOPBumpTween = FlxTween.tween(ratingsOP.scale, {x: 1.3 * ratingsScaleMultiplier, y: 1.3 * ratingsScaleMultiplier}, 0.1, {ease:FlxEase.circOut,
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
		// if (ClientPrefs.data.hudStyle == 'HITMANS'){
			ratingsOP.visible = true;
			noteScoreOp.visible = true;
		// }
	}

	public function setRatingAnimation(rat:Float){
		if (rat >= 0){
			if (rat <= ClientPrefs.data.marvelousWindow){
				ratings.animation.play("fantastic");
			} else if (rat <= ClientPrefs.data.sickWindow){
				ratings.animation.play("excellent Early");
			}else if (rat >= ClientPrefs.data.sickWindow && rat <= ClientPrefs.data.goodWindow){
				ratings.animation.play("great Early");
			}else if (rat >= ClientPrefs.data.goodWindow && rat <= ClientPrefs.data.badWindow){
				ratings.animation.play("decent Early");
			}else if (rat >= ClientPrefs.data.badWindow){
				ratings.animation.play("way Off Early");
			}
		} else {
			if (rat >= ClientPrefs.data.marvelousWindow * -1){
				ratings.animation.play("fantastic");
			} else if (rat >= ClientPrefs.data.sickWindow * -1){
				ratings.animation.play("excellent Late");
			}else if (rat <= ClientPrefs.data.sickWindow * -1 && rat >= ClientPrefs.data.goodWindow * -1){
				ratings.animation.play("great Late");
			}else if (rat <= ClientPrefs.data.goodWindow * -1 && rat >= ClientPrefs.data.badWindow * -1){
				ratings.animation.play("decent Late");
			}else if (rat <= ClientPrefs.data.badWindow * -1){
				ratings.animation.play("way Off Late");
			}
		}
	}

	public function setRatingImageOP(rat:Float){
		if (rat >= 0){
			if (rat <= ClientPrefs.data.marvelousWindow){
				ratingsOP.animation.play("fantastic");
			} else if (rat <= ClientPrefs.data.sickWindow){
				ratingsOP.animation.play("excellent Early");
			}else if (rat >= ClientPrefs.data.sickWindow && rat <= ClientPrefs.data.goodWindow){
				ratingsOP.animation.play("great Early");
			}else if (rat >= ClientPrefs.data.goodWindow && rat <= ClientPrefs.data.badWindow){
				ratingsOP.animation.play("decent Early");
			}else if (rat >= ClientPrefs.data.badWindow){
				ratingsOP.animation.play("way Off Early");
			}
		} else {
			if (rat >= ClientPrefs.data.marvelousWindow * -1){
				ratingsOP.animation.play("fantastic");
			} else if (rat >= ClientPrefs.data.sickWindow * -1){
				ratingsOP.animation.play("excellent Late");
			}else if (rat <= ClientPrefs.data.sickWindow * -1 && rat >= ClientPrefs.data.goodWindow * -1){
				ratingsOP.animation.play("great Late");
			}else if (rat <= ClientPrefs.data.goodWindow * -1 && rat >= ClientPrefs.data.badWindow * -1){
				ratingsOP.animation.play("decent Late");
			}else if (rat <= ClientPrefs.data.badWindow * -1){
				ratingsOP.animation.play("way Off Late");
			}
		}
	}
}
