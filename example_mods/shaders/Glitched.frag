#pragma header
// Monitor Glitch - Shader-Effect simulating bad TV reception
//
// Written in 2015 by JT (shaderview@protonmail.com)
//
// CC0 License
//
// To the extent possible under law, the author has dedicated
// all copyright and related and neighboring rights to this software
// to the public domain worldwide.
// This software is distributed without any warranty.
//
// For a copy of the CC0 Public Domain Dedication see <http://creativecommons.org/publicdomain/zero/1.0/>.

#define pi 3.1415926

uniform vec3      iResolution;           // viewport resolution (in pixels)
uniform float     iTime;                 // shader playback time (in seconds)
uniform float     iTimeDelta;            // render time (in seconds)
uniform float     iFrameRate;            // shader frame rate
uniform int       iFrame;                // shader playback frame
uniform float     iChannelTime[4];       // channel playback time (in seconds)
uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
uniform vec4      iDate;                 // (year, month, day, time in seconds)
float t;

vec3 colorSplit(vec2 uv, vec2 s)
{
    vec3 color;
    color.r = texture(iChannel0, uv - s).r;
    color.g = texture(iChannel0, uv    ).g;
    color.b = texture(iChannel0, uv + s).b;
    return color;
}

vec2 interlace(vec2 uv, float s)
{
    uv.x += s * (4.0 * fract((uv.y * iResolution.y) / 2.0) - 1.0);
    return uv;
}

vec2 fault(vec2 uv, float s)
{
    //float v = (0.5 + 0.5 * cos(2.0 * pi * uv.y)) * (2.0 * uv.y - 1.0);
    float v = pow(0.5 - 0.5 * cos(2.0 * pi * uv.y), 100.0) * sin(2.0 * pi * uv.y);
    uv.x += v * s;
    return uv;
}

vec2 rnd(vec2 uv, float s)
{
    uv.x += s * (2.0 * texture(iChannel1, uv * 0.05).x - 1.0);
    return uv;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // t = fract(iTime / 10.0) * 10.0
    float t = iTime / 10.0;

	vec2 uv = -fragCoord.xy / iResolution.xy;
    
    //float s = pow(0.5 + 0.5 * cos(2.0 * pi * t), 1000.0);
    float s = texture(iChannel1, vec2(t * 0.2, 0.5)).r;
    
    uv = interlace(uv, s * 0.005);
    //uv = fault(uv, s);
    float r = texture(iChannel2, vec2(t, 0.0)).x;
    //uv = fault(uv + vec2(0.0, fract(t * 20.0)), r) - vec2(0.0, fract(t * 20.0));
    uv = fault(uv + vec2(0.0, fract(t * 2.0)), 5.0 * sign(r) * pow(abs(r), 5.0)) - vec2(0.0, fract(t * 2.0));
    uv = rnd(uv, s * 0.02);
    
    vec3 color = colorSplit(uv, vec2(s * 0.02, 0.0));
    //vec2 m = texture(iChannel2, uv).xy;
    color = mix(color, texture(iChannel1, 0.5 * uv + t * 100.0).rgb, 0.25);
    
	fragColor = vec4(color, 1.0);
}