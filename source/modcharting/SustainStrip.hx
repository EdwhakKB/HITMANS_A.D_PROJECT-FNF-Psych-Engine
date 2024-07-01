package modcharting;

import flixel.graphics.tile.FlxDrawTrianglesItem.DrawData;
import openfl.geom.Vector3D;
#if LEATHER
import game.Note;
#end
import flixel.FlxStrip;

import lime.math.Vector2;
import flixel.math.FlxMath;

class SustainStrip extends FlxStrip
{
    private static final noteUV:Array<Float> = [
        0,0, //top left
        1,0, //top right
        0,0.5, //half left
        1,0.5, //half right    
        0,1, //bottom left
        1,1, //bottom right 
    ];
    private static final noteIndices:Array<Int> = [
        0,1,2,1,3,2, 2,3,4,3,4,5
        //makes 4 triangles
    ];

    private var daNote:Note;

    override public function new(daNote:Note)
    {
        this.daNote = daNote;
        daNote.alpha = 1;
        super(0,0);
        loadGraphic(daNote.updateFramePixels());
        shader = daNote.shader;
        for (uv in noteUV)
        {
            uvtData.push(uv);
            vertices.push(0);
        }
        for (ind in noteIndices)
            indices.push(ind);
    }

    //spiral holds test
    private function rotateAround(origin:Vector2, point:Vector2, degrees:Float):Vector2
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


    //Set this to true for spiral holds!
    //Note, they might cause some visual gaps. Maybe fix later?
    public var spiralHolds:Bool = false; //for now false cuz yeah 

    public function constructVertices(noteData:NotePositionData, thisNotePos:Vector3D, nextHalfNotePos:NotePositionData, nextNotePos:NotePositionData, flipGraphic:Bool, reverseClip:Bool)
    {
        var holdWidth = daNote.frameWidth;
        var xOffset = daNote.frameWidth/6.5; //FUCK YOU, MAGIC NUMBER GO! MAKE THEM HOLDS CENTERED DAMNIT!

        daNote.rgbShader.parent.stealthGlow = noteData.stealthGlow; //make sure at the moment we render sustains they get shader changes? (OMG THIS FIXED SUDDEN HIDDEN AND ETC LMAO)
        daNote.rgbShader.parent.stealthGlowRed = noteData.glowRed;
        daNote.rgbShader.parent.stealthGlowGreen = noteData.glowGreen;
        daNote.rgbShader.parent.stealthGlowBlue = noteData.glowBlue;

        var yOffset = -1; //fix small gaps
        if (reverseClip)
            yOffset *= -1;

        var verts:Array<Float> = [];
        if (flipGraphic)
        {
            var scaleTest = nextNotePos.scaleX;
            //MAKE IT TAKE IN Z!
            scaleTest *= (1/-nextNotePos.z);
            var widthScaled = holdWidth * scaleTest;
            var scaleChange = widthScaled - holdWidth;
            var holdLeftSide = 0 - (scaleChange / 2);
            var holdRightSide = widthScaled - (scaleChange / 2);
            holdLeftSide -= xOffset;
            holdRightSide -= xOffset;


            var vert_X_L:Float = nextNotePos.x+holdLeftSide;
            var vert_Y_L:Float = nextNotePos.y;
            var vert_X_R:Float = nextNotePos.x+holdRightSide;
            var vert_Y_R:Float = nextNotePos.y;

            var calculateAngleDif:Float = 0.0;
            if(spiralHolds){
                var a:Float = (nextNotePos.y - thisNotePos.y) * -1.0; // height
                var b:Float = (nextNotePos.x - thisNotePos.x); // length
                var angle:Float = Math.atan2(b,a);
                angle *= (180 / Math.PI);
                calculateAngleDif = angle;
            }

            if(spiralHolds){
                var rotateOrigin:Vector2 = new Vector2(vert_X_L, vert_Y_L);
                rotateOrigin.x += (vert_X_R - vert_X_L) / 2;

                var rotatePoint:Vector2 = new Vector2(vert_X_L, vert_Y_L);

                var thing:Vector2 = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_L = thing.x;
                vert_Y_L = thing.y;

                rotatePoint = new Vector2(vert_X_R, vert_Y_R);
                thing = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_R = thing.x;
                vert_Y_R = thing.y;
            }

            verts.push(vert_X_L);
            verts.push(vert_Y_L);
            verts.push(vert_X_R);
            verts.push(vert_Y_R);

            scaleTest = nextHalfNotePos.scaleX;
            scaleTest *= (1/-nextHalfNotePos.z);
            widthScaled = holdWidth * scaleTest;
            scaleChange = widthScaled - holdWidth;
            holdLeftSide = 0 - (scaleChange / 2);
            holdRightSide = widthScaled - (scaleChange / 2);
            holdLeftSide -= xOffset;
            holdRightSide -= xOffset;

            vert_X_L = nextHalfNotePos.x+holdLeftSide;
            vert_Y_L = nextHalfNotePos.y;
            vert_X_R = nextHalfNotePos.x+holdRightSide;
            vert_Y_R = nextHalfNotePos.y;

            if(spiralHolds){
                var rotateOrigin:Vector2 = new Vector2(vert_X_L, vert_Y_L);
                rotateOrigin.x += (vert_X_R - vert_X_L) / 2;

                var rotatePoint:Vector2 = new Vector2(vert_X_L, vert_Y_L);

                var thing:Vector2 = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_L = thing.x;
                vert_Y_L = thing.y;

                rotatePoint = new Vector2(vert_X_R, vert_Y_R);
                thing = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_R = thing.x;
                vert_Y_R = thing.y;
            }

            verts.push(vert_X_L);
            verts.push(vert_Y_L);
            verts.push(vert_X_R);
            verts.push(vert_Y_R);

            scaleTest = noteData.scaleX;
            scaleTest *= (1/-thisNotePos.z);
            widthScaled = holdWidth * scaleTest;
            scaleChange = widthScaled - holdWidth;
            holdLeftSide = 0 - (scaleChange / 2);
            holdRightSide = widthScaled - (scaleChange / 2);
            holdLeftSide -= xOffset;
            holdRightSide -= xOffset;

            vert_X_L = thisNotePos.x+holdLeftSide;
            vert_Y_L = thisNotePos.y;
            vert_X_R = thisNotePos.x+holdRightSide;
            vert_Y_R = thisNotePos.y;

            if(spiralHolds){
                var rotateOrigin:Vector2 = new Vector2(vert_X_L, vert_Y_L);
                rotateOrigin.x += (vert_X_R - vert_X_L) / 2;

                var rotatePoint:Vector2 = new Vector2(vert_X_L, vert_Y_L);

                var thing:Vector2 = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_L = thing.x;
                vert_Y_L = thing.y;

                rotatePoint = new Vector2(vert_X_R, vert_Y_R);
                thing = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_R = thing.x;
                vert_Y_R = thing.y;
            }

            verts.push(vert_X_L);
            verts.push(vert_Y_L);
            verts.push(vert_X_R);
            verts.push(vert_Y_R);
        }
        else 
        {
            var scaleTest = noteData.scaleX;
            scaleTest *= (1/-thisNotePos.z);
            var widthScaled = holdWidth * scaleTest;
            var scaleChange = widthScaled - holdWidth;
            var holdLeftSide = 0 - (scaleChange / 2);
            var holdRightSide = widthScaled - (scaleChange / 2);
            holdLeftSide -= xOffset;
            holdRightSide -= xOffset;

            var vert_X_L:Float = thisNotePos.x+holdLeftSide;
            var vert_Y_L:Float = thisNotePos.y;
            var vert_X_R:Float = thisNotePos.x+holdRightSide;
            var vert_Y_R:Float = thisNotePos.y;

            var calculateAngleDif:Float = 0.0;
            if(spiralHolds){
                var a:Float = (thisNotePos.y - nextNotePos.y) * -1.0; // height
                var b:Float = (thisNotePos.x - nextNotePos.x); // length
                var angle:Float = Math.atan2(b,a);
                angle *= (180 / Math.PI);
                calculateAngleDif = angle;
            }
            if(spiralHolds){
                var rotateOrigin:Vector2 = new Vector2(vert_X_L, vert_Y_L);
                rotateOrigin.x += (vert_X_R - vert_X_L) / 2;

                var rotatePoint:Vector2 = new Vector2(vert_X_L, vert_Y_L);

                var thing:Vector2 = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_L = thing.x;
                vert_Y_L = thing.y;

                rotatePoint = new Vector2(vert_X_R, vert_Y_R);
                thing = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_R = thing.x;
                vert_Y_R = thing.y;
            }


            verts.push(vert_X_L);
            verts.push(vert_Y_L); 
            verts.push(vert_X_R);
            verts.push(vert_Y_R);

            scaleTest = nextHalfNotePos.scaleX;
            scaleTest *= (1/-nextHalfNotePos.z);
            widthScaled = holdWidth * scaleTest;
            scaleChange = widthScaled - holdWidth;
            holdLeftSide = 0 - (scaleChange / 2);
            holdRightSide = widthScaled - (scaleChange / 2);
            holdLeftSide -= xOffset;
            holdRightSide -= xOffset;

            vert_X_L = nextHalfNotePos.x+holdLeftSide;
            vert_Y_L = nextHalfNotePos.y;
            vert_X_R = nextHalfNotePos.x+holdRightSide;
            vert_Y_R = nextHalfNotePos.y;

            if(spiralHolds){
                var rotateOrigin:Vector2 = new Vector2(vert_X_L, vert_Y_L);
                rotateOrigin.x += (vert_X_R - vert_X_L) / 2;

                var rotatePoint:Vector2 = new Vector2(vert_X_L, vert_Y_L);

                var thing:Vector2 = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_L = thing.x;
                vert_Y_L = thing.y;

                rotatePoint = new Vector2(vert_X_R, vert_Y_R);
                thing = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_R = thing.x;
                vert_Y_R = thing.y;
            }

            verts.push(vert_X_L);
            verts.push(vert_Y_L);
            verts.push(vert_X_R);
            verts.push(vert_Y_R);


            scaleTest = nextNotePos.scaleX;
            scaleTest *= (1/-nextNotePos.z);
            widthScaled = holdWidth * scaleTest;
            scaleChange = widthScaled - holdWidth;
            holdLeftSide = 0 - (scaleChange / 2);
            holdRightSide = widthScaled - (scaleChange / 2);
            holdLeftSide -= xOffset;
            holdRightSide -= xOffset;

            vert_X_L = nextNotePos.x+holdLeftSide;
            vert_Y_L = nextNotePos.y;
            vert_X_R = nextNotePos.x+holdRightSide;
            vert_Y_R = nextNotePos.y;

            if(spiralHolds){
                var rotateOrigin:Vector2 = new Vector2(vert_X_L, vert_Y_L);
                rotateOrigin.x += (vert_X_R - vert_X_L) / 2;

                var rotatePoint:Vector2 = new Vector2(vert_X_L, vert_Y_L);

                var thing:Vector2 = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_L = thing.x;
                vert_Y_L = thing.y;

                rotatePoint = new Vector2(vert_X_R, vert_Y_R);
                thing = rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
                vert_X_R = thing.x;
                vert_Y_R = thing.y;
            }

            verts.push(vert_X_L);
            verts.push(vert_Y_L);
            verts.push(vert_X_R);
            verts.push(vert_Y_R);
        }
        vertices = new DrawData(12, true, verts);
    }
}