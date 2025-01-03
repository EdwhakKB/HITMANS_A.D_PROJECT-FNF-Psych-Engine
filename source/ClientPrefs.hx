package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.util.FlxColor;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Discord;
import Controls;

class ClientPrefs {
	public static var downScroll:Bool = false;
	public static var middleScroll:Bool = false;
	public static var opponentStrums:Bool = true;
	public static var casualMode:Bool = false;
	public static var showFPS:Bool = true;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var mimicNoteAlpha:Float = 0.6;
	public static var hudStyle:String = 'HITMANS';
	public static var customHudName:String = 'FNF';
    public static var healthBarStyle:String = 'healthBar';
    public static var countDownStyle:Array<String> = ["get", "ready", "set", "go"];
    public static var countDownSounds:Array<String> = ["intro3", "intro2", "intro1", "introGo"];
    public static var ratingStyle:Array<Dynamic> = ["", null];
    public static var memoryDisplay:Bool = true;
	public static var notesSkin:Array<String> = ['HITMANS', 'MIMIC', 'NONE']; //notes, hurts, holds
	public static var mineSkin:String = 'HITMANS';
	public static var splashSkin:String = 'HITMANS';
	public static var userName:String = '';
	public static var isLogged:Bool = false;
	public static var quantization:Bool = false;
	public static var goStyle:String = 'NEW';
	public static var lowQuality:Bool = false;
	public static var shaders:Bool = true;
	public static var framerate:Int = 60;
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var schmovin:Bool = false;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [
		[0, 0, 0], [0, 0, 0], 
		[0, 0, 0], [0, 0, 0]
	]; // Fuck
	public static var arrowRGB:Array<Array<FlxColor>> = [
		[0xFFC24B99, 0xFFFFFFFF, 0xFF3C1F56],
		[0xFF00FFFF, 0xFFFFFFFF, 0xFF1542B7],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFFF9393F, 0xFFFFFFFF, 0xFF651038]
	];
	public static var arrowRGBQuantize:Array<Array<FlxColor>> = [
		[0xFFFF0000, 0xFFFFFFFF, 0xFF7F0000],
		[0xFF0000FF, 0xFFFFFFFF, 0xFF00007F],
		[0xFF800080, 0xFFFFFFFF, 0xFF400040],
		[0xFF00FF00, 0xFFFFFFFF, 0xFF007F00],
		[0xFFFFFF00, 0xFFFFFFFF, 0xFF7F7F00],
		[0xFF00FFDD, 0xFFFFFFFF, 0xFF018573],
		[0xFFFF00FF, 0xFFFFFFFF, 0xFF8A018A],
		[0xFFFF7300, 0xFFFFFFFF, 0xFF883D00]
	];
	public static var hurtRGB:Array<Array<FlxColor>> = [
		[0xFF101010, 0xFFFF0000, 0xFF990022],
		[0xFF101010, 0xFFFF0000, 0xFF990022],
		[0xFF101010, 0xFFFF0000, 0xFF990022],
		[0xFF101010, 0xFFFF0000, 0xFF990022]
	];
	public static var arrowRGB9:Array<Array<FlxColor>> = [
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
	public static var ghostTapping:Bool = true;
	public static var timeBarType:String = 'Time Left';
	public static var scoreZoom:Bool = true;
	public static var noReset:Bool = false;
	public static var healthBarAlpha:Float = 1;
	public static var controllerMode:Bool = false;
	public static var hitsoundVolume:Float = 0;
	public static var pauseMusic:String = 'Tea Time';
	public static var checkForUpdates:Bool = true;
	public static var comboStacking = true;
	public static var gameplaySettings:Map<String, Dynamic> = [
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

	public static var comboOffset:Array<Int> = [0, 0, 0, 0];
	public static var ratingOffset:Float = 0;
	public static var marvelousWindow:Float = 22.5;
	public static var sickWindow:Float = 45;
	public static var goodWindow:Float = 90;
	public static var badWindow:Float = 135;
	public static var shitWindow:Float = 180;
	public static var safeFrames:Float = 10;
	public static var discordRPC:Bool = true;

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
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE],
		'debug_3'		=> [SIX, NONE]
	];

	public static var developerMode:Bool = false; // so they can have access to a lot of stuff (such as chart editor, modchart editor, blocked stuff and etc)
	public static var edwhakMode:Bool = false; //so i have way more stuff than devs lol (includes god mode, autoComplete and others that i'll don't say im not dumb LOL)

	public static var defaultKeys:Map<String, Array<FlxKey>> = keyBinds;

	public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
		//trace(defaultKeys);
	}

	public static function saveSettings() {
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.opponentStrums = opponentStrums;
		FlxG.save.data.casualMode = casualMode;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.flashing = flashing;
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.shaders = shaders;
		FlxG.save.data.framerate = framerate;
		FlxG.save.data.hudStyle = hudStyle;
		// Custom HUD Stuff
        FlxG.save.data.customHudName = customHudName;
        FlxG.save.data.healthBarStyle = healthBarStyle;
        FlxG.save.data.countDownStyle = countDownStyle;
        FlxG.save.data.countDownSounds = countDownSounds;
        FlxG.save.data.ratingStyle = ratingStyle;
		FlxG.save.data.notesSkin = notesSkin;
		FlxG.save.data.mineSkin = mineSkin;
		FlxG.save.data.mimicNoteAlpha = mimicNoteAlpha;
		FlxG.save.data.splashSkin = splashSkin;
		FlxG.save.data.userName = userName;
		FlxG.save.data.isLogged = isLogged;
		FlxG.save.data.quantization = quantization;
		FlxG.save.data.gameOverStyle = goStyle;
		//FlxG.save.data.cursing = cursing;
		//FlxG.save.data.violence = violence;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.hideHud = hideHud;
		FlxG.save.data.arrowHSV = arrowHSV;
		FlxG.save.data.arrowRGB = arrowRGB;
		FlxG.save.data.arrowRGBQuantize = arrowRGBQuantize;
		FlxG.save.data.arrowRGB9 = arrowRGB9;
		FlxG.save.data.hurtRGB = hurtRGB;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.timeBarType = timeBarType;
		FlxG.save.data.scoreZoom = scoreZoom;
		FlxG.save.data.noReset = noReset;
		FlxG.save.data.healthBarAlpha = healthBarAlpha;
		FlxG.save.data.comboOffset = comboOffset;

		FlxG.save.data.ratingOffset = ratingOffset;
		FlxG.save.data.marvelousWindow = marvelousWindow;
		FlxG.save.data.sickWindow = sickWindow;
		FlxG.save.data.goodWindow = goodWindow;
		FlxG.save.data.badWindow = badWindow;
		FlxG.save.data.shitWindow = shitWindow;
		FlxG.save.data.safeFrames = safeFrames;
		FlxG.save.data.gameplaySettings = gameplaySettings;
		FlxG.save.data.controllerMode = controllerMode;
		FlxG.save.data.hitsoundVolume = hitsoundVolume;
		FlxG.save.data.pauseMusic = pauseMusic;
		FlxG.save.data.checkForUpdates = checkForUpdates;
		FlxG.save.data.comboStacking = comboStacking;
		FlxG.save.data.discordRPC = discordRPC;

		FlxG.save.data.developerMode = developerMode;
		FlxG.save.data.edwhakMode = edwhakMode;

		#if ACHIEVEMENTS_ALLOWED Achievements.save(); #end
	
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99'); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
		#if ACHIEVEMENTS_ALLOWED Achievements.load(); #end
		if(FlxG.save.data.downScroll != null) {
			downScroll = FlxG.save.data.downScroll;
		}
		if(FlxG.save.data.middleScroll != null) {
			middleScroll = FlxG.save.data.middleScroll;
		}
		if(FlxG.save.data.opponentStrums != null) {
			opponentStrums = FlxG.save.data.opponentStrums;
		}
		if(FlxG.save.data.casualMode != null) {
			casualMode = FlxG.save.data.casualMode;
		}
		if(FlxG.save.data.showFPS != null) {
			showFPS = FlxG.save.data.showFPS;
			if(Main.fpsVar != null) {
				Main.fpsVar.visible = showFPS;
			}
		}
		if(FlxG.save.data.flashing != null) {
			flashing = FlxG.save.data.flashing;
		}
		if(FlxG.save.data.globalAntialiasing != null) {
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if(FlxG.save.data.lowQuality != null) {
			lowQuality = FlxG.save.data.lowQuality;
		}
		if(FlxG.save.data.shaders != null) {
			shaders = FlxG.save.data.shaders;
		}
		if(FlxG.save.data.framerate != null) {
			framerate = FlxG.save.data.framerate;
			if(framerate > FlxG.drawFramerate) {
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			} else {
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		if(FlxG.save.data.hudStyle != null) {
			hudStyle = FlxG.save.data.hudStyle;
		}
		//Custom HUD Stuff
        if (FlxG.save.data.customHudName != null) {
            customHudName = FlxG.save.data.customHudName;
        }
        if (FlxG.save.data.healthBarStyle  != null) {
            healthBarStyle = FlxG.save.data.healthBarStyle;
        }
        if (FlxG.save.data.countDownStyle != null) {
            countDownStyle = FlxG.save.data.countDownStyle;
        }
        if (FlxG.save.data.countDownSounds != null) {
            countDownSounds = FlxG.save.data.countDownSounds;
        }
        if (FlxG.save.data.ratingStyle != null) {
            ratingStyle = FlxG.save.data.ratingStyle;
        }
		if(FlxG.save.data.notesSkin != null) {
			notesSkin = FlxG.save.data.notesSkin;
		}
		if(FlxG.save.data.mineSkin != null) {
			mineSkin = FlxG.save.data.mineSkin;
		}
		if(FlxG.save.data.mimicNoteAlpha != null) {
			mimicNoteAlpha = FlxG.save.data.mimicNoteAlpha;
		}
		if(FlxG.save.data.splashSkin != null) {
			splashSkin = FlxG.save.data.splashSkin;
		}
		if(FlxG.save.data.userName != null) {
			userName = FlxG.save.data.userName;
		}
		if(FlxG.save.data.isLogged != null) {
			isLogged = FlxG.save.data.isLogged;
		}
		if(FlxG.save.data.quantization != null) {
			quantization = FlxG.save.data.quantization;
		}
		if(FlxG.save.data.gameOverStyle != null) {
			goStyle = FlxG.save.data.gameOverStyle;
		}
		/*if(FlxG.save.data.cursing != null) {
			cursing = FlxG.save.data.cursing;
		}
		if(FlxG.save.data.violence != null) {
			violence = FlxG.save.data.violence;
		}*/
		if(FlxG.save.data.camZooms != null) {
			camZooms = FlxG.save.data.camZooms;
		}
		if(FlxG.save.data.hideHud != null) {
			hideHud = FlxG.save.data.hideHud;
		}
		if(FlxG.save.data.noteOffset != null) {
			noteOffset = FlxG.save.data.noteOffset;
		}
		if(FlxG.save.data.arrowHSV != null) {
			arrowHSV = FlxG.save.data.arrowHSV;
		}
		if(FlxG.save.data.arrowRGB != null) {
			arrowRGB = FlxG.save.data.arrowRGB;
		}
		if(FlxG.save.data.arrowRGBQuantize != null) {
			arrowRGBQuantize = FlxG.save.data.arrowRGBQuantize;
		}
		if(FlxG.save.data.arrowRGB9 != null) {
			arrowRGB9 = FlxG.save.data.arrowRGB9;
		}
		if(FlxG.save.data.hurtRGB != null) {
			hurtRGB = FlxG.save.data.hurtRGB;
		}
		if(FlxG.save.data.ghostTapping != null) {
			ghostTapping = FlxG.save.data.ghostTapping;
		}
		if(FlxG.save.data.timeBarType != null) {
			timeBarType = FlxG.save.data.timeBarType;
		}
		if(FlxG.save.data.scoreZoom != null) {
			scoreZoom = FlxG.save.data.scoreZoom;
		}
		if(FlxG.save.data.noReset != null) {
			noReset = FlxG.save.data.noReset;
		}
		if(FlxG.save.data.healthBarAlpha != null) {
			healthBarAlpha = FlxG.save.data.healthBarAlpha;
		}
		if(FlxG.save.data.comboOffset != null) {
			comboOffset = FlxG.save.data.comboOffset;
		}
		
		if(FlxG.save.data.ratingOffset != null) {
			ratingOffset = FlxG.save.data.ratingOffset;
		}
		if(FlxG.save.data.marvelousWindow != null) {
			marvelousWindow = FlxG.save.data.marvelousWindow;
		}
		if(FlxG.save.data.sickWindow != null) {
			sickWindow = FlxG.save.data.sickWindow;
		}
		if(FlxG.save.data.goodWindow != null) {
			goodWindow = FlxG.save.data.goodWindow;
		}
		if(FlxG.save.data.badWindow != null) {
			badWindow = FlxG.save.data.badWindow;
		}
		if(FlxG.save.data.shitWindow != null) {
			shitWindow = FlxG.save.data.shitWindow;
		}
		if(FlxG.save.data.safeFrames != null) {
			safeFrames = FlxG.save.data.safeFrames;
		}
		if(FlxG.save.data.controllerMode != null) {
			controllerMode = FlxG.save.data.controllerMode;
		}
		if(FlxG.save.data.hitsoundVolume != null) {
			hitsoundVolume = FlxG.save.data.hitsoundVolume;
		}
		if(FlxG.save.data.pauseMusic != null) {
			pauseMusic = FlxG.save.data.pauseMusic;
		}
		if(FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
			{
				gameplaySettings.set(name, value);
			}
		}
		
		// flixel automatically saves your volume!
		if(FlxG.save.data.volume != null)
		{
			FlxG.sound.volume = FlxG.save.data.volume;
		}
		if (FlxG.save.data.mute != null)
		{
			FlxG.sound.muted = FlxG.save.data.mute;
		}
		if (FlxG.save.data.checkForUpdates != null)
		{
			checkForUpdates = FlxG.save.data.checkForUpdates;
		}
		if (FlxG.save.data.comboStacking != null)
		{
			comboStacking = FlxG.save.data.comboStacking;
		}
		if (FlxG.save.data.discordRPC != null)
		{
			discordRPC = FlxG.save.data.discordRPC;
		}

		if(FlxG.save.data.developerMode != null) {
			developerMode = FlxG.save.data.developerMode;
		}
		if(FlxG.save.data.edwhakMode != null) {
			edwhakMode = FlxG.save.data.edwhakMode;
		}
		#if desktop
		DiscordClient.check();
		#end

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99');
		if(save != null && save.data.customControls != null) {
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls) {
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return /*PlayState.isStoryMode ? defaultValue : */ (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		TitleState.muteKeys = copyKey(keyBinds.get('volume_mute'));
		TitleState.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		TitleState.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		toggleVolumeKeys(true);
	}
	public static function toggleVolumeKeys(?turnOn:Bool = true)
	{
		final emptyArray = [];
		FlxG.sound.muteKeys = turnOn ? TitleState.muteKeys : emptyArray;
		FlxG.sound.volumeDownKeys = turnOn ? TitleState.volumeDownKeys : emptyArray;
		FlxG.sound.volumeUpKeys = turnOn ? TitleState.volumeUpKeys : emptyArray;
	}
	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey> {
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len) {
			if(copiedArray[i] == NONE) {
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
