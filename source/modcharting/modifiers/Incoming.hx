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
	[NEW] LinearModifier: (Includes X,Y,Z,Scale,Skew variants)
	-   New modifier to apply a linear incoming change on the scroll.
	-   Angle is not included as Dizzy, Twirl and Roll does same behaviour, making LinearAngleModifier useless.

	[NEW] CircModifier: (Includes X,Y,Z,Angle,Scale,Skew variants)
	-   New modifier similar to LinearModifier but with a circular incoming change on the scroll.

	[RENAME] EaseModifier: (Previously known as EaseCurveModifier)
	-   Renamed to have a simpler name that is more friendly for MT's enviroment and new modcharters.
 */
class Ease extends Modifier
{
	public var easeFunc = FlxEase.linear;

	public function setEase(ease:String)
	{
		easeFunc = ModchartUtil.getFlxEaseByString(ease);
	}
}

class EaseXModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += (easeFunc(curPos * 0.01) * currentValue * 0.2);
	}
}

class EaseYModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y += (easeFunc(curPos * 0.01) * currentValue * 0.2);
	}
}

class EaseZModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += (easeFunc(curPos * 0.01) * currentValue * 0.2);
	}
}

class EaseAngleModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle += (easeFunc(curPos * 0.01) * currentValue * 0.2);
	}
}

class EaseScaleModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((easeFunc(curPos * 0.01) * currentValue * 0.2) - 1);
		noteData.scaleY += ((easeFunc(curPos * 0.01) * currentValue * 0.2) - 1);
	}
}

class EaseScaleXModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((easeFunc(curPos * 0.01) * currentValue * 0.2) - 1);
	}
}

class EaseScaleYModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += ((easeFunc(curPos * 0.01) * currentValue * 0.2) - 1);
	}
}

class EaseSkewModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += (easeFunc(curPos * 0.01) * currentValue * 0.2);
		noteData.skewY += (easeFunc(curPos * 0.01) * currentValue * 0.2);
	}
}

class EaseSkewXModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += (easeFunc(curPos * 0.01) * currentValue * 0.2);
	}
}

class EaseSkewYModifier extends Ease
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += (easeFunc(curPos * 0.01) * currentValue * 0.2);
	}
}

class LinearXModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += curPos * currentValue; // don't mind me i just figured it out
	}
}

class LinearYModifier extends Modifier // Similar to speed but different, yk, weird Y behaviour
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var ud = false;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				ud = true;
		noteData.y += (curPos * currentValue) * (ud ? -1 : 1);
	}
}

class LinearZModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z += curPos * currentValue;
	}
}

class LinearScaleModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((curPos * currentValue) - 1);
		noteData.scaleY += ((curPos * currentValue) - 1);
	}
}

class LinearScaleXModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleX += ((curPos * currentValue) - 1);
	}
}

class LinearScaleYModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.scaleY += ((curPos * currentValue) - 1);
	}
}

class LinearSkewModifier extends Modifier // absurdely similar to angle xdxd
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += curPos * currentValue;
		noteData.skewY += curPos * currentValue;
	}
}

class LinearSkewXModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += curPos * currentValue;
	}
}

class LinearSkewYModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += curPos * currentValue;
	}
}

class Circ extends Modifier
{
	var strumResult:Array<Float>=[];

	var ud = false;

	override function setupSubValues()
	{
		setSubMod("offset", 0.0);
		setSubMod("useAlt", 0.0);
	}

	function doMath(curPos:Float)
	{
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				ud = true;

		var curPos2:Float = curPos * 0.45 * (ud ? -1 : 1);
		curPos2 += getSubMod("offset");
		return (curPos2 * curPos2 * currentValue * -0.001);
	}
}

class CircXModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x -= strumResult[lane%NoteMovement.keyCount]; //calls only half
		noteData.x += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.x += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircYModifier extends Circ // Similar to speed but different, yk, weird Y behaviour
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y -= strumResult[lane%NoteMovement.keyCount]; //calls only half
		noteData.y += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos) * (ud ? -1 : 1); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0) * (ud ? -1 : 1);
		noteData.y += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircZModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.z -= strumResult[lane%NoteMovement.keyCount]; //calls only half
		noteData.z += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.z += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircAngleModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angle -= strumResult[lane%NoteMovement.keyCount]; //calls only half
		noteData.angle += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.angle += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircAngleXModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleX -= strumResult[lane%NoteMovement.keyCount]; //calls only half
		noteData.angleX += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.angleX += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircAngleYModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.angleY -= strumResult[lane%NoteMovement.keyCount]; //calls only half
		noteData.angleY += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.angleY += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircScaleModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var r = doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos) * -0.01;
		noteData.scaleX += r; // No idea why math is like that, hazard is the one who made it -Ed
		noteData.scaleY += r;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0) * -0.01;
		noteData.scaleX += strumResult[lane%NoteMovement.keyCount];
		noteData.scaleY += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircScaleXModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var r = doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos) * -0.01;
		noteData.scaleX += r; // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0) * -0.01;
		noteData.scaleX += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircScaleYModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var r = doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos) * -0.01;
		noteData.scaleY += r; // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0) * -0.01;
		noteData.scaleY += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircSkewModifier extends Circ // absurdely similar to angle xdxd
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var r = doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos);
		noteData.skewX += r;
		noteData.skewY += r; // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.skewX += strumResult[lane%NoteMovement.keyCount];
		noteData.skewY += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircSkewXModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewX += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.skewX += strumResult[lane%NoteMovement.keyCount];
	}
}

class CircSkewYModifier extends Circ
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.skewY += doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : curPos); // No idea why math is like that, hazard is the one who made it -Ed
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		strumResult[lane%NoteMovement.keyCount] = getSubMod("offset") == 0 ? 0.0 : doMath(getSubMod("useAlt") >= 0.5 ? Conductor.songPosition * 0.001 : 0.0);
		noteData.skewY += strumResult[lane%NoteMovement.keyCount];
	}
}

class IncomingAngleModifier extends Modifier
{
	override function setupSubValues()
	{
		subValues.set('x', new ModifierSubValue(0.0));
		subValues.set('y', new ModifierSubValue(0.0));
		currentValue = 1.0;
	}

	override function incomingAngleMath(lane:Int, curPos:Float, pf:Int)
	{
		return [subValues.get('x').value, subValues.get('y').value];
	}

	override function reset()
	{
		super.reset();
		currentValue = 1.0; // the code that stop the mod from running gets confused when it resets in the editor i guess??
	}
}
