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
	[EXTRA] Spiral Improvements:
	-   Now instead of copy paste the math over and over, Spiral has a main helper class with all math, making it easier to use Spiral.

	[EXTRA & REWORK] Spiral Helper class:
	-   Spiral helper class has the basics of Spiral with new subValues.
	-   Added 4 subValues:
		+   mult (changes Spiral's period)
		+   offset (changes Spiral's offset)
		+   force (forces Spiral math to use songPosition rather than curPos (so mods modifying curpos don't affect spiral's behaviour))
		+   useAlt (changes Spiral's method, if value is higher than 0.5 it will use Cosine rather than sine)
	-   Spiral helper class can be called via custom mods (so you can create any custom SpiralMod, such as idk, SpiralDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Spiral(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Spiral)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[NEW] 
	- SpiralAngleX, SpiralAngleY. Prespective Angles added!
 */

class Spiral extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("offset", 0.0);
		setSubMod("mult", 0.05);
		setSubMod("force", 0.0);
		setSubMod("useAlt", 0.0);
	}

	function spiralMath(curPos:Float):Float
	{
		var ud = false;
        if (instance != null) if (ModchartUtil.getDownscroll(instance)) ud = true;

		curPos = curPos * (ud ? -1 : 1);
		curPos *= -0.1;
		var curposWithOffset:Float = curPos - getSubMod("offset");

		if (getSubMod("useAlt") > 0.5)
		{
			return (Math.cos(curposWithOffset * Math.PI * getSubMod("mult")) * curPos * curPos) * currentValue / 100;
		}
		else
		{
			return (Math.sin(curposWithOffset * Math.PI * getSubMod("mult")) * curPos * curPos) * currentValue / 100;
		}
	}
}

class SpiralXModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos));
	}
}

class SpiralYModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos));
	}
}

class SpiralZModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos));
	}
}

class SpiralAngleModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos));
	}
}

class SpiralAngleXModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos));
	}
}

class SpiralAngleYModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos));
	}
}

class SpiralScaleModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.01;
		noteData.scaleY += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.01;
	}
}

class SpiralScaleXModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.01;
	}
}

class SpiralScaleYModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.01;
	}
}

class SpiralSkewModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.5;
		noteData.skewY += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.5;
	}
}

class SpiralSkewXModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.5;
	}
}

class SpiralSkewYModifier extends Spiral
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += spiralMath((getSubMod("force") >= 0.5 ? Conductor.songPosition * 0.001 : curPos)) * 0.5;
	}
}