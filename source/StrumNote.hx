package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import RGBPalette;
import RGBPalette.RGBShaderReference;
// import flixel.addons.effects.FlxSkewedSprite;
import flixel.util.FlxColor;

import modcharting.FlxFilteredSkewedSprite as FlxImprovedSprite;
using StringTools;

class StrumNote extends FlxImprovedSprite
{
	public var rgbShader:RGBShaderReference;
	public var strumMesh:modcharting.ZProjectSprite_Note;
	private var colorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	public var noteData:Int = 0;
	public var direction:Float = 90;//plan on doing scroll directions soon -bb
	public var downScroll:Bool = false;//plan on doing scroll directions soon -bb
	public var sustainReduce:Bool = true;
	var myLibrary:String = '';
	public var loadShader:Bool = false;
	
	private var player:Int;
	
	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public function setupMesh():Void
	{
		if(strumMesh == null)
		{
			strumMesh = new modcharting.ZProjectSprite_Note();
			strumMesh.spriteGraphic = this;
		}
		strumMesh.setUp();
	}

	public var useRGBShader:Bool = true;
	var rgb9:Bool = false;
	public function new(x:Float, y:Float, leData:Int, player:Int, ?daTexture:String, ?library:String = 'shared', ?quantizedNotes:Bool = false, ?loadShader:Bool = true) {
		if (loadShader)
		{
			rgb9 = (player < 0);
			rgbShader = new RGBShaderReference(this, !quantizedNotes ? Note.initializeGlobalRGBShader(leData, rgb9) : 
				Note.initializeGlobalQuantRBShader(leData));
			rgbShader.enabled = false;
			if(PlayState.SONG != null && PlayState.SONG.disableNoteRGB) useRGBShader = false;
			var arr:Array<FlxColor> = !quantizedNotes ? (rgb9 ? ClientPrefs.arrowRGB9[leData] : ClientPrefs.arrowRGB[leData]) : ClientPrefs.arrowRGBQuantize[leData];

			if(leData <= arr.length)
			{
				@:bypassAccessor
				{
					rgbShader.r = arr[0];
					rgbShader.g = arr[1];
					rgbShader.b = arr[2];
				}
			}
		}

		noteData = leData;
		this.player = player;
		this.noteData = leData;
		this.loadShader = loadShader;
		super(x, y);

		myLibrary = library;
		var skin = 'Skins/Notes/'+ClientPrefs.notesSkin[0]+'/NOTE_assets';
		daTexture = daTexture != null ? daTexture : skin;
		if(PlayState.SONG != null && PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
		if (daTexture != null) texture = daTexture else texture = skin;

		scrollFactor.set();

		//setupMesh();
	}

	public function reloadNote()
	{
		var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

		var notesAnim:Array<String> = rgb9 ? ["UP", "UP", "UP", "UP", "UP", "UP", "UP", "UP", "UP"] : ['LEFT', 'DOWN', 'UP', 'RIGHT'];
        var pressAnim:Array<String> = rgb9 ? ["up", "up", "up", "up", "up", "up", "up", "up", "up"] : ['left', 'down', 'up', 'right'];
        var colorAnims:Array<String> = rgb9 ? ["green", "green", "green", "green", "green", "green", "green", "green", "green"] : ['purple', 'blue', 'green', 'red'];

		var daNoteData:Float = Math.abs(noteData) % 4;
		
        if(PlayState.isPixelStage)
        {
            loadGraphic(Paths.image('pixelUI/' + texture));
            width = width / 4;
            height = height / 5;
            loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));

            animation.add('green', [6]);
            animation.add('red', [7]);
            animation.add('blue', [5]);
            animation.add('purple', [4]);

            antialiasing = false;
            setGraphicSize(Std.int(width * PlayState.daPixelZoom));

            animation.add('static', [0 + Std.int(daNoteData)]);
            animation.add('pressed', [4 + Std.int(daNoteData), 8 + Std.int(daNoteData)], 12, false);
            animation.add('confirm', [12 + Std.int(daNoteData), 16 + Std.int(daNoteData)], 24, false);
        }
        else
        {
            frames = Paths.getSparrowAtlas(texture, myLibrary);
            animation.addByPrefix('green', 'arrowUP');
            animation.addByPrefix('blue', 'arrowDOWN');
            animation.addByPrefix('purple', 'arrowLEFT');
            animation.addByPrefix('red', 'arrowRIGHT');

            antialiasing = ClientPrefs.globalAntialiasing;
            setGraphicSize(Std.int(width * 0.7));

            animation.addByPrefix(colorAnims[Std.int(daNoteData)], 'arrow' + notesAnim[Std.int(daNoteData)]);

            animation.addByPrefix('static', 'arrow' + notesAnim[Std.int(daNoteData)]);
            animation.addByPrefix('pressed', pressAnim[Std.int(daNoteData)] + ' press', 24, false);
            animation.addByPrefix('confirm', pressAnim[Std.int(daNoteData)] + ' confirm', 24, false);
        }
		updateHitbox();

		if(lastAnim != null)
		{
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		if (strumMesh!=null) strumMesh.updateCol();
		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		if(animation.curAnim != null)
			{
				centerOffsets();
				centerOrigin();
			}
		if(loadShader && useRGBShader) rgbShader.enabled = (animation.curAnim != null && animation.curAnim.name != 'static');
	}
}
