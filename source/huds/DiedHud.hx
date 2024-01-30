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

/*
	so this is going to be OPT ig?
	i don't like how it currently looks so i'll try to improve it
	so if you want to add something to it, feel free to make this easier ed
	-Edwhak
*/
class DiedHud extends FlxGroup
{

    var crtFilter:FlxSprite;
	var whiteAnimeshoun:FlxSprite;
	var camAnimeshoun:FlxSprite;
	var staticAnimeshoun:FlxSprite;
	var constantstaticAnimeshoun:FlxSprite;

    public static var diedTo:String = "notes";
    public static var killedBy:String = "character";
    public static var lastedTo:Float = 0;
    var time:FlxText;


	public function new()
	{
		super();

        CoolUtil.precacheImage("overlays/ctr","image");
		if (ClientPrefs.downScroll)
			{
				CoolUtil.precacheImage("overlays/white_scanline-ds","image");
			}
			else if (!ClientPrefs.downScroll)
			{
				CoolUtil.precacheImage("overlays/white_scanline","image");
			}
		CoolUtil.precacheImage("overlays/cam_fuck","image");
		CoolUtil.precacheImage("static/static","image");
		crtFilter = new FlxSprite().loadGraphic(Paths.image('overlays/crt'));
		crtFilter.scrollFactor.set();
		crtFilter.antialiasing = true;
		crtFilter.screenCenter();
        crtFilter.alpha = 0.2;

		whiteAnimeshoun = new FlxSprite();
		if (ClientPrefs.downScroll)
		{
			whiteAnimeshoun.frames = Paths.getSparrowAtlas('overlays/white_scanline-ds');
		}
		else if (!ClientPrefs.downScroll)
		{
			whiteAnimeshoun.frames = Paths.getSparrowAtlas('overlays/white_scanline');
		}
		whiteAnimeshoun.animation.addByPrefix('idle', 'scanline', 24, true);
		whiteAnimeshoun.screenCenter();
		whiteAnimeshoun.scrollFactor.set();
		whiteAnimeshoun.antialiasing = true;
		whiteAnimeshoun.animation.play('idle');
        whiteAnimeshoun.alpha = 0.1;

		camAnimeshoun = new FlxSprite();
		camAnimeshoun.frames = Paths.getSparrowAtlas('overlays/safeMode');
		camAnimeshoun.animation.addByPrefix('idle', 'cam-idle', 24, true);
		camAnimeshoun.screenCenter();
		camAnimeshoun.scrollFactor.set();
		camAnimeshoun.antialiasing = false;
		camAnimeshoun.animation.play('idle', true);
        camAnimeshoun.alpha = 1;

		staticAnimeshoun = new FlxSprite();
		staticAnimeshoun.frames = Paths.getSparrowAtlas('static/static');
		staticAnimeshoun.animation.addByPrefix('idle', 'idle', 24, true);
		staticAnimeshoun.screenCenter();
		staticAnimeshoun.scrollFactor.set();
		staticAnimeshoun.animation.play('idle');
		staticAnimeshoun.visible = false;
        staticAnimeshoun.alpha = 1;

		create();

        addCameraOverlay();
        hideCameraOverlay(false);
	}

	function create():Void
	{
        time = new FlxText(925, FlxG.height - 80, Std.int(FlxG.width * 0.6), "0:00", 25);
        time.setFormat(Paths.font("vcr.ttf"), 25, 0xffffffff);
		time.alpha = 1;
		add(time);

        var showTime:String = FlxStringUtil.formatTime(FlxMath.roundDecimal(Conductor.songPosition / 1000, 2), false) + ' / ' + FlxStringUtil.formatTime(FlxMath.roundDecimal(FlxG.sound.music.length / 1000, 2), false);

		var deathtext:FlxText = new FlxText(30, FlxG.height - 80, 0, "Killed By: ", 32);
		deathtext.text += diedTo;
		deathtext.scrollFactor.set();
		deathtext.setFormat(Paths.font('vcr.ttf'), 32);
		deathtext.updateHitbox();
		add(deathtext);

		var lastedMax:FlxText = new FlxText(870, FlxG.height - 130, 0, "", 32);
		lastedMax.text = "Lasted: " + showTime;
		lastedMax.scrollFactor.set();
		lastedMax.setFormat(Paths.font('vcr.ttf'), 32);
		lastedMax.updateHitbox();
		add(lastedMax);
    }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
        time.text = DateTools.format(Date.now(), "%Y-%m-%d | %H:%M:%S");
	}

    public function addCameraOverlay(){
        add(staticAnimeshoun);
		add(whiteAnimeshoun);
		add(camAnimeshoun);
		add(crtFilter);
        FlxTween.tween(staticAnimeshoun, {alpha:0.025}, 1, {ease:FlxEase.circOut});
	}

	public function removeCameraOverlay(){
        remove(staticAnimeshoun);
		remove(whiteAnimeshoun);
		remove(camAnimeshoun);
		remove(crtFilter);
	}

	public function hideCameraOverlay(hide:Bool = false){
        staticAnimeshoun.visible = !hide;
		camAnimeshoun.visible = !hide;
		crtFilter.visible = !hide;
		whiteAnimeshoun.visible = !hide;
	}
}
