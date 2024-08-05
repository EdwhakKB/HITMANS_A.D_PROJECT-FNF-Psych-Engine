package modcharting;

import flixel.FlxG;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import lime.graphics.Image;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import openfl.display.BitmapDataChannel;
import openfl.display.BlendMode;
import openfl.display.CapsStyle;
import openfl.display.Graphics;
import openfl.display.JointStyle;
import openfl.display.LineScaleMode;
import openfl.display.Sprite;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import openfl.Vector;
import openfl.display.GraphicsPathCommand;
// import funkin.play.notes.Strumline;
import lime.math.Vector2;
// import funkin.graphics.ZSprite;
// import funkin.play.notes.StrumlineNote;
// import StrumNote as StrumLineNote;
#if LEATHER
import states.PlayState;
import game.Note as StrumlineNote;
import game.StrumNote;
import game.Conductor;
#else 
import PlayState;
import Note as StrumlineNote;
import Conductor;
#end

typedef Strumline = 
#if (PSYCH || LEATHER) StrumNote
#elseif KADE StaticArrow
#elseif FOREVER_LEGACY UIStaticArrow
#elseif ANDROMEDA Receptor
#else FlxSprite #end;

// SCRAPED BECAUSE IT JUST CAUSED MAJOR LAG PROBLEMS LOL
// ALSO BECAUSE IM NOT SMART ENOUGH TO FIGURE IT OUT

// GOOD LUCK FIGURING THIS OUT! if you get it, make sure to make a pull request into MT, so i can add it!!!!, thanks! -Edwhak
class Arrowpath
{
  // The actual bitmap data
  public var bitmap:BitmapData;

  var flashGfxSprite(default, null):Sprite = new Sprite();
  var flashGfx(default, null):Graphics;

  // For limiting the AFT update rate. Useful to make it less framerate dependent.
  // TODO -> Make a public function called limitAFT() which takes a target FPS (like the mirin template plugin)
  public var updateTimer:Float = 0.0;
  public var updateRate:Float = 0.25;

  // Just a basic rectangle which fills the entire bitmap when clearing out the old pixel data
  var rec:Rectangle;

  var blendMode:String = "normal";
  var colTransf:ColorTransform;

  var strum:Strumline;

  var noteData:NotePositionData;


  //hazard told me this function its useless but i'll leave it here ig?
    
  /*function setNotePos(noteData:NotePositionData, strumTime:Float, lane:Int):Void
  {
    // note.strumTime = Conductor.instance?.songPosition ?? 0;
    // note.strumTime -= arrowpathBackwardsLength[note.noteDirection % KEY_COUNT] ?? 0;

    var scrollMult:Float = 1.0;
    var notePos:Float = strum.calculateNoteYPos(strumTime, false);

    // for (mod in modifiers){
    for (mod in strum.mods.mods_speed)
    {
      scrollMult *= mod.speedMath(lane, notePos, strum, true);
    }

    notePos = strum.calculateNoteYPos(strumTime, false) * scrollMult;
    var whichStrumNote:StrumlineNote = strum.getByIndex(lane % Strumline.KEY_COUNT);

    note.angle = whichStrumNote.angle;
    note.x = whichStrumNote.x + strum.getNoteXOffset();
    // note.set_y(whichStrumNote.y - INITIAL_OFFSET + notePos);

    note.y = whichStrumNote.y + strum.getNoteYOffset() + notePos;

    note.x += whichStrumNote.width / 2 * ModConstants.noteScale;
    note.y += whichStrumNote.height / 2 * ModConstants.noteScale;

    note.z = whichStrumNote.z;
    note.alpha = 1;
    note.scale.set(ModConstants.noteScale, ModConstants.noteScale);

    for (mod in strum.mods.mods_arrowpath)
    {
      mod.noteMath(fakeNote, lane, notePos, strum, true, true);
    }

    ModConstants.applyPerspective(fakeNote, defaultLineSize, 1);
  }*/

  // var fakeNote:ZSprite;
  var defaultLineSize:Float = 2;

  public function updateAFT():Void
  {
    bitmap.lock();
    clearAFT();
    flashGfx.clear();

    for (l in 0...NoteMovement.keyCount)
    {
      var arrowPathAlpha:Float = noteData.arrowPathAlpha; //NoteData.arrowPathAlpha[l]; -- Must be added into NoteData
      if (arrowPathAlpha <= 0) continue; // skip path if we can't see shit

      var pathLength:Float = noteData.arrowPathLength != null ? noteData.arrowPathLength : 1500; //NoteData.arrowpathLength[l] != null ? NoteData.arrowpathLength[l] : 1500;
      var pathBackLength:Float = noteData.arrowPathBackwardsLength != null ? noteData.arrowPathBackwardsLength : 200; //NoteData.arrowpathBackwardsLength[l] != null ? NoteData.arrowpathBackwardsLength[l] : 200;
      var holdGrain:Float = noteData.pathGrain != null ? noteData.pathGrain : 50; // NoteData.pathGrain != null ? NoteData.pathGrain : 50;
      // var laneSpecificGrain:Float = strum?.mods?.pathGrain_Lane[l % 4] ?? 0; // NoteData.pathGrain_Lane[l % 4] != null ? NoteData.pathGrain_Lane[l % 4] : 0;
      // if (laneSpecificGrain > 0)
      // {
      //   holdGrain = laneSpecificGrain;
      // }
      var fullLength:Float = pathLength + pathBackLength;
      var holdResolution:Int = Math.floor(fullLength / holdGrain); // use full sustain so the uv doesn't mess up? huh?

      // https://github.com/4mbr0s3-2/Schmovin/blob/main/SchmovinRenderers.hx
      var commands = new Vector<Int>();
      var data = new Vector<Float>();

      var tim:Float = Conductor.songPosition != null ? Conductor.songPosition : 0; //Conductor.instance.songPosition != null ? Conductor.instance.songPosition : 0; -- not every engine uses exact line, find out per engine
      tim -= pathBackLength;
      for (i in 0...holdResolution)
      {
        var timmy:Float = ((fullLength / holdResolution) * i);
        setNotePos(noteData, tim + timmy, l); //must find a way to apply this into noteData system, im too stupid to do so

        var scaleX = FlxMath.remapToRange(noteData.scaleX, 0, NoteMovement.defaultScale[l], 0, 1);
        var lineSize:Float = defaultLineSize * scaleX;

        var path2:Vector2 = new Vector2(noteData.x, noteData.y);

        // if (FlxMath.inBounds(path2.x, 0, width) && FlxMath.inBounds(path2.y, 0, height))
        // {
        if (i == 0)
        {
          commands.push(GraphicsPathCommand.MOVE_TO);
          flashGfx.lineStyle(lineSize, 0xFFFFFFFF, arrowPathAlpha);
        }
        else
        {
          commands.push(GraphicsPathCommand.LINE_TO);
        }
        data.push(path2.x);
        data.push(path2.y);
        // }
      }
      flashGfx.drawPath(commands, data);
    }
    bitmap.draw(flashGfxSprite);
    bitmap.disposeImage();
    flashGfx.clear();
    bitmap.unlock();
  }

  /*
    public function updateAFT():Void
    {
      bitmap.lock();
      clearAFT();

      flashGfx.clear();
      flashGfx.lineStyle(3, FlxColor.WHITE.to24Bit(), alpha, false);

      flashGfx.beginFill(FlxColor.WHITE.to24Bit(), 0.35);

      var point1X:Float = -250;
      var point2X:Float = 250;

      var point1Y:Float = 0;
      var point2Y:Float = 1280;

      flashGfx.moveTo(point1X, point1Y);
      flashGfx.lineTo(point2X, point2Y);

      flashGfx.endFill();
      // bitmap.draw(flashGfxSprite, drawStyle.matrix, drawStyle.colorTransform, drawStyle.blendMode, drawStyle.clipRect, drawStyle.smoothing);
      // bitmap.draw(targetCAM.canvas, null, colTransf, blendMode);
      bitmap.draw(flashGfxSprite, null, colTransf, blendMode);

      bitmap.disposeImage(); // To prevent memory leak lol
      bitmap.unlock();

      // trace("updated bitmap?");
    }
   */
  // clear out the old bitmap data
  public function clearAFT():Void
  {
    bitmap.fillRect(rec, 0);
  }

  public function update(elapsed:Float = 0.0):Void
  {
    if (bitmap != null)
    {
      if (updateTimer >= 0 && updateRate != 0)
      {
        updateTimer -= elapsed;
      }
      else if (updateTimer < 0 || updateRate == 0)
      {
        updateTimer = updateRate;
        updateAFT();
      }
    }
  }

  var width:Int = 0;
  var height:Int = 0;

  public function new(s:Strumline, w:Int = -1, h:Int = -1)
  {
    // fakeNote = new ZSprite();
    this.strum = s;
    // this.lane = col;
    height = h;
    width = w;
    if (width == -1 || height == -1)
    {
      width = FlxG.width;
      height = FlxG.height;
    }

    flashGfx = flashGfxSprite.graphics;
    bitmap = new BitmapData(width, height, true, 0);
    rec = new Rectangle(0, 0, width, height);
    colTransf = new ColorTransform();
  }
}
