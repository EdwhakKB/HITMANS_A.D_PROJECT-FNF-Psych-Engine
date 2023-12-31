#pragma header
  uniform float r;
  uniform float g;
  uniform float b;
  uniform float blend;

void main()
{
  vec3 col = vec3(r,g,b);

  vec4 textureStuff = flixel_texture2D(bitmap,openfl_TextureCoordv);

  col = mix(col, textureStuff.rgb, blend);

  float sampleAlpha = textureStuff.a;
  col *= sampleAlpha;
  gl_FragColor = vec4(col.r,col.g,col.b,sampleAlpha);
}