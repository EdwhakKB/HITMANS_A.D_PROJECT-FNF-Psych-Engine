package modcharting.modifiers;

import modcharting.*;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;
import modcharting.Modifier.ModifierMath as ModifierMath;
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
	[EXTRA] HourGlass Improvements:
	-   Now instead of copy paste the math over and over, HourGlass has a main helper class with all math, making it easier to use HourGlass.

	[EXTRA & REWORK] HourGlass Helper class:
	-   HourGlass helper class has the basics of HourGlass with new subValues.
	-   Added 3 subValues:
		+   start (changes HourGlass's start position)
		+   offset (changes HourGlass's offset)
		+   end (changes HourGlass's end position)
	-   HourGlass helper class can be called via custom mods (so you can create any custom HourGlassMod, such as idk, HourGlassDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.HourGlass(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.HourGlass)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[NEW] 
	- HourGlassAngleX, HourGlassAngleY. Prespective Angles added!
 */

class HourGlass extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("start", 5.0);
		setSubMod("end", 3.0);
		setSubMod("offset", 0.0);
	}

	public function hourGlassMath(curPos):Float
	{
		// Copy of Sudden math
		var a:Float = FlxMath.remapToRange(curPos, (getSubMod("start")*-100) + (getSubMod("offset")*-100), (getSubMod("end")*-100) + (getSubMod("offset")*-100), 1, 0);
		a = FlxMath.bound(a, 0, 1); // clamp

		var b:Float = 1 - a;
		var c:Float = (FlxMath.fastCos(b * Math.PI) / 2) + 0.5;

		return c;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int){
		noteMath(noteData, lane, 0, pf);
	}
}

class HourGlassXModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.x += NoteMovement.arrowSizes[lane] * ModifierMath.Flip(lane) * currentValue * c;
		noteData.x -= NoteMovement.arrowSizes[lane] * currentValue * c;
	}
}

class HourGlassYModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.y += NoteMovement.arrowSizes[lane] * ModifierMath.Flip(lane) * currentValue * c;
		noteData.y -= NoteMovement.arrowSizes[lane] * currentValue * c;
	}
}

class HourGlassZModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.z += NoteMovement.arrowSizes[lane] * ModifierMath.Flip(lane) * currentValue * c;
		noteData.z -= NoteMovement.arrowSizes[lane] * currentValue * c;
	}
}

class HourGlassAngleModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.angle += c * (currentValue * -1)*180;
	}
}

class HourGlassAngleXModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.angleX += c * (currentValue * -1)*180;
	}
}

class HourGlassAngleYModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.angleY += c * (currentValue * -1)*180;
	}
}

class HourGlassScaleModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.scaleX += c * currentValue;
		noteData.scaleY += c * currentValue;
	}
}

class HourGlassScaleXModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.scaleX += c * currentValue;
	}
}

class HourGlassScaleYModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.scaleY += c * currentValue;
	}
}

class HourGlassSkewModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.skewX += c * (currentValue * -2);
		noteData.skewY += c * (currentValue * -2);
	}
}

class HourGlassSkewXModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.skewX += c * (currentValue * -2);
	}
}

class HourGlassSkewYModifier extends HourGlass
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var c = hourGlassMath(curPos);

		noteData.skewY += c * (currentValue * -2);
	}
}