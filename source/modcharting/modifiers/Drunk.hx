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
	[EXTRA] Drunk Improvements:
	-   Now instead of copy paste the math over and over, drunk has a main helper class with all math, making it easier to use drunk with its sin(cos)/tan(cot) variants.

	[EXTRA & REWORK] Drunk Helper class:
	-   Drunk helper class has the basics of Drunk with lot of new subValues (for both Drunk and TanDrunk).
	-   Added 5 subValues:
		+   desync (changes drunk's desync)
		+   Offset (changes drunk's offset)
		+   Size (changes how big/small drunk goes)
		+   UseAlt (changes it's math, if drunk (uses sin) it will now use cos, if tanDrunk (uses tangent) it will now use cosecant).
		+   timerType (changes the way drunk works, if value is 0.5 or more it will use beat as its math, else uses default behaviour).
	-   Drunk helper class can be called via custom mods (so you can create any custom drunkMod, such as idk, drunkDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Drunk(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Drunk)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[REMOVAL] cosecModifier:
	-   cosecModifier was supposed to be "cosecantDrunk" as the addition of Drunk helper class, this modifier became useless (you can just use tan + useAlt).

	[NEW] 
	- DrunkAngleX, DrunkAngleY, TanDrunkAngleX, TanDrunkAngleY. Prespective Angles added!
 */
class Drunk extends Modifier // My idea is clever, make this more simple to use
{
	override function setupSubValues()
	{
		setSubMod("speed", 1.0);
		setSubMod("size", 1.0);
		setSubMod("desync", 1.0);
		setSubMod("offset", 1.0);
		setSubMod("useAlt", 0.0);
		setSubMod("timertype", 0.0);
	}

	function tanDrunkMath(lane:Int, curPos:Float):Float
	{
		var time:Float = (getSubMod('timertype') >= 0.5 ? Modifier.beat : Conductor.songPosition * 0.001);
		time *= getSubMod('speed') / 2.0;
		time += getSubMod('offset');

		var usesAlt:Bool = (getSubMod("useAlt") >= 0.5);
		var screenHeight:Float = FlxG.height;
		var drunk_desync:Float = getSubMod("desync") * 0.2;
		var returnValue:Float = 0.0;
		var mult:Float = getSubMod("size")/2;
		if (!usesAlt)
			returnValue = currentValue * (Math.tan((time) + (((lane) % NoteMovement.keyCount) * drunk_desync) +
				(curPos * 0.45) * (10.0 / screenHeight) * mult)) * (Note.swagWidth * 0.5);
		else
			returnValue = currentValue * (1 / Math.sin((time) + (((lane) % NoteMovement.keyCount) * drunk_desync)
				+ (curPos * 0.45) * (10.0 / screenHeight) * mult)) * (Note.swagWidth * 0.5);

		return returnValue;
	}

	function drunkMath(lane:Int, curPos:Float):Float
	{
		var time:Float = (getSubMod('timertype') >= 0.5 ? Modifier.beat : Conductor.songPosition * 0.001);
		time *= getSubMod('speed');
		time += getSubMod('offset');

		var usesAlt:Bool = (getSubMod("useAlt") >= 0.5);
		var screenHeight:Float = FlxG.height;
		var drunk_desync:Float = getSubMod("desync") * 0.2;
		var returnValue:Float = 0.0;
		var mult:Float = getSubMod("size")/2;

		if (!usesAlt)
			returnValue = currentValue * (FlxMath.fastSin((time) + (((lane) % NoteMovement.keyCount) * drunk_desync)
				+ (curPos * 0.45) * (10.0 / screenHeight) * mult)) * (Note.swagWidth * 0.5);
		else
			returnValue = currentValue * (FlxMath.fastCos((time) + (((lane) % NoteMovement.keyCount) * drunk_desync)
				+ (curPos * 0.45) * (10.0 / screenHeight) * mult)) * (Note.swagWidth * 0.5);

		return returnValue;
	}
}

class DrunkXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkZModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class DrunkAngleModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkAngleXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkAngleYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkScaleModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (drunkMath(lane, curPos) - 1);
		noteData.scaleY += (drunkMath(lane, curPos) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkScaleXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (drunkMath(lane, curPos) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkScaleYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += (drunkMath(lane, curPos) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkSkewModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += drunkMath(lane, curPos);
		noteData.skewY += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkSkewXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DrunkSkewYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += drunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkZModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkAngleModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkAngleXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkAngleYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkScaleModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (tanDrunkMath(lane, curPos) - 1);
		noteData.scaleY += (tanDrunkMath(lane, curPos) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkScaleXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += (tanDrunkMath(lane, curPos) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkScaleYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += (tanDrunkMath(lane, curPos) - 1);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkSkewModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tanDrunkMath(lane, curPos);
		noteData.skewY += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkSkewXModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TanDrunkSkewYModifier extends Drunk
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += tanDrunkMath(lane, curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}
