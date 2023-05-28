package;

import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxSave;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class ResultScreen extends FlxSpriteGroup
{
	var bgFade:FlxSprite;
	var background:FlxBackdrop;
	var topUp:FlxSprite;
	var topDown:FlxSprite;
	var numbers:FlxText;
	var song:FlxText;
	var newBest:FlxText;
	var acctxt:FlxText;
	var comtxt:FlxText;
	var sicktxt:FlxText;
	var goodtxt:FlxText;
	var badtxt:FlxText;
	var shittxt:FlxText;
	var misstxt:FlxText;
	var wrongtxt:FlxText;
	var rating:FlxSprite;

	var ranking:FlxText;

	var lerpscore:Int = 0;
	var lerpacc:Float = 0;
	var lerpcom:Int = 0;

	var dascore:Int;
	var daacc:Float;
	var dacom:Int;
	var daBest:Int;

	var hasModchart:FlxText;

	var ended:Bool = false;

	public var end:Void->Void;

	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	public function new(score:Int, oldBest:Int, maxc:Int, acc:Float, sicks:Int, goods:Int, bads:Int, shits:Int, misses:Int)
	{
		super();

		dascore = score;
		daacc = acc;
		dacom = maxc;
		daBest = oldBest;

		background = new FlxBackdrop(Paths.getPath('images/rating/background.png', IMAGE),XY, 0,0);
		background.velocity.set(100, 50);
		background.alpha = 1;
		add(background);

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFF000000);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0.7;
		add(bgFade);

		topDown = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/rating/results-down.png', IMAGE));
		topDown.scrollFactor.set();
		topDown.alpha = 1;
		add(topDown);

		topUp = new FlxSprite(0, 0).loadGraphic(Paths.getPath('images/rating/results-up.png', IMAGE));
		topUp.scrollFactor.set();
		topUp.alpha = 1;
		add(topUp);

		numbers = new FlxText(850, 80, Std.int(FlxG.width * 0.6), "0", 120);
		numbers.font = "Assassin Nation Regular";
		numbers.color = 0xffff0000;
		numbers.alpha = 0;
		add(numbers);

		newBest = new FlxText(850, 195, Std.int(FlxG.width * 0.6), "0", 30);
		newBest.font = "Assassin Nation Regular";
		newBest.color = 0xffff0000;
		newBest.alpha = 0;
		add(newBest);

		song = new FlxText(50, 70, Std.int(FlxG.width * 0.6),PlayState.SONG.song, 88);
		song.font = "Assassin Nation Regular";
		song.alpha = 0;
		add(song);

		ranking = new FlxText(10, FlxG.height - 50, Std.int(FlxG.width * 0.6),"Rank ", 40);
		ranking.font = "Assassin Nation Regular";
		ranking.alpha = 0;
		add(ranking);

		acctxt = new FlxText(550, 225, Std.int(FlxG.width * 0.6), "Accuracy: 0%", 50);
		acctxt.font = "Assassin Nation Regular";
		
		acctxt.alpha = 0;
		add(acctxt);

		comtxt = new FlxText(550, 315, Std.int(FlxG.width * 0.6), "Max Combo: 0", 60);
		comtxt.font = "Assassin Nation Regular";

		comtxt.alpha = 0;
		add(comtxt);

		hasModchart = new FlxText(772.1,435.2, Std.int(FlxG.width * 0.6),"MODCHART DISABLED", 34);
		hasModchart.font = "Assassin Nation Regular";
		hasModchart.alpha = 0;
		add(hasModchart);

		rating = new FlxSprite(872.1,435.2);
		rating.frames = Paths.getSparrowAtlas('rating/ratings');
		rating.animation.addByPrefix('PERFECT', 'PLUS', 24, true);
		rating.animation.addByPrefix('S', 'S', 24, true);
		rating.animation.addByPrefix('A', 'A', 24, true);
		rating.animation.addByPrefix('B', 'B', 24, true);
		rating.animation.addByPrefix('C', 'C', 24, true);
		rating.animation.addByPrefix('D', 'D', 24, true);
        rating.animation.addByPrefix('E', 'E', 24, true);
        rating.animation.addByPrefix('F', 'F', 24, true);
        rating.animation.addByPrefix('?', '?', 24, true);
		rating.antialiasing = true;
		rating.updateHitbox();
		rating.scrollFactor.set();
		add(rating);

		sicktxt = new FlxText(10, 220, Std.int(FlxG.width * 0.6), "PERFECTS AND EXELENTS: " + sicks, 30);
		sicktxt.font = "Assassin Nation Regular";
		sicktxt.autoSize = false;
		sicktxt.alpha = 0;
		add(sicktxt);
		goodtxt = new FlxText(10, 260, Std.int(FlxG.width * 0.6), "GOODS: " + goods, 30);
		goodtxt.font = "Assassin Nation Regular";
		goodtxt.alpha = 0;
		add(goodtxt);
		badtxt = new FlxText(10, 300, Std.int(FlxG.width * 0.6), "DECENTS: " + bads, 30);
		badtxt.font = "Assassin Nation Regular";
		badtxt.alpha = 0;
		add(badtxt);
		shittxt = new FlxText(10, 370, Std.int(FlxG.width * 0.6), "WAYS OFFS: " + shits, 30);
		shittxt.font = "Assassin Nation Regular";
		shittxt.alpha = 0;
		add(shittxt);
		misstxt = new FlxText(10, 440, Std.int(FlxG.width * 0.6), "MISSES: " + misses, 30);
		misstxt.font = "Assassin Nation Regular";
		misstxt.alpha = 0;
		add(misstxt);
		FlxG.sound.playMusic(Paths.music('result'));
	}

	public function load()
	{
	}

	override function update(elapsed:Float)
	{
		lerpscore = Math.round(FlxMath.lerp(lerpscore, dascore, 0.2));
		lerpacc = Math.round(FlxMath.lerp(lerpacc, daacc, 0.2) * 100) / 100;
		lerpcom = Math.round(FlxMath.lerp(lerpcom, Math.abs(dacom), 0.2));
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

		numbers.alpha += 0.1;
		acctxt.alpha += 0.1;
		comtxt.alpha += 0.1;
		ranking.alpha += 0.1;
		song.alpha += 0.1;
		if (!PlayState.instance.notITGMod){
			hasModchart.alpha += 0.1;
		}
		if (lerpscore == dascore)
		{
			if (rating.animation.curAnim == null)
			{
				if (daacc == 100)
					rating.animation.play("PERFECT");
				else if (daacc >= 95)
					rating.animation.play("S");
				else if (daacc >= 90)
					rating.animation.play("S");
				else if (daacc >= 80)
					rating.animation.play("A");
				else if (daacc >= 70)
					rating.animation.play("B");
				else if (daacc >= 60)
					rating.animation.play("C");
                else if (daacc >= 50)
					rating.animation.play("D");
                else if (daacc <= 40)
					rating.animation.play("E");
				else if (daacc <= 30)
					rating.animation.play("F");
                else if (daacc <= 1)
                    rating.animation.play("?");
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
				
			sicktxt.alpha += 0.05;
			goodtxt.alpha += 0.05;
			badtxt.alpha += 0.05;
			shittxt.alpha += 0.05;
			misstxt.alpha += 0.05;
			if ((controls.ACCEPT || controls.BACK) && !ended)
			{
				end();
				ended = true;
				PlayState.inResultsScreen = false;
			}
		}

		super.update(elapsed);
	}
}