package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
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
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Note Options', 'KeyBinds', 'Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay'];
	private var grpOptions:FlxTypedGroup<FlxText>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	public static var isInPause = false;

    public function new(pauseMenu:Bool = false)
    {
        super();

        isInPause = pauseMenu;
    }

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Note Options':
				FlxTransitionableState.skipNextTransOut = true;
				FlxTransitionableState.skipNextTransIn = true;
				MusicBeatState.switchState(new options.NoteOptionsState());
			case 'KeyBinds':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Delay and Combo':
				LoadingState.loadAndSwitchState(new options.NoteOffsetState());
		}
	}

	var selectorLeft:FlxText;
	var selectorRight:FlxText;

	override function create() {
		#if desktop
		DiscordClient.changePresence("System - Options", null);
		#end

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.fromString('#403736'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		//bg.blend = MULTIPLY;
		add(bg);

		var fg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('MenuShit/Options'));
		fg.updateHitbox();
		fg.screenCenter();
		fg.antialiasing = ClientPrefs.globalAntialiasing;
		fg.scale.set(1.2, 1.2);
		add(fg);
		
		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:FlxText = new FlxText(0, 0, FlxG.width, options[i], 70);
			optionText.setFormat(Paths.font("kremlin.ttf"), 70, 0xffffffff, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			// optionText.screenCenter(XY);
			optionText.borderSize = 4;
			optionText.ID = i;
			optionText.y = (FlxG.height / 2) - (35 * options.length) + 70 * i;
			optionText.x = (FlxG.width / 2) - (FlxG.width / 4) - 255;
			optionText.size = 26;
			grpOptions.add(optionText);
		}

		selectorLeft = new FlxText(0, 0,FlxG.width ,'>', 70);
		selectorLeft.setFormat(Paths.font("kremlin.ttf"), 70, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		selectorLeft.borderSize = 4;
		add(selectorLeft);

		selectorRight = new FlxText(0, 0,FlxG.width ,'<',70);
		selectorRight.setFormat(Paths.font("kremlin.ttf"), 70, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		selectorRight.borderSize = 4;
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            if (!isInPause)
                MusicBeatState.switchState(new MainMenuState());
            else
            {
                PauseSubState.goToOptions = false;
				editors.EditorPauseSubState.goToOptions = false;
                LoadingState.loadAndSwitchState(new PlayState());
            }
        }

		if (controls.ACCEPT) {
			openSelectedSubstate(options[curSelected]);
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		grpOptions.forEach(function(item:FlxText)
		{
			item.alpha = 0.6;
			if (item.ID == curSelected){
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		});
		// for (item in grpOptions.members) {
		// 	item.y = bullShit - (curSelected);
		// 	bullShit++;

		// 	item.alpha = 0.6;
		// 	if (item.y == 0) {
		// 		item.alpha = 1;
		// 		selectorLeft.x = item.x - 63;
		// 		selectorLeft.y = item.y;
		// 		selectorRight.x = item.x + item.width + 15;
		// 		selectorRight.y = item.y;
		// 	}
		// }
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}