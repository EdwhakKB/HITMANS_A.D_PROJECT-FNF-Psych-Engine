package;

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
import haxe.ds.StringMap;
import flixel.system.FlxSound;
import Controls.Control;
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class ResultScreen extends FlxSpriteGroup
{
	var bgFade:FlxSprite;
	var background:FlxSprite;
	var topUp:FlxSprite;
	var topDown:FlxSprite;
	var numbers:FlxText;

	var song:FlxText;

	public static var rsNoteData = new StringMap();

	var ratingColours = {
		perfect: 0xFF00CCFF,
		excelent: 0xFFFFE600,
		great: 0xFF00B400,
		decent: 0xFF8C00FF,
		wayoff: 0xFFFF4800,
		miss: 0xFFFF0000
	}

	var isOnGraphMode:Bool = false;
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

	var noModchart:FlxSprite;

	var ended:Bool = false;

	public var end:Void->Void;

	public function new(score:Int, oldBest:Int, maxc:Int, acc:Float, fantastic:Int, excelent:Int, great:Int, decent:Int, wayoff:Int, miss:Int)
	{
		super();

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
        panel.antialiasing = ClientPrefs.globalAntialiasing;
        add(panel);

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFF000000);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0.7;
		add(bgFade);

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

		fantastictxt = new FlxText(70, 220, Std.int(FlxG.width * 0.6), "FANTASTIC: " + fantastic, 30);
		fantastictxt.font = "Assassin Nation Regular";
		fantastictxt.autoSize = false;
		fantastictxt.alpha = 0;
		add(fantastictxt);

		excelenttxt = new FlxText(70, 260, Std.int(FlxG.width * 0.6), "EXCELENTS: " + excelent, 30);
		excelenttxt.font = "Assassin Nation Regular";
		excelenttxt.autoSize = false;
		excelenttxt.alpha = 0;
		add(excelenttxt);

		greattxt = new FlxText(70, 300, Std.int(FlxG.width * 0.6), "GREATS: " + great, 30);
		greattxt.font = "Assassin Nation Regular";
		greattxt.alpha = 0;
		add(greattxt);

		wayofftxt = new FlxText(70, 340, Std.int(FlxG.width * 0.6), "DECENTS: " + decent, 30);
		wayofftxt.font = "Assassin Nation Regular";
		wayofftxt.alpha = 0;
		add(wayofftxt);

		decenttxt = new FlxText(70, 380, Std.int(FlxG.width * 0.6), "WAYS OFFS: " + wayoff, 30);
		decenttxt.font = "Assassin Nation Regular";
		decenttxt.alpha = 0;
		add(decenttxt);

		misstxt = new FlxText(70, 420, Std.int(FlxG.width * 0.6), "MISSES: " + miss, 30);
		misstxt.font = "Assassin Nation Regular";
		misstxt.alpha = 0;
		add(misstxt);

		hitGraphBG = new FlxSprite(140, 210).makeGraphic(507, 300, FlxColor.BLACK);
		hitGraphBG.alpha = 0;
		hitGraphBG.visible = false;
		add(hitGraphBG);

		zeroMs = new FlxText(hitGraphBG.x - 100, (hitGraphBG.y + (hitGraphBG.height / 2)) - 10, 100, '0ms', 16);
		zeroMs.font = "Assassin Nation Regular";
		zeroMs.borderStyle = OUTLINE;
		zeroMs.borderSize = 2;
		zeroMs.alignment = 'right';
		zeroMs.visible = false;
		add(zeroMs);
		zeroMs.alpha = 0;

		topMs = new FlxText(hitGraphBG.x - 100, hitGraphBG.y + 69, 100, (ClientPrefs.downScroll ? '-' : '') + floorDecimal((ClientPrefs.safeFrames / 60) * 1000, 2) + 'ms', 16);
		topMs.font = "Assassin Nation Regular";
		topMs.borderStyle = OUTLINE;
		topMs.borderSize = 2;
		topMs.alignment = 'right';
		topMs.visible = false;
		add(topMs);
		topMs.alpha = 0;

		bottomMs = new FlxText(hitGraphBG.x - 100, (hitGraphBG.y + hitGraphBG.height) - 87, 100, (ClientPrefs.downScroll ? '' : '-') + floorDecimal((ClientPrefs.safeFrames / 60) * 1000, 2) + 'ms', 16);
		bottomMs.font = "Assassin Nation Regular";
		bottomMs.borderStyle = OUTLINE;
		bottomMs.borderSize = 2;
		bottomMs.alignment = 'right';
		bottomMs.visible = false;
		add(bottomMs);
		bottomMs.alpha = 0;

		// for (i in 0...noteId) makeNote(i);

		if (FlxG.sound.music != null) FlxG.sound.music.stop();

		if(ClientPrefs.pauseMusic != 'None') music = new FlxSound().loadEmbedded(Paths.music(convertPauseMenuSong(ClientPrefs.pauseMusic)), true);
		music.volume = 0.5;
		FlxG.sound.list.add(music);
		music.play();

		// FlxG.sound.playMusic(Paths.music('result'));
	}

	public function switchResult(hitGraph:Bool)
	{
		if (!hitGraph){
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

			hitGraphBG.visible = false;
			zeroMs.visible = false;
			topMs.visible = false;
			bottomMs.visible = false;
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

			hitGraphBG.visible = true;
			zeroMs.visible = true;
			topMs.visible = true;
			bottomMs.visible = true;
		}
	}

	public function floorDecimal(value:Float, decimals:Int):Float
	{
		if(decimals < 1)
			return Math.floor(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;

		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

	public function convertPauseMenuSong(name:String) {
		name = name.toLowerCase();
		name = StringTools.replace(name, ' ', '-');
		return name;
	}

	function calculateMean():Float {
		var result:Float;
	
		for (i in 0...noteId) result += (rsNoteData.get('note' + i).diff);
		result /= noteId;
		result = floorDecimal(result, 2);
	
		return result;
	}
	
	public static function onGoodNoteHitPlayState(note:Note) {
		if (!note.isSustainNote) {
			noteId++;
			rsNoteData.set('note' + noteId, {
				strumTime: note.strumTime,
				rating: note.rating,
				diff: (note.strumTime - Conductor.songPosition) / game.playbackRate,
				missed: false
			});
		}
	
		if (game.combo > highestCombo) highestCombo = combo;
	}
	
	public static function onNoteMissPlayState(note:Note) {
		noteId++;
		rsNoteData.set('note' + noteId, {
			strumTime: note.strumTime,
			rating: note.rating,
			diff: (note.strumTime - Conductor.songPosition) / game.playbackRate,
			missed: true
		});
	}
	
	function makeNote(id) { // i tried stamp but it didn't work so this'll do for now
		var note = new FlxSprite((hitGraphBG.x + 5) + (rsNoteData.get('note' + id).strumTime / (FlxG.sound.music.length / hitGraphBG.width)),
		ClientPrefs.downScroll ? (hitGraphBG.y + (hitGraphBG.height / 2)) - (rsNoteData.get('note' + id).diff / 2) - 10: (hitGraphBG.y + (hitGraphBG.height / 2)) + (rsNoteData.get('note' + id).diff / 2)).makeGraphic(5, 5, !rsNoteData.get('note' + id).miss ? switch(rsNoteData.get('note' + id).rating) {
			case 'perfect': ratingColours.perfect;
			case 'excelent': ratingColours.excelent;
			case 'great': ratingColours.great;
			case 'decent': ratingColours.decent;
			case 'wayoff': ratingColours.wayoff;
		} : ratingColours.miss);
	
		add(note);
		note.camera = game.camOther;
	
		note.active = false;
		note.alive = false;
	}

	override function update(elapsed:Float)
	{

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

			hitGraphBG.alpha = 0.7;
			zeroMs.alpha += 0.05;
			topMs.alpha += 0.05;
			bottomMs.alpha += 0.05;

			if ((FlxG.keys.justPressed.CONTROL) && !ended)
			{
				isOnGraphMode = !isOnGraphMode;
				switchResult(isOnGraphMode);
			}
			if ((FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed) && !ended)
			{
				end();
				ended = true;
				PlayState.inResultsScreen = false;
			}
		}

		super.update(elapsed);
	}
}
