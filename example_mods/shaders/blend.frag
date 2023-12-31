#pragma header

//https://www.shadertoy.com/view/Md3GzX
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define iChannel2 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main


uniform int blendMode = 2;


vec3 multiply(in vec3 src, in vec3 dst)
{
	return src * dst;
}

vec3 screen(in vec3 src, in vec3 dst)
{
    return src + dst - src * dst;
}

vec3 exclusion(in vec3 src, in vec3 dst)
{
    return dst + src - (2.0*dst*src);;
}

vec3 overlay(in vec3 src, in vec3 dst)
{
    return mix(2.0 * src * dst, 1.0 - 2.0 * (1.0 - src) * (1.0-dst), step(0.5, dst));
}

vec3 hardlight(in vec3 src, in vec3 dst)
{
    return mix(2.0 * src * dst,  1.0 - 2.0 * (1.0 - src) * (1.0-dst), step(0.5, src));
}

vec3 softlight(in vec3 src, in vec3 dst)
{
    return mix(dst - (1.0 - 2.0 * src) * dst * (1.0 - dst), 
               mix(dst + ( 2.0 * src - 1.0 ) * (sqrt(dst) - dst),
                   dst + (2.0 * src - 1.0) * dst * ((16.0 * dst - 12.0) * dst + 3.0),
                   step(0.5, src) * (1.0 - step(0.25, dst))),
               step(0.5, src));
}

vec3 colorDodge(in vec3 src, in vec3 dst)
{
    return step(0.0, dst) * mix(min(vec3(1.0), dst/ (1.0 - src)), vec3(1.0), step(1.0, src)); 
}

vec3 colorBurn(in vec3 src, in vec3 dst)
{
    return mix(step(0.0, src) * (1.0 - min(vec3(1.0), (1.0 - dst) / src)),
        vec3(1.0), step(1.0, dst));
}

vec3 linearDodge(in vec3 src, in vec3 dst)
{
    return clamp(src.xyz + dst.xyz, 0.0, 1.0);
}

vec3 linearBurn(in vec3 src, in vec3 dst)
{
    return clamp(src.xyz + dst.xyz - 1.0, 0.0, 1.0);
}

vec3 vividLight(in vec3 src, in vec3 dst)
{
    return mix(max(vec3(0.0), 1.0 - min(vec3(1.0), (1.0 - dst) / (2.0 * src))),
               min(vec3(1.0), dst / (2.0 * (1.0 - src))),
               step(0.5, src));
}

vec3 linearLight(in vec3 src, in vec3 dst)
{
    return clamp(2.0 * src + dst - 1.0, 0.0, 1.0);;
}

vec3 pinLight(in vec3 src, in vec3 dst)
{
    return mix(mix(2.0 * src, dst, step(0.5 * dst, src)),
        max(vec3(0.0), 2.0 * src - 1.0), 
        step(dst, (2.0 * src - 1.0))
    );
}

vec3 hardMix(in vec3 src, in vec3 dst)
{
    return step(1.0, src + dst);
}

vec3 subtract(in vec3 src, in vec3 dst)
{
    return dst - src;
}

vec3 divide(in vec3 src, in vec3 dst)
{
    return dst / src;
}

vec3 addition(vec3 src, vec3 dst)
{
    return src + dst;
}

vec3 difference(in vec3 src, in vec3 dst )
{
    return abs(dst - src);   
}

vec3 darken(in vec3 src, in vec3 dst)
{
    return min(src, dst);
}

vec3 lighten(in vec3 src, in vec3 dst)
{
    return max(src, dst);
}

vec3 invert(in vec3 src, in vec3 dst)
{
    return 1.0 - dst;
}

vec3 invertRGB(in vec3 src, in vec3 dst)
{
    return src * (1.0 - dst);
}

vec3 source(in vec3 src, in vec3 dst)
{
	return src;
}

vec3 dest(in vec3 src, in vec3 dst)
{
	return dst;
}

// Branchless RGB2HSL implementation from : https://www.shadertoy.com/view/MsKGRW
vec3 rgb2hsl( in vec3 c )
{
    const float epsilon = 0.00000001;
    float cmin = min( c.r, min( c.g, c.b ) );
    float cmax = max( c.r, max( c.g, c.b ) );
	float cd   = cmax - cmin;
    vec3 hsl = vec3(0.0);
    hsl.z = (cmax + cmin) / 2.0;
    hsl.y = mix(cd / (cmax + cmin + epsilon), cd / (epsilon + 2.0 - (cmax + cmin)), step(0.5, hsl.z));

    vec3 a = vec3(1.0 - step(epsilon, abs(cmax - c)));
    a = mix(vec3(a.x, 0.0, a.z), a, step(0.5, 2.0 - a.x - a.y));
    a = mix(vec3(a.x, a.y, 0.0), a, step(0.5, 2.0 - a.x - a.z));
    a = mix(vec3(a.x, a.y, 0.0), a, step(0.5, 2.0 - a.y - a.z));
    
    hsl.x = dot( vec3(0.0, 2.0, 4.0) + ((c.gbr - c.brg) / (epsilon + cd)), a );
    hsl.x = (hsl.x + (1.0 - step(0.0, hsl.x) ) * 6.0 ) / 6.0;
    return hsl;
}

// HSL2RGB thanks to IQ : https://www.shadertoy.com/view/lsS3Wc
vec3 hsl2rgb(in vec3 c)
{
    vec3 rgb = clamp( abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0 );
    return c.z + c.y * (rgb-0.5)*(1.0-abs(2.0*c.z-1.0));
}

vec3 hue(in vec3 src, in vec3 dst)
{
    vec3 dstHSL = rgb2hsl(dst);
    vec3 srcHSL = rgb2hsl(src);
    return hsl2rgb(vec3(srcHSL.r, dstHSL.gb));
}

vec3 saturation(in vec3 src, in vec3 dst)
{
    vec3 dstHSL = rgb2hsl(dst);
    vec3 srcHSL = rgb2hsl(src);
    return hsl2rgb(vec3(dstHSL.r, srcHSL.g, dstHSL.b));
}

vec3 color(in vec3 src, in vec3 dst)
{
    vec3 dstHSL = rgb2hsl(dst);
    vec3 srcHSL = rgb2hsl(src);
    return hsl2rgb(vec3(srcHSL.rg, dstHSL.b));
}

vec3 luminosity(in vec3 src, in vec3 dst)
{
    vec3 dstHSL = rgb2hsl(dst);
    vec3 srcHSL = rgb2hsl(src);
    return hsl2rgb(vec3(dstHSL.rg, srcHSL.b));
}

vec3 blend(in vec3 src, in vec3 dst, in int mode)
{
    //if (mode == )  return source(src, dst);
    //if (mode == )  return dest(src, dst);
    if (mode == 0)  return screen(src, dst);
    if (mode == 1)  return multiply(src, dst);
    if (mode == 2)  return overlay(src, dst);
    if (mode == 3)  return hardlight(src, dst);
    if (mode == 4)  return softlight(src, dst);
    if (mode == 5)  return colorDodge(src, dst);
    if (mode == 6)  return colorBurn(src, dst);
    if (mode == 7)  return linearDodge(src, dst);
    if (mode == 8)  return linearBurn(src, dst);
    if (mode == 9)  return vividLight(src, dst);
    if (mode == 10) return linearLight(src, dst);
    if (mode == 11) return pinLight(src, dst);
    if (mode == 12) return hardMix(src, dst);
    if (mode == 13) return subtract(src, dst);
    if (mode == 14) return divide(src, dst);
    if (mode == 15) return addition(src, dst);
    if (mode == 16) return difference(src, dst);
    if (mode == 17) return darken(src, dst);
    if (mode == 18) return lighten(src, dst);
    if (mode == 19) return invert(src, dst);
    if (mode == 20) return invertRGB(src, dst);
    if (mode == 21) return hue(src, dst);
    if (mode == 22) return saturation(src, dst);
    if (mode == 23) return color(src, dst);
    if (mode == 24) return luminosity(src, dst);
    if (mode == 25) return exclusion(src, dst);
    return vec3(0.0,0.0,0.0);
}

///////////////////////////////////
// MAIN
///////////////////////////////////

void main()
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    
    // Blending
	int mode = int(texture(iChannel0, vec2(0.0, 0.0)).x);
    vec3 src = texture(iChannel1, uv).xyz; // Top layer
    vec3 dst = texture(iChannel2, uv).xyz; // Bottom layer
    
    fragColor.xyz = blend(src, dst, blendMode);
}