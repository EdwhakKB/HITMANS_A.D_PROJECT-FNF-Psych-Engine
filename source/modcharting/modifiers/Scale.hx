package modcharting.modifiers;

import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;
import modcharting.PlayfieldRenderer.StrumNoteType;
import modcharting.*;
import objects.Note;

//CHANGE LOG (the changes to modifiers)

//[REWORK] = totally overhaul of a modifier
//[UPDATE] = changed something on the modifier
//[RENAME] = rename of a modifier
//[REMOVAL] = a removed modifier
//[NEW] = a new modifier
//[EXTRA] = has nothing to do with modifiers but MT's enviroment.

//HERE CHANGE LIST
/*
    [NEW] TinyModifier: (X,Y Included)
    -   Makes the notes smaller. Value of 1 will always try to make the notes at 0 scale.
    -   Negative values can be used to make the notes bigger.

    [UPDATE] ScaleModifier: (X,Y Included)
    -   Now scale mods can stack (before, its behavior was like we have 2 mods but one its 0 then no mods other than that one works, now it's additive.)

    [EXTRA] Backwards Support:
    -   SCALE(X,Y Included), modifier is now on the Backwards Support list.
*/

class MiniModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 1.0;
		currentValue = 1.0;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var col = (lane % NoteMovement.keyCount);
		var daswitch = 1;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				daswitch = -1;

		var midFix = false;
		if (instance != null)
			if (ModchartUtil.getMiddlescroll(instance))
				midFix = true;
		// noteData.x -= (NoteMovement.arrowSizes[lane]-(NoteMovement.arrowSizes[lane]*currentValue))*col;

		// noteData.x += (NoteMovement.arrowSizes[lane]*currentValue*NoteMovement.keyCount*0.5);
		noteData.scaleX *= currentValue;
		noteData.scaleY *= currentValue;
		noteData.x -= ((NoteMovement.arrowSizes[lane] / 2) * (noteData.scaleX - NoteMovement.defaultScale[lane][0]));
		noteData.y += daswitch * ((NoteMovement.arrowSizes[lane] / 2) * (noteData.scaleY - NoteMovement.defaultScale[lane][1]));
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class ShrinkModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scaleMult = 1 + (curPos * 0.001 * currentValue);
		noteData.scaleX *= scaleMult;
		noteData.scaleY *= scaleMult;
	}
}

class TinyModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 0.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1-currentValue);
        noteData.scaleY *= (1-currentValue);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TinyXModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 0.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1-currentValue);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TinyYModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 0.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1-currentValue);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}

class ScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 1.0;
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX += (currentValue-1);
        noteData.scaleY += (currentValue-1);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class ScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 1.0;
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX += (currentValue-1);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class ScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 1.0;
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY += (currentValue-1);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}

/*class Zoom extends Modifier
{
	var pivotPoint:Vector2 = new Vector2(0, 0);
	var point:Vector2 = new Vector2(0, 0);

	override function setupSubValues()
	{
		setSubMod("offset_x", 0.0);
		setSubMod("offset_y", 0.0);
		setSubMod("offset_z", 0.0);
	}

	function getPivot(noteData:NotePositionData, lane:Int, type:String = "x")
	{
		switch (type)
		{
			case "x":
				var r:Float = 0;
					
				//1 should return oponent's midPoint, while 2 should return player's
				var downStrumPosition:Float = NoteMovement.defaultStrumX[
					(lane < NoteMovement.keyCount ? (Std.int(NoteMovement.totalKeyCount/2)) : (NoteMovement.totalKeyCount)) - Std.int((NoteMovement.keyCount/2)) - 1
				];
				var upStrumPosition:Float = NoteMovement.defaultStrumX[
					(lane < NoteMovement.keyCount ? (Std.int(NoteMovement.totalKeyCount/2)) : (NoteMovement.totalKeyCount)) - Std.int((NoteMovement.keyCount/2))
				];

				var midPosition = (upStrumPosition - downStrumPosition) / 2;
				r += downStrumPosition + midPosition;
				r += getSubMod("offset_x");
				return r;
			case "y":
				return (FlxG.height/2) + getSubMod("offset_y");
			case "z":
				return 0.0 + getSubMod("offset_z");
			default:
				return 0.0;
		}
	}

	function rotatePivot(noteData:NotePositionData, lane:Int, pf:Int, type:String = "x")
	{
		var angle:Float = currentValue;

		switch (type)
		{
			case "z":
				pivotPoint.x = getPivot(noteData, lane, "x");
				pivotPoint.y = getPivot(noteData, lane, "y");
				point.x = noteData.x;
				point.y = noteData.y;
				var output:Vector2 = ModchartUtil.rotateAround(pivotPoint, point, angle);
				noteData.x = output.x;
				noteData.y = output.y;
			case "y":
				pivotPoint.x = getPivot(noteData, lane, "x");
				pivotPoint.y = getPivot(noteData, lane, "z");
				point.x = noteData.x;
				point.y = noteData.z;
				var output:Vector2 = ModchartUtil.rotateAround(pivotPoint, point, angle);
				noteData.x = output.x;
				noteData.z = output.y;
			case "x":
				pivotPoint.x = getPivot(noteData, lane, "z");
				pivotPoint.y = getPivot(noteData, lane, "y");
				point.x = noteData.z;
				point.y = noteData.y;
				var output:Vector2 = ModchartUtil.rotateAround(pivotPoint, point, angle);
				noteData.z = output.x;
				noteData.y = output.y;
		}
	}
}*/