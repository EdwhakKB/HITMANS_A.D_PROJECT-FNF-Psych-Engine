#pragma header

vec2 uv = openfl_TextureCoordv.xy;

void main(void)
{
    uv.x = abs(uv.x-1.0);

    gl_FragColor = texture2D(bitmap, uv);
}