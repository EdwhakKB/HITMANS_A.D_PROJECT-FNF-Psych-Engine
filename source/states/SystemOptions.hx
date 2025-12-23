package states;

import openfl.text.AntiAliasType;
import states.OptionsMenu;
import engine.ClientPrefs.data;
import flixel.input.gamepad.FlxGamepad;
import engine.Conductor;
import states.MusicBeatState;
import Main;
import states.LoadingState;
import states.menus.MainMenuState;
import states.menus.StoryMenuState;
import flixel.graphics.FlxGraphic;
import play.Controls;
import openfl.Lib;

import flixel.graphics.FlxGraphic;

class SystemOptions
{
	public function new()
	{
		display = updateDisplay();
		showBoyfriend = false;
	}

	var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

	private var description:String = "";

	private var display:String;
	private var acceptValues:Bool = false;

	public static var valuechanged:Bool = false;

	public var changedMusic:Bool = false;

	public var showBoyfriend:Bool = false;

	public var acceptType:Bool = false;

	public var waitingType:Bool = false;

	public var blocked:Bool = false;

	public var pauseDesc:String = "This option cannot be toggled in the pause menu.";

	// Vars for Option Menu don't modify.
	public var targetY:Int = 0;

	public var connectedText:OptionText = null;

	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	public function getValue():String
	{
		return updateDisplay();
	}

	public function onType(text:String)
	{
	}

	// Returns whether the label is to be updated.
	public function press():Bool
	{
		return true;
	}

	private function updateDisplay():String
	{
		return "";
	}

	public function left():Bool
	{
		return false;
	}

	public function updateBlocks()
	{
	}

	public function right():Bool
	{
		return false;
	}
}

//Gameplay Settings
class DownscrollOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.data.downScroll = !ClientPrefs.data.downScroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Scroll Type: < " + (ClientPrefs.data.downScroll ? "Downscroll" : "Upscroll") + " >";
	}
}

class ControllerModeOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		Controls.instance.controllerMode = !Controls.instance.controllerMode;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Controller Usage: < " + (Controls.instance.controllerMode ? "Enabled" : "Disabled") + " >";
	}
}

class MiddleScrollOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.data.middleScroll = !ClientPrefs.data.middleScroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Middle Notes: < " + (ClientPrefs.data.middleScroll ? "Enabled" : "Disabled") + " >";
	}
}

class OpponentNotesOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.data.opponentStrums = !ClientPrefs.data.opponentStrums;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Opponent Notes: < " + (ClientPrefs.data.opponentStrums ? "Enabled" : "Disabled") + " >";
	}
}

class CasualModeOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.data.casualMode = !ClientPrefs.data.casualMode;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Casual Mode: < " + (ClientPrefs.data.casualMode ? "Enabled" : "Disabled") + " >";
	}
}

class GhostTappingOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.data.ghostTapping = !ClientPrefs.data.ghostTapping;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Ghost Tapping: < " + (ClientPrefs.data.ghostTapping ? "Enabled" : "Disabled") + " >";
	}
}

class DisableResetOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.data.noReset = !ClientPrefs.data.noReset;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "No Reset: < " + (ClientPrefs.data.noReset ? "Enabled" : "Disabled") + " >";
	}
}

class HitsoundVolumeOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
		ClientPrefs.data.hitsoundVolume += 0.1;

		if (ClientPrefs.data.hitsoundVolume > 1)
			ClientPrefs.data.hitsoundVolume = 1;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.data.hitsoundVolume -= 0.1;

		if (ClientPrefs.data.hitsoundVolume < 0)
			ClientPrefs.data.hitsoundVolume = 0;
		return true;
	}

	private override function updateDisplay():String
	{
		return "Hit Sound Volume: < " + (HelperFunctions.truncateFloat(ClientPrefs.data.hitsoundVolume, 1)*100) + '%' + " >";
	}
}

class SafeFramesOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
		ClientPrefs.data.safeFrames += 0.1;

		if (ClientPrefs.data.safeFrames > 10)
			ClientPrefs.data.safeFrames = 10;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.data.safeFrames -= 0.1;

		if (ClientPrefs.data.safeFrames < 0.1)
			ClientPrefs.data.safeFrames = 0.1;
		return true;
	}

	private override function updateDisplay():String
	{
		return "Safe Frames: < " + ClientPrefs.data.safeFrames + " >";
	}
}

class RatingOffsetOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
		ClientPrefs.data.ratingOffset += 0.5;

		if (ClientPrefs.data.ratingOffset > 30)
			ClientPrefs.data.ratingOffset = 30;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.data.ratingOffset -= 0.5;

		if (ClientPrefs.data.ratingOffset < -30)
			ClientPrefs.data.ratingOffset = -30;
		return true;
	}

	private override function updateDisplay():String
	{
		return "Rating Offseted: < " + ClientPrefs.data.ratingOffset + " >";
	}
}

//Apperance
class HudStyleOption extends SystemOptions
{
	var intMoved:Int = 0;
	var hudStyle = ['Classic', 'HITMANS'];
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;

		if (ClientPrefs.data.hudStyle.toLowerCase() == 'classic')
			intMoved = 0;
		else
			intMoved = 1;
	}

	override function right():Bool
	{
		intMoved += 1;

		if (intMoved > 1)
			intMoved = 1;

        ClientPrefs.data.hudStyle = hudStyle[intMoved]; 
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;
        ClientPrefs.data.hudStyle = hudStyle[intMoved]; 
		return true;
	}

	private override function updateDisplay():String
	{
		return "Hud Style: < " + hudStyle[intMoved]  + " >";
	}
}

class HideHudOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
        ClientPrefs.data.hideHud = !ClientPrefs.data.hideHud; 
		return true;
	}

	override function left():Bool
	{
		right();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Hidden Hud: < " + (ClientPrefs.data.hideHud ? "Enabled" : "Disabled")  + " >";
	}
}

class TimeBarOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
		switch (ClientPrefs.data.timeBarType)
		{
			case 'Time Left':
				intMoved = 0;
			case 'Time Elapsed':
				intMoved = 1;
			case 'Song Name':
				intMoved = 2;
			case 'Disabled':
				intMoved = 3;
		}
	}

    var timeBar = ['Time Left', 'Time Elapsed', 'Song Name', 'Disabled'];
    var intMoved:Int = 0;
	override function right():Bool
	{
		intMoved += 1;

		if (intMoved > 3)
			intMoved = 3;

        ClientPrefs.data.timeBarType = timeBar[intMoved]; 
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;
        ClientPrefs.data.timeBarType = timeBar[intMoved]; 
		return true;
	}

	private override function updateDisplay():String
	{
		return "Time Bar Type: < " + timeBar[intMoved]  + " >";
	}
}

class FlashingLightsOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
        ClientPrefs.data.flashing = !ClientPrefs.data.flashing; 
		return true;
	}

	override function left():Bool
	{
		right();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Flashing Lights: < " + (ClientPrefs.data.flashing ? "Enabled" : "Disabled")  + " >";
	}
}

class CamZoomOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
        ClientPrefs.data.camZooms = !ClientPrefs.data.camZooms; 
		return true;
	}

	override function left():Bool
	{
		right();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera Zooming: < " + (ClientPrefs.data.camZooms ? "Enabled" : "Disabled")  + " >";
	}
}

class ScoreZoomOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
        ClientPrefs.data.scoreZoom = !ClientPrefs.data.scoreZoom; 
		return true;
	}

	override function left():Bool
	{
		right();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Score Zoom On Text: < " + (ClientPrefs.data.scoreZoom ? "Enabled" : "Disabled")  + " >";
	}
}

class HealthBarVisibility extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
		acceptValues = true;
	}

    private override function updateDisplay():String
	{
		return "Health Bar Transperancy: < " + (HelperFunctions.truncateFloat(ClientPrefs.data.healthBarAlpha, 1)*100) + '%' + " >";
	}

	override function right():Bool
	{
		ClientPrefs.data.healthBarAlpha += 0.1;

		if (ClientPrefs.data.healthBarAlpha > 1)
			ClientPrefs.data.healthBarAlpha = 1;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.data.healthBarAlpha -= 0.1;

		if (ClientPrefs.data.healthBarAlpha < 0)
			ClientPrefs.data.healthBarAlpha = 0;
		return true;
	}
}

class FPSOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		description = desc;
	}

    public override function left():Bool
	{
		ClientPrefs.data.showFPS = !ClientPrefs.data.showFPS;
        if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

    private override function updateDisplay():String
    {
        return "FPS Counter: < " + (ClientPrefs.data.showFPS ? "Enabled" : "Disabled") + " >";
    }
}

class PauseMusicOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
		changedMusic = true;
		switch (ClientPrefs.data.pauseMusic)
		{
			case 'None':
				intMoved = 0;
			case 'Breakfast':
				intMoved = 1;
			case 'Tea Time':
				intMoved = 2;
			case 'Relaxing':
				intMoved = 3;
			case 'Bloodstained':
				intMoved = 4;
		}
	}

    var pauseMusic = ['None', 'Breakfast', 'Tea Time', 'Relaxing', 'Bloodstained'];
    var intMoved:Int = 0;
	override function right():Bool
	{
		intMoved += 1;

		if (intMoved > 4)
			intMoved = 4;

        ClientPrefs.data.pauseMusic = pauseMusic[intMoved]; 
		if(ClientPrefs.data.pauseMusic == 'None') FlxG.sound.music.volume = 0;
		else FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;
        ClientPrefs.data.pauseMusic = pauseMusic[intMoved]; 
		if(ClientPrefs.data.pauseMusic == 'None') FlxG.sound.music.volume = 0;
		else FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));
		return true;
	}

	private override function updateDisplay():String
	{
		return "Pause Screen Music: < " + pauseMusic[intMoved]  + " >";
	}
}

class DiscordRichOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		description = desc;
	}

    public override function left():Bool
	{
		ClientPrefs.data.discordRPC = !ClientPrefs.data.discordRPC;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

    private override function updateDisplay():String
    {
        return "Discord Rich: < " + (ClientPrefs.data.discordRPC ? "Enabled" : "Disabled") + " >";
    }
}

//Graphics
class LowQualityOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

    public override function left():Bool
	{
		ClientPrefs.data.lowQuality = !ClientPrefs.data.lowQuality;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

    private override function updateDisplay():String
    {
        return "Low Quality Graphics: < " + (ClientPrefs.data.lowQuality ? "Enabled" : "Disabled") + " >";
    }
}

class AntiAliasOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
		showBoyfriend = true;
	}

    public override function left():Bool
	{
		ClientPrefs.data.antialiasing = !ClientPrefs.data.antialiasing;
		if (OptionsMenu.boyfriend != null)
			OptionsMenu.boyfriend.antialiasing = ClientPrefs.data.antialiasing;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

    private override function updateDisplay():String
    {
        return "Anti Aliasing: < " + (ClientPrefs.data.antialiasing ? "Enabled" : "Disabled") + " >";
    }
}

class Framerate extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Game Framerate: < " + ClientPrefs.data.framerate + " >";
	}

	override function right():Bool
	{
		#if html5
		return false;
		#end
		if (ClientPrefs.data.framerate >= 1000)
		{
			ClientPrefs.data.framerate = 1000;
		}
		else
			ClientPrefs.data.framerate++;
		if(ClientPrefs.data.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.data.framerate;
			FlxG.drawFramerate = ClientPrefs.data.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.data.framerate;
			FlxG.updateFramerate = ClientPrefs.data.framerate;
		}
		return true;
	}

	override function left():Bool
	{
		#if html5
		return false;
		#end
		if (ClientPrefs.data.framerate > 900)
			ClientPrefs.data.framerate = 900;
		else if (ClientPrefs.data.framerate < 60)
			ClientPrefs.data.framerate = 60;
		else
			ClientPrefs.data.framerate--;
		if(ClientPrefs.data.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.data.framerate;
			FlxG.drawFramerate = ClientPrefs.data.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.data.framerate;
			FlxG.updateFramerate = ClientPrefs.data.framerate;
		}
		return true;
	}

	override function getValue():String
	{
		return updateDisplay();
	}
}

class ShadersOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

    public override function left():Bool
	{
		ClientPrefs.data.shaders = !ClientPrefs.data.shaders;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

    private override function updateDisplay():String
    {
        return "Shaders: < " + (ClientPrefs.data.shaders ? "Enabled" : "Disabled") + " >";
    }
}

class HotkeysOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause){
			blocked = true;
			description = desc + "(NOT WORKING IN PAUSE MENU";
		}else{
			blocked = false;
			description = desc;
		}
		acceptType = true;
	}

	public override function press():Bool
	{
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new options.ControlsSubState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Edit Keybindings";
	}
}

class NoteOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause){
			blocked = true;
			description = desc + "(NOT WORKING IN PAUSE MENU";
		}else{
			blocked = false;
			description = desc;
		}
		acceptType = true;
	}

	public override function press():Bool
	{
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new options.NotesSubState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Note Options";
	}
}

class HurtOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause){
			blocked = true;
			description = desc + "(NOT WORKING IN PAUSE MENU";
		}else{
			blocked = false;
			description = desc;
		}
		acceptType = true;
	}

	public override function press():Bool
	{
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new options.HurtsSubState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Hurt Options";
	}
}

class QuantOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause){
			blocked = true;
			description = desc + "(NOT WORKING IN PAUSE MENU";
		}else{
			blocked = false;
			description = desc;
		}
		acceptType = true;
	}

	public override function press():Bool
	{
		FlxG.state.closeSubState();
		FlxG.state.openSubState(new options.QuantSubState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Quantize Options";
	}
}

class QuantizationOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

    public override function left():Bool
	{
		ClientPrefs.data.quantization = !ClientPrefs.data.quantization;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

    private override function updateDisplay():String
    {
        return "Allow Quantize: < " + (ClientPrefs.data.quantization ? "Enabled" : "Disabled") + " >";
    }
}

class MineSkin extends SystemOptions
{
	var mineSkins = ['HITMANS', 'FNF', 'INHUMAN', 'STEPMANIA', 'NOTITG', 'ITHIT'];
    var intMoved:Int = 0;
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
		switch (FlxG.save.data.mineSkin)
		{
			case 'HITMANS':
				intMoved = 0;
			case 'FNF':
				intMoved = 1;
			case 'INHUMAN':
				intMoved = 2;
			case 'STEPMANIA':
				intMoved = 3;
			case 'NOTITG':
				intMoved = 4;
			case 'ITHIT':
				intMoved = 5;
		}
	}
	override function right():Bool
	{
		intMoved += 1;

		if (intMoved > 5)
			intMoved = 5;

        ClientPrefs.data.mineSkin = mineSkins[intMoved]; 
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;

        ClientPrefs.data.mineSkin = mineSkins[intMoved]; 
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mine Note Skin: < " + mineSkins[intMoved]  + " >";
	}
}

class MimicNoteOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	override function right():Bool
	{
		ClientPrefs.data.mimicNoteAlpha += 0.1;

		if (ClientPrefs.data.mimicNoteAlpha > 0.7)
			ClientPrefs.data.mimicNoteAlpha = 0.7;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.data.mimicNoteAlpha -= 0.1;

		if (ClientPrefs.data.mimicNoteAlpha < 0.3)
			ClientPrefs.data.mimicNoteAlpha = 0.3;
		return true;
	}

	private override function updateDisplay():String
	{
		return "Mimic Note Alpha: < " + (HelperFunctions.truncateFloat(ClientPrefs.data.mimicNoteAlpha, 1)*100) + '%' + " >";
	}
}

class HoldSkin extends SystemOptions
{
	var holdSkins = ['NONE', 'HEXAGONIC', 'CLASSIC', 'CIRCLE', 'STEPMANIA', 'TRIANGLE', 'INHUMAN'];
    var intMoved:Int = 0;
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
		switch (FlxG.save.data.notesSkin[2])
		{
			case 'NONE':
				intMoved = 0;
			case 'HEXAGONIC':
				intMoved = 1;
			case 'CLASSIC':
				intMoved = 2;
			case 'CIRCLE':
				intMoved = 3;
			case 'STEPMANIA':
				intMoved = 4;
			case 'TRIANGLE':
				intMoved = 5;
			case 'INHUMAN':
				intMoved = 6;
		}
	}
	override function right():Bool
	{
		intMoved += 1;

		if (intMoved > 5)
			intMoved = 5;

        ClientPrefs.data.notesSkin[2] = holdSkins[intMoved]; 
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;

		ClientPrefs.data.notesSkin[2] = holdSkins[intMoved]; 
		return true;
	}

	private override function updateDisplay():String
	{
		return "Hold Note Skin: < " + holdSkins[intMoved]  + " >";
	}
}