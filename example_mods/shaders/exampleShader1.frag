#pragma header

#define PI 3.14159265359

float opacity = .3;

const vec2 fixedSize = vec2(1280., 720.);

vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * fixedSize;//openfl_TextureSize;

uniform sampler2D bitmap1;
uniform float time;

float rand(float n){return fract(sin(n) * 43758.5453123);}

float noise(float p) {
	float fl = floor(p);
	float fc = fract(p);
	return mix(rand(fl), rand(fl + 1.), fc);
}

vec4 renderBitmap1() {
	vec2 uv1 = uv;
	uv1.x += (noise((fragCoord.y / 24.) + (time * 5.)) - .5) * (25. / 1280.);
	uv1.y += (noise((fragCoord.x / 24.) + (time * 3.)) - .5) * (25. / 720.);
	
	return flixel_texture2D(bitmap1, uv1);
}

vec4 renderBitmap0() {
	return flixel_texture2D(bitmap, uv);
}

float pixelSize = 8.0;
vec4 renderBitmap0Mask() {
	vec2 uv1 = uv * fixedSize;
	
    vec2 modul = mod(uv1, pixelSize);
	vec2 normalizedCord = uv1 - modul;
	
	vec2 uv2 = normalizedCord / fixedSize;
	
	uv2.x += (noise((fragCoord.y / 24.) + (time * 5.)) - .5) * (45. / 1280.);
	uv2.y += (noise((fragCoord.x / 24.) + (time * 3.)) - .5) * (45. / 720.);
	
	return flixel_texture2D(bitmap, uv2);
}

void main() {
	vec4 col0 = renderBitmap0();
	vec4 col0mask = renderBitmap0Mask();
	vec4 col1 = renderBitmap1();
	
	col0mask *= col1.a;
	col0 *= -col0mask.a + 1.;
	
	col1 *= opacity * col0mask.a;
	
	gl_FragColor = (col0 + col0mask) + col1;
}