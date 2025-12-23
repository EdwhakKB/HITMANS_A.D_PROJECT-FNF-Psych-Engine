import haxe.Log;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

function onCreate()
{
    Log.trace('Hello');
    new FlxTimer().start(1, function(tmr:FlxTimer)
    {
	    setupBossNewFight();
        setupOutro(false);
    });
    Log.trace('Welcome');
}

function setupBossNewFight(){
    var vsCharacter = new FlxSprite(0, 0).loadGraphic(Paths.image('hitmans/death/edwhak'));
    screenCenter(vsCharacter, 'xy');
    vsCharacter.scale.set(0.62,0.62);
    vsCharacter.alpha = 1;
    vsCharacter.antialiasing = ClientPrefs.data.antialiasing;
    Log.trace('Hello 2');

    var vsBarBg = new FlxSprite(50, FlxG.height - 100).loadGraphic(Paths.image('SimplyLoveHud/HealthBG'));

    Log.trace('Hello 3');

    var vsBar = new FlxSprite(vsBarBg.x+4, vsBarBg.y+4).makeGraphic(280, 29, CustomFlxColor.RED);
    vsBar.origin.x = 0;
    vsBar.scale.x = 0;

    Log.trace('Hello 3.5');

    var vsBackGround = new FlxSprite(0, 0).loadGraphic(Paths.image('rating/background'));
    vsBackGround.setGraphicSize(FlxG.width, FlxG.height);
    vsBackGround.screenCenter();
    vsBackGround.alpha = 0.25;

    Log.trace('Hello 4');

    var vsBlackBG = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, CustomFlxColor.BLACK);

    Log.trace('Hello 4');

    add(vsBlackBG);
    Log.trace('Hello 5');
    add(vsBackGround);
    Log.trace('Hello 6');
    add(vsCharacter);
    Log.trace('Hello 7');
    add(vsBarBg);
    Log.trace('Hello 8');
    add(vsBar);
    Log.trace('Hello 9');
}

function setupOutro(enter:Bool = false){
    Log.trace('Hello 10');
    var blackFade = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, CustomFlxColor.BLACK);
    blackFade.alpha = enter ? 0 : 1;
    add(blackFade);
    Log.trace('Hello 11');
    FlxTween.tween(blackFade, {alpha: enter ? 1 : 0}, 1, {ease: FlxEase.quadInOut});
    Log.trace('Hello 12');
}