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
	[EXTRA & RENAME] Sine Improvements: (Previously known as EaseModifier)
	-   Now instead of copy paste the math over and over, Sine has a main helper class with all math, making it easier to use Sine.
	-	Rename to "Sine" as "Ease" would cause confusion between modcharters on thinking what the mod does.

	[EXTRA & REWORK] Sine Helper class:
	-   Sine helper class has the basics of Sine with new subValues.
	-   Added 2 subValues:
		+   mult (changes Sine's period)
		+   steps (changes Sine's offset)
	-   Sine helper class can be called via custom mods (so you can create any custom SineMod, such as idk, SineDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Sine(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Sine)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[NEW] 
	- SineAngleX, SineAngleY. Prespective Angles added!
 */

class Sine extends Modifier
{
	override function setupSubValues()
	{
		setSubMod('speed', 1.0);
	}

	function sineMath(lane:Int)
	{
		return currentValue * (FlxMath.fastSin(((Conductor.songPosition * 0.001) +
			((lane % NoteMovement.keyCount) * 0.2) * (10 / FlxG.height)) * (getSubMod('speed')* 0.2)) * Note.swagWidth * 0.5);
	}
}

class SineXModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineYModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineZModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineAngleModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineAngleXModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineAngleYModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineScaleModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((0.01 * sineMath(lane)) - 1);
		noteData.scaleY += ((0.01 * sineMath(lane)) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineScaleXModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((0.01 * sineMath(lane)) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineScaleYModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += ((0.01 * sineMath(lane)) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineSkewModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += sineMath(lane);
		noteData.skewY += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineSkewXModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class SineSkewYModifier extends Sine
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += sineMath(lane);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}