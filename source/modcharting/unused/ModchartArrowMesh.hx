package modcharting;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import openfl.Vector;
import openfl.geom.Matrix;
import openfl.geom.Vector3D;

/**
 * @author TheoDev
 * 
 * most of the code was taken from FunkinModchart's arrow renderer
 */
class ModchartArrowMesh extends FlxBasic
{
	public var parent:FlxSprite;

	public function new(parent:FlxSprite)
	{
		super();

		this.parent = parent;

		for (i in 0..._indices.length)
			_indices[i] = i;
	}

	inline private function getGraphicVertices(planeWidth:Float, planeHeight:Float, flipX:Bool, flipY:Bool)
	{
		var x1 = flipX ? planeWidth : -planeWidth;
		var x2 = flipX ? -planeWidth : planeWidth;
		var y1 = flipY ? planeHeight : -planeHeight;
		var y2 = flipY ? -planeHeight : planeHeight;

		return [
			// top left
			x1,
			y1,
			// top right
			x2,
			y1,
			// bottom left
			x1,
			y2,
			// bottom right
			x2,
			y2
		];
	}

	var _vertices:Vector<Float> = new Vector<Float>(12, true);
	var _uv:Vector<Float> = new Vector<Float>(18, true);
	var _indices:Vector<Int> = new Vector<Int>(12, true);

	var _matrix:Matrix = new Matrix();
	var _rotationVector:Vector3D = new Vector3D();

	public function setupMesh(data:NotePositionData)
	{
		final planeWidth = parent.frame.frame.width * .5;
		final planeHeight = parent.frame.frame.height * .5;

		final planeVertices = getGraphicVertices(planeWidth, planeHeight, parent.flipX, parent.flipY);
		final projectionZ:haxe.ds.Vector<Float> = new haxe.ds.Vector(Math.ceil(planeVertices.length / 2));

		var vertPointer = 0;
		@:privateAccess
		do
		{
			_rotationVector.setTo(planeVertices[vertPointer], planeVertices[vertPointer + 1], 0);

			// The result of the vert rotation
			var rotation = _rotationVector;

			// apply rotation
			rotation = ModchartUtil.rotate3DVector(rotation, data.angleX, data.angleY, data.angle + data.angleZ);
			// rotation = ModchartUtil.rotatePivot(rotation, data.angle + data.angleZ, planeWidth/6, planeHeight/6, "z");
			// rotation = ModchartUtil.rotatePivot(rotation, data.angleY, planeWidth/6, planeHeight/6, "y");
			// rotation = ModchartUtil.rotatePivot(rotation, data.angleX, planeWidth/6, planeHeight/6, "x");

			// apply skewness
			if (data.skewX != 0 || data.skewY != 0)
			{
				_matrix.identity();

				_matrix.b = FlxMath.fastSin(data.skewY * FlxAngle.TO_RAD) / FlxMath.fastCos(data.skewY * FlxAngle.TO_RAD);
				_matrix.c = FlxMath.fastSin(data.skewX * FlxAngle.TO_RAD) / FlxMath.fastCos(data.skewX * FlxAngle.TO_RAD);

				rotation.x = _matrix.__transformX(rotation.x, rotation.y);
				rotation.y = _matrix.__transformY(rotation.x, rotation.y);
			}
		
			// apply scale
			rotation.x *= data.scaleX;
			rotation.y *= data.scaleY;
			rotation.z *= 0.001;

			// apply perspective
			final projection = ModchartUtil.calculatePerspective(rotation, ModchartUtil.defaultFOV * (Math.PI / 180));

			planeVertices[vertPointer] = data.x + projection.x;
			planeVertices[vertPointer + 1] = data.y + projection.y;

			// stores depth from this vert to use it for perspective correction on uv's (affine texture correction shit)
			projectionZ[Math.floor(vertPointer / 2)] = Math.max(0.0001, projection.z);

			vertPointer = vertPointer + 2;
		}
		while (vertPointer < planeVertices.length);

		parent.alpha = data.alpha;
		
		final uvRectangle = parent.frame.uv;

		// top left
		_vertices[0] = planeVertices[0];
		_vertices[1] = planeVertices[1];
		// top right
		_vertices[2] = planeVertices[2];
		_vertices[3] = planeVertices[3];
		// bottom left
		_vertices[4] = planeVertices[6];
		_vertices[5] = planeVertices[7];

		// top right
		_vertices[6] = planeVertices[0];
		_vertices[7] = planeVertices[1];
		// top left
		_vertices[8] = planeVertices[4];
		_vertices[9] = planeVertices[5];
		// bottom right
		_vertices[10] = planeVertices[6];
		_vertices[11] = planeVertices[7];

		// TODO: fix texture gap when z is not 0
		// uv for triangle 1
		_uv[0] = uvRectangle.x;
		_uv[1] = uvRectangle.y;
		_uv[2] = 1 / projectionZ[0];

		_uv[3] = uvRectangle.width;
		_uv[4] = uvRectangle.y;
		_uv[5] = 1 / projectionZ[1];

		_uv[6] = uvRectangle.width;
		_uv[7] = uvRectangle.height;
		_uv[8] = 1 / projectionZ[3];

		// uv for triangle 2
		_uv[9] = uvRectangle.x;
		_uv[10] = uvRectangle.y;
		_uv[11] = 1 / projectionZ[0];

		_uv[12] = uvRectangle.x;
		_uv[13] = uvRectangle.height;
		_uv[14] = 1 / projectionZ[2];

		_uv[15] = uvRectangle.width;
		_uv[16] = uvRectangle.height;
		_uv[17] = 1 / projectionZ[3];
	}

	override function draw()
	{
		@:privateAccess
		for (camera in parent.cameras)
		{
			if (!camera.visible || !camera.exists)
				continue;
			camera.drawTriangles(parent.graphic, _vertices, _indices, _uv, null, null, parent.blend, false, parent.antialiasing || camera.antialiasing,
				parent.colorTransform, parent.shader);
		}

		super.draw();
	}

	override function destroy()
	{
		//Make sure it doesn't do shit if the fucking sprite already died?
		if (_vertices != null) _vertices.splice(0, _vertices.length);
		if (_uv != null) _uv.splice(0, _uv.length);
		if (_indices != null) _indices.splice(0, _indices.length);

		_vertices = null;
		_uv = null;
		_indices = null;

		_matrix = null;
		_rotationVector = null;

		super.destroy();
	}
}
