package states;

import flixel.input.gamepad.FlxGamepad;
import states.subs.PauseSubState;
import flixel.graphics.FlxGraphic;
import states.SystemOptions;

class OptionCata extends FlxSprite
{
	public var title:String;

	public var options:Array<SystemOptions>;

	public var optionObjects:FlxTypedGroup<OptionText>;

	public var graphics:Array<FlxSprite> = [];

	public var titleObject:FlxText;

	public var middle:Bool = false;

	public var text:OptionText;

	public var fixedY:Bool = false;

	public static var sizeWindow:Float = 230;

	public function new(x:Float, y:Float, _title:String, _options:Array<SystemOptions>, middleType:Bool = false)
	{
		super(x, y);
		title = _title;
		middle = middleType;

		_options = _options.filter(option -> return option.existInPause);

		graphics = [];

		var blackGraphic = new FlxSprite().makeGraphic(295, 64, FlxColor.BLACK);
		var cumGraphic = new FlxSprite().makeGraphic(295, 64, FlxColor.WHITE);

		graphics.push(blackGraphic);
		graphics.push(cumGraphic);

		if (!middleType)
			loadGraphic(graphics[0].graphic);
		alpha = 0.4;

		options = _options;

		optionObjects = new FlxTypedGroup();

		titleObject = new FlxText((middleType ? 1180 / 2 : x), y + (middleType ? 0 : 16), 0, title);
		titleObject.setFormat(Paths.font("vcr.ttf"), 35, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleObject.borderSize = 3;

		if (middleType)
		{
			titleObject.x = 50 + ((1180 / 2) - (titleObject.fieldWidth / 2));
		}
		else
			titleObject.x += (width / 2) - (titleObject.fieldWidth / 2);

		titleObject.scrollFactor.set();

		scrollFactor.set();

		for (i in 0...options.length)
		{
			var opt = options[i];
			text = new OptionText(middleType ? 0 : 75, (46 * i) + 175, 35, 35, Paths.bitmapFont('fonts/vcr'));
			text.autoSize = true;
			text.borderStyle = FlxTextBorderStyle.OUTLINE;
			text.borderSize = 2;
			text.antialiasing = ClientPrefs.data.antialiasing;
			text.targetY = i;
			text.alpha = 0.4;
			text.ID = i;

			text.text = opt.getValue();

			if (middleType)
				text.alignment = FlxTextAlign.RIGHT;

			text.updateHitbox();

			text.scrollFactor.set();

			optionObjects.add(text);
		}
	}

	public function changeColor(color:FlxColor)
	{
		if (color == FlxColor.BLACK)
			loadGraphic(graphics[0].graphic);
		else if (color == FlxColor.WHITE)
			loadGraphic(graphics[1].graphic);
	}

	override function destroy()
	{
		for (graphic in graphics)
			graphic.destroy();
		graphics.resize(0);
		for (shit in optionObjects)
		{
			shit.destroy();
		}

		optionObjects.clear();

		options.resize(0);

		super.destroy();
	}
}

class OptionText extends CoolText
{
	public var offsetY:Float = 0;
	public var targetY:Float = 0;

	public var rawY:Float = 0;

	public var lerpFinished:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var optLerp = FlxMath.bound(elapsed * 15, 0, 1);

		rawY = (targetY * 45.75) + OptionCata.sizeWindow;
		y = FlxMath.lerp(y, rawY, optLerp) + offsetY;

		lerpFinished = y == rawY;
	}
}

class OptionsMenu extends MusicBeatSubstate
{
	private var camOptions:FlxCamera;
	private var camMenu:FlxCamera;

	public static var instance:OptionsMenu = null;

	public var background:FlxSprite;

	public var selectedCat:OptionCata;

	public var selectedOption:SystemOptions;

	public var selectedCatIndex = 0;

	public var selectedOptionIndex = 0;

	public static var mustScroll:Bool = false;

	public var isInCat:Bool = false;

	public var options:Array<OptionCata>;

	public static var isInPause = false;

	public var shownStuff:FlxTypedGroup<OptionText>;

	public static var visibleRange = [164, 640];

	var changedOption = false;

	var holdTime:Float = 0;

	public static var boyfriend:Character = null;

	public static var changedAntialising:Bool = false;

	var camFollow:FlxPoint = FlxPoint.get(0, 0);

	public function new(pauseMenu:Bool = false)
	{
		Paths.setCurrentLevel('shared'); //LMAO LMAO
		
		super();

		camMenu = new FlxCamera();
		camMenu.bgColor.alpha = 0;
		camOptions = new FlxCamera();
		camOptions.bgColor.alpha = 0;

		FlxG.cameras.add(camMenu, false);
		FlxG.cameras.add(camOptions, false);

		camMenu.setScale(0.75, 0.75);

		isInPause = pauseMenu;
		
		ClientPrefs.loadPrefs();

		if (!isInPause){
			options = [
				new OptionCata(50, 100, "Gameplay", [
					new ControllerModeOption("If you want to play with a controller instead of using your Keyboard."),
					new DownscrollOption("Notes go Down instead of Up, simple enough."),
					new MiddleScrollOption("Your notes get centered."),
					new OpponentNotesOption("Opponent notes get hidden."),
					new CasualModeOption("Game will buff healthGain and nerf the drain only that it will don't enable any archivement"),
					new GhostTappingOption("You won't get misses from pressing keys while there are no notes able to be hit."),
					new DisableResetOption("Pressing Reset won't do anything."),
					new HitsoundVolumeOption("Funny notes does \"Tick!\" when you hit them."),
					new HotkeysOption("Change your keyblinds ig?"),
				]),
				new OptionCata(345, 100, "Appearance", [
					new HudStyleOption("What HUD you like more?"),
					new HideHudOption("Hides most HUD elements."),
					new TimeBarOption("What should the Time Bar display?"),
					new CamZoomOption("The camera won't zoom in on a beat hit."),
					new ScoreZoomOption("Disables the Score text zooming everytime you hit a note."),
					new HealthBarVisibility("Toggles health bar transperancy"),
					new NoteOption("Change your notes options (skin/color)"),
					new HurtOption("Change your hurts options (skin/color)"),
					new QuantizationOption("Allow note quantization"),
					new QuantOption("Change the Quantize colors"),
					new MineSkin("Change the Mine Note Skin"),
					new HoldSkin("Change the Hold (Sustain) Skin"),
					new MimicNoteOption("Change the Mimic note alpha"),
				]),
				new OptionCata(640, 100, "Misc", [
					new FlashingLightsOption("If you're sensitive to flashing lights!"),
					new PauseMusicOption("What song do you prefer for the Pause Screen?"),
					new RatingOffsetOption('Changes how late/early you have to hit for a "PERFECT!" Higher values mean you have to hit later.'),
					new SafeFramesOption("Changes how many frames you have for hitting a note earlier or late."),
					new LowQualityOption("Disables some background details, decreases loading times and improves performance."),
					new AntiAliasOption("Disables anti-aliasing, increases performance at the cost of sharper visuals."),
					new ShadersOption("Disables shaders. It\'s used for some visual effects, and also CPU intensive for weaker PCs."),
				]),
				new OptionCata(935, 100, "Performance", [
					new FPSOption("Toggle the FPS Counter"),
					new Framerate("Pretty self explanatory, isn't it?"),
					#if desktop
					new DiscordRichOption("Uncheck this to prevent accidental leaks, it will hide the Application from your Playing box on Discord"),
					#end
				]),
				new OptionCata(10000, 10000, "", [

				]),
			];
		}else{
			options = [
				new OptionCata(50, 100, "Gameplay", [
					new ControllerModeOption("If you want to play with a controller instead of using your Keyboard."),
					new OpponentNotesOption("Opponent notes get hidden."),
					new DisableResetOption("Pressing Reset won't do anything."),
					new HitsoundVolumeOption("Funny notes does \"Tick!\" when you hit them."),
				]),
				new OptionCata(345, 100, "Appearance", [
					new HudStyleOption("What HUD you like more?"),
					new HideHudOption("Hides most HUD elements."),
					new TimeBarOption("What should the Time Bar display?"),
					new ScoreZoomOption("Disables the Score text zooming everytime you hit a note."),
					new HealthBarVisibility("Toggles health bar transperancy"),
					new QuantizationOption("Allow note quantization"),
					new MineSkin("Change the Mine Note Skin"),
					new HoldSkin("Change the Hold (Sustain) Skin"),
				]),
				new OptionCata(640, 100, "Misc", [
					new FlashingLightsOption("If you're sensitive to flashing lights!"),
					new PauseMusicOption("What song do you prefer for the Pause Screen?"),
					new LowQualityOption("Disables some background details, decreases loading times and improves performance."),
					new AntiAliasOption("Disables anti-aliasing, increases performance at the cost of sharper visuals."),
					new ShadersOption("Disables shaders. It\'s used for some visual effects, and also CPU intensive for weaker PCs."),
				]),
				new OptionCata(935, 100, "Performance", [
					new FPSOption("Toggle the FPS Counter"),
					new Framerate("Pretty self explanatory, isn't it?"),
					#if desktop
					new DiscordRichOption("Uncheck this to prevent accidental leaks, it will hide the Application from your Playing box on Discord"),
					#end
				]),
				new OptionCata(10000, 10000, "", [

				]),
			];
		}

		menu = new FlxTypedGroup<FlxSprite>();

		shownStuff = new FlxTypedGroup<OptionText>();

		background = new FlxSprite(/*50, 40)/*.makeGraphic(1180, 640, FlxColor.BLACK)*/).loadGraphic(Paths.image('MenuShit/Options'));
		background.scale.set(1.25, 1.25);
		background.screenCenter(XY);
		background.alpha = 1;
		background.scrollFactor.set();

		descBack = new FlxSprite(50, 642).makeGraphic(1180, 38, FlxColor.BLACK);
		descBack.alpha = 0.3;
		descBack.scrollFactor.set();

		if (isInPause)
		{
			var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			bg.alpha = 0;
			bg.scrollFactor.set();
			menu.add(bg);

			descBack.alpha = 0.3;
			bg.alpha = 0.6;
		}

		descText = new CoolText(65, 648, 20, 20, Paths.bitmapFont('fonts/vcr'));
		descText.autoSize = false;
		descText.fieldWidth = 1750;
		descText.antialiasing = ClientPrefs.data.antialiasing;
		descText.borderStyle = FlxTextBorderStyle.OUTLINE;
		descText.borderSize = 2;

		openCallback = refresh;

		cameras = [camMenu];
		camOptions.y = 200;
	}

	public var menu:FlxTypedGroup<FlxSprite>;

	public var descText:CoolText;
	public var descBack:FlxSprite;

	override function create()
	{	
		instance = this;

		menu.add(background);

		menu.add(descBack);

		selectedCat = options[0];

		add(menu);

		add(shownStuff);

		add(descBack);
		add(descText);

		isInCat = true;

		for (i in 0...options.length - 1)
		{
			/*if (i > 4)
				continue;*/
			var cat = options[i];
			add(cat);
			add(cat.titleObject);
		}

		switchCat(selectedCat);

        ClientPrefs.saveSettings();

		super.create();

		if(boyfriend == null)
			reloadBoyfriend();
	}

	function refresh()
	{
		#if cpp
		if (isInPause)
		{
			if (PauseSubState.pauseMusic != null)
			{
				add(PauseSubState.pauseMusic);
				PauseSubState.pauseMusic.play();
			}
		}
		#end
		switchCat(selectedCat);
	}

	var saveIndex:Int = 0;

	var saveOptIndex:Int = 0;

	public function switchCat(cat:OptionCata, toSubCat:Bool = false, fromSubCat:Bool = false)
	{
		if (toSubCat)
		{
			saveIndex = options.indexOf(selectedCat);
			saveOptIndex = selectedOptionIndex;
			isInCat = false;
		}
		else if (!fromSubCat)
		{
			saveIndex = 0;
			saveOptIndex = 0;
			selectedOptionIndex = 0;
		}

		visibleRange = [164, 640];
		/*if (cat.middle)
			visibleRange = [Std.int(cat.titleObject.y), 640]; */

		if (selectedCatIndex > options.length - 2 && !toSubCat)
			selectedCatIndex = 0;

		if (selectedCat.middle)
			remove(selectedCat.titleObject);

		selectedCat.changeColor(FlxColor.BLACK);
		selectedCat.alpha = 0.4;
		selectedCat = cat;
		selectedCat.alpha = 0.3;
		selectedCat.changeColor(FlxColor.WHITE);

		if (fromSubCat)
		{
			selectedOption = selectedCat.options[saveOptIndex];
			selectedOptionIndex = saveOptIndex;
			isInCat = false;
		}
		else
		{
			selectedOption = selectedCat.options[0];
			selectedOptionIndex = 0;
		}

		for (leStuff in shownStuff)
		{
			shownStuff.remove(leStuff, true);
		}

		shownStuff.members.resize(0);
		shownStuff.clear();

		if (selectedCat.middle)
			add(selectedCat.titleObject);

		if (!isInCat)
			selectOption(selectedOption);

		for (opt in selectedCat.optionObjects.members)
			opt.targetY = opt.ID;

		for (i in selectedCat.optionObjects)
			shownStuff.add(i);

		trace("Changed cat: " + selectedCatIndex);

		updateOptColors();
	}

	public function selectOption(option:SystemOptions)
	{
		var object = selectedCat.optionObjects.members[selectedOptionIndex];

		selectedOption = option;

		if (!isInCat)
		{
			object.text = "> " + option.getValue();

			descText.text = option.getDescription();

			updateOptColors();

			if (selectedOption.blocked)
				descText.color = FlxColor.RED;
			else
				descText.color = FlxColor.WHITE;

			descText.updateHitbox();
		}
		trace("Changed opt: " + selectedOptionIndex);

		trace("Bounds: " + visibleRange[0] + "," + visibleRange[1]);
	}

	public function changeOptionSelection(change:Int = 0) {
		if (selectedOption.acceptType)
			selectedOption.waitingType = false;
		FlxG.sound.play(Paths.sound('scrollMenu'),0.5);
		selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
		selectedOptionIndex = FlxMath.wrap(selectedOptionIndex + change, 0, options[selectedCatIndex].options.length - 1);

		var bullShit:Int = 0;
		for (option in selectedCat.optionObjects.members) {
			option.targetY = bullShit - selectedOptionIndex;
			bullShit++;
		}

		selectOption(options[selectedCatIndex].options[selectedOptionIndex]);
	}

	var exiting:Bool = false;
	var curView:Float = 0;

	override function update(elapsed:Float)
	{
		#if desktop
		if (isInPause)
		{
			if (PauseSubState.pauseMusic != null && PauseSubState.pauseMusic.time == 0)
			{
				if (!PauseSubState.pauseMusic.playing)
				    PauseSubState.pauseMusic.play();
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		var accept = false;
		var right = false;
		var left = false;
		var up = false;
		var down = false;
		var any = false;
		var escape = false;
		var clickedCat = false;

		var rightHold = controls.UI_RIGHT_P || FlxG.keys.pressed.RIGHT || (gamepad != null ? gamepad.pressed.DPAD_RIGHT : false);

		var leftHold = controls.UI_LEFT_P || FlxG.keys.pressed.LEFT || (gamepad != null ? gamepad.pressed.DPAD_LEFT : false);

		changedOption = false;

		accept = controls.ACCEPT || FlxG.keys.justPressed.ENTER || (gamepad != null ? gamepad.justPressed.A : false);
		right = controls.UI_RIGHT_P || FlxG.keys.justPressed.RIGHT || (gamepad != null ? gamepad.justPressed.DPAD_RIGHT : false);
		left = controls.UI_LEFT_P || FlxG.keys.justPressed.LEFT || (gamepad != null ? gamepad.justPressed.DPAD_LEFT : false);
		up = controls.UI_UP_P || FlxG.keys.justPressed.UP || (gamepad != null ? gamepad.justPressed.DPAD_UP : false);
		down = controls.UI_DOWN_P || FlxG.keys.justPressed.DOWN || (gamepad != null ? gamepad.justPressed.DPAD_DOWN : false);

		any = FlxG.keys.justPressed.ANY || (gamepad != null ? gamepad.justPressed.ANY : false);
		escape = controls.BACK || FlxG.keys.justPressed.ESCAPE || (gamepad != null ? gamepad.justPressed.B : false);

		if(boyfriend != null && boyfriend.animation.curAnim.finished) {
			boyfriend.dance();
		}

		if (selectedCat != null && !exiting)
		{
			for (i in selectedCat.optionObjects.members)
			{
				if (selectedCat.middle)
				{
					i.screenCenter(X);
					i.updateHitbox();
				}

				// I wanna die!!!
				if (i.y < visibleRange[0] - 24 || i.y > visibleRange[1] - 24)
				{
					if (i.visible)
						i.visible = false;
				}
				else
				{
					if (!i.visible)
						i.visible = true;

					if (selectedCat.optionObjects.members[selectedOptionIndex].text != i.text || isInCat)
						i.alpha = 0.4;
					else
						i.alpha = 1;
				}
			}
		}

		if (isInCat)
		{
			descText.text = "Please select a category";

			descText.color = FlxColor.WHITE;
			descText.updateHitbox();

			if (selectedOption != null)
			{
				if (right)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'),0.5);
					selectedCatIndex++;

					if (selectedCatIndex > options.length - 2)
						selectedCatIndex = 0;
					if (selectedCatIndex < 0)
						selectedCatIndex = options.length - 2;

					switchCat(options[selectedCatIndex]);
				}
				else if (left)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'),0.5);
					selectedCatIndex--;

					if (selectedCatIndex > options.length - 2)
						selectedCatIndex = 0;
					if (selectedCatIndex < 0)
						selectedCatIndex = options.length - 2;

					switchCat(options[selectedCatIndex]);
				}
			}

			if (accept)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'),0.5);
				selectedOptionIndex = 0;
				isInCat = false;
				selectOption(selectedCat.options[0]);
			}

			if (escape)
			{
				if (!isInPause)
				{
					exiting = true;
					FlxTween.tween(background, {alpha: 0}, 0.5, {ease: FlxEase.smootherStepInOut});
					for (i in 0...selectedCat.optionObjects.length)
					{
						FlxTween.tween(selectedCat.optionObjects.members[i], {alpha: 0}, 0.5, {ease: FlxEase.smootherStepInOut});
					}
					for (i in 0...options.length - 1)
					{
						FlxTween.tween(options[i].titleObject, {alpha: 0}, 0.5, {ease: FlxEase.smootherStepInOut});
						FlxTween.tween(options[i], {alpha: 0}, 0.5, {ease: FlxEase.smootherStepInOut});
					}
					FlxTween.tween(descText, {alpha: 0}, 0.5, {ease: FlxEase.smootherStepInOut});
					FlxTween.tween(descBack, {alpha: 0}, 0.5, {
						ease: FlxEase.smootherStepInOut,
						onComplete: function(twn:FlxTween)
						{
							MainMenuState.inFolder = false;
                            ClientPrefs.saveSettings();
							Paths.setCurrentLevel(''); //LMAO LMAO
							close();
						}
					});
				}
				else
				{
					ClientPrefs.saveSettings();
					PauseSubState.goBack = true;
					Paths.setCurrentLevel(''); //LMAO LMAO
					close();
				}
			}
		}
		else
		{
			if (selectedOption != null)
				if (selectedOption.acceptType)
				{
					if (escape && selectedOption.waitingType)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'));
						selectedOption.waitingType = false;
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						object.text = "> " + selectedOption.getValue();
						object.updateHitbox();
						trace("New text: " + object.text);
						return;
					}
					else if (any)
					{
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						selectedOption.onType(gamepad == null ? FlxG.keys.getIsDown()[0].ID.toString() : gamepad.firstJustPressedID());
						object.text = "> " + selectedOption.getValue();
						object.updateHitbox();
						trace("New text: " + object.text);
					}
				}

			if (selectedOption.acceptType)
				if (accept)
				{
					var prev = selectedOptionIndex;
					var object = selectedCat.optionObjects.members[selectedOptionIndex];
					selectedOption.press();

					if (selectedOptionIndex == prev)
					{
						object.text = "> " + selectedOption.getValue();
						object.updateHitbox();
					}
				}

			if (selectedOption != null)
			{
				if (boyfriend != null)
					boyfriend.visible = selectedOption.showBoyfriend;
			}
					

			#if !mobile
			if (FlxG.mouse.wheel != 0)
			{
				if (FlxG.mouse.wheel < 0)
					down = true;
				else if (FlxG.mouse.wheel > 0)
					up = true;
			}
			#end

			if (down || up)
				changeOptionSelection(down ? 1 : -1);

			if (!selectedOption.acceptType)
			{
				if (right)
					changeOptionValue(true);
				else if (left)
					changeOptionValue(false);

				if (selectedOption.getAccept())
				{
					if (rightHold || leftHold)
						holdTime += elapsed;
					else
						resetHoldTime();

					if (holdTime > 0.5)
					{
						if (Math.floor(elapsed) % 10 == 0)
						{
							if (rightHold)
								changeOptionValue(true);
							else if (leftHold)
								changeOptionValue(false);
						}
					}
				}
			}

			if (changedOption)
				updateOptColors();

			if (escape)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'),0.5);

				// ClientPrefs.loadKeyBinds();

				if (selectedCat.middle)
				{
					switchCat(options[saveIndex], false, true);
				}
				else
				{
					for (opt in selectedCat.optionObjects.members)
						opt.targetY = opt.ID;

					for (index => object in selectedCat.optionObjects.members)
					{
						object.text = selectedCat.options[selectedCat.optionObjects.members.indexOf(object)].getValue();
						object.updateHitbox();
					}
					changeOptionSelection(-selectedOptionIndex); // Revert back the options

					isInCat = true;
				}
			}
		}

		// #if !mobile
		// if (!isInPause)
		// {
		// 	for (i in 0...options.length - 1)
		// 	{
		// 		if (i <= 4)
		// 		{
		// 			clickedCat = ((FlxG.mouse.overlaps(options[i].titleObject) || FlxG.mouse.overlaps(options[i]))
		// 				&& FlxG.mouse.justPressed);
		// 			if (clickedCat)
		// 			{
		// 				FlxG.sound.play(Paths.sound('scrollMenu'));
		// 				selectedCatIndex = i;
		// 				switchCat(options[i]);
		// 				selectedOptionIndex = 0;
		// 				isInCat = false;
		// 				selectOption(selectedCat.options[0]);
		// 			}
		// 		}
		// 	}
		// }
		// #end

		super.update(elapsed);
	}

	override function close():Void
	{
		#if desktop
		if (isInPause)
		{
			if (PauseSubState.pauseMusic != null)
			{
				PauseSubState.pauseMusic.pause();
				remove(PauseSubState.pauseMusic);
			}
		}
		#end

		FlxG.save.flush();

		super.close();
	}

	override function destroy():Void
	{
		instance = null;
		if (selectedOption != null)
			if (selectedOption.changedMusic)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		for (cata in options)
			if (cata != null)
				cata.destroy();
		options.resize(0);
		if (boyfriend != null)
			boyfriend = null;
		super.destroy();
	}

	function resetHoldTime()
	{
		holdTime = 0;
	}

	function changeOptionValue(?right:Bool = false)
	{
		var object = selectedCat.optionObjects.members[selectedOptionIndex];

		if (right)
			selectedOption.right();
		else
			selectedOption.left();
		changedOption = true;

		object.text = "> " + selectedOption.getValue();
		object.updateHitbox();
		ClientPrefs.saveSettings();
	}

	function updateOptColors():Void
	{
		for (i in 0...selectedCat.options.length)
		{
			var opt = selectedCat.options[i];
			var optObject = selectedCat.optionObjects.members[i];
			opt.updateBlocks();

			if (opt.blocked)
				optObject.color = FlxColor.RED;
			else
				optObject.color = FlxColor.WHITE;

			optObject.updateHitbox();
		}
	}

	public function reloadBoyfriend()
	{
		var wasVisible:Bool = false;
		if(boyfriend != null) {
			wasVisible = boyfriend.visible;
			boyfriend.kill();
			remove(boyfriend);
			boyfriend.destroy();
		}

		boyfriend = new Character(840, 170, 'bf', true);
		boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.75));
		boyfriend.updateHitbox();
		boyfriend.dance();
		boyfriend.cameras = [camOptions];
		//boyfriend.antialiasing = changedAntialising;
		insert(1, boyfriend);
		boyfriend.visible = wasVisible;
	}
}
