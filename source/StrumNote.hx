package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.tile.FlxDrawTrianglesItem;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxAssets.FlxShader;
import flixel.util.FlxColor;
import lime.math.Vector2;
import openfl.geom.Matrix;
import openfl.geom.Vector3D;
import openfl.geom.ColorTransform;
import openfl.display.TriangleCulling;
import RGBPalette;
import RGBPalette.RGBShaderReference;
// import flixel.addons.effects.FlxSkewedSprite;

import modcharting.FlxFilteredSkewedSprite as FlxImprovedSprite;
import modcharting.ModchartUtil;
using StringTools;

class StrumNote extends FlxImprovedSprite
{
	 // Galxay stuff
	 private static var alphas:Map<String, Map<Int, Map<String, Map<Int, Array<Float>>>>> = new Map();
	 private static var indexes:Map<String, Map<Int, Map<String, Map<Int, Array<Int>>>>> = new Map();
	 private static var glist:Array<FlxGraphic> = [];
   
	 public var gpix:FlxGraphic = null;
	 public var oalp:Float = 1;
	 public var oanim:String = "";
   
	 // If set, will reference this sprites graphic! Very useful for animations!
   public var initialized:Bool = false;
	 public var projectionEnabled:Bool = true;
   
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
   
	 public var subdivisions:Int = 5;
   
	 static final TRIANGLE_VERTEX_INDICES:Array<Int> = [
	   0, 5, 1, 5, 1, 6, 1, 6, 2, 6, 2, 7, 2, 7, 3, 7, 3, 8, 3, 8, 4, 8, 4, 9, 5, 10, 6, 10, 6, 11, 6, 11, 7, 11, 7, 12, 7, 12, 8, 12, 8, 13, 8, 13, 9, 13, 9,
	   14, 10, 15, 11, 15, 11, 16, 11, 16, 12, 16, 12, 17, 12, 17, 13, 17, 13, 18, 13, 18, 14, 18, 14, 19, 15, 20, 16, 20, 16, 21, 16, 21, 17, 21, 17, 22, 17,
	   22, 18, 22, 18, 23, 18, 23, 19, 23, 19, 24
	 ];

	 public var z:Float = 200 / 0.7;
	public var rgbShader:RGBShaderReference;
	private var colorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	public var noteData:Int = 0;
	public var direction:Float = 90;//plan on doing scroll directions soon -bb
	public var downScroll:Bool = false;//plan on doing scroll directions soon -bb
	public var sustainReduce:Bool = true;
	var myLibrary:String = '';
	public var loadShader:Bool = false;
	
	private var player:Int;
	
	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public var strumType(default, set):String = null;

	private function set_strumType(value:String):String
	{
	  // Add custom strumTypes here!
	  if (noteData > 0 && strumType != value)
	  {
		strumType = value;
	  }
	  return value;
	}

	public var useRGBShader:Bool = true;
	var rgb9:Bool = false;
	public function new(x:Float, y:Float, leData:Int, player:Int, ?daTexture:String, ?library:String = 'shared', ?quantizedNotes:Bool = false, ?loadShader:Bool = true) {
		if (loadShader)
		{
			rgb9 = (player < 0);
			rgbShader = new RGBShaderReference(this, !quantizedNotes ? Note.initializeGlobalRGBShader(leData, rgb9) : 
				Note.initializeGlobalQuantRBShader(leData));
			rgbShader.enabled = false;
			if(PlayState.SONG != null && PlayState.SONG.disableNoteRGB) useRGBShader = false;
			var arr:Array<FlxColor> = !quantizedNotes ? (rgb9 ? ClientPrefs.arrowRGB9[leData] : ClientPrefs.arrowRGB[leData]) : ClientPrefs.arrowRGBQuantize[leData];

			if(leData <= arr.length)
			{
				@:bypassAccessor
				{
					rgbShader.r = arr[0];
					rgbShader.g = arr[1];
					rgbShader.b = arr[2];
				}
			}
		}

		noteData = leData;
		this.player = player;
		this.noteData = leData;
		this.loadShader = loadShader;
		super(x, y);

		myLibrary = library;
		var skin = 'Skins/Notes/'+ClientPrefs.notesSkin[0]+'/NOTE_assets';
		daTexture = daTexture != null ? daTexture : skin;
		if(PlayState.SONG != null && PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
		if (daTexture != null) texture = daTexture else texture = skin;

		scrollFactor.set();

		//setUp();
	}

	public function reloadNote()
	{
		var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

		var notesAnim:Array<String> = rgb9 ? ["UP", "UP", "UP", "UP", "UP", "UP", "UP", "UP", "UP"] : ['LEFT', 'DOWN', 'UP', 'RIGHT'];
        var pressAnim:Array<String> = rgb9 ? ["up", "up", "up", "up", "up", "up", "up", "up", "up"] : ['left', 'down', 'up', 'right'];
        var colorAnims:Array<String> = rgb9 ? ["green", "green", "green", "green", "green", "green", "green", "green", "green"] : ['purple', 'blue', 'green', 'red'];

		var daNoteData:Float = Math.abs(noteData) % 4;
		
        if(PlayState.isPixelStage)
        {
            loadGraphic(Paths.image('pixelUI/' + texture));
            width = width / 4;
            height = height / 5;
            loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));

            animation.add('green', [6]);
            animation.add('red', [7]);
            animation.add('blue', [5]);
            animation.add('purple', [4]);

            antialiasing = false;
            setGraphicSize(Std.int(width * PlayState.daPixelZoom));

            animation.add('static', [0 + Std.int(daNoteData)]);
            animation.add('pressed', [4 + Std.int(daNoteData), 8 + Std.int(daNoteData)], 12, false);
            animation.add('confirm', [12 + Std.int(daNoteData), 16 + Std.int(daNoteData)], 24, false);
        }
        else
        {
            frames = Paths.getSparrowAtlas(texture, myLibrary);
            animation.addByPrefix('green', 'arrowUP');
            animation.addByPrefix('blue', 'arrowDOWN');
            animation.addByPrefix('purple', 'arrowLEFT');
            animation.addByPrefix('red', 'arrowRIGHT');

            antialiasing = ClientPrefs.globalAntialiasing;
            setGraphicSize(Std.int(width * 0.7));

            animation.addByPrefix(colorAnims[Std.int(daNoteData)], 'arrow' + notesAnim[Std.int(daNoteData)]);

            animation.addByPrefix('static', 'arrow' + notesAnim[Std.int(daNoteData)]);
            animation.addByPrefix('pressed', pressAnim[Std.int(daNoteData)] + ' press', 24, false);
            animation.addByPrefix('confirm', pressAnim[Std.int(daNoteData)] + ' confirm', 24, false);
        }
		updateHitbox();

		if(lastAnim != null)
		{
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		if(animation.curAnim != null)
			{
				centerOffsets();
				centerOrigin();
			}
		if(loadShader && useRGBShader) rgbShader.enabled = (animation.curAnim != null && animation.curAnim.name != 'static');
	}


  public function setUp():Void
  {
    this.x = 0;
    this.y = 0;
    this.z = 0;

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
    var w:Float = frameWidth;
    var h:Float = frameHeight;

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

          point2D.x += (frameWidth - frameWidth) / 2;
          point2D.y += (frameHeight - frameHeight) / 2;
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

    // temp fix for now I guess lol?
    flipX = false;
    flipY = false;
  }

  @:access(flixel.FlxCamera)
  override public function draw():Void
  {
    if (alpha <= 0 || vertices == null || indices == null || uvtData == null || _point == null || offset == null)
	{
	return;
	}

	for (camera in cameras)
	{
	if (!camera.visible || !camera.exists) continue;
	//if (!isOnScreen(camera)) continue; // TODO: Update this code to make it work properly.

	// memory leak with drawTriangles :c

	getScreenPosition(_point, camera) /*.subtractPoint(offset)*/;
	var newGraphic:FlxGraphic = cast mapData();
	camera.drawTriangles(newGraphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing, colorTransform, shader);
	// camera.drawTriangles(processedGraphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing);
	// trace("we do be drawin... something?\n verts: \n" + vertices);
	}

	// trace("we do be drawin tho");

	#if FLX_DEBUG
	if (FlxG.debugger.drawDebug) drawDebug();
	#end
  }

  public function applyPerspective(pos:Vector3D, xPercent:Float = 0, yPercent:Float = 0):Vector2
  {
    // return new Vector2(pos.x, pos.y);

    var w:Float = frameWidth;
    var h:Float = frameHeight;

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
      trace("OH GOD OH FUCK IT NEARLY DIED CUZ OF: \n" + e.toString());
      return pos;
    }
  }

  public var typeOffsetX:Float = 0;
  public var typeOffsetY:Float = 0;

  public function updateObjectPosition(obj:StrumNote):Void
  {
    obj.centerOrigin();
    obj.centerOffsets();
  }

  function mapData():FlxGraphic
  {
    if (gpix == null || alpha != oalp || !animation.curAnim.finished || oanim != animation.curAnim.name)
    {
      if (!alphas.exists(strumType))
      {
        alphas.set(strumType, new Map());
        indexes.set(strumType, new Map());
      }
      if (!alphas.get(strumType).exists(ID))
      {
        alphas.get(strumType).set(ID, new Map());
        indexes.get(strumType).set(ID, new Map());
      }
      if (!alphas.get(strumType).get(ID).exists(animation.curAnim.name))
      {
        alphas.get(strumType).get(ID).set(animation.curAnim.name, new Map());
        indexes.get(strumType).get(ID).set(animation.curAnim.name, new Map());
      }
      if (!alphas.get(strumType)
        .get(ID)
        .get(animation.curAnim.name)
        .exists(animation.curAnim.curFrame))
      {
        alphas.get(strumType)
          .get(ID)
          .get(animation.curAnim.name)
          .set(animation.curAnim.curFrame, []);
        indexes.get(strumType)
          .get(ID)
          .get(animation.curAnim.name)
          .set(animation.curAnim.curFrame, []);
      }
      if (!alphas.get(strumType)
        .get(ID)
        .get(animation.curAnim.name)
        .get(animation.curAnim.curFrame)
        .contains(alpha))
      {
        var pix:FlxGraphic = FlxGraphic.fromFrame(frame, true);
        var nalp:Array<Float> = alphas.get(strumType)
          .get(ID)
          .get(animation.curAnim.name)
          .get(animation.curAnim.curFrame);
        var nindex:Array<Int> = indexes.get(strumType)
          .get(ID)
          .get(animation.curAnim.name)
          .get(animation.curAnim.curFrame);
        pix.bitmap.colorTransform(pix.bitmap.rect, colorTransform);
        glist.push(pix);
        nalp.push(alpha);
        nindex.push(glist.length - 1);
        alphas.get(strumType)
          .get(ID)
          .get(animation.curAnim.name)
          .set(animation.curAnim.curFrame, nalp);
        indexes.get(strumType)
          .get(ID)
          .get(animation.curAnim.name)
          .set(animation.curAnim.curFrame, nindex);
      }
      var dex = alphas.get(strumType)
        .get(ID)
        .get(animation.curAnim.name)
        .get(animation.curAnim.curFrame)
        .indexOf(alpha);
      gpix = glist[
        indexes.get(strumType)
          .get(ID)
          .get(animation.curAnim.name)
          .get(animation.curAnim.curFrame)[dex]];
      oalp = alpha;
      oanim = animation.curAnim.name;
    }
    return gpix;
  }

  public override function kill():Void
  {
    super.kill();
  }

  public override function revive():Void
  {
    super.revive();
  }

  override public function destroy():Void
  {
    vertices = null;
    indices = null;
    uvtData = null;
    for (i in glist)
      i.destroy();
    alphas = new Map();
    indexes = new Map();
    glist = [];
    super.destroy();
  }
}
