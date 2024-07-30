package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxCamera;
import flixel.FlxObject;

using StringTools;

class NoteColorState extends MusicBeatState
{
	public static var needToUpdate:Bool = false;
	public static var curNoteSelected:Int = 0;
	public static var noteTypeSelected:Int = 0;
	public static var curQuantSelected:Int = 0;
	public static var quantTypeSelected:Int = 0;
	public var onColorMenu:Bool = true;
	public var onPresets:Bool = false;

	private var camGame:FlxCamera;
	private var camNoteColor:FlxCamera;
	private var camQuantColor:FlxCamera;
	private var camHUD:FlxCamera;
	private var camNoteFollow:FlxObject;
	private var camNoteFollowPos:FlxObject;
	private var camQuantFollow:FlxObject;
	private var camQuantFollowPos:FlxObject;

	var curNoteValue:Float = 0;
	var curQuantValue:Float = 0;
	var holdTime:Float = 0;
	var nextAccept:Int = 5;

	private var grpNumbers:FlxTypedGroup<Alphabet>;
	private var grpNotes:FlxTypedGroup<FlxSprite>;
	private var grpHolds:FlxTypedGroup<FlxSprite>;
	private var grpHoldEnds:FlxTypedGroup<FlxSprite>;
	private var shaderNoteArray:Array<ColorSwap> = [];

	private var grpQuantNumbers:FlxTypedGroup<Alphabet>;
	private var grpQuantNotes:FlxTypedGroup<FlxSprite>;
	private var grpQuantHolds:FlxTypedGroup<FlxSprite>;
	private var grpQuantHoldEnds:FlxTypedGroup<FlxSprite>;
	private var shaderQuantArray:Array<ColorSwap> = [];

	private static var presetSelected:Int = 0;
	public var quantPresetDefault = [[0, 0, 0], [-150, 0, 0], [-75, 0, 0], [55, 0, 0], [-25, 0, 0], [35, 0, 0], [-180, 0, 0], [125, 0, 0], [0, -100, 0]];
	public var hsvPreset:Array<String> = [
		'Fallen', 'Funkin', 'Nostalgia', 'Soft', 'Pastel', 'Sunrise', 'Midnight',
		'QT', 'Inhuman', 'Hitman', 'Groovin', 'Mami', 
		'Anby', 'Hazard', 'Luis', 'Natumi', 'Crystarlya', 'Luna', 'Custom'];
	public var curHSVPreset = [[-85, -20, 0], [-125, -35, 0], [180, -50, 0], [-125, -75, 0], [-95, 0, 0]];
	public var noteSplash:FlxSprite;
	public var hurtSplash:FlxSprite;
	public var quantSplash:FlxSprite;

	var noteBar:FlxSprite;
	var noteHSVText:FlxText;
	var quantBar:FlxSprite;
	var quantHSVText:FlxText;

	public var titleText:FlxText;
	public var descText:FlxText;
	private var noteDescBox:FlxSprite;
	private var noteDescText:FlxText;
	public var noteTypeStuff:Array<String> = ['Left Note', 'Down Note', 'Up Note', 'Right Note', 'Hurt Note'];
	public var quantTypeStuff:Array<String> = ['4th Note', '8th Note', '12th Note', '16th Note', '24th Note', '32th Note', '48th Note', '64th Note', 'Unknown Note'];

	public var noteSplashSkin:String = null;
	public var notePack:String = null;
	public var noteSplashAlpha:Float = 0.6;
	public var hurtNoteAlpha:Float = 0.6;
	public var sustainNoteAlpha:Float = 0.6;

	override public function create()
	{
		#if desktop
		DiscordClient.changePresence('Options','Note Colors', null);
		#end

		presetSelected = 0;

		camGame = new FlxCamera();
		camNoteColor = new FlxCamera();
		camNoteColor.bgColor.alpha = 0;
		camQuantColor = new FlxCamera();
		camQuantColor.bgColor.alpha = 0;
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camNoteColor, false);
		FlxG.cameras.add(camQuantColor, false);
		FlxG.cameras.add(camHUD, true);

		camNoteFollow = new FlxObject(0, 0, 1, 1);
		camNoteFollowPos = new FlxObject(0, 0, 1, 1);
		add(camNoteFollow);
		add(camNoteFollowPos);

		camQuantFollow = new FlxObject(0, 0, 1, 1);
		camQuantFollowPos = new FlxObject(0, 0, 1, 1);
		add(camQuantFollow);
		add(camQuantFollowPos);

		super.create();
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('MenuShit/wallPaper'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		bg.cameras = [camGame];
		add(bg);

		var optbg:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width/1.5), FlxG.height, FlxColor.BLACK);
		optbg.alpha = 0.6;
		optbg.screenCenter();
		optbg.cameras = [camGame];
		add(optbg);

		var noteSuffix:String = ClientPrefs.notesSkin[0].toLowerCase();
		var hurtNoteSuffix:String = ClientPrefs.notesSkin[1].toLowerCase();
		var holdSuffix:String = ClientPrefs.notesSkin[2].toLowerCase(); //tho this one its unnused
		if(ClientPrefs.notesSkin[1].toLowerCase() == 'mimic') hurtNoteSuffix = noteSuffix;
		
		// usual color setting

		noteBar = new FlxSprite(0).makeGraphic(900, 140, FlxColor.BLACK);
		noteBar.alpha = 0.4;
		noteBar.cameras = [camNoteColor];
		noteBar.screenCenter();
		add(noteBar);

		grpHolds = new FlxTypedGroup<FlxSprite>();
		add(grpHolds);
		grpHoldEnds = new FlxTypedGroup<FlxSprite>();
		add(grpHoldEnds);
		grpNotes = new FlxTypedGroup<FlxSprite>();
		add(grpNotes);
		grpNumbers = new FlxTypedGroup<Alphabet>();
		add(grpNumbers);

		noteHSVText = new FlxText(0, 0, 0, "Hue      Saturation Brightness", 32);
		noteHSVText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		noteHSVText.borderSize = 2.4;
		noteHSVText.cameras = [camNoteColor];
		noteHSVText.screenCenter();
		noteHSVText.x += 125;
		add(noteHSVText);

		for(i in 0...4) {
			var yPos:Float = (125 * i) + 125;

			var note:FlxSprite = new FlxSprite(230, yPos - 40);
			var hold:FlxSprite = new FlxSprite(note.x+215, note.y+50);
			var holdend:FlxSprite = new FlxSprite(hold.x, hold.y);
			var animations:Array<String> = ['purple0', 'blue0', 'green0', 'red0'];
			if(i < 4) {
				note.frames = Paths.getSparrowAtlas('Skins/Notes/'+ClientPrefs.notesSkin[0]+'/NOTE_assets');
				note.animation.addByPrefix('idle', animations[i]);
				note.animation.play('idle');
				note.antialiasing = ClientPrefs.globalAntialiasing;
				note.cameras = [camNoteColor];

				hold.frames = Paths.getSparrowAtlas('Skins/Holds/'+ClientPrefs.notesSkin[2]+'/SUSTAIN_assets');
				hold.animation.addByPrefix('idle', 'purple hold piece0');
				hold.animation.play('idle');
				hold.antialiasing = ClientPrefs.globalAntialiasing;
				hold.cameras = [camNoteColor];
				hold.angle = 90;
				hold.scale.y = 15;

				holdend.frames = Paths.getSparrowAtlas('Skins/Holds/'+ClientPrefs.notesSkin[2]+'/SUSTAIN_assets');
				holdend.animation.addByPrefix('idle', 'purple hold end0');
				holdend.animation.play('idle');
				holdend.antialiasing = ClientPrefs.globalAntialiasing;
				holdend.cameras = [camNoteColor];
				holdend.angle = -90;
				holdend.x += hold.height + 425;

				hold.alpha = 1;
				holdend.alpha = 1;

				grpHolds.add(hold);
				grpHoldEnds.add(holdend);
				grpNotes.add(note);
			} else if(i == 4) {
				note.frames = Paths.getSparrowAtlas('Skins/Hurts/'+ClientPrefs.notesSkin[1]+'-HURT_assets');
				note.animation.addByPrefix('idle', 'purple0');
				note.animation.play('idle');
				note.antialiasing = ClientPrefs.globalAntialiasing;
				note.cameras = [camNoteColor];

				hold.frames = Paths.getSparrowAtlas('Skins/Hurts/'+ClientPrefs.notesSkin[1]+'-HURT_assets');
				hold.animation.addByPrefix('idle', 'purple hold piece0');
				hold.animation.play('idle');
				hold.antialiasing = ClientPrefs.globalAntialiasing;
				hold.cameras = [camNoteColor];
				hold.angle = 90;
				hold.scale.y = 15;

				holdend.frames = Paths.getSparrowAtlas('Skins/Hurts/'+ClientPrefs.notesSkin[1]+'-HURT_assets');
				holdend.animation.addByPrefix('idle', 'purple hold end0');
				holdend.animation.play('idle');
				holdend.antialiasing = ClientPrefs.globalAntialiasing;
				holdend.cameras = [camNoteColor];
				holdend.angle = -90;
				holdend.x += hold.height + 425;

				note.alpha = ClientPrefs.mimicNoteAlpha;
				hold.alpha = ClientPrefs.mimicNoteAlpha;
				holdend.alpha = ClientPrefs.mimicNoteAlpha;

				grpHolds.add(hold);
				grpHoldEnds.add(holdend);
				grpNotes.add(note);
			}
		}

		// noteSplash = new FlxSprite();
		// noteSplash.frames = Paths.getSparrowAtlas('splashes/splashes-'+noteSplashSkin.toLowerCase());
		// noteSplash.animation.addByPrefix("1", "note splash purple 1", 24, false);
		// noteSplash.animation.addByPrefix("2", "note splash purple 2", 24, false);
		// noteSplash.animation.play('1');
		// noteSplash.antialiasing = ClientPrefs.globalAntialiasing;
		// noteSplash.alpha = 0;
		// noteSplash.cameras = [camNoteColor];
		// add(noteSplash);

		// hurtSplash = new FlxSprite();
		// hurtSplash.frames = Paths.getSparrowAtlas('splashes/hurt/splashes-hurt');
		// hurtSplash.animation.addByPrefix("1", "note splash purple 1", 24, false);
		// hurtSplash.animation.addByPrefix("2", "note splash purple 2", 24, false);
		// hurtSplash.animation.play('1');
		// hurtSplash.antialiasing = ClientPrefs.globalAntialiasing;
		// hurtSplash.alpha = 0;
		// hurtSplash.cameras = [camNoteColor];
		// add(hurtSplash);

		// visuals

		camNoteColor.follow(camNoteFollowPos, null, 1);
		camNoteColor.visible = true;
		camQuantColor.follow(camQuantFollowPos, null, 1);
		camQuantColor.visible = false;

		var titleBG:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 90, FlxColor.BLACK);
		titleText = new FlxText(25, 16, FlxG.width, '< Note Colors >', 48);
		titleText.setFormat(Paths.font("vcr.ttf"), 56, FlxColor.WHITE, CENTER);
		titleText.scrollFactor.set();
		titleText.screenCenter(X);
		titleText.cameras = [camHUD];
		titleBG.cameras = [camHUD];
		add(titleBG);
		add(titleText);

		var descBG:FlxSprite = new FlxSprite(0, FlxG.height - 45).makeGraphic(FlxG.width, 51, FlxColor.BLACK);
		descText = new FlxText(descBG.x, descBG.y + 12, FlxG.width, "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors", 18);
		descText.setFormat(Paths.font("vcr.ttf"), 18, FlxColor.WHITE, CENTER);
		descText.scrollFactor.set();
		descText.cameras = [camHUD];
		descBG.cameras = [camHUD];
		add(descBG);
		add(descText);

		var swapButton:FlxSprite = new FlxSprite(0, 95).loadGraphic(Paths.image('menuStuff/menuSwap'));
		swapButton.frames = Paths.getSparrowAtlas('menuStuff/menuSwap');
		swapButton.animation.addByPrefix('1', 'selected-1', 1, true);	
		swapButton.animation.addByPrefix('2', 'selected-2', 1, true);	
		swapButton.antialiasing = ClientPrefs.globalAntialiasing;
		swapButton.scale.set(0.85, 0.85);
		swapButton.updateHitbox();
		swapButton.screenCenter();
		swapButton.animation.play("1");
		swapButton.x += 545;
		swapButton.y += 235;
		swapButton.cameras = [camHUD];
		add(swapButton);

		noteDescBox = new FlxSprite().makeGraphic(FlxG.width, 1, FlxColor.BLACK);
		noteDescBox.alpha = 0;
		noteDescBox.cameras = [camHUD];
		add(noteDescBox);

		noteDescText = new FlxText(50, 600, 1180, "", 32);
		noteDescText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		noteDescText.scrollFactor.set();
		noteDescText.borderSize = 2.4;
		noteDescText.alpha = 0;
		noteDescText.cameras = [camHUD];
		add(noteDescText);

		setSelections();
	}

	var changingNote:Bool = false;
	var changingQuant:Bool = false;
	override function update(elapsed:Float) {
		Conductor.songPosition = FlxG.sound.music.time;

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camNoteFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxMath.lerp(camNoteFollowPos.y, camNoteFollow.y, lerpVal));
		camQuantFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxMath.lerp(camQuantFollowPos.y, camQuantFollow.y, lerpVal));

		if(FlxG.keys.justPressed.SPACE && noteDescBox.alpha == 0) {
			FlxTween.tween(noteDescBox, {alpha: 0.6}, 0.25, {ease: FlxEase.circOut});
			FlxTween.tween(noteDescText, {alpha: 1}, 0.25, {ease: FlxEase.circOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
		} else if(FlxG.keys.justPressed.SPACE && noteDescBox.alpha == 0.6) {
			FlxTween.tween(noteDescBox, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
			FlxTween.tween(noteDescText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(controls.UI_UP_P) {
			changeSelection(-1);
			reloadSplash();
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(controls.UI_DOWN_P) {
			changeSelection(1);
			reloadSplash();
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(FlxG.mouse.wheel != 0) {
			changeSelection(-1 * FlxG.mouse.wheel);
			reloadSplash();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		}

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			ClientPrefs.saveSettings();

			titleText.text = '< "'+ '' +'" Preset >';
			titleText.screenCenter(X);

			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
			
		if(controls.BACK || ((changingNote || changingQuant) && controls.ACCEPT)) {
			if(onColorMenu) {
				descText.text = "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors";
				if(!changingNote) MusicBeatState.switchState(new options.OptionsState());
				else changeSelection();
				changingNote = false;
			} else {
				descText.text = "SHIFT - Note Colors | SPACE - Show/Hide Description | RESET - Reset Colors";
				if(!changingQuant) MusicBeatState.switchState(new options.OptionsState());
				else changeSelection();
				changingQuant = false;
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}

		if(FlxG.keys.justPressed.CONTROL) {
			persistentUpdate = false;
		}

		if(FlxG.keys.justPressed.SHIFT && !onPresets) {
			onColorMenu = !onColorMenu;
			if(onColorMenu) {
				titleText.text = '< Note Colors >';
				noteDescText.text = noteTypeStuff[curNoteSelected];
				descText.text = "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors";
			} else {
				titleText.text = '< Note Quantization >';
				noteDescText.text = quantTypeStuff[curQuantSelected];
				descText.text = "SHIFT - Note Colors | SPACE - Show/Hide Description | RESET - Reset Colors";
			}
			titleText.screenCenter(X);

			noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
			noteDescBox.y = noteDescText.y - 10;
			noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
			noteDescBox.updateHitbox();

			camNoteColor.visible = onColorMenu;
			camQuantColor.visible = !onColorMenu;

			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(FlxG.keys.justPressed.TAB)
			if(onColorMenu && !changingNote) {
				onPresets = !onPresets;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				if(onPresets) {
					titleText.text = '< "'+ '' +'" Preset >';
					descText.text = "TAB - Note Colors | SPACE - Show/Hide Description";
				} else {
					titleText.text = '< Note Colors >';
					descText.text = "TAB - Presets | SHIFT - Quantization | SPACE - Show/Hide Description | RESET - Reset Colors";
				}
				titleText.screenCenter(X);
			}

		if(needToUpdate) updateNotes();
		if(nextAccept > 0) nextAccept -= 1;
		if(onColorMenu) {
			if(noteSplash != null) {
				switch(noteSplash.animation.curAnim.name) {
					case '1' | '2' : if(noteSplash.animation.curAnim.finished) noteSplash.alpha = 0;
				}
			}
			if(hurtSplash != null) {
				switch(hurtSplash.animation.curAnim.name) {
					case '1' | '2' : if(hurtSplash.animation.curAnim.finished) hurtSplash.alpha = 0;
				}
			}
		} else {
			if(quantSplash != null) {
				switch(quantSplash.animation.curAnim.name) {
					case '1' | '2' : if(quantSplash.animation.curAnim.finished) quantSplash.alpha = 0;
				}
			}
		}

		super.update(elapsed);
	}

	function setSelections() {
		updateValue();

		for(i in 0...grpNumbers.length) {
			var item = grpNumbers.members[i];
			item.alpha = 0.6;
			if((curNoteSelected * 3) + noteTypeSelected == i) {
				item.alpha = 1;
				camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
			}
		}

		for(i in 0...grpNotes.length) {
			var item = grpNotes.members[i];
			if(i == 4) item.alpha = hurtNoteAlpha * (3/5);
			else item.alpha = 0.6;
			item.scale.set(0.5, 0.5);
			if(curNoteSelected == i) {
				if(i == 4) item.alpha = hurtNoteAlpha;
				else item.alpha = 1;
				item.scale.set(0.75, 0.75);
				noteHSVText.y = item.y;
				noteBar.y = item.y;
				camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
			}
		}

		for(i in 0...grpHolds.length) {
			var item = grpHolds.members[i];
			item.alpha = sustainNoteAlpha * (3/5);
			if(i == 4) item.alpha *= hurtNoteAlpha;
			item.scale.set(0.5, 15.43);
			if(curNoteSelected == i) {
				item.alpha = sustainNoteAlpha;
				if(i == 4) item.alpha *= hurtNoteAlpha;
				item.scale.set(0.75, 15.18);
			}
		}

		for(i in 0...grpHoldEnds.length) {
			var item = grpHoldEnds.members[i];
			item.alpha = sustainNoteAlpha * (3/5);
			if(i == 4) item.alpha *= hurtNoteAlpha;
			item.scale.set(0.5, 0.5);
			if(curNoteSelected == i) {
				item.alpha = sustainNoteAlpha;
				if(i == 4) item.alpha *= hurtNoteAlpha;
				item.scale.set(0.75, 0.75);
				item.x = grpHolds.members[i].x + grpHolds.members[i].height + 425;
			}
		}

		for(i in 0...grpQuantNumbers.length) {
			var item = grpQuantNumbers.members[i];
			item.alpha = 0.6;
			if((curQuantSelected * 3) + quantTypeSelected == i) {
				item.alpha = 1;
				camQuantFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
			}
		}

		for(i in 0...grpQuantNotes.length) {
			var item = grpQuantNotes.members[i];
			item.alpha = 0.6;
			item.scale.set(0.5, 0.5);
			if(curQuantSelected == i) {
				item.alpha = 1;
				item.scale.set(0.75, 0.75);
				quantHSVText.y = item.y;
				quantBar.y = item.y;
				camQuantFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
			}
		}

		for(i in 0...grpQuantHolds.length) {
			var item = grpQuantHolds.members[i];
			item.alpha = sustainNoteAlpha * (3/5);
			item.scale.set(0.5, 15.43);
			if(curQuantSelected == i) {
				item.alpha = sustainNoteAlpha;
				item.scale.set(0.75, 15.18);
			}
		}

		for(i in 0...grpQuantHoldEnds.length) {
			var item = grpQuantHoldEnds.members[i];
			item.alpha = sustainNoteAlpha * (3/5);
			item.scale.set(0.5, 0.5);
			if(curQuantSelected == i) {
				item.alpha = sustainNoteAlpha;
				item.scale.set(0.75, 0.75);
				item.x = grpQuantHolds.members[i].x + grpQuantHolds.members[i].height + 425;
			}
		}

		if(onColorMenu) noteDescText.text = noteTypeStuff[curNoteSelected];
		else noteDescText.text = quantTypeStuff[curQuantSelected];

		noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
		noteDescBox.y = noteDescText.y - 10;
		noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
		noteDescBox.updateHitbox();
	}

	function changeSelection(change:Int = 0) {
		if(onColorMenu) {
			curNoteSelected += change;
			updateValue();
	
			for(i in 0...grpNumbers.length) {
				var item = grpNumbers.members[i];
				item.alpha = 0.6;
				if((curNoteSelected * 3) + noteTypeSelected == i) {
					item.alpha = 1;
					camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
				}
			}

			for(i in 0...grpNotes.length) {
				var item = grpNotes.members[i];
				if(i == 4) item.alpha = hurtNoteAlpha * (3/5);
				else item.alpha = 0.6;
				item.scale.set(0.5, 0.5);
				if(curNoteSelected == i) {
					if(i == 4) item.alpha = hurtNoteAlpha;
					else item.alpha = 1;
					item.scale.set(0.75, 0.75);
					noteHSVText.y = item.y;
					noteBar.y = item.y;
					camNoteFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
				}
			}

			for(i in 0...grpHolds.length) {
				var item = grpHolds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				if(i == 4) item.alpha *= hurtNoteAlpha;
				item.scale.set(0.5, 15.43);
				if(curNoteSelected == i) {
					item.alpha = sustainNoteAlpha;
					if(i == 4) item.alpha *= hurtNoteAlpha;
					item.scale.set(0.75, 15.18);
				}
			}

			for(i in 0...grpHoldEnds.length) {
				var item = grpHoldEnds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				if(i == 4) item.alpha *= hurtNoteAlpha;
				item.scale.set(0.5, 0.5);
				if(curNoteSelected == i) {
					item.alpha = sustainNoteAlpha;
					if(i == 4) item.alpha *= hurtNoteAlpha;
					item.scale.set(0.75, 0.75);
					item.x = grpHolds.members[i].x + grpHolds.members[i].height + 425;
				}
			}
		} else {
			curQuantSelected += change;
			updateValue();
	
			for(i in 0...grpQuantNumbers.length) {
				var item = grpQuantNumbers.members[i];
				item.alpha = 0.6;
				if((curQuantSelected * 3) + quantTypeSelected == i) {
					item.alpha = 1;
					camQuantFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
				}
			}

			for(i in 0...grpQuantNotes.length) {
				var item = grpQuantNotes.members[i];
				item.alpha = 0.6;
				item.scale.set(0.5, 0.5);
				if(curQuantSelected == i) {
					item.alpha = 1;
					item.scale.set(0.75, 0.75);
					quantHSVText.y = item.y;
					quantBar.y = item.y;
					camQuantFollow.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), item.getGraphicMidpoint().y - 25);
				}
			}

			for(i in 0...grpQuantHolds.length) {
				var item = grpQuantHolds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				item.scale.set(0.5, 15.43);
				if(curQuantSelected == i) {
					item.alpha = sustainNoteAlpha;
					item.scale.set(0.75, 15.18);
				}
			}

			for(i in 0...grpQuantHoldEnds.length) {
				var item = grpQuantHoldEnds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				item.scale.set(0.5, 0.5);
				if(curQuantSelected == i) {
					item.alpha = sustainNoteAlpha;
					item.scale.set(0.75, 0.75);
					item.x = grpQuantHolds.members[i].x + grpQuantHolds.members[i].height + 425;
				}
			}
		}

		if(onColorMenu) noteDescText.text = noteTypeStuff[curNoteSelected];
		else noteDescText.text = quantTypeStuff[curQuantSelected];

		noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
		noteDescBox.y = noteDescText.y - 10;
		noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
		noteDescBox.updateHitbox();
	}

	function changeType(change:Int = 0) {
		if(onColorMenu) {
			noteTypeSelected += change;
			if(noteTypeSelected < 0) noteTypeSelected = 2;
			if(noteTypeSelected > 2) noteTypeSelected = 0;

			updateValue();
	
			for(i in 0...grpNumbers.length) {
				var item = grpNumbers.members[i];
				item.alpha = 0.6;
				if((curNoteSelected * 3) + noteTypeSelected == i) item.alpha = 1;
			}
		} else {
			quantTypeSelected += change;
			if(quantTypeSelected < 0) quantTypeSelected = 2;
			if(quantTypeSelected > 2) quantTypeSelected = 0;

			updateValue();
	
			for(i in 0...grpQuantNumbers.length) {
				var item = grpQuantNumbers.members[i];
				item.alpha = 0.6;
				if((curQuantSelected * 3) + quantTypeSelected == i) item.alpha = 1;
			}
		}
	}

	function defaultValue(selected:Int, type:Int) {
		if(onColorMenu) {
			
		} 
	}

	function updateValue(change:Float = 0) {
		if(onColorMenu) {
			curNoteValue += change;
			var roundedValue:Int = Math.round(curNoteValue);
			var max:Float = 180;
			switch(noteTypeSelected) {
				case 1 | 2: max = 100;
			}
	
			if(roundedValue < -max) curNoteValue = -max;
			if(roundedValue > max) curNoteValue = max;

			roundedValue = Math.round(curNoteValue);
	
			switch(noteTypeSelected) {
				case 0: shaderNoteArray[curNoteSelected].hue = roundedValue / 360;
				case 1: shaderNoteArray[curNoteSelected].saturation = roundedValue / 100;
				case 2: shaderNoteArray[curNoteSelected].brightness = roundedValue / 100;
			}
	
			var item = grpNumbers.members[(curNoteSelected * 3) + noteTypeSelected];
			item.text = Std.string(roundedValue);
	
			var add = (40 * (item.letters.length - 1)) / 2;
			for(letter in item.letters) {
				letter.offset.x += add;
				if(roundedValue < 0) letter.offset.x += 10;
			}
		} else {
			curQuantValue += change;
			var roundedValue:Int = Math.round(curQuantValue);
			var max:Float = 180;
			switch(quantTypeSelected) {
				case 1 | 2: max = 100;
			}
	
			if(roundedValue < -max) curQuantValue = -max;
			if(roundedValue > max) curQuantValue = max;

			roundedValue = Math.round(curQuantValue);
	
			switch(quantTypeSelected) {
				case 0: shaderQuantArray[curQuantSelected].hue = roundedValue / 360;
				case 1: shaderQuantArray[curQuantSelected].saturation = roundedValue / 100;
				case 2: shaderQuantArray[curQuantSelected].brightness = roundedValue / 100;
			}
	
			var item = grpQuantNumbers.members[(curQuantSelected * 3) + quantTypeSelected];
			item.text = Std.string(roundedValue);
	
			var add = (40 * (item.letters.length - 1)) / 2;
			for(letter in item.letters) {
				letter.offset.x += add;
				if(roundedValue < 0) letter.offset.x += 10;
			}
		}
	}

	function resetValue(selected:Int, type:Int) {
		if(onColorMenu) {
			curNoteValue = 0;
			switch(type) {
				case 0: shaderNoteArray[selected].hue = 0;
				case 1: shaderNoteArray[selected].saturation = 0;
				case 2: shaderNoteArray[selected].brightness = 0;
			}
	
			var item = grpNumbers.members[(selected * 3) + type];
			item.text = '0';
	
			var add = (40 * (item.letters.length - 1)) / 2;
			for(letter in item.letters) letter.offset.x += add;
		} else {
			curQuantValue = quantPresetDefault[selected][type];
			switch(type) {
				case 0: shaderQuantArray[selected].hue = quantPresetDefault[selected][type]/360;
				case 1: shaderQuantArray[selected].saturation = quantPresetDefault[selected][type]/100;
				case 2: shaderQuantArray[selected].brightness = quantPresetDefault[selected][type]/100;
			}
	
			var item = grpQuantNumbers.members[(selected * 3) + type];
			item.text = Std.string(quantPresetDefault[selected][type]);
	
			var add = (40 * (item.letters.length - 1)) / 2;
			for(letter in item.letters) letter.offset.x += add;
		}
	}

	function updateNotes() {
		var newNoteSuffix:String = ClientPrefs.notesSkin[0].toLowerCase();
		var newHurtNoteSuffix:String = ClientPrefs.notesSkin[1].toLowerCase();
		var newHoldSuffix:String = ClientPrefs.notesSkin[2].toLowerCase();
		if(ClientPrefs.notesSkin[1] == 'Note') newHurtNoteSuffix = newNoteSuffix;
	
		for(i in 0...grpNotes.length) {
			var note = grpNotes.members[i];
			var hold = grpHolds.members[i];
			var holdend = grpHoldEnds.members[i];
			var animations:Array<String> = ['purple0', 'blue0', 'green0', 'red0'];
			if(i < 4) {
				note.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/notes-'+newNoteSuffix);
				note.animation.addByPrefix('idle', animations[i]);
				note.animation.play('idle');
				note.antialiasing = ClientPrefs.globalAntialiasing;
	
				hold.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/holds/holds-'+newHoldSuffix);
				hold.animation.addByPrefix('idle', 'purple hold piece0');
				hold.animation.play('idle');
				hold.antialiasing = ClientPrefs.globalAntialiasing;
	
				holdend.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/holds/holds-'+newHoldSuffix);
				holdend.animation.addByPrefix('idle', 'purple hold end0');
				holdend.animation.play('idle');
				holdend.antialiasing = ClientPrefs.globalAntialiasing;
			} else if(i == 4) {
				note.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/hurt/hurts-'+newHurtNoteSuffix);
				note.animation.addByPrefix('idle', 'purple0');
				note.animation.play('idle');
				note.antialiasing = ClientPrefs.globalAntialiasing;
				note.angle = 0;
	
				hold.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/holds/hurt/hurtholds-'+newHoldSuffix);
				hold.animation.addByPrefix('idle', 'purple hold piece0');
				hold.animation.play('idle');
				hold.antialiasing = ClientPrefs.globalAntialiasing;
	
				holdend.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/holds/hurt/hurtholds-'+newHoldSuffix);
				holdend.animation.addByPrefix('idle', 'purple hold end0');
				holdend.animation.play('idle');
				holdend.antialiasing = ClientPrefs.globalAntialiasing;
			}

			if(!changingNote) {
				if(curNoteSelected == i) {
					note.alpha = 1;
					hold.alpha = sustainNoteAlpha;
					holdend.alpha = sustainNoteAlpha;
					if(i == 4) {
						note.alpha = hurtNoteAlpha;
						hold.alpha *= hurtNoteAlpha;
						holdend.alpha *= hurtNoteAlpha;
					}
				} else {
					note.alpha = 0.6;
					hold.alpha = sustainNoteAlpha * (3/5);
					holdend.alpha = sustainNoteAlpha * (3/5);
				    if(i == 4) {
						note.alpha = hurtNoteAlpha * (3/5);
						hold.alpha *= hurtNoteAlpha;
						holdend.alpha *= hurtNoteAlpha;
					}
				}
			} else {
				if(curNoteSelected == i) {
					note.alpha = 1;
					hold.alpha = 1;
					holdend.alpha = 1;
				} else {
					note.alpha = 0.2;
					hold.alpha = sustainNoteAlpha/5;
					holdend.alpha = sustainNoteAlpha/5;
				    if(i == 4) {
						note.alpha = hurtNoteAlpha/5;
						hold.alpha *= hurtNoteAlpha;
						holdend.alpha *= hurtNoteAlpha;
					}
				}
			}
		}
	
		for(i in 0...grpQuantNotes.length) {
			var note = grpQuantNotes.members[i];
			var hold = grpQuantHolds.members[i];
			var holdend = grpQuantHoldEnds.members[i];
			var animations:Array<String> = ['purple0', 'blue0', 'green0', 'red0', 'purple0', 'blue0', 'green0', 'red0', 'purple0'];

			note.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/notes-'+newNoteSuffix);
			note.animation.addByPrefix('idle', animations[i]);
			note.animation.play('idle');
			note.antialiasing = ClientPrefs.globalAntialiasing;
	
			hold.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/holds/holds-'+newHoldSuffix);
			hold.animation.addByPrefix('idle', 'purple hold piece0');
			hold.animation.play('idle');
			hold.antialiasing = ClientPrefs.globalAntialiasing;
	
			holdend.frames = Paths.getSparrowAtlas('notes/'+notePack.toLowerCase()+'/holds/holds-'+newHoldSuffix);
			holdend.animation.addByPrefix('idle', 'purple hold end0');
			holdend.animation.play('idle');
			holdend.antialiasing = ClientPrefs.globalAntialiasing;

			if(!changingQuant) {
				if(curQuantSelected == i) {
					note.alpha = 1;
					hold.alpha = sustainNoteAlpha;
					holdend.alpha = sustainNoteAlpha;
				} else {
					note.alpha = 0.6;
					hold.alpha = sustainNoteAlpha * (3/5);
					holdend.alpha = sustainNoteAlpha * (3/5);
				}
			} else {
				if(curQuantSelected == i) {
					note.alpha = 1;
					hold.alpha = 1;
					holdend.alpha = 1;
				} else {
					note.alpha = 0.2;
					hold.alpha = sustainNoteAlpha/5;
					holdend.alpha = sustainNoteAlpha/5;
				}
			}
		}
		
		needToUpdate = false;
	}

	function spawnSplash(forceAnim:Bool = false) {
		var item:FlxSprite;
		if(onColorMenu) {
			item = grpNotes.members[curNoteSelected];
			if(curNoteSelected != 4) {
				noteSplash.setPosition(item.x - Note.swagWidth * 0.8, item.y - Note.swagWidth * 0.85);
				noteSplash.frames = Paths.getSparrowAtlas('splashes/splashes-'+noteSplashSkin.toLowerCase());
				noteSplash.animation.addByPrefix("1", "note splash purple 1", 24, false);
				noteSplash.animation.addByPrefix("2", "note splash purple 2", 24, false);
		
				var animNum:Int = FlxG.random.int(1, 2);
				noteSplash.animation.play(Std.string(animNum), forceAnim);
				noteSplash.alpha = noteSplashAlpha;
			} else {
				hurtSplash.setPosition(item.x - Note.swagWidth * 0.8, item.y - Note.swagWidth * 0.85);
				hurtSplash.frames = Paths.getSparrowAtlas('splashes/hurt/splashes-hurt');
				hurtSplash.animation.addByPrefix("1", "note splash purple 1", 24, false);
				hurtSplash.animation.addByPrefix("2", "note splash purple 2", 24, false);
		
				var animNum:Int = FlxG.random.int(1, 2);
				hurtSplash.animation.play(Std.string(animNum), forceAnim);
				hurtSplash.alpha = noteSplashAlpha;
			}
		} else {
			item = grpQuantNotes.members[curQuantSelected];

			quantSplash.setPosition(item.x - Note.swagWidth * 0.8, item.y - Note.swagWidth * 0.85);
			quantSplash.frames = Paths.getSparrowAtlas('splashes/splashes-'+noteSplashSkin.toLowerCase());
			quantSplash.animation.addByPrefix("1", "note splash purple 1", 24, false);
			quantSplash.animation.addByPrefix("2", "note splash purple 2", 24, false);

			var splashShader:ColorSwap = new ColorSwap();
			quantSplash.shader = splashShader.shader;
			splashShader.hue = shaderQuantArray[curQuantSelected].hue;
			splashShader.saturation = shaderQuantArray[curQuantSelected].saturation;
			splashShader.brightness = shaderQuantArray[curQuantSelected].brightness;
	
			var animNum:Int = FlxG.random.int(1, 2);
			quantSplash.animation.play(Std.string(animNum), forceAnim);
			quantSplash.alpha = noteSplashAlpha;
		}
	}

	function reloadSplash() {
			if(onColorMenu) {
				noteSplash.alpha = 0;
				hurtSplash.alpha = 0;
			} else {
				quantSplash.alpha = 0;
			}
			spawnSplash(true);
	}


	var lastStepHit:Int = -1;
	override function stepHit()
	{
		super.stepHit();

		if(curStep == lastStepHit) return;
		if(curStep % 4 == 2) spawnSplash(false);
		
		lastStepHit = curStep;
	}

	var lastBeatHit:Int = -1;
	override public function beatHit()
	{
		super.beatHit();

		if(lastBeatHit == curBeat) return;
		if(curBeat % 2 == 0) {
			if(onColorMenu) {
				var item = grpNotes.members[4];
				if(ClientPrefs.notesSkin[1] == 'Note') {
					switch(item.angle) {
						case 0: item.angle = -90;
						case -90: item.angle = 90;
						case 90: item.angle = -180;
						case -180: item.angle = 0;
					}
				} else {
					if(item.angle != 0) item.angle = 0;
				}
			}
		}

		lastBeatHit = curBeat;
	}
}