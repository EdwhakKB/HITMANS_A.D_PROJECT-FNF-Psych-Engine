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
import flixel.util.FlxColor;

//A few TODOS im gona leave here:
/*
	- Make this optimized (gives lags spikes at some songs which means its not perfect)
	- Make SKEW poss correct as if it was a normal skew (similation of skew adds a few more numbers which means skew for this draw its a bit bigger than it should be)
	- Find a way to make sure we don't need extend this class on notes to make 3D (so people won't get confused once installing the 3D update)
	- Make sure the class extend of skew sprite but don't use it (only when draw manual it's false)
	- And finally, find at some point once we get 3D basics, how to make this class have the main balance (meaning it draws 3D stuff and 2D, while notes won't need anymore extend class)
*/
class NewModchartArrow extends FlxSprite
{
  	public var z:Float = 0.0;

	// If set, will reference this sprites graphic! Very useful for animations!
	public var spriteGraphic(default, set):FlxSprite;

	function set_spriteGraphic(value:FlxSprite):FlxSprite
	{
	  spriteGraphic = value;
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

	public function new(?x:Float = 0, ?y:Float = 0, ?simpleGraphic:FlxGraphicAsset)
	{
		super(x, y, simpleGraphic);
		if (simpleGraphic != null) setUp();
	}

	public function setUp(moveSprGraph:Bool = true):Void
	{
		this.x = 0;
		this.y = 0;
		this.z = 0;
	
		if (spriteGraphic != null && moveSprGraph)
		{
			spriteGraphic.x = 0;
			spriteGraphic.y = 0;
		}

		var nextRow:Int = (subdivisions + 1 + 1);

		this.active = true; // This NEEDS to be true for the note to be drawn!
		updateColorTransform();
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
				noteIndices.push(nextRow + 1 + funny);
				noteIndices.push(1 + funny);
			}
		}
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
		var wasAlreadyFlipped_X:Bool = flipX;
    	var wasAlreadyFlipped_Y:Bool = flipY;

		var w:Float = spriteGraphic != null ? spriteGraphic.frameWidth : frameWidth;
		var h:Float = spriteGraphic != null ? spriteGraphic.frameHeight : frameHeight;

		var i:Int = 0;
		for (x in 0...subdivisions + 2) // x
		{
			for (y in 0...subdivisions + 2) // y
			{
				var point2D:Vector2;
				var point3D:Vector3D = new Vector3D(0, 0, 0);
				point3D.x = (w / (subdivisions + 1)) * x;
				point3D.y = (h / (subdivisions + 1)) * y;

				// skew funny
				var xPercent:Float = x / (subdivisions + 1);
				var yPercent:Float = y / (subdivisions + 1);
				// For some reason, we need a 0.5 offset for this??????????????????? //fuck you 0.5
				var xPercent_SkewOffset:Float = xPercent - skewY_offset;
				var yPercent_SkewOffset:Float = yPercent - skewX_offset;
				// Keep math the same as skewedsprite for parity reasons.
				if (skewX != 0) // Small performance boost from this if check to avoid the tan math lol?
					point3D.x += yPercent_SkewOffset * Math.tan(skewX * FlxAngle.TO_RAD) * h;
				if (skewY != 0) //
					point3D.y += xPercent_SkewOffset * Math.tan(skewY * FlxAngle.TO_RAD) * w;
				if (skewZ != 0) //
					point3D.z += yPercent_SkewOffset * Math.tan(skewZ * FlxAngle.TO_RAD) * h;

				// scale
				var newWidth:Float = (scaleX - 1) * (xPercent - 0.5);
				point3D.x += (newWidth) * w;
				newWidth = (scaleY - 1) * (yPercent - 0.5);
				point3D.y += (newWidth) * h;

				point2D = applyPerspective(point3D, xPercent, yPercent);

				if (originalWidthHeight != null && autoOffset)
				{
					point2D.x += (originalWidthHeight.x - spriteGraphic.frameWidth) / 2;
					point2D.y += (originalWidthHeight.y - spriteGraphic.frameHeight) / 2;
				}
				
				vertices[i * 2] = point2D.x;
				vertices[i * 2 + 1] = point2D.y;
				i++;
			}
		}

		// if (debugTrace) trace("\nverts: \n" + vertices + "\n");

		// temp fix for now I guess lol?
		// return; // TEMP TEMP TEMP TEMP TEMP TEMP OVER HER DUMBASS GET RID OF ME RID OF ME YOU HEAR ME?!!!!

		culled = false;

		// temp fix for now I guess lol?
		// if (spriteGraphic != null)
		// {
		//  spriteGraphic.flipX = false;
		//  spriteGraphic.flipY = false;
		// }

		// flipX = wasAlreadyFlipped_X;
		// flipY = wasAlreadyFlipped_Y;
		flipX = false;
		flipY = false;

		// TODO -> culMode this so that it instead just breaks out of the function if it detects a difference between two points as being negative!
		switch (cullMode)
		{
			case "always_positive" | "always_negative":
			flipX = cullMode == "always_positive" ? true : false;
			flipY = cullMode == "always_positive" ? true : false;
	
			var xFlipCheck_vertTopLeftX = vertices[0];
			var xFlipCheck_vertBottomRightX = vertices[vertices.length - 1 - 1];
			if (!wasAlreadyFlipped_X)
			{
				if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX)
				{
					flipX = !flipX;
				}
			}
			else
			{
				if (xFlipCheck_vertTopLeftX < xFlipCheck_vertBottomRightX)
				{
					flipX = !flipX;
				}
			}
			// y check
			if (!wasAlreadyFlipped_Y)
			{
				xFlipCheck_vertTopLeftX = vertices[1];
				xFlipCheck_vertBottomRightX = vertices[vertices.length - 1];
				if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX)
				{
					flipY = !flipY;
				}
			}
			else
			{
				xFlipCheck_vertTopLeftX = vertices[1];
				xFlipCheck_vertBottomRightX = vertices[vertices.length - 1];
				if (xFlipCheck_vertTopLeftX < xFlipCheck_vertBottomRightX)
				{
					flipY = !flipY;
				}
			}
			default:
				culled = false;
		}
	}
	
	
	public var cullMode:String = "none";
	
	var culled:Bool = false;

	// Default to true for when players create their own ZProjectSprites!
	public var doDraw:Bool = true;
	public var copySpriteGraphic:Bool = true;

	@:access(flixel.FlxCamera)
	override public function draw():Void
	{
		if (doDraw)
		{
			if (spriteGraphic == null)
			{
				doDraw = false;
				trace("no sprite graphic! PERRO");
				return;
			}
			else
			{
				if (copySpriteGraphic)
				{
					this.x = spriteGraphic.x;
					this.y = spriteGraphic.y;
					// this.z = spriteGraphic.z;
			
					this.scaleX = spriteGraphic.scale.x;
					this.scaleY = spriteGraphic.scale.y;
			
					this.angleZ = spriteGraphic.angle;
			
					this.offset = spriteGraphic.offset;
					this.cameras = spriteGraphic.cameras;
				}
				updateTris();
				drawManual(spriteGraphic.graphic != null ? spriteGraphic.graphic : null);
			}
		}
		else
		{
			return; // do nothing lmfao, moved to drawManual just to be safe cuz idk if it will double draw or not (I doubt but, you never know with Flixel)
		}
	}

	public var debugTesting:Bool = false;

	// public var graphicAnimMap:Map<String, FlxGraphic> = new Map<String, FlxGraphic>();
	public static var graphicCache3D:Map<String, FlxGraphic> = new Map<String, FlxGraphic>();

	public function drawManual(graphicToUse:FlxGraphic = null, noteStyleName:String = ""):Void
	{
		var c = TriangleCulling.NONE;
		switch (cullMode)
		{
		case "positive" | "front":
			c = TriangleCulling.POSITIVE;
		case "negative" | "back":
			c = TriangleCulling.NEGATIVE;
		case "always":
			culled = true;
		}
		if (culled ||alpha < 0 || vertices == null || indices == null || graphicToUse == null || uvtData == null || _point == null || offset == null)
		{
			return;
		}

		if (spriteGraphic != null)
		{
			this.antialiasing = spriteGraphic.antialiasing;

			// var animFrameName:String = "ligma";

			// var animFrameName:String = spriteGraphic.animation.frameName + " - " + noteStyleName + (spriteGraphic.flipX ? " - flipX" : "")
			//  + (spriteGraphic.flipY ? " - flipY" : "");

			var animFrameName:String = spriteGraphic.animation.frameName + " - " + noteStyleName;

			// check to see if we have this frame of animation saved
			if (NewModchartArrow.graphicCache3D.exists(animFrameName))
			{
				graphicToUse = NewModchartArrow.graphicCache3D.get(animFrameName);
				// if (debugTesting) trace("got: " + animFrameName);
			}
			else
			{
				// TODO: MAKE IT SO IT AUTOMATICALLY PRECACHES ALL THE ANIMATION FRAMES BEFORE THE SONG STARTS TO AVOID MID-SONG LAGSPIKES AS IT CACHES NEW ANIMATIONS!

				var prevAlpha:Float = spriteGraphic.alpha;
				var prevCol:FlxColor = spriteGraphic.color;
				// var prevSkewX:Float = spriteGraphic.skewY;
				// var prevSkewY:Float = spriteGraphic.skewX;
				var prevAngle:Float = spriteGraphic.angle;

				spriteGraphic.alpha = 1; // Make sure the graphic alpha is 1!
				spriteGraphic.color = 0xFFFFFFFF;
				spriteGraphic.angle = 0;

				// if (debugTesting)
				// trace("New frame for: " + animFrameName);
				// if not, we create it and add it to the map.
				spriteGraphic.updateFramePixels();
				graphicToUse = FlxGraphic.fromBitmapData(spriteGraphic.framePixels, true, animFrameName);
				// graphicToUse.bitmap.colorTransform(graphicToUse.bitmap.rect, colorTransform);

				NewModchartArrow.graphicCache3D.set(animFrameName, graphicToUse);
				spriteGraphic.alpha = prevAlpha;
				spriteGraphic.angle = prevAngle;
				spriteGraphic.color = prevCol;
			}
			// graphicToUse.bitmap.colorTransform(graphicToUse.bitmap.rect, colorTransform);
			// graphicToUse.bitmap.colorTransform(graphicToUse.bitmap.rect, spriteGraphic.colorTransform);

			//  var cTransform:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0 - alphaMod);

			// if (debugTesting)
			// trace("map: " + graphicCache3D);
		}
		else
		{
			return; // fuck
		}

		if (alpha < 0 || graphicToUse == null || _point == null || offset == null)
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
			camera.drawTriangles(graphicToUse, vertices, indices, uvtData, null, _point, blend, true, antialiasing, spriteGraphic.colorTransform != null ? spriteGraphic.colorTransform : colorTransform,
				spriteGraphic.shader != null ? spriteGraphic.shader : null);
		}

		#if FLX_DEBUG
		if (FlxG.debugger.drawDebug) drawDebug();
		#end
	}

	public static function clearOutCache():Void
	{
		NewModchartArrow.graphicCache3D = new Map<String, FlxGraphic>();
		trace("3D animation graphics cache cleared!");
	}

	override public function destroy():Void
	{
		vertices = null;
		indices = null;
		uvtData = null;
		spriteGraphic = null;
		super.destroy();
	}

	// since updateColorTransform isn't public lol?
	public function updateCol():Void
	{
		updateColorTransform();
	}

	// Call this when updating the animation! This is because different animations can have different sprite sizes!
	override function updateColorTransform():Void
	{
		super.updateColorTransform();

		if (originalWidthHeight == null && spriteGraphic != null)
		{
		originalWidthHeight = new Vector2(spriteGraphic.frameWidth, spriteGraphic.frameHeight);
		}
	}

	public var offsetBeforeRotation:FlxPoint = new FlxPoint(0, 0);

	public function applyPerspective(pos:Vector3D, xPercent:Float = 0, yPercent:Float = 0):Vector2
	{
		var w:Float = spriteGraphic != null ? spriteGraphic.frameWidth : frameWidth;
		var h:Float = spriteGraphic != null ? spriteGraphic.frameHeight : frameHeight;

		var pos_modified:Vector3D = new Vector3D(pos.x, pos.y, pos.z);

		pos_modified.x -= offsetBeforeRotation.x;
    	pos_modified.y -= offsetBeforeRotation.y;

		var whatWasTheZBefore:Float = pos_modified.z;

		var rotateModPivotPoint:Vector2 = new Vector2(w / 2, h / 2);
		rotateModPivotPoint.x += pivotOffsetX;
		rotateModPivotPoint.y += pivotOffsetY;
		var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.y), angleZ);
		pos_modified.x = thing.x;
		pos_modified.y = thing.y;

		rotateModPivotPoint = new Vector2(w / 2, 0);
		rotateModPivotPoint.x += pivotOffsetX;
		rotateModPivotPoint.y += pivotOffsetZ;
		var angleY_withFlip:Float = angleY + (flipX ? 180 : 0);
		thing = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.z), -angleY_withFlip);
		pos_modified.x = thing.x;
		pos_modified.z = thing.y;

		rotateModPivotPoint = new Vector2(0, h / 2);
		rotateModPivotPoint.x += pivotOffsetZ;
		rotateModPivotPoint.y += pivotOffsetY;
		var angleX_withFlip:Float = angleX + (flipY ? 180 : 0);
		thing = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.z, pos_modified.y), -angleX_withFlip);
		pos_modified.z = thing.x;
		pos_modified.y = thing.y;

		//Calculate the difference of the rotation and use this as input for the applyPerspective function (idk it just works) 
		//Feel free to move this calculation around if you wanna account for other facts like offsetZ (if added) or moveZ, idk what you're doing exactly with this code lol
		// -Hazard24
		var zDifference:Float = pos_modified.z - whatWasTheZBefore;

		// Apply offset here before it gets affected by z projection!
		pos_modified.x -= offset.x;
		pos_modified.y -= offset.y;
		// pos_modified.x += daOffsetX; //Moved offsetX here so it's with the other Offsets -Hazard24

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

			//var thisNotePos = perspectiveMath(new Vector3D(pos_modified.x+(width/2), pos_modified.y+(height/2), zDifference * 0.001), -(width/2), -(height/2));
			pos_modified.z = zDifference * 0.001;
			pos_modified = perspectiveMath(pos_modified, 0, 0);
			//No need for any offsets since the offsets are already a part of pos_modified for each Vert. Plus if you look at the +height/2 part, you'll realise it's just cancelling each other out lmfao
			// -Hazard24

			pos_modified.x -= this.x;
			pos_modified.y -= this.y;
			pos_modified.z -= this.z; // ?????

			pos_modified.x -= fovOffsetX;
			pos_modified.y -= fovOffsetY;
			return new Vector2(pos_modified.x, pos_modified.y);
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
}