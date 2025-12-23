package modcharting;

// STOLEN FROM HAXEFLIXEL DEMO LOL
// Am I even allowed to use this?
// Blantados code! Thanks!!
import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.tile.FlxGraphicsShader;
import flixel.math.FlxAngle;
import flixel.system.FlxAssets.FlxShader;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import haxe.Json;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.Shader;
import openfl.display.ShaderInput;
import openfl.utils.Assets;

using StringTools;

class ShaderEffectNew
{
	public function update(elapsed:Float)
	{
		// nothing yet
	}
}

class StealthEffect extends ShaderEffectNew
{
	public var shader(default, null):StealthShader = new StealthShader();
	public var stealthGlow(default, set):Float;
	public var stealthGlowRed(default, set):Float;
	public var stealthGlowGreen(default, set):Float;
	public var stealthGlowBlue(default, set):Float;

	public function new()
	{
		stealthGlow = 0.0;
		stealthGlowRed = 1.0;
		stealthGlowGreen = 1.0;
		stealthGlowBlue = 1.0;
	}

	private function set_stealthGlow(value:Float)
	{
		stealthGlow = value;
		shader._stealthGlow.value = [stealthGlow];
		return value;
	}

	private function set_stealthGlowRed(value:Float)
	{
		stealthGlowRed = value;
		shader._stealthR.value = [stealthGlowRed];
		return value;
	}

	private function set_stealthGlowGreen(value:Float)
	{
		stealthGlowGreen = value;
		shader._stealthG.value = [stealthGlowGreen];
		return value;
	}

	private function set_stealthGlowBlue(value:Float)
	{
		stealthGlowBlue = value;
		shader._stealthB.value = [stealthGlowBlue];
		return value;
	}
}

class StealthShader extends FlxShader
{
	@:glFragmentSource('
        #pragma header

        uniform float _stealthGlow;
        uniform float _stealthR;
        uniform float _stealthG;
        uniform float _stealthB;

        void main()
        {
            vec4 spritecolor = flixel_texture2D(bitmap, openfl_TextureCoordv);
            vec4 col = vec4(_stealthR,_stealthG,_stealthB, spritecolor.a);
            vec3 finalCol = mix(col.rgb*spritecolor.a, spritecolor.rgb, _stealthGlow);

            gl_FragColor = vec4(finalCol.r, finalCol.g, finalCol.b, spritecolor.a );
        }
    ')
	public function new()
	{
		super();
	}
}

class ThreeDEffect extends ShaderEffectNew
{
	public var shader:ThreeDShader = new ThreeDShader();

	public var xrot(default, set):Float = 0;
	public var yrot(default, set):Float = 0;
	public var zrot(default, set):Float = 0;
	public var depth(default, set):Float = 0;

	public function new()
	{
		shader.xrot.value = [xrot];
		shader.yrot.value = [yrot];
		shader.zrot.value = [zrot];
		shader.depth.value = [depth];
	}

	override public function update(elapsed:Float)
	{
		shader.xrot.value = [xrot];
		shader.yrot.value = [yrot];
		shader.zrot.value = [zrot];
		shader.depth.value = [depth];
	}

	function set_xrot(x:Float):Float
	{
		xrot = x;
		shader.xrot.value = [xrot];
		return x;
	}

	function set_yrot(y:Float):Float
	{
		yrot = y;
		shader.yrot.value = [yrot];
		return y;
	}

	function set_zrot(z:Float):Float
	{
		zrot = z;
		shader.zrot.value = [zrot];
		return z;
	}

	function set_depth(d:Float):Float
	{
		depth = d;
		shader.depth.value = [depth];
		return d;
	}
}

class ThreeDShader extends FlxShader
{
	@:glFragmentSource('
        #pragma header
        //fixed by edwhak
        //i just defined and fixed some PI math and fragColor fixed for notes
        #define PI 3.14159265
        uniform float xrot = 0.0;
        uniform float yrot = 0.0;
        uniform float zrot = 0.0;
        uniform float depth = 0.0;

        float plane( in vec3 norm, in vec3 po, in vec3 ro, in vec3 rd ) {
            float de = dot(norm, rd);
            de = sign(de)*max( abs(de), 0.001);
            return dot(norm, po-ro)/de;
        }

        vec2 raytraceTexturedQuad(in vec3 rayOrigin, in vec3 rayDirection, in vec3 quadCenter, in vec3 quadRotation, in vec2 quadDimensions) {
            //Rotations ------------------
            float a = sin(quadRotation.x); float b = cos(quadRotation.x); 
            float c = sin(quadRotation.y); float d = cos(quadRotation.y); 
            float e = sin(quadRotation.z); float f = cos(quadRotation.z); 
            float ac = a*c;   float bc = b*c;
            
            mat3 RotationMatrix  = 
                    mat3(	  d*f,      d*e,  -c,
                        ac*f-b*e, ac*e+b*f, a*d,
                        bc*f+a*e, bc*e-a*f, b*d );
            //--------------------------------------
            
            vec3 right = RotationMatrix * vec3(quadDimensions.x, 0.0, 0.0);
            vec3 up = RotationMatrix * vec3(0, quadDimensions.y, 0);
            vec3 normal = cross(right, up);
            normal /= length(normal);
            
            //Find the plane hit point in space
            vec3 pos = (rayDirection * plane(normal, quadCenter, rayOrigin, rayDirection)) - quadCenter;
            
            //Find the texture UV by projecting the hit point along the plane dirs
            return vec2(dot(pos, right) / dot(right, right),
                        dot(pos, up)    / dot(up,    up)) + 0.5;
        }

        void main() {
            vec4 texColor = texture2D(bitmap, openfl_TextureCoordv);
            //Screen UV goes from 0 - 1 along each axis
            vec2 screenUV = openfl_TextureCoordv;
            vec2 p = (2.0 * screenUV) - 1.0;
            float screenAspect = 1280/720;
            p.x *= screenAspect;
            
            //Normalized Ray Dir
            vec3 dir = vec3(p.x, p.y, 1.0);
            dir /= length(dir);
            
            //Define the plane
            vec3 planePosition = vec3(0.0, 0.0, depth+0.5);
            vec3 planeRotation = vec3(xrot, PI+yrot, zrot);//this the shit you needa change
            vec2 planeDimension = vec2(-screenAspect, 1.0);
            
            vec2 uv = raytraceTexturedQuad(vec3(0), dir, planePosition, planeRotation, planeDimension);
            
            //If we hit the rectangle, sample the texture
            if(abs(uv.x - 0.5) < 0.5 && abs(uv.y - 0.5) < 0.5) {
            gl_FragColor = vec4(flixel_texture2D(bitmap, uv));
            }
        }
	')
	public function new()
	{
		super();
	}
}

// some unused shaders that might work?
/*
	StealthShader2

	#pragma header

	uniform float red;
	uniform float green;
	uniform float blue;
	uniform float fade;

	void main()
	{
		vec4 spritecolor = flixel_texture2D(bitmap, openfl_TextureCoordv);
		vec4 col = vec4(red/255,green/255,blue/255, spritecolor.a);
		vec3 finalCol = mix(col.rgb*spritecolor.a, spritecolor.rgb, fade);

		gl_FragColor = vec4( finalCol.r, finalCol.g, finalCol.b, spritecolor.a );
	}


	OG Shader
	#pragma header

		uniform float _stealthGlow;
		uniform float _stealthR;
		uniform float _stealthG;
		uniform float _stealthB;

		void main()
		{
			vec3 col = vec3(_stealthR,_stealthG,_stealthB);

			vec4 textureStuff = flixel_texture2D(bitmap,openfl_TextureCoordv);

			col = mix(col, textureStuff.rgb, _stealthGlow);

			float sampleAlpha = textureStuff.a;
			col *= sampleAlpha;
			gl_FragColor = vec4(col.r,col.g,col.b,sampleAlpha);
		}

 */
