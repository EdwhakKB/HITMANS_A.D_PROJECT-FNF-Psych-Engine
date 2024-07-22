package modcharting;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.tile.FlxDrawTrianglesItem;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxDirectionFlags;
// import funkin.graphics.ZSprite;
// import funkin.play.modchartSystem.ModchartUtil;
import lime.math.Vector2;
import openfl.geom.Matrix;
import openfl.display.TriangleCulling;
import openfl.geom.Vector3D;

class ZProjectSprite_Note extends FlxSprite
{
  public var z:Float = 0.0;

  // If set, will reference this sprites graphic! Very useful for animations!
  public var spriteGraphic(default, set):FlxSprite;

  function set_spriteGraphic(value:FlxSprite):FlxSprite
  {
    spriteGraphic = value;
    // if (spriteGraphic != null)
    // {
    //	loadGraphic(spriteGraphic.updateFramePixels());
    // setUp();
    // }
    return spriteGraphic;
  }

  public var projectionEnabled:Bool = true;
  public var autoOffset:Bool = false;

  public var originalWidthHeight:Vector2;

  public var angleX:Float = 0;
  public var angleY:Float = 0;
  public var angleZ:Float = 0;

  public var scaleX:Float = 1;
  public var scaleY:Float = 1;
  public var scaleZ:Float = 1;

  public var skewX:Float = 0;
  public var skewY:Float = 0;
  public var skewZ:Float = 0;

  // in %
  public var skewX_offset:Float = 0.5;
  public var skewY_offset:Float = 0.5;
  public var skewZ_offset:Float = 0.5;

  public var moveX:Float = 0;
  public var moveY:Float = 0;
  public var moveZ:Float = 0;

  public var fovOffsetX:Float = 0;
  public var fovOffsetY:Float = 0;
  // public var fovOffsetZ:Float = 0;
  public var pivotOffsetX:Float = 0;
  public var pivotOffsetY:Float = 0;
  public var pivotOffsetZ:Float = 0;

  // public var topleft:Vector3D = new Vector3D(-1, -1, 0);
  // public var topright:Vector3D = new Vector3D(1, -1, 0);
  // public var bottomleft:Vector3D = new Vector3D(-1, 1, 0);
  // public var bottomright:Vector3D = new Vector3D(1, 1, 0);
  // public var middlePoint:Vector3D = new Vector3D(0.5, 0.5, 0);
  public var fov:Float = 90;

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

  public var processedGraphic:FlxGraphic;

  public var subdivisions:Int = 5;

  static final TRIANGLE_VERTEX_INDICES:Array<Int> = [
    0, 5, 1, 5, 1, 6, 1, 6, 2, 6, 2, 7, 2, 7, 3, 7, 3, 8, 3, 8, 4, 8, 4, 9, 5, 10, 6, 10, 6, 11, 6, 11, 7, 11, 7, 12, 7, 12, 8, 12, 8, 13, 8, 13, 9, 13, 9,
    14, 10, 15, 11, 15, 11, 16, 11, 16, 12, 16, 12, 17, 12, 17, 13, 17, 13, 18, 13, 18, 14, 18, 14, 19, 15, 20, 16, 20, 16, 21, 16, 21, 17, 21, 17, 22, 17,
    22, 18, 22, 18, 23, 18, 23, 19, 23, 19, 24
  ];

  // static final TRIANGLE_VERTEX_INDICES:Array<Int> = [0, 2, 1, 1, 2, 3, 3, 2, 4, 4, 2, 0];

  public function new(?x:Float = 0, ?y:Float = 0, ?simpleGraphic:FlxGraphicAsset)
  {
    super(x, y, simpleGraphic);
    if (simpleGraphic != null) setUp();
  }

  public function setUp():Void
  {
    this.x = 0;
    this.y = 0;
    this.z = 0;

    if (spriteGraphic != null)
    {
      spriteGraphic.x = 0;
      spriteGraphic.y = 0;
    }

    this.active = true; // This NEEDS to be true for the note to be drawn!
    updateColorTransform();
    var noteIndices:Array<Int> = [];
    for (x in 0...subdivisions - 1)
    {
      for (y in 0...subdivisions - 1)
      {
        var funny2:Int = x * (subdivisions);
        var funny:Int = y + funny2;
        noteIndices.push(0 + funny);
        noteIndices.push(5 + funny);
        noteIndices.push(1 + funny);

        noteIndices.push(5 + funny);
        noteIndices.push(1 + funny);
        noteIndices.push(6 + funny);
      }
    }

    // trace("\nindices: \n" + noteIndices);

    // indices = new DrawData<Int>(12, true, TRIANGLE_VERTEX_INDICES);
    indices = new DrawData<Int>(noteIndices.length, true, noteIndices);

    // UV coordinates are normalized, so they range from 0 to 1.
    var i:Int = 0;
    for (x in 0...subdivisions) // x
    {
      for (y in 0...subdivisions) // y
      {
        uvtData[i * 2] = (1 / (subdivisions - 1)) * x;
        uvtData[i * 2 + 1] = (1 / (subdivisions - 1)) * y;
        i++;
      }
    }

    // trace("\nuv: \n" + uvtData);
    updateTris();
  }

  public function updateTris(debugTrace:Bool = false):Void
  {
    var w:Float = spriteGraphic == null ? frameWidth : spriteGraphic.frameWidth;
    var h:Float = spriteGraphic == null ? frameHeight : spriteGraphic.frameHeight;

    var i:Int = 0;
    for (x in 0...subdivisions) // x
    {
      for (y in 0...subdivisions) // y
      {
        var point2D:Vector2;
        var point3D:Vector3D = new Vector3D(0, 0, 0);
        point3D.x = (w / (subdivisions - 1)) * x;
        point3D.y = (h / (subdivisions - 1)) * y;

        if (true)
        {
          // skew funny
          var xPercent:Float = x / (subdivisions - 1);
          var yPercent:Float = y / (subdivisions - 1);
          var xPercent_SkewOffset:Float = xPercent - skewY_offset;
          var yPercent_SkewOffset:Float = yPercent - skewX_offset;
          // Keep math the same as skewedsprite for parity reasons.
          point3D.x += yPercent_SkewOffset * Math.tan(skewX * FlxAngle.TO_RAD) * h;
          point3D.y += xPercent_SkewOffset * Math.tan(skewY * FlxAngle.TO_RAD) * w;
          point3D.z += yPercent_SkewOffset * Math.tan(skewZ * FlxAngle.TO_RAD) * h;

          // scale
          var newWidth:Float = (scaleX - 1) * (xPercent - 0.5);
          point3D.x += (newWidth) * w;
          newWidth = (scaleY - 1) * (yPercent - 0.5);
          point3D.y += (newWidth) * h;

          // _skewMatrix.b = Math.tan(skew.y * FlxAngle.TO_RAD);
          // _skewMatrix.c = Math.tan(skew.x * FlxAngle.TO_RAD);

          point2D = applyPerspective(point3D, xPercent, yPercent);

          if (originalWidthHeight != null && autoOffset)
          {
            point2D.x += (originalWidthHeight.x - spriteGraphic.frameWidth) / 2;
            point2D.y += (originalWidthHeight.y - spriteGraphic.frameHeight) / 2;
          }
        }
        else
        {
          // point2D = new Vector2(point3D.x, point3D.y);
          point2D = applyPerspective(point3D);
        }
        vertices[i * 2] = point2D.x;
        vertices[i * 2 + 1] = point2D.y;
        i++;
      }
    }

    if (debugTrace) trace("\nverts: \n" + vertices + "\n");

    culled = false;

    // temp fix for now I guess lol?
    if (spriteGraphic != null)
    {
      spriteGraphic.flipX = false;
      spriteGraphic.flipY = false;
    }

    // TODO -> Swap this so that it instead just breaks out of the function if it detects a difference between two points as being negative!
    switch (hazCullMode)
    {
      case "always_positive" | "always_negative":
        if (spriteGraphic != null)
        {
          spriteGraphic.flipX = hazCullMode == "always_negative" ? true : false;
          spriteGraphic.flipY = hazCullMode == "always_negative" ? true : false;
        }

        var xFlipCheck_vertTopLeftX = vertices[0];
        var xFlipCheck_vertBottomRightX = vertices[vertices.length - 1 - 1];
        if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX)
        {
          if (spriteGraphic != null)
          {
            spriteGraphic.flipX = !spriteGraphic.flipX;
          }
          else
          {
            culled = true;
          }
        }
        else
        { // y check
          xFlipCheck_vertTopLeftX = vertices[1];
          xFlipCheck_vertBottomRightX = vertices[vertices.length - 1];
          if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX)
          {
            if (spriteGraphic != null)
            {
              spriteGraphic.flipY = !spriteGraphic.flipY;
            }
            else
            {
              culled = true;
            }
          }
        }

      case "back" | "positive":
        var xFlipCheck_vertTopLeftX = vertices[0];
        var xFlipCheck_vertBottomRightX = vertices[vertices.length - 1 - 1];
        if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX) culled = true;
        else
        { // y check
          xFlipCheck_vertTopLeftX = vertices[1];
          xFlipCheck_vertBottomRightX = vertices[vertices.length - 1];
          if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX) culled = true;
        }
      case "front" | "negative":
        var xFlipCheck_vertTopLeftX = vertices[0];
        var xFlipCheck_vertBottomRightX = vertices[vertices.length - 1 - 1];
        if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX) culled = true;
        else
        { // y check
          xFlipCheck_vertTopLeftX = vertices[1];
          xFlipCheck_vertBottomRightX = vertices[vertices.length - 1];
          if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX) culled = true;
        }
        culled = !culled;
      case "always":
        culled = true;
      default:
        culled = false;
    }
  }

  public var cullMode = TriangleCulling.NONE;
  public var hazCullMode:String = "none";

  var culled:Bool = false;

  @:access(flixel.FlxCamera)
  override public function draw():Void
  {
    return; // do nothing lmfao
  }

  public function drawManual():Void
  {
    if (culled || alpha < 0 || vertices == null || indices == null || processedGraphic == null || uvtData == null || _point == null || offset == null)
    {
      return;
    }

    if (spriteGraphic != null)
    {
      spriteGraphic.update(FlxG.elapsed);
      spriteGraphic.updateFramePixels();
    }

    if (alpha < 0 || processedGraphic == null || _point == null || offset == null)
    {
      return;
    }

    for (camera in cameras)
    {
      if (!camera.visible || !camera.exists) continue;
      // if (!isOnScreen(camera)) continue; // TODO: Update this code to make it work properly.

      // memory leak with drawTriangles :c

      // getScreenPosition(_point, camera).subtractPoint(offset);
      getScreenPosition(_point, camera);
      camera.drawTriangles(processedGraphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing, spriteGraphic.shader != null ? spriteGraphic.shader : null);
      // camera.drawTriangles(processedGraphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing);
      // trace("we do be drawin... something?\n verts: \n" + vertices);
    }

    // trace("we do be drawin tho");

    #if FLX_DEBUG
    if (FlxG.debugger.drawDebug) drawDebug();
    #end
  }

  override public function destroy():Void
  {
    vertices = null;
    indices = null;
    uvtData = null;
    spriteGraphic = null;
    if (processedGraphic != null) processedGraphic.destroy();

    super.destroy();
  }

  public function updateCol():Void
  {
    updateColorTransform();
  }

  override function updateColorTransform():Void
  {
    super.updateColorTransform();
    if (processedGraphic != null) processedGraphic.destroy();
    if (spriteGraphic != null)
    {
      spriteGraphic.updateFramePixels();
      // trace("sprGraphic: " + spriteGraphic);
      // processedGraphic = spriteGraphic._frameGraphic;
      processedGraphic = FlxGraphic.fromBitmapData(spriteGraphic.framePixels, false);
      // processedGraphic = FlxGraphic.fromGraphic(spriteGraphic.graphic, true);
      processedGraphic.bitmap.colorTransform(processedGraphic.bitmap.rect, colorTransform);
      // trace("processedGraphic: " + processedGraphic);

      if (originalWidthHeight == null)
      {
        originalWidthHeight = new Vector2(spriteGraphic.frameWidth, spriteGraphic.frameHeight);
      }
    }
    else if (graphic != null)
    {
      processedGraphic = FlxGraphic.fromGraphic(graphic, true);
      processedGraphic.bitmap.colorTransform(processedGraphic.bitmap.rect, colorTransform);
    }
  }

  public function applyPerspective(pos:Vector3D, xPercent:Float = 0, yPercent:Float = 0):Vector2
  {
    // return new Vector2(pos.x, pos.y);

    var w:Float = spriteGraphic == null ? frameWidth : spriteGraphic.frameWidth;
    var h:Float = spriteGraphic == null ? frameHeight : spriteGraphic.frameHeight;

    var pos_modified:Vector3D = new Vector3D(pos.x, pos.y, pos.z);

    // pos_modified.x -= spriteGraphic.offset.x;
    // pos_modified.y -= spriteGraphic.offset.y;

    var rotateModPivotPoint:Vector2 = new Vector2(w / 2, h / 2);
    rotateModPivotPoint.x += pivotOffsetX;
    rotateModPivotPoint.y += pivotOffsetY;
    var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.y), angleZ);
    pos_modified.x = thing.x;
    pos_modified.y = thing.y;

    var rotateModPivotPoint:Vector2 = new Vector2(w / 2, 0);
    rotateModPivotPoint.x += pivotOffsetX;
    rotateModPivotPoint.y += pivotOffsetZ;
    var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.z), angleY);
    pos_modified.x = thing.x;
    pos_modified.z = thing.y;

    var rotateModPivotPoint:Vector2 = new Vector2(0, h / 2);
    rotateModPivotPoint.x += pivotOffsetZ;
    rotateModPivotPoint.y += pivotOffsetY;
    var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.z, pos_modified.y), angleX);
    pos_modified.z = thing.x;
    pos_modified.y = thing.y;

    // Apply offset here before it gets affected by z projection!
    // point3D.x -= offset.x;
    // point3D.y -= offset.y;

    pos_modified.x -= offset.x;
    pos_modified.y -= offset.y;

    pos_modified.x += moveX;
    pos_modified.y += moveY;
    pos_modified.z += moveZ;

    if (projectionEnabled)
    {
      pos_modified.x += this.x;
      pos_modified.y += this.y;
      pos_modified.z += this.z; // ?????

      pos_modified.x += fovOffsetX;
      pos_modified.y += fovOffsetY;
      pos_modified.z *= 0.001;

      // var noteWidth:Float = w * xPercent;
      // var noteHeight:Float = h * yPercent;

      // var noteWidth:Float = w * 0;
      // var noteHeight:Float = h * 0;

      // var thisNotePos:Vector3D = perspectiveMath_OLD(pos_modified, (noteWidth * 0.5), (noteHeight * 0.5));
      var thisNotePos:Vector3D = perspectiveMath_OLD(pos_modified, 0, 0);

      thisNotePos.x -= this.x;
      thisNotePos.y -= this.y;
      thisNotePos.z -= this.z * 0.001; // ?????

      thisNotePos.x -= fovOffsetX;
      thisNotePos.y -= fovOffsetY;
      return new Vector2(thisNotePos.x, thisNotePos.y);
    }
    else
    {
      return new Vector2(pos_modified.x, pos_modified.y);
    }
  }

  public var zNear:Float = 0.0;
  public var zFar:Float = 100.0;

  // https://github.com/TheZoroForce240/FNF-Modcharting-Tools/blob/main/source/modcharting/ModchartUtil.hx
  public function perspectiveMath_OLD(pos:Vector3D, offsetX:Float = 0, offsetY:Float = 0):Vector3D
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
      return pos;
      trace("OH GOD OH FUCK IT NEARLY DIED CUZ OF: \n" + e.toString());
    }
  }
}
