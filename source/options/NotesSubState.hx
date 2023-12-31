package options;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import lime.system.Clipboard;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.math.FlxPoint;
import flixel.util.FlxGradient;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxMath;
import StrumNote;
import Note;

import RGBPalette;
import RGBPalette.RGBShaderReference;

using StringTools;

class NotesSubState extends MusicBeatSubstate
{
	var onModeColumn:Bool = true;
	var curSelectedMode:Int = 0;
	var curSelectedNote:Int = 0;
	var dataArray:Array<Array<FlxColor>>;

	var hexTypeLine:FlxSprite;
	var hexTypeNum:Int = -1;
	var hexTypeVisibleTimer:Float = 0;

	var copyButton:FlxSprite;
	var pasteButton:FlxSprite;

	var colorGradient:FlxSprite;
	var colorGradientSelector:FlxSprite;
	var colorPalette:FlxSprite;
	var colorWheel:FlxSprite;
	var colorWheelSelector:FlxSprite;

	var alphabetR:Alphabet;
	var alphabetG:Alphabet;
	var alphabetB:Alphabet;
	var alphabetHex:Alphabet;

	var modeBG:FlxSprite;
	var notesBG:FlxSprite;

	// controller support
	var tipTxt:FlxText;

	//skins stuff lol
	public var skinIndicator:FlxText;
	var skins:Array<String> = ['HITMANS', 'INHUMAN', 'FNF', 'ITHIT', 'MANIAHIT', 'FUTURE', 'CIRCLE', 'STEPMANIA', 'NOTITG']; //There must be a better way but for now with this im okay -Ed
	private static var curNum:Int = 0;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var noteSkinInt:Int = 0;

	public var rgb:Array<Array<FlxColor>> = [
		[0xFFC24B99, 0xFFFFFFFF, 0xFF3C1F56],
		[0xFF00FFFF, 0xFFFFFFFF, 0xFF1542B7],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFFF9393F, 0xFFFFFFFF, 0xFF651038]
	];
	var isOnMode:Int = 0;
	var reloadedNotes = false;

	public function new() {
		super();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scale.x = 0.6;
		bg.scale.y = 0.6;
		bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		var staticBG:FlxSprite;
		staticBG = new FlxSprite();
		staticBG.frames = Paths.getSparrowAtlas('menuPause');
        staticBG.animation.addByPrefix('glitch', 'glitch', 48, true);	
        staticBG.antialiasing = ClientPrefs.globalAntialiasing;
        staticBG.scale.y = 2;
        staticBG.scale.x = 2;				
        staticBG.screenCenter();
        staticBG.alpha = 0.5;
        staticBG.animation.play("glitch");
        add(staticBG);

		modeBG = new FlxSprite(215, 85).makeGraphic(315, 115, FlxColor.BLACK);
		modeBG.visible = false;
		modeBG.alpha = 0.4;
		add(modeBG);

		notesBG = new FlxSprite(140, 190).makeGraphic(480, 125, FlxColor.BLACK);
		notesBG.visible = false;
		notesBG.alpha = 0.4;
		add(notesBG);

		modeNotes = new FlxTypedGroup<FlxSprite>();
		add(modeNotes);

		myNotes = new FlxTypedGroup<StrumNote>();
		add(myNotes);

		var bg:FlxSprite = new FlxSprite(720).makeGraphic(FlxG.width - 720, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.25;
		add(bg);
		var bg:FlxSprite = new FlxSprite(750, 160).makeGraphic(FlxG.width - 780, 540, FlxColor.BLACK);
		bg.alpha = 0.25;
		add(bg);
		
		var text:Alphabet = new Alphabet(130, 56, 'CTRL', false);
		text.alignment = CENTERED;
		text.setScale(0.4);
		add(text);

		skinIndicator = new FlxText(280, 20, 0, "SkinName", 56);
		skinIndicator.setFormat(Paths.font("DEADLY KILLERS.ttf"), 56, 0xffffffff, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skinIndicator.borderSize = 2;
		add(skinIndicator);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');

		leftArrow = new FlxSprite(100, 350);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		leftArrow.scale.x = 2;
		leftArrow.scale.y = 2;
		leftArrow.updateHitbox();
		add(leftArrow);

		rightArrow = new FlxSprite(475, 350);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', "arrow left");
		rightArrow.animation.addByPrefix('press', "arrow push left");
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		rightArrow.scale.x = 2;
		rightArrow.scale.y = 2;
		rightArrow.flipX = true;
		rightArrow.updateHitbox();
		add(rightArrow);

		copyButton = new FlxSprite(760, 50).loadGraphic(Paths.image('noteColorMenu/copy'));
		copyButton.alpha = 0.6;
		add(copyButton);

		pasteButton = new FlxSprite(1180, 50).loadGraphic(Paths.image('noteColorMenu/paste'));
		pasteButton.alpha = 0.6;
		add(pasteButton);

		colorGradient = FlxGradient.createGradientFlxSprite(60, 360, [FlxColor.WHITE, FlxColor.BLACK]);
		colorGradient.setPosition(780, 200);
		add(colorGradient);

		colorGradientSelector = new FlxSprite(770, 200).makeGraphic(80, 10, FlxColor.WHITE);
		colorGradientSelector.offset.y = 5;
		add(colorGradientSelector);

		colorPalette = new FlxSprite(820, 580).loadGraphic(Paths.image('noteColorMenu/palette', 'shared'));
		colorPalette.scale.set(20, 20);
		colorPalette.updateHitbox();
		colorPalette.antialiasing = false;
		add(colorPalette);
		
		colorWheel = new FlxSprite(860, 200).loadGraphic(Paths.image('noteColorMenu/colorWheel'));
		colorWheel.setGraphicSize(360, 360);
		colorWheel.updateHitbox();
		add(colorWheel);

		colorWheelSelector = new FlxShapeCircle(0, 0, 8, {thickness: 0}, FlxColor.WHITE);
		colorWheelSelector.offset.set(8, 8);
		colorWheelSelector.alpha = 0.6;
		add(colorWheelSelector);

		var txtX = 980;
		var txtY = 90;
		alphabetR = makeColorAlphabet(txtX - 100, txtY);
		add(alphabetR);
		alphabetG = makeColorAlphabet(txtX, txtY);
		add(alphabetG);
		alphabetB = makeColorAlphabet(txtX + 100, txtY);
		add(alphabetB);
		alphabetHex = makeColorAlphabet(txtX, txtY - 55);
		add(alphabetHex);
		hexTypeLine = new FlxSprite(0, 20).makeGraphic(5, 62, FlxColor.WHITE);
		hexTypeLine.visible = false;
		add(hexTypeLine);

		switch (ClientPrefs.notesSkin[0])
		{
			case 'HITMANS':
				noteSkinInt = 0;
			case 'INHUMAN':
				noteSkinInt = 1;
			case 'FNF':
				noteSkinInt = 2;
			case 'ITHIT':
				noteSkinInt = 3;
			case 'MANIAHIT':
				noteSkinInt = 4;
			case 'FUTURE':
				noteSkinInt = 5;
			case 'CIRLCE':
				noteSkinInt = 6;
			case 'STEPMANIA':
				noteSkinInt = 7;
			case 'NOTITG':
				noteSkinInt = 8;
		}

		onChangeSkin(noteSkinInt);
		spawnNotes();
		updateNotes(true);
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);

		var tipX = 20;
		var tipY = 660;
		var tip:FlxText = new FlxText(tipX, tipY, 0, "Press RELOAD to Reset the selected Note Part.", 16);
		tip.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tip.borderSize = 2;
		add(tip);

		tipTxt = new FlxText(tipX, tipY + 24, 0, '', 16);
		tipTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipTxt.borderSize = 2;
		add(tipTxt);
		updateTip();
		
		FlxG.mouse.visible = true;
	}

	function updateTip()
	{
		tipTxt.text = 'Hold ' + 'Shift' + ' + Press RELOAD to fully reset the selected Note.';
	}

	var _storedColor:FlxColor;
	var changingNote:Bool = false;
	var holdingOnObj:FlxSprite;
	var allowedTypeKeys:Map<FlxKey, String> = [
		ZERO => '0', ONE => '1', TWO => '2', THREE => '3', FOUR => '4', FIVE => '5', SIX => '6', SEVEN => '7', EIGHT => '8', NINE => '9',
		NUMPADZERO => '0', NUMPADONE => '1', NUMPADTWO => '2', NUMPADTHREE => '3', NUMPADFOUR => '4', NUMPADFIVE => '5', NUMPADSIX => '6',
		NUMPADSEVEN => '7', NUMPADEIGHT => '8', NUMPADNINE => '9', A => 'A', B => 'B', C => 'C', D => 'D', E => 'E', F => 'F'];

	override function update(elapsed:Float) {
		if (controls.BACK) {
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			close();
			return;
		}

		super.update(elapsed);
		var qPress = FlxG.keys.justPressed.Q;
		var ePress = FlxG.keys.justPressed.E;

		var qHold = FlxG.keys.pressed.Q;
		var eHold = FlxG.keys.pressed.E;

		if(qPress)
		{
			onChangeSkin(-1);
			spawnNotes();
			updateNotes(true);
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
		}

		if(qHold){
			leftArrow.animation.play('press');
		}else{
			leftArrow.animation.play('idle');
		}

		if(ePress)
		{
			onChangeSkin(1);
			spawnNotes();
			updateNotes(true);
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
		}

		if(eHold){
			rightArrow.animation.play('press');
		}else{
			rightArrow.animation.play('idle');
		}

		if (FlxG.mouse.overlaps(rightArrow)) {
			if (FlxG.mouse.justPressed) {
				onChangeSkin(1);
				spawnNotes();
				updateNotes(true);
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
			}
			if (FlxG.mouse.pressed) {
				rightArrow.animation.play('press');
			} else {
				rightArrow.animation.play('idle');
			}
		}

		if (FlxG.mouse.overlaps(leftArrow)) {
			if (FlxG.mouse.justPressed) {
				onChangeSkin(-1);
				spawnNotes();
				updateNotes(true);
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
			}
			if (FlxG.mouse.pressed) {
				leftArrow.animation.play('press');
			} else {
				leftArrow.animation.play('idle');
			}
		}

		if(hexTypeNum > -1)
		{
			var keyPressed:FlxKey = cast (FlxG.keys.firstJustPressed(), FlxKey);
			hexTypeVisibleTimer += elapsed;
			var changed:Bool = false;
			if(changed = FlxG.keys.justPressed.LEFT)
				hexTypeNum--;
			else if(changed = FlxG.keys.justPressed.RIGHT)
				hexTypeNum++;
			else if(allowedTypeKeys.exists(keyPressed))
			{
				//trace('keyPressed: $keyPressed, lil str: ' + allowedTypeKeys.get(keyPressed));
				var curColor:String = alphabetHex.text;
				var newColor:String = curColor.substring(0, hexTypeNum) + allowedTypeKeys.get(keyPressed) + curColor.substring(hexTypeNum + 1);

				var colorHex:FlxColor = FlxColor.fromString('#' + newColor);
				setShaderColor(colorHex);
				_storedColor = getShaderColor();
				updateColors();
				
				// move you to next letter
				hexTypeNum++;
				changed = true;
			}
			else if(FlxG.keys.justPressed.ENTER)
				hexTypeNum = -1;
			
			var end:Bool = false;
			if(changed)
			{
				if (hexTypeNum > 5) //Typed last letter
				{
					hexTypeNum = -1;
					end = true;
					hexTypeLine.visible = false;
				}
				else
				{
					if(hexTypeNum < 0) hexTypeNum = 0;
					else if(hexTypeNum > 5) hexTypeNum = 5;
					centerHexTypeLine();
					hexTypeLine.visible = true;
				}
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
			}
			if(!end) hexTypeLine.visible = Math.floor(hexTypeVisibleTimer * 2) % 2 == 0;
		}

		// Copy/Paste buttons
		var generalMoved:Bool = (FlxG.mouse.justMoved);
		var generalPressed:Bool = (FlxG.mouse.justPressed);
		if(generalMoved)
		{
			copyButton.alpha = 0.6;
			pasteButton.alpha = 0.6;
		}

		if(pointerOverlaps(copyButton))
		{
			copyButton.alpha = 1;
			if(generalPressed)
			{
				Clipboard.text = getShaderColor().toHexString(false, false);
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
				trace('copied: ' + Clipboard.text);
			}
			hexTypeNum = -1;
		}
		else if (pointerOverlaps(pasteButton))
		{
			pasteButton.alpha = 1;
			if(generalPressed)
			{
				var formattedText = (Clipboard.text.trim().toUpperCase().replace('#', '').replace('0x', ''));
				var newColor:Null<FlxColor> = FlxColor.fromString('#' + formattedText);
				//trace('#${Clipboard.text.trim().toUpperCase()}');
				if(newColor != null && formattedText.length == 6)
				{
					setShaderColor(newColor);
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					_storedColor = getShaderColor();
					updateColors();
				}
				else //errored
					FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
			}
			hexTypeNum = -1;
		}

		// Click
		if(generalPressed)
		{
			hexTypeNum = -1;
			if (pointerOverlaps(modeNotes))
			{
				modeNotes.forEachAlive(function(note:FlxSprite) {
					if (curSelectedMode != note.ID && pointerOverlaps(note))
					{
						modeBG.visible = notesBG.visible = false;
						curSelectedMode = note.ID;
						onModeColumn = true;
						updateNotes();
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					}
				});
			}
			else if (pointerOverlaps(myNotes))
			{
				myNotes.forEachAlive(function(note:StrumNote) {
					if (curSelectedNote != note.ID && pointerOverlaps(note))
					{
						modeBG.visible = notesBG.visible = false;
						curSelectedNote = note.ID;
						onModeColumn = false;
						bigNote.rgbShader.parent = Note.globalRgbShaders[note.ID];
						bigNote.shader = Note.globalRgbShaders[note.ID].shader;
						updateNotes();
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					}
				});
			}
			else if (pointerOverlaps(colorWheel)) {
				_storedColor = getShaderColor();
				holdingOnObj = colorWheel;
			}
			else if (pointerOverlaps(colorGradient)) {
				_storedColor = getShaderColor();
				holdingOnObj = colorGradient;
			}
			else if (pointerOverlaps(colorPalette)) {
				setShaderColor(colorPalette.pixels.getPixel32(
					Std.int((pointerX() - colorPalette.x) / colorPalette.scale.x), 
					Std.int((pointerY() - colorPalette.y) / colorPalette.scale.y)));
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
				updateColors();
			}
			else if(pointerY() >= hexTypeLine.y && pointerY() < hexTypeLine.y + hexTypeLine.height &&
					Math.abs(pointerX() - 1000) <= 84)
			{
				hexTypeNum = 0;
				for (letter in alphabetHex.letters)
				{
					if(letter.x - letter.offset.x + letter.width <= pointerX()) hexTypeNum++;
					else break;
				}
				if(hexTypeNum > 5) hexTypeNum = 5;
				hexTypeLine.visible = true;
				centerHexTypeLine();
			}
			else holdingOnObj = null;
		}
		// holding
		if(holdingOnObj != null)
		{
			if (FlxG.mouse.justReleased)
			{
				holdingOnObj = null;
				_storedColor = getShaderColor();
				updateColors();
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
			}
			else if (generalMoved || generalPressed)
			{
				if (holdingOnObj == colorGradient)
				{
					var newBrightness = 1 - FlxMath.bound((pointerY() - colorGradient.y) / colorGradient.height, 0, 1);
					_storedColor.alpha = 1;
					if(_storedColor.brightness == 0) //prevent bug
						setShaderColor(FlxColor.fromRGBFloat(newBrightness, newBrightness, newBrightness));
					else
						setShaderColor(FlxColor.fromHSB(_storedColor.hue, _storedColor.saturation, newBrightness));
					updateColors(_storedColor);
				}
				else if (holdingOnObj == colorWheel)
				{
					var center:FlxPoint = new FlxPoint(colorWheel.x + colorWheel.width/2, colorWheel.y + colorWheel.height/2);
					var mouse:FlxPoint = pointerFlxPoint();
					var hue:Float = FlxMath.wrap(FlxMath.wrap(Std.int(mouse.degreesTo(center)), 0, 360) - 90, 0, 360);
					var sat:Float = FlxMath.bound(mouse.dist(center) / colorWheel.width*2, 0, 1);
					//trace('$hue, $sat');
					if(sat != 0) setShaderColor(FlxColor.fromHSB(hue, sat, _storedColor.brightness));
					else setShaderColor(FlxColor.fromRGBFloat(_storedColor.brightness, _storedColor.brightness, _storedColor.brightness));
					updateColors();
				}
			} 
		}
		else if(controls.RESET && hexTypeNum < 0)
		{
			if(FlxG.keys.pressed.SHIFT)
			{
				for (i in 0...3)
				{
					var strumRGB:RGBShaderReference = myNotes.members[curSelectedNote].rgbShader;
					var color:FlxColor = rgb[curSelectedNote][i];
					switch(i)
					{
						case 0:
							getShader().r = strumRGB.r = color;
						case 1:
							getShader().g = strumRGB.g = color;
						case 2:
							getShader().b = strumRGB.b = color;
					}
					dataArray[curSelectedNote][i] = color;
				}
			}
			setShaderColor(rgb[curSelectedNote][curSelectedMode]);
			FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
			updateColors();
		}
	}

	function pointerOverlaps(obj:Dynamic)
	{
		return FlxG.mouse.overlaps(obj);
	}

	function pointerX():Float
	{
		return FlxG.mouse.x;
	}
	function pointerY():Float
	{
		return FlxG.mouse.y;
	}
	function pointerFlxPoint():FlxPoint
	{
		return FlxG.mouse.getScreenPosition();
	}

	function centerHexTypeLine()
	{
		//trace(hexTypeNum);
		if(hexTypeNum > 0)
		{
			var letter = alphabetHex.letters[hexTypeNum-1];
			hexTypeLine.x = letter.x - letter.offset.x + letter.width;
		}
		else
		{
			var letter = alphabetHex.letters[0];
			hexTypeLine.x = letter.x - letter.offset.x;
		}
		hexTypeLine.x += hexTypeLine.width;
		hexTypeVisibleTimer = 0;
	}

	function changeSelectionMode(change:Int = 0) {
		curSelectedMode += change;
		if (curSelectedMode < 0)
			curSelectedMode = 2;
		if (curSelectedMode >= 3)
			curSelectedMode = 0;

		modeBG.visible = true;
		notesBG.visible = false;
		updateNotes();
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function changeSelectionNote(change:Int = 0) {
		curSelectedNote += change;
		if (curSelectedNote < 0)
			curSelectedNote = dataArray.length-1;
		if (curSelectedNote >= dataArray.length)
			curSelectedNote = 0;
		
		modeBG.visible = false;
		notesBG.visible = true;
		bigNote.rgbShader.parent = Note.globalRgbShaders[curSelectedNote];
		bigNote.shader = Note.globalRgbShaders[curSelectedNote].shader;
		updateNotes();
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	// alphabets
	function makeColorAlphabet(x:Float = 0, y:Float = 0):Alphabet
	{
		var text:Alphabet = new Alphabet(x, y, '', true);
		text.alignment = CENTERED;
		text.setScale(0.6);
		add(text);
		return text;
	}

	function onChangeSkin(?val:Int = 0){
		curNum += val; //So it does a "change" lmao, i still need get some variables such as grab the current skin and load a number -Ed

		if (curNum < 0)
			curNum = skins.length - 1;
		if (curNum >= skins.length)
			curNum = 0;

		ClientPrefs.notesSkin[0] = skins[curNum];
		skinIndicator.text = skins[curNum];
	}
	
	// notes sprites functions
	var skinNote:FlxSprite;
	var modeNotes:FlxTypedGroup<FlxSprite>;
	var myNotes:FlxTypedGroup<StrumNote>;
	var bigNote:Note;
	public function spawnNotes()
	{
		dataArray = ClientPrefs.arrowRGB;

		// clear groups
		modeNotes.forEachAlive(function(note:FlxSprite) {
			note.kill();
			note.destroy();
		});
		myNotes.forEachAlive(function(note:StrumNote) {
			note.kill();
			note.destroy();
		});
		modeNotes.clear();
		myNotes.clear();

		if(skinNote != null)
		{
			remove(skinNote);
			skinNote.destroy();
		}
		if(bigNote != null)
		{
			remove(bigNote);
			bigNote.destroy();
		}

		// respawn stuff

		var res:Int = 160;
		skinNote = new FlxSprite(48, 24).loadGraphic(Paths.image('noteColorMenu/note'), true, res, res);
		skinNote.antialiasing = ClientPrefs.globalAntialiasing;
		skinNote.setGraphicSize(68);
		skinNote.updateHitbox();
		skinNote.animation.add('anim', [0], 24, true);
		skinNote.animation.play('anim', true);
		skinNote.antialiasing = false;
		add(skinNote);

		var res:Int = 160;
		for (i in 0...3)
		{
			var newNote:FlxSprite = new FlxSprite(230 + (100 * i), 100).loadGraphic(Paths.image('noteColorMenu/note'), true, res, res);
			newNote.antialiasing = ClientPrefs.globalAntialiasing;
			newNote.setGraphicSize(85);
			newNote.updateHitbox();
			newNote.animation.add('anim', [i], 24, true);
			newNote.animation.play('anim', true);
			newNote.ID = i;
			modeNotes.add(newNote);
		}

		Note.globalRgbShaders = [];
		for (i in 0...dataArray.length)
		{
			Note.initializeGlobalRGBShader(i);
			var newNote:StrumNote = new StrumNote(150 + (480 / dataArray.length * i), 200, i, 0);
			newNote.useRGBShader = true;
			newNote.setGraphicSize(102);
			newNote.updateHitbox();
			newNote.ID = i;
			myNotes.add(newNote);
		}

		bigNote = new Note(0, 0, false, true);
		bigNote.setPosition(250, 325);
		bigNote.setGraphicSize(250);
		bigNote.updateHitbox();
		bigNote.rgbShader.parent = Note.globalRgbShaders[curSelectedNote];
		bigNote.shader = Note.globalRgbShaders[curSelectedNote].shader;
		for (i in 0...Note.colArray.length)
		{
			bigNote.animation.addByPrefix('note$i', Note.colArray[i] + '0', 24, true);
		}
		insert(members.indexOf(myNotes) + 1, bigNote);
		_storedColor = getShaderColor();
		PlayState.isPixelStage = false;
	}

	function updateNotes(?instant:Bool = false)
	{
		for (note in modeNotes)
			note.alpha = (curSelectedMode == note.ID) ? 1 : 0.6;

		for (note in myNotes)
		{
			var newAnim:String = curSelectedNote == note.ID ? 'confirm' : 'pressed';
			note.alpha = (curSelectedNote == note.ID) ? 1 : 0.6;
			if(note.animation.curAnim == null || note.animation.curAnim.name != newAnim) note.playAnim(newAnim, true);
			if(instant) note.animation.curAnim.finish();
		}
		bigNote.animation.play('note$curSelectedNote', true);
		updateColors();
	}

	function updateColors(specific:Null<FlxColor> = null)
	{
		var color:FlxColor = getShaderColor();
		var wheelColor:FlxColor = specific == null ? getShaderColor() : specific;
		alphabetR.text = Std.string(color.red);
		alphabetG.text = Std.string(color.green);
		alphabetB.text = Std.string(color.blue);
		alphabetHex.text = color.toHexString(false, false);
		for (letter in alphabetHex.letters) letter.color = color;

		colorWheel.color = FlxColor.fromHSB(0, 0, color.brightness);
		colorWheelSelector.setPosition(colorWheel.x + colorWheel.width/2, colorWheel.y + colorWheel.height/2);
		if(wheelColor.brightness != 0)
		{
			var hueWrap:Float = wheelColor.hue * Math.PI / 180;
			colorWheelSelector.x += Math.sin(hueWrap) * colorWheel.width/2 * wheelColor.saturation;
			colorWheelSelector.y -= Math.cos(hueWrap) * colorWheel.height/2 * wheelColor.saturation;
		}
		colorGradientSelector.y = colorGradient.y + colorGradient.height * (1 - color.brightness);

		var strumRGB:RGBShaderReference = myNotes.members[curSelectedNote].rgbShader;
		switch(curSelectedMode)
		{
			case 0:
				getShader().r = strumRGB.r = color;
			case 1:
				getShader().g = strumRGB.g = color;
			case 2:
				getShader().b = strumRGB.b = color;
		}
	}

	function setShaderColor(value:FlxColor) dataArray[curSelectedNote][curSelectedMode] = value;
	function getShaderColor() return dataArray[curSelectedNote][curSelectedMode];
	function getShader() return Note.globalRgbShaders[curSelectedNote];
}