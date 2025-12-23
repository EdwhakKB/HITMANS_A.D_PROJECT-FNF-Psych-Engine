package modcharting.modifiers;

import modcharting.*;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;

// CHANGE LOG (the changes to modifiers)
// [REWORK] = totally overhaul of a modifier
// [UPDATE] = changed something on the modifier
// [RENAME] = rename of a modifier
// [REMOVAL] = a removed modifier
// [NEW] = a new modifier
// [EXTRA] = has nothing to do with modifiers but MT's enviroment.
// HERE CHANGE LIST

/*
	[EXTRA] ZigZag Improvements:
	-   Now instead of copy paste the math over and over, ZigZag has a main helper class with all math, making it easier to use ZigZag.

	[EXTRA & REWORK] ZigZag Helper class:
	-   ZigZag helper class has the basics of ZigZag with 1 subValue.
	-   Added 1 subValue:
		+   mult (multiplies ZigZag's intencity)
	-   ZigZag helper class can be called via custom mods (so you can create any custom ZigZagMod, such as idk, ZigZagDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.ZigZag(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.ZigZag)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.
 */
class ZigZag extends Modifier
{
	override function setupSubValues()
	{
		setSubMod('mult', 1.0);
	}

	function zigZagMath(lane:Int, curPos:Float)
	{
		var mult:Float = NoteMovement.arrowSizes[lane] * getSubMod('mult');
		var mm:Float = mult * 2;
		var p:Float = curPos * 0.45;
		if (p < 0)
		{
			p *= -1;
			p += mult;
		}

		var ppp:Float = p + (mult / 2);
		var funny:Float = (ppp + mult) % mm;
		var result:Float = funny - mult;

		if (ppp % mm * 2 >= mm)
			result *= -1;
		result -= mult / 2;
		return result;
	}
}

class ZigZagXModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagYModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagZModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagAngleModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagAngleXModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagAngleYModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagScaleModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((zigZagMath(lane, curPos) * (currentValue * 0.01)) - 1);
		noteData.scaleY += ((zigZagMath(lane, curPos) * (currentValue * 0.01)) - 1);
	}
}

class ZigZagScaleXModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((zigZagMath(lane, curPos) * (currentValue * 0.01)) - 1);
	}
}

class ZigZagScaleYModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += ((zigZagMath(lane, curPos) * (currentValue * 0.01)) - 1);
	}
}

class ZigZagSkewModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += zigZagMath(lane, curPos) * currentValue;
		noteData.skewY += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagSkewXModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += zigZagMath(lane, curPos) * currentValue;
	}
}

class ZigZagSkewYModifier extends ZigZag
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += zigZagMath(lane, curPos) * currentValue;
	}
}
