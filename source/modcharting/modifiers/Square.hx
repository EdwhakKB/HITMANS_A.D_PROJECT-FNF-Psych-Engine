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
	[EXTRA] Square Improvements:
	-   Added a helper instead of copy and pasted code for the modifiers.
	-	Chanegd the math somewhat to hazard's (math it visually the same, not direct behavior changes)

	[UPDATE] Square: (X,Y Included)
	-   Now scale mods can stack (before, its behavior was like we have 2 mods but one its 0 then no mods other than that one works, now it's additive.)
 */
class Square extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("mult", 1.0);
		setSubMod("yoffset", 0.0);
		setSubMod("xoffset", 0.0);
	}

	public function squareMath(lane:Int, curPos:Float):Float
	{
		var mult:Float = (getSubMod("mult") / (NoteMovement.arrowSizes[lane] * 2));
		var timeOffset:Float = subValues.get('yoffset').value;
		var xOffset:Float = subValues.get('xoffset').value;
		var xVal:Float = FlxMath.fastSin(((curPos * 0.45) + timeOffset) * Math.PI * mult);
		xVal = Math.floor(xVal) + 0.5 + xOffset;
		return xVal;
	}
}

class SquareXModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += squareMath(lane, curPos) * currentValue;
	}
}

class SquareYModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += squareMath(lane, curPos) * currentValue;
	}
}

class SquareZModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += squareMath(lane, curPos) * currentValue;
	}
}

class SquareAngleModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += squareMath(lane, curPos) * currentValue;
	}
}

class SquareAngleXModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += squareMath(lane, curPos) * currentValue;
	}
}

class SquareAngleYModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += squareMath(lane, curPos) * currentValue;
	}
}

class SquareScaleModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((squareMath(lane, curPos) * (currentValue * 0.01)) - 1);
		noteData.scaleY += ((squareMath(lane, curPos) * (currentValue * 0.01)) - 1);
	}
}

class SquareScaleXModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((squareMath(lane, curPos) * (currentValue * 0.01)) - 1);
	}
}

class SquareScaleYModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += ((squareMath(lane, curPos) * (currentValue * 0.01)) - 1);
	}
}

class SquareSkewModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += squareMath(lane, curPos) * currentValue;
		noteData.skewY += squareMath(lane, curPos) * currentValue;
	}
}

class SquareSkewXModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += squareMath(lane, curPos) * currentValue;
	}
}

class SquareSkewYModifier extends Square
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += squareMath(lane, curPos) * currentValue;
	}
}
