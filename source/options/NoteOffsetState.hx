package options;

import flixel.util.FlxStringUtil;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.math.FlxPoint;
import haxe.Json;
import openfl.Assets;
#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef CustomHud = {
    var CustomHudName:String;
    var HealthBarStyle:String;
    var CountDownStyle:Array<String>;
    var CountDownSounds:Array<String>;
    var RatingStyle:Array<Dynamic>;
    var GameOverStyle:String;
}

class NoteOffsetState extends MusicBeatState
{
	public var camHUD:FlxCamera;
	public var camGame:FlxCamera;
	public var camOther:FlxCamera;

	private static var curSelected:Int = 0;
	private static var curSelecPrefx:Int = 0;
	var currentSelected:Array<String> = ['Offset&Beat', 'HudEditor', 'ChangeSickWindow'];
	var option:Array<String> = ['HudName', 'HealthBarStyle', 'CountDownStyle', 'CountDownSounds', 'RatingStyle', 'GameOverStyle'];

	public var square:FlxSprite;
	public var squareline:FlxSprite;
	public var island:FlxSprite;
	public var island1:FlxSprite;
	public var island2:FlxSprite;
	public var island3:FlxSprite;

	var coolText:FlxText;
	var rating:FlxSprite;
	var comboNums:FlxSpriteGroup;
	var dumbTexts:FlxTypedGroup<FlxText>;
	var dumbOpTexts:FlxTypedGroup<FlxText>;

	var barPercent:Float = 0;
	var delayMin:Int = 0;
	var delayMax:Int = 500;
	var timeBarBG:FlxSprite;
	var timeBar:FlxBar;
	var timeTxt:FlxText;
	var beatText:Alphabet;
	var beatTween:FlxTween;

	var blackBoxSide:FlxSprite;

	var changeModeText:FlxText;

	public var styleModAntiCrash:String = 'HITMANS';

	public static var styleMod:String = 'HITMANS';

    public static var customHudName:String = 'CLASSIC';

    public static var healthType:String = 'healthBar';

    public static var countdownType:Array<String> = ["get", "ready", "set", "go"];
    public static var countdownsoundsType:Array<String> = ["intro3", "intro2", "intro1", "introGo"];

    public static var ratingType:Array<Dynamic> = ['', null];

    public static var gameoverType:String = "NEW";

	public var onComboMenu:Bool = true;
	public var onHudMenu:Bool = false;
	public var onBeatOffMenu:Bool = false;

	override public function create()
	{

		var hudJsonPath:String = 'customHuds/' + styleMod + '.json';

        #if MODS_ALLOWED
        var path:String = Paths.modFolders(hudJsonPath);
        if (!FileSystem.exists(path))
        {
            path = Paths.getPreloadPath(hudJsonPath);
        }

        if (!FileSystem.exists(hudJsonPath))
        #else
        var path:String = Paths.getPreloadPath(hudJsonPath);
        if (!Assets.exists(hudJsonPath))
        #end
        {
            path = Paths.getPreloadPath('customHuds/' + styleModAntiCrash + '.json'); 
            // If a json couldn't be found, change it to FNF just to prevent a crash
        }

        #if MODS_ALLOWED
        var rawHudJson = File.getContent(path);
        #else
        var rawHudJson = Assets.getText(path);
        #end

        trace(path);

        var hudJson:CustomHud = cast Json.parse(rawHudJson);

        if (hudJson == null)
			{
				hudJson = {
					CustomHudName: "CLASSIC",
					HealthBarStyle: "CLASSIC",
					CountDownStyle: ["get", "ready", "set", "go"],
					CountDownSounds: ["intro3", "intro2", "intro1", "introGo"],
					RatingStyle: ["", ""],
					GameOverStyle: "gameOver"
				};
			}
	
			if (hudJson.CustomHudName != "")
				hudJson.CustomHudName = customHudName;
			if (hudJson.HealthBarStyle != "")
				hudJson.HealthBarStyle = healthType;
			if (hudJson.CountDownStyle != ["", "", "", ""])
				hudJson.CountDownStyle = countdownType;
			if (hudJson.CountDownSounds != ["", "", "", ""])
				hudJson.CountDownSounds = countdownsoundsType;
			if (hudJson.RatingStyle != ["", ""])
				hudJson.RatingStyle = ratingType;
			if (hudJson.GameOverStyle != "")
				hudJson.GameOverStyle = gameoverType;
	
			ClientPrefs.hudStyle = customHudName;
			ClientPrefs.healthBarStyle = healthType;
			ClientPrefs.countDownStyle = countdownType;
			ClientPrefs.countDownSounds = countdownsoundsType;
			ClientPrefs.ratingStyle = ratingType;
			ClientPrefs.goStyle = gameoverType;

		// Cameras
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camOther = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camOther, false);

		FlxG.cameras.setDefaultDrawTarget(camGame, true);
		CustomFadeTransition.nextCamera = camOther;
		FlxG.camera.scroll.set(120, 130);

		persistentUpdate = true;
		FlxG.sound.pause();

		// Stage

		var bg:BGSprite = new BGSprite('Edwhak/Hitmans/offsetShit/baseBG', 0, 0, 0, 0);
		bg.screenCenter();
		add(bg);

		var extrabg:BGSprite = new BGSprite('Edwhak/Hitmans/offsetShit/bg', 0, 0, 0, 0);
		extrabg.screenCenter();
		extrabg.alpha = 0.1;
		add(extrabg);

		if(!ClientPrefs.lowQuality) {
			island = new FlxSprite().loadGraphic(Paths.image('Edwhak/Hitmans/offsetShit/flotant1'));
			island.scrollFactor.set();
			island.screenCenter();
			island.alpha = 1;
			island.x = 0;
			island.y = 0;
			add(island);

			island1 = new FlxSprite().loadGraphic(Paths.image('Edwhak/Hitmans/offsetShit/flotant2'));
			island1.scrollFactor.set();
			island1.screenCenter();
			island1.alpha = 1;
			island1.x = 0;
			island1.y = 0;
			add(island1);

			island2 = new FlxSprite().loadGraphic(Paths.image('Edwhak/Hitmans/offsetShit/flotant3'));
			island2.scrollFactor.set();
			island2.screenCenter();
			island2.alpha = 1;
			island2.x = 0;
			island2.y = 0;
			add(island2);
			
			island3 = new FlxSprite().loadGraphic(Paths.image('Edwhak/Hitmans/offsetShit/flotant4'));
			island3.scrollFactor.set();
			island3.screenCenter();
			island3.alpha = 1;
			island3.x = 0;
			island3.y = 0;
			add(island3);
		}

		square = new FlxSprite().loadGraphic(Paths.image('Edwhak/Hitmans/offsetShit/square'));
		square.scrollFactor.set();
		square.screenCenter();
		square.alpha = 0.8;
		add(square);

		squareline = new FlxSprite().loadGraphic(Paths.image('Edwhak/Hitmans/offsetShit/square-line'));
		squareline.scrollFactor.set();
		squareline.screenCenter();
		add(squareline);

		var box:BGSprite = new BGSprite('Edwhak/Hitmans/offsetShit/box', 0, 0, 0, 0);
		box.cameras = [camHUD];
	    box.screenCenter();
		add(box);

		// Combo stuff

		blackBoxSide = new FlxSprite().makeGraphic(255, FlxG.height, FlxColor.BLACK);
		blackBoxSide.scrollFactor.set();
		blackBoxSide.alpha = 0.6;
		blackBoxSide.cameras = [camHUD];
		add(blackBoxSide);

		coolText = new FlxText(0, 0, 0, '', 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.35;

		rating = new FlxSprite().loadGraphic(Paths.image('sick'));
		rating.cameras = [camHUD];
		rating.setGraphicSize(Std.int(rating.width * 0.7));
		rating.updateHitbox();
		rating.antialiasing = ClientPrefs.globalAntialiasing;
		
		add(rating);

		comboNums = new FlxSpriteGroup();
		comboNums.cameras = [camHUD];
		add(comboNums);

		var seperatedScore:Array<Int> = [];
		for (i in 0...3)
		{
			seperatedScore.push(FlxG.random.int(0, 9));
		}

		var daLoop:Int = 0;
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite(43 * daLoop).loadGraphic(Paths.image('num' + i));
			numScore.cameras = [camHUD];
			numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			numScore.updateHitbox();
			numScore.antialiasing = ClientPrefs.globalAntialiasing;
			comboNums.add(numScore);
			daLoop++;
		}

		dumbTexts = new FlxTypedGroup<FlxText>();
		dumbTexts.cameras = [camHUD];
		add(dumbTexts);
		dumbOpTexts = new FlxTypedGroup<FlxText>();
		dumbOpTexts.cameras = [camHUD];
		add(dumbOpTexts);
		createTexts();

		repositionCombo();

		// Note delay stuff
		
		beatText = new Alphabet(0, 0, 'Beat Hit!', true);
		beatText.cameras = [camHUD];
		beatText.screenCenter();
		beatText.alpha = 0;
		beatText.acceleration.y = 250;
		beatText.visible = false;
		add(beatText);
		
		timeTxt = new FlxText(0, 625, FlxG.width, "", 32);
		timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeTxt.scrollFactor.set();
		timeTxt.borderSize = 2;
		timeTxt.visible = false;
		timeTxt.cameras = [camHUD];

		barPercent = ClientPrefs.noteOffset;
		updateNoteDelay();
		
		timeBarBG = new FlxSprite(0, timeTxt.y + 8).loadGraphic(Paths.image('timeBar'));
		timeBarBG.setGraphicSize(Std.int(timeBarBG.width * 1.2));
		timeBarBG.updateHitbox();
		timeBarBG.cameras = [camHUD];
		timeBarBG.screenCenter(X);
		timeBarBG.visible = false;

		timeBar = new FlxBar(0, timeBarBG.y + 4, LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), this, 'barPercent', delayMin, delayMax);
		timeBar.scrollFactor.set();
		timeBar.screenCenter(X);
		timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
		timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
		timeBar.visible = false;
		timeBar.cameras = [camHUD];

		add(timeBarBG);
		add(timeBar);
		add(timeTxt);

		///////////////////////

		var blackBox:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 55, FlxColor.BLACK);
		blackBox.scrollFactor.set();
		blackBox.alpha = 0.6;
		blackBox.cameras = [camHUD];
		add(blackBox);

		changeModeText = new FlxText(0, 19, FlxG.width, "", 32);
		changeModeText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		changeModeText.scrollFactor.set();
		changeModeText.cameras = [camHUD];
		add(changeModeText);
		updateMode();

		Conductor.changeBPM(128.0);
		FlxG.sound.playMusic(Paths.music('offsetSong'), 1, true);
		changeSelectedPart(0);

		super.create();
	}

	var holdTime:Float = 0;
	var holdingObjectType:Null<Bool> = null;

	var startMousePos:FlxPoint = new FlxPoint();
	var startComboOffset:FlxPoint = new FlxPoint();

	override public function update(elapsed:Float)
	{
		square.angle = square.angle + 0.025;
		squareline.angle = square.angle + 0.025;
		island.y = Math.sin((Conductor.songPosition/Conductor.crochet)*Math.PI) * 0.5;
		island1.y = Math.sin((Conductor.songPosition/Conductor.crochet)*Math.PI) * 0.3;
		island2.y = Math.sin((Conductor.songPosition/Conductor.crochet)*Math.PI) * 0.6;
		island3.y = Math.sin((Conductor.songPosition/Conductor.crochet)*Math.PI) * 0.8;

		var addNum:Int = 1;
		if(FlxG.keys.pressed.SHIFT) addNum = 10;

		if(onComboMenu)
		{
			var controlArray:Array<Bool> = [
				FlxG.keys.justPressed.LEFT,
				FlxG.keys.justPressed.RIGHT,
				FlxG.keys.justPressed.UP,
				FlxG.keys.justPressed.DOWN,
			
				FlxG.keys.justPressed.A,
				FlxG.keys.justPressed.D,
				FlxG.keys.justPressed.W,
				FlxG.keys.justPressed.S
			];

			if(controlArray.contains(true))
			{
				for (i in 0...controlArray.length)
				{
					if(controlArray[i])
					{
						switch(i)
						{
							case 0:
								ClientPrefs.comboOffset[0] -= addNum;
							case 1:
								ClientPrefs.comboOffset[0] += addNum;
							case 2:
								ClientPrefs.comboOffset[1] += addNum;
							case 3:
								ClientPrefs.comboOffset[1] -= addNum;
							case 4:
								ClientPrefs.comboOffset[2] -= addNum;
							case 5:
								ClientPrefs.comboOffset[2] += addNum;
							case 6:
								ClientPrefs.comboOffset[3] += addNum;
							case 7:
								ClientPrefs.comboOffset[3] -= addNum;
						}
					}
				}
				repositionCombo();
			}

			// probably there's a better way to do this but, oh well.
			if (FlxG.mouse.justPressed)
			{
				holdingObjectType = null;
				FlxG.mouse.getScreenPosition(camHUD, startMousePos);
				if (startMousePos.x - comboNums.x >= 0 && startMousePos.x - comboNums.x <= comboNums.width &&
					startMousePos.y - comboNums.y >= 0 && startMousePos.y - comboNums.y <= comboNums.height)
				{
					holdingObjectType = true;
					startComboOffset.x = ClientPrefs.comboOffset[2];
					startComboOffset.y = ClientPrefs.comboOffset[3];
					//trace('yo bro');
				}
				else if (startMousePos.x - rating.x >= 0 && startMousePos.x - rating.x <= rating.width &&
						 startMousePos.y - rating.y >= 0 && startMousePos.y - rating.y <= rating.height)
				{
					holdingObjectType = false;
					startComboOffset.x = ClientPrefs.comboOffset[0];
					startComboOffset.y = ClientPrefs.comboOffset[1];
					//trace('heya');
				}
			}
			if(FlxG.mouse.justReleased) {
				holdingObjectType = null;
				//trace('dead');
			}

			if(holdingObjectType != null)
			{
				if(FlxG.mouse.justMoved)
				{
					var mousePos:FlxPoint = FlxG.mouse.getScreenPosition(camHUD);
					var addNum:Int = holdingObjectType ? 2 : 0;
					ClientPrefs.comboOffset[addNum + 0] = Math.round((mousePos.x - startMousePos.x) + startComboOffset.x);
					ClientPrefs.comboOffset[addNum + 1] = -Math.round((mousePos.y - startMousePos.y) - startComboOffset.y);
					repositionCombo();
				}
			}

			if(controls.RESET)
			{
				for (i in 0...ClientPrefs.comboOffset.length)
				{
					ClientPrefs.comboOffset[i] = 0;
				}
				repositionCombo();
			}
		}

		if (onBeatOffMenu)
		{
			if(controls.UI_LEFT_P)
			{
				barPercent = Math.max(delayMin, Math.min(ClientPrefs.noteOffset - 1, delayMax));
				updateNoteDelay();
			}
			else if(controls.UI_RIGHT_P)
			{
				barPercent = Math.max(delayMin, Math.min(ClientPrefs.noteOffset + 1, delayMax));
				updateNoteDelay();
			}

			var mult:Int = 1;
			if(controls.UI_LEFT || controls.UI_RIGHT)
			{
				holdTime += elapsed;
				if(controls.UI_LEFT) mult = -1;
			}

			if(controls.UI_LEFT_R || controls.UI_RIGHT_R) holdTime = 0;

			if(holdTime > 0.5)
			{
				barPercent += 100 * elapsed * mult;
				barPercent = Math.max(delayMin, Math.min(barPercent, delayMax));
				updateNoteDelay();
			}

			if(controls.RESET)
			{
				holdTime = 0;
				barPercent = 0;
				updateNoteDelay();
			}
		}

		if(controls.ACCEPT)
		{
			changeSelectedPart(1);
		}

		if(controls.BACK)
		{
			if(zoomTween != null) zoomTween.cancel();
			if(beatTween != null) beatTween.cancel();

			persistentUpdate = false;
			CustomFadeTransition.nextCamera = camOther;
			if (options.OptionsState.isInPause)
                MusicBeatState.switchState(new options.OptionsState(true));
            else{
                MusicBeatState.switchState(new options.OptionsState());
            }
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 1, true);
			FlxG.mouse.visible = false;
		}

		if (curSelecPrefx == 0){
			onComboMenu = false;
			onHudMenu = true;
			onBeatOffMenu = false;
		}else if (curSelecPrefx == 1){
			onComboMenu = false;
			onHudMenu = false;
			onBeatOffMenu = true;
		}else if (curSelecPrefx == 2){
			onComboMenu = true;
			onHudMenu = false;
			onBeatOffMenu = false;
		}

		updateMode();
		Conductor.songPosition = FlxG.sound.music.time;
		super.update(elapsed);
	}

	var zoomTween:FlxTween;
	var lastBeatHit:Int = -1;
	override public function beatHit()
	{
		super.beatHit();

		if(lastBeatHit == curBeat)
		{
			return;
		}
		
		if(curBeat % 4 == 2)
		{
			FlxG.camera.zoom = 1.03;

			if(zoomTween != null) zoomTween.cancel();
			zoomTween = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween)
				{
					zoomTween = null;
				}
			});

			beatText.alpha = 1;
			beatText.y = 320;
			beatText.velocity.y = -150;
			if(beatTween != null) beatTween.cancel();
			beatTween = FlxTween.tween(beatText, {alpha: 0}, 1, {ease: FlxEase.sineIn, onComplete: function(twn:FlxTween)
				{
					beatTween = null;
				}
			});
		}

		lastBeatHit = curBeat;
	}

	function repositionCombo()
	{
		rating.screenCenter();
		rating.x = coolText.x - 40 + ClientPrefs.comboOffset[0];
		rating.y -= 60 + ClientPrefs.comboOffset[1];

		comboNums.screenCenter();
		comboNums.x = coolText.x - 90 + ClientPrefs.comboOffset[2];
		comboNums.y += 80 - ClientPrefs.comboOffset[3];
		reloadTexts();
	}

	function createTexts()
	{
		for (i in 0...4)
		{
			var text:FlxText = new FlxText(10, 48 + (i * 30), 0, '', 24);
			text.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text.scrollFactor.set();
			text.borderSize = 2;
			dumbTexts.add(text);
			text.cameras = [camHUD];
			text.x += 20;
			text.y += 20;

			if(i > 1)
			{
				text.y += 24;
			}
		}
		for (i in 0...14)
			{
				var text:FlxText = new FlxText(10, 48 + (i * 30), 0, '', 24);
				text.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				text.scrollFactor.set();
				text.borderSize = 2;
				dumbOpTexts.add(text);
				text.cameras = [camHUD];
				text.x += 20;
				text.y += 20;
	
				if(i > 1)
				{
					text.y += 24;
				}
			}
	}

	function reloadTexts()
	{
		for (i in 0...dumbTexts.length)
		{
			switch(i)
			{
				case 0: dumbTexts.members[i].text = 'Rating Offset:';
				case 1: dumbTexts.members[i].text = '[' + ClientPrefs.comboOffset[0] + ', ' + ClientPrefs.comboOffset[1] + ']';
				case 2: dumbTexts.members[i].text = 'Numbers Offset:';
				case 3: dumbTexts.members[i].text = '[' + ClientPrefs.comboOffset[2] + ', ' + ClientPrefs.comboOffset[3] + ']';
			}
		}
		for (i in 0...dumbOpTexts.length)
			{
				switch(i)
				{
					case 0: dumbOpTexts.members[i].text = 'Hud Mode:';
					case 1: dumbOpTexts.members[i].text = '[' + ClientPrefs.customHudName + ']';
					case 2: dumbOpTexts.members[i].text = 'Hud Name:';
					case 3: dumbOpTexts.members[i].text = '[' + ClientPrefs.hudStyle + ']';
					case 4: dumbOpTexts.members[i].text = 'HealthBar Type:';
					case 5: dumbOpTexts.members[i].text = '[' + ClientPrefs.healthBarStyle + ']';
					case 6: dumbOpTexts.members[i].text = 'CountDown Type:';
					case 7: dumbOpTexts.members[i].text = '[' + ClientPrefs.countDownStyle + ']';
					case 8: dumbOpTexts.members[i].text = 'CountDownSound Type:';
					case 9: dumbOpTexts.members[i].text = '[' + ClientPrefs.countDownSounds + ']';
					case 10: dumbOpTexts.members[i].text = 'Rating Type:';
					case 11: dumbOpTexts.members[i].text = '[' + ClientPrefs.ratingStyle + ']';
					case 12: dumbOpTexts.members[i].text = 'GameOver Type:';
					case 13: dumbOpTexts.members[i].text = '[' + ClientPrefs.goStyle + ']';
				}
			}
	}

	function updateNoteDelay()
	{
		ClientPrefs.noteOffset = Math.round(barPercent);
		timeTxt.text = 'Current offset: ' + Math.floor(barPercent) + ' ms';
	}

	function updateMode()
	{
		rating.visible = onComboMenu;
		comboNums.visible = onComboMenu;
		dumbTexts.visible = onComboMenu;

		blackBoxSide.visible = !onBeatOffMenu;

		dumbOpTexts.visible = onHudMenu;
		
		timeBarBG.visible = onBeatOffMenu;
		timeBar.visible = onBeatOffMenu;
		timeTxt.visible = onBeatOffMenu;
		beatText.visible = onBeatOffMenu;

		if(onComboMenu)
			changeModeText.text = '< Combo Offset (Press Accept to Switch) >';
		else if (onBeatOffMenu)
			changeModeText.text = '< Note/Beat Delay (Press Accept to Switch) >';
		else if (onHudMenu)
			changeModeText.text = '< Hud Customizer (Press Accept to Switch) >';

		changeModeText.text = changeModeText.text.toUpperCase();
		FlxG.mouse.visible = onComboMenu;
	}

	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = option.length - 1;
		if (curSelected >= option.length)
			curSelected = 0;

		var bullShit:Int = 0;

		// for (item in grpOptions.members) {
		// 	item.targetY = bullShit - curSelected;
		// 	bullShit++;

		// 	item.alpha = 0.6;
		// 	if (item.targetY == 0) {
		// 		item.alpha = 1;
		// 		selectorLeft.x = item.x - 63;
		// 		selectorLeft.y = item.y;
		// 		selectorRight.x = item.x + item.width + 15;
		// 		selectorRight.y = item.y;
		// 	}
		// }
	}

	function changeSelectedPart(change:Int = 0) {
		curSelecPrefx += change;
		if (curSelecPrefx < 0)
			curSelecPrefx = currentSelected.length - 1;
		if (curSelecPrefx >= currentSelected.length)
			curSelecPrefx = 0;
	}
}
