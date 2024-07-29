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
   
	 // custom setter to prevent values below 0, cuz otherwise we'll devide by 0!
	public var subdivisions(default, set):Int = 2;

	function set_subdivisions(value:Int):Int
	{
		if (value < 0) value = 0;
		subdivisions = value;
		return subdivisions;
	}

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

  public var drawManual:Bool = false;
  public var hasSetupRender:Bool = false;

  public function setUpThreeDRender():Void
  {
    if (!hasSetupRender)
    {
      drawManual = true;
      setUp();
      hasSetupRender = true;
    }
  }

  public function setUp():Void
  {
    this.x = 0;
    this.y = 0;
    this.z = 0;

    this.active = true; // This NEEDS to be true for the note to be drawn!
    updateColorTransform();
    var nextRow:Int = (subdivisions + 1 + 1);
		var noteIndices:Array<Int> = [];
		for (x in 0...subdivisions + 1)
		{
			for (y in 0...subdivisions + 1)
			{
				// indices are created from top to bottom, going along the x axis each cycle.
				var funny:Int = y + (x * nextRow);
				noteIndices.push(0 + funny);
				noteIndices.push(nextRow + funny);
				noteIndices.push(1 + funny);

				noteIndices.push(nextRow + funny);
				noteIndices.push(1 + funny);
				noteIndices.push(nextRow + 1 + funny);
			}
		}
		indices = new DrawData<Int>(noteIndices.length, true, noteIndices);

    // trace("\nindices: \n" + noteIndices);

    indices = new DrawData<Int>(noteIndices.length, true, noteIndices);

    // UV coordinates are normalized, so they range from 0 to 1.
		var i:Int = 0;
		for (x in 0...subdivisions + 2) // x
		{
		  for (y in 0...subdivisions + 2) // y
		  {
			var xPercent:Float = x / (subdivisions + 1);
			var yPercent:Float = y / (subdivisions + 1);
			uvtData[i * 2] = xPercent;
			uvtData[i * 2 + 1] = yPercent;
			i++;
		  }
		}
		updateTris();
  }

  public function updateTris(debugTrace:Bool = false):Void
  {
    var w:Float = frameWidth;
    var h:Float = frameHeight;

    var i:Int = 0;
    for (x in 0...subdivisions+2) // x
    {
      for (y in 0...subdivisions+2) // y
      {
        var point2D:Vector2;
        var point3D:Vector3D = new Vector3D(0, 0, 0);
        point3D.x = (w / (subdivisions + 1)) * x;
        point3D.y = (h / (subdivisions + 1)) * y;

        
        // skew funny
        var xPercent:Float = x / (subdivisions + 1);
        var yPercent:Float = y / (subdivisions + 1);
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

        point2D = applyPerspective(point3D, xPercent, yPercent);

        point2D.x += (frameWidth - frameWidth) / 2;
        point2D.y += (frameHeight - frameHeight) / 2;

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
    if (drawManual)
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
  else
  {
    super.draw();
  }
  }

  public function applyPerspective(pos:Vector3D, xPercent:Float = 0, yPercent:Float = 0):Vector2
  {
    var w:Float = frameWidth;
    var h:Float = frameHeight;

    var pos_modified:Vector3D = new Vector3D(pos.x, pos.y, pos.z);

    var whatWasTheZBefore:Float = pos_modified.z;

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
    pos_modified.x -= offset.x;
    pos_modified.y -= offset.y;

    pos_modified.x += moveX;
    pos_modified.y += moveY;
    pos_modified.z += moveZ;

    if (projectionEnabled)
    {
      pos_modified.x += this.x + (width / 2);
      pos_modified.y += this.y + (height / 2);
      pos_modified.z += this.z; // ?????

      pos_modified.x += fovOffsetX;
      pos_modified.y += fovOffsetY;
      pos_modified.z *= 0.001;

      // var noteWidth:Float = w * xPercent;
      // var noteHeight:Float = h * yPercent;

      // var noteWidth:Float = w * 0;
      // var noteHeight:Float = h * 0;

      // var thisNotePos:Vector3D = perspectiveMath_OLD(pos_modified, (noteWidth * 0.5), (noteHeight * 0.5));

      //quick notes -Ed
			// so the one that uses MT method (new Vector3D etc etc) fixes the z calculation, that being good ig, but the problem comes when you use 3D mods
			// when used, notes won't get the right 3D position. (only apply for Note.hx not strums (until centered2 its added))
			// the fix for note perspective to properly work its down and its the one used, but that breaks Z mod, there must be a way to fix both at the same time.
      
      //var thisNotePos = perspectiveMath_OLD(new Vector3D(pos_modified.x+(width/2), pos_modified.y+(height/2), pos_modified.z*0.001), -(width/2), -(height/2));
      var thisNotePos:Vector3D = perspectiveMath(pos_modified, -(width/2), -(height/2));

      thisNotePos.x -= this.x;
      thisNotePos.y -= this.y;
      thisNotePos.z -= this.z; // ?????

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
    drawManual = false;
    hasSetupRender = false;
    super.destroy();
  }
}
