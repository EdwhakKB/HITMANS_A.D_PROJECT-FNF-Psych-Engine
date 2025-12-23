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
	[EXTRA] Bounce Improvements:
	-   Now instead of copy paste the math over and over, Bounce has a main helper class with all math, making it easier to use Bounce with its sin(cos)/tan(cosec) variants.

	[EXTRA & REWORK] Bounce Helper class:
	-   Bounce helper class has the basics of Bounce with lot of new subValues (for both Bounce and TanBounce).
	- 	Some changes to the math, nothing too agressive to force people to redo a modchart, just some adjustments.
	-   Has 2 subValues:
		+   speed (changes Bounce's speed)
		+	useAlt (changes Bounce's math method, if using sin then it uses cos, if using tan it uses cosec, have in mind it will also move the strums (if enabled))
		+ Methods (2):
			1. Use ModifiersMath.Bounce(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Bounce)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[NEW]
	- BounceAngleX, BounceAngleY, TanBounceAngleX, TanBounceAngleY. Prespective Angle Mods.
 */
class Bounce extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("speed", 1.0);
		setSubMod("useAlt", 0.0);
	}

	function bounce(curPos:Float):Float
	{
		var speed:Float = getSubMod("speed");
		var usesAlt:Bool = (getSubMod("useAlt") >= 0.5);

		var mathToUse:Float = 0.0;

		if (!usesAlt)
			mathToUse = NoteMovement.arrowSize * Math.abs(FlxMath.fastSin(curPos * 0.005 * (speed * 2)));
		else
			mathToUse = NoteMovement.arrowSize * Math.abs(FlxMath.fastCos(curPos * 0.005 * (speed * 2)));

		return currentValue * mathToUse;
	}

	function tanBounce(curPos:Float):Float
	{
		var speed:Float = getSubMod("speed");
		var usesAlt:Bool = (getSubMod("useAlt") >= 0.5);

		var mathToUse:Float = 0.0;

		if (!usesAlt)
			mathToUse = NoteMovement.arrowSize * Math.abs(Math.tan(curPos * 0.005 * (speed * 2)));
		else
			mathToUse = NoteMovement.arrowSize * Math.abs((1 / Math.sin(curPos * 0.005 * (speed * 2))));

		return currentValue * mathToUse;
	}
}

class BounceXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceZModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceAngleModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceAngleXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceAngleYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceScaleModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += bounce(curPos) * 0.01;
		noteData.scaleY += bounce(curPos) * 0.01;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceScaleXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += bounce(curPos) * 0.01;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceScaleYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += bounce(curPos) * 0.01;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceSkewModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += bounce(curPos);
		noteData.skewY += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceSkewXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class BounceSkewYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += bounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceZModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceAngleModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceAngleXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceAngleYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceScaleModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += tanBounce(curPos) * 0.01;
		noteData.scaleY += tanBounce(curPos) * 0.01;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceScaleXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += tanBounce(curPos) * 0.01;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceScaleYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += tanBounce(curPos) * 0.01;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceSkewModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tanBounce(curPos);
		noteData.skewY += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceSkewXModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}

class TanBounceSkewYModifier extends Bounce
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += tanBounce(curPos);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (getSubMod("useAlt") >= 0.5)
			noteMath(noteData, lane, 0, pf);
	}
}
