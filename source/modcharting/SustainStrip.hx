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

    //Set this to true for spiral holds!
    //Note, they might cause some visual gaps. Maybe fix later?
    public var spiralHolds:Bool = false; //for now false cuz yeah 

    // for spiral holds
    // ported from FunkinModchart
    public function getPointsNormal(pos:NotePositionData, nextFramePos:NotePositionData, holdSize:Float)
    {
        var unitX = nextFramePos.x - pos.x;
        var unitY = nextFramePos.y - pos.y;
        // normalizing
        var length = Math.sqrt(unitX * unitX + unitY * unitY);
        unitX /= length;
        unitY /= length;
        holdSize *= .5 * (1 / -pos.z) * pos.scaleX;

        return [
            //  left
            pos.x + -unitY * holdSize, pos.y + unitX * holdSize,
            // right
            pos.x + unitY * holdSize, pos.y + -unitX * holdSize,
        ];
    }
    public function constructVertices(noteData:NotePositionData, topPositions:Array<NotePositionData>, middlePositions:Array<NotePositionData>, bottomPositions:Array<NotePositionData>, flipGraphic:Bool, reverseClip:Bool)
    {
        var holdWidth = daNote.frameWidth;
        var xOffset = daNote.frameWidth/6.5; //FUCK YOU, MAGIC NUMBER GO! MAKE THEM HOLDS CENTERED DAMNIT!

        daNote.rgbShader.stealthGlow = noteData.stealthGlow; //make sure at the moment we render sustains they get shader changes? (OMG THIS FIXED SUDDEN HIDDEN AND ETC LMAO)
        daNote.rgbShader.stealthGlowRed = noteData.glowRed;
        daNote.rgbShader.stealthGlowGreen = noteData.glowGreen;
        daNote.rgbShader.stealthGlowBlue = noteData.glowBlue;

        var yOffset = -1; //fix small gaps
        if (reverseClip)
            yOffset *= -1;

        var verts:Array<Float> = [];

        var top = [];
        var mid = [];
        var bottom = [];

        if (spiralHolds)
        {
            top = getPointsNormal(topPositions[0], topPositions[1], holdWidth);
            mid = getPointsNormal(middlePositions[0], middlePositions[1], holdWidth);
            bottom = getPointsNormal(bottomPositions[0], bottomPositions[1], holdWidth);
        } else {
            var zScaleTop = 1/-topPositions[0].z;
            var zScaleMid = 1/-middlePositions[0].z;
            var zScaleBottom = 1/-bottomPositions[0].z;

            top = [
                topPositions[0].x - holdWidth * .5 * zScaleTop * topPositions[0].scaleX, topPositions[0].y,
                topPositions[0].x + holdWidth * .5 * zScaleTop * topPositions[0].scaleX,  topPositions[0].y
            ];
            mid = [
                middlePositions[0].x - holdWidth * .5 * zScaleMid * middlePositions[0].scaleX, middlePositions[0].y,
                middlePositions[0].x + holdWidth * .5 * zScaleMid * middlePositions[0].scaleX,  middlePositions[0].y
            ];
            bottom = [
                bottomPositions[0].x - holdWidth * .5 * zScaleBottom * bottomPositions[0].scaleX, bottomPositions[0].y,
                bottomPositions[0].x + holdWidth * .5 * zScaleBottom * bottomPositions[0].scaleX,  bottomPositions[0].y
            ];
        }


        for (vector in [top, mid, bottom])
        {
            for (i in vector)
                verts.push(i);
        }

        vertices = new DrawData(12, true, verts);
    }
}