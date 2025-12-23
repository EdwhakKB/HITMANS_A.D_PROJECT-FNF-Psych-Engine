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
	[NEW] MoveModifier: (X,Y,YD,Z)
	-   Modifier ported from notITG, uses percent to move notes instead of value (so 1, would mean a WHOLE note move, not 1 pixel).

	[EXTRA] Backwards Support:
	-   X,Y,YD,Z,ANGLE(X,Y Included),SCALE(X,Y Included),ALPHA modifiers are now on the Backwards Support list.

	[REWORK & RENAME] TransformModifier: (Previously known as StrumsModifier)
	-   Replaces StrumModifier (for better syntaxis) with the removal of "Invert and Flip" since it made those modifiers useless.
	-   Uses all basic mods (X,Y,YD,Z,ANGLE,ANGLED,SCALE,SKEW) as subValues.

	[REWORK & RENAME] NoteOffsetModifier: (Previously known as NotesModifier)
	-   Replaces NotesModifier (for better syntaxis) with the removal of "Invert and Flip" since it made those modifiers useless.
	-   Uses all basic mods (X,Y,YD,Z,ANGLE,ANGLED,SCALE,SKEW) as subValues.

	[REWORK & RENAME] StrumOffsetModifier: (Previously known as LanesModifier)
	-   Replaces LanesModifier (for better syntaxis) with the removal of "Invert and Flip" since it made those modifiers useless.
	-   Uses all basic mods (X,Y,YD,Z,ANGLE,ANGLED,SCALE,SKEW) as subValues.

	[REMOVAL] MISC MODS:
	-   MISC MODS were all those mods that were helpers from others (skewOffsetX) as new 3D render does not use them.
 */
class TransformModifier extends Modifier
{
	var daswitch = 1;

	override function setupSubValues()
	{
		baseValue = 0.0;
		currentValue = 1.0; // By default enabled (can be turned off but won't work until turned back on)

		setSubMod('x', 0.0);
		setSubMod('y', 0.0);
		setSubMod('yD', 0.0); // Controls scroll movement (if downscroll, goes up, otherwise it goes down like normal Y)
		setSubMod('z', 0.0);

		setSubMod('angle', 0.0);
		setSubMod('angleD', 0.0); // similar to yD, this one changes angle bettwen scrolls for more proper visuals (intros and etc)
		setSubMod('anglex', 0.0);
		setSubMod('angley', 0.0);

		setSubMod('alpha', 0.0);

		setSubMod('scale', 1.0); // scale is set to 1 by default (so notes does not start fucking invisible)
		setSubMod('scalex', 1.0);
		setSubMod('scaley', 1.0);

		setSubMod('skew', 0.0);
		setSubMod('skewx', 0.0);
		setSubMod('skewy', 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				daswitch = -1;

		noteData.x += getSubMod('x');
		noteData.y += getSubMod('y') + (getSubMod('yD') * daswitch);
		noteData.z += getSubMod('z');

		noteData.angle += getSubMod('angle') + (getSubMod('angleD') * daswitch);
		noteData.angleX += getSubMod('anglex');
		noteData.angleY += getSubMod('angley');

		noteData.alpha *= 1 - getSubMod('alpha'); // alpha to 1 means it's invisible, otherwise it's visible

		noteData.scaleX += (getSubMod('scalex') - 1) + (getSubMod('scale') - 1);
		noteData.scaleY += (getSubMod('scaley') - 1) + (getSubMod('scale') - 1);

		noteData.skewX += getSubMod('skewx') + getSubMod('skew');
		noteData.skewY += getSubMod('skewy') + getSubMod('skew');
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}

	override function reset()
	{
		super.reset();
		baseValue = 0.0;
		currentValue = 1.0;
	}
}

// Same as Transform but exclusive for notes
class NoteOffsetModifier extends Modifier
{
	var daswitch = 1;

	override function setupSubValues()
	{
		baseValue = 0.0;
		currentValue = 1.0; // By default enabled (can be turned off but won't work until turned back on)

		setSubMod('x', 0.0);
		setSubMod('y', 0.0);
		setSubMod('yD', 0.0); // Controls scroll movement (if downscroll, goes up, otherwise it goes down like normal Y)
		setSubMod('z', 0.0);

		setSubMod('angle', 0.0);
		setSubMod('angleD', 0.0); // similar to yD, this one changes angle bettwen scrolls for more proper visuals (intros and etc)
		setSubMod('anglex', 0.0);
		setSubMod('angley', 0.0);

		setSubMod('alpha', 0.0);

		setSubMod('scale', 1.0); // scale is set to 1 by default (so notes does not start fucking invisible)
		setSubMod('scalex', 1.0);
		setSubMod('scaley', 1.0);

		setSubMod('skew', 0.0);
		setSubMod('skewx', 0.0);
		setSubMod('skewy', 0.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				daswitch = -1;

		noteData.x += getSubMod('x');
		noteData.y += getSubMod('y') + (getSubMod('yD') * daswitch);
		noteData.z += getSubMod('z');

		noteData.angle += getSubMod('angle') + (getSubMod('angleD') * daswitch);
		noteData.angleX += getSubMod('anglex');
		noteData.angleY += getSubMod('angley');

		noteData.alpha *= 1 - getSubMod('alpha'); // alpha to 1 means it's invisible, otherwise it's visible

		noteData.scaleX += (getSubMod('scalex') - 1) + (getSubMod('scale') - 1);
		noteData.scaleY += (getSubMod('scaley') - 1) + (getSubMod('scale') - 1);

		noteData.skewX += getSubMod('skewx') + getSubMod('skew');
		noteData.skewY += getSubMod('skewy') + getSubMod('skew');
	}

	override function reset()
	{
		super.reset();
		baseValue = 0.0;
		currentValue = 1.0;
	}
}

// Same as Transform but exclusive for strums
class StrumOffsetModifier extends Modifier
{
	var daswitch = 1;

	override function setupSubValues()
	{
		baseValue = 0.0;
		currentValue = 1.0; // By default enabled (can be turned off but won't work until turned back on)

		setSubMod('x', 0.0);
		setSubMod('y', 0.0);
		setSubMod('yD', 0.0); // Controls scroll movement (if downscroll, goes up, otherwise it goes down like normal Y)
		setSubMod('z', 0.0);

		setSubMod('angle', 0.0);
		setSubMod('angleD', 0.0); // similar to yD, this one changes angle bettwen scrolls for more proper visuals (intros and etc)
		setSubMod('anglex', 0.0);
		setSubMod('angley', 0.0);

		setSubMod('alpha', 0.0);

		setSubMod('scale', 1.0); // scale is set to 1 by default (so notes does not start fucking invisible)
		setSubMod('scalex', 1.0);
		setSubMod('scaley', 1.0);

		setSubMod('skew', 0.0);
		setSubMod('skewx', 0.0);
		setSubMod('skewy', 0.0);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				daswitch = -1;

		noteData.x += getSubMod('x');
		noteData.y += getSubMod('y') + (getSubMod('yD') * daswitch);
		noteData.z += getSubMod('z');

		noteData.angle += getSubMod('angle') + (getSubMod('angleD') * daswitch);
		noteData.angleX += getSubMod('anglex');
		noteData.angleY += getSubMod('angley');

		noteData.alpha *= 1 - getSubMod('alpha'); // alpha to 1 means it's invisible, otherwise it's visible

		noteData.scaleX += (getSubMod('scalex') - 1) + (getSubMod('scale') - 1);
		noteData.scaleY += (getSubMod('scaley') - 1) + (getSubMod('scale') - 1);

		noteData.skewX += getSubMod('skewx') + getSubMod('skew');
		noteData.skewY += getSubMod('skewy') + getSubMod('skew');
	}

	override function reset()
	{
		super.reset();
		baseValue = 0.0;
		currentValue = 1.0;
	}
}

class MoveXModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += NoteMovement.arrowSizes[lane] * currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class MoveYModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += NoteMovement.arrowSizes[lane] * currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class MoveYDModifier extends Modifier // similar to Y but this one changes on default scroll (down/up)
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var daswitch = 1;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				daswitch = -1;
		noteData.y += NoteMovement.arrowSizes[lane] * currentValue * daswitch;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class MoveZModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += NoteMovement.arrowSizes[lane] * currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

// STORAGE OF OLDER MODS (as i said, MT rework won't add these on modchart editor's list, but they will be kept for backwards support.)
// If any modchart breaks due a modifier removal or change (Confusion's case), just fix it, change the modifier and thats it.

class XModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class YModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class YDModifier extends Modifier // similar to Y but this one changes on default scroll (down/up)
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var daswitch = 1;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				daswitch = -1;
		noteData.y += currentValue * daswitch;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ZModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

/*

	//MISC MODS //mods that don't change anything by themselves, but helps other mods to change their visuals

	class PivotXOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.pivotOffsetX += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}
	class PivotYOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.pivotOffsetY += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}
	class PivotZOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.pivotOffsetZ += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}

	class SkewXOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX_offset += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}
	class SkewYOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY_offset += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}
	class SkewZOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewZ_offset += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}

	class FovXOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.fovOffsetX += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}
	class FovYOffsetModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.fovOffsetY += currentValue;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}

	class CullNTModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		if (currentValue == 0){
			noteData.cullMode = "none";
		}else if (currentValue > 0){
			noteData.cullMode = "positive";
		}else if (currentValue < 0){
			noteData.cullMode = "negative";
		}else if (currentValue >= 2){
			noteData.cullMode = "always_positive";
		}else if (currentValue <= -2){
			noteData.cullMode = "always_negative";
		}
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
	}

	class CullNotesModifier extends Modifier
	{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		if (currentValue == 0){
			noteData.cullMode = "none";
		}else if (currentValue > 0){
			noteData.cullMode = "positive";
		}else if (currentValue < 0){
			noteData.cullMode = "negative";
		}else if (currentValue >= 2){
			noteData.cullMode = "always_positive";
		}else if (currentValue <= -2){
			noteData.cullMode = "always_negative";
		}
	}
	}

	class CullTargetsModifier extends Modifier
	{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		if (currentValue == 0){
			noteData.cullMode = "none";
		}else if (currentValue > 0){
			noteData.cullMode = "positive";
		}else if (currentValue < 0){
			noteData.cullMode = "negative";
		}else if (currentValue >= 2){
			noteData.cullMode = "always_positive";
		}else if (currentValue <= -2){
			noteData.cullMode = "always_negative";
		}
	}
	}
 */
