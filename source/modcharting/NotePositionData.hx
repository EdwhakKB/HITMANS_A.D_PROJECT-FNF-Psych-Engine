package modcharting;

import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import flixel.util.FlxPool;

using StringTools;

class NotePositionData implements IFlxDestroyable
{

    static var pool:FlxPool<NotePositionData> = new FlxPool(NotePositionData);

    public var x:Float;
    public var y:Float;
    public var z:Float;
    public var angle:Float;
    public var alpha:Float;
    public var scaleX:Float;
    public var scaleY:Float;
    public var scaleZ:Float;
    public var skewX:Float;
    public var skewY:Float;
    public var skewZ:Float;
    public var curPos:Float;
    public var noteDist:Float;
    public var offset:Float;
    public var lane:Int;
    public var index:Int;
    public var playfieldIndex:Int;
    public var isStrum:Bool;
    public var incomingAngleX:Float;
    public var incomingAngleY:Float;
    public var strumTime:Float;

    public var stealthGlow:Float;
    public var glowRed:Float;
    public var glowGreen:Float;
    public var glowBlue:Float;

    public var arrowPathAlpha:Float = 0;
    public var arrowPathLength:Float = 14;
    public var arrowPathBackwardsLength:Float = 2;

    public var arrowPathWidth:Float = 1;

    public var pathGrain:Float = 0;

    public var spiralHold:Float = 0;

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
    public function new() {}
    public function destroy() {}
    public static function get() :  NotePositionData
    {
        return pool.get();
    }

    public function setupStrum(x:Float, y:Float, z:Float, lane:Int, scaleX:Float, scaleY:Float, skewX:Float, skewY:Float, pf:Int)
    {
        this.x = x;
        this.y =  y;
        this.z = z;
        this.angle = 0;
        this.alpha = 1;
        this.scaleX = scaleX; 
        this.scaleY = scaleY;
        this.scaleZ = 1; 
        this.skewX = skewX; 
        this.skewY = skewY;
        this.skewZ = 0;
        this.index = lane;
        this.playfieldIndex = pf;
        this.lane = lane;
        this.curPos = 0;
        this.noteDist = 0;
        this.isStrum = true;
        this.incomingAngleX = 0;
        this.incomingAngleY = 0;
        this.strumTime = 0;

        this.stealthGlow = 0;
        this.glowRed = 1;
        this.glowGreen = 1;
        this.glowBlue = 1;

        this.arrowPathAlpha = 0;
        this.arrowPathLength = 14;
        this.arrowPathBackwardsLength = 2;

        this.pathGrain = 0;

        this.spiralHold = 0;

        this.angleX = 0;
        this.angleY = 0;
        this.angleZ = 0;

        this.skewX_offset = 0.5;
        this.skewY_offset = 0.5;
        this.skewZ_offset = 0.5;

        this.fovOffsetX = 0;
        this.fovOffsetY = 0;

        this.pivotOffsetX = 0;
        this.pivotOffsetY = 0;
        this.pivotOffsetZ = 0;

        this.cullMode = "none";
        // this.pathColor = "000000";

        // this.straightHold = 0; //why tf does a strum need a damn "straightHold" value XD?
    }

    public function setupNote(x:Float, y:Float, z:Float, lane:Int, scaleX:Float, scaleY:Float, skewX:Float, skewY:Float, pf:Int, alpha:Float, curPos:Float, noteDist:Float, iaX:Float, iaY:Float, strumTime:Float, index:Int)
    {
        this.x = x;
        this.y =  y;
        this.z = z;
        this.angle = 0;
        this.alpha = alpha;
        this.scaleX = scaleX; 
        this.scaleY = scaleY;
        this.scaleZ = 1;
        this.skewX = skewX; 
        this.skewY = skewY;
        this.skewZ = 0;
        this.index = index;
        this.playfieldIndex = pf;
        this.lane = lane;
        this.curPos = curPos;
        this.noteDist = noteDist;
        this.isStrum = false;
        this.incomingAngleX = iaX;
        this.incomingAngleY = iaY;
        this.strumTime = strumTime;

        this.stealthGlow = 0;
        this.glowRed = 1;
        this.glowGreen = 1;
        this.glowBlue = 1;

        this.arrowPathAlpha = 0;
        this.arrowPathLength = 14;
        this.arrowPathBackwardsLength = 2;

        this.pathGrain = 0;

        this.spiralHold = 0;

        this.orient = 0;

        this.angleX = 0;
        this.angleY = 0;
        this.angleZ = 0;

        this.skewX_offset = 0.5;
        this.skewY_offset = 0.5;
        this.skewZ_offset = 0.5;

        this.fovOffsetX = 0;
        this.fovOffsetY = 0;

        this.pivotOffsetX = 0;
        this.pivotOffsetY = 0;
        this.pivotOffsetZ = 0;

        this.cullMode = "none";
        // this.pathColor = "000000";

        // this.straightHold = 0; //different to up this doesn't break shit LOL
    }
}