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
	[EXTRA] Digital Improvements:
	-   Now instead of copy paste the math over and over, Digital has a main helper class with all math, making it easier to use Digital.

	[EXTRA & REWORK] Digital Helper class:
	-   Digital helper class has the basics of Digital with new subValues.
	-   Added 2 subValues:
		+   mult (changes Digital's period)
		+   steps (changes Digital's offset)
	-   Digital helper class can be called via custom mods (so you can create any custom DigitalMod, such as idk, DigitalDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Digital(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Digital)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[NEW] 
	- DigitalAngleX, DigitalAngleY. Prespective Angles added!
 */

class Digital extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("mult", 1.0);
		setSubMod("steps", 4.0);
	}

	public function digitalMath(curPos:Float):Float
	{
		// Copy of Sudden math
		var s = getSubMod("steps") / 2;

		var funny:Float = FlxMath.fastSin((curPos * 0.45) * Math.PI * getSubMod("mult") / 250) * s;
		// trace("1: " + funny);
		funny = Math.floor(funny);
		// funny = Math.round(funny); //Why does this not work? no idea :(
		// trace("2: " + funny);
		// funny = funny;
		funny /= s;
		// trace("3: " + funny);
		return funny;
	}
}

class DigitalXModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += (digitalMath(curPos) * currentValue) * (NoteMovement.arrowSize / 2.0);
	}
}

class DigitalYModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += (digitalMath(curPos) * currentValue) * (NoteMovement.arrowSize / 2.0);
	}
}

class DigitalZModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += (digitalMath(curPos) * currentValue) * (NoteMovement.arrowSize / 2.0);
	}
}

class DigitalAngleModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += digitalMath(curPos) * currentValue;
	}
}

class DigitalAngleXModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += digitalMath(curPos) * currentValue;
	}
}

class DigitalAngleYModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += digitalMath(curPos) * currentValue;
	}
}

class DigitalScaleModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((digitalMath(curPos) * currentValue) - 1);
		noteData.scaleY += ((digitalMath(curPos) * currentValue) - 1);
	}
}

class DigitalScaleXModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((digitalMath(curPos) * currentValue) - 1);
	}
}

class DigitalScaleYModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += ((digitalMath(curPos) * currentValue) - 1);
	}
}

class DigitalSkewModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += (digitalMath(curPos) * currentValue);
		noteData.skewY += (digitalMath(curPos) * currentValue);
	}
}

class DigitalSkewXModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += (digitalMath(curPos) * currentValue);
	}
}

class DigitalSkewYModifier extends Digital
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += (digitalMath(curPos) * currentValue);
	}
}
