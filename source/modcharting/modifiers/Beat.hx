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
	[EXTRA] Beat Improvements:
	-   Now instead of copy paste the math over and over, Beat has a main helper class with all math, making it easier to use Beat.

	[NEW] BeatAngleX:
	-	Modifier added to allow modifying AngleX with beat without needing a custom mod.

	[NEW] BeatAngleY:
	-	Modifier added to allow modifying AngleY with beat without needing a custom mod.

	[EXTRA & REWORK] Beat Helper class:
	-   Beat helper class has the basics of Beat with lot of new subValues.
	-   Has 6 subValues:
		+   speed (changes Beat's speed)
		+   mult (changes Beat's intensity (value on 0 makes beat do nothing))
		+ 	offset (changes Beat's movement offset)
		+	alternate (changes Beat's method, if value is less than 0.5 it will only move at one direction (default value = 1))
		+	fAccelTime (changes the acceleration time)
		+	fTotalTime (changes the total time)
	-   Beat helper class can be called via custom mods (so you can create any custom BeatMod, such as idk, BeatDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Beat(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Beat)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.
 */
class Beat extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("speed", 1.0);
		setSubMod("mult", 1.0);
		setSubMod("offset", 0.0);
		setSubMod("alternate", 1.0);
		setSubMod("fAccelTime", 0.2);
		setSubMod("fTotalTime", 0.5);
	}

	function beatMath(curPos:Float):Float
	{
		var speed:Float = getSubMod("speed");
		var mult:Float = getSubMod("mult");
		var offset:Float = getSubMod("offset");
		var alternate:Bool = (getSubMod("alternate") >= 0.5);

		var mathToUse:Float = 0.0;

		var fAccelTime = getSubMod("fAccelTime");
		var fTotalTime = getSubMod("fTotalTime");

		/* If the song is really fast, slow down the rate, but speed up the
		 * acceleration to compensate or it'll look weird. */
		// var fBPM = Conductor.bpm * 60;
		// var fDiv = Math.max(1.0, Math.floor( fBPM / 150.0 ));
		// fAccelTime /= fDiv;
		// fTotalTime /= fDiv;

		var time = (Modifier.beat + offset) * speed;
		var posMult = mult * 2; // Multiplied by 2 to make the effect more pronounced instead of being like drunk-lite lmao
		/* offset by VisualDelayEffect seconds */
		var fBeat = time + fAccelTime;
		// fBeat /= fDiv;

		var bEvenBeat = (Math.floor(fBeat) % 2) != 0;

		/* -100.2 -> -0.2 -> 0.2 */
		if (fBeat < 0)
			return 0;

		fBeat -= Math.floor(fBeat);
		fBeat += 1;
		fBeat -= Math.floor(fBeat);

		if (fBeat >= fTotalTime)
			return 0;

		var fAmount:Float;
		if (fBeat < fAccelTime)
		{
			fAmount = FlxMath.remapToRange(fBeat, 0.0, fAccelTime, 0.0, 1.0);
			fAmount *= fAmount;
		}
		else
			/* fBeat < fTotalTime */ {
			fAmount = FlxMath.remapToRange(fBeat, fAccelTime, fTotalTime, 1.0, 0.0);
			fAmount = 1 - (1 - fAmount) * (1 - fAmount);
		}

		if (bEvenBeat && alternate)
			fAmount *= -1;

		mathToUse = FlxMath.fastSin((curPos * 0.01 * posMult) + (Math.PI / 2.0));

		var fShift = 20.0 * fAmount * mathToUse;
		return fShift * currentValue;
	}
}

class BeatXModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatYModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatZModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatAngleModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatAngleXModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatAngleYModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatScaleModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((0.01) * beatMath(curPos)) - 1);
		noteData.scaleY += (((0.01) * beatMath(curPos)) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatScaleXModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((0.01) * beatMath(curPos)) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatScaleYModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += (((0.01) * beatMath(curPos)) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatSkewModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += beatMath(curPos);
		noteData.skewY += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatSkewXModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class BeatSkewYModifier extends Beat
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += beatMath(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}
