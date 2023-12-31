#pragma header

uniform float brightness = 1;
uniform float saturation = 1;

void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    float f = (color.x+color.y+color.z) / 3.0;
    color.xyz = brightness+f*+color.xyz*3;

    color.a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;

    gl_FragColor = color;
}