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
	[EXTRA] Tipsy Improvements:
	-   Now instead of copy paste the math over and over, tipsy has a main helper class with all math, making it easier to use tipsy with its sin(cos)/tan(cot) variants.

	[EXTRA & REWORK] Tipsy Helper class:
	-   Tipsy helper class has the basics of Tipsy with lot of new subValues (for both Tipsy and TanTipsy).
	-   Added 4 subValues:
		+   Period (changes tipsy's period)
		+   Offset (changes tipsy's offset)
		+   UseAlt (changes it's math, if tipsy (uses sin) it will now use cos, if tanTipsy (uses tangent) it will now use cosecant).
		+   timerType (changes the way tipsy works, if value is 0.5 or more it will use beat as its math, else uses default behaviour).
	-   Tipsy helper class can be called via custom mods (so you can create any custom tipsyMod, such as idk, tipsyDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Tipsy(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Tipsy)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.
	[UPDATE]
	- Tipsy (the shared modifier) now carries strumMath to share instead of copy and paste.
 */
class Tipsy extends Modifier // My idea is clever, make this more simple to use
{
	override function setupSubValues()
	{
		setSubMod('speed', 1.0);
		setSubMod('desync', 2.0);
		setSubMod('offset', 0.0);
		setSubMod('timertype', 0.0);
		setSubMod('useAlt', 0.0);
	}

	function tanTipsyMath(lane:Int, curPos:Float):Float
	{
		var time:Float = (getSubMod('timertype') >= 0.5 ? Modifier.beat : Conductor.songPosition * 0.001 * 1.2);
		time *= getSubMod('speed');
		time += getSubMod('offset');

		var usesAlt:Bool = (getSubMod("useAlt") >= 0.5);
		var returnValue:Float = 0.0;
		if (usesAlt)
			returnValue = currentValue * (1 / Math.sin((time + ((lane) % NoteMovement.keyCount) * getSubMod('desync')) * (5) * 1 * 0.2) * Note.swagWidth * 0.5);
		else
			returnValue = currentValue * (Math.tan((time + ((lane) % NoteMovement.keyCount) * getSubMod('desync')) * (5) * 1 * 0.2) * Note.swagWidth * 0.5);

		return returnValue;
	}

	function tipsyMath(lane:Int, curPos:Float):Float
	{
		var time:Float = (getSubMod('timertype') >= 0.5 ? Modifier.beat : Conductor.songPosition * 0.001 * 1.2);
		time *= getSubMod('speed');
		time += getSubMod('offset');

		var usesAlt:Bool = (getSubMod("useAlt") >= 0.5);
		var returnValue:Float = 0.0;

		if (usesAlt)
			returnValue = currentValue * (FlxMath.fastCos((time + ((lane) % NoteMovement.keyCount) * getSubMod('desync')) * (5) * 1 * 0.2) * Note.swagWidth * 0.5);
		else
			returnValue = currentValue * (FlxMath.fastSin((time + ((lane) % NoteMovement.keyCount) * getSubMod('desync')) * (5) * 1 * 0.2) * Note.swagWidth * 0.5);

		return returnValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class TipsyXModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += tipsyMath(lane, curPos);
	}
}

class TipsyYModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += tipsyMath(lane, curPos);
	}
}

class TipsyZModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += tipsyMath(lane, curPos);
	}
}

class TipsyAngleModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += tipsyMath(lane, curPos);
	}
}

class TipsyScaleModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += tipsyMath(lane, curPos) * 0.001;
		noteData.scaleY += tipsyMath(lane, curPos) * 0.001;
	}
}

class TipsyScaleXModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += tipsyMath(lane, curPos) * 0.001;
	}
}

class TipsyScaleYModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += tipsyMath(lane, curPos) * 0.001;
	}
}

class TipsySkewModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tipsyMath(lane, curPos);
		noteData.skewY += tipsyMath(lane, curPos);
	}
}

class TipsySkewXModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tipsyMath(lane, curPos);
	}
}

class TipsySkewYModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += tipsyMath(lane, curPos);
	}
}

class TanTipsyXModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += tanTipsyMath(lane, curPos);
	}
}

class TanTipsyYModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += tanTipsyMath(lane, curPos);
	}
}

class TanTipsyZModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += tanTipsyMath(lane, curPos);
	}
}

class TanTipsyAngleModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += tanTipsyMath(lane, curPos);
	}
}

class TanTipsyScaleModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((tanTipsyMath(lane, curPos) * 0.001) - 1);
		noteData.scaleY += ((tanTipsyMath(lane, curPos) * 0.001) - 1);
	}
}

class TanTipsyScaleXModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((tanTipsyMath(lane, curPos) * 0.001) - 1);
	}
}

class TanTipsyScaleYModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += ((tanTipsyMath(lane, curPos) * 0.001) - 1);
	}
}

class TanTipsySkewModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tanTipsyMath(lane, curPos);
		noteData.skewY += tanTipsyMath(lane, curPos);
	}
}

class TanTipsySkewXModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tanTipsyMath(lane, curPos);
	}
}

class TanTipsySkewYModifier extends Tipsy
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += tanTipsyMath(lane, curPos);
	}
}
