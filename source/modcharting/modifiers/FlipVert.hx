package modcharting.modifiers;

import modcharting.*;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;
import modcharting.PlayfieldRenderer.StrumNoteType;

// CHANGE LOG (the changes to modifiers)
// [REWORK] = totally overhaul of a modifier
// [UPDATE] = changed something on the modifier
// [RENAME] = rename of a modifier
// [REMOVAL] = a removed modifier
// [NEW] = a new modifier
// [EXTRA] = has nothing to do with modifiers but MT's enviroment.
// HERE CHANGE LIST

/*
	[NEW] BlackSphereModifier:
	-   Does a spin effect on notes (has Flip and Invert variants)

	[NEW] VideoGamesModifier:
	-   New modifier based on notITG behaviour, which just flips down and up notes (has RealGames variant which does the same but only flips left and right notes)

	[NEW] FlipSineModifier:
	-	Similar to "InvertSineModifier" but this one does a flip effect

 */

class FlipModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var nd = lane % NoteMovement.keyCount;
		var newPos = FlxMath.remapToRange(nd, 0, NoteMovement.keyCount, NoteMovement.keyCount, -NoteMovement.keyCount);

		noteData.x += NoteMovement.arrowSizes[lane] * newPos * currentValue;
		noteData.x -= NoteMovement.arrowSizes[lane] * currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class InvertModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += NoteMovement.arrowSizes[lane] * (lane % 2 == 0 ? 1 : -1) * currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class VideoGamesModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var laneThing = lane % NoteMovement.keyCount;

		if (laneThing > 0 && laneThing < 3) // down and up notes
			noteData.x += NoteMovement.arrowSizes[lane] * (laneThing == 1 ? 1 : -1) * currentValue;

		// if its 1 then it adds, otherwise it subtracts
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class RealGamesModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var laneThing = lane % NoteMovement.keyCount;

		if (laneThing == 0 || laneThing == 3) // left and right notes
			noteData.x += NoteMovement.arrowSizes[lane] * (laneThing == 0 ? 1 : -1) * currentValue * 3; // ????

	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class InvertSineModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += FlxMath.fastSin((curPos * 0.004)) * (NoteMovement.arrowSizes[lane] * (lane % 2 == 0 ? 1 : -1) * currentValue * 0.5); // silly ah math
	}
}

class FlipSineModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var nd = lane % NoteMovement.keyCount;
		var newPos = (nd - 1.5) * -2;

		noteData.x += FlxMath.fastSin((curPos * 0.004)) * (NoteMovement.arrowSizes[lane] * newPos * currentValue * 0.5);
	}
}

class BlackSphereInvertModifier extends Modifier
{
	override public function setupSubValues()
	{
		baseValue = 1.0; // default set to skip math if value is default (1.0)
		currentValue = 1.0;
		setSubMod("variant", 0.0);
		setSubMod("speedaffect", 1.0);
	}

	// speed = curpos * currentValue (you could use noteDistToo but its a little more complex)
	override function curPosMath(lane:Int, curPos:Float, pf:Int):Float
	{
		var ud = false;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				ud = true;

		var value = currentValue % 360; // make sure to always use 0-360 values

		var retu_val:Float = 1;
		var speedAffectM:Float = getSubMod("speedaffect");
		var yValue:Float = FlxMath.fastSin(value * Math.PI / 180);

		var variant:Bool = (getSubMod("variant") >= 0.5);

		var laneThing = lane % NoteMovement.keyCount;

		if (variant) // make sure variant only gets applied when 1 or higger
		{
			if (laneThing % 4 == 1 || laneThing % 4 == 2) yValue *= -1;
		}
		else
		{
			if (laneThing % 2 == 1) yValue *= -1;
		}

		if (!ud) yValue *= -1;

		retu_val += yValue * 0.125 * speedAffectM;

		return curPos * retu_val;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var value = currentValue % 360;

		var invertValue:Float = 0;
		var yValue:Float = 0;

		invertValue = 50 - 50 * FlxMath.fastCos(value * Math.PI / 180);
		invertValue /= 100;

		yValue = 0.5 * FlxMath.fastSin(value * Math.PI / 180);

		var variant:Bool = (getSubMod("variant") >= 0.5);

		var laneThing = lane % NoteMovement.keyCount;

		if (variant) // make sure variant only gets applied when 1 or higger
		{
			if (laneThing % 4 == 1 || laneThing % 4 == 2) yValue *= -1;
		}
		else
		{
			if (laneThing % 2 == 1) yValue *= -1;
		}

		noteData.x += NoteMovement.arrowSizes[lane] * (laneThing % 2 == 0 ? 1 : -1) * invertValue;
		noteData.y += NoteMovement.arrowSizes[lane] * yValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BlackSphereFlipModifier extends Modifier
{
	override public function setupSubValues()
	{
		baseValue = 1.0; // default set to skip math if value is default (1.0)
		currentValue = 1.0;
		setSubMod("variant", 0.0);
		setSubMod("speedaffect", 1.0);
	}

	// speed = curpos * currentValue (you could use noteDistToo but its a little more complex)
	override function curPosMath(lane:Int, curPos:Float, pf:Int):Float
	{
		var ud = false;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				ud = true;

		var value = currentValue % 360; // make sure to always use 0-360 values

		var retu_val:Float = 1;
		var speedAffectM:Float = getSubMod("speedaffect");
		var yValue:Float = FlxMath.fastSin(value * Math.PI / 180);

		var variant:Bool = (getSubMod("variant") >= 0.5);

		var laneThing = lane % NoteMovement.keyCount;

		if (variant) // make sure variant only gets applied when 1 or higger
		{
			if (laneThing % 4 == 1 || laneThing % 4 == 2) yValue *= -1;
		}
		else
		{
			if (laneThing % 2 == 1) yValue *= -1;
		}

		if (!ud) yValue *= -1;

		retu_val += yValue * 0.125 * speedAffectM;

		return curPos * retu_val;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var value = currentValue % 360;

		var invertValue:Float = 0;
		var yValue:Float = 0;

		invertValue = 50 - 50 * FlxMath.fastCos(value * Math.PI / 180);
		invertValue /= 100;

		yValue = 0.5 * FlxMath.fastSin(value * Math.PI / 180);

		var variant:Bool = (getSubMod("variant") >= 0.5);

		var laneThing = lane % NoteMovement.keyCount;

		if (variant) // make sure variant only gets applied when 1 or higger
		{
			if (laneThing % 4 == 1 || laneThing % 4 == 2) yValue *= -1;
		}
		else
		{
			if (laneThing % 2 == 1) yValue *= -1;
		}

		var newPos = FlxMath.remapToRange(laneThing, 0, NoteMovement.keyCount, NoteMovement.keyCount, -NoteMovement.keyCount);
		noteData.x += NoteMovement.arrowSizes[lane] * newPos * invertValue;
		noteData.x -= NoteMovement.arrowSizes[lane] * invertValue;
		noteData.y += NoteMovement.arrowSizes[lane] * yValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}