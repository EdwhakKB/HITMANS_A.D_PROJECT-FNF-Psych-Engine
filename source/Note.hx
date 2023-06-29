package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flash.display.BitmapData;
import editors.ChartingState;

using StringTools;

typedef EventNote = {
	strumTime:Float,
	event:String,
	value1:String,
	value2:String
}

class Note extends FlxSprite
{
	//Extra keys stuff

	//Important stuff
	public static var gfxLetter:Array<String> = 
	[
		'purple', 
		'blue', 
		'green', 
		'red', 
		'white', 
		'yellow', 
		'violet', 
		'darkred', 
		'darkblue', 
		'purpleCircle', 
		'blueCircle', 
		'greenCircle',
		'redCircle', 
		'whiteCircle', 
		'yellowCircle', 
		'violetCircle', 
		'darkredCircle', 
		'darkblueCircle'
	];
	public static var ammo:Array<Int> = EKData.gun;
	public static var minMania:Int = 0;
	public static var maxMania:Int = 17; // key value is this + 1

	public static var scales:Array<Float> = EKData.scales;
	public static var lessX:Array<Int> = EKData.lessX;
	public static var separator:Array<Int> = EKData.noteSep;
	public static var xtra:Array<Float> = EKData.offsetX;
	public static var posRest:Array<Float> = EKData.restPosition;
	public static var gridSizes:Array<Int> = EKData.gridSizes;
	public static var noteSplashOffsets:Map<Int, Array<Int>> = [
		0 => [20, 10],
		9 => [10, 20]
	];
	public static var noteSplashScales:Array<Float> = EKData.splashScales;

	public static var xmlMax:Int = 17; // This specifies the max of the splashes can go

	public static var minManiaUI_integer:Int = minMania + 1;
	public static var maxManiaUI_integer:Int = maxMania + 1;

	public static var defaultMania:Int = 3;

	// pixel notes
	public static var pixelNotesDivisionValue:Int = 18;
	public static var pixelScales:Array<Float> = EKData.pixelScales;

	public static var sizeOfNotes:Array<Float> = [112, 112, 112, 112, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108];

	public static var keysShit:Map<Int, Map<String, Dynamic>> = EKData.keysShit;

	// End of extra keys stuff
	//////////////////////////////////////////////////


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

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var noteType(default, set):String = null;

	public var eventName:String = '';
	public var eventLength:Int = 0;
	public var eventVal1:String = '';
	public var eventVal2:String = '';

	public var colorSwap:ColorSwap;
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

	// Lua shit
	public var noteSplashDisabled:Bool = false;
	public var noteSplashTexture:String = null;
	public var noteSplashHue:Float = 0;
	public var noteSplashSat:Float = 0;
	public var noteSplashBrt:Float = 0;

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

	public static var tlove:Bool = false;
	//i love how fun its this (help) -Ed
	public var distance:Float = 2000; //plan on doing scroll directions soon -bb

	public var hitsoundDisabled:Bool = false;
	public var changeAnim:Bool = true;
	public var changeColSwap:Bool = true;

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

	public var mania:Int = 1;

	var ogW:Float;
	var ogH:Float;

	var defaultWidth:Float = 0;
	var defaultHeight:Float = 0;

	private function set_texture(value:String):String {
		if(texture != value) {
			reloadNote('', value);
		}
		texture = value;
		return value;
	}

	private function set_noteType(value:String):String {
		noteSplashTexture = PlayState.SONG.splashSkin;
		if (noteData > -1 && noteData < ClientPrefs.arrowHSV.length)
		{
			colorSwap.hue = ClientPrefs.arrowHSV[Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])][0] / 360;
			colorSwap.saturation = ClientPrefs.arrowHSV[Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])][1] / 100;
			colorSwap.brightness = ClientPrefs.arrowHSV[Std.int(Note.keysShit.get(mania).get('pixelAnimIndex')[noteData] % Note.ammo[mania])][2] / 100;
		}

		if(noteData > -1 && noteType != value) {
			switch(value) {
				case 'Hurt Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					reloadNote('HURT');
					noteSplashTexture = 'HURTnoteSplashes';
					copyAlpha=false;
					alpha=0.55; //not fully invisible but yeah
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
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
					reloadNote('HURTAG');
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
					lowPriority = true;
	
					if(isSustainNote) {
						missHealth = 0.2;
					} else {
						missHealth = 0.5;
					}
					hitCausesMiss = true;
				case 'Invisible Hurt Note':
					usedDifferentWidth = true;
					ignoreNote = mustPress;
					copyAlpha=false;
					alpha=0; //Makes them invisible.
					reloadNote('HURT');
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
					lowPriority = true;
					if(isSustainNote) {
						missHealth = 0.05;
					} else {
						missHealth = 0.15;
					}
					specialHurt = true;
					hitCausesMiss = true;
				case 'Mimic Note':
					ignoreNote = mustPress;
					copyAlpha=false;
					alpha=0.55; //not fully invisible but yeah
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
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
					// texture = 'INSTAKILLNOTE_assets';
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
				    colorSwap.saturation = 0;
					colorSwap.brightness = 0;
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
					// texture = 'MINENOTE_assets';
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
					lowPriority = true;
	
					if(isSustainNote) {
						hitHealth = 0;
					} else {
						hitHealth = 0;
					}
					mine = true;
					//not used since in Lua you can load that variables too lmao
					//maybe in a future i'll port it to Haxe lmao -Ed
				case 'HD note':
					usedDifferentWidth = true;
					reloadNote('HD');
					// texture = 'HDNOTE_assets';
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
	
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
					// texture = 'LOVENOTE_assets';
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
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
					// texture = 'FIRENOTE_assets';
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
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
					// texture = 'TLOVENOTE_assets';
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
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
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
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
		noteSplashHue = colorSwap.hue;
		noteSplashSat = colorSwap.saturation;
		noteSplashBrt = colorSwap.brightness;
		return value;
	}

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?inEditor:Bool = false)
	{
		super();
		// scaleDefault = FlxPoint.get();

		mania = PlayState.mania;

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
			colorSwap = new ColorSwap();
			shader = colorSwap.shader;

			x += swagWidth * (noteData % Note.ammo[mania]);
			if(!isSustainNote && noteData > -1 && noteData < Note.maxManiaUI_integer) { //Doing this 'if' check to fix the warnings on Senpai songs
				var animToPlay:String = '';
				animToPlay = Note.keysShit.get(mania).get('letters')[noteData];
				animation.play(animToPlay);
			}
		}

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

			animation.play(Note.keysShit.get(mania).get('letters')[noteData] + ' holdend');

			updateHitbox();

			offsetX -= width / 2;

			if (texture.contains('pixel') || PlayState.isPixelStage)
				offsetX += 30 * Note.pixelScales[mania];

			if (prevNote.isSustainNote)
			{
				prevNote.animation.play(Note.keysShit.get(mania).get('letters')[prevNote.noteData] + ' hold');

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.05;
				if(PlayState.instance != null)
				{
					prevNote.scale.y *= PlayState.instance.songSpeed;
				}

				if(texture.contains('pixel') || PlayState.isPixelStage) {
					prevNote.scale.y *= 1.19;
					prevNote.scale.y *= (6 / height); //Auto adjust note size
				}

				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}

			if(texture.contains('pixel') || PlayState.isPixelStage) {
				scale.y *= PlayState.daPixelZoom;
				updateHitbox();
			}
		} else if(!isSustainNote) {
			earlyHitMult = 1;
		}
		x += offsetX;
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
			skin = (PlayState.mania == 3  ? PlayState.SONG.arrowSkin : 'HITMANS_assets');
			if(skin == null || skin.length < 1) {
				if (ClientPrefs.noteSkin != 'NONE' && mania == 3)
					skin = 'Skins/Notes/'+ClientPrefs.noteSkin+'/NOTE_assets';
				else{
					if (ClientPrefs.noteSkin == 'HITMANS'){
						skin = 'HITMANS_assets';
					}else{
						skin = (mania == 3 ? 'shaggyNotes' : 'HITMANS_assets');
					}
				}
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

		defaultWidth = 157;
		defaultHeight = 154;
		if(texture.contains('pixel') || PlayState.isPixelStage) {
			if(isSustainNote) {
				loadGraphic(Paths.image('pixelUI/' + blahblah + 'ENDS'));
				width = width / pixelNotesDivisionValue;
				height = height / 2;
				originalHeightForCalcs = height;
				loadGraphic(Paths.image('pixelUI/' + blahblah + 'ENDS'), true, Math.floor(width), Math.floor(height));
			} else {
				loadGraphic(Paths.image('pixelUI/' + blahblah));
				width = width / pixelNotesDivisionValue;
				height = height / 5;
				loadGraphic(Paths.image('pixelUI/' + blahblah), true, Math.floor(width), Math.floor(height));
			}
			defaultWidth = width;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom * Note.pixelScales[mania]));
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
			frames = Paths.getSparrowAtlas((mania == 3 ? blahblah : 'HITMANS_assets'));
			if (frames == null){
				frames = Paths.getSparrowAtlas((mania == 3 ? 'NOTE_assets' : 'HITMANS_assets'));
			}
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
		for (i in 0...gfxLetter.length)
		{
			animation.addByPrefix(gfxLetter[i], gfxLetter[i] + '0');
			
			if (isSustainNote)
			{
				// animation.addByPrefix(gfxLetter[i] + 'rollend', 'Roll' + gfxLetter[i] + 'End');
				// animation.addByPrefix(gfxLetter[i] + 'roll', 'Roll' + gfxLetter[i]);
				animation.addByPrefix(gfxLetter[i] + ' holdend', gfxLetter[i] + ' hold end');
				animation.addByPrefix(gfxLetter[i] + ' hold', gfxLetter[i] + ' hold piece');
			}
		}
						
		ogW = width;
		ogH = height;
		if (!usedDifferentWidth)
		{
			if (!isSustainNote)
				setGraphicSize(Std.int(defaultWidth * scales[mania]));
			else
				setGraphicSize(Std.int(defaultWidth * scales[mania]), Std.int(defaultHeight * scales[0]));
		}else if (usedDifferentWidth){
			setGraphicSize(Std.int(width * scales[mania]));
		}
		updateHitbox();
	}

	function loadPixelNoteAnims() {
		if(isSustainNote) {
			for (i in 0...gfxLetter.length) {
				animation.add(gfxLetter[i] + 'hold', [i]);
				animation.add(gfxLetter[i] + 'holdend', [i + pixelNotesDivisionValue]);
			}
		} else {
			for (i in 0...gfxLetter.length) {
				animation.add(gfxLetter[i], [i + pixelNotesDivisionValue]);
			}
		}
	}

	/*public function applyManiaChange()
	{
		if (isSustainNote) 
			scale.y = 1;
		reloadNote(texture);
		if (isSustainNote)
			offsetX = width / 2;
		if (!isSustainNote)
		{
			var animToPlay:String = '';
			animToPlay = Note.keysShit.get(mania).get('letters')[noteData % Note.ammo[mania]];
			animation.play(animToPlay);
		}

		/*if (isSustainNote && prevNote != null) someone please tell me why this wont work
		{
			animation.play(Note.keysShit.get(mania).get('letters')[noteData % Note.ammo[mania]] + ' tail');
			if (prevNote != null && prevNote.isSustainNote)
			{
				prevNote.animation.play(Note.keysShit.get(mania).get('letters')[prevNote.noteData % Note.ammo[mania]] + ' hold');
				prevNote.updateHitbox();
			}
		}

		updateHitbox();
	}*/

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		mania = PlayState.mania;

		/* im so stupid for that
		if (noteData == 9)
		{
			if (animation.curAnim != null)
				trace(animation.curAnim.name);
			else trace("te anim is null waaaaaa");

			trace(Note.keysShit.get(mania).get('letters')[noteData]);
		}
		*/

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
