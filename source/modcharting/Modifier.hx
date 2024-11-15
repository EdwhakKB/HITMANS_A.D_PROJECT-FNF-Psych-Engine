package modcharting;

import modcharting.PlayfieldRenderer.StrumNoteType;
import flixel.tweens.FlxEase;
import flixel.math.FlxMath;
import flixel.FlxG;

#if LEATHER
import states.PlayState;
import game.Note;
import game.StrumNote;
import game.Conductor;
#else 
import PlayState;
import Note;
#end
import lime.math.Vector4;
import haxe.ds.List;
import flixel.group.FlxGroup.FlxTypedGroup;

enum ModifierType
{
    ALL;
    PLAYERONLY;
    OPPONENTONLY;
    LANESPECIFIC;   
}

class TimeVector extends Vector4 {
    public var startDist: Float;
    public var endDist: Float;
    public var next: TimeVector;
    
    public function new(x: Float = 0, y: Float = 0, z: Float = 0, w: Float = 0) {
        super(x, y, z, w);
        startDist = 0.0;
        endDist = 0.0;
        next = null;
    }

}


class ModifierSubValue 
{
    public var value:Float = 0.0;
    public var baseValue:Float = 0.0;
    public function new(value:Float)
    {
        this.value = value;
        baseValue = value;
    }
}

class Modifier
{
    public var baseValue:Float = 0;
    public var currentValue:Float = 0;
    public var subValues:Map<String, ModifierSubValue> = new Map<String, ModifierSubValue>();
    public var tag:String = '';
    public var type:ModifierType = ALL;
    public var playfield:Int = -1;
    public var targetLane:Int = -1;
    public var instance:ModchartMusicBeatState = null;
    public var renderer:PlayfieldRenderer = null;
    public static var beat:Float = 0;
    public static var step:Float = 0;
    public static var curBeat:Int = 0;
    public static var curStep:Int = 0;
    public var notes:FlxTypedGroup<Note>;
    
    public function new(tag:String, ?type:ModifierType = ALL, ?playfield:Int = -1)
    {
        this.tag = tag;
        this.type = type;
        this.playfield = playfield;

        setupSubValues();
    }    
    public function getNotePath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        if (currentValue != baseValue)
            noteMath(noteData, lane, curPos, pf);
    }
    public function getStrumPath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        if (currentValue != baseValue)
            strumMath(noteData, lane, pf);
    }
    public function getIncomingAngle(lane:Int, curPos:Float, pf:Int):Array<Float>
    {
        if (currentValue != baseValue)
            return incomingAngleMath(lane, curPos, pf); 
        return [0,0];       
    }

    //cur pos is how close the note is to the strum, need to edit for boost and accel
    public function getNoteCurPos(lane:Int, curPos:Float, pf:Int)
    {
        if (currentValue != baseValue)
            curPos = curPosMath(lane, curPos, pf);  
        return curPos;      
    }
    //usually fnf does *0.45 to slow the scroll speed a little, thats what this is
    //kinda just called it notedist cuz idk what else to call it,
    //using it for reverse/scroll speed changes ig
    public function getNoteDist(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    {

        if (currentValue != baseValue)
            noteDist = noteDistMath(noteDist, lane, curPos, pf);

        return noteDist; 
    }

    

    public dynamic function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int) {} //for overriding (and for custom mods with hscript)
    public dynamic function strumMath(noteData:NotePositionData, lane:Int, pf:Int) {}
    public dynamic function incomingAngleMath(lane:Int, curPos:Float, pf:Int):Array<Float> { return [0,0]; }
    public dynamic function curPosMath(lane:Int, curPos:Float, pf:Int) { return curPos; }
    public dynamic function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int):Float { return noteDist; }
    public dynamic function setupSubValues() {}

    public function checkPlayField(pf:Int):Bool //returns true if should display on current playfield
    {
        return (playfield == -1) || (pf == playfield);
    }
    public function checkLane(lane:Int):Bool //returns true if should display on current lane
    {
        switch(type)
        {
            case LANESPECIFIC: 
                return lane == targetLane;
            case PLAYERONLY:
                return lane >= NoteMovement.keyCount;
            case OPPONENTONLY:
                return lane < NoteMovement.keyCount;
            default: //so haxe shuts the fuck up
        }
        return true;
    }

    public function reset() //for the editor
    {
        currentValue = baseValue;
        for (subMod in subValues)
            subMod.value = subMod.baseValue;
    }
    public function copy()
    {
        //for custom mods to copy from the stored ones in the map
        var mod:Modifier = new Modifier(this.tag, this.type, this.playfield);
        mod.noteMath = this.noteMath;
        mod.strumMath = this.strumMath;
        mod.incomingAngleMath = this.incomingAngleMath;
        mod.curPosMath = this.curPosMath;
        mod.noteDistMath = this.noteDistMath;
        mod.currentValue = this.currentValue;
        mod.baseValue = this.currentValue;
        mod.subValues = this.subValues;
        mod.targetLane = this.targetLane;
        mod.instance = this.instance;
        mod.renderer = this.renderer;
        return mod;
    }
    public function createSubMod(name:String, startVal:Float)
    {
        subValues.set(name, new ModifierSubValue(startVal));
    }
}

class ModifierMath
{
    //Dunk math
    public static function Drunk(lane:Int, curPos:Float, speed:Float):Float
    {
        return (FlxMath.fastCos( ((Conductor.songPosition*0.001) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*0.45)*(10/FlxG.height)) * (speed*0.2)) * Note.swagWidth*0.5);
    };
    //TanDrunk math
    public static function TanDrunk(lane:Int, curPos:Float, speed:Float):Float
    {
        return (Math.tan( ((Conductor.songPosition*0.001) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*0.45)*(10/FlxG.height)) * (speed*0.2)) * Note.swagWidth*0.5);
    };


    //Tipsy math
    public static function Tipsy(lane:Int, speed:Float):Float
    {
        return (FlxMath.fastCos( (Conductor.songPosition*0.001 *(1.2) + 
        (lane%NoteMovement.keyCount)*(2.0)) * (5) * speed*0.2 ) * Note.swagWidth*0.4);
    }
    //TanTipsy math
    public static function TanTipsy(lane:Int, speed:Float):Float
    {
        return (Math.tan( (Conductor.songPosition*0.001 *(1.2) + 
        (lane%NoteMovement.keyCount)*(2.0)) * (5) * speed*0.2 ) * Note.swagWidth*0.4);
    };

    //Reverse Math
    public static function Reverse(noteData:NotePositionData, lane:Int) //no clue how would this be useful but ok??
    {  
        var screenCenter:Float = (FlxG.height/2) - (NoteMovement.arrowSizes[lane]/2);
        var differenceBetween:Float = noteData.y - screenCenter;
        return differenceBetween * -1;
    }

    /*public static function Rotate(noteData:NotePositionData, lane:Int) --until i figure it out
    {
        var xPos = NoteMovement.defaultStrumX[lane];
        var yPos = NoteMovement.defaultStrumY[lane];
        var rotX = ModchartUtil.getCartesianCoords3D(subValues.get('x').value, 90, xPos-subValues.get('rotatePointX').value);
        noteData.x += rotX.x+subValues.get('rotatePointX').value-xPos;
        var rotY = ModchartUtil.getCartesianCoords3D(90, subValues.get('y').value, yPos-subValues.get('rotatePointY').value);
        noteData.y += rotY.y+subValues.get('rotatePointY').value-yPos;
        noteData.z += rotX.z + rotY.z;

        var notePos = ModchartUtil.getCartesianCoords3D(rotX.x, rotY.x, rotX.y);
        return 
    }*/

    /*public static function StrumLineRotate(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var laneShit = lane%NoteMovement.keyCount;
        var offsetThing = 0.5;
        var halfKeyCount = NoteMovement.keyCount/2;
        if (lane < halfKeyCount)
        {
            offsetThing = -0.5;
            laneShit = lane+1;
        }
        var distFromCenter = ((laneShit)-halfKeyCount)+offsetThing; //theres probably an easier way of doing this
        //basically
        //0 = 1.5
        //1 = 0.5
        //2 = -0.5
        //3 = -1.5
        //so if you then multiply by the arrow size, all notes should be in the same place
        noteData.x += -distFromCenter*NoteMovement.arrowSize;

        var upscroll = true;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                upscroll = false;

        //var rot = ModchartUtil.getCartesianCoords3D(subValues.get('x').value, subValues.get('y').value, distFromCenter*NoteMovement.arrowSize);
        var q = SimpleQuaternion.fromEuler(subValues.get('z').value, subValues.get('x').value, (upscroll ? -subValues.get('y').value : subValues.get('y').value)); //i think this is the right order???
        //q = SimpleQuaternion.normalize(q); //dont think its too nessessary???
        noteData.x += q.x * distFromCenter*NoteMovement.arrowSize;
        noteData.y += q.y * distFromCenter*NoteMovement.arrowSize;
        noteData.z += q.z * distFromCenter*NoteMovement.arrowSize;
    }*/

    
    //Bumpy math
    public static function Bumpy(curPos:Float, speed:Float):Float
    {
        return 40 * FlxMath.fastSin(curPos*0.01*speed);
    }
    //TanBumpy math
    public static function TanBumpy(curPos:Float, speed:Float):Float
    {
        return 40 * Math.tan(curPos*0.01*speed);
    };

    //Beat math
    public static function Beat(curPos:Float, speed:Float, mult:Float):Float
    {
        var fAccelTime = 0.2;
        var fTotalTime = 0.5;
    
        /* If the song is really fast, slow down the rate, but speed up the
        * acceleration to compensate or it'll look weird. */
        //var fBPM = Conductor.bpm * 60;
        //var fDiv = Math.max(1.0, Math.floor( fBPM / 150.0 ));
        //fAccelTime /= fDiv;
        //fTotalTime /= fDiv;

        var time = Modifier.beat * speed;
        var posMult = mult;
        /* offset by VisualDelayEffect seconds */
        var fBeat = time + fAccelTime;
        //fBeat /= fDiv;

        var bEvenBeat = ( Math.floor(fBeat) % 2 ) != 0;

        /* -100.2 -> -0.2 -> 0.2 */
        if( fBeat < 0 )
            return 0;

        fBeat -= Math.floor( fBeat );
        fBeat += 1;
        fBeat -= Math.floor( fBeat );

        if( fBeat >= fTotalTime )
            return 0;

        var fAmount:Float;
        if( fBeat < fAccelTime )
        {
            fAmount = FlxMath.remapToRange( fBeat, 0.0, fAccelTime, 0.0, 1.0);
            fAmount *= fAmount;
        } else /* fBeat < fTotalTime */ {
            fAmount = FlxMath.remapToRange( fBeat, fAccelTime, fTotalTime, 1.0, 0.0);
            fAmount = 1 - (1-fAmount) * (1-fAmount);
        }

        if( bEvenBeat )
            fAmount *= -1;

        var fShift = 20.0*fAmount*FlxMath.fastSin( (curPos * 0.01 * posMult) + (Math.PI/2.0) );
        return fShift;
    }

    //Invert math
    public static function Invert(lane:Int)
    {
        return NoteMovement.arrowSizes[lane] * (lane % 2 == 0 ? 1 : -1);
    }

    //Flip math
    public static function Flip(lane:Int)
    {
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd, 0, NoteMovement.keyCount, NoteMovement.keyCount, -NoteMovement.keyCount);
       return newPos;
    }

    //Bounce math
    public static function Bounce(lane:Int, curPos:Float, speed:Float):Float
    {
        return NoteMovement.arrowSizes[lane] * Math.abs(FlxMath.fastSin(curPos*0.005*speed));
    }

    //InvertSine math
    public static function InvertSine(lane:Int, curPos:Float, pf:Int, currentValue:Float) //first mod mad that uses currentVal damn...
    {
        return FlxMath.fastSin(0 + (curPos*0.004))*(NoteMovement.arrowSizes[lane] * (lane % 2 == 0 ? 1 : -1) * currentValue * 0.5);
    }

    //Wave math
    public static function Wave(lane:Int, speed:Float)
    {
        return FlxMath.fastSin(((Conductor.songPosition) * (speed)*0.0008)+(lane/4))*0.2; //the 260 used in wave its just for it to look big, idk if you really need it in custom mods tho.
    }
    //TanWave math
    public static function TanWave(lane:Int, speed:Float)
    {
        return Math.tan(((Conductor.songPosition) * (speed)*0.0008)+(lane/4))*0.2; //the 260 used in wave its just for it to look big, idk if you really need it in custom mods tho.
    }

    //Ease math
    public static function Ease(lane:Int, speed:Float)
    {
        return (FlxMath.fastCos( ((Conductor.songPosition*0.001) + ((lane%NoteMovement.keyCount)*0.2) 
        *(10/FlxG.height)) * (speed*0.2)) * Note.swagWidth*0.5);
    }

    //Tornado math
    public static function Tornado(lane:Int, curPos:Float, speed:Float)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * speed * 0.2;
        var returnReceptorToZeroOffsetX = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetX = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetX;
        
        return offsetX;
    }
    //TanTornado math
    public static function TanTornado(lane:Int, curPos:Float, speed:Float)
    {
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * speed * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetX = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        return offsetX;
    }

    //ZigZag math
    public static function ZigZag(lane:Int, curPos:Float, mult:Float)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * mult;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        return result;
    }

    //Sawtooth math
    public static function Sawtooth(lane:Int, curPos:Float, multVal:Float)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * multVal;
        return ((curPos*0.45) % mult/2);
    }

    //Square math
    public static function squareMath(lane:Int, curPos:Float, mult:Float, timeOffset:Float, xOffset:Float):Float
    {
        var mult:Float = mult / (NoteMovement.arrowSizes[lane]);
        var timeOffset:Float = timeOffset;
        var xOffset:Float = xOffset;
        var xVal:Float = FlxMath.fastSin(((curPos*0.45) + timeOffset) * Math.PI * mult);
        xVal = Math.floor(xVal) + 0.5 + xOffset;

        return xVal * NoteMovement.arrowSizes[lane];
    }
    
    //Cosecant math
    public static function Cosecant(lane:Int, curPos:Float, period:Float, offset:Float, spacing:Float, speed:Float, size:Float)
    {
        return (1 / Math.sin((((Conductor.songPosition*(0.001*period)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*offset))*((spacing*10)/FlxG.height)) * 
        (speed*0.2)) * Note.swagWidth*(0.5*size)));
    }
}
//adding drunk and tipsy for all axis because i can

class DrunkXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkZModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkAngleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkScaleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value)));

        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkScaleXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkScaleYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkSkewModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);

        noteData.skewY += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkSkewXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class DrunkSkewYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * ModifierMath.Drunk(lane,curPos,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}

class TipsyXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsyYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsyZModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsyAngleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsyScaleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Tipsy(lane,subValues.get('speed').value)));

        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Tipsy(lane,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsyScaleXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Tipsy(lane,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsyScaleYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Tipsy(lane,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsySkewModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);

        noteData.skewY += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsySkewXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TipsySkewYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * ModifierMath.Tipsy(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}


class ReverseModifier extends Modifier 
{
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        noteData.y += (currentValue*2) * ModifierMath.Reverse(noteData, lane);
        //var screenCenter:Float = (FlxG.height/2) - (NoteMovement.arrowSizes[lane]/2);
        //var differenceBetween:Float = noteData.y - screenCenter;
        //noteData.y += (currentValue*2) * differenceBetween * -1;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    // override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    // {
    //     var scrollSwitch = 520;
    //     if (instance != null)
    //         if (ModchartUtil.getDownscroll(instance))
    //             scrollSwitch *= -1;
    //     noteData.y += scrollSwitch * currentValue;
    // }
    // override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    // {
    //     return noteDist * (1-(currentValue*2));
    // }
    // override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    // {
    //     noteMath(noteData, lane, 0, pf); //just reuse same thing
    // }
}
class SplitModifier extends Modifier 
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        subValues.set('VarA', new ModifierSubValue(0.0));
        subValues.set('VarB', new ModifierSubValue(0.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        var laneThing = lane % NoteMovement.keyCount;

        if (laneThing > 1)
            noteData.y += (subValues.get('VarA').value*2) * ModifierMath.Reverse(noteData, lane);

        if (laneThing < 2)
            noteData.y += (subValues.get('VarB').value*2) * ModifierMath.Reverse(noteData, lane);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    // override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    // {
    //     var scrollSwitch = 520;
    //     if (instance != null)
    //         if (ModchartUtil.getDownscroll(instance))
    //             scrollSwitch *= -1;

    //     var laneThing = lane % NoteMovement.keyCount;

    //     if (laneThing > 1)
    //         noteData.y += scrollSwitch * subValues.get('VarA').value;

    //     if (laneThing < 2)
    //         noteData.y += scrollSwitch * subValues.get('VarB').value;
    // }
    // override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    // {
    //     var laneThing = lane % NoteMovement.keyCount;

    //     if (laneThing > 1)
    //         return noteDist * (1-(subValues.get('VarA').value*2));

    //     if (laneThing < 2)
    //         return noteDist * (1-(subValues.get('VarB').value*2));

    //     return noteDist;
    // }
    // override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    // {
    //     noteMath(noteData, lane, 0, pf); //just reuse same thing
    // }
    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
}
class CrossModifier extends Modifier 
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        subValues.set('VarA', new ModifierSubValue(0.0));
        subValues.set('VarB', new ModifierSubValue(0.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        var laneThing = lane % NoteMovement.keyCount;

        if (laneThing > 0 && laneThing < 3)
            noteData.y += (subValues.get('VarA').value*2) * ModifierMath.Reverse(noteData, lane);

        if (laneThing == 0 || laneThing == 3)
            noteData.y += (subValues.get('VarB').value*2) * ModifierMath.Reverse(noteData, lane);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    // override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    // {
    //     var scrollSwitch = 520;
    //     if (instance != null)
    //         if (ModchartUtil.getDownscroll(instance))
    //             scrollSwitch *= -1;

    //     var laneThing = lane % NoteMovement.keyCount;

    //     if (laneThing > 0 && laneThing < 3)
    //         noteData.y += scrollSwitch * subValues.get('VarA').value;

    //     if (laneThing == 0 || laneThing == 3)
    //         noteData.y += scrollSwitch * subValues.get('VarB').value;
    // }
    // override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    // {
    //     var laneThing = lane % NoteMovement.keyCount;

    //     if (laneThing > 0 && laneThing < 3)
    //         return noteDist * (1-(subValues.get('VarA').value*2));

    //     if (laneThing == 0 || laneThing == 3)
    //         return noteDist * (1-(subValues.get('VarB').value*2));

    //     return noteDist;
    // }
    // override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    // {
    //     noteMath(noteData, lane, 0, pf); //just reuse same thing
    // }
    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
}
class AlternateModifier extends Modifier 
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        subValues.set('VarA', new ModifierSubValue(0.0));
        subValues.set('VarB', new ModifierSubValue(0.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        if (lane%2 == 1)
            noteData.y += (subValues.get('VarA').value*2) * ModifierMath.Reverse(noteData, lane);

        if (lane%2 == 0)
            noteData.y += (subValues.get('VarB').value*2) * ModifierMath.Reverse(noteData, lane);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    // override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    // {
    //     var scrollSwitch = 520;
    //     if (instance != null)
    //         if (ModchartUtil.getDownscroll(instance))
    //             scrollSwitch *= -1;
    //     if (lane%2 == 1)
    //         noteData.y += scrollSwitch * subValues.get('VarA').value;

    //     if (lane%2 == 0)
    //         noteData.y += scrollSwitch * subValues.get('VarB').value;
    // }
    // override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    // {
    //     if (lane%2 == 1)
    //         return noteDist * (1-(subValues.get('VarA').value*2));

    //     if (lane%2 == 0)
    //         return noteDist * (1-(subValues.get('VarB').value*2));

    //     return noteDist;
    // }
    // override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    // {
    //     noteMath(noteData, lane, 0, pf); //just reuse same thing
    // }
    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
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
        currentValue = 1.0; //the code that stop the mod from running gets confused when it resets in the editor i guess??
    }
}


class RotateModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));

        subValues.set('rotatePointX', new ModifierSubValue((FlxG.width/2)-(NoteMovement.arrowSize/2)));
        subValues.set('rotatePointY', new ModifierSubValue((FlxG.height/2)-(NoteMovement.arrowSize/2)));
        currentValue = 1.0;
    }

    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var xPos = NoteMovement.defaultStrumX[lane];
        var yPos = NoteMovement.defaultStrumY[lane];
        var rotX = ModchartUtil.getCartesianCoords3D(subValues.get('x').value, 90, xPos-subValues.get('rotatePointX').value);
        noteData.x += rotX.x+subValues.get('rotatePointX').value-xPos;
        var rotY = ModchartUtil.getCartesianCoords3D(90, subValues.get('y').value, yPos-subValues.get('rotatePointY').value);
        noteData.y += rotY.y+subValues.get('rotatePointY').value-yPos;
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
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));
        subValues.set('z', new ModifierSubValue(90.0));
        currentValue = 1.0;
    }

    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var laneShit = lane%NoteMovement.keyCount;
        var offsetThing = 0.5;
        var halfKeyCount = NoteMovement.keyCount/2;
        if (lane < halfKeyCount)
        {
            offsetThing = -0.5;
            laneShit = lane+1;
        }
        var distFromCenter = ((laneShit)-halfKeyCount)+offsetThing; //theres probably an easier way of doing this
        //basically
        //0 = 1.5
        //1 = 0.5
        //2 = -0.5
        //3 = -1.5
        //so if you then multiply by the arrow size, all notes should be in the same place
        noteData.x += -distFromCenter*NoteMovement.arrowSize;

        var upscroll = true;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                upscroll = false;

        //var rot = ModchartUtil.getCartesianCoords3D(subValues.get('x').value, subValues.get('y').value, distFromCenter*NoteMovement.arrowSize);
        var q = SimpleQuaternion.fromEuler(subValues.get('z').value, subValues.get('x').value, (upscroll ? -subValues.get('y').value : subValues.get('y').value)); //i think this is the right order???
        //q = SimpleQuaternion.normalize(q); //dont think its too nessessary???
        noteData.x += q.x * distFromCenter*NoteMovement.arrowSize;
        noteData.y += q.y * distFromCenter*NoteMovement.arrowSize;
        noteData.z += q.z * distFromCenter*NoteMovement.arrowSize;
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
class Rotate3DModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));

        subValues.set('rotatePointX', new ModifierSubValue((FlxG.width/2)-(NoteMovement.arrowSize/2)));
        subValues.set('rotatePointY', new ModifierSubValue((FlxG.height/2)-(NoteMovement.arrowSize/2)));
        currentValue = 1.0;
    }

    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var xPos = NoteMovement.defaultStrumX[lane];
        var yPos = NoteMovement.defaultStrumY[lane];
        var rotX = ModchartUtil.getCartesianCoords3D(-subValues.get('x').value, 90, xPos-subValues.get('rotatePointX').value);
        noteData.x += rotX.x+subValues.get('rotatePointX').value-xPos;
        var rotY = ModchartUtil.getCartesianCoords3D(90, subValues.get('y').value, yPos-subValues.get('rotatePointY').value);
        noteData.y += rotY.y+subValues.get('rotatePointY').value-yPos;
        noteData.z += rotX.z + rotY.z;

        noteData.angleY += subValues.get('x').value;
        noteData.angleX += subValues.get('y').value;
    }
    override function incomingAngleMath(lane:Int, curPos:Float, pf:Int)
    {
        var multiply:Bool = subValues.get('y').value%180 != 0; //so it calculates the stuff ONLY if angle its not 180/360 base
        var valueToUse:Float = multiply ? 90 : 0;
        return [valueToUse, subValues.get('y').value]; //ik this might cause problems at some point with some modifiers but eh, there is nothing i could do about it- (i can LMAO)
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

class BumpyXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
    }
}
class BumpyYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
    }
}
class BumpyModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
    }
}
class BumpyAngleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
    }
}
class BumpyScaleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Bumpy(curPos, subValues.get('speed').value)));
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Bumpy(curPos, subValues.get('speed').value)));
    }
}
class BumpyScaleXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Bumpy(curPos, subValues.get('speed').value)));
    }
}
class BumpyScaleYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Bumpy(curPos, subValues.get('speed').value)));
    }
}
class BumpySkewModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
        noteData.skewY += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
    }
}
class BumpySkewXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
    }
}
class BumpySkewYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * ModifierMath.Bumpy(curPos, subValues.get('speed').value);
    }
}


class TanBumpyXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
    }
}
class TanBumpyYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
    }
}
class TanBumpyModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
    }
}
class TanBumpyAngleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
    }
}
class TanBumpyScaleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.TanBumpy(curPos, subValues.get('speed').value)));
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.TanBumpy(curPos, subValues.get('speed').value)));
    }
}
class TanBumpyScaleXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.TanBumpy(curPos, subValues.get('speed').value)));
    }
}
class TanBumpyScaleYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.TanBumpy(curPos, subValues.get('speed').value)));
    }
}
class TanBumpySkewModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
        noteData.skewY += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
    }
}
class TanBumpySkewXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
    }
}
class TanBumpySkewYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * ModifierMath.TanBumpy(curPos, subValues.get('speed').value);
    }
}

class XModifier extends Modifier 
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.x += currentValue;
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
        noteData.y += currentValue;
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
        noteData.z += currentValue;
    }
}

class ConfusionModifier extends Modifier //note angle
{
    override function setupSubValues()
    {
        subValues.set('force', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = -1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch *= -1;

        if (subValues.get('force').value >= 0.5) noteData.angle += currentValue;
        else noteData.angle += currentValue * scrollSwitch; //forced as default now to fix upscroll and downscroll modcharts that uses angle (no need for z and x, just angle and y)
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.angle += currentValue;
    }
}
class ConfusionXModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angleX += currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.angleX += currentValue;
    }
}
class ConfusionYModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angleY += currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.angleY += currentValue;
    }
}

class ScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 1.0;
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= currentValue;
        noteData.scaleY *= currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleX *= currentValue;
        noteData.scaleY *= currentValue;
    }
}
class ScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 1.0;
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= currentValue;
        //noteData.scaleY *= currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleX *= currentValue;
        //noteData.scaleY *= currentValue;
    }
}
class ScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 1.0;
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        //noteData.scaleX *= currentValue;
        noteData.scaleY *= currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        //noteData.scaleX *= currentValue;
        noteData.scaleY *= currentValue;
    }
}


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


class AlphaModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.alpha *= 1-currentValue;
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
        noteData.alpha *= 1-currentValue;
    }
}
class TargetAlphaModifier extends Modifier
{
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.alpha *= 1-currentValue;
    }
}
//same as alpha but changes notes glow!!!!!
class StealthModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var stealthGlow:Float = currentValue*2;
        noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); //clamp

        var substractAlpha:Float = currentValue-0.5;
        substractAlpha = FlxMath.bound(substractAlpha*2, 0, 1);
        noteData.alpha *= 1-substractAlpha;
    }       
}
class DarkModifier extends Modifier
{
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        var stealthGlow:Float = currentValue*2;
        noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); //clamp

        var substractAlpha:Float = currentValue-0.5;
        substractAlpha = FlxMath.bound(substractAlpha*2, 0, 1);
        noteData.alpha *= 1-substractAlpha;
    }       
}
class StealthColorModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('r', new ModifierSubValue(255.0));
        subValues.set('g', new ModifierSubValue(255.0));
        subValues.set('b', new ModifierSubValue(255.0));
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var red = subValues.get('r').value/255; //so i can get exact values instead of 0.7668676767676768
        var green = subValues.get('g').value/255;
        var blue = subValues.get('b').value/255;

        noteData.glowRed *= red;
        noteData.glowGreen *= green;
        noteData.glowBlue *= blue;
    }
    override public function reset(){
        super.reset();
        currentValue = 1.0;
    }
}
class DarkColorModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('r', new ModifierSubValue(255.0));
        subValues.set('g', new ModifierSubValue(255.0));
        subValues.set('b', new ModifierSubValue(255.0));
        currentValue = 1.0;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        var red = subValues.get('r').value/255; //so i can get exact values instead of 0.7668676767676768
        var green = subValues.get('g').value/255;
        var blue = subValues.get('b').value/255;

        noteData.glowRed *= red;
        noteData.glowGreen *= green;
        noteData.glowBlue *= blue;
    }
    override public function reset(){
        super.reset();
        currentValue = 1.0;
    }
}
class SDColorModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('r', new ModifierSubValue(255.0));
        subValues.set('g', new ModifierSubValue(255.0));
        subValues.set('b', new ModifierSubValue(255.0));
        currentValue = 1.0;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        var red = subValues.get('r').value/255; //so i can get exact values instead of 0.7668676767676768
        var green = subValues.get('g').value/255;
        var blue = subValues.get('b').value/255;

        noteData.glowRed *= red;
        noteData.glowGreen *= green;
        noteData.glowBlue *= blue;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    override public function reset(){
        super.reset();
        currentValue = 1.0;
    }
}
class SuddenModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('noglow', new ModifierSubValue(1.0)); //by default 1
        subValues.set('start', new ModifierSubValue(5.0));
        subValues.set('end', new ModifierSubValue(3.0));
        subValues.set('offset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var a:Float = FlxMath.remapToRange(curPos, (subValues.get('start').value*-100) + (subValues.get('offset').value*-100), 
            (subValues.get('end').value*-100) + (subValues.get('offset').value*-100), 1, 0);
        a = FlxMath.bound(a, 0, 1);

        if (subValues.get('noglow').value >= 1.0)
        {
            noteData.alpha -= a*currentValue;
            return;
        }

        a *= currentValue;

        if (subValues.get('noglow').value < 0.5)
        {
            var stealthGlow:Float = a*2;
            noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); //clamp
        }

        var substractAlpha:Float = FlxMath.bound((a-0.5)*2, 0, 1);
        noteData.alpha -= substractAlpha;

        // var start = (subValues.get('start').value*-100) + (subValues.get('offset').value*-100);
        // var end = (subValues.get('end').value*-100) + (subValues.get('offset').value*-100);

        // if (curPos <= end && curPos >= start)
        // {
        //     var hmult = -(curPos-(subValues.get('offset').value*-100))/200;
        //     noteData.alpha *=(1-hmult)*currentValue;
        // } 
        // else if (curPos < end)
        // {
        //     noteData.alpha *=(1-currentValue);
        // }
    }
}
class HiddenModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('noglow', new ModifierSubValue(1.0)); //by default 1
        subValues.set('start', new ModifierSubValue(5.0));
        subValues.set('end', new ModifierSubValue(3.0));
        subValues.set('offset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var a:Float = FlxMath.remapToRange(curPos, (subValues.get('start').value*-100) + (subValues.get('offset').value*-100), 
            (subValues.get('end').value*-100) + (subValues.get('offset').value*-100), 0, 1);
        a = FlxMath.bound(a, 0, 1);

        if (subValues.get('noglow').value >= 1.0)
        {
            noteData.alpha -= a*currentValue;
            return;
        }

        a *= currentValue;

        if (subValues.get('noglow').value < 0.5)
        {
            var stealthGlow:Float = a*2;
            noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); //clamp
        }

        var substractAlpha:Float = FlxMath.bound((a-0.5)*2, 0, 1);
        noteData.alpha -= substractAlpha;


        // if (curPos > ((subValues.get('offset').value*-100)-100))
        // {
        //     var hmult = (curPos-(subValues.get('offset').value*-100))/200;
        //     noteData.alpha *=(1-hmult);
        // }
    }
}
class VanishModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('noglow', new ModifierSubValue(1.0)); //by default 1
        subValues.set('start', new ModifierSubValue(4.75));
        subValues.set('end', new ModifierSubValue(1.25));
        subValues.set('offset', new ModifierSubValue(0.0));
        subValues.set('size', new ModifierSubValue(1.95));

        // subValues.set('offsetIn', new ModifierSubValue(1.0));
        // subValues.set('offsetOut', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var midPoint:Float = (subValues.get('start').value*-100) + (subValues.get('offset').value*-100);
        midPoint/=2;

        var sizeThingy:Float = (subValues.get('size').value*100)/2;

        var a:Float = FlxMath.remapToRange(curPos, 
           ( subValues.get('start').value*-100) + (subValues.get('offset').value*-100),
            midPoint + sizeThingy + (subValues.get('offset').value*-100), 0, 1);

        a = FlxMath.bound(a, 0, 1);

        var b:Float = FlxMath.remapToRange(curPos, 
            midPoint - sizeThingy + (subValues.get('offset').value*-100),
            (subValues.get('end').value*-100) + (subValues.get('offset').value*-100), 0, 1);

        b = FlxMath.bound(b, 0, 1);

        var result:Float = a - b;

        if (subValues.get('noglow').value >= 1.0)
        {
            noteData.alpha -= result*currentValue;
            return;
        }

        result *= currentValue;

        if (subValues.get('noglow').value < 0.5)
        {
            var stealthGlow:Float = result*2;
            noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); //clamp
        }

        var substractAlpha:Float = FlxMath.bound((result-0.5)*2, 0, 1);
        noteData.alpha -= substractAlpha;



        // if (curPos <= (subValues.get('offsetOut').value*-100) && curPos >= ((subValues.get('offsetOut').value*-100)-200))
        // {
        //     var hmult = -(curPos-(subValues.get('offsetOut').value*-100))/200;
        //     noteData.alpha *=(1-hmult)*currentValue;
        // }
        // else if (curPos > ((subValues.get('offsetIn').value*-100)-100))
        // {
        //     var hmult = (curPos-(subValues.get('offsetIn').value*-100))/200;
        //     noteData.alpha *=(1-hmult);
        // }
        // else if (curPos < ((subValues.get('offsetOut').value*-100)-100))
        // {
        //     noteData.alpha *=(1-currentValue);
        // }
    }
}
class BlinkModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('noglow', new ModifierSubValue(1.0)); //by default 1
        subValues.set('offset', new ModifierSubValue(0.0));

        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var a:Float = FlxMath.fastSin((Modifier.beat + (subValues.get('offset').value*-100))*subValues.get('speed').value* Math.PI)*2;
        a = FlxMath.bound(a, 0, 1);

        if (subValues.get('noglow').value >= 1.0)
        {
            noteData.alpha -= a*currentValue;
            return;
        }

        a *= currentValue;

        if (subValues.get('noglow').value < 0.5)
        {
            var stealthGlow:Float = a*2;
            noteData.stealthGlow += FlxMath.bound(stealthGlow, 0, 1); //clamp
        }

        var substractAlpha:Float = FlxMath.bound((a-0.5)*2, 0, 1);
        noteData.alpha -= substractAlpha;

        // noteData.alpha *=(1-(currentValue*FlxMath.fastSin(((Conductor.songPosition*0.001)*(subValues.get('speed').value*10)))));
    }
}


class InvertModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += ModifierMath.Invert(lane) * currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class FlipModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += NoteMovement.arrowSizes[lane] * ModifierMath.Flip(lane) * currentValue;
        noteData.x -= NoteMovement.arrowSizes[lane] * currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class MiniModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 1.0;
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var col = (lane%NoteMovement.keyCount);
        var daswitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = -1;

        var midFix = false;
        if (instance != null)
            if (ModchartUtil.getMiddlescroll(instance))
                midFix = true;
        //noteData.x -= (NoteMovement.arrowSizes[lane]-(NoteMovement.arrowSizes[lane]*currentValue))*col;

        //noteData.x += (NoteMovement.arrowSizes[lane]*currentValue*NoteMovement.keyCount*0.5);
        noteData.scaleX *= currentValue;
        noteData.scaleY *= currentValue;
        noteData.x -= ((NoteMovement.arrowSizes[lane]/2)*(noteData.scaleX-NoteMovement.defaultScale[lane]));
        noteData.y += daswitch * ((NoteMovement.arrowSizes[lane]/2)*(noteData.scaleY-NoteMovement.defaultScale[lane]));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class ShrinkModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scaleMult = 1 + (curPos*0.001*currentValue);
        noteData.scaleX *= scaleMult;
        noteData.scaleY *= scaleMult;
    }
}


class BeatXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value)));
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
        noteData.skewY += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class BeatSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * ModifierMath.Beat(curPos, subValues.get('speed').value, subValues.get('mult').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}


class BounceXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
    }
}
class BounceYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var daswitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = -1;
        noteData.y += (currentValue * daswitch) * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
    }
}
class BounceZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
    }
}
class BounceAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
    }
}
class BounceScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * NoteMovement.arrowSizes[lane] * Math.abs(FlxMath.fastSin(curPos*0.005*subValues.get('speed').value))));
        noteData.scaleY *= (1+((currentValue*0.01) * NoteMovement.arrowSizes[lane] * Math.abs(FlxMath.fastSin(curPos*0.005*subValues.get('speed').value))));
    }
}
class BounceScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * NoteMovement.arrowSizes[lane] * Math.abs(FlxMath.fastSin(curPos*0.005*subValues.get('speed').value))));
    }
}
class BounceScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * NoteMovement.arrowSizes[lane] * Math.abs(FlxMath.fastSin(curPos*0.005*subValues.get('speed').value))));
    }
}
class BounceSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
        noteData.skewY += currentValue * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
    }
}
class BounceSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
    }
}
class BounceSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * ModifierMath.Bounce(lane, curPos, subValues.get('speed').value);
    }
}


class EaseCurveModifier extends Modifier
{
    public var easeFunc = ImprovedEases.linear;
    public function setEase(ease:String)
    {
        easeFunc = ModchartUtil.getFlxEaseByString(ease);
    }
}

class EaseCurveXModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveYModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveZModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveAngleModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveScaleModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (easeFunc(curPos*0.01)*currentValue*0.2);
        noteData.scaleY *= (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveScaleXModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveScaleYModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveSkewModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += (easeFunc(curPos*0.01)*currentValue*0.2);
        noteData.skewY += (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveSkewXModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}
class EaseCurveSkewYModifier extends EaseCurveModifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += (easeFunc(curPos*0.01)*currentValue*0.2);
    }
}


class InvertSineModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += ModifierMath.InvertSine(lane, curPos, pf, currentValue); //silly ah math
    }
}


class BoostModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('offset', new ModifierSubValue(1.0));
    }
    override function curPosMath(lane:Int, curPos:Float, pf:Int)
    {
        var yOffset:Float = 0;

        var speed = renderer.getCorrectScrollSpeed() * subValues.get('offset').value;

        var fYOffset = -curPos / speed;
        var fEffectHeight = FlxG.height;
        var fNewYOffset = fYOffset * 1.5 / ((fYOffset+fEffectHeight/1.2)/fEffectHeight);
        var fBrakeYAdjust = (currentValue) * (fNewYOffset - fYOffset);
        fBrakeYAdjust = FlxMath.bound(fBrakeYAdjust, -400, 400 ); //clamp
        
        yOffset -= fBrakeYAdjust*speed;

        return curPos+yOffset;
    }
}

class BrakeModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('offset', new ModifierSubValue(1.0));
    }
    override function curPosMath(lane:Int, curPos:Float, pf:Int)
    {
        var yOffset:Float = 0;

        var speed = renderer.getCorrectScrollSpeed() * subValues.get('offset').value;

        var fYOffset = -curPos / speed;
		var fEffectHeight = FlxG.height;
		var fScale = FlxMath.remapToRange(fYOffset, 0, fEffectHeight, 0, 1); //scale
		var fNewYOffset = fYOffset * fScale; 
		var fBrakeYAdjust = currentValue * (fNewYOffset - fYOffset);
		fBrakeYAdjust = FlxMath.bound( fBrakeYAdjust, -400, 400 ); //clamp
        
		yOffset -= fBrakeYAdjust*speed;

        return curPos+yOffset;
    }
}
class BoomerangModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    { 
        var scrollSwitch = -1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch *= -1;

        noteData.y += (FlxMath.fastSin((curPos/-700)) * 400 + (curPos/3.5))*scrollSwitch * (-currentValue);
        noteData.alpha *= FlxMath.bound(1-(curPos/-600-3.5), 0, 1);
    }
    override function curPosMath(lane:Int, curPos:Float, pf:Int)
    {
        return curPos * 0.75;
    }
}
class WaveingModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    { 
        var distance = curPos * 0.01;
        noteData.y += (FlxMath.fastSin(distance*0.3)*50) * currentValue; //don't mind me i just figured it out
    }
    override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    {
        return noteDist * (0.4+((FlxMath.fastSin(curPos*0.007)*0.1) * currentValue));
    }
}

class JumpModifier extends Modifier //custom thingy i made //ended just being driven OMG LMAO
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        var beatVal = Modifier.beat - Math.floor(Modifier.beat); //should give decimal

        var scrollSwitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch = -1;

        

        noteData.y += (beatVal*(Conductor.stepCrochet*currentValue))*renderer.getCorrectScrollSpeed()*0.45*scrollSwitch;
    }
}
class JumpTargetModifier extends Modifier
{
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        var beatVal = Modifier.beat - Math.floor(Modifier.beat); //should give decimal

        var scrollSwitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch = -1;

        

        noteData.y += (beatVal*(Conductor.stepCrochet*currentValue))*renderer.getCorrectScrollSpeed()*0.45*scrollSwitch;
    }
}
class JumpNotesModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var beatVal = Modifier.beat - Math.floor(Modifier.beat); //should give decimal

        var scrollSwitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch = -1;

        

        noteData.y += (beatVal*(Conductor.stepCrochet*currentValue))*renderer.getCorrectScrollSpeed()*0.45*scrollSwitch;
    }
}
class DrivenModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSpeed = renderer.getCorrectScrollSpeed();

        var scrollSwitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch = -1;

        
        noteData.y += 0.45 * scrollSpeed * scrollSwitch * currentValue;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}

//here i add custom modifiers, why? well its to make some cool modcharts shits -Ed
class WaveXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.x += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.y += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveZModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.z += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveAngleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.angle += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveScaleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleX *= 260*(1+((currentValue*0.01)*ModifierMath.Wave(lane,subValues.get('speed').value)));
        noteData.scaleY *= 260*(1+((currentValue*0.01)*ModifierMath.Wave(lane,subValues.get('speed').value)));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveScaleXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleX *= 260*(1+((currentValue*0.01)*ModifierMath.Wave(lane,subValues.get('speed').value)));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveScaleYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleY *= 260*(1+((currentValue*0.01)*ModifierMath.Wave(lane,subValues.get('speed').value)));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveSkewModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.skewX += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
        noteData.skewY += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveSkewXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.skewX += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class WaveSkewYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.skewY += 260*currentValue*ModifierMath.Wave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}

class TimeStopModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('stop', new ModifierSubValue(0.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('continue', new ModifierSubValue(0.0));
    }
    override function curPosMath(lane:Int, curPos:Float, pf:Int)
    {
        if (curPos <= (subValues.get('stop').value*-1000))
            {
                curPos = (subValues.get('stop').value*-1000) + (curPos*(subValues.get('speed').value/100));
            }
        return curPos;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        if (curPos <= (subValues.get('stop').value*-1000))
        {
            curPos = (subValues.get('stop').value*-1000) + (curPos*(subValues.get('speed').value/100));
        } 
        else if (curPos <= (subValues.get('continue').value*-100))
        {
            var a = ((subValues.get('continue').value*100)-Math.abs(curPos))/((subValues.get('continue').value*100)+(subValues.get('stop').value*-1000));
        }else{
            //yep, nothing here lmao
        }
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
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
        noteData.angle += (currentValue*multiply);
        var laneShit = lane%NoteMovement.keyCount;
        var offsetThing = 0.5;
        var halfKeyCount = NoteMovement.keyCount/2;
        if (lane < halfKeyCount)
        {
            offsetThing = -0.5;
            laneShit = lane+1;
        }
        var distFromCenter = ((laneShit)-halfKeyCount)+offsetThing;
        noteData.x += -distFromCenter*NoteMovement.arrowSize;

        var q = SimpleQuaternion.fromEuler(90, 0, (currentValue * multiply)); //i think this is the right order???
        noteData.x += q.x * distFromCenter*NoteMovement.arrowSize;
        noteData.y += q.y * distFromCenter*NoteMovement.arrowSize;
        noteData.z += q.z * distFromCenter*NoteMovement.arrowSize;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        // noteData.angle += (subValues.get('y').value/2);
        noteMath(noteData, lane, 0, pf);
    }
    override function incomingAngleMath(lane:Int, curPos:Float, pf:Int)
    {
        return [0, currentValue*-1];
    }
    override function reset()
    {
        super.reset();
        currentValue = 0; //the code that stop the mod from running gets confused when it resets in the editor i guess??
    }
}


class EaseXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseZModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseAngleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseScaleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Ease(lane,subValues.get('speed').value)));
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Ease(lane,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseScaleXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * ModifierMath.Ease(lane,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseScaleYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * ModifierMath.Ease(lane,subValues.get('speed').value)));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseSkewModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);

        noteData.skewY += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseSkewXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class EaseSkewYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * ModifierMath.Ease(lane,subValues.get('speed').value);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}

class YDModifier extends Modifier 
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
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}


class SkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));
        subValues.set('xDmod', new ModifierSubValue(0.0));
        subValues.set('yDmod', new ModifierSubValue(0.0));
        currentValue = 1.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var daswitch = -1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = 1;

        noteData.skewX += subValues.get('x').value * daswitch;
        noteData.skewY += subValues.get('y').value * daswitch;

        noteData.skewX += subValues.get('xDmod').value * daswitch;
        noteData.skewY += subValues.get('yDmod').value * daswitch;
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
class SkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var daswitch = -1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = 1;
        noteData.skewX += currentValue * daswitch;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}
class SkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var daswitch = -1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = 1;
        noteData.skewY += currentValue * daswitch;
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}


class DizzyModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('forced', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        if (subValues.get('forced').value >= 0.5) noteData.angle += currentValue*(Conductor.songPosition*0.001);
        else noteData.angle += currentValue*curPos;
    }
}


class NotesModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));
        subValues.set('yD', new ModifierSubValue(0.0));
        subValues.set('angle', new ModifierSubValue(0.0));
        subValues.set('z', new ModifierSubValue(0.0));
        subValues.set('skewx', new ModifierSubValue(0.0));
        subValues.set('skewy', new ModifierSubValue(0.0));
        subValues.set('invert', new ModifierSubValue(0.0));
        subValues.set('flip', new ModifierSubValue(0.0));
    }

    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var daswitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = -1;

        noteData.x += subValues.get('x').value;
        noteData.y += subValues.get('y').value;
        noteData.y += subValues.get('yD').value * daswitch;
        noteData.angle += subValues.get('angle').value;
        noteData.z += subValues.get('z').value;
        noteData.skewX += subValues.get('skewx').value * -daswitch;
        noteData.skewY += subValues.get('skewy').value * -daswitch;

        noteData.x += ModifierMath.Invert(lane) * subValues.get('invert').value;

        noteData.x += NoteMovement.arrowSizes[lane] * ModifierMath.Flip(lane) * subValues.get('flip').value;
        noteData.x -= NoteMovement.arrowSizes[lane] * subValues.get('flip').value;
    }

    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
}
class LanesModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));
        subValues.set('yD', new ModifierSubValue(0.0));
        subValues.set('angle', new ModifierSubValue(0.0));
        subValues.set('z', new ModifierSubValue(0.0));
        subValues.set('skewx', new ModifierSubValue(0.0));
        subValues.set('skewy', new ModifierSubValue(0.0));
    }

    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        var daswitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = -1;

        noteData.x += subValues.get('x').value;
        noteData.y += subValues.get('y').value;
        noteData.y += subValues.get('yD').value * daswitch;
        noteData.angle += subValues.get('angle').value;
        noteData.z += subValues.get('z').value;
        noteData.skewX += subValues.get('skewx').value * -daswitch;
        noteData.skewY += subValues.get('skewy').value * -daswitch;
    }

    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
}
class StrumsModifier extends Modifier
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));
        subValues.set('yD', new ModifierSubValue(0.0));
        subValues.set('angle', new ModifierSubValue(0.0));
        subValues.set('z', new ModifierSubValue(0.0));
        subValues.set('skewx', new ModifierSubValue(0.0));
        subValues.set('skewy', new ModifierSubValue(0.0));
        subValues.set('invert', new ModifierSubValue(0.0));
        subValues.set('flip', new ModifierSubValue(0.0));
    }

    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var daswitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                daswitch = -1;

        noteData.x += subValues.get('x').value;
        noteData.y += subValues.get('y').value;
        noteData.y += subValues.get('yD').value * daswitch;
        noteData.angle += subValues.get('angle').value;
        noteData.z += subValues.get('z').value;
        noteData.skewX += subValues.get('skewx').value * -daswitch;
        noteData.skewY += subValues.get('skewy').value * -daswitch;

        noteData.x += ModifierMath.Invert(lane) * subValues.get('invert').value;

        noteData.x += NoteMovement.arrowSizes[lane] * ModifierMath.Flip(lane) * subValues.get('flip').value;
        noteData.x -= NoteMovement.arrowSizes[lane] * subValues.get('flip').value;
    }

    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
    
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}


class TanDrunkXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));

        noteData.scaleY *= (1+((currentValue*0.01) * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));

        noteData.skewY += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class TanDrunkSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * (Math.tan( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}


class TanWaveXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.x += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.y += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveZModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.z += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveAngleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.angle += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveScaleModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleX *= 260*(1+((currentValue*0.01)*ModifierMath.TanWave(lane,subValues.get('speed').value)));
        noteData.scaleY *= 260*(1+((currentValue*0.01)*ModifierMath.TanWave(lane,subValues.get('speed').value)));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveScaleXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleX *= 260*(1+((currentValue*0.01)*ModifierMath.TanWave(lane,subValues.get('speed').value)));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveScaleYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.scaleY *= 260*(1+((currentValue*0.01)*ModifierMath.TanWave(lane,subValues.get('speed').value)));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveSkewModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.skewX += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
        noteData.skewY += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveSkewXModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.skewX += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}
class TanWaveSkewYModifier extends Modifier 
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteData.skewY += 260*currentValue*ModifierMath.TanWave(lane,subValues.get('speed').value);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData,lane,pf);
    }
}


class TwirlModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('forced', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        //noteData.scaleX *=(0+(currentValue*FlxMath.fastCos(((curPos*0.001)*(5*subValues.get('speed').value)))));
        if (subValues.get('forced').value >= 0.5) noteData.angleX += (Conductor.songPosition*0.001) * currentValue;
        else noteData.angleY += (curPos / 2.0) * currentValue;
    }
}
class RollModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('forced', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        //noteData.scaleY *=(0+(currentValue*FlxMath.fastCos(((curPos*0.001)*(5*subValues.get('speed').value)))));
        if (subValues.get('forced').value >= 0.5) noteData.angleY += (Conductor.songPosition*0.001) * currentValue;
        else noteData.angleX += (curPos / 2.0) * currentValue;
    }
}


class CosecantXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    public static function cosecant(angle:Null<Float>):Float
    {
        return 1 / Math.sin(angle);
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += currentValue * (cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += currentValue * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += currentValue * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += currentValue * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));

        noteData.scaleY *= (1+((currentValue*0.01) * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+((currentValue*0.01) * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+((currentValue*0.01) * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value))));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));

        noteData.skewY += currentValue * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += currentValue * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}
class CosecantSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('period', new ModifierSubValue(1.0));
        subValues.set('offset', new ModifierSubValue(1.0));
        subValues.set('spacing', new ModifierSubValue(1.0));
        subValues.set('speed', new ModifierSubValue(1.0));
        subValues.set('size', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += currentValue * (CosecantXModifier.cosecant( ((Conductor.songPosition*(0.001*subValues.get('period').value)) + ((lane%NoteMovement.keyCount)*0.2) + 
        (curPos*(0.225*subValues.get('offset').value))*((subValues.get('spacing').value*10)/FlxG.height)) * 
        (subValues.get('speed').value*0.2)) * Note.swagWidth*(0.5*subValues.get('size').value));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf); //just reuse same thing
    }
}


class ShakyNotesModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += FlxMath.fastSin(500)+currentValue * (Math.cos(Conductor.songPosition * 4*0.2) + ((lane%NoteMovement.keyCount)*0.2) - 0.002)
        * (Math.sin(100 - (120 * subValues.get('speed').value * 0.4))) /** (BeatXModifier.getShift(noteData, lane, curPos, pf) / 2)*/;
        
        noteData.y += FlxMath.fastSin(500)+currentValue * (Math.cos(Conductor.songPosition * 8*0.2) + ((lane%NoteMovement.keyCount)*0.2) - 0.002)
        * (Math.sin(100 - (120 * subValues.get('speed').value * 0.4))) /** (BeatXModifier.getShift(noteData, lane, curPos, pf) / 2)*/;
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
        noteData.x += FlxMath.fastSin(0.1)*(currentValue * FlxG.random.int(1, 20));
        noteData.y += FlxMath.fastSin(0.1)*(currentValue * FlxG.random.int(1, 20));
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {
        noteMath(noteData, lane, 0, pf);
    }
}


class TornadoModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetX = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetX = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetX;
        
        noteData.x += offsetX * currentValue;
    }
}
class TornadoYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetY = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetY = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetY;
        
        noteData.y += offsetY * currentValue;
    }
}
class TornadoZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetZ = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;
        
        noteData.z += offsetZ * currentValue;
    }
}
class TornadoAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetAngle = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.angle += offsetAngle * currentValue;
    }
}
class TornadoScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetScale = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.scaleX *= (1+((currentValue*0.01)*offsetScale));
        noteData.scaleY *= (1+((currentValue*0.01)*offsetScale));
    }
}
class TornadoScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetScale = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.scaleX *= (1+((currentValue*0.01)*offsetScale));
    }
}
class TornadoScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetScale = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.scaleY *= (1+((currentValue*0.01)*offsetScale));
    }
}
class TornadoSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetSkew = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.skewX += offsetSkew * currentValue;
        noteData.skewY += offsetSkew * currentValue;
    }
}
class TornadoSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetSkew = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.skewX += offsetSkew * currentValue;
    }
}
class TornadoSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.cos(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetSkew = (-Math.cos((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.skewY += offsetSkew * currentValue;
    }
}

class TanTornadoModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetX = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.x += offsetX * currentValue;
    }
}
class TanTornadoYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetY = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.y += offsetY * currentValue;
    }
}
class TanTornadoZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetZ = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.z += offsetZ * currentValue;
    }
}
class TanTornadoAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetAngle = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.angle += offsetAngle * currentValue;
    }
}
class TanTornadoScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetScale = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.scaleX *= (1+((currentValue*0.01)*offsetScale));
        noteData.scaleY *= (1+((currentValue*0.01)*offsetScale));
    }
}
class TanTornadoScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetScale = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.scaleX *= (1+((currentValue*0.01)*offsetScale));
    }
}
class TanTornadoScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetScale = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.scaleY *= (1+((currentValue*0.01)*offsetScale));
    }
}
class TanTornadoSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetSkew = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.skewX += offsetSkew * currentValue;
        noteData.skewY += offsetSkew * currentValue;
    }
}
class TanTornadoSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetSkew = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.skewX += offsetSkew * currentValue;
    }
}
class TanTornadoSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('speed', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {

        // thank you 4mbr0s3 & andromeda for the modifier lol -- LETS GOOOO FINALLY I FIGURED IT OUT
        var playerColumn = lane % NoteMovement.keyCount;
        var columnPhaseShift = playerColumn * Math.PI / 3;
        var phaseShift = (curPos / 135 ) * subValues.get('speed').value * 0.2;
        var returnReceptorToZeroOffsetZ = (-Math.tan(-columnPhaseShift) + 1) / 2 * Note.swagWidth * 3;
        var offsetSkew = (-Math.tan((phaseShift - columnPhaseShift)) + 1) / 2 * Note.swagWidth * 3 - returnReceptorToZeroOffsetZ;

        noteData.skewY += offsetSkew * currentValue;
    }
}


class ParalysisModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('amplitude', new ModifierSubValue(1.0));
    }
    override function curPosMath(lane:Int, curPos:Float, pf:Int)
    {
        var beat = (Conductor.songPosition/Conductor.crochet/2);
        var fixedperiod = (Math.floor(beat)*Conductor.crochet*2);
        var strumTime = (Conductor.songPosition - (curPos / PlayState.SONG.speed));
        return ((fixedperiod - strumTime)*PlayState.SONG.speed/4)*subValues.get('amplitude').value;
    }  
}


class ZigZagXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.x += result*currentValue;
    }
}
class ZigZagYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.y += result*currentValue;
    }
}
class ZigZagZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.z += result*currentValue;
    }
}
class ZigZagAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.angle += result*currentValue;
    }
}
class ZigZagScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.scaleX *= (1+(result*(currentValue*0.01)));
        noteData.scaleY *= (1+(result*(currentValue*0.01)));
    }
}
class ZigZagScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.scaleX *= (1+(result*(currentValue*0.01)));
    }
}
class ZigZagScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.scaleY *= (1+(result*(currentValue*0.01)));
    }
}
class ZigZagSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.skewX += result*currentValue;
        noteData.skewY += result*currentValue;
    }
}
class ZigZagSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.skewX += result*currentValue;
    }
}
class ZigZagSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        var mm:Float = mult * 2;
        var ppp:Float = Math.abs(curPos*0.45) + (mult/2);
        var funny:Float = (ppp + mult) % mm;
        var result:Float = funny - mult;

        if (ppp % mm * 2 >= mm) result *= -1;
        result -= mult/2;

        noteData.skewY += result*currentValue;
    }
}


class SawToothXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.x += ((curPos*0.45) % mult/2) * currentValue;
    }
}
class SawToothYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.y += ((curPos*0.45) % mult/2) * currentValue;
    }
}
class SawToothZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.z += ((curPos*0.45) % mult/2) * currentValue;
    }
}
class SawToothAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.angle += ((curPos*0.45) % mult/2) * currentValue;
    }
}
class SawToothScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.scaleX *= (1+(((curPos*0.45) % mult/2) * (currentValue*0.01)));
        noteData.scaleY *= (1+(((curPos*0.45) % mult/2) * (currentValue*0.01)));
    }
}
class SawToothScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.scaleX *= (1+(((curPos*0.45) % mult/2) * (currentValue*0.01)));
    }
}
class SawToothScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.scaleY *= (1+(((curPos*0.45) % mult/2) * (currentValue*0.01)));
    }
}
class SawToothSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.skewX += ((curPos*0.45) % mult/2) * currentValue;
        noteData.skewY += ((curPos*0.45) % mult/2) * currentValue;
    }
}
class SawToothSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.skewX += ((curPos*0.45) % mult/2) * currentValue;
    }
}
class SawToothSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var mult:Float = NoteMovement.arrowSizes[lane] * subValues.get('mult').value;
        noteData.skewY += ((curPos*0.45) % mult/2) * currentValue;
    }
}


class SquareXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.x += squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
    }
    public static function squareMath(curPos:Float, mult:Float, timeOffset:Float, xOffset:Float, lane:Int):Float
    {
        var mult:Float = mult / (NoteMovement.arrowSizes[lane]);
        var timeOffset:Float = timeOffset;
        var xOffset:Float = xOffset;
        var xVal:Float = FlxMath.fastSin(((curPos*0.45) + timeOffset) * Math.PI * mult);
        xVal = Math.floor(xVal) + 0.5 + xOffset;

        return xVal * NoteMovement.arrowSizes[lane];
    }
}
class SquareYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.y += SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
    }
}
class SquareZModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.z += SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
    }
}
class SquareAngleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.angle += SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
    }
}
class SquareScaleModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+(SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * (currentValue*0.01)));
        noteData.scaleY *= (1+(SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * (currentValue*0.01)));
    }
}
class SquareScaleXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleX *= (1+(SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * (currentValue*0.01)));
    }
}
class SquareScaleYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.scaleY *= (1+(SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * (currentValue*0.01)));
    }
}
class SquareSkewModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
        noteData.skewY += SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
    }
}
class SquareSkewXModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewX += SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
    }
}
class SquareSkewYModifier extends Modifier
{
    override function setupSubValues()
    {
        subValues.set('mult', new ModifierSubValue(1.0));
        subValues.set('yoffset', new ModifierSubValue(0.0));
        subValues.set('xoffset', new ModifierSubValue(0.0));
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.skewY += SquareXModifier.squareMath(curPos, subValues.get('mult').value, subValues.get('yoffset').value, subValues.get('xoffset').value, lane) * currentValue;
    }
}

class CenterModifier extends Modifier
{
    var differenceBetween:Float = 0;
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        var screenCenter:Float = (FlxG.height/2) - (NoteMovement.arrowSizes[lane]/2);
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
        var screenCenter:Float = (FlxG.height/2) - (NoteMovement.arrowSizes[lane]/2);
        var differenceBetween:Float = noteData.y - screenCenter;
       noteData.y -= currentValue * differenceBetween;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
}

class SpiralHoldsModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.spiralHold += currentValue;
    }
}

class AttenuateModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.x += newPos * curVal * p;
        noteData.x += curVal * p *0.5;
    }
}
class AttenuateYModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
        if (instance != null)
            if (ModchartUtil.getDownscroll(instance))
                scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.y += newPos * curVal * p;
        noteData.y += curVal * p *0.5;
    }
}
class AttenuateZModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.z += newPos * curVal * p;
        noteData.z += curVal * p *0.5;
    }
}
class AttenuateAngleModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.angle += newPos * curVal * p;
        noteData.angle += curVal * p *0.5;
    }
}
class AttenuateScaleModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.scaleX *= 1+(newPos * curVal * p);
        noteData.scaleX *= 1+(curVal * p *0.1);

        noteData.scaleY *= 1+(newPos * curVal * p);
        noteData.scaleY *= 1+(curVal * p *0.1);
    }
}
class AttenuateScaleXModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.scaleX *= 1+(newPos * curVal * p);
        noteData.scaleX *= 1+(curVal * p * 0.1);
    }
}
class AttenuateScaleYModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.scaleY *= 1+(newPos * curVal * p);
        noteData.scaleY *= 1+(curVal * p * 0.1);
    }
}
class AttenuateSkewModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.skewX += newPos * curVal * p;
        noteData.skewX += curVal * p *0.5;

        noteData.skewY += newPos * curVal * p;
        noteData.skewY += curVal * p *0.5;
    }
}
class AttenuateSkewXModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.skewX += newPos * curVal * p;
        noteData.skewX += curVal * p *0.5;
    }
}
class AttenuateSkewYModifier extends Modifier
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        var scrollSwitch = 1;
            if (instance != null)
                if (ModchartUtil.getDownscroll(instance))
                    scrollSwitch *= -1;
        var nd = lane % NoteMovement.keyCount;
        var newPos = FlxMath.remapToRange(nd,0,NoteMovement.keyCount,NoteMovement.keyCount*-1*0.5,NoteMovement.keyCount*0.5);

        var p = curPos * scrollSwitch;
        p = (p * p) * 0.1;

        var curVal = currentValue * 0.0015;

        noteData.skewY += newPos * curVal * p;
        noteData.skewY += curVal * p *0.5;
    }
}

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



class ArrowPathAlphaModifier extends Modifier //used but unstable (as old way)
{
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        noteData.arrowPathAlpha *= 1-currentValue;
    }
}

// class LongHoldsModifier extends Modifier //unused
// {
//     override function setupSubValues()
//     {
//         baseValue = 1.0;
//         currentValue = 1.0;
//     }
//     override function curPosMath(lane:Int, curPos:Float, pf:Int)
//     {
//         if (notes.members[lane].isSustainNote) 
//             return curPos * currentValue;
//         else
//             return curPos;

//         //if else then nothing??
//     }
// }

//OH MY FUCKING GOD, thanks to @noamlol for the code of this thing//
class ArrowPath extends Modifier
{
    public var _path:List<TimeVector> = null;
    public var _pathDistance:Float = 0;

    override public function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int) {
        if (Paths.fileExists("data/"+PlayState.SONG.song.toLowerCase()+"/customMods/path"+subValues.get('path').value+".txt", TEXT)){
            var newPosition = executePath(0, (curPos*0.45), lane, lane < 4 ? 0 : 1, new Vector4(noteData.x, noteData.y, noteData.z, 0), "data/"+PlayState.SONG.song.toLowerCase()+"/customMods/path"+subValues.get('path').value+".txt");
            noteData.x = newPosition.x;
            noteData.y = newPosition.y;
            noteData.z = newPosition.z;
        }
    }
    override function setupSubValues()
    {
        subValues.set('x', new ModifierSubValue(0.0));
        subValues.set('y', new ModifierSubValue(0.0));
        subValues.set('path', new ModifierSubValue(0.0));
        currentValue = 1.0;
        baseValue = 0.0;
    }
    override function incomingAngleMath(lane:Int, curPos:Float, pf:Int)
    {
        return [subValues.get('x').value, subValues.get('y').value];
    }
    override function reset()
    {
        super.reset();
        currentValue = 1.0; //the code that stop the mod from running gets confused when it resets in the editor i guess??
        baseValue = 0.0;
    }
    public var firstPath:String = "";
    public function loadPath() {
        var file = CoolUtil.coolTextFile(Paths.modFolders("data/"+PlayState.SONG.song.toLowerCase()+"/customMods/path"+subValues.get('path').value+".txt"));
        var file2 = CoolUtil.coolTextFile(Paths.getPreloadPath("data/"+PlayState.SONG.song.toLowerCase()+"/customMods/path"+subValues.get('path').value+".txt"));

        var filePath = null;
        if (file != null) {
            filePath = file;
        }else if (file2 != null) {
            filePath = file2;
        }else{
            return;
        }

        firstPath = "data/"+PlayState.SONG.song.toLowerCase()+"/customMods/path"+subValues.get('path').value+".txt";

        // trace(filePath);

        var path = new List<TimeVector>();
        var _g = 0;
        while (_g < filePath.length) {
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

    public function calculatePathDistances(path:List<TimeVector>): Float {
        @:privateAccess 
        var iterator_head = path.h;
        var val = iterator_head.item;
        iterator_head = iterator_head.next;
        var last = val;
        last.startDist = 0;
        var dist = 0.0;
        while (iterator_head != null) {
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

    public function getPointAlongPath(distance: Float): TimeVector {
        @:privateAccess 
        var _g_head = this._path.h;
        while (_g_head != null) {
            var val = _g_head.item;
            _g_head = _g_head.next;
            var vec = val;
            var Min = vec.startDist;
            var Max = vec.endDist;
            // looks like a FlxMath function could be that
            if ((Min == 0 || distance >= Min) && (Max == 0 || distance <= Max) && vec.next != null) {
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
    public function executePath(currentBeat, strumTimeDiff:Float, column, player, pos, fp:String): Vector4 {
        if (_path == null || (firstPath != fp && _path != null)) {
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

    public function getPercent(player: Int): Float {
        return 1;
    }

    public function getOtherPercent(modName: String, player: Int): Float {
        return 1;
    }
}

/*
class MegaMindModifier extend Modifier
    trace("
......................................................................................................................................................                                                                                             
......................................................................................................................................................                                                                                          
......................................................................................................................................................
......................................................................................................................................................
......................................................................................................................................................
:::::.................................................................................................................................................
::::::................................................................................................................................................
::::::::::.......................................::::::...............................................................................................
:::::::::::::................................:::::::..................................................................................................
::::::::::::::::...........................:::::......................................................................................................
::::::::::::::::::......................:::::..::::::...........................................::....................................................
:::::::::::::::::::::................::::::::::::::::.............................................::..................................................
:::::::::::::::::::::::::..........::::::::::::::::.............................................::::::................................................
:::::::::::::::::::::::::::::::::::::::::::::::::::............................................:::::::::..............................................
:::::::::::::::::::::::::::::::::::::::::::::::::::::..........................................::::::::::.............................................
:::::::::::::::::::::::::::::::::::::::::::::::::::::::.................................:::...::::::::::::............................................
::::::::::::::::::::::::::::::::::::::::::::::::::::::::................................:::::::::::::::::::...........................................
:::::::::::::::::::::::::::::::::::::-::::::::::::::::::::..............................::::::::::::::::::::..........................................
:::::::::::::::::::::::::::::::::::::--:::::::::::::::::::::::::........................:::::::::::::::::::::.........................................
::::::::::::::::::::::::::::::::::::----::::::::::::::::::::::::::...................:::::::::::::::::::::::::........................................
:::::::::::::::::::::::::::::::::::-------:::::::::::::::::::::::::::................:::::::::::::::::::::::::........................................
::::::::::::::::::::::::::::::::::--------:::::::::::::::::::::::::::::::............:::::::::::::::::-::::::::.......................................
::::::::::::::::::::::::::::::::::--------::::::::::::::::::::::::::::::::::::::::...:::::::::::::::::--:::::-::......................................
:::::::::::::::::::::::::::::::::---------::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::---:::::-:.................::::::::.............
:::::::::::::::::::::::::::::::::----------:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::----::::-::::::...........::::::::::::::::::::::
:::::::::::::::::::::::::::::::::----------:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::------::=:::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::-----------:::::::::::::::::::::::::::::::::::::::::::::::::::::::::-------:-=:::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::-------=---::::::::::::::::::::::::::::::::::::::::::::::::::::::::-------:-=:::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::------------::::::::::::::::::::::::::::::::::::::::::::::::::::::--------:-=:::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::------===----:::::::::::::::::::::::::::::::::::::::::::::::::::::-==------==:::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::---=---==------:::::::::::::::::::::::::::::::::::::::::::::::::::-==------+=:::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::----==---=-------:::::::::::::::::::::::::::::::::::::::::::::::::--==------*-:::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::-----==--=---------::::::::::::::::::::::::::::::::::::::::::::::--===-----=+::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::-----=====-----------:::::::::::::::::::::::::::::::::::::::-:::--=====---=++::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::--------==--=======----------:::::::::::::::::::::::::::::::::::--------=+====---=*-::::::::::::::::::::::::::::::::::::::::
:::::::::::::::-:::---------==++**#*--====+===-----=----:::::::::::::::::::::::::::::::::---------=+====--=++--=--::::::::::::::::::::::::::::::::::::
:::::::::::-----------===++++++++*##======+++====--------:::::::::::::::::::::::::::::::----------=++===-=+#**+==----==--:::::::::::::::::::::::::::::
::::::--------========++++**++**###%%===+++++====--------::::::::::::::::::::::::::::::----====--===+====+#****+==---=--===---::::::::::::::::::::::::
--------============++++++++*+***###%*==+++++======---------::::::::::::::::::::::::::-----======++=====+*#****+======-==--------:::::::::::::::::::::
======-==-=========+++++++++****####%@*==++++===+=====----------::::::::::::::::::::::--============+==++%#****+===--==--------------:::::::::::::::::
====================++++++++*##*##%#%@%===+++++++=======--------:::::::::::::::::::::---=========++++=+*%#####*+=------------------===---:::::::::::::
=====================++++++****####+*%@*-=++++++==-----===-------::--:::::::------:-:-----=====+++*+=+*%@##%#*++==-------------------=------::::::::::
======================++++******##====+#+=++++=++=====---------------------------------=++****==++++=+%@%*+##*++====-------------------=====----::::::
===++================++++***#*#**++**#*+*+=*++*#%%%#####*++==----------------------=++*#%%%##%%#*+*+=*@#+=-+***++====-=-----------------========---:::
====++================+++****#***==++#%%*+++++**+===+*#%%%%%%#*+=-=---------=++***%%%%##*+====++++*++++***=-***+++=====---==-------------===========--
========================++++*****+===+*##++====----+*##***#%%%%%##*+=-----==*%@@%%%#%#**#%##*+====+*+=***+*=++++++======---=-----=====----====+==++++=
=========================++++****#==--=++++===-----=+***+==+++=*#*#*=--::-=+*###*==-==++*#**+=--==+*==++===+=+++++=====--=--=------===================
---======================++++++***#=----==*+==-------===--==++++++**+-:::-=+*+=--===-=====+=----==*#===---=--+++=+===========----------===============
-------===================+*+++***##*===*%#*++=------------------=++=-::-==*++--::---------::--===**===-----=++++=============-==---==================
--------==================++*+++****##+==*#**+++=---------------==++=----=++++=-::::::::::::---==+%*=+---==**+++==============-=======================
----------======++======+++++**+****#%%+==+%#*++++=-------------=++++=---=*+++==--------:-----==+#%*#*===*###*++====================-------====++=====
-------=====-=====+++====+*+++*+****##%%#+*@@%#*+++==----------==++++=---+**++==-------------=+*#%*=--=*##****+=++===============----------------=+**+
-----------==+++===++++===++**+++****##%#%@@@%%%#*+++=---------=++**+=-==+***++===---------==+*%%%==**##******++=======-======-----------------------+
----------------=++++++++++=++++++***#####%@%%%%%#*++++====--==++***+=-==+***++====-------=+*#%%#%#*####***#*++=============--------------------------
--------------------==++++++==++*****####%%%###%%##*+++++=======+*##+----++**#+====-----==+*###**%%###***##*+++===========----------------------------
=====------------------=++++++++*##**###%#%%##*####**++++=======*+**+===+**+++*==--=====++*###*+*%%%#*##***++++========-------------------------------
==-----------------------=+++++++**#*##%%#%@#****##***+++====---+**#****####**+==-=====+***##+++*%%#*#%#*+++++===+===---------------------------------
=------=========-----------=++++++**###%##%@%#*+++*****++++====--===--=++=============++*###+==+*%%#**#***++++=+==+=----------------------------------
===================---------=+++++++*#%##%%@%#**+==+*#**++++========--=======++=======+*##*++==+*%%###**#**++++=++=-----------------------------------
========================-----=+*++***##%#%@@%***+===+###*++++=======++==+++++++===+===*###*++==+*%%%%###****+++*+=------------------------------------
===============================+#*+**#%%@@@%*%**++==+*%%*++++++++*#######%#******+*++=*%#*+++=+*#@%%%%#****++**+=-------------------------------------
=================================#*+**%@@@@%*%%**+===+#%#*+++*#%%%%%%%%%%%%##%#%%@%*==*%#*++++*##@%%%%#***++**====------------------------------------
==================================#**#%%@@@%+*#%#+++==*##**++++**+++===+++++**##**==-+#%*+=+**%%#@%###*#**+**========--------------------------------=
==================================+#*##%%@@%+*##%%*++++###*++++++*****##*****++++++=+###+++*#%#*%@%%###*+***==========----======---------------------=
===================================*##%#%%@#+****#%#**#####*+++++++==*#%@*=+++++++++*##*+*#%%#**%@%#%##*+*#+==========================================
====================================###%%@@#+*****#%@###%%#*++++++===+@@@+======++++#####%%#****%@%%##***#*===========================================
====================================*%#%%@@#*********%@%%%%*++++++===+@@@+=====+++*#%%%%%#******%@%%#***#*+===========================================
====================================+%##%@@#**********#@%#%#**++++===*@@@+=====++*#%@@@#+******#%@%%***#%*+===========================================
=====================================##*%@@#************%@%##***++===*@@@*+++++***%@@%*+++*****##@###**#%*+===========================================
====================================+*#**%@%*##**+++**+++*@%##**+++++#@@@%+++***#%@@#*+++++****##%%%##*#%*+===========================================
=============================++++++=+##*#*#@**#***+***+++++#%##****#%@@@@@%####%%@%***++++++***##@@####*#%+===========================================
++++++++++++++++++++++=======+#++++++%***##%#*****+****++++++*#%%%%@@@@@@@@@@%%%%*****++++++***#%@%***%**%#+==========================================
++++++++++++++++++++++++++++++#%#*+*#%###***%***********++++++++*#######***##********+++++++****@@#***#***#%*========++===============================
+++++++++++++++++++++++++++++++####**#####**#%**********+++++++++=========++++******++++++++++*#%#***##***+#%#++=++++#*++++++++++++++++++===+++++++===
+++++++++++++++++++*+++++++*#*##********###**#%****+***+++++++++++++++++++*********+++++++++++#@#****##*++++*****++++##+++++++++#*++++++++++++++++++++
+++++*#++++++++++++##*+++**#%#***+++*%***##***#%#******++++++++++++++++************++++++++++*%#*****#****+++****##**%%++++++++**#+++++#*+++++++++++++
++++++##*++++++#*++*%%#%#****#****++*@@#*******#%#******++++++++++++++*************++++++++**%#*****#**************#####+++++++#*#++++#%#+++++++++++++
+++++++##**++++*****#%##*************%%%*****#***%#*******++++++++++++++**********+++++++**#%#*****#****************##****++++*##%*+*%%#%*++++++++++++
+++++++*##**+**++++******************%*%#*********%#********++++++++++++***#*****++++++***#%#*********************##***###******##**+++****+++++++++++
++++++++*%#*#*++++**#****+************##**********#%#*********++++++*****##*************##%#********************##****#%*#*****###****+++**+++++++++++
+++++++++*#+**+++++*%*********#********************#%%*********+++********************##%%#*********************##****#%*#****#%##***++++#**++++++++++
+++++++++++++***++++*%********#**********#*****##***#%%#*****************************##%%**********************###****####*****##****+++#%**++++++++++
++++++++++++++#**++++***++****#%###*****##***********#%%#***************************####****#******************%%*#***#********#%#++++++*##*++++++++++
++++++++++++++###%#+++++++++************%#************#%%#*************************#%%#**###*******************%%##**##********%#%*+++++++++++++++++++
*+++++++++++++****++++*#*+++*************%###******###*##%#****#*******************#%#*####**************************%##***++*#@#%*+++++++++++++++++++
****++++++++++++++++++*#***************************#######%%#*********************#%#*#############******************%###*+++++##*++++++++++++++++++++
***********+++++++++++*##%***************************###%%%%%#*******************%@##%#############******************##**+++++++++++++********++++++++
*****************************************###**##*****#####%@%%##**********#####%@@##%#*##########*****************************************************
*****************************************############*####%%@%@%#***######%%%%%@@%%##*###############*************************************************
*******************************************################%@@@@%####*##*##%@#%@%%##**####%###########************************************************
************************************************#############%%%@%############%%%#####################******************#*****************************
***************************************************########**###%%#########**##%###**#########*********************#**##******************************
**************************************************************#############################*******************#*##*#%%###*****************************
*********************************************************###*******####################*********************#%#*#%%%@#********************************
****************************************************#####*****##****##################**********************######%#****########**********************
************************************************************##########################*************************#####**********************************
*************************************************************################*************************************************************************
******************************************************************************************************************************************************
")
*/