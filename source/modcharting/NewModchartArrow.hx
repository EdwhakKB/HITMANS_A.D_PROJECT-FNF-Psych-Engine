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
import flixel.graphics.frames.FlxFramesCollection;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxDirectionFlags;
// import funkin.graphics.ZSprite;
// import funkin.play.modchartSystem.ModchartUtil;
import lime.math.Vector2;
import modcharting.*;
import openfl.Vector;
import openfl.display.TriangleCulling;
import openfl.geom.Matrix;
import openfl.geom.Vector3D;
import flixel.addons.effects.FlxSkewedSprite;

class NewModchartArrow extends ZSprite
{
	/**
	 * Tranformation matrix for this sprite.
	 * Used only when matrixExposed is set to true
	 */
	public var transformMatrix(default, null):Matrix = new Matrix();

	/**
	 * Bool flag showing whether transformMatrix is used for rendering or not.
	 * False by default, which means that transformMatrix isn't used for rendering
	 */
	public var matrixExposed:Bool = false;

	/**
	 * Internal helper matrix object. Used for rendering calculations when matrixExposed is set to false
	 */
	var _skewMatrix:Matrix = new Matrix();

	override function getScreenPosition(?result:FlxPoint, ?camera:FlxCamera):FlxPoint
	{
		var output:FlxPoint = super.getScreenPosition(result, camera);
		output.x += this.x2;
		output.y += this.y2;
		return output;
	}

	public function new(customSetup:Bool = false, ?x:Float = 0, ?y:Float = 0, ?simpleGraphic:FlxGraphicAsset)
	{
		this.customSetup = customSetup;
		super(x, y, simpleGraphic);
		if (simpleGraphic != null) setUp();
		this.active = true;
	}

	public function setUp():Void
	{
		if (customSetup) return;
		if (frames == null || graphic == null) return;
		var nextRow:Int = (subdivisions + 1 + 1);
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

		for (x in 0...subdivisions + 2) // x
		{
			for (y in 0...subdivisions + 2) // y
			{
				vertOffsetX.push(0);
				vertOffsetY.push(0);
				vertOffsetZ.push(0);
			}
		}
		updateTris();
	}

	/**
   * The function which will update all the vertex and UV data.
   */
	public function updateTris():Void
	{
		if (customSetup || destroying || frames == null || graphic == null) return;
		
    	// TODO: Improve how this gets applied!
		var wasAlreadyFlipped_X:Bool = flipX;
		var wasAlreadyFlipped_Y:Bool = flipY;

		var needsFlipX:Bool = false;
		var needsFlipY:Bool = false;
		switch (cullMode)
		{
			case "always_positive" | "always_negative":
				needsFlipX = cullMode == "always_positive" ? true : false;
				needsFlipY = cullMode == "always_positive" ? true : false;

				var xFlipCheck_vertTopLeftX = vertices[0];
				var xFlipCheck_vertBottomRightX = vertices[vertices.length - 1 - 1];
				if (!wasAlreadyFlipped_X)
				{
					if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX)
						needsFlipX = !needsFlipX;
				}
				else
				{
					if (xFlipCheck_vertTopLeftX < xFlipCheck_vertBottomRightX)
						needsFlipX = !needsFlipX;
				}
				// y check
				if (!wasAlreadyFlipped_Y)
				{
					xFlipCheck_vertTopLeftX = vertices[1];
					xFlipCheck_vertBottomRightX = vertices[vertices.length - 1];
					if (xFlipCheck_vertTopLeftX >= xFlipCheck_vertBottomRightX)
						needsFlipY = !needsFlipY;
				}
				else
				{
					xFlipCheck_vertTopLeftX = vertices[1];
					xFlipCheck_vertBottomRightX = vertices[vertices.length - 1];
					if (xFlipCheck_vertTopLeftX < xFlipCheck_vertBottomRightX)
						needsFlipY = !needsFlipY;
				}
		}

		var w:Float = this.frame.frame.width;
    	var h:Float = this.frame.frame.height;

		var offsetX:Float = this.frame.offset.x * scaleX;
		var offsetScaledX:Float = (frameWidth - w) * (scaleX - 1) / 2;

		var offsetY:Float = this.frame.offset.y * scaleY;
		var offsetScaledY:Float = (frameHeight - h) * (scaleY - 1) / 2;

		culled = false;

		var i:Int = 0;
		for (x in 0...subdivisions + 2) // x
		{
			for (y in 0...subdivisions + 2) // y
			{
				// Setup point
				var point3D:Vector3D = new Vector3D(0, 0, 0);
				point3D.x = (w / (subdivisions + 1)) * x;
				point3D.y = (h / (subdivisions + 1)) * y;

				// Animation frame offset stuff
				point3D.x += offsetX - offsetScaledX;
				point3D.y += offsetY - offsetScaledY;

				// skew funny
				var xPercent:Float = x / (subdivisions + 1);
				var yPercent:Float = y / (subdivisions + 1);

				var newWidth:Float = (scaleX - 1) * (xPercent - 0.5);
				var newHeight:Float = (scaleY - 1) * (yPercent - 0.5);

				// Apply vibrate effect
				if (vibrateEffect != 0)
				{
					point3D.x += FlxG.random.float(-1, 1) * vibrateEffect;
					point3D.y += FlxG.random.float(-1, 1) * vibrateEffect;
					point3D.z += FlxG.random.float(-1, 1) * vibrateEffect;
				}

				// Apply curVertOffsets
				var curVertOffsetX:Float = 0;
				var curVertOffsetY:Float = 0;
				var curVertOffsetZ:Float = 0;

				if (i < vertOffsetX.length)
				{
					curVertOffsetX = vertOffsetX[i];
				}
				if (i < vertOffsetY.length)
				{
					curVertOffsetY = vertOffsetY[i];
				}
				if (i < vertOffsetZ.length)
				{
					curVertOffsetZ = vertOffsetZ[i];
				}

				point3D.x += curVertOffsetX;
				point3D.y += curVertOffsetY;
				point3D.z += curVertOffsetZ;

				// scale
				point3D.x += (newWidth) * w;
				point3D.y += (newHeight) * h;

				point3D = applyFlip(point3D, xPercent, yPercent);
				point3D = applyRotation(point3D, xPercent, yPercent);

				point3D = applySkew(point3D, xPercent, yPercent, w, h);

				// Apply offset here before it gets affected by z projection!
				point3D.x -= offset.x;
				point3D.y -= offset.y;
				point3D = applyPerspective(point3D, xPercent, yPercent);

				vertices[i * 2] = point3D.x;
				vertices[i * 2 + 1] = point3D.y;

				if (needsFlipX)
					xPercent = 1 - xPercent;
				if (needsFlipY)
					yPercent = 1 - yPercent;

				/* Updating the UV mapping! */
				var uvX:Float = xPercent;
				var uvY:Float = yPercent;

				var curFrame = this.frame;
				uvX = FlxMath.remapToRange(xPercent, 0, 1, curFrame.uv.left, curFrame.uv.right);
				uvY = FlxMath.remapToRange(yPercent, 0, 1, curFrame.uv.top, curFrame.uv.bottom);

				// todo: add repeat texture to here instead so that we can use frameBorderCut to determine if we repeat the entire atlas, or just the current frame

				// uv scale
				uvX -= uvScaleOffset.x;
				uvY -= uvScaleOffset.y;

				uvX *= uvScale.x;
				uvY *= uvScale.y;

				uvX += uvScaleOffset.x;
				uvY += uvScaleOffset.y;

				// uv offset
				uvX += uvOffset.x;
				uvY += uvOffset.y;

				// map it
				uvtData[i * 3] = uvX; // u
				uvtData[i * 3 + 1] = uvY; // v
				uvtData[i * 3 + 2] = (doPerspectiveCorrection ? 1 / Math.max(0.0001, -point3D.z) : 1.0); // t

				i++;
			}
		}
	}

	override public function loadGraphic(graphic:FlxGraphicAsset, animated = false, frameWidth = 0, frameHeight = 0, unique = false, ?key:String):NewModchartArrow
	{
		super.loadGraphic(graphic, animated, frameWidth, frameHeight, unique, key);
		if (graphic != null) setUp();
		return this;
	}

	override function set_frames(Frames:FlxFramesCollection):FlxFramesCollection
	{
		final result = super.set_frames(Frames);
		if (frames != null) setUp();
		return result;
	}

	@:access(flixel.FlxCamera)
	override public function draw():Void
	{
		if (notePositionData?.alpha <= 0 || frames == null || graphic == null) return;
		if (destroying) return;
		if (!projectionEnabled)
		{
			super.draw();
		}
		else
		{
			var culling = TriangleCulling.NONE;
			switch (cullMode)
			{
				case "positive" | "front":
					culling = TriangleCulling.POSITIVE;
				case "negative" | "back":
					culling = TriangleCulling.NEGATIVE;
				case "always":
					culled = true;
			}
	
      		if (dirty) this.updateTris();

			if (culled || alpha < 0 || vertices == null || indices == null || graphic == null || uvtData == null || _point == null || offset == null)
			{
				return;
			}
			var alphaMemory:Float = this.alpha;
			for (camera in cameras)
			{
				if (!camera.visible || !camera.exists) continue;
				// if (!isOnScreen(camera)) continue; // TODO: Update this code to make it work properly.
				alpha = alphaMemory * camera.alpha; // Fix for drawTriangles not fading with camera
				// getScreenPosition(_point, camera).subtractPoint(offset);
				getScreenPosition(_point, camera);
				camera.drawTriangles(graphic, vertices, indices, uvtData, colors, _point, blend, textureRepeat, antialiasing, colorTransform, shader, /*,culling*/);
			}
			this.alpha = alphaMemory;

			#if FLX_DEBUG
			if (FlxG.debugger.drawDebug) drawDebug();
			#end
		}
	}

	/**
	 * WARNING: This will remove this sprite entirely. Use kill() if you
	 * want to disable it temporarily only and reset() it later to revive it.
	 * Used to clean up memory.
	 */
	override public function destroy():Void
	{
		skew = FlxDestroyUtil.put(skew);
		_skewMatrix = null;
		transformMatrix = null;

		super.destroy();
	}

	override function drawComplex(camera:FlxCamera):Void
	{
		_frame.prepareMatrix(_matrix, FlxFrameAngle.ANGLE_0, checkFlipX(), checkFlipY());
		_matrix.translate(-origin.x, -origin.y);
		_matrix.scale(scale.x, scale.y);

		if (matrixExposed)
			_matrix.concat(transformMatrix);
		else
		{
			if (bakedRotationAngle <= 0)
			{
				updateTrig();

				if (angle != 0)
					_matrix.rotateWithTrig(_cosAngle, _sinAngle);
			}

			updateSkewMatrix();
			_matrix.concat(_skewMatrix);
		}

		getScreenPosition(_point, camera).subtractPoint(offset);
		_point.addPoint(origin);
		if (isPixelPerfectRender(camera))
			_point.floor();

		_matrix.translate(_point.x, _point.y);
		camera.drawPixels(_frame, framePixels, _matrix, colorTransform, blend, antialiasing, shader);
	}

	function updateSkewMatrix():Void
	{
		_skewMatrix.identity();

		if (skew.x != 0 || skew.y != 0)
		{
			_skewMatrix.b = Math.tan(skew.y * FlxAngle.TO_RAD);
			_skewMatrix.c = Math.tan(skew.x * FlxAngle.TO_RAD);
		}
	}

	override public function isSimpleRender(?camera:FlxCamera):Bool
		return FlxG.renderBlit ? super.isSimpleRender(camera) && (skew.x == 0) && (skew.y == 0) && !matrixExposed : false;
}
