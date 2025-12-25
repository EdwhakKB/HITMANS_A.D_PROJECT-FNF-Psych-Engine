package engine;

import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;

@:structInit 
@:publicFields
class SaveVariables {
	var downScroll:Bool = false;
	var middleScroll:Bool = false;
	var opponentStrums:Bool = true;
	var casualMode:Bool = false;
	var showFPS:Bool = true;
	var flashing:Bool = true;
	var antialiasing:Bool = true;
	var mimicNoteAlpha:Float = 0.6;
	var hudStyle:String = 'HITMANS';
	var mineSkin:String = 'HITMANS';
	var customHudName:String = 'FNF';
    var healthBarStyle:String = 'healthBar';
    var countDownStyle:Array<String> = ["get", "ready", "set", "go"];
    var countDownSounds:Array<String> = ["intro3", "intro2", "intro1", "introGo"];
    var ratingStyle:Array<Dynamic> = ["", null];
    var memoryDisplay:Bool = true;
	var notesSkin:Array<String> = ['HITMANS', 'MIMIC', 'NONE']; //notes, hurts, holds
	var userName:String = '';
	var isLogged:Bool = false;
	var quantization:Bool = false;
	var goStyle:String = 'NEW';
	var lowQuality:Bool = false;
	var shaders:Bool = true;
	var framerate:Int = 60;
	var cursing:Bool = true;
	var violence:Bool = true;
	var camZooms:Bool = true;
	var schmovin:Bool = false;
	var hideHud:Bool = false;
	var noteOffset:Int = 0;
	var arrowRGB:Array<Array<FlxColor>> = [
		[0xFFC24B99, 0xFFFFFFFF, 0xFF3C1F56],
		[0xFF00FFFF, 0xFFFFFFFF, 0xFF1542B7],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFFF9393F, 0xFFFFFFFF, 0xFF651038]
	];
	var arrowRGBPixel:Array<Array<FlxColor>> = [
		[0xFFE276FF, 0xFFFFF9FF, 0xFF60008D],
		[0xFF3DCAFF, 0xFFF4FFFF, 0xFF003060],
		[0xFF71E300, 0xFFF6FFE6, 0xFF003100],
		[0xFFFF884E, 0xFFFFFAF5, 0xFF6C0000]
	];
	var arrowRGBQuantize:Array<Array<FlxColor>> = [
		[0xFFFF0000, 0xFFFFFFFF, 0xFF7F0000],
		[0xFF0000FF, 0xFFFFFFFF, 0xFF00007F],
		[0xFF800080, 0xFFFFFFFF, 0xFF400040],
		[0xFF00FF00, 0xFFFFFFFF, 0xFF007F00],
		[0xFFFFFF00, 0xFFFFFFFF, 0xFF7F7F00],
		[0xFF00FFDD, 0xFFFFFFFF, 0xFF018573],
		[0xFFFF00FF, 0xFFFFFFFF, 0xFF8A018A],
		[0xFFFF7300, 0xFFFFFFFF, 0xFF883D00]
	];
	var hurtRGB:Array<Array<FlxColor>> = [
		[0xFF101010, 0xFFFF0000, 0xFF990022],
		[0xFF101010, 0xFFFF0000, 0xFF990022],
		[0xFF101010, 0xFFFF0000, 0xFF990022],
		[0xFF101010, 0xFFFF0000, 0xFF990022]
	];
	var arrowRGB9:Array<Array<FlxColor>> = [
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
	];
	var ghostTapping:Bool = true;
	var timeBarType:String = 'Time Left';
	var scoreZoom:Bool = true;
	var noReset:Bool = false;
	var healthBarAlpha:Float = 1;
	var hitsoundVolume:Float = 0;
	var pauseMusic:String = 'Tea Time';
	var checkForUpdates:Bool = true;
	var comboStacking:Bool = true;
	var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'modchart' => true,
		'practice' => false,
		'botplay' => false,
		'chaosmode' => false,
		'chaosdifficulty' => 1.0,
		'randomnotes' => false
	];

	var comboOffset:Array<Int> = [0, 0, 0, 0];
	var ratingOffset:Float = 0;
	var marvelousWindow:Float = 22.5;
	var sickWindow:Float = 45;
	var goodWindow:Float = 90;
	var badWindow:Float = 135;
	var shitWindow:Float = 180;
	var safeFrames:Float = 10;
	var discordRPC:Bool = true;
	var autoPause:Bool = true;
	var guitarHeroSustains:Bool = true;
	var noteSkin:String = 'Default';
	var splashSkin:String = 'Psych';
	var holdSkin:String = 'Vanilla';
	var splashAlpha:Float = 0.6;
	var holdSplashAlpha:Float = 0.6;
	var cacheOnGPU:Bool = true;
}

class ClientPrefs {
	public static var data:SaveVariables = {};
	public static var defaultData:SaveVariables = {};

	//Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_up'		=> [W, UP],
		'note_right'	=> [D, RIGHT],

		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_up'			=> [W, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R],
		
		'volume_mute'	=> [ZERO],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN],
		'debug_2'		=> [EIGHT],
		'debug_3'		=> [SIX]
	];
	public static var gamepadBinds:Map<String, Array<FlxGamepadInputID>> = [
		'note_up'		=> [DPAD_UP, Y],
		'note_left'		=> [DPAD_LEFT, X],
		'note_down'		=> [DPAD_DOWN, A],
		'note_right'	=> [DPAD_RIGHT, B],
		
		'ui_up'			=> [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'ui_left'		=> [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'ui_down'		=> [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'ui_right'		=> [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		
		'accept'		=> [A, START],
		'back'			=> [B],
		'pause'			=> [START],
		'reset'			=> [BACK]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;
	public static var defaultButtons:Map<String, Array<FlxGamepadInputID>> = null;
	public static var developerMode:Bool = true; // so they can have access to a lot of stuff (such as chart editor, modchart editor, blocked stuff and etc)
	public static var edwhakMode:Bool = true; //so i have way more stuff than devs lol (includes god mode, autoComplete and others that i'll don't say im not dumb LOL)

	public static function resetKeys(controller:Null<Bool> = null) //Null = both, False = Keyboard, True = Controller
	{
		if(controller != true)
			for (key in keyBinds.keys())
				if(defaultKeys.exists(key))
					keyBinds.set(key, defaultKeys.get(key).copy());

		if(controller != false)
			for (button in gamepadBinds.keys())
				if(defaultButtons.exists(button))
					gamepadBinds.set(button, defaultButtons.get(button).copy());
	}

	public static function clearInvalidKeys(key:String)
	{
		var keyBind:Array<FlxKey> = keyBinds.get(key);
		var gamepadBind:Array<FlxGamepadInputID> = gamepadBinds.get(key);
		while(keyBind != null && keyBind.contains(NONE)) keyBind.remove(NONE);
		while(gamepadBind != null && gamepadBind.contains(NONE)) gamepadBind.remove(NONE);
	}

	public static function loadDefaultKeys()
	{
		defaultKeys = keyBinds.copy();
		defaultButtons = gamepadBinds.copy();
	}

	public static function saveSettings() {
		for (key in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, key, Reflect.field(data, key));

		#if ACHIEVEMENTS_ALLOWED Achievements.save(); #end
		FlxG.save.flush();
		edwhakMode = FlxG.save.data.edwhakMode;

		//Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		var save:FlxSave = new FlxSave();
		save.bind('controls_v1', CoolUtil.getSavePath());
		save.data.keyboard = keyBinds;
		save.data.gamepad = gamepadBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
		#if ACHIEVEMENTS_ALLOWED Achievements.load(); #end

		for (key in Reflect.fields(data))
			if (key != 'gameplaySettings' && Reflect.hasField(FlxG.save.data, key))
				Reflect.setField(data, key, Reflect.field(FlxG.save.data, key));
		
		if(Main.fpsVar != null)
			Main.fpsVar.visible = data.showFPS;

		#if (!html5 && !switch)
		FlxG.autoPause = ClientPrefs.data.autoPause;

		if(FlxG.save.data.framerate == null) {
			final refreshRate:Int = FlxG.stage.application.window.displayMode.refreshRate;
			data.framerate = Std.int(FlxMath.bound(refreshRate, 60, 240));
		}
		#end

		if(data.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = data.framerate;
			FlxG.drawFramerate = data.framerate;
		}
		else
		{
			FlxG.drawFramerate = data.framerate;
			FlxG.updateFramerate = data.framerate;
		}

		if (FlxG.save.data.edwhakMode != null)
			edwhakMode = FlxG.save.data.edwhakMode;

		if(FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
				data.gameplaySettings.set(name, value);
		}
		
		// flixel automatically saves your volume!
		if (FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;
		if (FlxG.save.data.mute != null)
			FlxG.sound.muted = FlxG.save.data.mute;

		#if DISCORD_ALLOWED DiscordClient.check(); #end

		// // controls on a separate save file
		var save:FlxSave = new FlxSave();
		save.bind('controls_v1', CoolUtil.getSavePath());
		if(save != null)
		{
			if(save.data.keyboard != null)
			{
				var loadedControls:Map<String, Array<FlxKey>> = save.data.keyboard;
				for (control => keys in loadedControls)
					if(keyBinds.exists(control)) keyBinds.set(control, keys);
			}
			if(save.data.gamepad != null)
			{
				var loadedControls:Map<String, Array<FlxGamepadInputID>> = save.data.gamepad;
				for (control => keys in loadedControls)
					if(gamepadBinds.exists(control)) gamepadBinds.set(control, keys);
			}
			reloadVolumeKeys();
		}
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic = null, ?customDefaultValue:Bool = false):Dynamic
	{
		if(!customDefaultValue) defaultValue = defaultData.gameplaySettings.get(name);
		return /*PlayState.isStoryMode ? defaultValue : */ (data.gameplaySettings.exists(name) ? data.gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadVolumeKeys()
	{
		TitleState.muteKeys = keyBinds.get('volume_mute').copy();
		TitleState.volumeDownKeys = keyBinds.get('volume_down').copy();
		TitleState.volumeUpKeys = keyBinds.get('volume_up').copy();
		toggleVolumeKeys(true);
	}

	public static function toggleVolumeKeys(?turnOn:Bool = true)
	{
		final emptyArray = [];
		FlxG.sound.muteKeys = turnOn ? TitleState.muteKeys : emptyArray;
		FlxG.sound.volumeDownKeys = turnOn ? TitleState.volumeDownKeys : emptyArray;
		FlxG.sound.volumeUpKeys = turnOn ? TitleState.volumeUpKeys : emptyArray;
	}
}
