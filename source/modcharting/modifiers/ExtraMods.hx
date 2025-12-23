package modcharting.modifiers;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import haxe.ds.List;
import lime.math.Vector4;
import modcharting.PlayfieldRenderer.StrumNoteType;
//import modcharting.modifiers.*; // so this should work?
import objects.Note;
import openfl.geom.Vector3D;
import play.PlayState;
import modcharting.Modifier;

@:exclude
class TimeVector extends Vector4
{
	public var startDist:Float;
	public var endDist:Float;
	public var next:TimeVector;

	public function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0)
	{
		super(x, y, z, w);
		startDist = 0.0;
		endDist = 0.0;
		next = null;
	}
}

class ShakyNotesModifier extends Modifier
{
	override function setupSubValues()
	{
		setSubMod("speed", 1.0);
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += FlxMath.fastSin(500)
			+ currentValue * (Math.cos(Conductor.songPosition * 4 * 0.2) + ((lane % NoteMovement.keyCount) * 0.2) - 0.002) * (Math.sin(100
				- (120 * getSubMod('speed') * 0.4)));

		noteData.y += FlxMath.fastSin(500)
			+ currentValue * (Math.cos(Conductor.songPosition * 8 * 0.2) + ((lane % NoteMovement.keyCount) * 0.2) - 0.002) * (Math.sin(100
				- (120 * getSubMod('speed') * 0.4)));
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class ShakeNotesModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.x += FlxMath.fastSin(0.1) * (currentValue * FlxG.random.int(1, 20));
		noteData.y += FlxMath.fastSin(0.1) * (currentValue * FlxG.random.int(1, 20));
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}
}

class OrientModifier extends Modifier // ig this must work?
{
	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.orient += currentValue;
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.orient += currentValue;
	}
}

class ArrowPathModifier extends Modifier // used but unstable (as old way)
{
	override function setupSubValues()
	{
		setSubMod("length", 14.0);
		setSubMod("backlength", 2.0);
		setSubMod("grain", 5.0);
		setSubMod("width", 1.0);
	}

	override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.arrowPathAlpha += currentValue;
		noteData.arrowPathLength += getSubMod('length'); // length is in pixels
		noteData.arrowPathBackwardsLength += getSubMod('backlength');
		noteData.pathGrain += getSubMod('grain');
		noteData.arrowPathWidth *= getSubMod('width');
	}

	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		strumMath(noteData, lane, pf);
	}
}

// OH MY FUCKING GOD, thanks to @noamlol for the code of this thing//
class CustomPathModifier extends Modifier // wow. it sucks when you spend time trying to add something you wanted a lot, to end scrapping it because a single error.
{
	public var _path:List<TimeVector> = null;
	public var _pathDistance:Float = 0;

	var calculatedOffset:Bool = false;
	var offset:Vector3D = new Vector3D(0, 0, 0);

	override public function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		if (Paths.fileExists("data/" + PlayState.SONG.song.toLowerCase() + "/customMods/path" + subValues.get('path').value + ".txt", TEXT))
		{
			var newPosition = executePath(Modifier.beat, (curPos * 0.4), lane, 1, new Vector4(noteData.x, noteData.y, noteData.z, 0),
				"data/"
				+ PlayState.SONG.song.toLowerCase()
				+ "/customMods/path"
				+ subValues.get('path').value
				+ ".txt");

			var blend:Float = Math.abs(currentValue);
			blend = FlxMath.bound(blend, 0, 1); // clamp

			noteData.setX = (newPosition.x * blend);
			noteData.setY = (newPosition.y * blend);
			noteData.setZ = (newPosition.z * blend);
		}
	}

	override public function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteMath(noteData, lane, 0, pf);
	}

	override function setupSubValues()
	{
		setSubMod("path", 0.0);
	}

	override function reset()
	{
		super.reset();
	}

	public var firstPath:String = "";

	public function loadPath()
	{
		var file = CoolUtil.coolTextFile(Paths.modFolders("data/" + PlayState.SONG.song.toLowerCase() + "/customMods/path" + getSubMod('path')
			+ ".txt"));
		var file2 = CoolUtil.coolTextFile(Paths.getSharedPath("data/" + PlayState.SONG.song.toLowerCase() + "/customMods/path" + getSubMod('path')
			+ ".txt"));

		var filePath = null;
		if (file != null)
		{
			filePath = file;
		}
		else if (file2 != null)
		{
			filePath = file2;
		}
		else
		{
			return;
		}

		firstPath = "data/" + PlayState.SONG.song.toLowerCase() + "/customMods/path" + subValues.get('path').value + ".txt";

		// trace(filePath);

		var path = new List<TimeVector>();
		var _g = 0;
		while (_g < filePath.length)
		{
			var line = filePath[_g];
			_g++;
			var coords = line.split(";");
			var vec = new TimeVector(Std.parseFloat(coords[0]), Std.parseFloat(coords[1]), Std.parseFloat(coords[2]), Std.parseFloat(coords[3]));
			vec.x *= 200;
			vec.y *= 200;
			vec.z *= 200;
			path.add(vec);
			// trace(coords);
		}
		_pathDistance = calculatePathDistances(path);
		_path = path;
	}

	public function calculatePathDistances(path:List<TimeVector>):Float
	{
		@:privateAccess
		var iterator_head = path.h;
		var val = iterator_head.item;
		iterator_head = iterator_head.next;
		var last = val;
		last.startDist = 0;
		var dist = 0.0;
		while (iterator_head != null)
		{
			var val = iterator_head.item;
			iterator_head = iterator_head.next;
			var current = val;
			var result = new Vector4();
			result.x = current.x - last.x;
			result.y = current.y - last.y;
			result.z = current.z - last.z;
			var differential = result;
			dist += Math.sqrt(differential.x * differential.x + differential.y * differential.y + differential.z * differential.z);
			current.startDist = dist;
			last.next = current;
			last.endDist = current.startDist;
			last = current;
		}
		return dist;
	}

	public function getPointAlongPath(distance:Float):TimeVector
	{
		@:privateAccess
		var _g_head = this._path.h;
		while (_g_head != null)
		{
			var val = _g_head.item;
			_g_head = _g_head.next;
			var vec = val;
			var Min = vec.startDist;
			var Max = vec.endDist;
			// looks like a FlxMath function could be that
			if ((Min == 0 || distance >= Min) && (Max == 0 || distance <= Max) && vec.next != null)
			{
				var ratio = distance - vec.startDist;
				var _this = vec.next;
				var result = new Vector4();
				result.x = _this.x - vec.x;
				result.y = _this.y - vec.y;
				result.z = _this.z - vec.z;
				var ratio1 = ratio / Math.sqrt(result.x * result.x + result.y * result.y + result.z * result.z);
				var vec2 = vec.next;
				var out1 = new Vector4(vec.x, vec.y, vec.z, vec.w);
				var s = 1 - ratio1;
				out1.x *= s;
				out1.y *= s;
				out1.z *= s;
				var out2 = new Vector4(vec2.x, vec2.y, vec2.z, vec2.w);
				out2.x *= ratio1;
				out2.y *= ratio1;
				out2.z *= ratio1;
				var result1 = new Vector4();
				result1.x = out1.x + out2.x;
				result1.y = out1.y + out2.y;
				result1.z = out1.z + out2.z;
				return new TimeVector(result1.x, result1.y, result1.z, result1.w);
			}
		}
		return _path.first();
	}

	// var strumTimeDiff = Conductor.songPosition - note.strumTime;     -- saw this in the Groovin.js
	public function executePath(currentBeat, strumTimeDiff:Float, column, player, pos, fp:String):Vector4
	{
		if (_path == null || (firstPath != fp && _path != null))
		{
			loadPath();
		}
		var path = getPointAlongPath(strumTimeDiff / -1500.0 * _pathDistance);
		var a = new Vector4(FlxG.width / 2, FlxG.height / 2 + 280, column % 4 * getOtherPercent("arrowshapeoffset", player) + pos.z);
		var result = new Vector4();
		result.x = path.x + a.x;
		result.y = path.y + a.y;
		result.z = path.z + a.z;
		var vec2 = result;
		var lerp = getPercent(player);
		var out1 = new Vector4(pos.x, pos.y, pos.z, pos.w);
		var s = 1 - lerp;
		out1.x *= s;
		out1.y *= s;
		out1.z *= s;
		var out2 = new Vector4(vec2.x, vec2.y, vec2.z, vec2.w);
		out2.x *= lerp;
		out2.y *= lerp;
		out2.z *= lerp;
		var result = new Vector4();
		result.x = out1.x + out2.x;
		result.y = out1.y + out2.y;
		result.z = out1.z + out2.z;
		return result;
	}

	public function getPercent(player:Int):Float
	{
		return 1;
	}

	public function getOtherPercent(modName:String, player:Int):Float
	{
		return 1;
	}
}

class SpiralHoldsModifier extends Modifier
{
	override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
	{
		noteData.spiralHold += currentValue;
	}
}
