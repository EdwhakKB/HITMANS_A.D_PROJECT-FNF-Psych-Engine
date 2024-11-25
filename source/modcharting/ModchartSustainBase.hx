package funkin.play.notes;

import funkin.play.notes.notestyle.NoteStyle;
import funkin.play.notes.NoteDirection;
import funkin.data.song.SongData.SongNoteData;
import flixel.util.FlxDirectionFlags;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.tile.FlxDrawTrianglesItem;
import flixel.math.FlxMath;
import funkin.ui.options.PreferencesMenu;
import funkin.play.modchartSystem.ModHandler;
import funkin.play.modchartSystem.ModConstants;
import funkin.graphics.FunkinSprite;
import funkin.graphics.ZSprite;
import lime.math.Vector2;
import flixel.util.FlxColor;
import funkin.graphics.shaders.HSVShader;
import funkin.play.modchartSystem.NoteData;
import funkin.play.notes.StrumlineNote;
import openfl.display.TriangleCulling;
import openfl.geom.Vector3D;

/**
 * This is based heavily on the `FlxStrip` class. It uses `drawTriangles()` to clip a sustain note
 * trail at a certain time.
 * The whole `FlxGraphic` is used as a texture map. See the `NOTE_hold_assets.fla` file for specifics
 * on how it should be constructed.
 *
 * @author MtH
 */
class SustainTrail extends ZSprite
{
  /**
   * The triangles corresponding to the hold, followed by the endcap.
   * `top left, top right, bottom left`
   * `top left, bottom left, bottom right`
   */
  static final TRIANGLE_VERTEX_INDICES:Array<Int> = [0, 1, 2, 1, 2, 3, 4, 5, 6, 5, 6, 7];

  public var strumTime:Float = 0; // millis
  public var noteDirection:NoteDirection = 0;
  public var sustainLength(default, set):Float = 0; // millis
  public var fullSustainLength:Float = 0;
  public var noteData:Null<SongNoteData>;
  public var parentStrumline:Strumline;

  // public var z:Float = 0;
  public var cover:NoteHoldCover = null;

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

  /**
   * A `Vector` of magic for color magic, IDFK
   */
  public var colors:DrawData<Int> = null;

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
  public var noteStyleOffsets:Array<Float>;

  var graphicWidth:Float = 0;
  var graphicHeight:Float = 0;

  public var isArrowPath:Bool = false;

  // for identifying what noteStyle this notesprite is using in hxScript or even lua
  public var noteStyleName:String = "funkin";

  /**
   * Normally you would take strumTime:Float, noteData:Int, sustainLength:Float, parentNote:Note (?)
   * @param NoteData
   * @param SustainLength Length in milliseconds.
   * @param fileName
   */
  public function new(noteDirection:NoteDirection, sustainLength:Float, noteStyle:NoteStyle, isArrowPath:Bool = false, ?parentStrum:Strumline)
  {
    this.isArrowPath = isArrowPath;
    this.parentStrumline = parentStrum;

    this.sustainLength = sustainLength;
    this.fullSustainLength = sustainLength;
    this.noteDirection = noteDirection;

    if (isArrowPath)
    {
      if (parentStrum != null)
      {
        super(0, 0, Paths.image(parentStrum.arrowPathFileName));
        // trace("pathpath: " + parentStrum.arrowPathFileName);
      }
      else
      {
        super(0, 0, Paths.image('NOTE_ArrowPath'));
      }
      useShader = false; // Don't use the hsv shader for arrowpaths cuz by default they should be white so they can easily be tinted instead of relying on a shader.
    }
    else
    {
      super(0, 0, noteStyle.getHoldNoteAssetPath());
      // setupHoldNoteGraphic(noteStyle);// still need to support this lmfao
    }

    noteStyleOffsets = noteStyle.getHoldNoteOffsets();

    noteModData = new NoteData();

    noteStyleName = noteStyle.id;

    antialiasing = true;

    this.isPixel = noteStyle.isHoldNotePixel();
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
    zoom *= noteStyle.fetchHoldNoteScale();

    // CALCULATE SIZE
    graphicWidth = graphic.width / 8 * zoom; // amount of notes * 2
    graphicHeight = sustainHeight(sustainLength, parentStrumline?.scrollSpeed ?? 1.0);
    // instead of scrollSpeed, PlayState.SONG.speed

    if (parentStrum != null)
    {
      if (parentStrum.sustainGraphicWidth == null && !isArrowPath)
      {
        parentStrum.sustainGraphicWidth = graphicWidth;
      }
    }
    flipY = Preferences.downscroll;

    indices = new DrawData<Int>(12, true, TRIANGLE_VERTEX_INDICES);

    // alpha = 0.6;
    alpha = 1.0;
    // calls updateColorTransform(), which initializes processedGraphic!
    updateColorTransform();

    updateClipping();
  }

  /**
   * Creates hold note graphic and applies correct zooming
   * @param noteStyle The note style
   */
  public function setupHoldNoteGraphic(noteStyle:NoteStyle):Void
  {
    loadGraphic(noteStyle.getHoldNoteAssetPath());
    noteStyleName = noteStyle.id;
    antialiasing = true;

    this.isPixel = noteStyle.isHoldNotePixel();
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
    zoom *= noteStyle.fetchHoldNoteScale();
    zoom *= 0.7;

    // alpha = 0.6;
    alpha = 1.0;
    // calls updateColorTransform(), which initializes processedGraphic!
    updateColorTransform();

    updateClipping();
  }

  function getBaseScrollSpeed():Float
  {
    return (PlayState.instance?.currentChart?.scrollSpeed ?? 1.0);
  }

  var previousScrollSpeed:Float = 1;

  override function update(elapsed):Void
  {
    super.update(elapsed);
    if (previousScrollSpeed != (parentStrumline?.scrollSpeed ?? 1.0))
    {
      triggerRedraw();
    }
    previousScrollSpeed = parentStrumline?.scrollSpeed ?? 1.0;
  }

  /**
   * Calculates height of a sustain note for a given length (milliseconds) and scroll speed.
   * @param	susLength	The length of the sustain note in milliseconds.
   * @param	scroll		The current scroll speed.
   */
  public static inline function sustainHeight(susLength:Float, scroll:Float)
  {
    return (susLength * Constants.PIXELS_PER_MS * scroll);
  }

  function set_sustainLength(s:Float):Float
  {
    if (s < 0.0) s = 0.0;

    if (sustainLength == s) return s;
    this.sustainLength = s;
    triggerRedraw();
    return this.sustainLength;
  }

  function triggerRedraw():Void
  {
    graphicHeight = sustainHeight(sustainLength, parentStrumline?.scrollSpeed ?? 1.0);

    updateClipping();
    updateHitbox();
  }

  public override function updateHitbox():Void
  {
    width = graphicWidth;
    height = graphicHeight;

    offset.set(0, 0);
    if (noteStyleOffsets != null)
    {
      if (!usingHazModHolds || parentStrumline == null || parentStrumline.mods == null)
      {
        offset.set(noteStyleOffsets[0], noteStyleOffsets[1]);
      }
    }

    origin.set(width * 0.5, height * 0.5);
  }

  var usingHazModHolds:Bool = true;

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
    if (parentStrumline == null || parentStrumline.mods == null)
    {
      // trace("AW FUCK, THERE IS NO WAY TO SAMPLE MOD DATA!");
      updateClipping_Legacy(songTime);
      return;
    }

    if (usingHazModHolds)
    {
      updateClipping_mods(songTime);
    }
    else
    {
      updateClipping_Legacy(songTime);
    }
  }

  var fakeNote:ZSprite;
  var perspectiveShift:Vector2 = new Vector2(0, 0);

  function resetFakeNote():Void
  {
    fakeNote.x = 0;
    fakeNote.y = 0;
    fakeNote.z = 0;
    fakeNote.angle = 0;
    fakeNote.color = FlxColor.WHITE;

    fakeNote.stealthGlow = 0.0;
    fakeNote.stealthGlowBlue = 1.0;
    fakeNote.stealthGlowGreen = 1.0;
    fakeNote.stealthGlowRed = 1.0;

    fakeNote.skew.x = 0;
    fakeNote.skew.y = 0;

    if (isArrowPath)
    {
      // straightHoldsModAmount = parentStrumline.mods.arrowpathStraightHold[noteDirection % 4];
      fakeNote.alpha = 0;
      fakeNote.scale.set(ModConstants.arrowPathScale, ModConstants.arrowPathScale);
    }
    else
    {
      fakeNote.alpha = 1;
      fakeNote.scale.set(ModConstants.noteScale, ModConstants.noteScale);
    }
  }

  var noteModData:NoteData;

  public var cullMode = TriangleCulling.NONE;

  public var hazCullMode:String = "none";

  public var whichStrumNote:StrumlineNote;

  private var old3Dholds:Bool = false;

  function susSample(t:Float, yJank:Bool = false, isRoot:Bool = false, dumbHeight:Float = 0):Void
  {
    var strumTimmy:Float = t - whichStrumNote.strumExtraModData.strumPos; // parentStrumline.mods.strumPos[noteDirection % 4];

    var notePos:Float = parentStrumline.calculateNoteYPos(strumTimmy, false);
    if (parentStrumline.mods.mathCutOffCheck(notePos, noteDirection % 4)
      || (!isRoot
        && whichStrumNote.strumExtraModData.noHoldMathShortcut < 0.5
        && hitNote
        && !missedNote
        && ((notePos < 0.5 && !Preferences.downscroll) || (notePos > -0.5 && Preferences.downscroll))))
    {
      // if (noteDirection == 0) trace("skipped!");
      return;
    }

    // resetFakeNote(straightHoldsModAmount);
    resetFakeNote();
    dumbHeight = 8; // lol, lmao, fuck you, fix this later

    noteModData.defaultValues();
    noteModData.setValuesFromZSprite(fakeNote);
    noteModData.strumTime = strumTimmy;
    noteModData.direction = noteDirection % Strumline.KEY_COUNT;
    noteModData.curPos_unscaled = notePos;

    noteModData.whichStrumNote = whichStrumNote;

    var straightHoldsModAmount:Float = isArrowPath ? whichStrumNote.strumExtraModData.arrowpathStraightHold : whichStrumNote.strumExtraModData.straightHolds;

    var scrollMult:Float = 1.0;
    // for (mod in modifiers){
    for (mod in parentStrumline.mods.mods_speed)
    {
      if (mod.targetLane != -1 && noteModData.direction != mod.targetLane) continue;
      scrollMult *= mod.speedMath(noteModData.direction, noteModData.curPos_unscaled, parentStrumline, true);
    }
    noteModData.speedMod = scrollMult;

    noteModData.x = noteModData.whichStrumNote.x + parentStrumline.mods.getHoldOffsetX(isArrowPath, graphicWidth);
    var sillyPos:Float = parentStrumline.calculateNoteYPos(noteModData.strumTime, true) * scrollMult;
    if (Preferences.downscroll)
    {
      noteModData.y = (noteModData.whichStrumNote.y + sillyPos + Strumline.STRUMLINE_SIZE / 2);
    }
    else
    {
      noteModData.y = (noteModData.whichStrumNote.y - Strumline.INITIAL_OFFSET + sillyPos + Strumline.STRUMLINE_SIZE / 2);
    }
    noteModData.z = noteModData.whichStrumNote.z;
    noteModData.curPos = sillyPos;

    noteModData.x -= noteModData.whichStrumNote.strumExtraModData.noteStyleOffsetX; // undo strum offset
    noteModData.y -= noteModData.whichStrumNote.strumExtraModData.noteStyleOffsetY;

    for (mod in (isArrowPath ? parentStrumline.mods.mods_arrowpath : parentStrumline.mods.mods_notes))
    {
      if (mod.targetLane != -1 && noteModData.direction != mod.targetLane) continue;
      mod.noteMath(noteModData, parentStrumline, true, isArrowPath);
    }

    for (mod in noteModData.noteMods)
    {
      if (mod.targetLane != -1 && noteModData.direction != mod.targetLane) continue;
      mod.noteMath(noteModData, parentStrumline, true, isArrowPath);
    }

    noteModData.funnyOffMyself();

    is3D = (noteModData.whichStrumNote?.strumExtraModData?.threeD ?? false);
    old3Dholds = (noteModData.whichStrumNote?.strumExtraModData?.old3Dholds ?? false);
    // is3D = false;

    noteModData.x -= noteStyleOffsets[0]; // apply notestyle offset here for z math reasons lol
    noteModData.y -= noteStyleOffsets[1];

    fakeNote.applyNoteData(noteModData, !is3D);
    if (Preferences.downscroll) fakeNote.y += 27; // fix gap for downscroll lol Moved from verts so it is applied before perspective fucks it up!

    var rememberMe:Vector2 = new Vector2(fakeNote.x, fakeNote.y);

    if (old3Dholds || !is3D) applyPerspective(fakeNote, graphicWidth, dumbHeight);

    // caluclate diff
    perspectiveShift.x = fakeNote.x - rememberMe.x;
    perspectiveShift.y = fakeNote.y - rememberMe.y;

    // var notePosModified:Float = parentStrumline.mods.makeHoldCopyStrum_sample(fakeNote, strumTimmy, noteDirection, parentStrumline, notePos, isArrowPath);
    // parentStrumline.mods.sampleModMath(fakeNote, strumTimmy, noteDirection, parentStrumline, true, yJank, notePosModified, isArrowPath, graphicWidth,
    //  dumbHeight);

    var scaleX = FlxMath.remapToRange(fakeNote.scale.x, 0, isArrowPath ? ModConstants.arrowPathScale : ModConstants.noteScale, 0, 1);
    var scaleY = FlxMath.remapToRange(fakeNote.scale.y, 0, isArrowPath ? ModConstants.arrowPathScale : ModConstants.noteScale, 0, 1);

    switch (hazCullMode)
    {
      case "positive" | "back":
        if (scaleX < 0) scaleX = 0;
        if (scaleY < 0) scaleY = 0;
      case "negative" | "front":
        if (scaleX > 0) scaleX = 0;
        if (scaleY > 0) scaleY = 0;
    }

    // fakeNote.scale.set(scaleX, scaleY);

    if (!isRoot || straightHoldsModAmount == 0)
    {
      fakeNote.x = FlxMath.lerp(fakeNote.x, holdRootX, straightHoldsModAmount);
      // fakeNote.y = FlxMath.lerp(fakeNote.y, holdRootY, straightHoldsModAmount);
      fakeNote.z = FlxMath.lerp(fakeNote.z, holdRootZ, straightHoldsModAmount);
      fakeNote.angle = FlxMath.lerp(fakeNote.x, holdRootAngle, straightHoldsModAmount);
      scaleX = FlxMath.lerp(scaleX, holdRootScaleX, straightHoldsModAmount);
      scaleY = FlxMath.lerp(scaleY, holdRootScaleY, straightHoldsModAmount);
      fakeNote.scale.set(scaleX, scaleY);
    }
    else
    {
      holdRootX = fakeNote.x;
      holdRootY = fakeNote.y;
      holdRootZ = fakeNote.z;
      holdRootAngle = fakeNote.angle;
      // holdRootAlpha = fakeNote.alpha
      holdRootScaleX = scaleX;
      holdRootScaleY = scaleY;
      fakeNote.scale.set(scaleX, scaleY);
    }

    // temp fix for sus notes covering the entire fucking screen
    if (fakeNote.z > 825)
    {
      // fakeNote.x = 0;
      // fakeNote.y = 0;
      fakeNote.alpha = 0;
      fakeNote.scale.set(0.0, 0.0);
    }
  }

  var is3D:Bool = false;

  function applyPerspective(pos:Vector3D, rotatePivot:Vector2):Vector2
  {
    if (!is3D || old3Dholds)
    {
      return new Vector2(pos.x, pos.y);
    }
    else
    {
      var pos_modified:Vector3D = new Vector3D(pos.x, pos.y, pos.z);

      var angleY:Float = noteModData.angleY;
      var angleX:Float = 0;

      // Already done with spiral holds lol
      // var rotateModPivotPoint:Vector2 = new Vector2(rotatePivot.x, rotatePivot.y);
      // var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.y), angleZ);
      // pos_modified.x = thing.x;
      // pos_modified.y = thing.y;

      var rotateModPivotPoint:Vector2 = new Vector2(rotatePivot.x, pos_modified.z); // x, z
      var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.z), angleY);
      pos_modified.x = thing.x;
      pos_modified.z = thing.y;
      // pos_modified.x += thing.x - pos_modified.x;
      // pos_modified.z += thing.y - pos_modified.y;

      if (angleX == 0 && false)
      {
        var rotateModPivotPoint:Vector2 = new Vector2(rotatePivot.x, rotatePivot.y);
        var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.z, pos_modified.y), angleX);
        pos_modified.z = thing.x;
        pos_modified.y = thing.y;
      }

      // pos_modified.x -= offset.x;
      // pos_modified.y -= offset.y;

      pos_modified.z *= 0.001;
      var thisNotePos:Vector3D = perspectiveMath(pos_modified, 0, 0);
      return new Vector2(thisNotePos.x, thisNotePos.y);
    }
  }

  var spiralHoldOldMath:Bool = false;
  private var tinyOffsetForSpiral:Float = 5.0;

  private var holdRootX:Float = 0.0;
  private var holdRootY:Float = 0.0;
  private var holdRootZ:Float = 0.0;
  private var holdRootAngle:Float = 0.0;
  // private var holdRootAlpha:Float = 0.0;
  private var holdRootScaleX:Float = 0.0;
  private var holdRootScaleY:Float = 0.0;

  private function clipTimeThing(songTimmy:Float, strumtimm:Float, piece:Int = 0):Float
  {
    var returnVal:Float = 0.0;
    // if (hitNote && !missedNote) returnVal = songTimmy - strumTime;
    if (!(hitNote && !missedNote)) return 0.0;
    if (songTimmy >= strumtimm)
    {
      returnVal = songTimmy - strumtimm;
      returnVal -= tinyOffsetForSpiral * piece;
    }
    if (returnVal < 0) returnVal = 0;
    return returnVal;
  }

  // If set to false, will disable the hold being hidden when being dropped
  public var hideOnMiss:Bool = true;

  // The angle the hold note is coming from with spiral holds! used for hold covers!
  public var baseAngle:Float = 0;

  /**
   * Sets up new vertex and UV data to clip the trail.
   * @param songTime	The time to clip the note at, in milliseconds.
   * @param uvSetup	Should UV's be updated?.
   */
  public function updateClipping_mods(songTime:Float = 0, uvSetup:Bool = true):Void
  {
    whichStrumNote = parentStrumline.getByIndex(noteDirection);

    if (fakeNote == null) fakeNote = new ZSprite();

    var holdGrain:Float = isArrowPath ? (whichStrumNote?.strumExtraModData?.pathGrain ?? 95) : (whichStrumNote?.strumExtraModData?.holdGrain ?? 82);
    var songTimmy:Float = (Conductor?.instance?.songPosition ?? songTime);

    var longHolds:Float = 0;
    if (!isArrowPath)
    {
      longHolds = whichStrumNote.strumExtraModData?.longHolds ?? 0;
      // longHolds = parentStrumline?.mods?.longHolds[noteDirection % 4] ?? 0;
      if (longHolds != 0)
      {
        var percentageTillCompletion_part:Float = 0;
        if (songTimmy >= strumTime) percentageTillCompletion_part = songTimmy - strumTime;
        if (percentageTillCompletion_part < 0) percentageTillCompletion_part = 0;
        var percentageTillCompletion:Float = percentageTillCompletion_part / fullSustainLength;
        percentageTillCompletion = FlxMath.bound(percentageTillCompletion, 0, 1); // clamp
        percentageTillCompletion = 1 - percentageTillCompletion;
        longHolds *= percentageTillCompletion;
      }
    }
    longHolds += 1;

    var holdResolution:Int = Math.floor(fullSustainLength * longHolds / holdGrain);

    if (holdResolution < 1) // To ensure UV's to break (lol???)
    {
      holdResolution = 1;
    }

    var holdNoteJankX:Float = ModConstants.holdNoteJankX * -1;
    var holdNoteJankY:Float = ModConstants.holdNoteJankY * -1;

    // var spiralHolds:Bool = parentStrumline?.mods?.spiralHolds[noteDirection % 4] ?? false;
    var spiralHolds:Bool = (isArrowPath ? (whichStrumNote.strumExtraModData?.spiralPaths ?? false) : (whichStrumNote.strumExtraModData?.spiralHolds ?? false));

    var testCol:Array<Int> = [];
    var vertices:Array<Float> = [];
    var uvtData:Array<Float> = [];
    var noteIndices:Array<Int> = [];

    var dumbAlt:Bool = true;

    for (i in 0...Std.int(holdResolution * 2))
    {
      // for (k in 0...3)
      // {
      //  noteIndices.push(i + k);
      // }
      if (dumbAlt)
      {
        noteIndices.push(i + 0);
        noteIndices.push(i + 2);
        noteIndices.push(i + 1);
      }
      else
      {
        noteIndices.push(i + 0);
        noteIndices.push(i + 1);
        noteIndices.push(i + 2);
      }
      dumbAlt = !dumbAlt;
    }
    // add cap
    var highestNumSoFar_:Int = Std.int((holdResolution * 2) - 1 + 2);
    noteIndices.push(highestNumSoFar_ + 0 + 1);
    noteIndices.push(highestNumSoFar_ + 2 + 1);
    noteIndices.push(highestNumSoFar_ + 1 + 1);

    noteIndices.push(highestNumSoFar_ + 0 + 2);
    noteIndices.push(highestNumSoFar_ + 1 + 2);
    noteIndices.push(highestNumSoFar_ + 2 + 2);

    // for (k in 0...3)
    // {
    //  noteIndices.push(highestNumSoFar_ + k + 2);
    // }

    var clipHeight:Float = FlxMath.bound(sustainHeight(sustainLength - (songTime - strumTime), parentStrumline?.scrollSpeed ?? 1.0), 0, graphicHeight);
    if (clipHeight <= 0.1)
    {
      visible = false;
      return;
    }
    else
    {
      visible = true;
    }

    // lmao, make it invisible if we dropped a hold. Done using alpha in base game but since alpha is being used, we need to use visible instead
    if (hitNote && missedNote && hideOnMiss)
    {
      visible = false;
      return; // Update v0.7.3 -> No need to do any more math / code if it's going to not be seen lol
    }

    var sussyLength:Float = fullSustainLength;
    var holdWidth = graphicWidth;
    // var scaleTest = fakeNote.scale.x;
    // var holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
    // var holdRightSide = holdWidth * scaleTest;

    var clippingTimeOffset:Float = clipTimeThing(songTimmy, strumTime);

    var bottomHeight:Float = graphic.height * zoom * endOffset;
    var partHeight:Float = clipHeight - bottomHeight;

    susSample(this.strumTime + clippingTimeOffset, false, true, 0);
    var scaleTest = fakeNote.scale.x;
    var widthScaled = holdWidth * scaleTest;
    var scaleChange = widthScaled - holdWidth;
    var holdLeftSide = 0 - (scaleChange / 2);
    var holdRightSide = widthScaled - (scaleChange / 2);

    // scaleTest = fakeNote.scale.x;
    // holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
    // holdRightSide = holdWidth * scaleTest;

    // ===HOLD VERTICES==
    // var uvHeight = (-partHeight) / graphic.height / zoom;
    // V0.7.4a -> Updated UV textures to not be stupid anymore. (0 -> 1 -> 2 -> 3) since we can just use the repeating texture power of drawTriangles.

    // just copy it from source idgaf
    if (uvSetup)
    {
      uvtData[0 * 2] = (1 / 4) * (noteDirection % 4); // 0%/25%/50%/75% of the way through the image
      uvtData[0 * 2 + 1] = 0; // top bound
      // Top left

      // Top right
      uvtData[1 * 2] = uvtData[0 * 2] + (1 / 8); // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
      uvtData[1 * 2 + 1] = uvtData[0 * 2 + 1]; // top bound
    }

    // grab left vert
    var rotateOrigin:Vector2 = new Vector2(fakeNote.x + holdLeftSide, fakeNote.y);
    // move rotateOrigin to be inbetween the left and right vert so it's centered
    rotateOrigin.x += ((fakeNote.x + holdRightSide) - (fakeNote.x + holdLeftSide)) / 2;
    var vert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdLeftSide, fakeNote.y, fakeNote.z), rotateOrigin);

    // Top left
    vertices[0 * 2] = vert.x; // Inline with left side
    // vertices[0 * 2 + 1] = flipY ? clipHeight : graphicHeight - clipHeight;
    vertices[0 * 2 + 1] = vert.y;

    testCol[0 * 2] = fakeNote.color;
    testCol[0 * 2 + 1] = fakeNote.color;
    testCol[1 * 2] = fakeNote.color;
    testCol[1 * 2 + 1] = fakeNote.color;

    this.color = fakeNote.color;
    // if (!isArrowPath)
    // {
    this.alpha = fakeNote.alpha;
    // }
    this.z = fakeNote.z; // for z ordering

    if (useShader && this.hsvShader != null)
    {
      this.hsvShader.stealthGlow = fakeNote.stealthGlow;
      this.hsvShader.stealthGlowBlue = fakeNote.stealthGlowBlue;
      this.hsvShader.stealthGlowGreen = fakeNote.stealthGlowGreen;
      this.hsvShader.stealthGlowRed = fakeNote.stealthGlowRed;
    }

    // Top right
    vert = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
    vertices[1 * 2] = vert.x;
    vertices[1 * 2 + 1] = vert.y; // Inline with top left vertex

    var holdPieceStrumTime:Float = 0.0;

    var previousSampleX:Float = fakeNote.x;
    var previousSampleY:Float = fakeNote.y;

    var rightSideOffX:Float = 0;
    var rightSideOffY:Float = 0;

    // var rememberMeX:Float = 0;
    // var rememberMeY:Float = 0;

    // THE REST, HOWEVER...
    for (k in 0...holdResolution)
    {
      var i:Int = (k + 1) * 2;

      holdPieceStrumTime = this.strumTime + ((sussyLength / holdResolution) * (k + 1) * longHolds);
      var tm:Float = holdPieceStrumTime;
      if (spiralHolds && !spiralHoldOldMath)
      {
        tm += (k + 1) * tinyOffsetForSpiral; // ever so slightly offset the time so that it never hits 0, 0 on the strum time so spiral hold can do its magic
      }
      susSample(tm + clipTimeThing(songTimmy, holdPieceStrumTime), true, false, sussyLength / holdResolution);

      // susSample(this.strumTime + clippingTimeOffset + ((sussyLength / holdResolution) * (k + 1)), true);
      // scaleTest = fakeNote.scale.x;
      // holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
      // holdRightSide = holdWidth * scaleTest;

      scaleTest = fakeNote.scale.x;
      widthScaled = holdWidth * scaleTest;
      scaleChange = widthScaled - holdWidth;
      holdLeftSide = 0 - (scaleChange / 2);
      holdRightSide = widthScaled - (scaleChange / 2);

      // grab left vert
      var rotateOrigin:Vector2 = new Vector2(fakeNote.x + holdLeftSide, fakeNote.y);
      // move rotateOrigin to be inbetween the left and right vert so it's centered
      rotateOrigin.x += ((fakeNote.x + holdRightSide) - (fakeNote.x + holdLeftSide)) / 2;

      var vert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdLeftSide, fakeNote.y, fakeNote.z), rotateOrigin);

      // Bottom left
      vertices[i * 2] = vert.x; // Inline with left side
      vertices[i * 2 + 1] = vert.y;

      if (spiralHolds && spiralHoldOldMath)
      {
        var calculateAngleDif:Float = 0;
        var a:Float = (fakeNote.y - previousSampleY) * -1; // height
        var b:Float = (fakeNote.x - previousSampleX); // length
        var angle:Float = Math.atan(b / a);
        angle *= (180 / Math.PI);
        calculateAngleDif = angle;
        var thing:Vector2 = ModchartUtil.rotateAround(new Vector2(vertices[i * 2], vertices[i * 2 + 1]),
          new Vector2(fakeNote.x + holdRightSide, vertices[i * 2 + 1]), calculateAngleDif);
        rightSideOffX = thing.x;
        rightSideOffY = thing.y;
        previousSampleX = fakeNote.x;
        previousSampleY = fakeNote.y;
        if (k == 0) // to orient the root of the hold properly!
        {
          var scuffedDifferenceX:Float = fakeNote.x + holdRightSide - rightSideOffX;
          var scuffedDifferenceY:Float = vertices[i * 2 + 1] - rightSideOffY;
          vertices[(i + 1 - 2) * 2] -= scuffedDifferenceX;
          vertices[(i + 1 - 2) * 2 + 1] -= scuffedDifferenceY;
          // rememberMeX = scuffedDifferenceX;
          // rememberMeY = scuffedDifferenceY;
        }
        // Bottom right
        vertices[(i + 1) * 2] = rightSideOffX;
        vertices[(i + 1) * 2 + 1] = rightSideOffY;
      }
      else if (spiralHolds)
      {
        var affectRoot:Bool = (k == 0);
        var a:Float = (fakeNote.y - previousSampleY) * -1; // height
        var b:Float = (fakeNote.x - previousSampleX); // length
        var angle:Float = Math.atan2(b, a);
        var calculateAngleDif:Float = angle * (180 / Math.PI);

        // rotate right point
        // var rvert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
        var rotatePoint:Vector2 = new Vector2(fakeNote.x + holdRightSide, fakeNote.y);
        var thing:Vector2 = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
        thing = applyPerspective(new Vector3D(thing.x, thing.y, fakeNote.z), rotateOrigin);
        rightSideOffX = thing.x;
        rightSideOffY = thing.y;

        // Bottom right
        vertices[(i + 1) * 2] = rightSideOffX;
        vertices[(i + 1) * 2 + 1] = rightSideOffY;

        // left
        rotatePoint = new Vector2(fakeNote.x + holdLeftSide, fakeNote.y);
        thing = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
        thing = applyPerspective(new Vector3D(thing.x, thing.y, fakeNote.z), rotateOrigin);
        rightSideOffX = thing.x;
        rightSideOffY = thing.y;

        vertices[(i) * 2] = rightSideOffX;
        vertices[(i) * 2 + 1] = rightSideOffY;

        if (affectRoot)
        {
          baseAngle = calculateAngleDif;

          var rotateOrigin_rooter:Vector2 = new Vector2(vertices[(i - 2) * 2], vertices[(i - 2) * 2 + 1]);
          // move rotateOrigin to be inbetween the left and right vert so it's centered
          rotateOrigin_rooter.x += (vertices[(i - 2 + 1) * 2] - vertices[(i - 2) * 2]) / 2;

          rotatePoint = new Vector2(vertices[(i - 2) * 2], vertices[(i - 2) * 2 + 1]);
          thing = ModchartUtil.rotateAround(rotateOrigin_rooter, rotatePoint, calculateAngleDif);

          vertices[(i - 2) * 2] = thing.x;
          vertices[(i - 2) * 2 + 1] = thing.y;

          rotatePoint = new Vector2(vertices[(i - 2 + 1) * 2], vertices[(i - 2 + 1) * 2 + 1]);
          thing = ModchartUtil.rotateAround(rotateOrigin_rooter, rotatePoint, calculateAngleDif);

          vertices[(i - 2 + 1) * 2] = thing.x;
          vertices[(i - 2 + 1) * 2 + 1] = thing.y;
        }
        previousSampleX = fakeNote.x;
        previousSampleY = fakeNote.y;
      }
      else
      {
        // Bottom right
        var vert:Vector2 = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
        vertices[(i + 1) * 2] = vert.x;
        vertices[(i + 1) * 2 + 1] = vert.y;
      }

      testCol[i * 2] = fakeNote.color;
      testCol[i * 2 + 1] = fakeNote.color;
      testCol[(i + 1) * 2] = fakeNote.color;
      testCol[(i + 1) * 2 + 1] = fakeNote.color;
    }

    if (uvSetup)
    {
      for (k in 0...holdResolution)
      {
        var i = (k + 1) * 2;

        // Bottom left
        uvtData[i * 2] = uvtData[0 * 2]; // 0%/25%/50%/75% of the way through the image
        uvtData[i * 2 + 1] = 1 * (k + 1);

        // Bottom right
        uvtData[(i + 1) * 2] = uvtData[1 * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left)
        uvtData[(i + 1) * 2 + 1] = uvtData[i * 2 + 1]; // bottom bound
      }
    }

    // === END CAP VERTICES ===

    var endvertsoftrail:Int = (holdResolution * 2);
    var highestNumSoFar:Int = endvertsoftrail + 2;

    // TODO - FIX HOLD ENDS MOD SAMPLE TIME!
    var sillyEndOffset = (graphic.height * (endOffset) * zoom);

    // just some random magic number for now. Don't know how to convert the pixels / height into strumTime
    sillyEndOffset = sillyEndOffset / (0.45 * parentStrumline?.scrollSpeed ?? 1.0);

    sillyEndOffset *= 1.9; // MAGIC NUMBER IDFK

    // sillyEndOffset = sustainHeight(sustainLength, getScrollSpeed());

    // pixels = (susLength * 0.45 * getScrollSpeed());
    // sillyEndOffset = (? * 0.45)
    // ? = sillyEndOffset / (0.45 * getScrollSpeed());

    holdPieceStrumTime = this.strumTime + (sussyLength * longHolds) + sillyEndOffset;
    var tm_end:Float = holdPieceStrumTime;
    if (spiralHolds && !spiralHoldOldMath)
    {
      tm_end += holdResolution * tinyOffsetForSpiral; // ever so slightly offset the time so that it never hits 0, 0 on the strum time so spiral hold can do its magic
    }
    susSample(tm_end + clipTimeThing(songTimmy, holdPieceStrumTime), true, false, sillyEndOffset);

    scaleTest = fakeNote.scale.x;
    widthScaled = holdWidth * scaleTest;
    scaleChange = widthScaled - holdWidth;
    holdLeftSide = 0 - (scaleChange / 2);
    holdRightSide = widthScaled - (scaleChange / 2);

    // scaleTest = fakeNote.scale.x;
    // holdLeftSide = (holdWidth * (scaleTest - 1)) * -1;
    // holdRightSide = holdWidth * scaleTest;

    // Top left
    vertices[highestNumSoFar * 2] = vertices[endvertsoftrail * 2]; // Inline with bottom left vertex of hold
    vertices[highestNumSoFar * 2 + 1] = vertices[endvertsoftrail * 2 + 1]; // Inline with bottom left vertex of hold
    testCol[highestNumSoFar * 2] = testCol[endvertsoftrail * 2];
    testCol[highestNumSoFar * 2 + 1] = testCol[endvertsoftrail * 2 + 1];

    // vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
    // vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

    // Top right
    highestNumSoFar += 1;
    vertices[highestNumSoFar * 2] = vertices[(endvertsoftrail + 1) * 2]; // Inline with bottom right vertex of hold
    vertices[highestNumSoFar * 2 + 1] = vertices[(endvertsoftrail + 1) * 2 + 1]; // Inline with bottom right vertex of hold
    testCol[highestNumSoFar * 2] = testCol[(endvertsoftrail + 1) * 2]; // Inline with bottom right vertex of hold
    testCol[highestNumSoFar * 2 + 1] = testCol[(endvertsoftrail + 1) * 2 + 1]; // Inline with bottom right vertex of hold

    // vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
    // vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

    // Bottom left
    highestNumSoFar += 1;

    // grab left vert
    var rotateOrigin:Vector2 = new Vector2(fakeNote.x + holdLeftSide, fakeNote.y);
    // move rotateOrigin to be inbetween the left and right vert so it's centered
    rotateOrigin.x += ((fakeNote.x + holdRightSide) - (fakeNote.x + holdLeftSide)) / 2;

    vert = applyPerspective(new Vector3D(fakeNote.x + holdLeftSide, fakeNote.y, fakeNote.z), rotateOrigin);
    vertices[highestNumSoFar * 2] = vert.x;
    vertices[highestNumSoFar * 2 + 1] = vert.y;
    testCol[highestNumSoFar * 2] = fakeNote.color;
    testCol[highestNumSoFar * 2 + 1] = fakeNote.color;

    // vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
    // vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

    // Bottom right
    highestNumSoFar += 1;
    vert = applyPerspective(new Vector3D(fakeNote.x + holdRightSide, fakeNote.y, fakeNote.z), rotateOrigin);
    vertices[highestNumSoFar * 2] = vert.x;
    vertices[highestNumSoFar * 2 + 1] = vert.y;
    testCol[highestNumSoFar * 2] = fakeNote.color;
    testCol[highestNumSoFar * 2 + 1] = fakeNote.color;
    if (spiralHolds && !spiralHoldOldMath)
    {
      var a:Float = (fakeNote.y - previousSampleY) * -1; // height
      var b:Float = (fakeNote.x - previousSampleX); // length
      var angle:Float = Math.atan2(b, a);
      var calculateAngleDif:Float = angle * (180 / Math.PI);

      var ybeforerotate:Float = vertices[(highestNumSoFar - 1) * 2 + 1];

      // grab left vert
      var rotateOrigin:Vector2 = new Vector2(vertices[(highestNumSoFar - 1) * 2], vertices[(highestNumSoFar - 1) * 2 + 1]);
      // move rotateOrigin to be inbetween the left and right vert so it's centered
      rotateOrigin.x += (vertices[highestNumSoFar * 2] - rotateOrigin.x) / 2;

      // rotate right point
      // var rotatePoint:Vector2 = new Vector2(fakeNote.x + holdRightSide,vertices[i * 2+1]);
      var rotatePoint:Vector2 = new Vector2(vertices[highestNumSoFar * 2], vertices[highestNumSoFar * 2 + 1]);

      var thing:Vector2 = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);

      vertices[highestNumSoFar * 2 + 1] = thing.y;
      vertices[highestNumSoFar * 2] = thing.x;

      rotatePoint = new Vector2(vertices[(highestNumSoFar - 1) * 2], ybeforerotate);
      thing = ModchartUtil.rotateAround(rotateOrigin, rotatePoint, calculateAngleDif);
      vertices[(highestNumSoFar - 1) * 2 + 1] = thing.y;
      vertices[(highestNumSoFar - 1) * 2] = thing.x;
    }
    else if (spiralHolds && spiralHoldOldMath)
    {
      var calculateAngleDif:Float = 0;
      var a:Float = (fakeNote.y - previousSampleY) * -1; // height
      var b:Float = (fakeNote.x - previousSampleX); // length
      var angle:Float = Math.atan(b / a);
      angle *= (180 / Math.PI);
      calculateAngleDif = angle;

      var thing:Vector2 = ModchartUtil.rotateAround(new Vector2(vertices[(highestNumSoFar - 1) * 2], vertices[(highestNumSoFar - 1) * 2 + 1]),
        new Vector2(vertices[highestNumSoFar * 2], vertices[highestNumSoFar * 2 + 1]), calculateAngleDif);
      vertices[highestNumSoFar * 2 + 1] = thing.y;
      vertices[highestNumSoFar * 2] = thing.x;
    }

    // vertices[highestNumSoFar * 2] = holdNoteJankX * -1;
    // vertices[highestNumSoFar * 2 + 1] = holdNoteJankY * -1;

    if (uvSetup)
    {
      highestNumSoFar = (holdResolution * 2) + 2;

      // === END CAP UVs ===
      // Top left
      uvtData[highestNumSoFar * 2] = uvtData[2 * 2] + (1 / 8); // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
      uvtData[highestNumSoFar * 2 + 1] = if (partHeight > 0)
      {
        0;
      }
      else
      {
        (bottomHeight - clipHeight) / zoom / graphic.height;
      };

      // Top right
      uvtData[(highestNumSoFar + 1) * 2] = uvtData[highestNumSoFar * 2] +
        (1 / 8); // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
      uvtData[(highestNumSoFar + 1) * 2 + 1] = uvtData[highestNumSoFar * 2 + 1]; // top bound

      // Bottom left
      uvtData[(highestNumSoFar +
        2) * 2] = uvtData[highestNumSoFar * 2]; // 12.5%/37.5%/62.5%/87.5% of the way through the image (1/8th past the top left of hold)
      uvtData[(highestNumSoFar + 2) * 2 + 1] = bottomClip; // bottom bound

      // Bottom right
      uvtData[(highestNumSoFar + 3) * 2] = uvtData[(highestNumSoFar + 1) * 2]; // 25%/50%/75%/100% of the way through the image (1/8th past the top left of cap)
      uvtData[(highestNumSoFar + 3) * 2 + 1] = uvtData[(highestNumSoFar + 2) * 2 + 1]; // bottom bound
    }

    for (k in 0...vertices.length)
    {
      if (k % 2 == 1)
      { // all y verts
        vertices[k] += holdNoteJankY;
        // if (Preferences.downscroll) vertices[k] += 23; // fix gap for downscroll lol
      }
      else
      {
        vertices[k] += holdNoteJankX;
      }

      // holdStripVerts_.vertices.push(vertices[k]);
    }

    this.vertices = new DrawData<Float>(vertices.length - 0, true, vertices);
    this.indices = new DrawData<Int>(noteIndices.length - 0, true, noteIndices);
    this.colors = new DrawData<Int>(testCol.length - 0, true, testCol);
    if (uvSetup)
    {
      this.uvtData = new DrawData<Float>(uvtData.length - 0, true, uvtData);
      uvtData = null;
    }
    testCol = null;
    noteIndices = null;
    vertices = null;
  }

	public var zNear:Float = 0.0;
	public var zFar:Float = 100.0;

    // https://github.com/TheZoroForce240/FNF-Modcharting-Tools/blob/main/source/modcharting/ModchartUtil.hx
    public function perspectiveMath(pos:Vector3D, offsetX:Float = 0, offsetY:Float = 0):Vector3D
    {
        try
        {
            var _FOV:Float = this.fov;

            _FOV *= (Math.PI / 180.0);

            var newz:Float = pos.z - 1;
            var zRange:Float = zNear - zFar;
            var tanHalfFOV:Float = 1;
            var dividebyzerofix:Float = FlxMath.fastCos(_FOV * 0.5);
            if (dividebyzerofix != 0)
            {
                tanHalfFOV = FlxMath.fastSin(_FOV * 0.5) / dividebyzerofix;
            }

            if (pos.z > 1) newz = 0;

            var xOffsetToCenter:Float = pos.x - (FlxG.width * 0.5);
            var yOffsetToCenter:Float = pos.y - (FlxG.height * 0.5);

            var zPerspectiveOffset:Float = (newz + (2 * zFar * zNear / zRange));

            // divide by zero check
            if (zPerspectiveOffset == 0) zPerspectiveOffset = 0.001;

            xOffsetToCenter += (offsetX * -zPerspectiveOffset);
            yOffsetToCenter += (offsetY * -zPerspectiveOffset);

            xOffsetToCenter += (0 * -zPerspectiveOffset);
            yOffsetToCenter += (0 * -zPerspectiveOffset);

            var xPerspective:Float = xOffsetToCenter * (1 / tanHalfFOV);
            var yPerspective:Float = yOffsetToCenter * tanHalfFOV;
            xPerspective /= -zPerspectiveOffset;
            yPerspective /= -zPerspectiveOffset;

            pos.x = xPerspective + (FlxG.width * 0.5);
            pos.y = yPerspective + (FlxG.height * 0.5);
            pos.z = zPerspectiveOffset;
            return pos;
        }
        catch (e)
        {
            trace("OH GOD OH FUCK IT NEARLY DIED CUZ OF: \n" + e.toString());
            return pos;
        }
    }

  /**
   * Sets up new vertex and UV data to clip the trail.
   * If flipY is true, top and bottom bounds swap places.
   * @param songTime	The time to clip the note at, in milliseconds.
   */
  public function updateClipping_Legacy(songTime:Float = 0):Void
  {
    var clipHeight:Float = FlxMath.bound(sustainHeight(sustainLength - (songTime - strumTime), parentStrumline?.scrollSpeed ?? 1.0), 0, graphicHeight);
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
    if (alpha == 0 || graphic == null || vertices == null || !this.alive) return;

    for (camera in cameras)
    {
      if (!camera.visible || !camera.exists) continue;
      // if (!isOnScreen(camera)) continue; // TODO: Update this code to make it work properly.

      // if (is3D) getScreenPosition(_point, camera)
      // else
      getScreenPosition(_point, camera).subtractPoint(offset);

      camera.drawTriangles(processedGraphic, vertices, indices, uvtData, colors, _point, blend, true, antialiasing, colorTransform, hsvShader, cullMode);

      // camera.drawTriangles(graphicToUse, vertices, indices, uvtData, null, _point, blend, textureRepeat, antialiasing,
      //   spriteGraphic?.colorTransform ?? colorTransform, spriteGraphic?.shader ?? null, c);
    }

    #if FLX_DEBUG
    if (FlxG.debugger.drawDebug) drawDebug();
    #end
  }

  public override function kill():Void
  {
    super.kill();

    strumTime = 0;
    noteDirection = 0;
    sustainLength = 0;
    fullSustainLength = 0;
    noteData = null;

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
    noteData = null;

    hitNote = false;
    missedNote = false;
    handledMiss = false;
  }

  public override function destroy():Void
  {
    vertices = null;
    indices = null;
    uvtData = null;
    if (processedGraphic != null) processedGraphic.destroy();

    super.destroy();
  }

  override function updateColorTransform():Void
  {
    super.updateColorTransform();

    // if (processedGraphic != null) processedGraphic.destroy();

    if (processedGraphic == null)
    {
      processedGraphic = FlxGraphic.fromGraphic(graphic, true);
      // processedGraphic.bitmap.colorTransform(processedGraphic.bitmap.rect, colorTransform);
    }
    if (useShader && this.hsvShader == null)
    {
      this.hsvShader = new HSVShader();
    }
  }

  public function desaturate():Void
  {
    this.hsvShader.saturation = 0.2;
  }

  public function setHue(hue:Float):Void
  {
    this.hsvShader.hue = hue;
  }

  var useShader:Bool = true;
  var hsvShader:HSVShader = null;
}