package modcharting;

import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import lime.math.Vector2;
import modcharting.SimpleQuaternion;
import openfl.geom.Vector3D;

import objects.Note;
import objects.StrumNote;
import play.PlayState;

enum abstract RotationOrder(String) from String to String {
	final X_Y_Z = "x_y_z";
	final X_Z_Y = "x_z_y";
	final Y_X_Z = "y_x_z";
	final Y_Z_X = "y_z_x";
	final Z_X_Y = "z_x_y";
	final Z_Y_X = "z_y_x";

	final X_Y_X = "x_y_x";
	final X_Z_X = "x_z_x";
	final Y_X_Y = "y_x_y";
	final Y_Z_Y = "y_z_y";
	final Z_X_Z = "z_x_z";
	final Z_Y_Z = "z_y_z";
}

class ModchartUtil
{
	public static function getDownscroll(instance:ModchartMusicBeatState)
	{
		// need to test each engine
		// not expecting all to work
		#if PSYCH
		return ClientPrefs.data.downScroll;
		#elseif LEATHER
		return utilities.Options.getData("downscroll");
		#elseif ANDROMEDA // dunno why youd use this on andromeda but whatever, already got its own cool modchart system
		return instance.currentOptions.downScroll;
		#elseif KADE
		return PlayStateChangeables.useDownscroll;
		#elseif FOREVER_LEGACY // forever might not work just yet because of the multiple strumgroups
		return Init.trueSettings.get('Downscroll');
		#elseif FPSPLUS
		return Config.downscroll;
		#elseif MIC_D_UP // basically no one uses this anymore
		return MainVariables._variables.scroll == "down"
		#else
		return false;
		#end
	}

	public static function getMiddlescroll(instance:ModchartMusicBeatState)
	{
		#if PSYCH
		return ClientPrefs.data.middleScroll;
		#elseif LEATHER
		return utilities.Options.getData("middlescroll");
		#else
		return false;
		#end
	}

	public static function getScrollSpeed(instance:PlayState)
	{
		var speedFix:Float = 0.8;
		if (instance == null)
			return PlayState.SONG.speed * speedFix;

		#if PSYCH
		return instance.songSpeed * speedFix;
		#elseif ANDROMEDA
		return instance.songSpeed * speedFix;
		#elseif LEATHER @:privateAccess
		return instance.speed * speedFix;
		#elseif KADE
		return PlayStateChangeables.scrollSpeed == 1 ? PlayState.SONG.speed * speedFix : PlayStateChangeables.scrollSpeed * speedFix;
		#else
		return PlayState.SONG.speed * speedFix; // most engines just use this
		#end
	}

	public static function getIsPixelStage(instance:ModchartMusicBeatState)
	{
		if (instance == null)
			return false;
		#if LEATHER
		return PlayState.SONG.ui_Skin == 'pixel';
		#else
		return PlayState.isPixelStage;
		#end
	}

	public static function getNoteOffsetX(daNote:Note, instance:ModchartMusicBeatState)
	{
		#if PSYCH
		return daNote.offsetX;
		#elseif LEATHER
		// fuck
		var offset:Float = 0;

		var lane = daNote.noteData;
		if (daNote.mustPress)
			lane += NoteMovement.keyCount;
		var strum = instance.playfieldRenderer.strumGroup.members[lane];

		var arrayVal = Std.string([lane, daNote.arrow_Type, daNote.isSustainNote]);

		if (!NoteMovement.leatherEngineOffsetStuff.exists(arrayVal))
		{
			var tempShit:Float = 0.0;

			var targetX = NoteMovement.defaultStrum[lane][0];
			var xPos = targetX;
			while (Std.int(xPos + (daNote.width / 2)) != Std.int(targetX + (strum.width / 2)))
			{
				xPos += (xPos + daNote.width > targetX + strum.width ? -0.1 : 0.1);
				tempShit += (xPos + daNote.width > targetX + strum.width ? -0.1 : 0.1);
			}
			// trace(arrayVal);
			// trace(tempShit);

			NoteMovement.leatherEngineOffsetStuff.set(arrayVal, tempShit);
		}
		offset = NoteMovement.leatherEngineOffsetStuff.get(arrayVal);

		return offset;
		#else
		return (daNote.isSustainNote ? 37 : 0); // the magic number
		#end
	}

	public static function getNoteSkew(daNote:Note, isSkewY:Bool)
	{
		if (!isSkewY)
		{
			return daNote.skew.x;
		}
		else
		{
			return daNote.skew.y;
		}
	}

	public static function getStrumSkew(daNote:StrumNote, isSkewY:Bool)
	{
		if (!isSkewY)
		{
			return daNote.skew.x;
		}
		else
		{
			return daNote.skew.y;
		}
	}

	static var currentFakeCrochet:Float = -1;
	static var lastBpm:Float = -1;

	public static function getFakeCrochet()
	{
		if (PlayState.SONG.bpm != lastBpm)
		{
			currentFakeCrochet = (60 / PlayState.SONG.bpm) * 1000; // only need to calculate once
			lastBpm = PlayState.SONG.bpm;
		}
		return currentFakeCrochet;
	}

	public static var zNear:Float = 0;
	public static var zFar:Float = 100;
	public static var defaultFOV:Float = 90;

	/**
		Converts a Vector3D to its in world coordinates using perspective math
	**/
	public static function calculatePerspective(pos:Vector3D, FOV:Float, offsetX:Float = 0, offsetY:Float = 0)
	{
		/* math from opengl lol
			found from this website https://ogldev.org/www/tutorial12/tutorial12.html
		 */

		// TODO: maybe try using actual matrix???

		var newz = pos.z - 1;
		var zRange = zNear - zFar;
		var tanHalfFOV = FlxMath.fastSin(FOV * 0.5) / FlxMath.fastCos(FOV * 0.5); // faster tan
		if (pos.z > 1) // if above 1000 z basically
			newz = 0; // should stop weird mirroring with high z values

		// var m00 = 1/(tanHalfFOV);
		// var m11 = 1/tanHalfFOV;
		// var m22 = (-zNear - zFar) / zRange; //isnt this just 1 lol
		// var m23 = 2 * zFar * zNear / zRange;
		// var m32 = 1;

		var xOffsetToCenter = pos.x - (FlxG.width * 0.5); // so the perspective focuses on the center of the screen
		var yOffsetToCenter = pos.y - (FlxG.height * 0.5);

		var zPerspectiveOffset = (newz + (2 * zFar * zNear / zRange));

		// xOffsetToCenter += (offsetX / (1/-zPerspectiveOffset));
		// yOffsetToCenter += (offsetY / (1/-zPerspectiveOffset));
		xOffsetToCenter += (offsetX * -zPerspectiveOffset);
		yOffsetToCenter += (offsetY * -zPerspectiveOffset);

		var xPerspective = xOffsetToCenter * (1 / tanHalfFOV);
		var yPerspective = yOffsetToCenter / (1 / tanHalfFOV);
		xPerspective /= -zPerspectiveOffset;
		yPerspective /= -zPerspectiveOffset;

		pos.x = xPerspective + (FlxG.width * 0.5); // offset it back to normal
		pos.y = yPerspective + (FlxG.height * 0.5);
		pos.z = zPerspectiveOffset;

		// pos.z -= 1;
		// pos = perspectiveMatrix.transformVector(pos);

		return pos;
	}

	/**
		Returns in-world 3D coordinates using polar angle, azimuthal angle and a radius.
		(Spherical to Cartesian)

		@param	theta Angle used along the polar axis.
		@param	phi Angle used along the azimuthal axis.
		@param	radius Distance to center.
	**/
	public static function getCartesianCoords3D(theta:Float, phi:Float, radius:Float):Vector3D
	{
		var pos:Vector3D = new Vector3D();
		var rad = FlxAngle.TO_RAD;
		pos.x = FlxMath.fastCos(theta * rad) * FlxMath.fastSin(phi * rad);
		pos.y = FlxMath.fastCos(phi * rad);
		pos.z = FlxMath.fastSin(theta * rad) * FlxMath.fastSin(phi * rad);
		pos.x *= radius;
		pos.y *= radius;
		pos.z *= radius;

		return pos;
	}

	public static function rotateAround(origin:Vector2, point:Vector2, degrees:Float):Vector2
	{
		// public function rotateAround(origin, point, degrees):FlxBasePoint{
		// public function rotateAround(origin, point, degrees){
		var angle:Float = degrees * (Math.PI / 180);
		var ox = origin.x;
		var oy = origin.y;
		var px = point.x;
		var py = point.y;

		var qx = ox + FlxMath.fastCos(angle) * (px - ox) - FlxMath.fastSin(angle) * (py - oy);
		var qy = oy + FlxMath.fastSin(angle) * (px - ox) + FlxMath.fastCos(angle) * (py - oy);

		// point.x = qx;
		// point.y = qy;

		return (new Vector2(qx, qy));
		// return FlxBasePoint.weak(qx, qy);
		// return qx, qy;
	}

	public static function easeFlip(ease:Float->Float):Float->Float
	{
		return function(t:Float)
		{
			return 1.0 - ease(t);
		}
	}
	
	public static function getFlxEaseByString(?ease:String = '')
	{
		if (StringTools.contains(ease, "flip(")){
			var subModArr = ease.split("flip(");
			ease = subModArr[1];
			subModArr = ease.split(")");
			ease = subModArr[0];
			var easeFinal = getFlxEaseByString(ease);
			
			return easeFlip(easeFinal);
		}

		switch (ease.toLowerCase().trim())
		{
			case 'backin':
				return ImprovedEases.backIn;
			case 'backinout':
				return ImprovedEases.backInOut;
			case 'backout':
				return ImprovedEases.backOut;
			case 'backoutin':
				return ImprovedEases.backOutIn;
			case 'bounce':
				return ImprovedEases.bounce;
			case 'bouncein':
				return ImprovedEases.bounceIn;
			case 'bounceinout':
				return ImprovedEases.bounceInOut;
			case 'bounceout':
				return ImprovedEases.bounceOut;
			case 'bounceoutin':
				return ImprovedEases.bounceOutIn;
			case 'bell':
				return ImprovedEases.bell;
			case 'circin':
				return ImprovedEases.circIn;
			case 'circinout':
				return ImprovedEases.circInOut;
			case 'circout':
				return ImprovedEases.circOut;
			case 'circoutin':
				return ImprovedEases.circOutIn;
			case 'cubein':
				return ImprovedEases.cubeIn;
			case 'cubeinout':
				return ImprovedEases.cubeInOut;
			case 'cubeout':
				return ImprovedEases.cubeOut;
			case 'cubeoutin':
				return ImprovedEases.cubeOutIn;
			case 'elasticin':
				return ImprovedEases.elasticIn;
			case 'elasticinout':
				return ImprovedEases.elasticInOut;
			case 'elasticout':
				return ImprovedEases.elasticOut;
			case 'elasticoutin':
				return ImprovedEases.elasticOutIn;
			case 'expoin':
				return ImprovedEases.expoIn;
			case 'expoinout':
				return ImprovedEases.expoInOut;
			case 'expoout':
				return ImprovedEases.expoOut;
			case 'expooutin':
				return ImprovedEases.expoOutIn;
			case 'inverse':
				return ImprovedEases.inverse;
			case 'instant':
				return ImprovedEases.instant;
			case 'pop':
				return ImprovedEases.pop;
			case 'popelastic':
				return ImprovedEases.popElastic;
			case 'pulse':
				return ImprovedEases.pulse;
			case 'pulseelastic':
				return ImprovedEases.pulseElastic;
			case 'quadin':
				return ImprovedEases.quadIn;
			case 'quadinout':
				return ImprovedEases.quadInOut;
			case 'quadout':
				return ImprovedEases.quadOut;
			case 'quadoutin':
				return ImprovedEases.quadOutIn;
			case 'quartin':
				return ImprovedEases.quartIn;
			case 'quartinout':
				return ImprovedEases.quartInOut;
			case 'quartout':
				return ImprovedEases.quartOut;
			case 'quartoutin':
				return ImprovedEases.quartOutIn;
			case 'quintin':
				return ImprovedEases.quintIn;
			case 'quintinout':
				return ImprovedEases.quintInOut;
			case 'quintout':
				return ImprovedEases.quintOut;
			case 'quintoutin':
				return ImprovedEases.quintOutIn;
			case 'sinein':
				return ImprovedEases.sineIn;
			case 'sineinout':
				return ImprovedEases.sineInOut;
			case 'sineout':
				return ImprovedEases.sineOut;
			case 'sineoutin':
				return ImprovedEases.sineOutIn;
			case 'spike':
				return ImprovedEases.spike;
			case 'smoothstepin':
				return ImprovedEases.smoothStepIn;
			case 'smoothstepinout':
				return ImprovedEases.smoothStepInOut;
			case 'smoothstepout':
				return ImprovedEases.smoothStepOut;
			case 'smootherstepin':
				return ImprovedEases.smootherStepIn;
			case 'smootherstepinout':
				return ImprovedEases.smootherStepInOut;
			case 'smootherstepout':
				return ImprovedEases.smootherStepOut;
			case 'tap':
				return ImprovedEases.tap;
			case 'tapelastic':
				return ImprovedEases.tapElastic;
			case 'tri':
				return ImprovedEases.tri;
			default:
				return ImprovedEases.linear;
		}
		return ImprovedEases.linear;
	}

	public static function getTimeFromBeat(beat:Float)
	{
		var totalTime:Float = 0;
		var curBpm = Conductor.bpm;
		if (PlayState.SONG != null)
			curBpm = PlayState.SONG.bpm;
		for (i in 0...Math.floor(beat))
		{
			if (Conductor.bpmChangeMap.length > 0)
			{
				for (j in 0...Conductor.bpmChangeMap.length)
				{
					if (totalTime >= Conductor.bpmChangeMap[j].songTime)
						curBpm = Conductor.bpmChangeMap[j].bpm;
				}
			}
			totalTime += (60 / curBpm) * 1000;
		}

		var leftOverBeat = beat - Math.floor(beat);
		totalTime += (60 / curBpm) * 1000 * leftOverBeat;

		return totalTime;
	}

	inline public static function rotatePivot(vec:Vector3D, rotation:Float, w:Float, h:Float, type:String = "x"):Vector3D
	{
		var angle:Float = rotation;

		if (angle == 0) return vec;

		switch (type)
		{
			case "z":
				var pivotPoint:Vector2 = new Vector2(w/2, h/2);
				var output:Vector2 = rotateAround(pivotPoint, new Vector2(vec.x, vec.y), angle);
				vec.x = output.x;
				vec.y = output.y;
			case "y":
				var pivotPoint:Vector2 = new Vector2(w/2, 0);
				var output:Vector2 = rotateAround(pivotPoint, new Vector2(vec.z, vec.x), angle);
				vec.x = output.x;
				vec.z = output.y;
			case "x":
				var pivotPoint:Vector2 = new Vector2(0, h/2);
				var output:Vector2 = rotateAround(pivotPoint, new Vector2(vec.z, vec.y), angle);
				vec.z = output.x;
				vec.y = output.y;
		}

		return vec;
	}

	public static var ROTATION_ORDER:RotationOrder = X_Y_Z;
	@:pure @:noDebug
	inline public static function rotate3DVector(vec:Vector3D, angleX:Float, angleY:Float, angleZ:Float):Vector3D
	{
		if (angleX == 0 && angleY == 0 && angleZ == 0)
			return vec;

		final RAD = FlxAngle.TO_RAD;
		final quatX = Quaternion.fromAxisAngle(Vector3D.X_AXIS, angleX * RAD);
		final quatY = Quaternion.fromAxisAngle(Vector3D.Y_AXIS, angleY * RAD);
		final quatZ = Quaternion.fromAxisAngle(Vector3D.Z_AXIS, angleZ * RAD);

		// this is confusing, X_Y_Z is done like this:
		// OUT = Z;
		// OUT *= Y
		// OUT *= X
		// But it feels wrong, so investigate this
		switch (ROTATION_ORDER) {
			case Z_X_Y:
				quatY.multiplyInPlace(quatX);
				quatY.multiplyInPlace(quatZ);
				return quatY.rotateVector(vec);
			case X_Y_Z:
				quatZ.multiplyInPlace(quatY);
				quatZ.multiplyInPlace(quatX);
				return quatZ.rotateVector(vec);
			case X_Z_Y:
				quatY.multiplyInPlace(quatZ);
				quatY.multiplyInPlace(quatX);
				return quatY.rotateVector(vec);
			case Y_X_Z:
				quatZ.multiplyInPlace(quatX);
				quatZ.multiplyInPlace(quatY);
				return quatZ.rotateVector(vec);
			case Y_Z_X:
				quatX.multiplyInPlace(quatZ);
				quatX.multiplyInPlace(quatY);
				return quatX.rotateVector(vec);
			case Z_Y_X:
				quatX.multiplyInPlace(quatY);
				quatX.multiplyInPlace(quatZ);
				return quatX.rotateVector(vec);
			case X_Y_X:
				quatX.multiplyInPlace(quatY);
				quatX.multiplyInPlace(quatX);
				return quatX.rotateVector(vec);
			case X_Z_X:
				quatX.multiplyInPlace(quatZ);
				quatX.multiplyInPlace(quatX);
				return quatX.rotateVector(vec);
			case Y_X_Y:
				quatY.multiplyInPlace(quatX);
				quatY.multiplyInPlace(quatY);
				return quatY.rotateVector(vec);
			case Y_Z_Y:
				quatY.multiplyInPlace(quatZ);
				quatY.multiplyInPlace(quatY);
				return quatY.rotateVector(vec);
			case Z_X_Z:
				quatZ.multiplyInPlace(quatX);
				quatZ.multiplyInPlace(quatZ);
				return quatZ.rotateVector(vec);
			case Z_Y_Z:
				quatZ.multiplyInPlace(quatY);
				quatZ.multiplyInPlace(quatZ);
				return quatZ.rotateVector(vec);
		}
	}
}
