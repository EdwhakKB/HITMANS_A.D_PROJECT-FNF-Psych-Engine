package;

import flixel.FlxSubState;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import PauseSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import SystemOptions;
import flixel.FlxG;
import CoolUtil;
import flixel.FlxCamera;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;
#if sys
import sys.FileSystem;
#end

using StringTools;

class BossTierState extends MusicBeatState
{
	private var camBoss:FlxCamera;

    public static var bossLevel:Float = 0.0;
	public static var bossCharacter:String = 'default';

	public static var instance:BossTierState = null;

    public var continueText:FlxText;

	#if HSCRIPT_ALLOWED
	public var hscriptArray:Array<SSHScript> = [];
	public var instancesExclude:Array<String> = [];
	#end

	public var bossScript:ScriptHandler = null;

    override public function create()
    {
		persistentUpdate = true;
		persistentDraw = true;
		bossScript = new ScriptHandler(Paths.scriptsForHandler(bossCharacter, 'data/boss'));

		bossScript.setVar('BossTierState', this);
		bossScript.setVar('add', add);
		bossScript.setVar('insert', insert);
		bossScript.setVar('members', members);
		bossScript.setVar('remove', remove);

		bossScript.callFunc('onCreate', []);

        super.create();

        continueText = new FlxText((FlxG.width/2) +(FlxG.width/4), FlxG.height-25-30, 0, "PRESS ENTER TO CONTINUE");
		continueText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.alpha = 1;
		continueText.visible = false;
		add(continueText);

		bossScript.callFunc('onCreatePost', []);

       /*new FlxTimer().start(1, function(twn:FlxTimer) {
            setupBossFight();
            setupIntro(false);
        });*/
    }

	override public function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		bossScript.callFunc('onUpdate', [elapsed]);
		bossScript.callFunc('onUpdatePost', [elapsed]);
		super.update(elapsed);
	}

	function setupBossFight(){
		bossScript.callFunc('setupBossFight', []);
		var theEnemy = "none";
		switch(bossCharacter.toLowerCase()){
			case 'edwhak', 'he', 'edwhakbroken', 'edkbmassacre':
				theEnemy = "edwhak";
			default:
				theEnemy = bossCharacter.toLowerCase();
		}
		trace("Boss: " + theEnemy);
		var vsCharacter = new FlxSprite(0, 0).loadGraphic(Paths.image('hitmans/death/' + theEnemy));
		if(vsCharacter.graphic == null) //if no graphic was loaded, then load the placeholder
            vsCharacter.loadGraphic(Paths.image('hitmans/death/dawperKill'));
        vsCharacter.screenCenter(XY);
        vsCharacter.scale.set(0.62,0.62);
        vsCharacter.alpha = 1;
        vsCharacter.antialiasing = ClientPrefs.globalAntialiasing;

		var vsBarBg = new FlxSprite(50, FlxG.height - 100).loadGraphic(Paths.image('SimplyLoveHud/HealthBG'));

		var vsBar = new FlxSprite(vsBarBg.x+4, vsBarBg.y+4).makeGraphic(280, 29, FlxColor.RED);
		vsBar.origin.x = 0;
		vsBar.scale.x = 0;

		var vsBackGround = new FlxSprite(0, 0).loadGraphic(Paths.image('rating/background'));
		vsBackGround.setGraphicSize(FlxG.width, FlxG.height);
		vsBackGround.screenCenter();
		vsBackGround.alpha = 0.25;

		var vsBlackBG = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		add(vsBlackBG);
		add(vsBackGround);
		add(vsCharacter);
		add(vsBarBg);
		add(vsBar);
	}

	function setupIntro(enter:Bool = false){
		bossScript.callFunc('setupIntro', []);
	}

	function setupBossIntro(boss:String = 'none')
	{

    }

	override public function beatHit()
	{
		super.beatHit();

		bossScript.setVar('curBeat', [curBeat]);
		bossScript.callFunc('onBeatHit', [curBeat]);
	}

	override public function stepHit()
	{
		super.stepHit();

		bossScript.setVar('curStep', [curStep]);
		bossScript.callFunc('onStepHit', [curStep]);
	}
}