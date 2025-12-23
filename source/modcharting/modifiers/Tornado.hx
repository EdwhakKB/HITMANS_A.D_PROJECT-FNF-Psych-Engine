package modcharting.modifiers;

import modcharting.*;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;
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
	[EXTRA] Tornado Improvements:
	-   Now instead of copy paste the math over and over, Tornado has a main helper class with all math, making it easier to use Tornado with its sin(cos)/tan(cot) variants.

	[EXTRA & REWORK] Tornado Helper class:
	-   Tornado helper class has the basics of Tornado with lot of new subValues (for both Tornado and TanTornado).
	-   Added 2 subValues:
		+   Speed (changes Tornado's intensity)
		+   Offset (changes Tornado's offset)
	-   Tornado helper class can be called via custom mods (so you can create any custom TornadoMod, such as idk, TornadoDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Tornado(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Tornado)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.
 */
class Tornado extends Modifier
{
	override function setupSubValues()
	{
		setSubMod('speed', 1.0);
		setSubMod('offset', 0.0);
	}

	// Tornado math
	public function tornadoMath(lane:Int, curPos:Float)
	{
		var ud = false;
        if (instance != null) if (ModchartUtil.getDownscroll(instance)) ud = true;

		var daCurPos = curPos + getSubMod('offset') * (ud ? -1 : 1);
		var playerColumn = lane % NoteMovement.keyCount;
		var columnPhaseShift = playerColumn * Math.PI / 3;
		var phaseShift = (daCurPos / 135) * getSubMod('speed') * 0.2;
		var returnReceptorToZeroOffsetX = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
		var offsetX = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetX;

		return offsetX;
	}

	public function tornadoTanMath(lane:Int, curPos:Float)
	{
		var ud = false;
        if (instance != null) if (ModchartUtil.getDownscroll(instance)) ud = true;
		
		var daCurPos = curPos + getSubMod('offset') * (ud ? -1 : 1);
		var playerColumn = lane % NoteMovement.keyCount;
		var columnPhaseShift = playerColumn * Math.PI / 3;
		var phaseShift = (daCurPos / 135) * getSubMod('speed') * 0.2;
		var returnReceptorToZeroOffsetX = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
		var offsetX = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetX;

		return offsetX;
	}
}

class TornadoXModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += tornadoMath(lane, curPos) * currentValue;
	}
}

class TornadoYModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += tornadoMath(lane, curPos) * currentValue;
	}
}

class TornadoZModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += tornadoMath(lane, curPos) * currentValue;
	}
}

class TornadoAngleModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += tornadoMath(lane, curPos) * currentValue;
	}
}

class TornadoScaleModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((currentValue * 0.01) * tornadoMath(lane, curPos)) - 1);
		noteData.scaleY += (((currentValue * 0.01) * tornadoMath(lane, curPos)) - 1);
	}
}

class TornadoScaleXModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((currentValue * 0.01) * tornadoMath(lane, curPos)) - 1);
	}
}

class TornadoScaleYModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += (((currentValue * 0.01) * tornadoMath(lane, curPos)) - 1);
	}
}

class TornadoSkewModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tornadoMath(lane, curPos) * currentValue;
		noteData.skewY += tornadoMath(lane, curPos) * currentValue;
	}
}

class TornadoSkewXModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tornadoMath(lane, curPos) * currentValue;
	}
}

class TornadoSkewYModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += tornadoMath(lane, curPos) * currentValue;
	}
}

class TanTornadoXModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += tornadoTanMath(lane, curPos) * currentValue;
	}
}

class TanTornadoYModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += tornadoTanMath(lane, curPos) * currentValue;
	}
}

class TanTornadoZModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += tornadoTanMath(lane, curPos) * currentValue;
	}
}

class TanTornadoAngleModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += tornadoTanMath(lane, curPos) * currentValue;
	}
}

class TanTornadoScaleModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((currentValue * 0.01) * tornadoTanMath(lane, curPos)) - 1);
		noteData.scaleY += (((currentValue * 0.01) * tornadoTanMath(lane, curPos)) - 1);
	}
}

class TanTornadoScaleXModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (((currentValue * 0.01) * tornadoTanMath(lane, curPos)) - 1);
	}
}

class TanTornadoScaleYModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += (((currentValue * 0.01) * tornadoTanMath(lane, curPos)) - 1);
	}
}

class TanTornadoSkewModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tornadoTanMath(lane, curPos) * currentValue;
		noteData.skewY += tornadoTanMath(lane, curPos) * currentValue;
	}
}

class TanTornadoSkewXModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tornadoTanMath(lane, curPos) * currentValue;
	}
}

class TanTornadoSkewYModifier extends Tornado
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += tornadoTanMath(lane, curPos) * currentValue;
	}
}
