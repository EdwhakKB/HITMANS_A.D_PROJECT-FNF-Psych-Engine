package;


import modcharting.ModchartArrow;
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

import flixel.addons.effects.FlxSkewedSprite;

import modcharting.FlxFilteredSkewedSprite as FlxImprovedSprite;
import modcharting.ModchartUtil;

import RGBPalette;
import RGBPalette.RGBShaderReference;
import SustainTrail;

using StringTools;

typedef EventNote = {
	strumTime:Float,
	event:String,
	value1:String,
	value2:String
}

class Note extends FlxSkewedSprite
{
	//This is needed for the hardcoded note types to appear on the Chart Editor,
	//It's also used for backwards compatibility with 0.1 - 0.3.2 charts.
	public static final defaultNoteTypes:Array<String> = [
		'', //Always leave this one empty pls
		'Alt Animation',
		'Hey!',
		'Hurt Note',
		'HurtAgressive',
		'Mimic Note',
		'Invisible Hurt Note',
		'Instakill Note',
		'Mine Note',
		'HD Note',
		'Love Note',
		'Fire Note',
		'GF Sing',
		'No Animation'
	];

	public var mesh:modcharting.SustainStrip = null; 
	public var arrowMesh:modcharting.NewModchartArrow;
	public var z:Float = 0;
	public var extraData:Map<String,Dynamic> = [];

	public var arrowPath:SustainTrail;
	public var altArrowPath:modcharting.ArrowPathBitmap = null;
	public var arrowPathSprite:FlxSprite;

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

	// Call this to create a mesh
	public function setupMesh():Void
	{
		if (arrowMesh == null)
		{
			arrowMesh = new modcharting.NewModchartArrow();
			arrowMesh.spriteGraphic = this;
			arrowMesh.doDraw = false;
			arrowMesh.copySpriteGraphic = false;
		}
		arrowMesh.setUp();
	}

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

	public static var SUSTAIN_SIZE:Int = 44;

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
					hitCausesMiss = !edwhakIsPlayer;
					instakill = !edwhakIsPlayer;
					// texture = 'INSTAKILLNOTE_assets';
					lowPriority = true;
					if(isSustainNote) {
						missHealth = !hitCausesMiss ? 0 : 4; //doesn't kill ed
						hitHealth = 0.35; //player doesn't get anything more than death
					} else {
						missHealth = !hitCausesMiss ? 0 : 4; //doesn't kill ed
						hitHealth = 0.2; //player doesn't get anything more than death
					}
				case 'Mine Note':
					ignoreNote = mustPress;
					reloadNote('', 'Skins/Misc/'+ClientPrefs.mineSkin+'/MINENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'MINENOTE_assets';
					lowPriority = true;
					if(isSustainNote) {
						missHealth = 0.16;
					} else {
						missHealth = 0.8;
					}
					mine = true;
					hitCausesMiss = true;
					//not used since in Lua you can load that variables too lmao
					//maybe in a future i'll port it to Haxe lmao -Ed
				case 'HD Note':
					usedDifferentWidth = true;
					reloadNote('', 'Skins/Notes/HDNOTE_assets');
					rgbShader.enabled = false;
					// texture = 'HDNOTE_assets';
					if(isSustainNote) {
						missHealth = 0.2;
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

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?inEditor:Bool = false, ?createdFrom:Dynamic = null)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		if(createdFrom == null) createdFrom = PlayState.instance;

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
			if(PlayState.SONG != null && PlayState.SONG.disableNoteRGB) rgbShader.enabled = false;

			x += swagWidth * (noteData);
			if(!isSustainNote && noteData > -1) { //Doing this 'if' check to fix the warnings on Senpai songs
				var animToPlay:String = '';
				animToPlay = colArray[noteData % colArray.length];
				animation.play(animToPlay + 'Scroll');
			}
		}

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
				if(createdFrom != null && createdFrom.songSpeed != null) prevNote.scale.y *= createdFrom.songSpeed;

				if(PlayState.isPixelStage) {
					prevNote.scale.y *= 1.19;
					prevNote.scale.y *= (6 / height); //Auto adjust note size
				}

				prevNote.updateHitbox();
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

	public function setNoteType(noteType:String)
	{
		this.noteType = noteType;
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

	var _lastNoteOffX:Float = 0;
	static var _lastValidChecked:String; //optimization
	public var originalHeight:Float = 6;
	public var correctionOffset:Float = 0; //dont mess with this

	public function reloadNote(?prefix:String = '', ?texture:String = '', ?suffix:String = '') {
		if(prefix == null) prefix = '';
		if(texture == null) texture = '';
		if(suffix == null) suffix = '';

		var skin:String = texture;
		if(texture.length < 1) {
			skin = PlayState.SONG != null ? PlayState.SONG.arrowSkin : null;
			if(skin == null || skin.length < 1) {
				skin = 'Skins/Notes/'+ClientPrefs.notesSkin[0]+'/NOTE_assets';
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
				var graphic = Paths.image('pixelUI/' + blahblah + 'ENDS');
				originalHeight = graphic.height / 2;
				loadGraphic(graphic, true, Math.floor(graphic.width / 4), Math.floor(graphic.height / 2));
			} else {
				var graphic = Paths.image('pixelUI/' + blahblah);
				loadGraphic(graphic, true, Math.floor(graphic.width / 4), Math.floor(graphic.height / 5));
			}
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));
			loadPixelNoteAnims();
			antialiasing = false;

			if(isSustainNote) {
				offsetX += _lastNoteOffX;
				_lastNoteOffX = (width - 7) * (PlayState.daPixelZoom / 2);
				offsetX -= _lastNoteOffX;
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
		updateHitbox();
		if (arrowMesh != null) arrowMesh.updateCol();
	}
	
	function loadNoteAnims() 
	{
		animation.addByPrefix(colArray[noteData] + 'Scroll', colArray[noteData] + '0');

		if (isSustainNote)
		{
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

		if (arrowMesh != null) arrowMesh.updateCol();
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	public function followStrumNote(myStrum:StrumNote, songSpeed:Float = 1)
	{
		var strumX:Float = myStrum.x;
		var strumY:Float = myStrum.y;
		var strumAngle:Float = myStrum.angle;
		var strumAlpha:Float = myStrum.alpha;
		var strumDirection:Float = myStrum.direction;

		distance = (0.45 * (Conductor.songPosition - strumTime) * songSpeed * multSpeed);
		if (!myStrum.downScroll) distance *= -1;

		var angleDir = strumDirection * Math.PI / 180;
		if (copyAngle)
			angle = strumDirection - 90 + strumAngle + offsetAngle;

		if(copyAlpha)
			alpha = strumAlpha * multAlpha;

		if(copyX)
			x = strumX + offsetX + Math.cos(angleDir) * distance;

		if(copyY)
		{
			y = strumY + offsetY + correctionOffset + Math.sin(angleDir) * distance;
			if(myStrum.downScroll && isSustainNote)
			{
				if(PlayState.isPixelStage)
				{
					y -= PlayState.daPixelZoom * 9.5;
				}
				y -= (frameHeight * scale.y) - (Note.swagWidth / 2);
			}
		}
	}

	public function clipToStrumNote(myStrum:StrumNote)
	{
		var center:Float = myStrum.y + offsetY + Note.swagWidth / 2;
		if((mustPress || !ignoreNote) && (wasGoodHit || (prevNote.wasGoodHit && !canBeHit)))
		{
			var swagRect:FlxRect = clipRect;
			if(swagRect == null) swagRect = new FlxRect(0, 0, frameWidth, frameHeight);

			if (myStrum.downScroll)
			{
				if(y - offset.y * scale.y + height >= center)
				{
					swagRect.width = frameWidth;
					swagRect.height = (center - y) / scale.y;
					swagRect.y = frameHeight - swagRect.height;
				}
			}
			else if (y + offset.y * scale.y <= center)
			{
				swagRect.y = (center - y) / scale.y;
				swagRect.width = width / scale.x;
				swagRect.height = (height / scale.y) - swagRect.y;
			}
			clipRect = swagRect;
		}
	}
}
