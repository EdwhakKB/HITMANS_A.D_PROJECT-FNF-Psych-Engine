package modcharting.modifiers;

import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import modcharting.*;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;
import modcharting.PlayfieldRenderer.StrumNoteType;
import objects.Note;

// CHANGE LOG (the changes to modifiers)
// [REWORK] = totally overhaul of a modifier
// [UPDATE] = changed something on the modifier
// [RENAME] = rename of a modifier
// [REMOVAL] = a removed modifier
// [NEW] = a new modifier
// [EXTRA] = has nothing to do with modifiers but MT's enviroment.
// HERE CHANGE LIST

/*
	[EXTRA] Backwards Support:
	-   SKEW(X,Y Included) modifiers are now on the Backwards Support list.

	[NEW] SkewFieldModifier:
	-   New modifier ported from notITG. (Includes X,Y variants ONLY).
	-   Has 1 subValue:
		+ CenterOffset (This one changes the offset of where the skew should take it's base of)
 */

class SkewModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 0.0;
		currentValue = 1.0;
		setSubMod('x', 0.0);
		setSubMod('y', 0.0);
		setSubMod('xDmod', 0.0);
		setSubMod('yDmod', 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var daswitch = -1;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				daswitch = 1;

		noteData.skewX += getSubMod('x') + (getSubMod('xDmod') * daswitch);
		noteData.skewY += getSubMod('y') + (getSubMod('yDmod') * daswitch);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}

	override function reset()
	{
		super.reset();
		baseValue = 0.0;
		currentValue = 1.0;
	}
}

class SkewXModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 0.0;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class SkewYModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 0.0;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class SkewFieldXModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 0.0;
		setSubMod('centerOffset', 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var centerPoint:Float = (FlxG.height / 2) + getSubMod('centerOffset');

		var offsetY:Float = NoteMovement.arrowSizes[lane] / 2;

		var finalPos:Float = (noteData.y + offsetY) - centerPoint;

		noteData.x += finalPos * Math.tan(currentValue * FlxAngle.TO_RAD);

		noteData.skewX += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SkewFieldYModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 0.0;
		setSubMod('centerOffset', 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var centerPoint:Float = (FlxG.width / 2) + getSubMod('centerOffset');

		var offsetX:Float = NoteMovement.arrowSizes[lane] / 2;

		var finalPos:Float = (noteData.x + offsetX) - centerPoint;

		noteData.y += finalPos * Math.tan(currentValue * FlxAngle.TO_RAD);

		noteData.skewY += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}