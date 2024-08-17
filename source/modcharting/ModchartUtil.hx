package modcharting;

import flixel.tweens.FlxEase;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import lime.math.Vector2;
import openfl.geom.Vector3D;
import flixel.FlxG;

#if LEATHER
import states.PlayState;
import game.Note;
import game.Conductor;
#else 
import PlayState;
import Note;
#end

using StringTools;

class ModchartUtil
{
    public static function getDownscroll(instance:ModchartMusicBeatState)
    {
        //need to test each engine
        //not expecting all to work
        #if PSYCH 
        return ClientPrefs.downScroll;
        #elseif LEATHER
        return utilities.Options.getData("downscroll");
        #elseif ANDROMEDA //dunno why youd use this on andromeda but whatever, already got its own cool modchart system
        return instance.currentOptions.downScroll;
        #elseif KADE 
        return PlayStateChangeables.useDownscroll;
        #elseif FOREVER_LEGACY //forever might not work just yet because of the multiple strumgroups
        return Init.trueSettings.get('Downscroll');
        #elseif FPSPLUS 
        return Config.downscroll;
        #elseif MIC_D_UP //basically no one uses this anymore
        return MainVariables._variables.scroll == "down"
        #else 
        return false;
        #end
    }
    public static function getMiddlescroll(instance:ModchartMusicBeatState)
    {
        #if PSYCH 
        return ClientPrefs.middleScroll;
        #elseif LEATHER
        return utilities.Options.getData("middlescroll");
        #else 
        return false;
        #end
    }
    public static function getScrollSpeed(instance:PlayState)
    {
        if (instance == null)
            return PlayState.SONG.speed;

        #if PSYCH
        return PlayState.SONG.speed;
        #elseif ANDROMEDA
        return instance.songSpeed;
        #elseif LEATHER
        @:privateAccess
        return instance.speed;
        #elseif KADE 
        return PlayStateChangeables.scrollSpeed == 1 ? PlayState.SONG.speed : PlayStateChangeables.scrollSpeed;
        #else 
        return PlayState.SONG.speed; //most engines just use this
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
        //fuck
        var offset:Float = 0;
       
        var lane = daNote.noteData;
        if (daNote.mustPress)
            lane += NoteMovement.keyCount;
        var strum = instance.playfieldRenderer.strumGroup.members[lane];

        var arrayVal = Std.string([lane, daNote.arrow_Type, daNote.isSustainNote]);

        if (!NoteMovement.leatherEngineOffsetStuff.exists(arrayVal))
        {
            var tempShit:Float = 0.0;

            
            var targetX = NoteMovement.defaultStrumX[lane];
            var xPos = targetX;
            while (Std.int(xPos + (daNote.width / 2)) != Std.int(targetX + (strum.width / 2)))
            {
                xPos += (xPos + daNote.width > targetX + strum.width ? -0.1 : 0.1);
                tempShit += (xPos + daNote.width > targetX + strum.width ? -0.1 : 0.1);
            }
            //trace(arrayVal);
            //trace(tempShit);

            NoteMovement.leatherEngineOffsetStuff.set(arrayVal, tempShit);
        }
        offset = NoteMovement.leatherEngineOffsetStuff.get(arrayVal);
        
        return offset;
        #else 
        return (daNote.isSustainNote ? 37 : 0); //the magic number
        #end
    }
    
    public static function getNoteSkew(daNote:Note, isSkewY:Bool)
    {
        if (!isSkewY){
            return daNote.skew.x;
        }else{
            return daNote.skew.y;  
        }
    }

    public static function getStrumSkew(daNote:StrumNote, isSkewY:Bool)
    {
        if (!isSkewY){
            return daNote.skew.x;
        }else{
            return daNote.skew.y;  
        }
    }

    static var currentFakeCrochet:Float = -1;
    static var lastBpm:Float = -1;

    public static function getFakeCrochet()
    {
        if (PlayState.SONG.bpm != lastBpm)
        {
            currentFakeCrochet = (60 / PlayState.SONG.bpm) * 1000; //only need to calculate once
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

        //TODO: maybe try using actual matrix???

        var newz = pos.z - 1;
        var zRange = zNear - zFar;
        var tanHalfFOV = FlxMath.fastSin(FOV*0.5)/FlxMath.fastCos(FOV*0.5); //faster tan
        if (pos.z > 1) //if above 1000 z basically
            newz = 0; //should stop weird mirroring with high z values

        //var m00 = 1/(tanHalfFOV);
        //var m11 = 1/tanHalfFOV;
        //var m22 = (-zNear - zFar) / zRange; //isnt this just 1 lol
        //var m23 = 2 * zFar * zNear / zRange;
        //var m32 = 1;

        var xOffsetToCenter = pos.x - (FlxG.width*0.5); //so the perspective focuses on the center of the screen
        var yOffsetToCenter = pos.y - (FlxG.height*0.5);

        var zPerspectiveOffset = (newz+(2 * zFar * zNear / zRange));


        //xOffsetToCenter += (offsetX / (1/-zPerspectiveOffset));
        //yOffsetToCenter += (offsetY / (1/-zPerspectiveOffset));
        xOffsetToCenter += (offsetX * -zPerspectiveOffset);
        yOffsetToCenter += (offsetY * -zPerspectiveOffset);

        var xPerspective = xOffsetToCenter*(1/tanHalfFOV);
        var yPerspective = yOffsetToCenter/(1/tanHalfFOV);
        xPerspective /= -zPerspectiveOffset;
        yPerspective /= -zPerspectiveOffset;

        pos.x = xPerspective+(FlxG.width*0.5); //offset it back to normal
        pos.y = yPerspective+(FlxG.height*0.5);
        pos.z = zPerspectiveOffset;

        

        //pos.z -= 1;
        //pos = perspectiveMatrix.transformVector(pos);

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
        pos.x = FlxMath.fastCos(theta*rad)*FlxMath.fastSin(phi*rad);
        pos.y = FlxMath.fastCos(phi*rad);
        pos.z = FlxMath.fastSin(theta*rad)*FlxMath.fastSin(phi*rad);
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

    public static function getFlxEaseByString(?ease:String = '') {
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
            totalTime += (60/curBpm)*1000;
        }

        var leftOverBeat = beat - Math.floor(beat);
        totalTime += (60/curBpm)*1000*leftOverBeat;

        return totalTime;
    }
}