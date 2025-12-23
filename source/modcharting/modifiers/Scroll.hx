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
	[RENAME] WaveModifier: (Previously known as WaveingModifier)
	-   Renamed to make a cleaner look bettwen notITG and MT.

	[RENAME] JumpStrumsModifier: (Previously known as JumpTargetModifier)
	-   Renamed to keep order with other mods (as other uses strum and not target)
 */
class SpeedModifier extends Modifier
{
	override function setupSubValues()
	{
		baseValue = 1.0;
		currentValue = 1.0;
	}

	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		return curPos * currentValue;
	}
}

class BoostModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("offset", 1.0);
	}

	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		var yOffset:Float = 0;

		var speed = renderer.getCorrectScrollSpeed() * getSubMod("offset");

		var fYOffset = -curPos / speed;
		var fEffectHeight = FlxG.height;
		var fNewYOffset = fYOffset * 1.5 / ((fYOffset + fEffectHeight / 1.2) / fEffectHeight);
		var fBrakeYAdjust = (currentValue) * (fNewYOffset - fYOffset);
		fBrakeYAdjust = FlxMath.bound(fBrakeYAdjust, -400, 400); // clamp

		yOffset -= fBrakeYAdjust * speed;

		return curPos + yOffset;
	}
}

class BrakeModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("offset", 1.0);
	}

	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		var yOffset:Float = 0;

		var speed = renderer.getCorrectScrollSpeed() * getSubMod("offset");

		var fYOffset = -curPos / speed;
		var fEffectHeight = FlxG.height;
		var fScale = FlxMath.remapToRange(fYOffset, 0, fEffectHeight, 0, 1); // scale
		var fNewYOffset = fYOffset * fScale;
		var fBrakeYAdjust = currentValue * (fNewYOffset - fYOffset);
		fBrakeYAdjust = FlxMath.bound(fBrakeYAdjust, -400, 400); // clamp

		yOffset -= fBrakeYAdjust * speed;

		return curPos + yOffset;
	}
}

class BoomerangModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		noteData.y += (FlxMath.fastSin((curPos / -700)) * 400 + (curPos / 3.5)) * scrollSwitch * (currentValue);
		noteData.alpha *= FlxMath.bound(1 - (curPos / -600 - 3.5), 0, 1);
	}

	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		return curPos * 0.75;
	}
}

class WaveModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("multiplier", 1.0);
	}

	// override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	// {
	//     var distance = curPos;
	//     noteData.y += (FlxMath.fastSin(distance / 38 * subValues.get('multiplier').value * 0.2)*50) * currentValue; //don't mind me i just figured it out
	// }
	// override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
	// {
	//     return noteDist * (0.4+((FlxMath.fastSin(curPos*0.007)*0.1) * currentValue));
	// }
	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		curPos += (FlxMath.fastSin(-curPos / 38.0 * (getSubMod("multiplier") * 0.75) * 0.2) * 100) * (currentValue * 2);

		return curPos * 0.75;
	}
}

class ExpandModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("Speed", 1.0);
	}
	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		var b:Float = Modifier.beat / 2 * getSubMod("Speed");
		var sine:Float = FlxMath.fastSin(b * Math.PI);

		var speedMod:Float = 1.0;

		if (currentValue > 0){
			speedMod = 1 + (sine * currentValue / 4); // 4 means that scroll speed becames 0
		}else{ //special negative behaviour
			var r:Float = FlxMath.lerp(1,0,currentValue*-1);
			r = FlxMath.bound(r,0,1);

			r += sine * (1 - r) * (currentValue * -0.5); // 2 is normal speed in both ways?

			speedMod = r;
		}

		return curPos * speedMod;
	}
}

class JumpModifier extends Modifier // custom thingy i made //ended just being driven OMG LMAO
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		var beatVal = Modifier.beat - Math.floor(Modifier.beat); // should give decimal
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		noteData.y += (beatVal * (Conductor.stepCrochet * currentValue)) * renderer.getCorrectScrollSpeed() * 0.45 * scrollSwitch;
	}
}

class JumpStrumsModifier extends Modifier
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		var beatVal = Modifier.beat - Math.floor(Modifier.beat); // should give decimal
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		noteData.y += (beatVal * (Conductor.stepCrochet * currentValue)) * renderer.getCorrectScrollSpeed() * 0.45 * scrollSwitch;
	}
}

class JumpNotesModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var beatVal = Modifier.beat - Math.floor(Modifier.beat); // should give decimal
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		noteData.y += (beatVal * (Conductor.stepCrochet * currentValue)) * renderer.getCorrectScrollSpeed() * 0.45 * scrollSwitch;
	}
}

class DrivenModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var scrollSpeed = renderer.getCorrectScrollSpeed();
		var scrollSwitch = (instance != null && ModchartUtil.getDownscroll(instance)) ? -1 : 1;

		noteData.y += 0.45 * scrollSpeed * scrollSwitch * currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class TimeStopModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("stop", 0.0);
		setSubMod("speed", 1.0);
		setSubMod("continue", 0.0);
	}

	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		if (curPos <= (getSubMod("stop") * -1000))
		{
			curPos = (getSubMod("stop") * -1000) + (curPos * (getSubMod("speed") / 100));
		}
		return curPos;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		if (curPos <= (getSubMod('stop') * -1000))
		{
			curPos = (getSubMod('stop') * -1000) + (curPos * (getSubMod('speed') / 100));
		}
		else if (curPos <= (getSubMod('continue') * -100))
		{
			var a = ((getSubMod('continue') * 100) - Math.abs(curPos)) / ((getSubMod('continue') * 100) + (getSubMod('stop') * -1000));
		}
		else
		{
			// yep, nothing here lmao
		}
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf); // just reuse same thing
	}
}

class ParalysisModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("amplitude", 1.0);
	}

	override function curPosMath(lane:Int, curPos:Float, pf:Int)
	{
		var beat = (Conductor.songPosition / Conductor.crochet / 2);
		var fixedperiod = (Math.floor(beat) * Conductor.crochet * 2);
		var strumTime = (Conductor.songPosition - (curPos / PlayState.SONG.speed));
		return ((fixedperiod - strumTime) * PlayState.SONG.speed / 4) * getSubMod("amplitude");
	}
}

class CenterModifier extends Modifier
{
	var differenceBetween:Float = 0;

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		var screenCenter:Float = (FlxG.height / 2) - (NoteMovement.arrowSizes[lane] / 2);
		differenceBetween = noteData.y - screenCenter;
		noteData.y -= currentValue * differenceBetween;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.y -= currentValue * differenceBetween;
	}
}

class Center2Modifier extends Modifier
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		var screenCenter:Float = (FlxG.height / 2) - (NoteMovement.arrowSizes[lane] / 2);
		var differenceBetween:Float = noteData.y - screenCenter;
		noteData.y -= currentValue * differenceBetween;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

class ReceptorScrollModifier extends Modifier
{
	function getStaticCrochet():Float
	{
		return Conductor.crochet + 8;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var moveSpeed = getStaticCrochet() * 4;
		var diff = curPos;
		var songTime = Conductor.songPosition;
		var vDiff = -(diff - songTime) / moveSpeed;
		var reversed = Math.floor(vDiff) % 2 == 0;

		var startY = noteData.y;
		var revPerc = reversed ? 1 - vDiff % 1 : vDiff % 1;

		var ud = false;
		if (instance != null)
			if (ModchartUtil.getDownscroll(instance))
				ud = true;

		var scrollSwitch = 520;
		if (ud)
			scrollSwitch *= -1;

		var offset = 0;
		var reversedOffset = -scrollSwitch;

		var endY = offset + ((reversedOffset - NoteMovement.arrowSizes[lane]) * revPerc) + NoteMovement.arrowSizes[lane];

		noteData.y = FlxMath.lerp(startY, endY, currentValue);

		// ALPHA//
		var a:Float = FlxMath.remapToRange(curPos, (50 * -100), (10 * -100), 1, 0);
		a = FlxMath.bound(a, 0, 1);

		noteData.alpha -= a * currentValue;
		return;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}
