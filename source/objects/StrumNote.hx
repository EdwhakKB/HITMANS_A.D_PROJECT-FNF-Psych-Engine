package objects;

import modcharting.ModchartUtil;

class StrumNote extends modcharting.NewModchartArrow
{
	public var arrowPath:modcharting.graphics.SustainTrail = null;
	public var rgbShader:RGBShaderReference;
	public var resetAnim:Float = 0;
	public var noteData:Int = 0;
	public var direction:Float = 90;
	public var downScroll:Bool = false;
	public var sustainReduce:Bool = true;
	public var ai:Bool = false;

	public var splash:NoteSplash = null;
	public var holdSplash:SustainSplash = null;
	public var released:Bool = false;

	private var player:Int;

	public var notITGStrums:Bool = false;

	public var texture(default, set):String = null;

	private function set_texture(value:String):String
	{
		if (texture != value)
		{
			texture = value;
			reloadNote();
		}
		return value;
	}

	public var useRGBShader:Bool = true;

	var rgb9:Bool = false;

	public var myLibrary:String = null;
	public var loadShader:Bool = true;
	public var time:Float = 0;

	public function new(x:Float, y:Float, leData:Int, player:Int, ?daTexture:String, ?library:String = null, ?quantizedNotes:Bool = false,
			?loadShader:Bool = true)
	{
		notITGStrums = (PlayState.SONG != null && PlayState.SONG.notITG && ClientPrefs.getGameplaySetting('modchart'));

		if (loadShader)
		{
			rgb9 = (player < 0);
			rgbShader = new RGBShaderReference(this,
				!quantizedNotes ? Note.initializeGlobalRGBShader(leData, rgb9) : Note.initializeGlobalQuantRBShader(leData));
			rgbShader.enabled = false;
			if (PlayState.SONG != null && PlayState.SONG.disableNoteRGB)
				useRGBShader = false;
			var arr:Array<FlxColor> = !quantizedNotes ? (rgb9 ? ClientPrefs.data.arrowRGB9[leData] : ClientPrefs.data.arrowRGB[leData]) : ClientPrefs.data.arrowRGBQuantize[leData];
			if (!quantizedNotes && !rgb9 && PlayState.isPixelStage)
				ClientPrefs.data.arrowRGBPixel[leData];

			if (leData <= arr.length)
			{
				@:bypassAccessor
				{
					rgbShader.r = arr[0];
					rgbShader.g = arr[1];
					rgbShader.b = arr[2];
				}
			}
		}
		if (PlayState.SONG != null && PlayState.SONG.disableNoteRGB)
			useRGBShader = false;

		noteData = leData;
		this.player = player;
		this.noteData = leData;
		this.released = ai;
		this.ID = noteData;
		this.loadShader = loadShader;
		super(x, y);

		myLibrary = library;
		var skin = 'Skins/Notes/' + ClientPrefs.data.notesSkin[0] + '/NOTE_assets';
		daTexture = daTexture != null ? daTexture : skin;
		if (!Paths.fileExists('images/$skin.png', IMAGE))
		{
			if (PlayState.SONG != null && PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1)
				skin = PlayState.SONG.arrowSkin;
			else
				skin = Note.defaultNoteSkin;

			var customSkin:String = skin + Note.getNoteSkinPostfix();
			if (Paths.fileExists('images/$customSkin.png', IMAGE))
				skin = customSkin;
		}
		if (daTexture != null)
			texture = daTexture
		else
			texture = skin;

		scrollFactor.set();

		animation.finishCallback = function(name:String){
			if (name != "confirm" && released)
				playAnim('static');
		};

		playAnim('static');
	}

	override public function set_cameras(v:Array<FlxCamera>):Array<FlxCamera>
	{
		if (splash != null)
			splash.cameras = v;
		if (holdSplash != null)
			holdSplash.cameras = v;
		return super.set_cameras(v);
	}

	public function playSplash(note:Note) {
		if (ClientPrefs.data.splashAlpha <= 0) return;
		// if (splash == null)
		// 	splash = new NoteSplash(x, y);
		return;
		if (!splash.alive)
			splash.revive();
		splash.cameras = this.cameras;
		if (splash.babyArrow == null)
			splash.babyArrow = this;
		splash.spawnSplashNote(this.x, this.y, noteData, note);
	}

	public function playHoldSplash(note:Note, playbackRate:Float) {
		if (ClientPrefs.data.holdSplashAlpha <= 0 || note.tail.length <= 1) return;
		final end:Note = note.isSustainNote ? note.parent.tail[note.parent.tail.length - 1] : note.tail[note.tail.length - 1];
		// if (holdSplash == null)
		// 	holdSplash = new SustainSplash();
		return;
		if (!holdSplash.alive)
			holdSplash.revive();
		if (holdSplash.strumNote == null)
			holdSplash.strumNote = this;
		holdSplash.cameras = this.cameras;
		holdSplash.setupSusSplash(note, playbackRate);
		end.noteHoldSplash = holdSplash;
	}

	public function applyGeneralData(sprite:NewModchartArrow, data:modcharting.NotePositionData) {
		if (sprite == null || data == null) return;
		sprite.z = data.z;
		sprite.skew.set(data.skewX, data.skewY);
		sprite.angleY = data.angleY;
		sprite.angleX = data.angleX;
		sprite.scale.set(data.scaleX, data.scaleY);
		sprite.alpha = data.alpha;
		sprite.angle = sprite.angle;
	}

	public function reloadNote()
	{
		var lastAnim:String = null;
		if (animation.curAnim != null)
			lastAnim = animation.curAnim.name;

		var notesAnim:Array<String> = rgb9 ? ["UP", "UP", "UP", "UP", "UP", "UP", "UP", "UP", "UP"] : ['LEFT', 'DOWN', 'UP', 'RIGHT'];
		var pressAnim:Array<String> = rgb9 ? ["up", "up", "up", "up", "up", "up", "up", "up", "up"] : ['left', 'down', 'up', 'right'];
		var colorAnims:Array<String> = rgb9 ? ["green", "green", "green", "green", "green", "green", "green", "green", "green"] : ['purple', 'blue', 'green', 'red'];

		var daNoteData:Int = Std.int(Math.abs(noteData) % 4);

		if (PlayState.isPixelStage)
		{
			var testingGraphic = Paths.image('pixelUI/' + texture, null, !notITGStrums);
			if (testingGraphic == null)
			{
				texture = "noteSkins/NOTE_assets" + Note.getNoteSkinPostfix();
				testingGraphic = Paths.image('pixelUI/' + texture, null, !notITGStrums);
				if (testingGraphic == null)
					texture = "NOTE_assets";
			}
			loadGraphic(Paths.image('pixelUI/' + texture, null, !notITGStrums));
			width = width / 4;
			height = height / 5;
			loadGraphic(Paths.image('pixelUI/' + texture, null, !notITGStrums), true, Math.floor(width), Math.floor(height));

			antialiasing = false;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));

			animation.add('green', [6]);
			animation.add('red', [7]);
			animation.add('blue', [5]);
			animation.add('purple', [4]);

			animation.add('static', [0 + daNoteData]);
			animation.add('pressed', [4 + daNoteData, 8 + daNoteData], 12, false);
			animation.add('confirm', [12 + daNoteData, 16 + daNoteData], 24, false);
		}
		else
		{
			frames = Paths.getSparrowAtlas(texture, null, !notITGStrums);
			animation.addByPrefix('green', 'arrowUP');
			animation.addByPrefix('blue', 'arrowDOWN');
			animation.addByPrefix('purple', 'arrowLEFT');
			animation.addByPrefix('red', 'arrowRIGHT');

			antialiasing = ClientPrefs.data.antialiasing;
			setGraphicSize(Std.int(width * 0.7));

			animation.addByPrefix(colorAnims[daNoteData], 'arrow' + notesAnim[daNoteData]);

			animation.addByPrefix('static', 'arrow' + notesAnim[daNoteData]);
			animation.addByPrefix('pressed', pressAnim[daNoteData] + ' press', 24, false);
			animation.addByPrefix('confirm', pressAnim[daNoteData] + ' confirm', 24, false);
		}
		updateHitbox();

		if (lastAnim != null)
		{
			playAnim(lastAnim, true);
		}
		startingScale.set(scale.x, scale.y);
	}

	public function playerPosition()
	{
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
	}

	override function update(elapsed:Float)
	{
		// if (resetAnim > 0)
		// {
		// 	resetAnim -= elapsed;
		// 	if (resetAnim <= 0)
		// 	{
		// 		playAnim('static');
		// 		resetAnim = 0;
		// 	}
		// }
		super.update(elapsed);

		if (ai && animation.curAnim != null && animation.curAnim.name != "static" && animation.curAnim.finished && released) {
			playAnim('static');
			released = false;
		}
	}

	@:allow(flixel.FlxCamera)
	override function draw():Void
	{
		// if (notePositionData?.arrowPathAlpha != 0)
		// 	arrowPath?.draw();
		super.draw();
	}

	public function playAnim(anim:String, ?force:Bool = false)
	{
		animation.play(anim, force);
		if (animation.curAnim != null)
		{
			centerOffsets();
			centerOrigin();
		}
		if (loadShader && useRGBShader)
			rgbShader.enabled = (animation.curAnim != null && animation.curAnim.name != 'static');
	}

	override public function destroy():Void
	{
		super.destroy();
		// if (arrowMesh != null)
		// {
		// 	arrowMesh.destroy();
		// }
	}
}
