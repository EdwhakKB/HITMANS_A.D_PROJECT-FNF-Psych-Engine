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

class StrumNote extends modcharting.ModchartArrow
{
  private static var alphas:Map<String, Map<Int, Map<String, Map<Int, Array<Float>>>>> = new Map();
  private static var indexes:Map<String, Map<Int, Map<String, Map<Int, Array<Int>>>>> = new Map();
  private static var glist:Array<FlxGraphic> = [];

	public var gpix:FlxGraphic = null;
	public var oalp:Float = 1;
	public var oanim:String = "";

  // public var z:Float = 200 / 0.7;
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
