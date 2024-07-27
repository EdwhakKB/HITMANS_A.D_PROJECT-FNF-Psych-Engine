package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.tile.FlxDrawTrianglesItem;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxAssets.FlxShader;
import flixel.util.FlxColor;
import lime.math.Vector2;
import openfl.filters.BitmapFilter;
import openfl.filters.DropShadowFilter;
import openfl.filters.ShaderFilter;
import openfl.geom.Matrix;
import openfl.geom.Vector3D;
import openfl.geom.ColorTransform;
import openfl.display.BitmapData;
import openfl.display.TriangleCulling;

import editors.ChartingState;

// import flixel.addons.effects.FlxSkewedSprite;

import modcharting.FlxFilteredSkewedSprite as FlxImprovedSprite;
import modcharting.ModchartUtil;

import RGBPalette;
import RGBPalette.RGBShaderReference;

using StringTools;

typedef EventNote = {
	strumTime:Float,
	event:String,
	value1:String,
	value2:String
}

class Note extends FlxImprovedSprite
{

	// Modcharting Stuff ---->
	// Galaxy stuff
	private static var alphas:Map<String, Map<String, Map<Int, Array<Float>>>> = new Map();
	private static var indexes:Map<String, Map<String, Map<Int, Array<Int>>>> = new Map();
	private static var glist:Array<FlxGraphic> = [];

	public var gpix:FlxGraphic = null;
	public var oalp:Float = 1;
	public var oanim:String = "";

	// If set, will reference this sprites graphic! Very useful for animations!
	public var initialized:Bool = false; //if this is false it won't use most of functions
	public var projectionEnabled:Bool = true;

	public var angleX:Float = 0;
	public var angleY:Float = 0;
	public var angleZ:Float = 0;

	public var scaleX:Float = 1;
	public var scaleY:Float = 1;
	public var scaleZ:Float = 1;

	public var skewX:Float = 0;
	public var skewY:Float = 0;
	public var skewZ:Float = 0;

	// in %
	public var skewX_offset:Float = 0.5;
	public var skewY_offset:Float = 0.5;
	public var skewZ_offset:Float = 0.5;

	public var moveX:Float = 0;
	public var moveY:Float = 0;
	public var moveZ:Float = 0;

	public var fovOffsetX:Float = 0;
	public var fovOffsetY:Float = 0;
	// public var fovOffsetZ:Float = 0;
	public var pivotOffsetX:Float = 0;
	public var pivotOffsetY:Float = 0;
	public var pivotOffsetZ:Float = 0;

	// public var topleft:Vector3D = new Vector3D(-1, -1, 0);
	// public var topright:Vector3D = new Vector3D(1, -1, 0);
	// public var bottomleft:Vector3D = new Vector3D(-1, 1, 0);
	// public var bottomright:Vector3D = new Vector3D(1, 1, 0);
	// public var middlePoint:Vector3D = new Vector3D(0.5, 0.5, 0);
	public var fov:Float = 90;

	/**
	* A `Vector` of floats where each pair of numbers is treated as a coordinate location (an x, y pair).
	*/
	public var vertices:DrawData<Float> = new DrawData<Float>();

	/**
	* A `Vector` of integers or indexes, where every three indexes define a triangle.
	*/
	public var indices:DrawData<Int> = new DrawData<Int>();

	/**
	* A `Vector` of normalized coordinates used to apply texture mapping.
	*/
	public var uvtData:DrawData<Float> = new DrawData<Float>();

	public var subdivisions:Int = 5;

	static final TRIANGLE_VERTEX_INDICES:Array<Int> = [
		0, 5, 1, 5, 1, 6, 1, 6, 2, 6, 2, 7, 2, 7, 3, 7, 3, 8, 3, 8, 4, 8, 4, 9, 5, 10, 6, 10, 6, 11, 6, 11, 7, 11, 7, 12, 7, 12, 8, 12, 8, 13, 8, 13, 9, 13, 9,
		14, 10, 15, 11, 15, 11, 16, 11, 16, 12, 16, 12, 17, 12, 17, 13, 17, 13, 18, 13, 18, 14, 18, 14, 19, 15, 20, 16, 20, 16, 21, 16, 21, 17, 21, 17, 22, 17,
		22, 18, 22, 18, 23, 18, 23, 19, 23, 19, 24
	];

	// <----
	public var mesh:modcharting.SustainStrip = null; 
	public var z:Float = 0;
	public var extraData:Map<String,Dynamic> = [];

	public var strumTime:Float = 0;
	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var ignoreNote:Bool = false;
	public var hitByOpponent:Bool = false;
	public var noteWasHit:Bool = false;
	public var prevNote:Note;
	public var nextNote:Note;

	public var spawned:Bool = false;
	public var tail:Array<Note> = []; // for sustains
	public var parent:Note;
	public var blockHit:Bool = false; // only works for player

	public static var colArray:Array<String> = ['purple', 'blue', 'green', 'red'];

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var isHoldEnd:Bool = false;
	public var noteType(default, set):String = null;

	public var eventName:String = '';
	public var eventLength:Int = 0;
	public var eventVal1:String = '';
	public var eventVal2:String = '';

	// public var colorSwap:ColorSwap;
	// public var stealth:modcharting.ModchartShaders.StealthEffect;
	// var filtahs:Array<BitmapFilter> = [];

	public var rgbShader:RGBShaderReference;
	public static var globalRgbShaders:Array<RGBPalette> = [];
	public static var globalRgb9Shaders:Array<RGBPalette> = [];
	public static var globalHurtRgbShaders:Array<RGBPalette> = [];
	public static var globalQuantRgbShaders:Array<RGBPalette> = [];
	public var inEditor:Bool = false;

	public var animSuffix:String = '';
	public var gfNote:Bool = false;
	public var earlyHitMult:Float = 0.5;
	public var lateHitMult:Float = 1;
	public var lowPriority:Bool = false;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var offsetAngle:Float = 0;
	public var multAlpha:Float = 1;
	public var multSpeed(default, set):Float = 1;

	public var copyX:Bool = true;
	public var copyY:Bool = true;
	public var copyAngle:Bool = true;
	public var copyAlpha:Bool = true;
	public var alphaMod:Float = 1;
	
	public var hitHealth:Float = 0.023;
	public var missHealth:Float = 0.1;  //0.0475; just in case -Ed
	public var rating:String = 'unknown';
	public var ratingMod:Float = 0; //9 = unknown, 0.25 = shit, 0.5 = bad, 0.75 = good, 1 = sick
	public var ratingDisabled:Bool = false;
	public static var canDamagePlayer:Bool = true; //for edwhak Instakill Notes and others :3 -Ed
	public static var edwhakIsPlayer:Bool = false; //made to make Ed special Mechanics lmao

	//MAKES PUBLIC VAR NOT STATIC VAR IDIOT
	public var sustainRGB:Bool = true; //so if it have only 1 sustain and colored it loads this LOL

	public var texture(default, set):String = null;

	public var noAnimation:Bool = false;
	public var noMissAnimation:Bool = false;
	public var hitCausesMiss:Bool = false;

	//added this so Hitmans game over can load this variables lmao -Ed
	public static var instakill:Bool = false;
	public static var mine:Bool = false;
	public static var ice:Bool = false;
	public static var corrupted:Bool = false;
	public static var hd:Bool = false;
	public static var love:Bool = false;
	public static var fire:Bool = false;
	public var specialHurt:Bool  = false;
	public var hurtNote:Bool  = false;
	public var mimicNote:Bool  = false;
	public static var isRoll:Bool = false;

	public var usedDifferentWidth:Bool = false; //to fix some issues LMAO
	private var pixelInt:Array<Int> = [0, 1, 2, 3];

	public static var tlove:Bool = false;
	//i love how fun its this (help) -Ed
	public var distance:Float = 2000; //plan on doing scroll directions soon -bb

	public var hitsoundDisabled:Bool = false;

	public var quantizedNotes:Bool = false;

	private function set_multSpeed(value:Float):Float {
		resizeByRatio(value / multSpeed);
		multSpeed = value;
		//trace('fuck cock');
		return value;
	}

	public function resizeByRatio(ratio:Float) //haha funny twitter shit
	{
		if(isSustainNote && !isHoldEnd)
		{
			scale.y *= ratio;
			updateHitbox();
		}
	}

	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote('', value);
		}
		return value;
	}

	public function defaultRGB(?moreThan8:Bool) {
		var arr:Array<FlxColor> = moreThan8 ? ClientPrefs.arrowRGB9[noteData] : ClientPrefs.arrowRGB[noteData];

		if (noteData > -1 && noteData <= arr.length)
		{
			rgbShader.r = arr[0];
			rgbShader.g = arr[1];
			rgbShader.b = arr[2];
		}
	}

	public function defaultRGBHurt() {
		var arrHurt:Array<FlxColor> = ClientPrefs.hurtRGB[noteData];

		if (noteData > -1 && noteData <= arrHurt.length)
		{
			rgbShader.r = arrHurt[0];
			rgbShader.g = arrHurt[1];
			rgbShader.b = arrHurt[2];
		}
			
	}

	public function defaultRGBQuant() {
		var arrQuantRGB:Array<FlxColor> = ClientPrefs.arrowRGBQuantize[noteData];

		if (noteData > -1 && noteData <= arrQuantRGB.length)
		{
			rgbShader.r = arrQuantRGB[0];
			rgbShader.g = arrQuantRGB[0];
			rgbShader.b = arrQuantRGB[2];
		}	
	}

	private function set_noteType(value:String):String 
	{
		defaultRGB();

		if(noteData > -1 && noteType != value) {
			switch(value) {
				case 'Hurt Note' | 'HurtAgressive':
					var isAgressive:Bool = value == 'HurtAgressive';
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					defaultRGBHurt();

					if(ClientPrefs.notesSkin[1] != 'MIMIC') {
						reloadNote('', 'Skins/Hurts/'+ClientPrefs.notesSkin[1]+'-HURT_assets');				
					}
					if (!isAgressive){
						copyAlpha=false;
						alpha=0.55; //not fully invisible but yeah
					}
					lowPriority = true;

					if(isSustainNote) {
						if (isAgressive)
							missHealth = 0.2;
						else
							missHealth = 0.1;
					} else {
						if (isAgressive)
							missHealth = 0.5;
						else
							missHealth = 0.3;
					}
					sustainRGB = true;
					hurtNote = true;
					hitCausesMiss = true;
				case 'Invisible Hurt Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					copyAlpha=false;
					alpha=0; //Makes them invisible.

					rgbShader.r = 0xFF101010;
					rgbShader.g = 0xFFFF0000;
					rgbShader.b = 0xFF990022;

					lowPriority = true;
					if(isSustainNote) {
						missHealth = 0.05;
					} else {
						missHealth = 0.15;
					}
					sustainRGB = true;
					hurtNote = true;
					specialHurt = true;
					hitCausesMiss = true;
				case 'Mimic Note':
					ignoreNote = mustPress;
					copyAlpha=false;
					alpha=ClientPrefs.mimicNoteAlpha; //not fully invisible but yeah
					lowPriority = true;

					if(isSustainNote) {
						missHealth = 0.1;
					} else {
						missHealth = 0.3;
					}
					mimicNote = true;
					hitCausesMiss = true;
				case 'Instakill Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					reloadNote('', 'Skins/Notes/INSTAKILLNOTE_assets');
					rgbShader.enabled = false;
					// texture = 'INSTAKILLNOTE_assets';
					lowPriority = true;
					if (canDamagePlayer) {
						if(isSustainNote) {
							hitHealth = -2;
						} else {
							hitHealth = -2;
						}
						instakill = true;
				    } else {
						if(isSustainNote) {
							hitHealth = 0.35;
						} else {
							hitHealth = 0.2;
						}
						instakill = false;
					}
				case 'Mine Note':
					ignoreNote = mustPress;
					reloadNote('', 'Skins/Misc/'+ClientPrefs.mineSkin+'/MINENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'MINENOTE_assets';
					lowPriority = true;
	
					if(isSustainNote) {
						hitHealth = 0;
					} else {
						hitHealth = 0;
					}
					mine = true;
					//not used since in Lua you can load that variables too lmao
					//maybe in a future i'll port it to Haxe lmao -Ed
				case 'HD Note':
					usedDifferentWidth = true;
					reloadNote('', 'Skins/Notes/HDNOTE_assets');
					rgbShader.enabled = false;
					// texture = 'HDNOTE_assets';
					if(isSustainNote) {
						missHealth = 1;
					} else {
						missHealth = 1;
					}
					hd = true;
					hitCausesMiss = false;
				case 'Love Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					reloadNote('', 'Skins/Notes/LOVENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'LOVENOTE_assets';
					if (!edwhakIsPlayer){
						if(isSustainNote) {
							hitHealth = 0.5;
						} else {
							hitHealth = 0.5;
						}
					}
					if (edwhakIsPlayer){
					    love = true;
						if(isSustainNote) {
							hitHealth = 0;
						} else {
							hitHealth = 0;
						}
					}
				case 'Fire Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					reloadNote('', 'Skins/Notes/FIRENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'FIRENOTE_assets';
					if (!edwhakIsPlayer){
						if(isSustainNote) {
							hitHealth = 0.1;
						} else {
							hitHealth = 0.1;
						}
					}
					if (edwhakIsPlayer){
						fire = true;
						if(isSustainNote) {
							hitHealth = -0.35;
						} else {
							hitHealth = -0.7;
						}
						fire = true;
					}
				case 'True Love Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					reloadNote('', 'Skins/Notes/TLOVENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'TLOVENOTE_assets';
					if (!edwhakIsPlayer){
						if(isSustainNote) {
							hitHealth = -0.25;
						} else {
							hitHealth = -0.50;
						}
					}
					if (edwhakIsPlayer){
						tlove = true;
						if(isSustainNote) {
							hitHealth = 0;
						} else {
							hitHealth = 0;
						}
					}
				/*case 'Ice Note':
					ignoreNote = mustPress;
					reloadNote('ICE');
					lowPriority = true;
	
					if(isSustainNote) {
						missHealth = 0.2;
					} else {
						missHealth = 0.5;
					}
					hitCausesMiss = true;
				*/
				case 'Alt Animation':
					animSuffix = '-alt';
				case 'No Animation':
					noAnimation = true;
					noMissAnimation = true;
				case 'GF Sing':
					gfNote = true;
			}
			noteType = value;
		}
		return value;
	}

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?inEditor:Bool = false)
	{
		super();
		// scaleDefault = FlxPoint.get();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;
		this.inEditor = inEditor;

		x += (ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) + 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;
		if(!inEditor) this.strumTime += ClientPrefs.noteOffset;

		this.noteData = noteData;

		// if (ClientPrefs.notesSkin[0] == 'NOTITG'){ //make sure hurts don't get affected by this shit ig?
		// 	sustainRGB = false;
		// }else{
		// 	sustainRGB = true;
		// }

		if(noteData > -1) {
			texture = '';
			if (quantizedNotes) rgbShader = new RGBShaderReference(this, !hurtNote ? initializeGlobalQuantRBShader(noteData) : initializeGlobalHurtRGBShader(noteData));
			else rgbShader = new RGBShaderReference(this, !hurtNote ? initializeGlobalRGBShader(noteData, false) : initializeGlobalHurtRGBShader(noteData));
			// shader = rgbShader.shader;
			// if(!sustainRGB && isSustainNote && !hurtNote){
			// 	rgbShader.enabled = false;
			// }else if(sustainRGB && isSustainNote){
			// 	rgbShader.enabled = true; //no need force ig?
			// }
			if(PlayState.SONG != null && PlayState.SONG.disableNoteRGB) rgbShader.enabled = false;

			x += swagWidth * (noteData);
			if(!isSustainNote && noteData > -1) { //Doing this 'if' check to fix the warnings on Senpai songs
				var animToPlay:String = '';
				animToPlay = colArray[noteData % colArray.length];
				animation.play(animToPlay + 'Scroll');
			}
		}

		// stealth = new modcharting.ModchartShaders.StealthEffect();
		// filters = [new ShaderFilter(stealth.shader)]; //TODO: fix this shit
		
		// trace(prevNote);

		if(prevNote!=null)
			prevNote.nextNote = this;

		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;
			multAlpha = 0.6;
			hitsoundDisabled = true;
			if(ClientPrefs.downScroll) flipY = true;

			offsetX += width / 2;
			copyAngle = false;

			animation.play(colArray[noteData % 4] + 'holdend');
			isHoldEnd = true;

			// if (ClientPrefs.notesSkin[0] == 'NOTITG'){ //LMAO
			// 	flipX = true;
			// }else{
			// 	flipX = false;
			// }

			if (ClientPrefs.notesSkin[0] == 'NOTITG'){ //make sure the game only forces this for notITG sking ig?
				sustainRGB = false;
			}else{
				sustainRGB = true;
			}

			rgbShader.enabled = sustainRGB;

			updateHitbox();

			offsetX -= width / 2;

			if (PlayState.isPixelStage)
				offsetX += 30;

			if (prevNote.isSustainNote)
			{
				prevNote.animation.play(colArray[prevNote.noteData % 4] + 'hold');
				isHoldEnd = false;
				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.05;
				if(PlayState.instance != null)
				{
					prevNote.scale.y *= PlayState.instance.songSpeed;
				}

				if(PlayState.isPixelStage) {
					prevNote.scale.y *= 1.19;
					prevNote.scale.y *= (6 / height); //Auto adjust note size
				}

				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}

			if(PlayState.isPixelStage) {
				scale.y *= PlayState.daPixelZoom;
				updateHitbox();
			}
		} else if(!isSustainNote) {
			earlyHitMult = 1;
		}
		x += offsetX;
	}
	
	function round(num: Float, numDecimalPlaces: Int = 0): Float {
		var mult: Float = Math.pow(10, numDecimalPlaces);
		return Math.floor(num * mult + 0.5) / mult;
	}

	public static function initializeGlobalRGBShader(noteData:Int, ?moreThan8:Bool)
	{
		if (moreThan8)
		{
			if(globalRgb9Shaders[noteData] == null)
			{
				var newRGB:RGBPalette = new RGBPalette();
				globalRgb9Shaders[noteData] = newRGB;

				var arr:Array<FlxColor> = ClientPrefs.arrowRGB9[noteData];
				if (noteData > -1 && noteData <= arr.length)
				{
					newRGB.r = arr[0];
					newRGB.g = arr[1];
					newRGB.b = arr[2];
				}
			}
		}else{
			if(globalRgbShaders[noteData] == null)
			{
				var newRGB:RGBPalette = new RGBPalette();
				globalRgbShaders[noteData] = newRGB;

				var arr:Array<FlxColor> = ClientPrefs.arrowRGB[noteData];
				if (noteData > -1 && noteData <= arr.length)
				{
					newRGB.r = arr[0];
					newRGB.g = arr[1];
					newRGB.b = arr[2];
				}
			}
		}
		return moreThan8 ? globalRgb9Shaders[noteData] : globalRgbShaders[noteData];
	}
	public static function initializeGlobalHurtRGBShader(noteData:Int)
	{
		if(globalHurtRgbShaders[noteData] == null)
		{
			var newRGB:RGBPalette = new RGBPalette();
			globalHurtRgbShaders[noteData] = newRGB;

			var arr:Array<FlxColor> = ClientPrefs.hurtRGB[noteData];
			if (noteData > -1 && noteData <= arr.length)
			{
				newRGB.r = arr[0];
				newRGB.g = arr[1];
				newRGB.b = arr[2];
			}
		}
		return globalHurtRgbShaders[noteData];
	}
	public static function initializeGlobalQuantRBShader(noteData:Int)
	{
		if(globalQuantRgbShaders[noteData] == null)
		{
			var newRGB:RGBPalette = new RGBPalette();
			globalQuantRgbShaders[noteData] = newRGB;

			var arr:Array<FlxColor> = ClientPrefs.arrowRGBQuantize[noteData];

			if (noteData > -1 && noteData <= arr.length)
			{
				newRGB.r = arr[0];
				newRGB.g = arr[1];
				newRGB.b = arr[2];
			}
		}
		return globalQuantRgbShaders[noteData];
	}	

	var lastNoteOffsetXForPixelAutoAdjusting:Float = 0;
	var lastNoteScaleToo:Float = 1;
	public var originalHeightForCalcs:Float = 6;
	public var updateHolds:Bool = false;
	public function reloadNote(?prefix:String = '', ?texture:String = '', ?suffix:String = '') {
		if(prefix == null) prefix = '';
		if(texture == null) texture = '';
		if(suffix == null) suffix = '';

		var skin:String = texture;
		if(texture.length < 1) {
			skin = PlayState.SONG != null ? PlayState.SONG.arrowSkin : null;
			updateHolds = false;
			if(skin == null || skin.length < 1) {
				skin = 'Skins/Notes/'+ClientPrefs.notesSkin[0]+'/NOTE_assets';
				updateHolds = true;
			}
		}

		var animName:String = null;
		if(animation.curAnim != null) {
			animName = animation.curAnim.name;
		}

		var arraySkin:Array<String> = skin.split('/');
		arraySkin[arraySkin.length-1] = prefix + arraySkin[arraySkin.length-1] + suffix;

		var lastScaleY:Float = scale.y;
		var blahblah:String = arraySkin.join('/');

		if(texture.contains('pixel') || PlayState.isPixelStage) {
			if(isSustainNote) {
				loadGraphic(Paths.image('pixelUI/' + blahblah + 'ENDS'));
				width = width / 4;
				height = height / 2;
				originalHeightForCalcs = height;
				loadGraphic(Paths.image('pixelUI/' + blahblah + 'ENDS'), true, Math.floor(width), Math.floor(height));
			} else {
				loadGraphic(Paths.image('pixelUI/' + blahblah));
				width = width / 4;
				height = height / 5;
				loadGraphic(Paths.image('pixelUI/' + blahblah), true, Math.floor(width), Math.floor(height));
			}
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));
			loadPixelNoteAnims();
			antialiasing = false;

			if(isSustainNote) {
				offsetX += lastNoteOffsetXForPixelAutoAdjusting;
				lastNoteOffsetXForPixelAutoAdjusting = (width - 7) * (PlayState.daPixelZoom / 2);
				offsetX -= lastNoteOffsetXForPixelAutoAdjusting;

				/*if(animName != null && !animName.endsWith('end'))
				{
					lastScaleY /= lastNoteScaleToo;
					lastNoteScaleToo = (6 / height);
					lastScaleY *= lastNoteScaleToo;
				}*/
			}
		} else {
			frames = Paths.getSparrowAtlas(blahblah);
			loadNoteAnims();
			antialiasing = ClientPrefs.globalAntialiasing;
		}
		if(isSustainNote) {
			scale.y = lastScaleY;
		}
		updateHitbox();

		if(animName != null)
			animation.play(animName, true);

		if(inEditor) {
			setGraphicSize(ChartingState.GRID_SIZE, ChartingState.GRID_SIZE);
			updateHitbox();
		}
	}
	
	function loadNoteAnims() 
	{
		animation.addByPrefix(colArray[noteData] + 'Scroll', colArray[noteData] + '0');

		if (isSustainNote)
		{
			if(updateHolds){ //doing this check because of custom notes with own holds???
				if (ClientPrefs.notesSkin[2] != 'NONE') //if its none it will just use notesSkin[0] sustain instead?
					frames = Paths.getSparrowAtlas('Skins/Holds/'+ClientPrefs.notesSkin[2]+'/SUSTAIN_assets');
				// else
				// 	frames = Paths.getSparrowAtlas('Skins/Notes/'+ClientPrefs.notesSkin[0]+'/NOTE_assets'); //avoid a crash
			}
			animation.addByPrefix('purpleholdend', 'pruple end hold'); // ?????
			animation.addByPrefix(colArray[noteData] + 'holdend', colArray[noteData] + ' hold end');
			animation.addByPrefix(colArray[noteData] + 'hold', colArray[noteData] + ' hold piece');
		}

		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
	}

	function loadPixelNoteAnims() {
		if(isSustainNote) {
			animation.add(colArray[noteData] + 'holdend', [pixelInt[noteData] + 4]);
			animation.add(colArray[noteData] + 'hold', [pixelInt[noteData]]);
		} else {
			animation.add(colArray[noteData] + 'Scroll', [pixelInt[noteData] + 4]);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// stealth.update(elapsed);

		if (mustPress)
		{
			// ok river
			if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * lateHitMult)
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult))
			{
				if((isSustainNote && prevNote.wasGoodHit) || strumTime <= Conductor.songPosition)
					wasGoodHit = true;
			}
		}

		if (tooLate && !inEditor)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}

	}

	public var drawManual:Bool = false;
	public var hasSetupRender:Bool = false;
  
	public function setUpThreeDRender():Void
	{
	  if (!hasSetupRender)
	  {
		drawManual = true;
		setUp();
		hasSetupRender = true;
	  }
	}

	public function setUp():Void
	{
		this.x = 0;
		this.y = 0;
		this.z = 0;

		this.active = true; // This NEEDS to be true for the note to be drawn!
		updateColorTransform();
		var noteIndices:Array<Int> = [];
		for (x in 0...subdivisions - 1)
		{
			for (y in 0...subdivisions - 1)
			{
				var funny2:Int = x * (subdivisions);
				var funny:Int = y + funny2;
				noteIndices.push(0 + funny);
				noteIndices.push(5 + funny);
				noteIndices.push(1 + funny);

				noteIndices.push(5 + funny);
				noteIndices.push(1 + funny);
				noteIndices.push(6 + funny);
			}
		}

		// trace("\nindices: \n" + noteIndices);

		// indices = new DrawData<Int>(12, true, TRIANGLE_VERTEX_INDICES);
		indices = new DrawData<Int>(noteIndices.length, true, noteIndices);

		// UV coordinates are normalized, so they range from 0 to 1.
		var i:Int = 0;
		for (x in 0...subdivisions) // x
		{
			for (y in 0...subdivisions) // y
			{
				uvtData[i * 2] = (1 / (subdivisions - 1)) * x;
				uvtData[i * 2 + 1] = (1 / (subdivisions - 1)) * y;
				i++;
			}
		}

		// trace("\nuv: \n" + uvtData);
		updateTris();
	}

	public function updateTris(debugTrace:Bool = false):Void
	{
		var w:Float = frameWidth;
		var h:Float = frameHeight;

		var i:Int = 0;
		for (x in 0...subdivisions) // x
		{
			for (y in 0...subdivisions) // y
			{
			var point2D:Vector2;
			var point3D:Vector3D = new Vector3D(0, 0, 0);
			point3D.x = (w / (subdivisions - 1)) * x;
			point3D.y = (h / (subdivisions - 1)) * y;

			if (true)
			{
				// skew funny
				var xPercent:Float = x / (subdivisions - 1);
				var yPercent:Float = y / (subdivisions - 1);
				var xPercent_SkewOffset:Float = xPercent - skewY_offset;
				var yPercent_SkewOffset:Float = yPercent - skewX_offset;
				// Keep math the same as skewedsprite for parity reasons.
				point3D.x += yPercent_SkewOffset * Math.tan(skewX * FlxAngle.TO_RAD) * h;
				point3D.y += xPercent_SkewOffset * Math.tan(skewY * FlxAngle.TO_RAD) * w;
				point3D.z += yPercent_SkewOffset * Math.tan(skewZ * FlxAngle.TO_RAD) * h;

				// scale
				var newWidth:Float = (scaleX - 1) * (xPercent - 0.5);
				point3D.x += (newWidth) * w;
				newWidth = (scaleY - 1) * (yPercent - 0.5);
				point3D.y += (newWidth) * h;

				// _skewMatrix.b = Math.tan(skew.y * FlxAngle.TO_RAD);
				// _skewMatrix.c = Math.tan(skew.x * FlxAngle.TO_RAD);

				point2D = applyPerspective(point3D, xPercent, yPercent);

				point2D.x += (frameWidth - frameWidth) / 2;
          		point2D.y += (frameHeight - frameHeight) / 2;
			}
			else
			{
				// point2D = new Vector2(point3D.x, point3D.y);
				point2D = applyPerspective(point3D);
			}
			vertices[i * 2] = point2D.x;
			vertices[i * 2 + 1] = point2D.y;
			i++;
			}
		}

		if (debugTrace) trace("\nverts: \n" + vertices + "\n");

		// temp fix for now I guess lol?
		flipX = false;
		flipY = false;
	}

	@:access(flixel.FlxCamera)
	override public function draw():Void
	{
		if (drawManual)
		{
			if (alpha <= 0 || vertices == null || indices == null || uvtData == null || _point == null || offset == null)
			{
				return;
			}

			for (camera in cameras)
			{
				if (!camera.visible || !camera.exists) continue;
				//if (!isOnScreen(camera)) continue; // TODO: Update this code to make it work properly.

				// memory leak with drawTriangles :c

				getScreenPosition(_point, camera) /*.subtractPoint(offset)*/;
				var newGraphic:FlxGraphic = cast mapData();
				camera.drawTriangles(newGraphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing, colorTransform, shader);
				// camera.drawTriangles(processedGraphic, vertices, indices, uvtData, null, _point, blend, true, antialiasing);
				// trace("we do be drawin... something?\n verts: \n" + vertices);
			}

			// trace("we do be drawin tho");

			#if FLX_DEBUG
			if (FlxG.debugger.drawDebug) drawDebug();
			#end
		}
		else
		{
			super.draw();
		}
	}

	public function applyPerspective(pos:Vector3D, xPercent:Float = 0, yPercent:Float = 0):Vector2
	{
		// return new Vector2(pos.x, pos.y);

		var w:Float = frameWidth;
		var h:Float = frameHeight;

		var pos_modified:Vector3D = new Vector3D(pos.x, pos.y, pos.z);

		// pos_modified.x -= spriteGraphic.offset.x;
		// pos_modified.y -= spriteGraphic.offset.y;

		var whatWasTheZBefore:Float = pos_modified.z;

		var rotateModPivotPoint:Vector2 = new Vector2(w / 2, h / 2);
		rotateModPivotPoint.x += pivotOffsetX;
		rotateModPivotPoint.y += pivotOffsetY;
		var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.y), angleZ);
		pos_modified.x = thing.x;
		pos_modified.y = thing.y;

		var rotateModPivotPoint:Vector2 = new Vector2(w / 2, 0);
		rotateModPivotPoint.x += pivotOffsetX;
		rotateModPivotPoint.y += pivotOffsetZ;
		var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.x, pos_modified.z), angleY);
		pos_modified.x = thing.x;
		pos_modified.z = thing.y;

		var rotateModPivotPoint:Vector2 = new Vector2(0, h / 2);
		rotateModPivotPoint.x += pivotOffsetZ;
		rotateModPivotPoint.y += pivotOffsetY;
		var thing:Vector2 = ModchartUtil.rotateAround(rotateModPivotPoint, new Vector2(pos_modified.z, pos_modified.y), angleX);
		pos_modified.z = thing.x;
		pos_modified.y = thing.y;

		//Calculate the difference of the rotation and use this as input for the applyPerspective function (idk it just works) 
		//Feel free to move this calculation around if you wanna account for other facts like offsetZ (if added) or moveZ, idk what you're doing exactly with this code lol
		// -Hazard24
		var zDifference:Float = pos_modified.z - whatWasTheZBefore;

		// Apply offset here before it gets affected by z projection!
		pos_modified.x -= offset.x;
		pos_modified.y -= offset.y;
		pos_modified.x += offsetX; //Moved offsetX here so it's with the other Offsets -Hazard24
		

		pos_modified.x += moveX;
		pos_modified.y += moveY;
		pos_modified.z += moveZ;

		if (projectionEnabled)
		{
			pos_modified.x += this.x;
			pos_modified.y += this.y;
			//pos_modified.x += (width/2);
			//pos_modified.y += (height/2);
			pos_modified.z += this.z; // ?????

			pos_modified.x += fovOffsetX;
			pos_modified.y += fovOffsetY;
			pos_modified.z *= 0.001;

			// var noteWidth:Float = w * xPercent;
			// var noteHeight:Float = h * yPercent;

			// var noteWidth:Float = w * 0;
			// var noteHeight:Float = h * 0;

			//var thisNotePos = perspectiveMath(new Vector3D(pos_modified.x+(width/2), pos_modified.y+(height/2), zDifference * 0.001), -(width/2), -(height/2));
			pos_modified.z = zDifference * 0.001;
			var thisNotePos:Vector3D = perspectiveMath(pos_modified, 0, 0);
			//No need for any offsets since the offsets are already a part of pos_modified for each Vert. Plus if you look at the +height/2 part, you'll realise it's just cancelling each other out lmfao
			// -Hazard24

			thisNotePos.x -= this.x;
			thisNotePos.y -= this.y;
			thisNotePos.z -= this.z; // ?????

			thisNotePos.x -= fovOffsetX;
			thisNotePos.y -= fovOffsetY;
			return new Vector2(thisNotePos.x, thisNotePos.y);
		}
		else
		{
			return new Vector2(pos_modified.x, pos_modified.y);
		}
	}

	public var zNear:Float = 0.0;
	public var zFar:Float = 100.0;

	// https://github.com/TheZoroForce240/FNF-Modcharting-Tools/blob/main/source/modcharting/ModchartUtil.hx
	public function perspectiveMath(pos:Vector3D, offsetX:Float = 0, offsetY:Float = 0):Vector3D
	{
		try
		{
			var _FOV:Float = this.fov;

			_FOV *= (Math.PI / 180.0);

			var newz:Float = pos.z - 1;
			var zRange:Float = zNear - zFar;
			var tanHalfFOV:Float = 1;
			var dividebyzerofix:Float = FlxMath.fastCos(_FOV * 0.5);
			if (dividebyzerofix != 0)
			{
				tanHalfFOV = FlxMath.fastSin(_FOV * 0.5) / dividebyzerofix;
			}

			if (pos.z > 1) newz = 0;

			var xOffsetToCenter:Float = pos.x - (FlxG.width * 0.5);
			var yOffsetToCenter:Float = pos.y - (FlxG.height * 0.5);

			var zPerspectiveOffset:Float = (newz + (2 * zFar * zNear / zRange));

			// divide by zero check
			if (zPerspectiveOffset == 0) zPerspectiveOffset = 0.001;

			xOffsetToCenter += (offsetX * -zPerspectiveOffset);
			yOffsetToCenter += (offsetY * -zPerspectiveOffset);

			xOffsetToCenter += (0 * -zPerspectiveOffset);
			yOffsetToCenter += (0 * -zPerspectiveOffset);

			var xPerspective:Float = xOffsetToCenter * (1 / tanHalfFOV);
			var yPerspective:Float = yOffsetToCenter * tanHalfFOV;
			xPerspective /= -zPerspectiveOffset;
			yPerspective /= -zPerspectiveOffset;

			pos.x = xPerspective + (FlxG.width * 0.5);
			pos.y = yPerspective + (FlxG.height * 0.5);
			pos.z = zPerspectiveOffset;
			return pos;
		}
		catch (e)
		{
			trace("OH GOD OH FUCK IT NEARLY DIED CUZ OF: \n" + e.toString());
			return pos;
		}
	}

	public var typeOffsetX:Float = 0;
	public var typeOffsetY:Float = 0;

	public function updateObjectPosition(obj:Note):Void
	{
		// obj.updateHitbox();

		// var note:Note = cast obj;
		if (isSustainNote)
		{
			obj.centerOrigin();
			obj.centerOffsets();
		}
		// note.offset.x += note.typeOffsetX;
		// note.offset.y += note.typeOffsetY;
	}

	function mapData():FlxGraphic
	{
		if (gpix == null || alpha != oalp || !animation.curAnim.finished || oanim != animation.curAnim.name)
		{
			if (!alphas.exists(noteType))
			{
				alphas.set(noteType, new Map());
				indexes.set(noteType, new Map());
			}
			if (!alphas.get(noteType).exists(animation.curAnim.name))
			{
				alphas.get(noteType).set(animation.curAnim.name, new Map());
				indexes.get(noteType).set(animation.curAnim.name, new Map());
			}
			if (!alphas.get(noteType)
				.get(animation.curAnim.name)
				.exists(animation.curAnim.curFrame))
			{
				alphas.get(noteType)
				.get(animation.curAnim.name)
				.set(animation.curAnim.curFrame, []);
				indexes.get(noteType)
				.get(animation.curAnim.name)
				.set(animation.curAnim.curFrame, []);
			}
			if (!alphas.get(noteType)
				.get(animation.curAnim.name)
				.get(animation.curAnim.curFrame)
				.contains(alpha))
			{
				var pix:FlxGraphic = FlxGraphic.fromFrame(frame, true);
				var nalp:Array<Float> = alphas.get(noteType)
				.get(animation.curAnim.name)
				.get(animation.curAnim.curFrame);
				var nindex:Array<Int> = indexes.get(noteType)
				.get(animation.curAnim.name)
				.get(animation.curAnim.curFrame);
				pix.bitmap.colorTransform(pix.bitmap.rect, colorTransform);
				glist.push(pix);
				nalp.push(alpha);
				nindex.push(glist.length - 1);
				alphas.get(noteType)
				.get(animation.curAnim.name)
				.set(animation.curAnim.curFrame, nalp);
				indexes.get(noteType)
				.get(animation.curAnim.name)
				.set(animation.curAnim.curFrame, nindex);
			}
			var dex = alphas.get(noteType)
				.get(animation.curAnim.name)
				.get(animation.curAnim.curFrame)
				.indexOf(alpha);
			gpix = glist[
				indexes.get(noteType)
				.get(animation.curAnim.name)
				.get(animation.curAnim.curFrame)[dex]];
			oalp = alpha;
			oanim = animation.curAnim.name;
		}
		return gpix;
	}

	@:noCompletion
	override function set_clipRect(rect:FlxRect):FlxRect
	{
		clipRect = rect;

		if (frames != null)
			frame = frames.frames[animation.frameIndex];

		return rect;
	}

	public override function kill():Void
	{
		super.kill();
	}
	
	public override function revive():Void
	{
		super.revive();
	}
	
	override public function destroy():Void
	{
		vertices = null;
		indices = null;
		uvtData = null;
		for (i in glist)
			i.destroy();
		alphas = new Map();
		indexes = new Map();
		glist = [];
		drawManual = false;
		hasSetupRender = false;
		super.destroy();
	}
}
