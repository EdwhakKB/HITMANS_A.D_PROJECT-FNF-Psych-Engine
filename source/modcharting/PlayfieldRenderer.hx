package modcharting;

// import HazardAFT_Capture.HazardAFT_CaptureMultiCam as MultiCamCapture;
import flixel.util.FlxTimer.FlxTimerManager;
import flixel.tweens.FlxTween.FlxTweenManager;
import flixel.tweens.FlxTween.TweenOptions;
// import modcharting.ArrowPathBitmap;
import modcharting.Modifier;
import modcharting.Proxiefield.Proxie as Proxy;
import objects.Note;
import objects.StrumNote;
import objects.NoteSplash;
import openfl.geom.Vector3D;
import play.PlayState;

/*import flixel.tweens.misc.BezierPathTween;
	import flixel.tweens.misc.BezierPathNumTween; */
// a few todos im gonna leave here:
//--ZORO--
// setup quaternions for everything else (incoming angles and the rotate mod)
// do add and remove buttons on stacked events in editor
// fix switching event type in editor so you can actually do set events (as well as adding "add and value" events - Edwhak)
// finish setting up tooltips in editor (as 4.0 should go, this will be made)
// start documenting more stuff idk (same as 4.0)
//--EDWHAK--
// finish editor itself and fix some errors zoro didn't (mostly on editors)
// Optimize arrowPath and add the other variant (we have "ArrowPathFill" but not "ArrowPath")
// Make editor optimized as well as playfieldRenderer (includes Arrows and Sustains) (most likely it's way to render it's the lag issue)
// Grain shit for sustains (the higger value the most and most soft sustain looks) -- possible, i just don't know how
// Optimize the tool for better performance, would be cool see this thing run on low end PC's
// Editor 4.0 (psych has no windows tabs so i need create my own)
// Fix "Stealth" mods when using playfields (for some reason playfields ask a general change instead of individual even if they are their own note copy??)
// ^^^ this also happens in "McMadness mod" in combo-meal song when notes goes timeStop (added playfields and got same result!!) interesting.

typedef StrumNoteType = objects.StrumNote;
typedef NotefieldData = {
	var field:NoteField;
	var index:Int;
	var memberIndex:Int;
}

class PlayfieldRenderer extends FlxBasic
{
	public var strumGroup:FlxTypedGroup<StrumNoteType>;
	public var notes:FlxTypedGroup<Note>;
	public var instance:ModchartMusicBeatState;
	public var playStateInstance:PlayState;
	// public var editorPlayStateInstance:editors.content.EditorPlayState;
	public var playfields:Array<Playfield> = []; // adding an extra playfield will add 1 for each player
	public var proxiefields:Array<Proxiefield> = [];

	public var eventManager:ModchartEventManager;
	public var modifierTable:ModTable;
	public var tweenManager:FlxTweenManager = null;
	public var timerManager:FlxTimerManager = null;

	public var modchart:ModchartFile;
	public var inEditor:Bool = false;
	public var editorPaused:Bool = false;

	public var rate:Float = 1.0;
	public var speed:Float = 1.0;

	public var modifiers(get, default):Map<String, Modifier>;

	public var isEditor:Bool = false;

	// public var aftCapture:MultiCamCapture = null;

	private function get_modifiers():Map<String, Modifier>
	{
		return modifierTable.modifiers; // back compat with lua modcharts
	}

	public var noteFields:Array<NoteField> = [];
	public var onAddPlayfield:?Int->Void;
	public var allObjects:FlxTypedGroup<ZSprite>;
	public var splashObjects:FlxTypedGroup<ZSprite>;
	public var killOffset:Float = 350;

	override public function set_cameras(cameras:Array<flixel.FlxCamera>):Array<flixel.FlxCamera>
	{
		allObjects.cameras = cameras;
		splashObjects.cameras = cameras;
		for (field in noteFields)
			field.cameras = cameras;
		return super.set_cameras(cameras);
	}

	public function new(strums:FlxTypedGroup<StrumNote>, notes:FlxTypedGroup<Note>, unspawnNotes:Array<Note>, ?instance:ModchartMusicBeatState)
	{
		super();

		strums.visible = notes.visible = false;
	
		this.instance = instance;
		if (Std.isOfType(instance, PlayState))
			playStateInstance = cast instance; // so it just casts once
		/*if (Std.isOfType(instance, editors.content.EditorPlayState))
			{
				editorPlayStateInstance = cast instance; // so it just casts once
				isEditor = true;
		}*/

		// fix stupid crash because the renderer in playstate is still technically null at this point and its needed for json loading
		instance.playfieldRenderer = this;

		tweenManager = new FlxTweenManager();
		timerManager = new FlxTimerManager();
		eventManager = new ModchartEventManager(this);
		modifierTable = new ModTable(instance, this);
		allObjects = new FlxTypedGroup<ZSprite>();
		splashObjects = new FlxTypedGroup<ZSprite>();
		noteFields = [];
		onAddPlayfield = function(?index:Int) {
			try
			{
				final field:NoteField = new NoteField(this, index, strums, notes, unspawnNotes);
				field.pfIndex = index;
				noteFields.push(field);
				field.cameras = cameras;
				return field;
			}
			catch(e:haxe.Exception)
			{
				trace(e.message, e.stack);
				return null;
			}
			return null;
		}
		addPlayfield(0);

		trace(noteFields, noteFields == null, noteFields.length);

		// why ??

		// addNewProxiefield(new Proxy());
		modchart = new ModchartFile(this);
	}

	public var oldFields:Array<NotefieldData> = [];

	public function rescaleNotes(ratio:Float)
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.rescaleNotes(ratio);
	}

	public function clearNotesBefore(time:Float)
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.clearNotesBefore(time);
	}

	public function keyPress(key:Int)
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.keyPress(key);
	}

	public function keyRelease(key:Int)
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.keyRelease(key);
	}

	public function updateNotes(elapsed:Float)
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.updateNotes(elapsed);
	}

	public function handleSustainInput(hold:Array<Bool>)
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.handleSustainInput(hold);
	}

	public function prepareNotes()
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.prepareNotes();
	}

	public function skipIntro()
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.skipIntro();
	}

	public function killNotes()
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.killNotes();
	}

	public function spawnNotes()
	{
		if (noteFields == null || noteFields.length < 2) return;
		for (i in 1...noteFields.length)
			noteFields[i].strumLine.spawnNotes();
	}

	public function forEach(func:NoteField->Void) {
		if (noteFields == null || noteFields.length < 2 || func == null) return;
		for (i in 1...noteFields.length)
			func(noteFields[i]);
	}

	public function addPlayfield(?index:Int)
		onAddPlayfield(index);

	public function insertPlayfield(playfield:NoteField, index:Int)
		noteFields.insert(index, playfield);

	public function removePlayfield(index:Int) // Use Playfield Index, NOT MEMBER INDEX!
	{
		final field:NoteField = noteFields[index];
		field.strumLine.strums.forEach(function(strum:NewModchartArrow) {
			allObjects.remove(strum);
		});
		field.strumLine.notes.forEach(function(note:NewModchartArrow) {
			allObjects.remove(note);
		});
		noteFields.remove(field);
	}

	public function addNewProxiefield(proxy:Proxy)
		proxiefields.push(new Proxiefield(proxy));

	public function compareZ(order:Int, a:ZSprite, b:ZSprite):Int
		return flixel.util.FlxSort.byValues(order, a.z, b.z);

	public function resortZ() {
		allObjects.members.sort(function(a, b) return ((a.z < b.z) ? -1 : ((a.z > b.z) ? 1 : 0)));
		splashObjects.members.sort(function(a, b) return ((a.z < b.z) ? -1 : ((a.z > b.z) ? 1 : 0)));
	}

	override function update(elapsed:Float)
	{
		eventManager.update(elapsed);
		tweenManager.update(elapsed); // should be automatically paused when you pause in game
		timerManager.update(elapsed);
		allObjects.update(elapsed);
		splashObjects.update(elapsed);
	}

	override function draw()
	{
		resortZ();
		for (field in noteFields)
			field.draw();
		allObjects.draw();
		splashObjects.draw();
	}

	public function getCorrectScrollSpeed()
		return ModchartUtil.getScrollSpeed(inEditor ? null : playStateInstance);

	public var tweens:Map<String, FlxTween> = [];

    public function createTween(Object:Dynamic, Values:Dynamic, Duration:Float, ?Options:TweenOptions, ?tag:String):FlxTween
    {
        if (tweens.exists(tag))
        {
            tweens.get(tag).cancel();
            tweens.remove(tag);
        }
        final tween:FlxTween = tweenManager.tween(Object, Values, Duration, Options);
        tween.manager = tweenManager;
        tweens.set(tag, tween);
        return tween;
    }

    public function createTweenNum(FromValue:Float, ToValue:Float, Duration:Float = 1, ?Options:TweenOptions, ?TweenFunction:Float->Void, ?tag:String):FlxTween
    {
        if (tweens.exists(tag))
        {
            tweens.get(tag).cancel();
            tweens.remove(tag);
        }
        final tween:FlxTween = tweenManager.num(FromValue, ToValue, Duration, Options, TweenFunction);
        tween.manager = tweenManager;
        tweens.set(tag, tween);
        return tween;
    }

	override public function destroy()
	{
		if (modchart != null)
			for (customMod in modchart.customModifiers)
				customMod.destroy(); // make sure the interps are dead
		super.destroy();
	}
}
