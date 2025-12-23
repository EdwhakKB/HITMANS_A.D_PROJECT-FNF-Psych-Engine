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
	[EXTRA] Attenuate Improvements:
	-   Now instead of copy paste the math over and over, Attenuate has a main helper class with all math, making it easier to use Attenuate.

	[NEW] AttenuateAngleX:
	-	Modifier added to allow modifying AngleX with Attenuate without needing a custom mod.

	[NEW] AttenuateAngleY:
	-	Modifier added to allow modifying AngleY with Attenuate without needing a custom mod.

	[EXTRA & REWORK] Attenuate Helper class:
	-   Attenuate helper class has the basics of Attenuate.
	-   Attenuate helper class can be called via custom mods (so you can create any custom AttenuateMod, such as idk, AttenuateDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Attenuate(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Attenuate)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.
 */
class Attenuate extends Modifier
{
	public function attenuateMath(curPos:Float, lane:Int, ?endMult:Float = 0.5):Float
	{
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;
		var nd = lane % NoteMovement.keyCount;
		var newPos = FlxMath.remapToRange(nd, 0, NoteMovement.keyCount, NoteMovement.keyCount * -1 * 0.5, NoteMovement.keyCount * 0.5);

		var p = curPos * scrollSwitch;
		p = (p * p) * 0.1;

		var curVal = 0.0015;

		var newVal = newPos * curVal * p;
		newVal += curVal * p * endMult;
		return newVal;
	}
}

class AttenuateXModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateYModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateZModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateAngleModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateAngleXModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateAngleYModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateScaleModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += currentValue * (attenuateMath(curPos, lane, 0.1) - 1);
		noteData.scaleY += currentValue * (attenuateMath(curPos, lane, 0.1) - 1);
	}
}

class AttenuateScaleXModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += currentValue * (attenuateMath(curPos, lane, 0.1) - 1);
	}
}

class AttenuateScaleYModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += currentValue * (attenuateMath(curPos, lane, 0.1) - 1);
	}
}

class AttenuateSkewModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += currentValue * attenuateMath(curPos, lane);
		noteData.skewY += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateSkewXModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += currentValue * attenuateMath(curPos, lane);
	}
}

class AttenuateSkewYModifier extends Attenuate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += currentValue * attenuateMath(curPos, lane);
	}
}
