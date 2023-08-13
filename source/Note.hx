package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flash.display.BitmapData;
import editors.ChartingState;

import RGBPalette;
import RGBPalette.RGBShaderReference;

using StringTools;

typedef EventNote = {
	strumTime:Float,
	event:String,
	value1:String,
	value2:String
}

class Note extends FlxSprite{

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
	public var noteType(default, set):String = null;

	public var eventName:String = '';
	public var eventLength:Int = 0;
	public var eventVal1:String = '';
	public var eventVal2:String = '';

	public var colorSwap:ColorSwap;

	public var rgbShader:RGBShaderReference;
	public static var globalRgbShaders:Array<RGBPalette> = [];
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
	public static var isRoll:Bool = false;

	public var usedDifferentWidth:Bool = false; //to fix some issues LMAO
	private var pixelInt:Array<Int> = [0, 1, 2, 3];

	public static var tlove:Bool = false;
	//i love how fun its this (help) -Ed
	public var distance:Float = 2000; //plan on doing scroll directions soon -bb

	public var hitsoundDisabled:Bool = false;

	private function set_multSpeed(value:Float):Float {
		resizeByRatio(value / multSpeed);
		multSpeed = value;
		//trace('fuck cock');
		return value;
	}

	public function resizeByRatio(ratio:Float) //haha funny twitter shit
	{
		if(isSustainNote && !animation.curAnim.name.endsWith('end'))
		{
			scale.y *= ratio;
			updateHitbox();
		}
	}

	private function set_texture(value:String):String {
		if(texture != value) {
			reloadNote('', value);
		}
		texture = value;
		return value;
	}

	public function defaultRGB() {
		var arr:Array<FlxColor> = ClientPrefs.arrowRGB[noteData];

		if (noteData > -1 && noteData <= arr.length)
		{
			rgbShader.r = arr[0];
			rgbShader.g = arr[1];
			rgbShader.b = arr[2];
		}
			
	}

	private function set_noteType(value:String):String {
		defaultRGB();

		if(noteData > -1 && noteType != value) {
			switch(value) {
				case 'Hurt Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;

					rgbShader.r = 0xFF101010;
					rgbShader.g = 0xFFFF0000;
					rgbShader.b = 0xFF990022;

					copyAlpha=false;
					alpha=0.55; //not fully invisible but yeah
					lowPriority = true;

					if(isSustainNote) {
						missHealth = 0.1;
					} else {
						missHealth = 0.3;
					}
					hurtNote = true;
					hitCausesMiss = true;
				case 'HurtAgressive':
					usedDifferentWidth = true;
					ignoreNote = mustPress;

					rgbShader.r = 0xFF101010;
					rgbShader.g = 0xFFA80000;
					rgbShader.b = 0xFFFF0000;

					lowPriority = true;
	
					if(isSustainNote) {
						missHealth = 0.2;
					} else {
						missHealth = 0.5;
					}
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
					hurtNote = true;
					specialHurt = true;
					hitCausesMiss = true;
				case 'Mimic Note':
					ignoreNote = mustPress;
					copyAlpha=false;
					alpha=0.55; //not fully invisible but yeah
					lowPriority = true;

					if(isSustainNote) {
						missHealth = 0.1;
					} else {
						missHealth = 0.3;
					}
					hurtNote = true;
					hitCausesMiss = true;
				case 'Instakill Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					reloadNote('INSTAKILL');
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
					isRoll = false;
					reloadNote('MINE');
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
					reloadNote('HD');
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
					reloadNote('LOVE');
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
					reloadNote('FIRE');
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
					reloadNote('TLOVE');
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
				case 'RollNote':
					isRoll = true;
					reloadNote('ROLL');
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

		if(noteData > -1) {
			texture = '';
			rgbShader = new RGBShaderReference(this, initializeGlobalRGBShader(noteData));
			// shader = rgbShader.shader;

			x += swagWidth * (noteData);
			if(!isSustainNote && noteData > -1) { //Doing this 'if' check to fix the warnings on Senpai songs
				var animToPlay:String = '';
				animToPlay = colArray[noteData % 4];
				animation.play(animToPlay + 'Scroll');
			}
		}

		// trace(prevNote);

		// if (ClientPrefs.quantization)
		// {
		// 	var quantcolord:Array<FlxColor> = [0xFFFF0000,0xFF800080,0xFF0000FF,0xFF800080,0xFF00FF00,0xFFFFC0CB,0xFFFFFF00];
		// 	var quantcolord2:Array<FlxColor> = [0xFF7F0000,0xFF400040,0xFF00007F,0xFF400040,0xFF007F00,0xFF7F6080,0xFF7F7F00];

		// 	var beat:Float = (PlayState.SONG.bpm * strumTime / 1000 / 60);
		// 	var beatRow = round(beat * 48,0);
		// 	if(!isSustainNote){
		// 		if(beatRow%(192/4)==0){
		// 			rgbShader.r = quantcolord[0];
		// 			rgbShader.b = quantcolord2[0];
		// 		}
		// 		else if(beatRow%(192/8)==0){
		// 			rgbShader.r = quantcolord[1];
		// 			rgbShader.b = quantcolord2[1];
		// 		}
		// 		else if(beatRow%(192/12)==0){
		// 			rgbShader.r = quantcolord[2];
		// 			rgbShader.b = quantcolord2[2];
		// 		}
		// 		else if(beatRow%(192/16)==0){
		// 			rgbShader.r = quantcolord[3];
		// 			rgbShader.b = quantcolord2[3];
		// 		}
		// 		else if(beatRow%(192/24)==0){
		// 			rgbShader.r = quantcolord[4];
		// 			rgbShader.b = quantcolord2[4];
		// 		}
		// 		else if(beatRow%(192/32)==0){
		// 			rgbShader.r = quantcolord[6];
		// 			rgbShader.b = quantcolord2[6];
		// 		}
		// 	}else{
		// 		rgbShader.r = prevNote.rgbShader.r;
		// 		rgbShader.b = prevNote.rgbShader.b;  
		// 	}
		// }
		// doNoteQuant(strumTime);

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

			updateHitbox();

			offsetX -= width / 2;

			if (PlayState.isPixelStage)
				offsetX += 30;

			if (prevNote.isSustainNote)
			{
				prevNote.animation.play(colArray[prevNote.noteData % 4] + 'hold');

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

	// public function doNoteQuant(targetTime:Float){
	// 	// var strumTimeCorrection:Float = strumTime-timeOffset - ClientPrefs.noteOffset; //stolen from inhuman LMAO
	// 	// var beat:Float = (strumTimeCorrection % Conductor.crochet) / Conductor.crochet; //Quant goes BRRRR bro -Ed
	// 	var quantcolord:Array<FlxColor> = [0xFFFF0000,0xFF800080,0xFF0000FF,0xFF800080,0xFF00FF00,0xFFFFC0CB,0xFFFFFF00];
	// 	var quantcolord2:Array<FlxColor> = [0xFF7F0000,0xFF400040,0xFF00007F,0xFF400040,0xFF007F00,0xFF7F6080,0xFF7F7F00];

	// 	var beat:Float = (PlayState.SONG.bpm * targetTime / 1000 / 60);
	// 	var beatRow = round(beat * 48,0);
	// 	if(!isSustainNote){
	// 		if(beatRow%(192/4)==0){
	// 			rgbShader.r = quantcolord[0];
	// 			rgbShader.b = quantcolord2[0];
	// 		}
	// 		else if(beatRow%(192/8)==0){
	// 			rgbShader.r = quantcolord[1];
	// 			rgbShader.b = quantcolord2[1];
	// 		}
	// 		else if(beatRow%(192/12)==0){
	// 			rgbShader.r = quantcolord[2];
	// 			rgbShader.b = quantcolord2[2];
	// 		}
	// 		else if(beatRow%(192/16)==0){
	// 			rgbShader.r = quantcolord[3];
	// 			rgbShader.b = quantcolord2[3];
	// 		}
	// 		else if(beatRow%(192/24)==0){
	// 			rgbShader.r = quantcolord[4];
	// 			rgbShader.b = quantcolord2[4];
	// 		}
	// 		else if(beatRow%(192/32)==0){
	// 			rgbShader.r = quantcolord[6];
	// 			rgbShader.b = quantcolord2[6];
	// 		}
	// 	}else{
	// 		rgbShader.r = prevNote.rgbShader.r;
	// 		rgbShader.b = prevNote.rgbShader.b;  
	// 	}
	// }

	function round(num: Float, numDecimalPlaces: Int = 0): Float {
		var mult: Float = Math.pow(10, numDecimalPlaces);
		return Math.floor(num * mult + 0.5) / mult;
	}

	public static function initializeGlobalRGBShader(noteData:Int)
		{
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
			return globalRgbShaders[noteData];
		}

	var lastNoteOffsetXForPixelAutoAdjusting:Float = 0;
	var lastNoteScaleToo:Float = 1;
	public var originalHeightForCalcs:Float = 6;
	function reloadNote(?prefix:String = '', ?texture:String = '', ?suffix:String = '') {
		if(prefix == null) prefix = '';
		if(texture == null) texture = '';
		if(suffix == null) suffix = '';

		var skin:String = texture;
		if(texture.length < 1) {
			skin = PlayState.SONG != null ? PlayState.SONG.arrowSkin : null;
			if(skin == null || skin.length < 1) {
				skin = 'Skins/Notes/'+ClientPrefs.noteSkin+'/NOTE_assets';
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
}
