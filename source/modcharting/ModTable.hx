package modcharting;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import haxe.ds.Vector;
import modcharting.Modifier;
import modcharting.modifiers.*;

class ModTable
{
	public var modifiers:Map<String, Modifier> = new Map<String, Modifier>();

	private var instance:ModchartMusicBeatState = null;
	private var renderer:PlayfieldRenderer = null;

	public var isEditor:Bool = false; // BRUH

	// The table is used to precalculate all the playfield and lane checks on each modifier,
	// so it should end up with a lot less loops and if checks each frame
	// index table by playfield, then lane, and then loop through each modifier
	private var table:Vector<Vector<Vector<Modifier>>>;

	public function new(instance:ModchartMusicBeatState, renderer:PlayfieldRenderer)
	{
		this.instance = instance;
		this.renderer = renderer;
		loadDefaultModifiers();
		reconstructTable();
	}

	public function add(mod:Modifier):Void
	{
		mod.instance = instance;
		mod.renderer = renderer;
		remove(mod.tag); // in case you replace one???
		modifiers.set(mod.tag, mod);
	}

	public function remove(tag:String):Void
	{
		if (modifiers.exists(tag))
			modifiers.remove(tag);
	}

	public function clear():Void
	{
		modifiers.clear();

		loadDefaultModifiers();
	}

	public function resetMods():Void
	{
		for (mod in modifiers)
			mod.reset();
	}

	public function setModTargetLane(tag:String, lane:Int):Void
	{
		if (modifiers.exists(tag))
		{
			modifiers.get(tag).targetLane = lane;
		}
	}

	public function loadDefaultModifiers():Void
	{
		// default modifiers
		// got a sigly rework to make this shit work better ig? (added all modifiers so lua and hxscript can use them and no need add)
		add(new modcharting.modifiers.Transform.XModifier('x'));
		add(new modcharting.modifiers.Transform.YModifier('y'));
		add(new modcharting.modifiers.Transform.ZModifier('z'));
		add(new modcharting.modifiers.Confusion.ConfusionModifier('confusion'));
		for (i in 0...((NoteMovement.keyCount + NoteMovement.playerKeyCount)))
		{
			add(new modcharting.modifiers.Transform.XModifier('x' + i, ModifierType.LANESPECIFIC));
			add(new modcharting.modifiers.Transform.YModifier('y' + i, ModifierType.LANESPECIFIC));
			add(new modcharting.modifiers.Transform.ZModifier('z' + i, ModifierType.LANESPECIFIC));
			add(new modcharting.modifiers.Confusion.AngleModifier('confusion' + i, ModifierType.LANESPECIFIC));
			setModTargetLane('x' + i, i);
			setModTargetLane('y' + i, i);
			setModTargetLane('z' + i, i);
			setModTargetLane('confusion' + i, i);
		}
	}

	public function reconstructTable():Void
	{
		if (table != null)
			table.fill(null);

		if (table == null || table.length < renderer.noteFields.length)
			table = new Vector<Vector<Vector<Modifier>>>(renderer.noteFields.length);

		for (pf in 0...renderer.noteFields.length)
		{
			if (table[pf] == null)
				table[pf] = new Vector<Vector<Modifier>>(NoteMovement.totalKeyCount);

			for (lane in 0...NoteMovement.totalKeyCount)
			{
				var len:Int = 0;
				for (mod in modifiers)
				{
					if (mod.checkLane(lane) && mod.checkPlayField(pf))
						++len;
				}
				table[pf][lane] = new Vector<Modifier>(len);

				var index:Int = 0;

				for (mod in modifiers)
				{
					if (mod.checkLane(lane) && mod.checkPlayField(pf))
						table[pf][lane][index++] = mod; // add mod to table
				}
			}
		}
	}

	public function applyStrumMods(noteData:NotePositionData, lane:Int, pf:Int):Void
	{
		if (table[pf] != null && table[pf][lane] != null)
		{
			var modList:Vector<Modifier> = table[pf][lane];
			for (mod in modList)
				mod.getStrumPath(noteData, lane, pf);
		}
	}

	public function applyNoteMods(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int):Void
	{
		if (table[pf] != null && table[pf][lane] != null)
		{
			var modList:Vector<Modifier> = table[pf][lane];
			for (mod in modList)
				mod.getNotePath(noteData, lane, curPos, pf);
		}
	}

    public function applySplashMods(noteData:NotePositionData, lane:Int, /*curPos:Float,*/ pf:Int):Void
	{
		if (table[pf] != null && table[pf][lane] != null)
		{
			var modList:Vector<Modifier> = table[pf][lane];
			for (mod in modList)
				mod.getStrumPath(noteData, lane, /*curPos,*/ pf);
		}
	}

    public function applyHoldSplashMods(noteData:NotePositionData, lane:Int, /*curPos:Float,*/ pf:Int):Void
	{
		if (table[pf] != null && table[pf][lane] != null)
		{
			var modList:Vector<Modifier> = table[pf][lane];
			for (mod in modList)
				mod.getStrumPath(noteData, lane, /*curPos,*/ pf);
		}
	}

	public function applyNoteDistMods(noteDist:Float, lane:Int, pf:Int):Float
	{
		if (table[pf] != null && table[pf][lane] != null)
		{
			var modList:Vector<Modifier> = table[pf][lane];
			for (mod in modList)
				noteDist = mod.getNoteDist(noteDist, lane, 0, pf);
		}
		return noteDist;
	}

	public function applyCurPosMods(lane:Int, curPos:Float, pf:Int):Float
	{
		if (table[pf] != null && table[pf][lane] != null)
		{
			var modList:Vector<Modifier> = table[pf][lane];
			for (mod in modList)
				curPos = mod.getNoteCurPos(lane, curPos, pf);
		}
		return curPos;
	}

	public function applyIncomingAngleMods(lane:Int, curPos:Float, pf:Int):Array<Float>
	{
		var incomingAngle:Array<Float> = [0, 0];
		if (table[pf] != null && table[pf][lane] != null)
		{
			var modList:Vector<Modifier> = table[pf][lane];
			for (mod in modList)
			{
				var ang = mod.getIncomingAngle(lane, curPos, pf); // need to get incoming angle before
				incomingAngle[0] += ang[0];
				incomingAngle[1] += ang[1];
			}
		}
		return incomingAngle;
	}

	public function tweenModifier(modifier:String, val:Float, time:Float, ease:String, beat:Float)
    {
        var modifiers:Map<String, Modifier> = renderer.modifierTable.modifiers;
        if (modifiers.exists(modifier))
        {
            var easefunc = ModchartUtil.getFlxEaseByString(ease);

            final startPoint:Float = modifiers.get(modifier).currentValue; //get starter value (unscaled)
            final finishPoint:Float = startPoint + ((val - startPoint) * easefunc(1.0)); //get final value

            if (Conductor.songPosition >= ModchartUtil.getTimeFromBeat(beat) + (time * 1000)) // cancel if should have ended
            {
                modifiers.get(modifier).currentValue = finishPoint;
                return;
            }
            time /= renderer.rate;
            var tween = renderer.createTweenNum(startPoint, val, time, { //average 0-1 tween LMAO
                ease: easefunc,
                onComplete: function(twn:FlxTween)
                {
                    renderer.tweens.remove(modifier);
                    if (modifiers.get(modifier).currentValue != finishPoint)
                        modifiers.get(modifier).currentValue = finishPoint; //make sure it's ALSO set when completed?
                    //trace("Completed Tween For Mod: " + modifier + " Value: " + modifiers.get(modifier).currentValue);
                    #if PSYCH
                    if (PlayState.instance == FlxG.state)
                        PlayState.instance.callOnScripts("onModifierComplete", [modifier, []]);
                    // else if (EditorPlayState.instance == FlxG.state)
                    //     EditorPlayState.instance.callOnScripts("onModifierComplete", [modifier, []]);
                    #end
                }
            }, function(v)
            {
                modifiers.get(modifier).currentValue = v;
            }, modifier);

            if (Conductor.songPosition > ModchartUtil.getTimeFromBeat(beat)) // skip to where it should be i guess??
            {
                @:privateAccess
                tween._secondsSinceStart += ((Conductor.songPosition - ModchartUtil.getTimeFromBeat(beat)) * 0.001);
                @:privateAccess
                tween.update(0);
            }
            if (renderer.editorPaused)
                tween.active = false;
        }
    }

    public function tweenModifierSubValue(modifier:String, subValue:String, val:Float, time:Float, ease:String, beat:Float)
    {
        var modifiers:Map<String, Modifier> = renderer.modifierTable.modifiers;
        if (modifiers.exists(modifier))
        {
            if (modifiers.get(modifier).subValues.exists(subValue))
            {
                var easefunc = ModchartUtil.getFlxEaseByString(ease);
                var tag = modifier + ' ' + subValue;

                var startPoint:Float = modifiers.get(modifier).subValues.get(subValue).value; //get starter value
                var finishPoint:Float = startPoint + ((val - startPoint) * easefunc(1.0)); //get final value

                if (Conductor.songPosition >= ModchartUtil.getTimeFromBeat(beat) + (time * 1000)) // cancel if should have ended
                {
                    modifiers.get(modifier).subValues.get(subValue).value = finishPoint;
                    return;
                }
                time /= renderer.rate;
                var tween = renderer.createTweenNum(startPoint, val, time, {
                    ease: easefunc,
                    onComplete: function(twn:FlxTween)
                    {
                        renderer.tweens.remove(modifier+subValue);
                        //trace("Completed Tween For subMod: " + modifier + ":" + subValue + " Value: " + modifiers.get(modifier).subValues.get(subValue).value);
                        modifiers.get(modifier).subValues.get(subValue).value = finishPoint;

                        #if PSYCH
                        if (PlayState.instance == FlxG.state)
                            PlayState.instance.callOnScripts("onModifierComplete", [modifier, subValue]);
                        // else if (EditorPlayState.instance == FlxG.state)
                        //     EditorPlayState.instance.callOnScripts("onModifierComplete", [modifier, subValue]);
                        #end
                    }
                }, function (v){
                    modifiers.get(modifier).subValues.get(subValue).value = v;
                }, modifier+subValue);

                if (Conductor.songPosition > ModchartUtil.getTimeFromBeat(beat)) // skip to where it should be i guess??
                {
                    @:privateAccess
                    tween._secondsSinceStart += ((Conductor.songPosition - ModchartUtil.getTimeFromBeat(beat)) * 0.001);
                    @:privateAccess
                    tween.update(0);
                }
                if (renderer.editorPaused)
                    tween.active = false;
            }
        }
    }

    public function tweenAdd(modifier:String, val:Float, time:Float, ease:String, beat:Float)
    {
        var modifiers:Map<String, Modifier> = renderer.modifierTable.modifiers;
        if (modifiers.exists(modifier))
        {
            var easefunc = ModchartUtil.getFlxEaseByString(ease);

            var startValue = modifiers.get(modifier).currentValue;

            var finishPoint:Float = startValue + ((val - startValue) * easefunc(1.0));

            var lastReportChange:Float = 0;

            if (Conductor.songPosition >= ModchartUtil.getTimeFromBeat(beat) + (time * 1000)) // cancel if should have ended
            {
                final v:Float = val * easefunc(1.0);
                modifiers.get(modifier).currentValue += val;
                return;
            }
            time /= renderer.rate;
            var tween = renderer.createTweenNum(0, 1, time, { //average 0-1 tween LMAO
                ease: FlxEase.linear,
                onComplete: function(twn:FlxTween)
                {
                    renderer.tweens.remove(modifier);
                    final v:Float = val * easefunc(1.0);
                    if (modifiers.get(modifier).currentValue != (v - lastReportChange)){
                        modifiers.get(modifier).currentValue = modifiers.get(modifier).currentValue + (v - lastReportChange); //make sure it's ALSO set when completed?
                        lastReportChange = v;
                    }

                    //trace("Completed Tween For Mod: " + modifier + " Value: " + modifiers.get(modifier).currentValue);
                    #if PSYCH
                    if (PlayState.instance == FlxG.state)
                        PlayState.instance.callOnScripts("onModifierComplete", [modifier, []]);
                    // else if (EditorPlayState.instance == FlxG.state)
                    //     EditorPlayState.instance.callOnScripts("onModifierComplete", [modifier, []]);
                    #end
                }
            }, function(t){
                final v:Float = val * easefunc(t);
                modifiers.get(modifier).currentValue = modifiers.get(modifier).currentValue + (v - lastReportChange); //make sure it's ALSO set when completed?
                lastReportChange = v;
            }, modifier);

            if (Conductor.songPosition > ModchartUtil.getTimeFromBeat(beat)) // skip to where it should be i guess??
            {
                @:privateAccess
                tween._secondsSinceStart += ((Conductor.songPosition - ModchartUtil.getTimeFromBeat(beat)) * 0.001);
                @:privateAccess
                tween.update(0);
            }
            if (renderer.editorPaused)
                tween.active = false;
        }
    }

    public function tweenAddSubValue(modifier:String, subValue:String, val:Float, time:Float, ease:String, beat:Float)
    {
        var modifiers:Map<String, Modifier> = renderer.modifierTable.modifiers;
        if (modifiers.exists(modifier))
        {
            if (modifiers.get(modifier).subValues.exists(subValue))
            {
                var easefunc = ModchartUtil.getFlxEaseByString(ease);
                var tag = modifier + ' ' + subValue;

                var lastReportChange:Float = 0;

                if (Conductor.songPosition >= ModchartUtil.getTimeFromBeat(beat) + (time * 1000)) // cancel if should have ended
                {
                    final v:Float = val * easefunc(1.0);
                    modifiers.get(modifier).subValues.get(subValue).value += v;
                    return;
                }
                time /= renderer.rate;
                var tween = renderer.createTweenNum(0, 1, time, {
                    ease: FlxEase.linear,
                    onComplete: function(twn:FlxTween)
                    {
                        renderer.tweens.remove(modifier+subValue);
                        final v:Float = val * easefunc(1.0);
                        modifiers.get(modifier).subValues.get(subValue).value += (v - lastReportChange);
                        lastReportChange = v;
                        //trace("Completed Tween For subMod: " + modifier + ":" + subValue + " Value: " + modifiers.get(modifier).subValues.get(subValue).value);
                        #if PSYCH
                        if (PlayState.instance == FlxG.state)
                            PlayState.instance.callOnScripts("onModifierComplete", [modifier, subValue]);
                        // else if (EditorPlayState.instance == FlxG.state)
                        //     EditorPlayState.instance.callOnScripts("onModifierComplete", [modifier, subValue]);
                        #end
                    }
                }, function (t){
                    final v:Float = val * easefunc(t);
                    modifiers.get(modifier).subValues.get(subValue).value += (v-lastReportChange);
                    lastReportChange = v;
                }, modifier+subValue);

                if (Conductor.songPosition > ModchartUtil.getTimeFromBeat(beat)) // skip to where it should be i guess??
                {
                    @:privateAccess
                    tween._secondsSinceStart += ((Conductor.songPosition - ModchartUtil.getTimeFromBeat(beat)) * 0.001);
                    @:privateAccess
                    tween.update(0);
                }
                if (renderer.editorPaused)
                    tween.active = false;
            }
        }
    }
}
