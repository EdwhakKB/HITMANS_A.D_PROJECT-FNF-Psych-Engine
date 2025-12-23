package options;
import openfl.text.TextField;
import flixel.addons.display.FlxGridOverlay;

import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import play.Controls;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class NoteColorState extends MusicBeatState
{
	public static var curNoteSelected:Int = 0;
	public static var noteTypeSelected:Int = 0;
	private static var curNum:Int = 0;

	private var grpNumbers:FlxTypedGroup<Alphabet>;
	private var grpNotes:FlxTypedGroup<Note>;
	private var grpHolds:FlxTypedGroup<Note>;
	private var grpHoldEnds:FlxTypedGroup<Note>;
	private var shaderNoteArray:Array<ColorSwap> = [];

	public var onColorMenu:Bool = true;
	var curNoteValue:Float = 0;
	var holdTime:Float = 0;
	var nextAccept:Int = 5;

	public var notePack:String = null;
	public var hurtNoteAlpha:Float = 0.6;
	public var sustainNoteAlpha:Float = 0.6;

	private var camGame:FlxCamera;
	private var camNoteColor:FlxCamera;
	private var camHUD:FlxCamera;
	private var camNoteFollow:FlxObject;
	private var camNoteFollowPos:FlxObject;

	var skins:Array<String> = ['HITMANS', 'INHUMAN', 'FNF', 'ITHIT', 'MANIAHIT', 'FUTURE', 'CIRCLE', 'STEPMANIA', 'NOTITG']; //There must be a better way but for now with this im okay -Ed
	var skinNoteTypes:Array<String> = ['Left Note', 'Down Note', 'Up Note', 'Right Note', 'Hurt Note'];
	var skinIndicator:String = ClientPrefs.data.notesSkin[0];

	var noteBar:FlxSprite;
	var noteHSVText:FlxText;

	var noteDescBox:FlxSprite;
	var noteDescText:FlxText;

	var titleText:FlxText;
	var descText:FlxText;
	var optionsText:FlxText;

	override public function create()
	{
		#if desktop
		DiscordClient.changePresence('Options','Note Colors', null);
		#end

		for(i in 0...skins.length) if(skins[i] == skinIndicator) curNum = i;

		camGame = new FlxCamera();
		camNoteColor = new FlxCamera();
		camNoteColor.bgColor.alpha = 0;
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camNoteColor, false);
		FlxG.cameras.add(camHUD, true);

		camNoteFollow = new FlxObject(0, 0, 1, 1);
		camNoteFollowPos = new FlxObject(0, 0, 1, 1);
		add(camNoteFollow);
		add(camNoteFollowPos);

		super.create();
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('MenuShit/wallPaper'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.screenCenter();
		bg.cameras = [camGame];
		add(bg);

		var optbg:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width/1.5), FlxG.height, FlxColor.BLACK);
		optbg.alpha = 0;
		optbg.screenCenter();
		optbg.cameras = [camGame];
		add(optbg);

		var noteSuffix:String = ClientPrefs.data.notesSkin[0].toLowerCase();
		var hurtNoteSuffix:String = ClientPrefs.data.notesSkin[1].toLowerCase();
		var holdSuffix:String = ClientPrefs.data.notesSkin[2].toLowerCase(); //tho this one its unnused
		if(ClientPrefs.data.notesSkin[1].toLowerCase() == 'mimic') hurtNoteSuffix = noteSuffix;
		
		// NOTES

		noteBar = new FlxSprite(0).makeGraphic(FlxG.width, 140, FlxColor.BLACK);
		noteBar.alpha = 0.6;
		noteBar.cameras = [camNoteColor];
		noteBar.screenCenter();
		noteBar.x -= FlxG.width/2;
		noteBar.y -= 400;
		add(noteBar);

		grpHolds = new FlxTypedGroup<Note>();
		add(grpHolds);
		grpHoldEnds = new FlxTypedGroup<Note>();
		add(grpHoldEnds);
		grpNotes = new FlxTypedGroup<Note>();
		add(grpNotes);
		grpNumbers = new FlxTypedGroup<Alphabet>();
		add(grpNumbers);

		updateNotes();

		camNoteColor.follow(camNoteFollowPos, null, 1);
		camNoteColor.visible = true;

		// OTHER

		var titleBG:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 90, FlxColor.BLACK);
		titleText = new FlxText(25, 16, FlxG.width, '< "'+ skinIndicator +'" Skin >', 48);
		titleText.setFormat(Paths.font("vcr.ttf"), 56, FlxColor.WHITE, CENTER);
		titleText.scrollFactor.set();
		titleText.screenCenter(X);
		titleBG.cameras = titleText.cameras = [camHUD];
		add(titleBG);
		add(titleText);

		optionsText = new FlxText(0, 0, FlxG.width, "Options", 48);
		optionsText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, CENTER);
		optionsText.screenCenter();
		optionsText.x += 450;
		optionsText.y = 16;
		optionsText.scrollFactor.set();
		optionsText.cameras = [camHUD];
		add(optionsText);

		var descBG:FlxSprite = new FlxSprite(0, FlxG.height - 45).makeGraphic(FlxG.width, 51, FlxColor.BLACK);
		descText = new FlxText(descBG.x, descBG.y + 12, FlxG.width, "SHIFT - Quantization | SPACE - Show/Hide Description", 18);
		descText.setFormat(Paths.font("vcr.ttf"), 18, FlxColor.WHITE, CENTER);
		descText.scrollFactor.set();
		descBG.cameras = descText.cameras = [camHUD];
		add(descBG);
		add(descText);

		noteDescBox = new FlxSprite().makeGraphic(FlxG.width, 1, FlxColor.BLACK);
		noteDescText = new FlxText(50, 600, 1180, "", 32);
		noteDescText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		noteDescText.scrollFactor.set();
		noteDescText.borderSize = 2.4;
		noteDescBox.alpha = noteDescText.alpha = 0;
		noteDescBox.cameras = noteDescText.cameras = [camHUD];
		add(noteDescBox);
		add(noteDescText);

		changeSelection();
	}

	override function update(elapsed:Float)
	{
		Conductor.songPosition = FlxG.sound.music.time;

		if(FlxG.keys.justPressed.SPACE && noteDescBox.alpha == 0) {
			FlxTween.tween(noteDescBox, {alpha: 0.6}, 0.25, {ease: FlxEase.circOut});
			FlxTween.tween(noteDescText, {alpha: 1}, 0.25, {ease: FlxEase.circOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
		} else if(FlxG.keys.justPressed.SPACE && noteDescBox.alpha == 0.6) {
			FlxTween.tween(noteDescBox, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
			FlxTween.tween(noteDescText, {alpha: 0}, 0.25, {ease: FlxEase.circOut});
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(controls.UI_UP_P || controls.UI_DOWN_P) {
			changeSelection(controls.UI_UP_P ? -1 : 1);
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(FlxG.mouse.wheel != 0) {
			changeSelection(-1 * FlxG.mouse.wheel);
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		}

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			onChangeSkin(controls.UI_LEFT_P ? -1 : 1);
			updateNotes();
			changeSelection();
			ClientPrefs.saveSettings();

			titleText.text = '< "'+ skinIndicator +'" Skin >';
			titleText.screenCenter(X);

			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
			
		if(controls.BACK) {
			MusicBeatState.switchState(new MainMenuState());
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}

		if(FlxG.keys.justPressed.SHIFT) {
			onColorMenu = !onColorMenu;
			if(onColorMenu) {
				noteDescText.text = skinNoteTypes[curNoteSelected];
				descText.text = "SHIFT - Quantization | SPACE - Show/Hide Description";
			} else {
				noteDescText.text = skinNoteTypes[curNoteSelected];
				descText.text = "SHIFT - Note Colors | SPACE - Show/Hide Description";
			}
			titleText.screenCenter(X);

			noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
			noteDescBox.y = noteDescText.y - 10;
			noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
			noteDescBox.updateHitbox();

			camNoteColor.visible = onColorMenu;
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(nextAccept > 0) nextAccept -= 1;

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		if(onColorMenu) {
			curNoteSelected += change;
			if(curNoteSelected < 0) curNoteSelected = 4;
			if(curNoteSelected > 4) curNoteSelected = 0;
	
			for(i in 0...grpNumbers.length) {
				var item = grpNumbers.members[i];
				item.alpha = 0.6;
				if((curNoteSelected * 3) + noteTypeSelected == i) item.alpha = 1;
			}

			for(i in 0...grpNotes.length) {
				var item = grpNotes.members[i];
				item.alpha = 0.6;
				item.scale.set(0.5, 0.5);
				if(curNoteSelected == i) {
					if(i == 4) item.alpha = hurtNoteAlpha;
					else item.alpha = 1;
					item.scale.set(0.75, 0.75);
					noteBar.y = item.y-50;
				}
			}

			for(i in 0...grpHolds.length) {
				var item = grpHolds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				item.setGraphicSize(Std.int(item.width*2), Std.int(FlxG.height/1.005));
				if(curNoteSelected == i) {
					item.alpha = sustainNoteAlpha;
					item.setGraphicSize(Std.int(item.width*2.95), Std.int(FlxG.height/1.005));
				}
			}

			for(i in 0...grpHoldEnds.length) {
				var item = grpHoldEnds.members[i];
				item.alpha = sustainNoteAlpha * (3/5);
				item.scale.set(0.5, 0.5);
				if(curNoteSelected == i) {
					item.alpha = sustainNoteAlpha;
					item.scale.set(0.75, 0.75);
					item.x = grpHolds.members[i].x + grpHolds.members[i].height + 380;
				}
			}
		} else {
		
		}

		if(onColorMenu) noteDescText.text = skinNoteTypes[curNoteSelected];
		else noteDescText.text = skinNoteTypes[curNoteSelected];

		noteDescText.y = (FlxG.height - 50) - noteDescText.height - 10;
		noteDescBox.y = noteDescText.y - 10;
		noteDescBox.setGraphicSize(0, Std.int(noteDescText.height + 25));
		noteDescBox.updateHitbox();
	}

	function changeType(change:Int = 0)
	{
		if(onColorMenu) {
			noteTypeSelected += change;
			if(noteTypeSelected < 0) noteTypeSelected = 2;
			if(noteTypeSelected > 2) noteTypeSelected = 0;
	
			for(i in 0...grpNumbers.length) {
				var item = grpNumbers.members[i];
				item.alpha = 0.6;
				if((curNoteSelected * 3) + noteTypeSelected == i) item.alpha = 1;
			}
		} else {

		}
	}

	function updateValue(change:Float = 0)
	{
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

			var item = grpNumbers.members[(curNoteSelected * 3) + noteTypeSelected];
			item.text = Std.string(roundedValue);
	
			var add = (40 * (item.letters.length - 1)) / 2;
			for(letter in item.letters) {
				letter.offset.x += add;
				if(roundedValue < 0) letter.offset.x += 10;
			}
		} else {

		}
	}

	function updateNotes()
	{
		grpNotes.clear();
		grpHolds.clear();
		grpHoldEnds.clear();

		for(i in 0...5) {
			var yPos:Float = (105 * i) - 155;

			var j:Int = 0;
			if(i < 4)
				j = i;
			else
				j = 0;

			var note:Note = new Note(0, j, false, true); //new FlxSprite(230, yPos - 40);
			var hold:Note = new Note(0, j, true, true);
			var holdend:Note = new Note(0, j, true, true);
			if(i == 4) note.noteType = hold.noteType = holdend.noteType = 'Hurt Note';
			note.x = hold.x = holdend.x = -550;
			note.y = hold.y = holdend.y = yPos - 40;

			var animations:Array<String> = ['purple', 'blue', 'green', 'red', 'purple'];
			note.antialiasing = ClientPrefs.data.antialiasing;
			note.cameras = [camNoteColor];

			hold.antialiasing = ClientPrefs.data.antialiasing;
			hold.cameras = [camNoteColor];
			hold.animation.play(animations[i]+'hold', true);

			holdend.antialiasing = ClientPrefs.data.antialiasing;
			holdend.cameras = [camNoteColor];
			holdend.animation.play(animations[i]+'holdend', true);

			hold.angle = holdend.angle = 90;
			hold.alpha = holdend.alpha = 1;

			hold.setGraphicSize(Std.int(hold.width*2), Std.int(FlxG.height/1.005));
			holdend.scale.set(0.5, 0.5);

			hold.x += 340 + (note.width/2);
			hold.y = note.y + ((note.height-hold.width)/2);

			holdend.x = hold.x + hold.height + 380;
			holdend.y = hold.y;

			grpHolds.add(hold);
			grpHoldEnds.add(holdend);
			grpNotes.add(note);
		}
	}

	function onChangeSkin(?val:Int = 0)
	{
		curNum += val; //So it does a "change" lmao, i still need get some variables such as grab the current skin and load a number -Ed
		if(curNum < 0) curNum = skins.length - 1;
		if(curNum >= skins.length) curNum = 0;

		ClientPrefs.data.notesSkin[0] = skins[curNum];
		skinIndicator = skins[curNum];
	}

	var lastStepHit:Int = -1;
	override function stepHit()
	{
		super.stepHit();

		if(curStep == lastStepHit) return;
		
		lastStepHit = curStep;
	}

	var lastBeatHit:Int = -1;
	var noteThing:Int = 0;
	override public function beatHit()
	{
		super.beatHit();

		if(lastBeatHit == curBeat) return;
		if(curBeat % 2 == 0) {
			var item = grpNotes.members[0];
			item.noteData = noteThing;
			noteThing ++;
			if(noteThing > 3) noteThing = 0; //reset
		}

		lastBeatHit = curBeat;
	}
}