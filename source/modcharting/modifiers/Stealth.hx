package modcharting.modifiers;

import modcharting.Modifier;
import modcharting.Modifier.ModifierSubValue;
import flixel.math.FlxMath;

//CHANGE LOG (the changes to modifiers)

//[REWORK] = totally overhaul of a modifier
//[UPDATE] = changed something on the modifier
//[RENAME] = rename of a modifier
//[REMOVAL] = a removed modifier
//[NEW] = a new modifier
//[EXTRA] = has nothing to do with modifiers but MT's enviroment.

//HERE CHANGE LIST
/*
    [RENAME] StrumAlphaModifier: (Previously known as TargetAlphaModifier)
    -   Rename to fit more the standard names along the other mods.

	[NEW] FlashModifier:
	-	FlashModifier is a merge of both StealthModifier and DarkModifier to make easier use of them in case you want to use them together.

	[RENAME] FlashColorModifier: (Previously known as SDColorModifier)
	-	Same basics as StealthColor and DarkColor in one modifier, renamed to fit the new "FlashModifier" info.

*/

class AlphaModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.alpha *= 1 - currentValue;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class NoteAlphaModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.alpha *= 1 - currentValue;
	}
}

class StrumAlphaModifier extends Modifier
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.alpha *= 1 - currentValue;
	}
}

class StealthModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var stealthGlow:Float = currentValue * 2;
		noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); // clamp

		var substractAlpha:Float = currentValue - 0.5;
		substractAlpha = FlxMath.bound(substractAlpha * 2, 0, 1);
		noteData.alpha *= 1 - substractAlpha;
	}
}

class DarkModifier extends Modifier
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		var stealthGlow:Float = currentValue * 2;
		noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); // clamp

		var substractAlpha:Float = currentValue - 0.5;
		substractAlpha = FlxMath.bound(substractAlpha * 2, 0, 1);
		noteData.alpha *= 1 - substractAlpha;
	}
}

class FlashModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var stealthGlow:Float = currentValue * 2;
		noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); // clamp

		var substractAlpha:Float = currentValue - 0.5;
		substractAlpha = FlxMath.bound(substractAlpha * 2, 0, 1);
		noteData.alpha *= 1 - substractAlpha;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class StealthColorModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("r", 255.0);
		setSubMod("g", 255.0);
		setSubMod("b", 255.0);
		currentValue = 1.0;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		var red = getSubMod("r") / 255; // so i can get exact values instead of 0.7668676767676768
		var green = getSubMod("g") / 255;
		var blue = getSubMod("b") / 255;

		noteData.glowRed *= red;
		noteData.glowGreen *= green;
		noteData.glowBlue *= blue;
	}

	override public function reset()
	{
		super.reset();
		currentValue = 1.0;
	}
}

class DarkColorModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("r", 255.0);
		setSubMod("g", 255.0);
		setSubMod("b", 255.0);
		currentValue = 1.0;
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		var red = getSubMod("r") / 255; // so i can get exact values instead of 0.7668676767676768
		var green = getSubMod("g") / 255;
		var blue = getSubMod("b") / 255;

		noteData.glowRed *= red;
		noteData.glowGreen *= green;
		noteData.glowBlue *= blue;
	}

	override public function reset()
	{
		super.reset();
		currentValue = 1.0;
	}
}

class FlashColorModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("r", 255.0);
		setSubMod("g", 255.0);
		setSubMod("b", 255.0);
		currentValue = 1.0;
	}
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		var red = getSubMod("r") / 255; // so i can get exact values instead of 0.7668676767676768
		var green = getSubMod("g") / 255;
		var blue = getSubMod("b") / 255;

		noteData.glowRed *= red;
		noteData.glowGreen *= green;
		noteData.glowBlue *= blue;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}

	override public function reset()
	{
		super.reset();
		currentValue = 1.0;
	}
}

class SuddenModifier extends Modifier {
	override function setupSubValues() {
		setSubMod("noglow", 1.0);
		setSubMod("start", 5.0);
		setSubMod("end", 3.0);
		setSubMod("offset", 0.0);
	}
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var a:Float = FlxMath.remapToRange(curPos, (getSubMod("start") * -100) + (getSubMod("offset") * -100),
			(getSubMod("end") * -100) + (getSubMod("offset") * -100), 1, 0);
		a = FlxMath.bound(a, 0, 1);

		if (getSubMod("noglow") >= 1.0) {
			noteData.alpha -= a * currentValue;
			return;
		}

		a *= currentValue;

		if (getSubMod("noglow") < 0.5) {
			var stealthGlow:Float = a * 2;
			noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); // clamp
		}

		var substractAlpha:Float = FlxMath.bound((a - 0.5) * 2, 0, 1);
		noteData.alpha -= substractAlpha;
    }
}

class HiddenModifier extends Modifier {
	override function setupSubValues() {
		setSubMod("noglow", 1.0);
		setSubMod("start", 5.0);
		setSubMod("end", 3.0);
		setSubMod("offset", 0.0);
	}
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int) {
		var a:Float = FlxMath.remapToRange(curPos, (getSubMod('start') * -100) + (getSubMod('offset') * -100),
			(getSubMod('end') * -100) + (getSubMod('offset') * -100), 0, 1);
		a = FlxMath.bound(a, 0, 1);

		if (getSubMod('noglow') >= 1.0) {
			noteData.alpha -= a * currentValue;
			return;
		}

		a *= currentValue;

		if (getSubMod('noglow') < 0.5) {
			var stealthGlow:Float = a * 2;
			noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); // clamp
		}

		var substractAlpha:Float = FlxMath.bound((a - 0.5) * 2, 0, 1);
		noteData.alpha -= substractAlpha;

		// if (curPos > ((subValues.get('offset').value*-100)-100))
		// {
		//     var hmult = (curPos-(subValues.get('offset').value*-100))/200;
		//     noteData.alpha *=(1-hmult);
		// }
	}
}

class VanishModifier extends Modifier {
	override function setupSubValues() {
		setSubMod("noglow", 1.0);
		setSubMod("start", 5.0);
		setSubMod("end", 3.0);
		setSubMod("offset", 0.0);
		setSubMod("size", 1.95);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int) {
		var midPoint:Float = (getSubMod('start') * -100) + (getSubMod('offset') * -100);
		midPoint /= 2;

		var sizeThingy:Float = (getSubMod('size') * 100) / 2;

		var a:Float = FlxMath.remapToRange(curPos, (getSubMod('start') * -100)
			+ (getSubMod('offset') * -100),
			midPoint
			+ sizeThingy
			+ (getSubMod('offset') * -100), 0, 1);

		a = FlxMath.bound(a, 0, 1);

		var b:Float = FlxMath.remapToRange(curPos, midPoint
			- sizeThingy
			+ (getSubMod('offset') * -100),
			(getSubMod('end') * -100)
			+ (getSubMod('offset') * -100), 0, 1);

		b = FlxMath.bound(b, 0, 1);

		var result:Float = a - b;

		if (getSubMod('noglow') >= 1.0) {
			noteData.alpha -= result * currentValue;
			return;
		}

		result *= currentValue;

		if (getSubMod('noglow') < 0.5) {
			var stealthGlow:Float = result * 2;
			noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); // clamp
		}

		var substractAlpha:Float = FlxMath.bound((result - 0.5) * 2, 0, 1);
		noteData.alpha -= substractAlpha;
	}
}

class BlinkModifier extends Modifier {
	override function setupSubValues() {
		setSubMod("noglow", 1.0);
		setSubMod("offset", 0.0);
		setSubMod("speed", 1.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int) {
		var a:Float = FlxMath.fastSin((Modifier.beat + (getSubMod('offset') * -100)) * getSubMod('speed') * Math.PI) * 2;
		a = FlxMath.bound(a, 0, 1);

		if (getSubMod('noglow') >= 1.0) {
			noteData.alpha -= a * currentValue;
			return;
		}

		a *= currentValue;

		if (getSubMod('noglow') < 0.5) {
			var stealthGlow:Float = a * 2;
			noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); // clamp
		}

		var substractAlpha:Float = FlxMath.bound((a - 0.5) * 2, 0, 1);
		noteData.alpha -= substractAlpha;
	}
}
