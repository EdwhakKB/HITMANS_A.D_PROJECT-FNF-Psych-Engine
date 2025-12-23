package modcharting.modifiers;

import modcharting.*;
import modcharting.Modifier.ModifierSubValue;
import modcharting.Modifier;
import modcharting.PlayfieldRenderer.StrumNoteType;
import lime.math.Vector2;
import openfl.geom.Vector3D;

// CHANGE LOG (the changes to modifiers)
// [REWORK] = totally overhaul of a modifier
// [UPDATE] = changed something on the modifier
// [RENAME] = rename of a modifier
// [REMOVAL] = a removed modifier
// [NEW] = a new modifier
// [EXTRA] = has nothing to do with modifiers but MT's enviroment.
// HERE CHANGE LIST

/*
	[NEW] Rotate:
	-   New modifier that creates a rotation of both fields into a 3D space, like notITG (The math is directly ported from WITF (WHAT IN THE FUNKIN) by hazard24).

	[EXTRA & REWORK] Rotate Helper class:
	-   Rotate helper class has the basics of Rotate with new subValues.
	-   Added 3 subValues:
		+   offset_X (changes X midPoint to take when rotating)
		+   offset_Y (changes Y midPoint to take when rotating)
		+   offset_Z (changes Z midPoint to take when rotating)
	-   Rotate helper class can be called via custom mods (so you can create any custom RotateMod, such as idk, RotateDadX. yet you are the one who defines how to use it).
		+ Methods (2):
			1. Use ModifiersMath.Rotate(values) and set it to whatever you want to modify.
			2. Create a custom class (call it whatever u want (better if ends on "Modifier")) and extend it to this path (modcharting.modifiers.Rotate)
				then call it inside any customMod (yourPath/yourModifier.hx) on any of these (songName/customMods/yourCustomMod.hx) OR (songName/yourLua.lua)
				check how to make a customMod (both hx and lua) for better information.

	[NEW & RENAME] RotateFieldsModifier & RotateFields3DModifier: (Previously known as RotateModifier and Rotate3DModifier)
	-   Renamed modifiers to allow new "Rotate" modifier to exist, as the behaviour of these is more based on fields rather than 3D spaces.
 */

//PlayState.instance.strumLineNotes

class Rotate extends Modifier
{
	var pivotPoint:Vector2 = new Vector2(0, 0);
	var point:Vector2 = new Vector2(0, 0);

	var strumXRotA:Array<Float> = [];
	var strumXRotB:Array<Float> = [];

	var strumYRotA:Array<Float> = [];
	var strumYRotB:Array<Float> = [];

	var strumZRotA:Array<Float> = [];
	var strumZRotB:Array<Float> = [];

	override function setupSubValues()
	{
		baseValue = 0.0;
        currentValue = 1.0;

		setSubMod("x", 0.0);
		setSubMod("y", 0.0);
		setSubMod("z", 0.0);

		setSubMod("offset_x", 0.0);
		setSubMod("offset_y", 0.0);
		setSubMod("offset_z", 0.0);
	}

	function getPivot(noteData:NotePositionData, lane:Int, type:String = "x")
	{
		switch (type)
		{
			case "x":
				var r:Float = 0;
					
				//1 should return oponent's midPoint, while 2 should return player's
				var downStrumPosition:Float = NoteMovement.defaultStrumPos[
					(lane < NoteMovement.keyCount ? (Std.int(NoteMovement.totalKeyCount/2)) : (NoteMovement.totalKeyCount)) - Std.int((NoteMovement.keyCount/2)) - 1
				][0];
				var upStrumPosition:Float = NoteMovement.defaultStrumPos[
					(lane < NoteMovement.keyCount ? (Std.int(NoteMovement.totalKeyCount/2)) : (NoteMovement.totalKeyCount)) - Std.int((NoteMovement.keyCount/2))
				][0];

				var midPosition = (upStrumPosition - downStrumPosition) / 2;
				r += downStrumPosition + midPosition;
				r += getSubMod("offset_x");
				return r;
			case "y":
				return ((FlxG.height/2) - (NoteMovement.arrowSize / 2)) + getSubMod("offset_y");
			case "z":
				return 0.0 + getSubMod("offset_z");
			default:
				return 0.0;
		}
	}

	function rotatePivot(noteData:NotePositionData, lane:Int, pf:Int, type:String = "x")
	{
		var angleX:Float = getSubMod("x");
		var angleY:Float = getSubMod("y");
		var angleZ:Float = getSubMod("z");

		switch (type)
		{
			case "z":
				pivotPoint.x = getPivot(noteData, lane, "x");
				pivotPoint.y = getPivot(noteData, lane, "y");
				point.x = noteData.x;
				point.y = noteData.y;
				var output:Vector2 = ModchartUtil.rotateAround(pivotPoint, point, angleZ);
				noteData.x = output.x;
				noteData.y = output.y;
				strumZRotA[lane] = point.x - output.x;
				strumZRotB[lane] = point.y - output.y;
			case "y":
				pivotPoint.x = getPivot(noteData, lane, "x");
				pivotPoint.y = getPivot(noteData, lane, "z");
				point.x = noteData.x;
				point.y = noteData.z;
				var output:Vector2 = ModchartUtil.rotateAround(pivotPoint, point, angleY);
				noteData.x = output.x;
				noteData.z = output.y;
				strumYRotA[lane] = point.x - output.x;
				strumYRotB[lane] = point.y - output.y;
			case "x":
				pivotPoint.x = getPivot(noteData, lane, "z");
				pivotPoint.y = getPivot(noteData, lane, "y");
				point.x = noteData.z;
				point.y = noteData.y;
				var output:Vector2 = ModchartUtil.rotateAround(pivotPoint, point, angleX);
				noteData.z = output.x;
				noteData.y = output.y;
				strumXRotA[lane] = point.x - output.x;
				strumXRotB[lane] = point.y - output.y;
		}
	}
}

//This modifier was made based on "TheoDev's" RotateModifier which doesn't properly work
/*class RotateAltModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 0.0;
		currentValue = 1.0;

		setSubMod("x", 0.0);
		setSubMod("y", 0.0);
		setSubMod("z", 0.0);
	}

	public function getOrigin(noteData:NotePositionData):Vector3D {
		var fixedLane = Math.round(NoteMovement.totalKeyCount / 2);
		return new Vector3D(NoteMovement.defaultStrumX[fixedLane], FlxG.height / 2);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var angleX = getSubMod("x");
		var angleY = getSubMod("y");
		var angleZ = getSubMod("z");

		var curData:Vector3D = new Vector3D(noteData.x, noteData.y, noteData.z);
		var data:Vector3D = getOrigin(noteData);
		curData.decrementBy(data);

		var finalData = ModchartUtil.rotate3DVector(curData, angleX, angleY, angleZ);

		noteData.x += finalData.x;
		noteData.y += finalData.y;
		noteData.z += finalData.z;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}*/

class RotateModifier extends Rotate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		rotatePivot(noteData, lane, pf, "x");
		rotatePivot(noteData, lane, pf, "y");
		rotatePivot(noteData, lane, pf, "z");
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class NoteRotateModifier extends Rotate
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		rotatePivot(noteData, lane, pf, "x");
		rotatePivot(noteData, lane, pf, "y");
		rotatePivot(noteData, lane, pf, "z");
	}
}

class StrumRotateModifier extends Rotate
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		rotatePivot(noteData, lane, pf, "x");
		rotatePivot(noteData, lane, pf, "y");
		rotatePivot(noteData, lane, pf, "z");
	}
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var laneShit = lane % NoteMovement.keyCount;
		//X
		noteData.z -= strumXRotA[laneShit];
		noteData.y -= strumXRotB[laneShit];
		//Y
		noteData.x -= strumYRotA[laneShit];
		noteData.z -= strumYRotB[laneShit];
		//Z
		noteData.x -= strumZRotA[laneShit];
		noteData.y -= strumZRotB[laneShit];
	}
}

// class RotatingYModifier extends Rotate
// {
// 	override function setupSubValues()
// 	{
// 		setSubMod("affects_strum", 0.0);
// 	}
	
// 	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
// 	{
// 		var curVal:Float = currentValue * curPos / 180;
// 		noteRotatePivot(noteData, lane, "y", curVal);
// 	}

// 	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
// 	{
// 		if (currentValue % 360 == 0 || getSubMod("affects_strum") == 0) return;
// 		var curVal:Float = currentValue * 1 / 180;
// 		strumRotatePivot(noteData, lane, "y", curVal);
// 	}
// }

// here i add custom modifiers, why? well its to make some cool modcharts shits -Ed

class RotateFieldsModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("x", 0.0);
		setSubMod("y", 0.0);

		setSubMod("rotatePointX", (FlxG.width / 2) - (NoteMovement.arrowSize / 2));
		setSubMod("rotatePointY", (FlxG.height / 2) - (NoteMovement.arrowSize / 2));
		currentValue = 1.0;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var xPos = NoteMovement.defaultStrumPos[lane][0];
		var yPos = NoteMovement.defaultStrumPos[lane][1];
		var rotX = ModchartUtil.getCartesianCoords3D(getSubMod("x"), 90, xPos - getSubMod("rotatePointX"));
		noteData.x += rotX.x + getSubMod("rotatePointX") - xPos;
		var rotY = ModchartUtil.getCartesianCoords3D(90, getSubMod("y"), yPos - getSubMod("rotatePointY"));
		noteData.y += rotY.y + getSubMod("rotatePointY") - yPos;
		noteData.z += rotX.z + rotY.z;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}

	override function reset()
	{
		super.reset();
		currentValue = 1.0;
	}
}

class StrumLineRotateModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("x", 0.0);
		setSubMod("y", 0.0);
		setSubMod("z", 90.0);
		currentValue = 1.0;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var laneShit = lane % NoteMovement.keyCount;
		var offsetThing = 0.5;
		var halfKeyCount = NoteMovement.keyCount / 2;
		if (lane < halfKeyCount)
		{
			offsetThing = -0.5;
			laneShit = lane + 1;
		}
		var distFromCenter = ((laneShit) - halfKeyCount) + offsetThing; // theres probably an easier way of doing this
		// basically
		// 0 = 1.5
		// 1 = 0.5
		// 2 = -0.5
		// 3 = -1.5
		// so if you then multiply by the arrow size, all notes should be in the same place
		noteData.x += -distFromCenter * NoteMovement.arrowSize;

		var upscroll = true;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				upscroll = false;

		// var rot = ModchartUtil.getCartesianCoords3D(subValues.get('x').value, subValues.get('y').value, distFromCenter*NoteMovement.arrowSize);
		var q = SimpleQuaternion.fromEuler(getSubMod("z"), getSubMod("x"),
			(upscroll ? -getSubMod("y") : getSubMod("y"))); // i think this is the right order???
		// q = SimpleQuaternion.normalize(q); //dont think its too nessessary???
		noteData.x += q.x * distFromCenter * NoteMovement.arrowSize;
		noteData.y += q.y * distFromCenter * NoteMovement.arrowSize;
		noteData.z += q.z * distFromCenter * NoteMovement.arrowSize;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}

	override function reset()
	{
		super.reset();
		currentValue = 1.0;
	}
}

class RotateFields3DModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("x", 0.0);
		setSubMod("y", 0.0);

		setSubMod("rotatePointX", (FlxG.width / 2) - (NoteMovement.arrowSize / 2));
		setSubMod("rotatePointY", (FlxG.height / 2) - (NoteMovement.arrowSize / 2));
		currentValue = 1.0;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var xPos = NoteMovement.defaultStrumPos[lane][0];
		var yPos = NoteMovement.defaultStrumPos[lane][1];
		var rotX = ModchartUtil.getCartesianCoords3D(getSubMod("x"), 90, xPos - getSubMod("rotatePointX"));
		noteData.x += rotX.x + getSubMod("rotatePointX") - xPos;
		var rotY = ModchartUtil.getCartesianCoords3D(90, getSubMod("y"), yPos - getSubMod("rotatePointY"));
		noteData.y += rotY.y + getSubMod("rotatePointY") - yPos;
		noteData.z += rotX.z + rotY.z;

		noteData.angleY -= getSubMod("x");
		noteData.angleX -= getSubMod("y");
	}

	override function incomingAngleMath(lane:Int, curPos:Float, pf:Int)
	{
		var multiply:Bool = getSubMod("y") % 180 != 0; // so it calculates the stuff ONLY if angle its not 180/360 base
		var valueToUse:Float = multiply ? 90 : 0;
		return [valueToUse, getSubMod("y")]; // ik this might cause problems at some point with some modifiers but eh, there is nothing i could do about it- (i can LMAO)
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}

	override function reset()
	{
		super.reset();
		currentValue = 1.0;
	}
}

class StrumAngleModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var multiply = -1;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				multiply *= -1;
		noteData.angle += (currentValue * multiply);
		var laneShit = lane % NoteMovement.keyCount;
		var offsetThing = 0.5;
		var halfKeyCount = NoteMovement.keyCount / 2;
		if (lane < halfKeyCount)
		{
			offsetThing = -0.5;
			laneShit = lane + 1;
		}
		var distFromCenter = ((laneShit) - halfKeyCount) + offsetThing;
		noteData.x += -distFromCenter * NoteMovement.arrowSize;

		var q = SimpleQuaternion.fromEuler(90, 0, (currentValue * multiply)); // i think this is the right order???
		noteData.x += q.x * distFromCenter * NoteMovement.arrowSize;
		noteData.y += q.y * distFromCenter * NoteMovement.arrowSize;
		noteData.z += q.z * distFromCenter * NoteMovement.arrowSize;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		// noteData.angle += (subValues.get('y').value/2);
		noteMath(noteData, lane, 0, pf);
	}

	override function incomingAngleMath(lane:Int, curPos:Float, pf:Int)
	{
		return [0, currentValue * -1];
	}

	override function reset()
	{
		super.reset();
		currentValue = 0; // the code that stop the mod from running gets confused when it resets in the editor i guess??
	}
}
