import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;

function onCreatePost()
{
	new FlxTimer().start(1, function(twn:FlxTimer) {
        setupBossNewFight();
        setupOutro(false);
    });
}

function setupBossNewFight(){
    var vsCharacter = new FlxSprite(0, 0).loadGraphic(Paths.image('hitmans/death/edwhak'));
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

function setupOutro(enter:Bool = false){
    var blackFade = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackFade.alpha = enter ? 0 : 1;
    add(blackFade);
    FlxTween.tween(blackFade, {alpha: enter ? 1 : 0}, 1, {ease: FlxEase.quadInOut});
}