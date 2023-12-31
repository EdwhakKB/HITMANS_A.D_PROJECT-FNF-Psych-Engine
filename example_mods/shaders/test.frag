#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
#define scale_uv(uv, scale, center) ((uv - center) * scale + center)

void mainImage() {
    vec2 uv = coord / iResolution.xy;
    
    float t = iTime * 1.0;
    vec2 center = vec2(
        sin(t * 1.25 + 75.0 + uv.y * 0.5) + sin(t * 2.75 - 18.0 - uv.x * 0.25),
        sin(t * 1.75 - 125.0 + uv.x * 0.25) + sin(t * 2.25 + 4.0 - uv.y * 0.5)
    ) * 0.25 + 0.5;
    
    vec2 mouse = iMouse.xy / iResolution.xy;
    float z = (iMouse.z > 0.0) ?
        1.0 - distance(mouse, vec2(0.5)) :
        sin((t + 234.5) * 3.0) * 0.05 + 0.75;
    
    vec2 uv2 = scale_uv(uv, z, center);
    
    color = texture(iChannel0, uv2);
    
    float vignette = 1.0 - distance(uv, vec2(0.5));
    color = mix(color, color * vignette, sin((t + 80.023) * 2.0) * 0.75);
}