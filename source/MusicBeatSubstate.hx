package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxBasic;
import flixel.FlxSprite;

class MusicBeatSubstate extends FlxSubState
{

	var crtFilter:FlxSprite;
	var whiteAnimeshoun:FlxSprite;
	var camAnimeshoun:FlxSprite;
	var staticAnimeshoun:FlxSprite;
	var constantstaticAnimeshoun:FlxSprite;

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

		camAnimeshoun = new FlxSprite();
		camAnimeshoun.frames = Paths.getSparrowAtlas('overlays/cam_fuck');
		camAnimeshoun.animation.addByPrefix('idle', 'cam-idle', 24, true);
		camAnimeshoun.screenCenter();
		camAnimeshoun.scrollFactor.set();
		camAnimeshoun.antialiasing = false;
		camAnimeshoun.animation.play('idle', true);

		staticAnimeshoun = new FlxSprite();
		staticAnimeshoun.frames = Paths.getSparrowAtlas('static/static');
		staticAnimeshoun.animation.addByPrefix('idle', 'idle', 24, true);
		staticAnimeshoun.screenCenter();
		staticAnimeshoun.scrollFactor.set();
		staticAnimeshoun.animation.play('idle');
		staticAnimeshoun.visible = false;

		constantstaticAnimeshoun = new FlxSprite();
		constantstaticAnimeshoun.frames = Paths.getSparrowAtlas('static/static');
		constantstaticAnimeshoun.animation.addByPrefix('idle', 'idle', 24, true);
		constantstaticAnimeshoun.screenCenter();
		constantstaticAnimeshoun.scrollFactor.set();
		constantstaticAnimeshoun.animation.play('idle');
		constantstaticAnimeshoun.visible = false;
	}

	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;

	private var curDecStep:Float = 0;
	private var curDecBeat:Float = 0;
	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override function update(elapsed:Float)
	{
		//everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();


		super.update(elapsed);
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
		curDecBeat = curDecStep/4;
	}

	private function updateCurStep():Void
	{
		var lastChange = Conductor.getBPMFromSeconds(Conductor.songPosition);

		var shit = ((Conductor.songPosition - ClientPrefs.noteOffset) - lastChange.songTime) / lastChange.stepCrochet;
		curDecStep = lastChange.stepTime + shit;
		curStep = lastChange.stepTime + Math.floor(shit);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		//do literally nothing dumbass
	}

	public function addCameraOverlay(){
		// add(constantstaticAnimeshoun);
		// add(staticAnimeshoun);
		add(whiteAnimeshoun);
		add(camAnimeshoun);
		add(crtFilter);
	}

	public function removeCameraOverlay(){
		// remove(constantstaticAnimeshoun);
		// remove(staticAnimeshoun);
		remove(whiteAnimeshoun);
		remove(camAnimeshoun);
		remove(crtFilter);
	}

	public function hideCameraOverlay(hide:Bool = false){
		camAnimeshoun.visible = !hide;
		crtFilter.visible = !hide;
		// staticAnimeshoun.visible = !hide;
		whiteAnimeshoun.visible = !hide;
		// constantstaticAnimeshoun.visible = !hide;
	}
}
