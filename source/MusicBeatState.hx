package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.FlxBasic;

class MusicBeatState extends modcharting.ModchartMusicBeatState
{
	private var curSection:Int = 0;
	private var stepsToDo:Int = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var curBeat2:Float = 0;

	public var curDecStep:Float = 0;
	public var curDecBeat:Float = 0;
	private var controls(get, never):Controls;

	public static var camBeat:FlxCamera;
	public static var isBlack:Bool = false;
	public static var time:Float = 0.7;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	public static var subStates:Array<MusicBeatSubstate> = [];

	override public function destroy()
	{
		// if (subStates != null)
		// {
		// 	while (subStates.length > 5)
		// 	{
		// 		var subState:MusicBeatSubstate = subStates[0];
		// 		if (subState != null)
		// 		{
		// 			trace('Destroying Substates!');
		// 			subStates.remove(subState);
		// 			subState.destroy();
		// 		}
		// 		subState = null;
		// 	}

		// 	subStates.resize(0);
		// }

		super.destroy();
	}

	override function create() {

		destroySubStates = false;

		camBeat = FlxG.camera;
		var skip:Bool = FlxTransitionableState.skipNextTransOut;
		#if MODS_ALLOWED Mods.updatedOnState = false; #end

		var mousecursor:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mouse', 'shared'));
		mousecursor.scale.set(0.5, 0.5);
        FlxG.mouse.load(mousecursor.pixels);

		// var pcInterfas:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('MenuShit/PCInterfas'));
		// pcInterfas.updateHitbox();
		// pcInterfas.screenCenter();
		// pcInterfas.antialiasing = ClientPrefs.globalAntialiasing;
		// add(pcInterfas);
		super.create();

		if(!skip) {
			openSubState(new CustomFadeTransition(time, true, isBlack));
		}
		FlxTransitionableState.skipNextTransOut = false;
	}

	override function update(elapsed:Float)
	{
		//everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep)
		{
			if(curStep > 0)
				stepHit();

			if(PlayState.SONG != null)
			{
				if (oldStep < curStep)
					updateSection();
				else
					rollbackSection();
			}
		}

		if(FlxG.save.data != null) FlxG.save.data.fullscreen = FlxG.fullscreen;

		super.update(elapsed);
	}

	private function updateSection():Void
	{
		if(stepsToDo < 1) stepsToDo = Math.round(getBeatsOnSection() * 4);
		while(curStep >= stepsToDo)
		{
			curSection++;
			var beats:Float = getBeatsOnSection();
			stepsToDo += Math.round(beats * 4);
			sectionHit();
		}
	}

	private function rollbackSection():Void
	{
		if(curStep < 0) return;

		var lastSection:Int = curSection;
		curSection = 0;
		stepsToDo = 0;
		for (i in 0...PlayState.SONG.notes.length)
		{
			if (PlayState.SONG.notes[i] != null)
			{
				stepsToDo += Math.round(getBeatsOnSection() * 4);
				if(stepsToDo > curStep) break;
				
				curSection++;
			}
		}

		if(curSection > lastSection) sectionHit();
	}

	private function updateBeat():Void
	{
		curBeat2 = curStep/4; //so i can grab the decimal variables
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

	public static function switchState(nextState:FlxState, ?usesBlack:Bool = false, ?datime:Float = 0.7) {
		// Custom made Trans in
		isBlack = usesBlack;
		time = datime;
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		if(!FlxTransitionableState.skipNextTransIn) {
			leState.openSubState(new CustomFadeTransition(time, false, isBlack));
			if(nextState == FlxG.state) {
				CustomFadeTransition.finishCallback = function() {
					FlxG.resetState();
				};
				//trace('resetted');
			} else {
				CustomFadeTransition.finishCallback = function() {
					FlxG.switchState(nextState);
				};
				//trace('changed state');
			}
			return;
		}
		FlxTransitionableState.skipNextTransIn = false;
		FlxG.switchState(nextState);
	}

	public static function resetState() {
		MusicBeatState.switchState(FlxG.state);
	}

	public static function getState():MusicBeatState {
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		return leState;
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
		
		beatDecimalHit();
	}

	public function beatHit():Void
	{
		//trace('Beat: ' + curBeat);
	}

	public function beatDecimalHit():Void
	{
		//trace('Beat: ' + curBeat);
	}

	public function sectionHit():Void
	{
		//trace('Section: ' + curSection + ', Beat: ' + curBeat + ', Step: ' + curStep);
	}

	function getBeatsOnSection()
	{
		var val:Null<Float> = 4;
		if(PlayState.SONG != null && PlayState.SONG.notes[curSection] != null) val = PlayState.SONG.notes[curSection].sectionBeats;
		return val == null ? 4 : val;
	}

	// Esto no importa donde va
	public function refresh()
    {
      sort(math.Zutils.byZIndex, flixel.util.FlxSort.ASCENDING);
    }

	public function refreshZ()
	{
		sort(math.Zutils.byZ, flixel.util.FlxSort.ASCENDING);
	}
}
