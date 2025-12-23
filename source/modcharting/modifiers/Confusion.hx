package modcharting.modifiers;

import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;
import modcharting.PlayfieldRenderer.StrumNoteType;
import objects.Note;

// CONFUSION EXPLAIN:
// Confusion on notITG works different from here, and i want an easy enviroment for both notITG modcharters and MT modcharters, so from now on
// Confusion will work the SAME way as notITG, ofc adding 2 new modifiers "ConfusionOffset" and "AngleModifier"
// That being said, time to explain
// CHANGE LOG (the changes to modifiers)
// [REWORK] = totally overhaul of a modifier
// [UPDATE] = changed something on the modifier
// [RENAME] = rename of a modifier
// [REMOVAL] = a removed modifier
// [NEW] = a new modifier
// [EXTRA] = has nothing to do with modifiers but MT's enviroment.
// HERE CHANGE LIST

/*
	[NEW] AngleModifier:
	-   New modifier based on old confusion behaviour (uses degrees) (Includes X,Y variants).
	-   Added 1 subValue (BASIC ONLY):
		+ force (forced by default, this defines if notes takes in mind the scroll to rotate clockwise or counter clockwise)

	[NEW] ConfusionOffsetModifier:
	-   New modifier ported from notITG (uses radians) (Includes X,Y variants).
	-   Added 1 subValue (BASIC ONLY):
		+ force (forced by default, this defines if notes takes in mind the scroll to rotate clockwise or counter clockwise)
								
	[UPDATE] TwirlModifier:
	-   Added 2 subValues:
		+ useOld (recreates the same effect with "ScaleModifier" instead of 3D render (can be useful))
		+ Forced (makes the same effect but doesn't depend on curpos (will go on forever even when curpos is being modified))

	[UPDATE] RollModifier:
	-   Added 2 subValues:
		+ useOld (recreates the same effect with "ScaleModifier" instead of 3D render (can be useful))
		+ Forced (makes the same effect but doesn't depend on curpos (will go on forever even when curpos is being modified))

	[UPDATE] DizzyModifier:
	-   Added 1 subValue:
		+ Forced (makes the same effect but doesn't depend on curpos (will go on forever even when curpos is being modified))

	[REWORK] ConfusionModifier:
	-   Now it's behaviour works like notITG making it cleaner for notITG modders interested on MT template for FNF (Includes X,Y variants).
	-   Added 2 subValues:
		+ useOld (recreates the same effect with "ScaleModifier" instead of 3D render (can be useful) (Apply only for X,Y variants))
		+ Forced (makes the same effect but doesn't mind the scroll (enabled by default, if disabled it changes when using downscroll/upscroll))

	[REMOVAL] ConfusionConstantModifier:
	-   This one was made to be "notITG" confusion style, to then me change mind about it, and make the OG confusion work like notITG, making this one useless.
 */
class AngleModifier extends Modifier // note angle
{
	override function setupSubValues()
	{
		setSubMod("force", 1.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		if (getSubMod("force") >= 0.5)
			noteData.angle += currentValue;
		else
			noteData.angle += currentValue * scrollSwitch; // forced as default now to fix upscroll and downscroll modcharts that uses angle (no need for z and x, just angle and y)
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class AngleXModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class AngleYModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ConfusionOffsetModifier extends Modifier // note angle
{
	override function setupSubValues()
	{
		setSubMod("force", 1.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		if (getSubMod("force") >= 0.5)
			noteData.angle += currentValue * FlxAngle.TO_DEG;
		else
			noteData.angle += currentValue * FlxAngle.TO_DEG * scrollSwitch; // forced as default now to fix upscroll and downscroll modcharts that uses angle (no need for z and x, just angle and y)
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ConfusionOffsetXModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX += currentValue * FlxAngle.TO_DEG;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ConfusionOffsetYModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY += currentValue * FlxAngle.TO_DEG;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ConfusionModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("forced", 1.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;
		var mathToUse = 0.0;
		if (getSubMod("forced") >= 0.5)
			mathToUse = Modifier.beat;
		else
			mathToUse = Modifier.beat * scrollSwitch;

		noteData.angle += mathToUse * currentValue * FlxAngle.TO_DEG; // forced as default now to fix upscroll and downscroll modcharts that uses angle (no need for z and x, just angle and y)
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ConfusionXModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("useOld", 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		var mathToUse = 0.0;
		var result = 0.0;
		mathToUse = Modifier.beat;

		result = mathToUse * currentValue * FlxAngle.TO_DEG;

		if (getSubMod("useOld") >= 0.5)
			noteData.scaleX *= FlxMath.fastCos(result * (Math.PI / 180));
		else
			noteData.angleY += result;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ConfusionYModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("useOld", 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		var mathToUse = 0.0;
		var result = 0.0;
		mathToUse = Modifier.beat;

		result = mathToUse * currentValue * FlxAngle.TO_DEG;

		if (getSubMod("useOld") >= 0.5)
			noteData.scaleY *= FlxMath.fastCos(result * (Math.PI / 180));
		else
			noteData.angleX += result;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class DizzyModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("forced", 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		if (getSubMod("forced") >= 0.5)
			noteData.angle += currentValue * (Conductor.songPosition * 0.001);
		else
			noteData.angle += currentValue * (curPos / 2.0);
	}
}

class TwirlModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("forced", 0.0);
		setSubMod("useOld", 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var mathToUse = 0.0;
		var result = 0.0;
		if (getSubMod("forced") >= 0.5)
			mathToUse = Conductor.songPosition * 0.001;
		else
			mathToUse = curPos / 2.0;

		result = mathToUse * currentValue;

		if (getSubMod("useOld") >= 0.5)
			noteData.scaleX *= FlxMath.fastCos(result * (Math.PI / 180));
		else
			noteData.angleY += result;
	}
}

class RollModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("forced", 0.0);
		setSubMod("useOld", 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var mathToUse = 0.0;
		var result = 0.0;
		if (getSubMod("forced") >= 0.5)
			mathToUse = Conductor.songPosition * 0.001;
		else
			mathToUse = curPos / 2.0;

		result = mathToUse * currentValue;

		if (getSubMod("useOld") >= 0.5)
			noteData.scaleY *= FlxMath.fastCos(result * (Math.PI / 180));
		else
			noteData.angleX += result;
	}
}
