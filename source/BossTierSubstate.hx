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

using StringTools;

class BossIntro extends FlxSpriteGroup
{
		
}

class BossTierSubstate extends MusicBeatSubstate
{
	private var camBoss:FlxCamera;

    public static var bossLevel:Float = 0.0;
	public static var bossCharacter:String = 'default';

    public var continueText:FlxText;

    public function new(enemy:String, lvl:Float)
    {
        super();
        bossCharacter = enemy;
        bossLevel = lvl;
    }

    override public function create()
    {
        super.create();

        camBoss = new FlxCamera();
        FlxG.cameras.reset(camBoss);
        FlxG.cameras.setDefaultDrawTarget(camBoss, true);

        setupIntro(true);

        continueText = new FlxText((FlxG.width/2) +(FlxG.width/4), FlxG.height-25-30, 0, "PRESS ENTER TO CONTINUE");
		continueText.setFormat(Paths.font("DEADLY KILLERS.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		continueText.alpha = 1;
		continueText.visible = false;
		add(continueText);

        new FlxTimer().start(1, function(twn:FlxTimer) {
            setupBossFight();
            setupIntro(false);
        });
    }

	function setupBossFight(){
		var theEnemy = "none";
		switch(bossCharacter.toLowerCase()){
			case 'edwhak':
				theEnemy = "edwhak";
			case 'he':
				theEnemy = "edwhak";
			case 'edwhakbroken':
				theEnemy = "edwhak";
			case 'edkbmassacre':
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
        var blackFade = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackFade.alpha = enter ? 0 : 1;
        add(blackFade);
        FlxTween.tween(blackFade, {alpha: enter ? 1 : 0}, 1, {ease: FlxEase.quadInOut});
	}

	function setupBossIntro(boss:String = 'none')
	{

    }

}