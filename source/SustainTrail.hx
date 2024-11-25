package;

import flixel.graphics.FlxGraphic;
import flixel.math.FlxMath;
import flixel.graphics.tile.FlxDrawTrianglesItem;
import RGBPalette.RGBShaderReference;
import flixel.FlxSprite;
import flixel.FlxG;
import sys.FileSystem;
import modcharting.*;
import openfl.geom.Vector3D;
import flixel.util.FlxColor;

/**
 * This is based heavily on the `FlxStrip` class. It uses `drawTriangles()` to clip a sustain note
 * trail at a certain time.
 * The whole `FlxGraphic` is used as a texture map. See the `NOTE_hold_assets.fla` file for specifics
 * on how it should be constructed.
 *
 * @author MtH
 */
class SustainTrail extends FlxSprite
{
  /**
   * The triangles corresponding to the hold, followed by the endcap.
   * `top left, top right, bottom left`
   * `top left, bottom left, bottom right`
   */
  static final TRIANGLE_VERTEX_INDICES:Array<Int> = [0, 1, 2, 1, 2, 3, 4, 5, 6, 5, 6, 7];

  public var strumTime:Float = 0; // millis
  public var noteDirection:Int = 0;
  public var sustainLength(default, set):Float = 0; // millis
  public var fullSustainLength:Float = 0;

  /**
   * Set to `true` if the user hit the note and is currently holding the sustain.
   * Should display associated effects.
   */
  public var hitNote:Bool = false;

  /**
   * Set to `true` if the user missed the note or released the sustain.
   * Should make the trail transparent.
   */
  public var missedNote:Bool = false;

  /**
   * Set to `true` after handling additional logic for missing notes.
   */
  public var handledMiss:Bool = false;

  // maybe BlendMode.MULTIPLY if missed somehow, drawTriangles does not support!

  /**
   * A `Vector` of floats where each pair of numbers is treated as a coordinate location (an x, y pair).
   */
  public var vertices:DrawData<Float> = new DrawData<Float>();

  /**
   * A `Vector` of integers or indexes, where every three indexes define a triangle.
   */
  public var indices:DrawData<Int> = new DrawData<Int>();

  /**
   * A `Vector` of normalized coordinates used to apply texture mapping.
   */
  public var uvtData:DrawData<Float> = new DrawData<Float>();

  private var processedGraphic:FlxGraphic;

  private var zoom:Float = 1;

  /**
   * What part of the trail's end actually represents the end of the note.
   * This can be used to have a little bit sticking out.
   */
  public var endOffset:Float = 0.5; // 0.73 is roughly the bottom of the sprite in the normal graphic!

  /**
   * At what point the bottom for the trail's end should be clipped off.
   * Used in cases where there's an extra bit of the graphic on the bottom to avoid antialiasing issues with overflow.
   */
  public var bottomClip:Float = 0.9;

  public var isPixel:Bool;

  var graphicWidth:Float = 0;
  var graphicHeight:Float = 0;

  var noteData:NotePositionData;
  var pfr:PlayfieldRenderer;
  public var rgbShader:RGBShaderReference;

  /**
   * Normally you would take strumTime:Float, noteData:Int, sustainLength:Float, parentNote:Note (?)
   * @param noteData
   * @param SustainLength Length in milliseconds.
   * @param NoteSkin
   */
  public function new(noteDirection:Int, sustainLength:Float, noteStyle:String, s:PlayfieldRenderer)
  {
    super(0, 0);

    // BASIC SETUP
    this.sustainLength = sustainLength;
    this.fullSustainLength = sustainLength;
    this.noteDirection = noteDirection;
    this.pfr = s;
    super(0, 0, Paths.image('NOTE_ArrowPath'));
    //setupHoldNoteGraphic(noteStyle);

    antialiasing = true;

    this.isPixel = noteStyle.contains('pixel');
    if (isPixel)
    {
      endOffset = bottomClip = 1;
      antialiasing = false;
    }
    else
    {
      endOffset = 0.5;
      bottomClip = 0.9;
    }

    zoom = 1.0;
    zoom *= isPixel ? 8.0 : 1.55;
    zoom *= 0.7;

    noteData = new NotePositionData();
    var leData:Int = Std.int(Math.abs(noteDirection % 4));
    rgbShader = new RGBShaderReference(this, Note.initializeGlobalRGBShader(leData));
    if (PlayState.SONG != null && PlayState.SONG.disableNoteRGB) rgbShader.enabled = false;

    var arr:Array<FlxColor> = ClientPrefs.arrowRGB[leData];

    if (leData <= arr.length)
    {
      @:bypassAccessor
      {
        rgbShader.r = arr[0];
        rgbShader.g = arr[1];
        rgbShader.b = arr[2];
      }
    }

    // CALCULATE SIZE
    graphicWidth = graphic.width / 8 * zoom; // amount of notes * 2
    graphicHeight = sustainHeight(sustainLength, 1.0);
    // instead of scrollSpeed, PlayState.SONG.speed
    flipY = ClientPrefs.downScroll;

    indices = new DrawData<Int>(12, true, TRIANGLE_VERTEX_INDICES);

    alpha = 1.0;
    // calls updateColorTransform(), which initializes processedGraphic!
    updateColorTransform();

    updateClipping();

    this.active = true; // This NEEDS to be true for the note to be drawn!
  }

  /**
   * Creates hold note graphic and applies correct zooming
   * @param noteStyle The note style
   */
  public function setupHoldNoteGraphic(noteStyle:String):Void
  {
    var style:String = getStyle(noteStyle);
    loadGraphic(Paths.getPath('images/$style.png'));

    antialiasing = true;

    this.isPixel = style.contains('pixel');
    if (isPixel)
    {
      endOffset = bottomClip = 1;
      antialiasing = false;
    }
    else
    {
      endOffset = 0.5;
      bottomClip = 0.9;
    }

    zoom = 1.0;
    zoom *= isPixel ? 8.0 : 1.55;
    zoom *= 0.7;

    var leData:Int = Std.int(Math.abs(noteDirection % 4));
    rgbShader = new RGBShaderReference(this, Note.initializeGlobalRGBShader(leData));
    if (PlayState.SONG != null && PlayState.SONG.disableNoteRGB) rgbShader.enabled = false;

    var arr:Array<FlxColor> = ClientPrefs.arrowRGB[leData];

    if (leData <= arr.length)
    {
      @:bypassAccessor
      {
        rgbShader.r = arr[0];
        rgbShader.g = arr[1];
        rgbShader.b = arr[2];
      }
    }

    // CALCULATE SIZE
    graphicWidth = graphic.width / 8 * zoom; // amount of notes * 2
    graphicHeight = sustainHeight(sustainLength, 1.0);
    // instead of scrollSpeed, PlayState.SONG.speed
    flipY = ClientPrefs.downScroll;
    // calls updateColorTransform(), which initializes processedGraphic!
    updateColorTransform();

    updateClipping();
  }

  public function getStyle(noteStyleType:String):String
  {
    var firstPath:Bool = #if MODS_ALLOWED FileSystem.exists(Paths.getPath('images/notes/$noteStyleType.png')) || #end openfl.utils.Assets.exists(Paths.getPath('images/notes/$noteStyleType.png'));
    var secondPath:Bool = #if MODS_ALLOWED FileSystem.exists(Paths.getPath('images/$noteStyleType.png')) || #end openfl.utils.Assets.exists(Paths.getPath('images/$noteStyleType.png'));
    var endingStyle:String = "";
    switch (noteStyleType)
    {
      default:
        if (noteStyleType.contains('pixel'))
        {
          if (firstPath)
          {
            endingStyle = 'notes/' + noteStyleType + 'ENDS';
          }
          else if (secondPath)
          {
            endingStyle = noteStyleType + 'ENDS';
          }
          else
          {
            var noteSkinNonRGB:Bool = (PlayState.SONG != null && PlayState.SONG.disableNoteRGB);
            endingStyle = noteSkinNonRGB ? 'pixelUI/NOTE_assetsENDS' : 'pixelUI/noteSkins/NOTE_assetsENDS';
          }
        }
        else
        {
          if (firstPath)
          {
            endingStyle = 'notes/' + noteStyleType;
          }
          else if (secondPath)
          {
            endingStyle = noteStyleType;
          }
          else
          {
            var noteSkinNonRGB:Bool = (PlayState.SONG != null && PlayState.SONG.disableNoteRGB);
            endingStyle = "NOTE_hold_assets";
          }
        }
    }
    return endingStyle;
  }

  function getBaseScrollSpeed():Float
  {
    var speed:Float = 1.0;
    if (FlxG.state is PlayState) speed = PlayState.SONG.speed;
    return speed;
  }

  var previousScrollSpeed:Float = 1;

  override function update(elapsed)
  {
    super.update(elapsed);
    if (previousScrollSpeed != 1.0)
    {
      triggerRedraw();
    }
    previousScrollSpeed = 1.0;
    alpha = 1;
  }

  /**
   * Calculates height of a sustain note for a given length (milliseconds) and scroll speed.
   * @param	susLength	The length of the sustain note in milliseconds.
   * @param	scroll		The current scroll speed.
   */
  public static inline function sustainHeight(susLength:Float, scroll:Float)
  {
    return (susLength * 0.45 * scroll);
  }

  function set_sustainLength(s:Float):Float
  {
    if (s < 0.0) s = 0.0;

    if (sustainLength == s) return s;
    this.sustainLength = s;
    triggerRedraw();
    return this.sustainLength;
  }

  function triggerRedraw()
  {
    graphicHeight = sustainHeight(sustainLength, 1.0);
    updateClipping();
    updateHitbox();
  }

  public override function updateHitbox():Void
  {
    width = graphicWidth;
    height = graphicHeight;
    offset.set(0, 0);
    origin.set(width * 0.5, height * 0.5);
  }

  /**
   * Sets up new vertex and UV data to clip the trail.
   * If flipY is true, top and bottom bounds swap places.
   * @param songTime	The time to clip the note at, in milliseconds.
   */
   
  public function updateClipping(songTime:Float = 0):Void
  {
    if (graphic == null)
    {
      return;
    }

    var clipHeight:Float = FlxMath.bound(sustainHeight(sustainLength - (songTime - strumTime), 1.0), 0, graphicHeight);
    if (clipHeight <= 0.1)
    {
      visible = false;
      return;
    }
    else
    {
      visible = true;
    }

    var bottomHeight:Float = graphic.height * zoom * endOffset;
    var partHeight:Float = clipHeight - bottomHeight;

    // ===HOLD VERTICES==
    // Top left
    vertices[0 * 2] = 0.0; // Inline with left side
    vertices[0 * 2 + 1] = flipY ? clipHeight : graphicHeight - clipHeight;

    // Top right
    vertices[1 * 2] = graphicWidth;
    vertices[1 * 2 + 1] = vertices[0 * 2 + 1]; // Inline with top left vertex

    // Bottom left
    vertices[2 * 2] = 0.0; // Inline with left side
    vertices[2 * 2 + 1] = if (partHeight > 0)
    {
      // flipY makes the sustain render upside down.
      flipY ? 0.0 + bottomHeight : vertices[1] + partHeight;
    }
    else
    {
      vertices[0 * 2 + 1]; // Inline with top left vertex (no partHeight available)
    }

    // Bottom right
    vertices[3 * 2] = graphicWidth;
    vertices[3 * 2 + 1] = vertices[2 * 2 + 1]; // Inline with bottom left vertex

    // ===HOLD UVs===

    // The UVs are a bit more complicated.
    // UV coordinates are normalized, so they range from 0 to 1.
    // We are expecting an image containing 8 horizontal segments, each representing a different colored hold note followed by its end cap.

    uvtData[0 * 2] = 1 / 4 * (noteDirection % 4); // 0%/25%/50%/75% of the way through the image
    uvtData[0 * 2 + 1] = (-partHeight) / graphic.height / zoom; // top bound
    // Top left

    // Top right
    uvtData[1 * 2] = uvtData[0 * 2] + 1 / 8; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
    uvtData[1 * 2 + 1] = uvtData[0 * 2 + 1]; // top bound

    // Bottom left
    uvtData[2 * 2] = uvtData[0 * 2]; // 0%/25%/50%/75% of the way through the image
    uvtData[2 * 2 + 1] = 0.0; // bottom bound

    // Bottom right
    uvtData[3 * 2] = uvtData[1 * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
    uvtData[3 * 2 + 1] = uvtData[2 * 2 + 1]; // bottom bound

    // === END CAP VERTICES ===
    // Top left
    vertices[4 * 2] = vertices[2 * 2]; // Inline with bottom left vertex of hold
    vertices[4 * 2 + 1] = vertices[2 * 2 + 1]; // Inline with bottom left vertex of hold

    // Top right
    vertices[5 * 2] = vertices[3 * 2]; // Inline with bottom right vertex of hold
    vertices[5 * 2 + 1] = vertices[3 * 2 + 1]; // Inline with bottom right vertex of hold

    // Bottom left
    vertices[6 * 2] = vertices[2 * 2]; // Inline with left side
    vertices[6 * 2 + 1] = flipY ? (graphic.height * (-bottomClip + endOffset) * zoom) : (graphicHeight + graphic.height * (bottomClip - endOffset) * zoom);

    // Bottom right
    vertices[7 * 2] = vertices[3 * 2]; // Inline with right side
    vertices[7 * 2 + 1] = vertices[6 * 2 + 1]; // Inline with bottom of end cap

    // === END CAP UVs ===
    // Top left
    uvtData[4 * 2] = uvtData[2 * 2] + 1 / 8; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
    uvtData[4 * 2 + 1] = if (partHeight > 0)
    {
      0;
    }
    else
    {
      (bottomHeight - clipHeight) / zoom / graphic.height;
    };

    // Top right
    uvtData[5 * 2] = uvtData[4 * 2] + 1 / 8; // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
    uvtData[5 * 2 + 1] = uvtData[4 * 2 + 1]; // top bound

    // Bottom left
    uvtData[6 * 2] = uvtData[4 * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
    uvtData[6 * 2 + 1] = bottomClip; // bottom bound

    // Bottom right
    uvtData[7 * 2] = uvtData[5 * 2]; // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
    uvtData[7 * 2 + 1] = uvtData[6 * 2 + 1]; // bottom bound
  }

  @:access(flixel.FlxCamera)
  override public function draw():Void
  {
    if (alpha == 0 || graphic == null || vertices == null) return;

    for (camera in cameras)
    {
      if (!camera.visible || !camera.exists) continue;
      // if (!isOnScreen(camera)) continue; // TODO: Update this code to make it work properly.

      getScreenPosition(_point, camera).subtractPoint(offset);
      camera.drawTriangles(processedGraphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing, colorTransform, shader);
    }

    #if FLX_DEBUG
    if (FlxG.debugger.drawDebug) drawDebug();
    #end
  }

  public function updatePath(strumT:Float, lane:Int, pf:Int):Void
  {
    setNotePos(noteData, strumT, lane, pf);
  }

  public function setNotePos(noteData:NotePositionData, strumTim:Float, lane:Int, pf:Int):Void
  {
    //Sample the current mod math!

    var songSpeed:Float = pfr.getCorrectScrollSpeed();

    var noteDist:Float = pfr.getNoteDist(noteData.index); //?????

    var curPos = (Conductor.songPosition - strumTim) * songSpeed;

    curPos = pfr.modifierTable.applyCurPosMods(lane, curPos, pf);

    var incomingAngle:Array<Float> = pfr.modifierTable.applyIncomingAngleMods(lane, curPos, pf);
    if (noteDist < 0)
      incomingAngle[0] += 180; // make it match for both scrolls

    // get the general note path
    NoteMovement.setNotePath_positionData(noteData, lane, songSpeed, curPos, noteDist, incomingAngle[0], incomingAngle[1]);

    //move the x and y to properly be in the center of the strum graphic
    var strumNote = pfr.strumGroup.members[lane]; //first we need to know what the strum is though lol
    noteData.x += strumNote.width/2 - frameWidth/15;
    noteData.y += strumNote.height/2 - frameHeight/15;

    // add offsets to data with modifiers
    pfr.modifierTable.applyNoteMods(noteData, lane, curPos, pf);

    // add position data to list //idk what this does so I just commented it out lol cuz we just constantly reuse 1 notePosition data.
    //notePositions.push(noteData);


    //Apply z-axis projection! 
    var pointWidth:Float = width;
    var pointHeight:Float = height;

    var thisNotePos = ModchartUtil.calculatePerspective(
      new Vector3D(noteData.x + (pointWidth / 2), noteData.y + (pointHeight / 2), noteData.z * 0.001),
          ModchartUtil.defaultFOV * (Math.PI / 180), -(pointWidth / 2), -(pointHeight / 2)
    );

    noteData.x = thisNotePos.x;
    noteData.y = thisNotePos.y;
    noteData.scaleX *= (1 / -thisNotePos.z);
    noteData.scaleY *= (1 / -thisNotePos.z);

    this.x = noteData.x;
    this.y = noteData.y;
    this.scale.x = noteData.scaleX;
    this.scale.y = noteData.scaleY;
  }

  public override function kill():Void
  {
    super.kill();

    strumTime = 0;
    noteDirection = 0;
    sustainLength = 0;
    fullSustainLength = 0;

    hitNote = false;
    missedNote = false;
  }

  public override function revive():Void
  {
    super.revive();

    strumTime = 0;
    noteDirection = 0;
    sustainLength = 0;
    fullSustainLength = 0;

    hitNote = false;
    missedNote = false;
    handledMiss = false;
  }

  override public function destroy():Void
  {
    vertices = null;
    indices = null;
    uvtData = null;
    processedGraphic.destroy();

    super.destroy();
  }

  override function updateColorTransform():Void
  {
    super.updateColorTransform();
    if (processedGraphic != null) processedGraphic.destroy();
    processedGraphic = FlxGraphic.fromGraphic(graphic, true);
    processedGraphic.bitmap.colorTransform(processedGraphic.bitmap.rect, colorTransform);
  }
}
