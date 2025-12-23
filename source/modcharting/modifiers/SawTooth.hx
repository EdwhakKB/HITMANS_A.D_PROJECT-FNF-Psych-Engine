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
	[EXTRA] SawTooth Improvements:
	-   Now instead of copy paste the math over and over, SawTooth has a main helper class with all math, making it easier to use SawTooth.

	[EXTRA & REWORK] SawTooth Helper class:
	-   SawTooth helper class has the basics of SawTooth with 1 subValue.
	-   Has 1 subValue:
		+   mult (Changes SawTooth's intensity (value on 0 makes SawTooth do nothing))
		+ Methods (2):
			1. Use ModifiersMath.SawTooth(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.SawTooth)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[NEW]
	- SawToothAngleX, SawToothAngleY. Prespective Angle Mods.
 */
class SawTooth extends Modifier
{
	override function setupSubValues()
	{
		setSubMod('mult', 1.0);
	}

	/**
	 * Performs a modulo operation to calculate the remainder of `a` divided by `b`.
	 *
	 * The definition of "remainder" varies by implementation;
	 * this one is similar to GLSL or Python in that it uses Euclidean division, which always returns positive,
	 * while Haxe's `%` operator uses signed truncated division.
	 *
	 * For example, `-5 % 3` returns `-2` while `FlxMath.mod(-5, 3)` returns `1`.
	 *
	 * @param a The dividend.
	 * @param b The divisor.
	 * @return `a mod b`.
	 *
	 * SOURCE: https://github.com/HaxeFlixel/flixel/pull/3341/files
	 */
	public static inline function mod(a:Float, b:Float):Float
	{
		b = Math.abs(b);
		return a - b * Math.floor(a / b);
	}

	public function sawToothMath(lane:Int, curPos:Float)
	{
		return mod(curPos * 0.45, NoteMovement.arrowSizes[lane] * getSubMod('mult'));
	}
}

class SawToothXModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothYModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothZModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothAngleModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothAngleXModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothAngleYModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothScaleModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((sawToothMath(lane, curPos)) * (currentValue * 0.01)) - 1);
		noteData.scaleY += (((sawToothMath(lane, curPos)) * (currentValue * 0.01)) - 1);
	}
}

class SawToothScaleXModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((sawToothMath(lane, curPos)) * (currentValue * 0.01)) - 1);
	}
}

class SawToothScaleYModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += (((sawToothMath(lane, curPos)) * (currentValue * 0.01)) - 1);
	}
}

class SawToothSkewModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += sawToothMath(lane, curPos) * currentValue;
		noteData.skewY += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothSkewXModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += sawToothMath(lane, curPos) * currentValue;
	}
}

class SawToothSkewYModifier extends SawTooth
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += sawToothMath(lane, curPos) * currentValue;
	}
}
