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
	[RENAME & REWORK] WavyModifier: (Previously known as wavyModifier)
	-   Change made so waveModifier (Previously known as waveingModifier) fits notITG, but i decided to keep these own mods.
	-   Made a totally overhaul of the modifier, with a new math system, and new subValues but this one has 3 different maths (Legacy, Old, New).
		*   Legacy uses the old behavior (before rework)
		*   Old uses a beta edition of the math
		*   New uses the current default math (which has lot of new features)
		*   Keep in mind that using oldMath or legacy might make some subValues useless.

	[EXTRA] Wavy Improvements:
	-   Now instead of copy paste the math over and over, Wavy has a main helper class with all math, making it easier to use Wavy with its sin(cos)/tan(cot) variants.

	[EXTRA & REWORK] Wavy Helper class:
	-   Wavy helper class has the basics of Wavy with lot of new subValues (for both Wavy and TanWavy).
	-   Has 7 subValues:
		+   speed (changes Wavy's speed)
		+   desync (changes Wavy's desync)
		+   time_add (Adds time to Wavy's math)
		+	oldMath (changes Wavy's math, if value is 0.5 or higher, uses old rework method, otherwise uses new method (default))
		+   timertype (changes Wavy's timer method, only will work for "newMath (aka oldMath subValue set to 0-0.49)")
		+   useAlt (changes it's math, if Wavy (uses sin) it will now use cos, if tanWavy (uses tangent) it will now use cosecant)
		+   legacy (changes Wavy's behaviour, to keep track on older versions of Wavy (wavyModifier), will use older math, and will disable all subValues (except speed and useAlt)).
	-   Wavy helper class can be called via custom mods (so you can create any custom WavyMod, such as idk, WavyDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Wavy(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Wavy)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.
 */
class Wavy extends Modifier
{
	override function setupSubValues()
	{
		setSubMod('speed', 1.0);
		setSubMod('desync', 0.2);
		setSubMod('time_add', 0.0);
		setSubMod('timertype', 0.0);
		setSubMod('oldmath', 0.0);
		setSubMod('useAlt', 0.0);
		setSubMod('legacy', 0.0);
	}

	function wavyMath(lane:Int)
	{
		var legacy:Bool = (getSubMod('legacy') >= 0.5);
		var oldMath:Bool = (getSubMod('oldmath') >= 0.5);
		var usesAlt:Bool = (getSubMod('useAlt') >= 0.5);

		var speed:Float = getSubMod('speed');
		var add:Float = getSubMod('time_add');
		var desync:Float = getSubMod('desync');
		var timerType:Float = getSubMod('timertype');

		var returnValue:Float = 0.0;

		if (!legacy)
		{
			if (oldMath)
			{
				if (!usesAlt)
					returnValue = currentValue * (FlxMath.fastSin((((Modifier.beat + add / Conductor.stepCrochet) * speed) +
						(lane * desync)) * Math.PI) * NoteMovement.arrowSize / 2);
				else
					returnValue = currentValue * (FlxMath.fastCos((((Modifier.beat + add / Conductor.stepCrochet) * speed) +
						(lane * desync)) * Math.PI) * NoteMovement.arrowSize / 2);
			}
			else
			{
				var time:Float = (timerType >= 0.5 ? Modifier.beat : Conductor.songPosition * 0.001);
				time *= speed;
				time += add;
				if (!usesAlt)
					returnValue = currentValue * FlxMath.fastSin(time + (lane * desync) * Math.PI) * (NoteMovement.arrowSize / 2);
				else
					returnValue = currentValue * FlxMath.fastCos(time + (lane * desync) * Math.PI) * (NoteMovement.arrowSize / 2);
			}
		}
		else
		{
			if (usesAlt)
				returnValue = 260 * currentValue * FlxMath.fastCos(((Conductor.songPosition) * (speed) * 0.0008) + (lane / 4)) * 0.2;
			else
				returnValue = 260 * currentValue * FlxMath.fastSin(((Conductor.songPosition) * (speed) * 0.0008) + (lane / 4)) * 0.2;
		}

		return returnValue;
	}

	function tanWavyMath(lane:Int)
	{
		var legacy:Bool = (getSubMod('legacy') >= 0.5);
		var oldMath:Bool = (getSubMod('oldmath') >= 0.5);
		var usesAlt:Bool = (getSubMod('useAlt') >= 0.5);

		var speed:Float = getSubMod('speed');
		var add:Float = getSubMod('time_add');
		var desync:Float = getSubMod('desync');
		var timerType:Float = getSubMod('timertype');

		var returnValue:Float = 0.0;

		if (!legacy)
		{
			if (oldMath)
			{
				if (!usesAlt)
					returnValue = currentValue * (Math.tan((((Modifier.beat + add / Conductor.stepCrochet) * speed) +
						(lane * desync)) * Math.PI) * NoteMovement.arrowSize / 2);
				else
					returnValue = currentValue * (1 / Math.sin((((Modifier.beat + add / Conductor.stepCrochet) * speed) +
						(lane * desync)) * Math.PI) * NoteMovement.arrowSize / 2);
			}
			else
			{
				var time:Float = (timerType >= 0.5 ? Modifier.beat : Conductor.songPosition * 0.001);
				time *= speed;
				time += add;
				if (!usesAlt)
					returnValue = currentValue * Math.tan(time + (lane * desync) * Math.PI) * (NoteMovement.arrowSize / 2);
				else
					returnValue = currentValue * (1 / Math.sin(time + (lane * desync) * Math.PI) * (NoteMovement.arrowSize / 2));
			}
		}
		else
		{
			if (usesAlt)
				returnValue = 260 * currentValue * (1 / Math.sin(((Conductor.songPosition) * (speed) * 0.0008) + (lane / 4))) * 0.2;
			else
				returnValue = 260 * currentValue * Math.tan(((Conductor.songPosition) * (speed) * 0.0008) + (lane / 4)) * 0.2;
		}

		return returnValue;
	}
}

class WavyXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.x += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.y += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyZModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.z += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyAngleModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.angle += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyAngleXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.angleX += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyAngleYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.angleY += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyScaleModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.scaleX += (wavyMath(lane) - 1);
		noteData.scaleY += (wavyMath(lane) - 1);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyScaleXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.scaleX += (wavyMath(lane) - 1);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavyScaleYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.scaleY += (wavyMath(lane) - 1);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavySkewModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.skewX += wavyMath(lane);
		noteData.skewY += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavySkewXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.skewX += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class WavySkewYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.skewY += wavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.x += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.y += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyZModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.z += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyAngleModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.angle += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyAngleXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.angleX += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyAngleYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.angleY += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyScaleModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.scaleX += (tanWavyMath(lane) - 1);
		noteData.scaleY += (tanWavyMath(lane) - 1);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyScaleXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.scaleX += (tanWavyMath(lane) - 1);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavyScaleYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.scaleY += (tanWavyMath(lane) - 1);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavySkewModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.skewX += tanWavyMath(lane);
		noteData.skewY += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavySkewXModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.skewX += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class TanWavySkewYModifier extends Wavy
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.skewY += tanWavyMath(lane);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}
