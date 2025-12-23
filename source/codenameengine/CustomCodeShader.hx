package codenameengine;

import haxe.Exception;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

/**
 * Class for custom shaders.
 *
 * To create one, create a `shaders` folder in your assets/mod folder, then add a file named `my-shader.frag` or/and `my-shader.vert`.
 *
 * Non-existent shaders will only load the default one, and throw a warning in the console.
 *
 * To access the shader's uniform variables, use `shader.variable`
 */
class CustomCodeShader extends FunkinShader {
	public var path:String = "";

	/**
	 * Creates a new custom shader
	 * @param name Name of the frag and vert files.
	 * @param glslVersion GLSL version to use. Defaults to `120`.
	 */
	public function new(name:String, glslVersion:String = "120") {
		var fragShaderPath = Paths.getFilePath('$name.frag');
		var vertShaderPath = Paths.getFilePath('$name.vert');
		var fragCode = Paths.getTextFromFile(fragShaderPath);
		var vertCode = Paths.getTextFromFile(vertShaderPath);

		path = fragShaderPath+vertShaderPath;

		if (fragCode == null && vertCode == null)
			trace('Shader "$name" couldn\'t be found.');

		super(fragCode, vertCode, glslVersion);
	}
}