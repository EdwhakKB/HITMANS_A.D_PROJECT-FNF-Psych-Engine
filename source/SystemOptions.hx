package;

import openfl.text.AntiAliasType;
import flixel.util.FlxColor;
import flixel.FlxG;
#if FEATURE_DISCORD
import Discord.DiscordClient;
#end
import OptionsMenu;
import ClientPrefs;
import flixel.input.gamepad.FlxGamepad;
#if FEATURE_FILESYSTEM
import sys.FileSystem;
#end
import Conductor;
import MusicBeatState;
import Main;
import HelperFunctions;
import Highscore;
import LoadingState;
import MainMenuState;
import StoryMenuState;
import flixel.graphics.FlxGraphic;
import Controls;
import openfl.Lib;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import lime.utils.Assets;
import flixel.graphics.FlxGraphic;

using StringTools;

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
		ClientPrefs.downScroll = !ClientPrefs.downScroll;
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
		return "Scroll Type: < " + (ClientPrefs.downScroll ? "Downscroll" : "Upscroll") + " >";
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
		ClientPrefs.controllerMode = !ClientPrefs.controllerMode;
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
		return "Controller Usage: < " + (ClientPrefs.controllerMode ? "Enabled" : "Disabled") + " >";
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
		ClientPrefs.middleScroll = !ClientPrefs.middleScroll;
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
		return "Middle Notes: < " + (ClientPrefs.middleScroll ? "Enabled" : "Disabled") + " >";
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
		ClientPrefs.opponentStrums = !ClientPrefs.opponentStrums;
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
		return "Opponent Notes: < " + (ClientPrefs.opponentStrums ? "Enabled" : "Disabled") + " >";
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
		ClientPrefs.casualMode = !ClientPrefs.casualMode;
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
		return "Casual Mode: < " + (ClientPrefs.casualMode ? "Enabled" : "Disabled") + " >";
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
		ClientPrefs.ghostTapping = !ClientPrefs.ghostTapping;
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
		return "Ghost Tapping: < " + (ClientPrefs.ghostTapping ? "Enabled" : "Disabled") + " >";
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
		ClientPrefs.noReset = !ClientPrefs.noReset;
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
		return "No Reset: < " + (ClientPrefs.noReset ? "Enabled" : "Disabled") + " >";
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
		ClientPrefs.hitsoundVolume += 0.1;

		if (ClientPrefs.hitsoundVolume > 1)
			ClientPrefs.hitsoundVolume = 1;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.hitsoundVolume -= 0.1;

		if (ClientPrefs.hitsoundVolume < 0)
			ClientPrefs.hitsoundVolume = 0;
		return true;
	}

	private override function updateDisplay():String
	{
		return "Hit Sound Volume: < " + HelperFunctions.truncateFloat(ClientPrefs.hitsoundVolume, 1) + " >";
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
		ClientPrefs.safeFrames += 0.1;

		if (ClientPrefs.safeFrames > 10)
			ClientPrefs.safeFrames = 10;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.safeFrames -= 0.1;

		if (ClientPrefs.safeFrames < 0.1)
			ClientPrefs.safeFrames = 0.1;
		return true;
	}

	private override function updateDisplay():String
	{
		return "Safe Frames: < " + ClientPrefs.safeFrames + " >";
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
		ClientPrefs.ratingOffset += 0.5;

		if (ClientPrefs.ratingOffset > 30)
			ClientPrefs.ratingOffset = 30;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.ratingOffset -= 0.5;

		if (ClientPrefs.ratingOffset < -30)
			ClientPrefs.ratingOffset = -30;
		return true;
	}

	private override function updateDisplay():String
	{
		return "Rating Offseted: < " + ClientPrefs.ratingOffset + " >";
	}
}

//Apperance
class HudStyleOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;

		switch (ClientPrefs.hudStyle)
		{
			case 'Classic':
				intMoved = 0;
			case 'HITMANS':
				intMoved = 1;
		}
	}

    var hudStyle = ['Classic', 'HITMANS'];
    var intMoved:Int = 0;
	override function right():Bool
	{
		intMoved += 1;

		if (intMoved > 1)
			intMoved = 1;

        ClientPrefs.hudStyle = hudStyle[intMoved]; 
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;
        ClientPrefs.hudStyle = hudStyle[intMoved]; 
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
        ClientPrefs.hideHud = !ClientPrefs.hideHud; 
		return true;
	}

	override function left():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Hidden Hud: < " + (ClientPrefs.hideHud ? "Enabled" : "Disabled")  + " >";
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
		switch (ClientPrefs.timeBarType)
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

        ClientPrefs.timeBarType = timeBar[intMoved]; 
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;
        ClientPrefs.timeBarType = timeBar[intMoved]; 
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
        ClientPrefs.flashing = !ClientPrefs.flashing; 
		return true;
	}

	override function left():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Flashing Lights: < " + (ClientPrefs.flashing ? "Enabled" : "Disabled")  + " >";
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
        ClientPrefs.camZooms = !ClientPrefs.camZooms; 
		return true;
	}

	override function left():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera Zooming: < " + (ClientPrefs.camZooms ? "Enabled" : "Disabled")  + " >";
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
        ClientPrefs.scoreZoom = !ClientPrefs.scoreZoom; 
		return true;
	}

	override function left():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Score Zoom On Text: < " + (ClientPrefs.scoreZoom ? "Enabled" : "Disabled")  + " >";
	}
}

class HealthBarVisibility extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

    private override function updateDisplay():String
	{
		return "Health Bar Transperancy: < " + HelperFunctions.truncateFloat(ClientPrefs.healthBarAlpha, 1) + '%' + " >";
	}

	override function right():Bool
	{
		ClientPrefs.healthBarAlpha += 0.1;

		if (ClientPrefs.healthBarAlpha > 1)
			ClientPrefs.healthBarAlpha = 1;
		return true;
	}

	override function left():Bool
	{
		ClientPrefs.healthBarAlpha -= 0.1;

		if (ClientPrefs.healthBarAlpha < 0)
			ClientPrefs.healthBarAlpha = 0;
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
		ClientPrefs.showFPS = !ClientPrefs.showFPS;
        if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
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
        return "FPS Counter: < " + (ClientPrefs.showFPS ? "Enabled" : "Disabled") + " >";
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
		switch (ClientPrefs.pauseMusic)
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

        ClientPrefs.pauseMusic = pauseMusic[intMoved]; 
		if(ClientPrefs.pauseMusic == 'None') FlxG.sound.music.volume = 0;
		else FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));
		return true;
	}

	override function left():Bool
	{
		intMoved -= 1;

		if (intMoved < 0)
			intMoved = 0;
        ClientPrefs.pauseMusic = pauseMusic[intMoved]; 
		if(ClientPrefs.pauseMusic == 'None') FlxG.sound.music.volume = 0;
		else FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));
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
		ClientPrefs.discordRPC = !ClientPrefs.discordRPC;
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
        return "Discord Rich: < " + (ClientPrefs.discordRPC ? "Enabled" : "Disabled") + " >";
    }
}

//Graphics
class LowQualityOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		description = desc;
	}

    public override function left():Bool
	{
		ClientPrefs.lowQuality = !ClientPrefs.lowQuality;
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
        return "Low Quality Graphics: < " + (ClientPrefs.lowQuality ? "Enabled" : "Disabled") + " >";
    }
}

class AntiAliasOption extends SystemOptions
{
    public function new(desc:String)
	{
		super();
		description = desc;
		showBoyfriend = true;
	}

    public override function left():Bool
	{
		ClientPrefs.globalAntialiasing = !ClientPrefs.globalAntialiasing;
		if (OptionsMenu.instance.boyfriend != null)
			OptionsMenu.instance.boyfriend.antialiasing = ClientPrefs.globalAntialiasing;
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
        return "Anti Aliasing: < " + (ClientPrefs.globalAntialiasing ? "Enabled" : "Disabled") + " >";
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
		return "Game Framerate: < " + ClientPrefs.framerate + " >";
	}

	override function right():Bool
	{
		#if html5
		return false;
		#end
		if (ClientPrefs.framerate >= 1000)
		{
			ClientPrefs.framerate = 1000;
		}
		else
			ClientPrefs.framerate++;
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
		return true;
	}

	override function left():Bool
	{
		#if html5
		return false;
		#end
		if (ClientPrefs.framerate > 900)
			ClientPrefs.framerate = 900;
		else if (ClientPrefs.framerate < 60)
			ClientPrefs.framerate = 60;
		else
			ClientPrefs.framerate--;
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
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
		description = desc;
	}

    public override function left():Bool
	{
		ClientPrefs.shaders = !ClientPrefs.shaders;
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
        return "Shaders: < " + (ClientPrefs.shaders ? "Enabled" : "Disabled") + " >";
    }
}

class HotkeysOption extends SystemOptions
{
	public function new(desc:String)
	{
		super();
		description = desc;
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

/*class UpKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gpupBind = text;
			else
				FlxG.save.data.upBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "UP: " + (waitingType ? "> " + FlxG.save.data.upBind + " <" : FlxG.save.data.upBind) + "";
	}
}

class DownKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gpdownBind = text;
			else
				FlxG.save.data.downBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "DOWN: " + (waitingType ? "> " + FlxG.save.data.downBind + " <" : FlxG.save.data.downBind) + "";
	}
}

class RightKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gprightBind = text;
			else
				FlxG.save.data.rightBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "RIGHT: " + (waitingType ? "> " + FlxG.save.data.rightBind + " <" : FlxG.save.data.rightBind) + "";
	}
}

class LeftKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gplefttBind = text;
			else
				FlxG.save.data.leftBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "LEFT: " + (waitingType ? "> " + FlxG.save.data.leftBind + " <" : FlxG.save.data.leftBind) + "";
	}
}

class PauseKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gppauseBind = text;
			else
				FlxG.save.data.pauseBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "PAUSE: " + (waitingType ? "> " + FlxG.save.data.pauseBind + " <" : FlxG.save.data.pauseBind) + "";
	}
}

class ResetBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gpresetBind = text;
			else
				FlxG.save.data.resetBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "RESET: " + (waitingType ? "> " + FlxG.save.data.resetBind + " <" : FlxG.save.data.resetBind) + "";
	}
}

class MuteBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.muteBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "VOLUME MUTE: " + (waitingType ? "> " + FlxG.save.data.muteBind + " <" : FlxG.save.data.muteBind) + "";
	}
}

class VolUpBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.volUpBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "VOLUME UP: " + (waitingType ? "> " + FlxG.save.data.volUpBind + " <" : FlxG.save.data.volUpBind) + "";
	}
}

class VolDownBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.volDownBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "VOLUME DOWN: " + (waitingType ? "> " + FlxG.save.data.volDownBind + " <" : FlxG.save.data.volDownBind) + "";
	}
}

class FullscreenBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.fullscreenBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		Debug.logTrace("keybind change");
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "FULLSCREEN:  " + (waitingType ? "> " + FlxG.save.data.fullscreenBind + " <" : FlxG.save.data.fullscreenBind) + "";
	}
}

class SwagMSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptValues = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.swagMs -= 0.1;
		if (FlxG.save.data.swagMs < 0)
			FlxG.save.data.swagMs = 0;
		FlxG.save.data.swagMs = HelperFunctions.truncateFloat(FlxG.save.data.swagMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.swagMs += 0.1;
		FlxG.save.data.swagMs = HelperFunctions.truncateFloat(FlxG.save.data.swagMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.swagMs = 22.5;
	}

	private override function updateDisplay():String
	{
		return "SWAG: < " + FlxG.save.data.swagMs + " ms >";
	}
}

class SickMSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptValues = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.sickMs -= 0.1;
		if (FlxG.save.data.sickMs < 0)
			FlxG.save.data.sickMs = 0;
		FlxG.save.data.sickMs = HelperFunctions.truncateFloat(FlxG.save.data.sickMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.sickMs += 0.1;
		FlxG.save.data.sickMs = HelperFunctions.truncateFloat(FlxG.save.data.sickMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.sickMs = 45;
	}

	private override function updateDisplay():String
	{
		return "SICK: < " + FlxG.save.data.sickMs + " ms >";
	}
}

class GoodMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptValues = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.goodMs -= 0.1;
		if (FlxG.save.data.goodMs < 0)
			FlxG.save.data.goodMs = 0;
		FlxG.save.data.goodMs = HelperFunctions.truncateFloat(FlxG.save.data.goodMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.goodMs += 0.1;
		FlxG.save.data.goodMs = HelperFunctions.truncateFloat(FlxG.save.data.goodMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.goodMs = 90;
	}

	private override function updateDisplay():String
	{
		return "GOOD: < " + FlxG.save.data.goodMs + " ms >";
	}
}

class BadMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptValues = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.badMs -= 0.1;
		if (FlxG.save.data.badMs < 0)
			FlxG.save.data.badMs = 0;
		FlxG.save.data.badMs = HelperFunctions.truncateFloat(FlxG.save.data.badMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.badMs += 0.1;
		FlxG.save.data.badMs = HelperFunctions.truncateFloat(FlxG.save.data.badMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.badMs = 135;
	}

	private override function updateDisplay():String
	{
		return "BAD: < " + FlxG.save.data.badMs + " ms >";
	}
}

class ShitMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptValues = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.shitMs -= 0.1;
		if (FlxG.save.data.shitMs < 0)
			FlxG.save.data.shitMs = 0;
		FlxG.save.data.shitMs = HelperFunctions.truncateFloat(FlxG.save.data.shitMs, 1);
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.shitMs = 180;
	}

	public override function right():Bool
	{
		FlxG.save.data.shitMs += 0.1;
		FlxG.save.data.shitMs = HelperFunctions.truncateFloat(FlxG.save.data.shitMs, 1);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "SHIT: < " + FlxG.save.data.shitMs + " ms >";
	}
}

class NoteCocks extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		FlxG.save.data.noteSplashes = !FlxG.save.data.noteSplashes;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Note Splashes: < " + (!FlxG.save.data.noteSplashes ? "off" : "on") + " >";
	}
}

class AutoSaveChart extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;

		FlxG.save.data.autoSaveChart = !FlxG.save.data.autoSaveChart;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Auto Saving Chart: < " + (!FlxG.save.data.autoSaveChart ? "off" : "on") + " >";
	}
}

class GPURendering extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		#if html5
		description = "This option is handled automaticly by browser.";
		#end
	}

	public override function left():Bool
	{
		#if !html5
		if (OptionsMenu.isInPause)
			return false;

		FlxG.save.data.gpuRender = !FlxG.save.data.gpuRender;
		display = updateDisplay();
		return true;
		#else
		return false;
		#end
	}

	public override function right():Bool
	{
		#if !html5
		if (OptionsMenu.isInPause)
			return false;
		left();
		return true;
		#else
		return false;
		#end
	}

	private override function updateDisplay():String
	{
		#if !html5
		return "GPU Rendering: < " + (!FlxG.save.data.gpuRender ? "off" : "on") + " >";
		#else
		return "GPU Rendering: < " + "Auto" + " >";
		#end
	}
}

class RoundAccuracy extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.roundAccuracy = !FlxG.save.data.roundAccuracy;

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
		return "Round Accuracy: < " + (FlxG.save.data.roundAccuracy ? "on" : "off") + " >";
	}
}

class CpuStrums extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.cpuStrums = !FlxG.save.data.cpuStrums;

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
		return "CPU Strums: < " + (FlxG.save.data.cpuStrums ? "Light up" : "Stay static") + " >";
	}
}

class GraphicLoading extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.cacheImages = !FlxG.save.data.cacheImages;

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "";
	}
}

class DownscrollOption extends Option
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
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
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
		return "Scroll: < " + (FlxG.save.data.downscroll ? "Downscroll" : "Upscroll") + " >";
	}
}

class GhostTapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.ghost = !FlxG.save.data.ghost;
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
		return "Ghost Tapping: < " + (FlxG.save.data.ghost ? "Enabled" : "Disabled") + " >";
	}
}

class AccuracyOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
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
		return "Accuracy Display < " + (!FlxG.save.data.accuracyDisplay ? "off" : "on") + " >";
	}
}

class SongPositionOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	public override function getValue():String
	{
		return "Song Position Bar: < " + (!FlxG.save.data.songPosition ? "off" : "on") + " >";
	}
}

class DistractionsAndEffectsOption extends Option
{
	var desc:String = '';

	public function new(desc:String)
	{
		super();
		this.desc = desc;
		setDesc(desc);
	}

	function setDesc(desc:String)
	{
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else if (!FlxG.save.data.background)
		{
			blocked = true;
			description = "BACKGROUNDS ARE DISABLED, OPTION DISABLED.";
		}
		else
		{
			blocked = false;
			description = desc;
		}
	}

	public override function updateBlocks()
	{
		setDesc(desc);
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause || !FlxG.save.data.background)
			return false;
		FlxG.save.data.distractions = !FlxG.save.data.distractions;
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
		return "Distractions: < " + (!FlxG.save.data.distractions ? "off" : "on") + " >";
	}
}

class Colour extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		if (!FlxG.save.data.healthBar)
			return false;
		FlxG.save.data.colour = !FlxG.save.data.colour;
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
		return "Colored HP Bars: < " + (FlxG.save.data.colour ? "Enabled" : "Disabled") + " >";
	}
}

class StepManiaOption extends Option
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
		FlxG.save.data.stepMania = !FlxG.save.data.stepMania;
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
		return "Color Quantization: < " + (!FlxG.save.data.stepMania ? "off" : "on") + " >";
	}
}

class ResetButtonOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
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
		return "Reset Button: < " + (!FlxG.save.data.resetButton ? "off" : "on") + " >";
	}
}

class InstantRespawn extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.InstantRespawn = !FlxG.save.data.InstantRespawn;
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
		return "Instant Respawn: < " + (!FlxG.save.data.InstantRespawn ? "off" : "on") + " >";
	}
}

class FlashingLightsOption extends Option
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
		FlxG.save.data.flashing = !FlxG.save.data.flashing;
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
		return "Flashing Lights: < " + (!FlxG.save.data.flashing ? "off" : "on") + " >";
	}
}

class AntialiasingOption extends Option
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
		FlxG.save.data.antialiasing = !FlxG.save.data.antialiasing;
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
		return "Antialiasing: < " + (!FlxG.save.data.antialiasing ? "off" : "on") + " >";
	}
}

class MissSoundsOption extends Option
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
		FlxG.save.data.missSounds = !FlxG.save.data.missSounds;
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
		return "Miss Sounds: < " + (!FlxG.save.data.missSounds ? "off" : "on") + " >";
	}
}

class ShowInput extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.inputShow = !FlxG.save.data.inputShow;
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
		return "Score Screen Debug: < " + (FlxG.save.data.inputShow ? "Enabled" : "Disabled") + " >";
	}
}

class Judgement extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
		acceptType = true;
	}

	public override function press():Bool
	{
		OptionsMenu.instance.selectedCatIndex = 6;
		OptionsMenu.instance.switchCat(OptionsMenu.instance.options[6], true);
		return true;
	}

	private override function updateDisplay():String
	{
		return "Edit Judgements";
	}
}

class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.fps = !FlxG.save.data.fps;

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
		return "FPS Counter: < " + (!FlxG.save.data.fps ? "off" : "on") + " >";
	}
}

class ScoreScreen extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.scoreScreen = !FlxG.save.data.scoreScreen;
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
		return "Score Screen: < " + (FlxG.save.data.scoreScreen ? "Enabled" : "Disabled") + " >";
	}
}

class FPSCapOption extends Option
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
		return "FPS Cap: < " + FlxG.save.data.fpsCap + " >";
	}

	override function right():Bool
	{
		#if html5
		return false;
		#end
		if (FlxG.save.data.fpsCap >= 900)
		{
			FlxG.save.data.fpsCap = 900;
			Main.gameContainer.setFPSCap(900);
		}
		else
			FlxG.save.data.fpsCap++;
		Main.gameContainer.setFPSCap(FlxG.save.data.fpsCap);

		return true;
	}

	override function left():Bool
	{
		#if html5
		return false;
		#end
		if (FlxG.save.data.fpsCap > 900)
			FlxG.save.data.fpsCap = 900;
		else if (FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = 60;
		else
			FlxG.save.data.fpsCap--;
		Main.gameContainer.setFPSCap(FlxG.save.data.fpsCap);
		return true;
	}

	override function getValue():String
	{
		return updateDisplay();
	}
}

class ScrollSpeedOption extends Option
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
		return "Scroll Speed: < " + HelperFunctions.truncateFloat(FlxG.save.data.scrollSpeed, 1) + " >";
	}

	override function right():Bool
	{
		FlxG.save.data.scrollSpeed += 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 6)
			FlxG.save.data.scrollSpeed = 6;
		return true;
	}

	override function getValue():String
	{
		return "Scroll Speed: < " + HelperFunctions.truncateFloat(FlxG.save.data.scrollSpeed, 1) + " >";
	}

	override function left():Bool
	{
		FlxG.save.data.scrollSpeed -= 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 6)
			FlxG.save.data.scrollSpeed = 6;

		return true;
	}
}

class RainbowFPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.fpsRain = !FlxG.save.data.fpsRain;
		Main.gameContainer.changeFPSColor(FlxColor.WHITE);
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Rainbow: < " + (!FlxG.save.data.fpsRain ? "off" : "on") + " >";
	}
}

class NPSDisplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.npsDisplay = !FlxG.save.data.npsDisplay;
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
		return "NPS Display: < " + (!FlxG.save.data.npsDisplay ? "off" : "on") + " >";
	}
}

class ReplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		// MusicBeatState.switchState(new LoadReplayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Load replays";
	}
}

class AccuracyDOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		FlxG.save.data.accuracyMod = FlxG.save.data.accuracyMod == 1 ? 0 : 1;
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
		return "Accuracy Mode: < " + (FlxG.save.data.accuracyMod == 0 ? "Accurate" : "Complex") + " >";
	}
}

class ScoreDOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			description = "This option cannot be toggled in the pause menu.";
			blocked = true;
		}
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (blocked)
			return false;
		FlxG.save.data.scoreMod = FlxG.save.data.scoreMod == 1 ? 0 : 1;
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
		return "Scoring Mode: < " + (FlxG.save.data.scoreMod == 0 ? "Simple" : "Complex") + " >";
	}
}

class CustomizeGameplay extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		acceptType = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		trace("switch");
		LoadingState.loadAndSwitchState(new GameplayCustomizeState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Customize Gameplay";
	}
}

class WatermarkOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		Main.watermarks = !Main.watermarks;
		FlxG.save.data.watermark = Main.watermarks;
		FlxG.sound.music.stop();
		if (!PlayState.inDaPlay)
		{
			FlxG.sound.playMusic(Paths.music(FlxG.save.data.watermark ? "ke_freakyMenu" : "freakyMenu"));
			MainMenuState.freakyPlaying = true;
		}
		Conductor.changeBPM(102);
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
		return "Watermarks: < " + (FlxG.save.data.watermark ? "on" : "off") + " >";
	}
}

class OffsetMenu extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");

		PlayState.SONG = Song.loadFromJson('tutorial', '');
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = 0;
		PlayState.storyWeek = 0;
		PlayState.offsetTesting = true;
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Time your offset";
	}
}

class DisplayMemory extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.memoryDisplay = !FlxG.save.data.memoryDisplay;
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
		return "Memory Display: < " + (!FlxG.save.data.memoryDisplay ? "off" : "on") + " >";
	}
}

class OffsetThing extends Option
{
	public function new(desc:String)
	{
		super();
		acceptValues = true;
		if (OptionsMenu.isInPause)
			description = desc + " (RESTART REQUIRED)";
		else
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.offset--;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.offset++;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Visual offset: < " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 0) + " >";
	}

	public override function getValue():String
	{
		return "Visual offset: < " + HelperFunctions.truncateFloat(FlxG.save.data.offset, 0) + " >";
	}
}

class BotPlay extends Option
{
	public function new(desc:String)
	{
		super();
		if (PlayState.isStoryMode)
			description = 'BOTPLAY is disabled on Story Mode.'
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (PlayState.isStoryMode)
			return false;
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
		trace('BotPlay : ' + FlxG.save.data.botplay);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
		return "BotPlay: < " + (FlxG.save.data.botplay ? "on" : "off") + " >";
}

class CamZoomOption extends Option
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
		FlxG.save.data.camzoom = !FlxG.save.data.camzoom;
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
		return "Camera Zoom: < " + (!FlxG.save.data.camzoom ? "off" : "on") + " >";
	}
}

class JudgementCounter extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.judgementCounter = !FlxG.save.data.judgementCounter;
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
		return "Judgement Counter: < " + (FlxG.save.data.judgementCounter ? "Enabled" : "Disabled") + " >";
	}
}

class MiddleScrollOption extends Option
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
		FlxG.save.data.middleScroll = !FlxG.save.data.middleScroll;
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
		return "Middle Scroll: < " + (FlxG.save.data.middleScroll ? "Enabled" : "Disabled") + " >";
	}
}

class HitSoundOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.hitSound--;
		if (FlxG.save.data.hitSound < 0)
			FlxG.save.data.hitSound = HitSounds.getSound().length - 1;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.hitSound++;
		if (FlxG.save.data.hitSound > HitSounds.getSound().length - 1)
			FlxG.save.data.hitSound = 0;
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Hitsound Style: < " + HitSounds.getSoundByID(FlxG.save.data.hitSound) + " >";
	}
}

class HitSoundVolume extends Option
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
		return "Hitsound Volume: < " + HelperFunctions.truncateFloat(FlxG.save.data.hitVolume, 1) + " >";
	}

	override function right():Bool
	{
		FlxG.save.data.hitVolume += 0.1;

		if (FlxG.save.data.hitVolume < 0)
			FlxG.save.data.hitVolume = 0;

		if (FlxG.save.data.hitVolume > 1)
			FlxG.save.data.hitVolume = 1;
		return true;
	}

	override function getValue():String
	{
		return "Hitsound Volume: < " + HelperFunctions.truncateFloat(FlxG.save.data.hitVolume, 1) + " >";
	}

	override function left():Bool
	{
		FlxG.save.data.hitVolume -= 0.1;

		if (FlxG.save.data.hitVolume < 0)
			FlxG.save.data.hitVolume = 0;

		if (FlxG.save.data.hitVolume > 1)
			FlxG.save.data.hitVolume = 1;

		return true;
	}
}

class HitErrorBarOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (blocked)
			return false;
		FlxG.save.data.hitErrorBar = !FlxG.save.data.hitErrorBar;
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
		return "Hit Error Bar: < " + (FlxG.save.data.hitErrorBar ? "Enabled" : "Disabled") + " >";
	}
}

class Background extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		FlxG.save.data.background = !FlxG.save.data.background;
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
		return "Background Stage: < " + (FlxG.save.data.background ? "Enabled" : "Disabled") + " >";
	}
}

class CharacterOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		FlxG.save.data.characters = !FlxG.save.data.characters;
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
		return "Display Characters: < " + (FlxG.save.data.characters ? "Enabled" : "Disabled") + " >";
	}
}

#if FEATURE_DISCORD
class DiscordOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.discordMode--;
		if (FlxG.save.data.discordMode < 0)
			FlxG.save.data.discordMode = DiscordClient.getRCPmode().length - 1;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.discordMode++;
		if (FlxG.save.data.discordMode > DiscordClient.getRCPmode().length - 1)
			FlxG.save.data.discordMode = 0;
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Discord RCP mode: < " + DiscordClient.getRCPmodeByID(FlxG.save.data.discordMode) + " >";
	}
}
#end

class NoteskinOption extends Option
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
		FlxG.save.data.noteskin--;
		if (FlxG.save.data.noteskin < 0)
			FlxG.save.data.noteskin = NoteskinHelpers.getNoteskins().length - 1;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.noteskin++;
		if (FlxG.save.data.noteskin > NoteskinHelpers.getNoteskins().length - 1)
			FlxG.save.data.noteskin = 0;
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Current Noteskin: < " + NoteskinHelpers.getNoteskinByID(FlxG.save.data.noteskin) + " >";
	}
}

class HealthBarOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.healthBar = !FlxG.save.data.healthBar;
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
		return "Health Bar: < " + (FlxG.save.data.healthBar ? "Enabled" : "Disabled") + " >";
	}
}

class LaneUnderlayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	private override function updateDisplay():String
	{
		return "Lane Transparceny: < " + HelperFunctions.truncateFloat(FlxG.save.data.laneTransparency, 1) + " >";
	}

	override function right():Bool
	{
		FlxG.save.data.laneTransparency += 0.1;

		if (FlxG.save.data.laneTransparency > 1)
			FlxG.save.data.laneTransparency = 1;
		return true;
	}

	override function left():Bool
	{
		FlxG.save.data.laneTransparency -= 0.1;

		if (FlxG.save.data.laneTransparency < 0)
			FlxG.save.data.laneTransparency = 0;

		return true;
	}
}

class ScrollAlpha extends Option
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
		return ("Scroll Alpha");
	}

	override function right():Bool
	{
		FlxG.save.data.alpha += 0.1;

		if (FlxG.save.data.alpha < 0.3)
			FlxG.save.data.alpha = 0.3;

		if (FlxG.save.data.alpha > 1)
			FlxG.save.data.alpha = 1;
		return true;
	}

	override function getValue():String
	{
		return "Hold note Transparency: < " + HelperFunctions.truncateFloat(FlxG.save.data.alpha, 1) + " >";
	}

	override function left():Bool
	{
		FlxG.save.data.alpha -= 0.1;

		if (FlxG.save.data.alpha < 0.3)
			FlxG.save.data.alpha = 0.3;

		if (FlxG.save.data.alpha > 1)
			FlxG.save.data.alpha = 1;

		return true;
	}
}

class ScoreSmoothing extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.lerpScore = !FlxG.save.data.lerpScore;

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
		return "Smooth Score PopUp: < " + (FlxG.save.data.lerpScore ? "on" : "off") + " >";
	}
}


class HitSoundMode extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.strumHit = !FlxG.save.data.strumHit;

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
		return "Hitsound Mode: < " + (FlxG.save.data.strumHit ? "On Key Hit" : "On Note Hit") + " >";
	}
}

class Shader extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;

		FlxG.save.data.shaders = !FlxG.save.data.shaders;

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
		return "Shaders: < " + (FlxG.save.data.shaders ? "On" : "Off") + " >";
	}
}

class DebugMode extends Option
{
	public function new(desc:String)
	{
		description = desc;
		super();
	}

	public override function press():Bool
	{
		MusicBeatState.switchState(new AnimationDebug());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Animation Debug";
	}
}

class LockWeeksOption extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		acceptType = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}
		FlxG.save.data.weekUnlocked = 1;
		StoryMenuState.weekUnlocked = [true, true];
		confirm = false;
		trace('Weeks Locked');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Story Reset" : "Reset Story Progress";
	}
}

class ResetModifiersOption extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		acceptType = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}

		KadeEngineData.resetModifiers();
		confirm = false;
		trace('Modifiers went brrrr');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Modifiers reset" : "Reset Modifiers";
	}
}

class ResetScoreOption extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		acceptType = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}
		FlxG.save.data.songScores = null;
		for (key in Highscore.songScores.keys())
		{
			Highscore.songScores[key] = 0;
		}
		FlxG.save.data.songCombos = null;
		for (key in Highscore.songCombos.keys())
		{
			Highscore.songCombos[key] = '';
		}
		FlxG.save.data.songAcc = null;
		for (key in Highscore.songAcc.keys())
		{
			Highscore.songAcc[key] = 0.00;
		}
		confirm = false;
		trace('Highscores Wiped');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Score Reset" : "Reset Score";
	}
}

class ResetSettings extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		acceptType = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}
		FlxG.save.data.weekUnlocked = null;
		FlxG.save.data.background = null;
		FlxG.save.data.newInput = null;
		FlxG.save.data.downscroll = null;
		FlxG.save.data.antialiasing = null;
		FlxG.save.data.missSounds = null;
		FlxG.save.data.dfjk = null;
		FlxG.save.data.accuracyDisplay = null;
		FlxG.save.data.offset = null;
		FlxG.save.data.songPosition = null;
		FlxG.save.data.fps = null;
		FlxG.save.data.changedHit = null;
		FlxG.save.data.fpsRain = null;
		FlxG.save.data.fpsCap = null;
		FlxG.save.data.scrollSpeed = null;
		FlxG.save.data.npsDisplay = null;
		FlxG.save.data.frames = null;
		FlxG.save.data.accuracyMod = null;
		FlxG.save.data.watermark = null;
		FlxG.save.data.ghost = null;
		FlxG.save.data.distractions = null;
		FlxG.save.data.colour = null;
		FlxG.save.data.stepMania = null;
		FlxG.save.data.flashing = null;
		FlxG.save.data.resetButton = null;
		FlxG.save.data.botplay = null;
		FlxG.save.data.roundAccuracy = null;
		FlxG.save.data.cpuStrums = null;
		FlxG.save.data.strumline = null;
		FlxG.save.data.customStrumLine = null;
		FlxG.save.data.camzoom = null;
		FlxG.save.data.scoreScreen = null;
		FlxG.save.data.inputShow = null;
		FlxG.save.data.characters = null;
		FlxG.save.data.cacheImages = null;
		FlxG.save.data.editor = null;
		FlxG.save.data.laneTransparency = 0;
		FlxG.save.data.middleScroll = null;
		FlxG.save.data.healthBar = null;
		FlxG.save.data.instantRespawn = null;
		FlxG.save.data.memoryDisplay = null;
		FlxG.save.data.noteskin = null;
		FlxG.save.data.lerpScore = null;
		FlxG.save.data.hitSound = null;
		FlxG.save.data.hitVolume = null;
		FlxG.save.data.strumHit = null;
		FlxG.save.data.volume = null;
		FlxG.save.data.mute = null;
		FlxG.save.data.showCombo = null;
		FlxG.save.data.showComboNum = null;
		FlxG.save.data.changedHitX = null;
		FlxG.save.data.changedHitY = null;

		FlxG.save.data.strumOffsets = null;

		KadeEngineData.initSave();
		confirm = false;
		trace('All settings have been reset');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Settings Reset" : "Reset Settings";
	}
}

class ClearLogFolder extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		acceptType = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}

		Debug.clearLogsFolder();
		confirm = false;

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Delete Logs Files" : "Clear Logs Folder";
	}
}

class ClearCrashDumpFolder extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		{
			blocked = true;
			description = pauseDesc;
		}
		else
			description = desc;

		acceptType = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}

		#if FEATURE_FILESYSTEM
		if (FileSystem.exists("./crash/"))
		{
			var files = FileSystem.readDirectory("./crash/");
			for (file in files)
				FileSystem.deleteFile('./crash/$file');
		}
		#end

		confirm = false;

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Delete Crash Dumps" : "Clear Crash Folder";
	}
}*/