package modcharting.utils;

import objects.Note;

class RGBPalette
{
	public var shader(default, null):RGBPaletteShader = new RGBPaletteShader();
	public var r(default, set):FlxColor;
	public var g(default, set):FlxColor;
	public var b(default, set):FlxColor;
	public var mult(default, set):Float;

	public var stealthGlow(default, set):Float;
	public var stealthGlowRed(default, set):Float;
	public var stealthGlowGreen(default, set):Float;
	public var stealthGlowBlue(default, set):Float;

	public var isHold(default, set):Bool;

	public var bottomStealth(default, set):Float;
	public var bottomAlpha(default, set):Float;
	public var bottomRed(default, set):Float;
	public var bottomGreen(default, set):Float;
	public var bottomBlue(default, set):Float;
	public var bottomStealthRed(default, set):Float;
	public var bottomStealthGreen(default, set):Float;
	public var bottomStealthBlue(default, set):Float;

	public var topStealth(default, set):Float;
	public var topAlpha(default, set):Float;
	public var topRed(default, set):Float;
	public var topGreen(default, set):Float;
	public var topBlue(default, set):Float;
	public var topStealthRed(default, set):Float;
	public var topStealthGreen(default, set):Float;
	public var topStealthBlue(default, set):Float;

	public var enabled(default, set):Bool;

	public function copyValues(tempShader:RGBPalette)
	{
		if (tempShader != null)
		{
			for (i in 0...3)
			{
				shader.r.value[i] = tempShader.shader.r.value[i];
				shader.g.value[i] = tempShader.shader.g.value[i];
				shader.b.value[i] = tempShader.shader.b.value[i];
			}
			shader.mult.value[0] = tempShader.shader.mult.value[0];
		}
		else
			shader.mult.value[0] = 0.0;
	}

	private function set_r(color:FlxColor)
	{
		r = color;
		shader.r.value = [color.redFloat, color.greenFloat, color.blueFloat];
		return color;
	}

	private function set_g(color:FlxColor)
	{
		g = color;
		shader.g.value = [color.redFloat, color.greenFloat, color.blueFloat];
		return color;
	}

	private function set_b(color:FlxColor)
	{
		b = color;
		shader.b.value = [color.redFloat, color.greenFloat, color.blueFloat];
		return color;
	}

	private function set_mult(value:Float)
	{
		mult = Math.max(0, Math.min(1, value));
		shader.mult.value = [mult];
		return value;
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

	private function set_isHold(value:Bool)
	{
		isHold = value;
		shader._isHold.value = [isHold];
		return value;
	}

	private function set_bottomStealth(value:Float):Float
	{
		bottomStealth = value;
		shader._bottomStealth.value = [value];
		return value;
	}

	private function set_bottomAlpha(value:Float):Float
	{
		bottomAlpha = value;
		shader._bottomAlpha.value = [value];
		return value;
	}

	private function set_bottomRed(value:Float):Float
	{
		bottomRed = value;
		shader._bottomRed.value = [value];
		return value;
	}

	private function set_bottomGreen(value:Float):Float
	{
		bottomGreen = value;
		shader._bottomGreen.value = [value];
		return value;
	}

	private function set_bottomBlue(value:Float):Float
	{
		bottomBlue = value;
		shader._bottomBlue.value = [value];
		return value;
	}

	private function set_bottomStealthRed(value:Float):Float
	{
		bottomStealthRed = value;
		shader._bottomStealthRed.value = [value];
		return value;
	}

	private function set_bottomStealthGreen(value:Float):Float
	{
		bottomStealthGreen = value;
		shader._bottomStealthGreen.value = [value];
		return value;
	}

	private function set_bottomStealthBlue(value:Float):Float
	{
		bottomStealthBlue = value;
		shader._bottomStealthBlue.value = [value];
		return value;
	}

	private function set_topStealth(value:Float):Float
	{
		topStealth = value;
		shader._topStealth.value = [value];
		return value;
	}

	private function set_topAlpha(value:Float):Float
	{
		topAlpha = value;
		shader._topAlpha.value = [value];
		return value;
	}

	private function set_topRed(value:Float):Float
	{
		topRed = value;
		shader._topRed.value = [value];
		return value;
	}

	private function set_topGreen(value:Float):Float
	{
		topGreen = value;
		shader._topGreen.value = [value];
		return value;
	}

	private function set_topBlue(value:Float):Float
	{
		topBlue = value;
		shader._topBlue.value = [value];
		return value;
	}

	private function set_topStealthRed(value:Float):Float
	{
		topStealthRed = value;
		shader._topStealthRed.value = [value];
		return value;
	}

	private function set_topStealthGreen(value:Float):Float
	{
		topStealthGreen = value;
		shader._topStealthGreen.value = [value];
		return value;
	}

	private function set_topStealthBlue(value:Float):Float
	{
		topStealthBlue = value;
		shader._topStealthBlue.value = [value];
		return value;
	}

	private function set_enabled(value:Bool)
	{
		enabled = value;
		shader.enableRGB.value = [enabled];
		return value;
	}

	public function new()
	{
		r = 0xFFFF0000;
		g = 0xFF00FF00;
		b = 0xFF0000FF;
		mult = 1.0;

		stealthGlow = 0.0;
		stealthGlowRed = 1.0;
		stealthGlowGreen = 1.0;
		stealthGlowBlue = 1.0;

		isHold = false;
		bottomStealth = bottomAlpha = bottomRed = bottomGreen = bottomBlue = bottomStealthRed = bottomStealthGreen = bottomStealthBlue = 0;
		topStealth = topAlpha = topRed = topGreen = topBlue = topStealthRed = topStealthGreen = topStealthBlue = 0;

		enabled = true;
	}
}

// automatic handler for easy usability
class RGBShaderReference
{
	public var r(default, set):FlxColor;
	public var g(default, set):FlxColor;
	public var b(default, set):FlxColor;
	public var mult(default, set):Float;

	public var stealthGlow(default, set):Float;
	public var stealthGlowRed(default, set):Float;
	public var stealthGlowGreen(default, set):Float;
	public var stealthGlowBlue(default, set):Float;

	public var isHold(default, set):Bool = false;

	public var bottomStealth(default, set):Float;
	public var bottomAlpha(default, set):Float;
	public var bottomRed(default, set):Float;
	public var bottomGreen(default, set):Float;
	public var bottomBlue(default, set):Float;
	public var bottomStealthRed(default, set):Float;
	public var bottomStealthGreen(default, set):Float;
	public var bottomStealthBlue(default, set):Float;

	public var topStealth(default, set):Float;
	public var topAlpha(default, set):Float;
	public var topRed(default, set):Float;
	public var topGreen(default, set):Float;
	public var topBlue(default, set):Float;
	public var topStealthRed(default, set):Float;
	public var topStealthGreen(default, set):Float;
	public var topStealthBlue(default, set):Float;

	public var enabled(default, set):Bool = true;

	public var parent:RGBPalette;

	private var _owner:FlxSprite;
	private var _original:RGBPalette;

	public function new(owner:FlxSprite, ref:RGBPalette)
	{
		parent = ref;
		_owner = owner;
		_original = ref;
		owner.shader = ref.shader;

		@:bypassAccessor
		{
			r = parent.r;
			g = parent.g;
			b = parent.b;
			mult = parent.mult;

			stealthGlow = parent.stealthGlow;
			stealthGlowRed = parent.stealthGlowRed;
			stealthGlowGreen = parent.stealthGlowGreen;
			stealthGlowBlue = parent.stealthGlowBlue;

			isHold = parent.isHold;

			bottomStealth = parent.bottomStealth;
			bottomAlpha = parent.bottomAlpha;
			bottomRed = parent.bottomRed;
			bottomGreen = parent.bottomGreen;
			bottomBlue = parent.bottomBlue;
			bottomStealthRed = parent.bottomStealthRed;
			bottomStealthGreen = parent.bottomStealthGreen;
			bottomStealthBlue = parent.bottomStealthBlue;

			topStealth = parent.topStealth;
			topAlpha = parent.topAlpha;
			topRed = parent.topRed;
			topGreen = parent.topGreen;
			topBlue = parent.topBlue;
			topStealthRed = parent.topStealthRed;
			topStealthGreen = parent.topStealthGreen;
			topStealthBlue = parent.topStealthBlue;
		}
	}

	private function set_r(value:FlxColor)
	{
		if (allowNew && value != _original.r)
			cloneOriginal();
		return (r = parent.r = value);
	}

	private function set_g(value:FlxColor)
	{
		if (allowNew && value != _original.g)
			cloneOriginal();
		return (g = parent.g = value);
	}

	private function set_b(value:FlxColor)
	{
		if (allowNew && value != _original.b)
			cloneOriginal();
		return (b = parent.b = value);
	}

	private function set_mult(value:Float)
	{
		if (allowNew && value != _original.mult)
			cloneOriginal();
		return (mult = parent.mult = value);
	}

	private function set_enabled(value:Bool)
	{
		if (allowNew && value != _original.enabled)
			cloneOriginal();
		return (enabled = parent.enabled = value);
	}

	private function set_stealthGlow(value:Float)
	{
		if (allowNew && value != _original.stealthGlow)
			cloneOriginal();
		return (stealthGlow = parent.stealthGlow = value);
	}

	private function set_stealthGlowRed(value:Float)
	{
		if (allowNew && value != _original.stealthGlowRed)
			cloneOriginal();
		return (stealthGlowRed = parent.stealthGlowRed = value);
	}

	private function set_stealthGlowGreen(value:Float)
	{
		if (allowNew && value != _original.stealthGlowGreen)
			cloneOriginal();
		return (stealthGlowGreen = parent.stealthGlowGreen = value);
	}

	private function set_stealthGlowBlue(value:Float)
	{
		if (allowNew && value != _original.stealthGlowBlue)
			cloneOriginal();
		return (stealthGlowBlue = parent.stealthGlowBlue = value);
	}

	private function set_isHold(value:Bool)
	{
		if (allowNew && value != _original.isHold)
			cloneOriginal();
		return (isHold = parent.isHold = value);
	}

	private function set_bottomStealth(value:Float):Float
	{
		if (allowNew && value != _original.bottomStealth)
			cloneOriginal();
		return (bottomStealth = parent.bottomStealth = value);
	}

	private function set_bottomAlpha(value:Float):Float
	{
		if (allowNew && value != _original.bottomAlpha)
			cloneOriginal();
		return (bottomAlpha = parent.bottomAlpha = value);
	}

	private function set_bottomRed(value:Float):Float
	{
		if (allowNew && value != _original.bottomRed)
			cloneOriginal();
		return (bottomRed = parent.bottomRed = value);
	}

	private function set_bottomGreen(value:Float):Float
	{
		if (allowNew && value != _original.bottomGreen)
			cloneOriginal();
		return (bottomGreen = parent.bottomGreen = value);
	}

	private function set_bottomBlue(value:Float):Float
	{
		if (allowNew && value != _original.bottomBlue)
			cloneOriginal();
		return (bottomBlue = parent.bottomBlue = value);
	}

	private function set_bottomStealthRed(value:Float):Float
	{
		if (allowNew && value != _original.bottomStealthRed)
			cloneOriginal();
		return (bottomStealthRed = parent.bottomStealthRed = value);
	}

	private function set_bottomStealthGreen(value:Float):Float
	{
		if (allowNew && value != _original.bottomStealthGreen)
			cloneOriginal();
		return (bottomStealthGreen = parent.bottomStealthGreen = value);
	}

	private function set_bottomStealthBlue(value:Float):Float
	{
		if (allowNew && value != _original.bottomStealthBlue)
			cloneOriginal();
		return (bottomStealthBlue = parent.bottomStealthBlue = value);
	}

	private function set_topStealth(value:Float):Float
	{
		if (allowNew && value != _original.topStealth)
			cloneOriginal();
		return (topStealth = parent.topStealth = value);
	}

	private function set_topAlpha(value:Float):Float
	{
		if (allowNew && value != _original.topAlpha)
			cloneOriginal();
		return (topAlpha = parent.topAlpha = value);
	}

	private function set_topRed(value:Float):Float
	{
		if (allowNew && value != _original.topRed)
			cloneOriginal();
		return (topRed = parent.topRed = value);
	}

	private function set_topGreen(value:Float):Float
	{
		if (allowNew && value != _original.topGreen)
			cloneOriginal();
		return (topGreen = parent.topGreen = value);
	}

	private function set_topBlue(value:Float):Float
	{
		if (allowNew && value != _original.topBlue)
			cloneOriginal();
		return (topBlue = parent.topBlue = value);
	}

	private function set_topStealthRed(value:Float):Float
	{
		if (allowNew && value != _original.topStealthRed)
			cloneOriginal();
		return (topStealthRed = parent.topStealthRed = value);
	}

	private function set_topStealthGreen(value:Float):Float
	{
		if (allowNew && value != _original.topStealthGreen)
			cloneOriginal();
		return (topStealthGreen = parent.topStealthGreen = value);
	}

	private function set_topStealthBlue(value:Float):Float
	{
		if (allowNew && value != _original.topStealthBlue)
			cloneOriginal();
		return (topStealthBlue = parent.topStealthBlue = value);
	}

	public var allowNew = true;

	private function cloneOriginal()
	{
		if (allowNew)
		{
			allowNew = false;
			if (_original != parent)
				return;

			parent = new RGBPalette();
			parent.r = _original.r;
			parent.g = _original.g;
			parent.b = _original.b;
			parent.mult = _original.mult;

			parent.stealthGlow = _original.stealthGlow;
			parent.stealthGlowRed = _original.stealthGlowRed;
			parent.stealthGlowGreen = _original.stealthGlowGreen;
			parent.stealthGlowBlue = _original.stealthGlowBlue;

			parent.isHold = _original.isHold;

			parent.bottomStealth = _original.bottomStealth;
			parent.bottomAlpha = _original.bottomAlpha;
			parent.bottomRed = _original.bottomRed;
			parent.bottomGreen = _original.bottomGreen;
			parent.bottomBlue = _original.bottomBlue;
			parent.bottomStealthRed = _original.bottomStealthRed;
			parent.bottomStealthGreen = _original.bottomStealthGreen;
			parent.bottomStealthBlue = _original.bottomStealthBlue;

			parent.topStealth = _original.topStealth;
			parent.topAlpha = _original.topAlpha;
			parent.topRed = _original.topRed;
			parent.topGreen = _original.topGreen;
			parent.topBlue = _original.topBlue;
			parent.topStealthRed = _original.topStealthRed;
			parent.topStealthGreen = _original.topStealthGreen;
			parent.topStealthBlue = _original.topStealthBlue;

			parent.enabled = _original.enabled;
			_owner.shader = parent.shader;
			// trace('created new shader');
		}
	}
}

class RGBPaletteShader extends flixel.system.FlxAssets.FlxShader
{
	@:glFragmentHeader('
		#pragma header

		uniform vec3 r;
		uniform vec3 g;
		uniform vec3 b;
		uniform float mult;
		uniform bool enableRGB;

		vec4 flixel_texture2DCustom(sampler2D bitmap, vec2 coord) {
			vec4 color = flixel_texture2D(bitmap, coord);
			if (!hasTransform) {
				return color;
			}

			if(color.a == 0.0 || mult == 0.0) {
				return color * openfl_Alphav;
			}

			if(enableRGB){
				vec4 newColor = color;
				newColor.rgb = min(color.r * r + color.g * g + color.b * b, vec3(1.0));
				newColor.a = color.a;
				color = mix(color, newColor, mult);
			}

			if(color.a > 0.0) {
				return vec4(color.rgb, color.a);
			}
			return vec4(0.0, 0.0, 0.0, 0.0);
		}')
	@:glFragmentSource('
		#pragma header

		uniform float _stealthGlow;
		uniform float _stealthR;
		uniform float _stealthG;
		uniform float _stealthB;

		uniform bool _isHold;

		uniform float _bottomStealth;
		uniform float _bottomAlpha;
		uniform float _bottomRed;
		uniform float _bottomGreen;
		uniform float _bottomBlue;
		uniform float _bottomStealthRed;
		uniform float _bottomStealthGreen;
		uniform float _bottomStealthBlue;

		uniform float _topStealth;
		uniform float _topAlpha;
		uniform float _topRed;
		uniform float _topGreen;
		uniform float _topBlue;
		uniform float _topStealthRed;
		uniform float _topStealthGreen;
		uniform float _topStealthBlue;

		vec4 applyStealth(vec4 curCol, float stealth, float stealthR, float stealthG, float stealthB)
		{
			vec4 glow = vec4(stealthR,stealthG,stealthB, 1.0);
			float _stealthGlow_clamped = clamp(stealth, 0.0, 1.0);
			glow *=  curCol[3]; //Apply Alpha from texture
			glow = clamp(glow, 0.0, 1.0);
			curCol = mix(curCol, glow, _stealthGlow_clamped);
			return curCol;
		}
		vec4 applyAlpha(vec4 curCol, float alpha)
		{
			curCol *=  alpha;
			return curCol;
		}
		vec4 applyCol(vec4 curCol, float r, float g, float b)
		{
				curCol.rgb *= vec3(r,g,b);
				return curCol;
		}

		void main() {
			vec4 color = flixel_texture2DCustom(bitmap, openfl_TextureCoordv);

			if(_isHold){
				vec4 colorTop = color;
				vec4 colorBottom = color;

				colorTop = applyCol(colorTop, _topRed,_topGreen, _topBlue );
				colorBottom = applyCol(colorBottom, _bottomRed, _bottomGreen,_bottomBlue );

				colorTop = applyAlpha(colorTop, _topAlpha);
				colorBottom = applyAlpha(colorBottom, _bottomAlpha);

				colorTop = applyStealth(colorTop, _topStealth, _topStealthRed,_topStealthGreen, _topStealthBlue );
				colorBottom = applyStealth(colorBottom, _bottomStealth, _bottomStealthRed,_bottomStealthGreen, _bottomStealthBlue );


				// Blend the two
				colorTop = clamp(colorTop, 0.0, 1.0);
				colorBottom = clamp(colorBottom, 0.0, 1.0);
				color = mix(colorBottom, colorTop, openfl_TextureCoordv.y);

			}else{
				color = applyStealth(color, _stealthGlow, _stealthR, _stealthG, _stealthB);
			}

			gl_FragColor = color;

		}')
	public function new()
	{
		super();
	}
}