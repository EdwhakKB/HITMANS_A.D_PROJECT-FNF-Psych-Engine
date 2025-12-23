package modcharting;

import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import flixel.util.FlxPool;

@:structInit 
@:publicFields
class ObjectData {
	@:optional
	var setX:Float = 0;
	@:optional
	var setY:Float = 0;
	@:optional
	var setZ:Float = 0;

	@:optional
	var x:Float = 0;
	@:optional
	var y:Float = 0;
	@:optional
	var z:Float = 0;
	@:optional
	var angle:Float = 0;
	@:optional
	var alpha:Float = 1;
	@:optional
	var scaleX:Float = 1;
	@:optional
	var scaleY:Float = 1;
	// ??? this is a 2d texture, doesnt have depth so doesnt need scale z
	// var scaleZ:Float;
	@:optional
	var skewX:Float = 0;
	@:optional
	var skewY:Float = 0;

	// SKEW Z DOENST EXISTS !!!!!!!!!!!!!
	@:optional
	var skewZ:Float = 0;

	@:optional
	var curPos:Float = 0;
	@:optional
	var noteDist:Float = 0;
	@:optional
	var offset:Float = 0;
	@:optional
	var lane:Int = 0;
	@:optional
	var index:Int = 0;
	@:optional
	var playfieldIndex:Int = 0;
	@:optional
	var isHoldSplash:Bool = false;
	@:optional
	var isStrum:Bool = false;
	@:optional
	var isSplash:Bool = false;
	@:optional
	var isSus:Bool = false;
	@:optional
	var incomingAngleX:Float = 0.0;
	@:optional
	var incomingAngleY:Float = 0.0;
	@:optional
	var strumTime:Float = 0.0;
	@:optional
	var noteIndex:Int = 0;

	@:optional
	var stealthGlow:Float = 0;
	@:optional
	var glowRed:Float = 1;
	@:optional
	var glowGreen:Float = 1;
	@:optional
	var glowBlue:Float = 1;

	@:optional
	var sustainWidth:Float = 1;
	@:optional
	var sustainGrain:Float = 0;

	@:optional
	var arrowPathAlpha:Float = 0;
	@:optional
	var arrowPathLength:Float = 14;
	@:optional
	var arrowPathBackwardsLength:Float = 2;
	@:optional
	var arrowPathWidth:Float = 1;
	@:optional
	var pathGrain:Float = 0;

	@:optional
	var spiralHold:Float = 0;
	@:optional
	var spiralPath:Float = 0;

	@:optional
	var orient:Float = 0;

	@:optional
	var angleX:Float = 0;
	@:optional
	var angleY:Float = 0;
	@:optional
	var angleZ:Float = 0;

	@:optional
	var skewX_offset:Float = 0.5;
	@:optional
	var skewY_offset:Float = 0.5;
	@:optional
	var skewZ_offset:Float = 0.5;

	@:optional
	var fovOffsetX:Float = 0;
	@:optional
	var fovOffsetY:Float = 0;

	@:optional
	var pivotOffsetX:Float = 0;
	@:optional
	var pivotOffsetY:Float = 0;
	@:optional
	var pivotOffsetZ:Float = 0;

	@:optional
	var cullMode:String = "none";

	public function reset()
	{
		setX = setY = setZ = x = y = z = angle = skewX = skewY = skewZ = stealthGlow = 0;
		alpha = scaleX = scaleY = glowRed = glowGreen = glowBlue =  1;
		strumTime = incomingAngleX = incomingAngleY = curPos = noteDist = offset = playfieldIndex = lane = index = noteIndex = 0;
		isHoldSplash = isStrum = isSus = isSplash = false;
		sustainWidth = arrowPathWidth = 1;
		sustainGrain = arrowPathAlpha = pathGrain = spiralHold = spiralPath = orient = angleX = angleY = angleZ = 0;
		arrowPathLength = 14;
		arrowPathBackwardsLength = 2;
		skewX_offset = skewY_offset = skewZ_offset = 0.5;
		fovOffsetX = fovOffsetY = 0;
		pivotOffsetX = pivotOffsetY = pivotOffsetZ = 0;
		cullMode = "none";
	}
} 

class NotePositionData implements IFlxDestroyable
{
	static var pool:FlxPool<NotePositionData> = new FlxPool(NotePositionData);

	// Set+axis variables are to force position rather than adding (added for customPathModifier, can be useful for other mods tho)
	public var setX:Float;
	public var setY:Float;
	public var setZ:Float;

	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var angle:Float;
	public var alpha:Float;
	public var scaleX:Float;
	public var scaleY:Float;
	// ??? this is a 2d texture, doesnt have depth so doesnt need scale z
	// public var scaleZ:Float;
	public var skewX:Float;
	public var skewY:Float;

	// SKEW Z DOENST EXISTS !!!!!!!!!!!!!
	public var skewZ:Float;

	public var curPos:Float;
	public var noteDist:Float;
	public var offset:Float;
	public var lane:Int;
	public var index:Int;
	public var playfieldIndex:Int;
	public var isHoldSplash:Bool;
	public var isStrum:Bool;
	public var isSplash:Bool;
	public var incomingAngleX:Float;
	public var incomingAngleY:Float;
	public var strumTime:Float;
	public var isSus:Bool;
	public var noteIndex:Int;

	public var stealthGlow:Float;
	public var glowRed:Float;
	public var glowGreen:Float;
	public var glowBlue:Float;

	public var sustainWidth:Float = 1;
	public var sustainGrain:Float = 0;

	public var arrowPathAlpha:Float = 0;
	public var arrowPathLength:Float = 14;
	public var arrowPathBackwardsLength:Float = 2;
	public var arrowPathWidth:Float = 1;
	public var pathGrain:Float = 0;

	public var spiralHold:Float = 0;
	public var spiralPath:Float = 0;

	public var orient:Float = 0;

	public var angleX:Float = 0;
	public var angleY:Float = 0;
	public var angleZ:Float = 0;

	public var skewX_offset:Float = 0.5;
	public var skewY_offset:Float = 0.5;
	public var skewZ_offset:Float = 0.5;

	public var fovOffsetX:Float = 0;
	public var fovOffsetY:Float = 0;

	public var pivotOffsetX:Float = 0;
	public var pivotOffsetY:Float = 0;
	public var pivotOffsetZ:Float = 0;

	public var cullMode:String = "none";

	// public var pathColor:StringTools.hex();
	// public var straightHold:Float;
	public function new()
	{
	}

	public function destroy()
	{

	}

	public static function get():NotePositionData
		return pool.get();

	public function setup(objectData:ObjectData):NotePositionData
	{
		this.setX = objectData.x; // by default they will be same as the base
		this.setY = objectData.y;
		this.setZ = objectData.z;

		this.x = objectData.x;
		this.y = objectData.y;
		this.z = objectData.z;
		this.angle = objectData.angle;
		this.alpha = objectData.alpha;
		this.scaleX = objectData.scaleX;
		this.scaleY = objectData.scaleY;
		this.skewX = objectData.skewX;
		this.skewY = objectData.skewY;
		this.skewZ = objectData.skewZ;
		this.index = objectData.index;
		this.playfieldIndex = objectData.playfieldIndex;
		this.lane = objectData.lane;
		this.curPos = objectData.curPos;
		this.noteDist = objectData.noteDist;
		this.isStrum = objectData.isStrum;
		this.isHoldSplash = objectData.isHoldSplash;
		this.isSplash = objectData.isSplash;
		this.isSus = objectData.isSus;
		this.incomingAngleX = objectData.incomingAngleX;
		this.incomingAngleY = objectData.incomingAngleY;
		this.strumTime = objectData.strumTime;

		this.stealthGlow = objectData.stealthGlow;
		this.glowRed = objectData.glowRed;
		this.glowGreen = objectData.glowGreen;
		this.glowBlue = objectData.glowBlue;

		this.arrowPathAlpha = objectData.arrowPathAlpha;
		this.arrowPathLength = objectData.arrowPathLength;
		this.arrowPathBackwardsLength = objectData.arrowPathBackwardsLength;

		this.pathGrain = objectData.pathGrain;

		this.spiralHold = objectData.spiralHold;

		this.angleX = objectData.angleX;
		this.angleY = objectData.angleY;
		this.angleZ = objectData.angleZ;

		this.skewX_offset = objectData.skewX_offset;
		this.skewY_offset = objectData.skewY_offset;
		this.skewZ_offset = objectData.skewZ_offset;

		this.fovOffsetX = objectData.fovOffsetX;
		this.fovOffsetY = objectData.fovOffsetY;

		this.pivotOffsetX = objectData.pivotOffsetX;
		this.pivotOffsetY = objectData.pivotOffsetY;
		this.pivotOffsetZ = objectData.pivotOffsetZ;

		this.cullMode = objectData.cullMode;
		// this.pathColor = "000000";

		// this.straightHold = 0; //why tf does a strum need a damn "straightHold" value XD?
		return this;
	}

	public function copy():NotePositionData
	{
		var data:NotePositionData = new NotePositionData();
		data.setX = setX; // by default they will be same as the base
		data.setY = setY;
		data.setZ = setZ;

		data.x = x;
		data.y = y;
		data.z = z;
		data.angle = angle;
		data.alpha = alpha;
		data.scaleX = scaleX;
		data.scaleY = scaleY;
		data.skewX = skewX;
		data.skewY = skewY;
		data.skewZ = skewZ;
		data.index = index;
		data.playfieldIndex = playfieldIndex;
		data.lane = lane;
		data.curPos = curPos;
		data.noteDist = noteDist;
		data.isStrum = isStrum;
		data.isHoldSplash = isHoldSplash;
		data.isSplash = isSplash;
		data.isSus = isSus;
		data.incomingAngleX = incomingAngleX;
		data.incomingAngleY = incomingAngleY;
		data.strumTime = strumTime;

		data.stealthGlow = stealthGlow;
		data.glowRed = glowRed;
		data.glowGreen = glowGreen;
		data.glowBlue = glowBlue;

		data.arrowPathAlpha = arrowPathAlpha;
		data.arrowPathLength = arrowPathLength;
		data.arrowPathBackwardsLength = arrowPathBackwardsLength;

		data.pathGrain = pathGrain;

		data.spiralHold = spiralHold;

		data.angleX = angleX;
		data.angleY = angleY;
		data.angleZ = angleZ;

		data.skewX_offset = skewX_offset;
		data.skewY_offset = skewY_offset;
		data.skewZ_offset = skewZ_offset;

		data.fovOffsetX = fovOffsetX;
		data.fovOffsetY = fovOffsetY;

		data.pivotOffsetX = pivotOffsetX;
		data.pivotOffsetY = pivotOffsetY;
		data.pivotOffsetZ = pivotOffsetZ;

		data.cullMode = cullMode;

		return data;
	}
}
