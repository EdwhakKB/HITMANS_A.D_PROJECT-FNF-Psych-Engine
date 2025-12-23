package objects;

import flixel.util.FlxColor;

import editors.ChartingState;

import modcharting.ModchartUtil;


typedef EventNote = {
	strumTime:Float,
	event:String,
	value1:String,
	value2:String
}

typedef NoteSplashData =
{
	disabled:Bool,
	texture:String,
	useGlobalShader:Bool, // breaks r/g/b but makes it copy default colors for your custom note
	useRGBShader:Bool,
	antialiasing:Bool,
	r:FlxColor,
	g:FlxColor,
	b:FlxColor,
	a:Float
}

/**
 * The note object used as a data structure to spawn and manage notes during gameplay.
 * 
 * If you want to make a custom note type, you should search for: "function set_noteType"
**/
class Note extends modcharting.NewModchartArrow
{
	// This is needed for the hardcoded note types to appear on the Chart Editor,
	// It's also used for backwards compatibility with 0.1 - 0.3.2 charts.
	public static final defaultNoteTypes:Array<String> = [
		'', // Always leave this one empty pls
		'Alt Animation',
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

	public static var canDamagePlayer:Bool = true; // for edwhak Instakill Notes and others :3 -Ed
	public static var edwhakIsPlayer:Bool = false; // made to make Ed special Mechanics lmao

	// added this so Hitmans game over can load this variables lmao -Ed
	public var instakill:Bool = false;
	public var mine:Bool = false;
	public var ice:Bool = false;
	public var corrupted:Bool = false;
	public var hd:Bool = false;
	public var love:Bool = false;
	public var fire:Bool = false;
	public var specialHurt:Bool = false;
	public var hurtNote:Bool = false;
	public var mimicNote:Bool = false;
	public var tlove:Bool = false;
	public var rendererIndex:Int = 0;
	public var ogIndex:Int = 0;

	public var quantizedNotes:Bool = false;

	// MAKES PUBLIC VAR NOT STATIC VAR IDIOT
	public var sustainRGB:Bool = true; // so if it have only 1 sustain and colored it loads this LOL

	public var mesh:modcharting.SustainStrip = null;
	public var extraData:Map<String, Dynamic> = new Map<String, Dynamic>();

	public var strumTime:Float = 0;
	public var noteData:Int = 0;

	public var mustPress:Bool = false;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;

	public var wasGoodHit:Bool = false;
	public var missed:Bool = false;

	public var ignoreNote:Bool = false;
	public var hitByOpponent:Bool = false;
	public var noteWasHit:Bool = false;
	public var prevNote:Note;
	public var nextNote:Note;

	public var spawned:Bool = false;
	public var isHoldEnd:Bool = false;

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

	public var rgbShader:RGBShaderReference;

	public static var globalRgbShaders:Array<RGBPalette> = [];
	public static var globalRgb9Shaders:Array<RGBPalette> = [];
	public static var globalHurtRgbShaders:Array<RGBPalette> = [];
	public static var globalQuantRgbShaders:Array<RGBPalette> = [];

	public var inEditor:Bool = false;

	public var animSuffix:String = '';
	public var gfNote:Bool = false;
	public var earlyHitMult:Float = 1;
	public var lateHitMult:Float = 1;
	public var lowPriority:Bool = false;

	public static var SUSTAIN_SIZE:Int = 44;
	public static var swagWidth:Float = 160 * 0.7;
	public static var colArray:Array<String> = ['purple', 'blue', 'green', 'red'];
	public static var defaultNoteSkin(default, never):String = 'noteSkins/NOTE_assets';

	public var noteSplashData:NoteSplashData = {
		disabled: false,
		texture: null,
		antialiasing: !PlayState.isPixelStage,
		useGlobalShader: false,
		useRGBShader: (PlayState.SONG != null) ? !(PlayState.SONG.disableNoteRGB == true) : true,
		r: -1,
		g: -1,
		b: -1,
		a: ClientPrefs.data.splashAlpha
	};
	public var noteHoldSplash:SustainSplash;

	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var offsetAngle:Float = 0;
	public var multAlpha:Float = 1;
	public var multSpeed(default, set):Float = 1;
	
	public var newMesh:modcharting.graphics.SustainTrail = null;

	public var copyX:Bool = true;
	public var copyY:Bool = true;
	public var copyAngle:Bool = true;
	public var copyAlpha:Bool = true;

	public var hitHealth:Float = 0.02;
	public var missHealth:Float = 0.1;
	public var rating:String = 'unknown';
	public var ratingMod:Float = 0; // 9 = unknown, 0.25 = shit, 0.5 = bad, 0.75 = good, 1 = sick
	public var ratingDisabled:Bool = false;

	public var texture(default, set):String = null;

	public var noAnimation:Bool = false;
	public var noMissAnimation:Bool = false;
	public var hitCausesMiss:Bool = false;
	public var distance:Float = 2000; // plan on doing scroll directions soon -bb

	public var hitsoundDisabled:Bool = false;
	public var hitsoundChartEditor:Bool = true;

	/**
	 * Forces the hitsound to be played even if the user's hitsound volume is set to 0
	**/
	public var hitsoundForce:Bool = false;

	public var hitsoundVolume(get, default):Float = 1.0;

	function get_hitsoundVolume():Float
	{
		if (ClientPrefs.data.hitsoundVolume > 0)
			return ClientPrefs.data.hitsoundVolume;
		return hitsoundForce ? hitsoundVolume : 0.0;
	}

	public var hitsound:String = 'hitsound';

	private function set_multSpeed(value:Float):Float
	{
		resizeByRatio(value / multSpeed);
		multSpeed = value;
		// trace('fuck cock');
		return value;
	}

	public function resizeByRatio(ratio:Float) // haha funny twitter shit
	{
		if (isSustainNote && animation.curAnim != null && !animation.curAnim.name.endsWith('end'))
		{
			scale.y *= ratio;
			updateHitbox();
		}
	}

	private function set_texture(value:String):String
	{
		if (texture != value)
			reloadNote(value);

		texture = value;
		return value;
	}

	public function defaultRGB(?moreThan8:Bool)
	{
		var arr:Array<FlxColor> = moreThan8 ? ClientPrefs.data.arrowRGB9[noteData] : ClientPrefs.data.arrowRGB[noteData];
		if (PlayState.isPixelStage && !moreThan8)
			arr = ClientPrefs.data.arrowRGBPixel[noteData];

		if (arr != null && noteData > -1 && noteData <= arr.length)
		{
			rgbShader.r = arr[0];
			rgbShader.g = arr[1];
			rgbShader.b = arr[2];
		}
		else
		{
			rgbShader.r = 0xFFFF0000;
			rgbShader.g = 0xFF00FF00;
			rgbShader.b = 0xFF0000FF;
		}
	}

	public function defaultRGBHurt()
	{
		var arrHurt:Array<FlxColor> = ClientPrefs.data.hurtRGB[noteData];

		if (arrHurt != null && noteData > -1 && noteData <= arrHurt.length)
		{
			rgbShader.r = arrHurt[0];
			rgbShader.g = arrHurt[1];
			rgbShader.b = arrHurt[2];
		}
		else
		{
			rgbShader.r = 0xFF101010;
			rgbShader.g = 0xFFFF0000;
			rgbShader.b = 0xFF990022;
		}
	}

	public function defaultRGBQuant()
	{
		var arrQuantRGB:Array<FlxColor> = ClientPrefs.data.arrowRGBQuantize[noteData];

		if (noteData > -1 && noteData <= arrQuantRGB.length)
		{
			rgbShader.r = arrQuantRGB[0];
			rgbShader.g = arrQuantRGB[0];
			rgbShader.b = arrQuantRGB[2];
		}
		else
		{
			rgbShader.r = 0xFFFF0000;
			rgbShader.g = 0xFF00FF00;
			rgbShader.b = 0xFF0000FF;
		}
	}

	private function set_noteType(value:String):String
	{
		noteSplashData.texture = PlayState.SONG != null ? PlayState.SONG.splashSkin : 'noteSplashes/noteSplashes';
		defaultRGB();

		if (noteData > -1 && noteType != value)
		{
			switch (value)
			{
				case 'Hurt Note' | 'HurtAgressive':
					var isAgressive:Bool = value == 'HurtAgressive';
					defaultRGBHurt();
					ignoreNote = mustPress;
					if (ClientPrefs.data.notesSkin[1] != 'MIMIC')
					{
						reloadNote('Skins/Hurts/' + ClientPrefs.data.notesSkin[1] + '-HURT_assets');
					}
					if (!isAgressive)
					{
						copyAlpha = false;
						alpha = 0.55; // not fully invisible but yeah
					}
					// this used to change the note texture to HURTNOTE_assets.png,
					// but i've changed it to something more optimized with the implementation of RGBPalette:

					// splash data and colors
					noteSplashData.r = 0xFFFF0000;
					noteSplashData.g = 0xFF101010;
					noteSplashData.texture = 'noteSplashes/noteSplashes-electric';

					if (isSustainNote)
					{
						if (isAgressive)
							missHealth = 0.2;
						else
							missHealth = 0.1;
					}
					else
					{
						if (isAgressive)
							missHealth = 0.5;
						else
							missHealth = 0.3;
					}
					sustainRGB = true;
					hurtNote = true;

					// gameplay data
					lowPriority = true;
					hitCausesMiss = true;
					hitsound = 'cancelMenu';
					hitsoundChartEditor = false;
				case 'Invisible Hurt Note':
					ignoreNote = mustPress;
					copyAlpha = false;
					alpha = 0; // Makes them invisible.

					rgbShader.r = 0xFF101010;
					rgbShader.g = 0xFFFF0000;
					rgbShader.b = 0xFF990022;

					lowPriority = true;
					if (isSustainNote)
					{
						missHealth = 0.05;
					}
					else
					{
						missHealth = 0.15;
					}
					sustainRGB = true;
					hurtNote = true;
					specialHurt = true;
					hitCausesMiss = true;
				case 'Mimic Note':
					ignoreNote = mustPress;
					copyAlpha = false;
					alpha = ClientPrefs.data.mimicNoteAlpha; // not fully invisible but yeah
					lowPriority = true;

					if (isSustainNote)
					{
						missHealth = 0.1;
					}
					else
					{
						missHealth = 0.3;
					}
					mimicNote = true;
					hitCausesMiss = true;
				case 'Instakill Note':
					ignoreNote = mustPress;
					reloadNote('Skins/Notes/INSTAKILLNOTE_assets');
					rgbShader.enabled = false;
					hitCausesMiss = !edwhakIsPlayer;
					instakill = !edwhakIsPlayer;
					// texture = 'INSTAKILLNOTE_assets';
					lowPriority = true;
					if (isSustainNote)
					{
						missHealth = !hitCausesMiss ? 0 : 4; // doesn't kill ed
						hitHealth = 0.35; // player doesn't get anything more than death
					}
					else
					{
						missHealth = !hitCausesMiss ? 0 : 4; // doesn't kill ed
						hitHealth = 0.2; // player doesn't get anything more than death
					}
				case 'Mine Note':
					ignoreNote = mustPress;
					reloadNote('Skins/Misc/' + ClientPrefs.data.mineSkin + '/MINENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'MINENOTE_assets';
					lowPriority = true;
					if (isSustainNote)
					{
						missHealth = 0.16;
					}
					else
					{
						missHealth = 0.8;
					}
					mine = true;
					hitCausesMiss = true;
				// not used since in Lua you can load that variables too lmao
				// maybe in a future i'll port it to Haxe lmao -Ed
				case 'HD Note':
					reloadNote('Skins/Notes/HDNOTE_assets');
					rgbShader.enabled = false;
					// texture = 'HDNOTE_assets';
					if (isSustainNote)
					{
						missHealth = 0.2;
					}
					else
					{
						missHealth = 1;
					}
					hd = true;
					hitCausesMiss = false;
				case 'Love Note':
					ignoreNote = mustPress;
					reloadNote('Skins/Notes/LOVENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'LOVENOTE_assets';
					if (!edwhakIsPlayer)
					{
						if (isSustainNote)
						{
							hitHealth = 0.5;
						}
						else
						{
							hitHealth = 0.5;
						}
					}
					if (edwhakIsPlayer)
					{
						love = true;
						if (isSustainNote)
						{
							hitHealth = 0;
						}
						else
						{
							hitHealth = 0;
						}
					}
				case 'Fire Note':
					ignoreNote = mustPress;
					reloadNote('Skins/Notes/FIRENOTE_assets');
					rgbShader.enabled = false;
					// texture = 'FIRENOTE_assets';
					if (!edwhakIsPlayer)
					{
						if (isSustainNote)
						{
							hitHealth = 0.1;
						}
						else
						{
							hitHealth = 0.1;
						}
					}
					if (edwhakIsPlayer)
					{
						fire = true;
						if (isSustainNote)
						{
							hitHealth = -0.35;
						}
						else
						{
							hitHealth = -0.7;
						}
						fire = true;
					}
				case 'Alt Animation':
					animSuffix = '-alt';
				case 'No Animation':
					noAnimation = true;
					noMissAnimation = true;
				case 'GF Sing':
					gfNote = true;
				case 'Custom Note':
					allowCustomMech = true;
					if (customNoteMech != null)
						customNoteMech(this);
			}
			if (value != null && value.length > 1)
				NoteTypesConfig.applyNoteTypeData(this, value);
			if (hitsound != 'hitsound' && hitsoundVolume > 0)
				Paths.sound(hitsound); // precache new sound for being idiot-proof
			noteType = value;
		}
		return value;
	}

	public var allowCustomMech:Bool = false;
	public var customNoteMech:Note->Void = null;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?inEditor:Bool = false, ?createdFrom:Dynamic = null)
	{
		super();

		antialiasing = ClientPrefs.data.antialiasing;
		if (createdFrom == null)
			createdFrom = PlayState.instance;

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;
		this.inEditor = inEditor;
		this.moves = false;

		x += (ClientPrefs.data.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) + 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;
		if (!inEditor)
			this.strumTime += ClientPrefs.data.noteOffset;

		this.noteData = noteData;

		if (noteData > -1)
		{
			if (quantizedNotes)
				rgbShader = new RGBShaderReference(this, !hurtNote ? initializeGlobalQuantRBShader(noteData) : initializeGlobalHurtRGBShader(noteData));
			else
				rgbShader = new RGBShaderReference(this, !hurtNote ? initializeGlobalRGBShader(noteData, false) : initializeGlobalHurtRGBShader(noteData));
			if (PlayState.SONG != null && PlayState.SONG.disableNoteRGB)
				rgbShader.enabled = false;
			texture = '';

			x += swagWidth * (noteData);
			if (!isSustainNote && noteData < colArray.length)
			{ // Doing this 'if' check to fix the warnings on Senpai songs
				var animToPlay:String = '';
				animToPlay = colArray[noteData % colArray.length];
				animation.play(animToPlay + 'Scroll');
			}
		}

		// trace(prevNote);

		if (prevNote != null)
			prevNote.nextNote = this;

		if (isSustainNote && prevNote != null)
		{
			//alpha = 0.6;
			//multAlpha = 0.6;
			hitsoundDisabled = true;
			if (ClientPrefs.data.downScroll)
				flipY = true;

			offsetX += width / 2;
			copyAngle = false;

			isHoldEnd = false;
			animation.play(colArray[noteData % colArray.length] + 'holdend');

			updateHitbox();

			if (ClientPrefs.data.notesSkin[0] == 'NOTITG')
			{ // make sure the game only forces this for notITG sking ig?
				sustainRGB = false;
			}
			else
			{
				sustainRGB = true;
			}

			rgbShader.enabled = sustainRGB;

			updateHitbox();

			offsetX -= width / 2;

			if (PlayState.isPixelStage)
				offsetX += 30;

			updateHitbox();

			if (prevNote.isSustainNote)
			{
				prevNote.isHoldEnd = false;
				prevNote.animation.play(colArray[prevNote.noteData % colArray.length] + 'hold');

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.05;
				if (createdFrom != null && createdFrom.songSpeed != null)
					prevNote.scale.y *= createdFrom.songSpeed;

				if (PlayState.isPixelStage)
				{
					prevNote.scale.y *= 1.19;
					prevNote.scale.y *= (6 / height); // Auto adjust note size
				}
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}

			if (PlayState.isPixelStage)
				scale.y *= PlayState.daPixelZoom;
			updateHitbox();
			earlyHitMult = 0;
		}
		else if (!isSustainNote)
		{
			centerOffsets();
			centerOrigin();
		}
		x += offsetX;
	}

	public static function initializeGlobalRGBShader(noteData:Int, ?moreThan8:Bool)
	{
		if (moreThan8)
		{
			if (globalRgb9Shaders[noteData] == null)
			{
				var newRGB:RGBPalette = new RGBPalette();
				globalRgb9Shaders[noteData] = newRGB;

				var arr:Array<FlxColor> = (!PlayState.isPixelStage) ? ClientPrefs.data.arrowRGB[noteData] : ClientPrefs.data.arrowRGBPixel[noteData];
				if (noteData > -1 && noteData <= arr.length)
				{
					newRGB.r = arr[0];
					newRGB.g = arr[1];
					newRGB.b = arr[2];
				}
			}
		}
		else
		{
			if (globalRgbShaders[noteData] == null)
			{
				var newRGB:RGBPalette = new RGBPalette();
				globalRgbShaders[noteData] = newRGB;

				var arr:Array<FlxColor> = ClientPrefs.data.arrowRGB[noteData];
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
		if (globalHurtRgbShaders[noteData] == null)
		{
			var newRGB:RGBPalette = new RGBPalette();
			globalHurtRgbShaders[noteData] = newRGB;

			var arr:Array<FlxColor> = ClientPrefs.data.hurtRGB[noteData];
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
		if (globalQuantRgbShaders[noteData] == null)
		{
			var newRGB:RGBPalette = new RGBPalette();
			globalQuantRgbShaders[noteData] = newRGB;

			var arr:Array<FlxColor> = ClientPrefs.data.arrowRGBQuantize[noteData];

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

	static var _lastValidChecked:String; // optimization

	public var originalHeight:Float = 6;
	public var correctionOffset:Float = 0; // dont mess with this

	public function reloadNote(texture:String = '', postfix:String = '')
	{
		if (texture == null)
			texture = '';
		if (postfix == null)
			postfix = '';

		var skin:String = texture + postfix;
		if (texture.length < 1)
		{
			skin = PlayState.SONG != null ? PlayState.SONG.arrowSkin : null;
			if (skin == null || skin.length < 1)
				skin = 'Skins/Notes/' + ClientPrefs.data.notesSkin[0] + '/NOTE_assets';
		}
		else
			rgbShader.enabled = false;

		var animName:String = null;
		if (animation.curAnim != null)
		{
			animName = animation.curAnim.name;
		}

		var skinPixel:String = skin;
		var lastScaleY:Float = scale.y;
		var skinPostfix:String = getNoteSkinPostfix();
		var customSkin:String = skin + skinPostfix;
		var path:String = PlayState.isPixelStage ? 'pixelUI/' : '';
		if (customSkin == _lastValidChecked || Paths.fileExists('images/' + path + customSkin + '.png', IMAGE))
		{
			skin = customSkin;
			_lastValidChecked = customSkin;
		}
		else
			skinPostfix = '';

		if (PlayState.isPixelStage)
		{
			var graphicSkinTest = Paths.image('pixelUI/' + skinPixel + 'ENDS' + skinPostfix, null, false);
			if (graphicSkinTest == null)
				skinPixel = "noteSkins/NOTE_assets";

			customSkin = skinPixel + skinPostfix;
			if (customSkin == _lastValidChecked || Paths.fileExists('images/' + path + customSkin + '.png', IMAGE))
			{
				skinPixel = customSkin;
				_lastValidChecked = customSkin;
			}
			else
				skinPostfix = '';

			if (skinPixel.contains(skinPostfix))
				skinPixel = skinPixel.replace(skinPostfix, "");

			trace('Path ${'pixelUI/' + skinPixel + 'ENDS' + skinPostfix}');
			if (isSustainNote)
			{
				var graphic = Paths.image('pixelUI/' + skinPixel + 'ENDS' + skinPostfix, null, false);
				loadGraphic(graphic, true, Math.floor(graphic.width / 4), Math.floor(graphic.height / 2));
				originalHeight = graphic.height / 2;
			}
			else
			{
				var graphic = Paths.image('pixelUI/' + skinPixel + skinPostfix, null, false);
				loadGraphic(graphic, true, Math.floor(graphic.width / 4), Math.floor(graphic.height / 5));
			}
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));
			loadPixelNoteAnims();
			antialiasing = false;

			if (isSustainNote)
			{
				offsetX += _lastNoteOffX;
				_lastNoteOffX = (width - 7) * (PlayState.daPixelZoom / 2);
				offsetX -= _lastNoteOffX;
			}
		}
		else
		{
			frames = Paths.getSparrowAtlas(skin, null, false);
			loadNoteAnims();
			if (!isSustainNote)
			{
				centerOffsets();
				centerOrigin();
			}
		}

		if (isSustainNote)
		{
			scale.y = lastScaleY;
		}
		updateHitbox();

		if (animName != null)
			animation.play(animName, true);

		updateHitbox();
	}

	public static function getNoteSkinPostfix()
	{
		var skin:String = '';
		if (ClientPrefs.data.noteSkin != ClientPrefs.defaultData.noteSkin)
			skin = '-' + ClientPrefs.data.noteSkin.trim().toLowerCase().replace(' ', '_');
		return skin;
	}

	function loadNoteAnims()
	{
		if (colArray[noteData] == null)
			return;

		if (isSustainNote)
		{
			attemptToAddAnimationByPrefix('purpleholdend', 'pruple end hold', 24, true); // this fixes some retarded typo from the original note .FLA
			animation.addByPrefix(colArray[noteData] + 'holdend', colArray[noteData] + ' hold end', 24, true);
			animation.addByPrefix(colArray[noteData] + 'hold', colArray[noteData] + ' hold piece', 24, true);
		}
		else
			animation.addByPrefix(colArray[noteData] + 'Scroll', colArray[noteData] + '0');

		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
	}

	function loadPixelNoteAnims()
	{
		if (colArray[noteData] == null)
			return;

		if (isSustainNote)
		{
			animation.add(colArray[noteData] + 'holdend', [noteData + 4], 24, true);
			animation.add(colArray[noteData] + 'hold', [noteData], 24, true);
		}
		else
			animation.add(colArray[noteData] + 'Scroll', [noteData + 4], 24, true);
	}

	function attemptToAddAnimationByPrefix(name:String, prefix:String, framerate:Float = 24, doLoop:Bool = true)
	{
		var animFrames = [];
		@:privateAccess
		animation.findByPrefix(animFrames, prefix); // adds valid frames to animFrames
		if (animFrames.length < 1)
			return;

		animation.addByPrefix(name, prefix, framerate, doLoop);
	}

	// override function updateColorTransform():Void
	// {
	// 	if (arrowMesh != null) arrowMesh.updateCol();
	// 	super.updateColorTransform();
	// }

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (allowCustomMech && customNoteMech != null)
			customNoteMech(this);

		if (mustPress)
		{
			canBeHit = (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * lateHitMult)
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult));

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (!wasGoodHit && strumTime <= Conductor.songPosition)
			{
				if (!isSustainNote || (prevNote.wasGoodHit && !ignoreNote))
					wasGoodHit = true;
			}
		}

		if (tooLate && !inEditor)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}

	override public function destroy()
	{
		super.destroy();
		_lastValidChecked = '';
		// if (arrowMesh != null)
		// {
		// 	arrowMesh.destroy();
		// }
	}

	public function followStrumNote(myStrum:StrumNote, songSpeed:Float = 1)
	{
		var strumX:Float = myStrum.x;
		var strumY:Float = myStrum.y;
		var strumAngle:Float = myStrum.angle;
		var strumAlpha:Float = myStrum.alpha;
		var strumDirection:Float = myStrum.direction;

		distance = (0.45 * (Conductor.songPosition - strumTime) * songSpeed * multSpeed);
		if (!myStrum.downScroll)
			distance *= -1;

		var angleDir = strumDirection * Math.PI / 180;
		if (copyAngle)
			angle = strumDirection - 90 + strumAngle + offsetAngle;

		if (copyAlpha)
			alpha = strumAlpha * multAlpha;

		if (copyX)
			x = strumX + offsetX + Math.cos(angleDir) * distance;

		if (copyY)
		{
			y = strumY + offsetY + correctionOffset + Math.sin(angleDir) * distance;
			if (myStrum.downScroll && isSustainNote)
			{
				if (PlayState.isPixelStage)
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
		if ((mustPress || !ignoreNote) && (wasGoodHit || (prevNote.wasGoodHit && !canBeHit)))
		{
			var swagRect:FlxRect = clipRect;
			if (swagRect == null)
				swagRect = new FlxRect(0, 0, frameWidth, frameHeight);

			if (myStrum.downScroll)
			{
				if (y - offset.y * scale.y + height >= center)
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

	public function setCustomColor(type:String = 'quant', disableQuant:Bool)
	{
		var beat:Float = 0;
		var dataStuff:Float = 0;
		var col:FlxColor = 0xFFFFD700;
		var col3:FlxColor = 0xFFFFD700;
		var col2:FlxColor = 0xFFFFD700;

		var bpmChanges = engine.Conductor.bpmChangeMap;
		var currentBPM = play.PlayState.SONG.bpm;
		var newStrumTime = strumTime;
		var newTime = newStrumTime;
		for (i in 0...bpmChanges.length)
			if (newStrumTime > bpmChanges[i].songTime)
			{
				currentBPM = bpmChanges[i].bpm;
				newTime = newStrumTime - bpmChanges[i].songTime;
			}
		if (rgbShader.enabled && !hurtNote && !disableQuant)
		{
			dataStuff = ((currentBPM * (newTime - ClientPrefs.data.noteOffset)) / 1000 / 60);
			beat = round(dataStuff * 48, 0);
			if (!isSustainNote)
			{
				if (beat % (192 / 4) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[0][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[0][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[0][2];
				}
				else if (beat % (192 / 8) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[1][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[1][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[1][2];
				}
				else if (beat % (192 / 12) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[2][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[2][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[2][2];
				}
				else if (beat % (192 / 16) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[3][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[3][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[3][2];
				}
				else if (beat % (192 / 24) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[4][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[4][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[4][2];
				}
				else if (beat % (192 / 32) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[5][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[5][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[5][2];
				}
				else if (beat % (192 / 48) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[6][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[6][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[6][2];
				}
				else if (beat % (192 / 64) == 0)
				{
					col = ClientPrefs.data.arrowRGBQuantize[7][0];
					col3 = ClientPrefs.data.arrowRGBQuantize[7][1];
					col2 = ClientPrefs.data.arrowRGBQuantize[7][2];
				}
				else
				{
					col = 0xFF7C7C7C;
					col3 = 0xFFFFFFFF;
					col2 = 0xFF3A3A3A;
				}
				rgbShader.r = col;
				rgbShader.g = col3;
				rgbShader.b = col2;
			}
			else
			{
				rgbShader.r = prevNote.rgbShader.r;
				rgbShader.g = prevNote.rgbShader.g;
				rgbShader.b = prevNote.rgbShader.b;
			}
		}
	}

	private function round(num:Float, numDecimalPlaces:Int)
	{
		var mult = 10 ^ numDecimalPlaces;
		return Math.floor(num * mult + 0.5) / mult;
	}

	@:noCompletion
	override function set_clipRect(rect:FlxRect):FlxRect
	{
		clipRect = rect;

		if (frames != null)
			frame = frames.frames[animation.frameIndex];

		return rect;
	}

	@:allow(flixel.FlxCamera)
	override function draw():Void
	{
		if (mesh == null)
			super.draw();
	}

	public override function kill():Void
	{
		super.kill();
	}

	public override function revive():Void
	{
		super.revive();
	}
}

