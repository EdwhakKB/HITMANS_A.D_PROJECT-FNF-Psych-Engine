package codenameengine.scripting;

import lime.app.Application;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import haxe.io.Path;
import _hscript.IHScriptCustomConstructor;
import flixel.util.FlxStringUtil;
import flixel.FlxBasic;
import flixel.FlxG;
import editors.content.EditorPlayState;

@:allow(codenameengine.scripting.ScriptPack)
/**
 * Class used for scripting.
 */
class Script extends FlxBasic implements IFlxDestroyable {
	/**
	 * Use "static var thing = true;" in hscript to use those!!
	 * are reset every mod switch so once you're done with them make sure to make them null!!
	 */
	public static var staticVariables:Map<String, Dynamic> = [];

	public static function getDefaultVariables(?script:Script):Map<String, Dynamic> {
		return [
			// Haxe related stuff
			"Std"			   => Std,
			"Math"			  => Math,
			"Reflect"			  => Reflect,
			"StringTools"	   => StringTools,
			"Json"			  => haxe.Json,

			// OpenFL & Lime related stuff
			"Assets"			=> openfl.utils.Assets,
			"Application"	   => lime.app.Application,
			"Main"				=> Main,
			"window"			=> lime.app.Application.current.window,

			// Flixel related stuff
			"FlxG"			  => flixel.FlxG,
			"FlxSprite"		 => flixel.FlxSprite,
			"FlxBasic"		  => flixel.FlxBasic,
			"FlxCamera"		 => flixel.FlxCamera,
			"state"			 => flixel.FlxG.state,
			"FlxEase"		   => flixel.tweens.FlxEase,
			"FlxTween"		  => flixel.tweens.FlxTween,
			"FlxSound"		  => flixel.sound.FlxSound,
			"FlxAssets"		 => flixel.system.FlxAssets,
			"FlxMath"		   => flixel.math.FlxMath,
			"FlxGroup"		  => flixel.group.FlxGroup,
			"FlxTypedGroup"	 => flixel.group.FlxGroup.FlxTypedGroup,
			"FlxSpriteGroup"	=> flixel.group.FlxSpriteGroup,
			"FlxTypeText"	   => flixel.addons.text.FlxTypeText,
			"FlxText"		   => flixel.text.FlxText,
			"FlxTimer"		  => flixel.util.FlxTimer,
			"FlxPoint"		  => CoolUtil.getMacroAbstractClass("flixel.math.FlxPoint"),
			"FlxAxes"		   => CoolUtil.getMacroAbstractClass("flixel.util.FlxAxes"),
			"FlxColor"		  => CoolUtil.getMacroAbstractClass("flixel.util.FlxColor"),
			"Mods"		  => Mods,
			"PlayState"		 => PlayState,
			"EditorPlayState" => editors.content.EditorPlayState,
			"GameOverSubstate"  => GameOverSubstate,
			"HealthIcon"		=> HealthIcon,
			"Note"			  => Note,
			"StrumNote"			 => StrumNote,
			"Character"		 => Character,
			"Boyfriend"		 => Character, // for compatibility
			"PauseSubstate"	 => PauseSubState,
			"FreeplayState"	 => FreeplayState,
			"MainMenuState"	 => MainMenuState,
			"StoryMenuState"	=> StoryMenuState,
			"TitleState"		=> TitleState,
			"Options"		   => options.OptionsState,
			"Paths"			 => Paths,
			"Conductor"		 => Conductor,
			"FunkinShader"	  => codenameengine.FunkinShader,
			"CustomCodeShader"	  => codenameengine.CustomCodeShader,
            "CustomShader"	  => codenameengine.CustomCodeShader,
			#if flxanimate "FlxAnimate"		=> FlxAnimate, #end
			"Alphabet"		  => Alphabet,

			"CoolUtil"		  => CoolUtil,

			"CustomFlxColor" => CustomFlxColor,
			"ClientPrefs" => ClientPrefs,
			#if (sys && !flash)
			"FlxRuntimeShader" => flixel.addons.display.FlxRuntimeShader,
			#end
			"GraphicsShader" => openfl.display.GraphicsShader,
			"ColorSwap" => shaders.ColorSwap,
			#if ACHIEVEMENTS_ALLOWED
			"Achievements" => achievements.Achievements,
			#end
			#if DISCORD_ALLOWED
			"Discord" => Discord.DiscordClient,
			#end
			"ShaderFilter" => openfl.filters.ShaderFilter,
			#if LUA_ALLOWED
			"FunkinLua" => FunkinLua,
			#end
			"BGSprite" => BGSprite,
			"AttachedSprite" => AttachedSprite,
			"AttachedText" => AttachedText,
			"Controls" => Controls,
			"FlxSimplex" => flixel.addons.util.FlxSimplex

		];
	}
/*	public static function getDefaultPreprocessors():Map<String, Dynamic> {
		var defines = funkin.backend.system.macros.DefinesMacro.defines;
		defines.set("CODENAME_ENGINE", true);
		defines.set("CODENAME_VER", Application.current.meta.get('version'));
		defines.set("CODENAME_BUILD", 2675); // 2675 being the last build num before it was removed
		defines.set("CODENAME_COMMIT", funkin.backend.system.macros.GitCommitMacro.commitNumber);
		return defines;
	}*/

	/**
	 * Currently executing script.
	 */
	public static var curScript:Script = null;

	/**
	 * Script name (with extension)
	 */
	public var fileName:String;

	/**
	 * Path to the script.
	 */
	public var path:String = null;

	private var didLoad:Bool = false;

	/**
	 * Creates a script from the specified asset path. The language is automatically determined.
	 * @param path Path in assets
	 */
	public static function create(path:String):Script {
		if (sys.FileSystem.exists(path)) {
			return switch(Path.extension(path).toLowerCase()) {
				case "hx" | "hscript" | "hsc" | "hxs":
					new HScript(path);
				default:
					new DummyScript(path);
			}
		}
		return new DummyScript(path);
	}

	/**
	 * Creates a script from the string. The language is determined based on the path.
	 * @param code code
	 * @param path filename
	 */
	public static function fromString(code:String, path:String):Script {
		return switch(Path.extension(path).toLowerCase()) {
			case "hx" | "hscript" | "hsc" | "hxs":
				new HScript(path).loadFromString(code);
			default:
				new DummyScript(path).loadFromString(code);
		}
	}

	public var modFolder:String;

	/**
	 * Creates a new instance of the script class.
	 * @param path
	 */
	public function new(path:String) {
		super();

		fileName = Path.withoutDirectory(path);
		this.path = path;
		onCreate(path);
		#if MODS_ALLOWED
		var myFolder:Array<String> = path.split('/');
		if(myFolder[0] + '/' == Paths.mods() && (Mods.currentModDirectory == myFolder[1] || Mods.getGlobalMods().contains(myFolder[1]))) //is inside mods folder
			this.modFolder = myFolder[1];
		#end
		for(k=>e in getDefaultVariables(this)) {
			set(k, e);
		}
		set("disableScript", () -> {
			active = false;
		});
		set("__script__", this);

		// Functions & Variables
		set('setVar', function(name:String, value:Dynamic)
		{
			if (PlayState.instance == FlxG.state) PlayState.instance.variables.set(name, value);
			else if (EditorPlayState.instance == FlxG.state) EditorPlayState.instance.variables.set(name, value);
		});
		set('getVar', function(name:String)
		{
			var result:Dynamic = null;
			if (PlayState.instance == FlxG.state) if(PlayState.instance.variables.exists(name)) result = PlayState.instance.variables.get(name);
			else if (EditorPlayState.instance == FlxG.state) if(EditorPlayState.instance.variables.exists(name)) result = EditorPlayState.instance.variables.get(name);
			return result;
		});
		set('removeVar', function(name:String)
		{
			if (PlayState.instance == FlxG.state){
				if(PlayState.instance.variables.exists(name))
				{
					PlayState.instance.variables.remove(name);
					return true;
				}
			}else if (EditorPlayState.instance == FlxG.state){
				if(EditorPlayState.instance.variables.exists(name))
				{
					EditorPlayState.instance.variables.remove(name);
					return true;
				}
			}
			return false;
		});
		set('debugPrint', function(text:String, ?color:flixel.util.FlxColor = null) {
			if(color == null) color = flixel.util.FlxColor.WHITE;
			if (PlayState.instance == FlxG.state)
				PlayState.instance.addTextToDebug(text, color);
			else if (EditorPlayState.instance == FlxG.state)
				EditorPlayState.instance.addTextToDebug(text, color);
			else trace(text);
		});

		// Keyboard & Gamepads
		set('keyboardJustPressed', function(name:String) return Reflect.getProperty(FlxG.keys.justPressed, name));
		set('keyboardPressed', function(name:String) return Reflect.getProperty(FlxG.keys.pressed, name));
		set('keyboardReleased', function(name:String) return Reflect.getProperty(FlxG.keys.justReleased, name));

		set('anyGamepadJustPressed', function(name:String) return FlxG.gamepads.anyJustPressed(name));
		set('anyGamepadPressed', function(name:String) FlxG.gamepads.anyPressed(name));
		set('anyGamepadReleased', function(name:String) return FlxG.gamepads.anyJustReleased(name));

		/*set('gamepadAnalogX', function(id:Int, ?leftStick:Bool = true)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null) return 0.0;

			return controller.getXAxis(leftStick ? LEFT_ANALOG_STICK : RIGHT_ANALOG_STICK);
		});
		set('gamepadAnalogY', function(id:Int, ?leftStick:Bool = true)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null) return 0.0;

			return controller.getYAxis(leftStick ? LEFT_ANALOG_STICK : RIGHT_ANALOG_STICK);
		});
		set('gamepadJustPressed', function(id:Int, name:String)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null) return false;

			return Reflect.getProperty(controller.justPressed, name) == true;
		});
		set('gamepadPressed', function(id:Int, name:String)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null) return false;

			return Reflect.getProperty(controller.pressed, name) == true;
		});
		set('gamepadReleased', function(id:Int, name:String)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null) return false;

			return Reflect.getProperty(controller.justReleased, name) == true;
		});

		set('keyJustPressed', function(name:String = '') {
			name = name.toLowerCase();
			switch(name) {
				case 'left': return Controls.instance.NOTE_LEFT_P;
				case 'down': return Controls.instance.NOTE_DOWN_P;
				case 'up': return Controls.instance.NOTE_UP_P;
				case 'right': return Controls.instance.NOTE_RIGHT_P;
				default: return Controls.instance.justPressed(name);
			}
			return false;
		});
		set('keyPressed', function(name:String = '') {
			name = name.toLowerCase();
			switch(name) {
				case 'left': return Controls.instance.NOTE_LEFT;
				case 'down': return Controls.instance.NOTE_DOWN;
				case 'up': return Controls.instance.NOTE_UP;
				case 'right': return Controls.instance.NOTE_RIGHT;
				default: return Controls.instance.pressed(name);
			}
			return false;
		});
		set('keyReleased', function(name:String = '') {
			name = name.toLowerCase();
			switch(name) {
				case 'left': return Controls.instance.NOTE_LEFT_R;
				case 'down': return Controls.instance.NOTE_DOWN_R;
				case 'up': return Controls.instance.NOTE_UP_R;
				case 'right': return Controls.instance.NOTE_RIGHT_R;
				default: return Controls.instance.justReleased(name);
			}
			return false;
		});*/

		// set('buildTarget', FunkinLua.getBuildTarget());
		set('customSubstate', FunkinLua.CustomSubstate.instance);
		set('customSubstateName', FunkinLua.CustomSubstate.name);
		set('Function_Stop', FunkinLua.Function_Stop);
		set('Function_Continue', FunkinLua.Function_Continue);
		set('Function_StopLua', FunkinLua.Function_StopLua); //doesnt do much cuz HScript has a lower priority than Lua
		set('Function_StopHScript', FunkinLua.Function_StopHScript);
		set('Function_StopAll', FunkinLua.Function_StopAll);

		set('add', FlxG.state.add);
		set('insert', FlxG.state.insert);
		set('remove', FlxG.state.remove);

		set('setAxes', function(fromString:Bool, axes:String, xAxes:Bool, yAxes:Bool, bothAxes:Bool)
		{
			if (fromString)
				return flixel.util.FlxAxes.fromString(axes);
			else if (xAxes)
				return flixel.util.FlxAxes.X;
			else if (yAxes)
				return flixel.util.FlxAxes.Y;
			else if (bothAxes)
				return flixel.util.FlxAxes.XY;
			return flixel.util.FlxAxes.fromString('XY');
		});

		set('Math', Math);
		set('ModchartEditorState', modcharting.ModchartEditorState);
		set('ModchartEvent', modcharting.ModchartEvent);
		set('ModchartEventManager', modcharting.ModchartEventManager);
		set('ModchartFile', modcharting.ModchartFile);
		set('ModchartFuncs', modcharting.ModchartFuncs);
		set('ModchartMusicBeatState', modcharting.ModchartMusicBeatState);
		set('ModchartUtil', modcharting.ModchartUtil);
		for (i in ['mod', 'Modifier'])
			set(i, modcharting.Modifier); //the game crashes without this???????? what??????????? -- fue glow
		set('ModifierSubValue', modcharting.Modifier.ModifierSubValue);
		set('ModTable', modcharting.ModTable);
		set('NoteMovement', modcharting.NoteMovement);
		set('NotePositionData', modcharting.NotePositionData);
		set('Playfield', modcharting.Playfield);
		set('PlayfieldRenderer', modcharting.PlayfieldRenderer);
		set('SimpleQuaternion', modcharting.SimpleQuaternion);
		set('SustainStrip', modcharting.SustainStrip);

		//Why?
		set('BeatXModifier', modcharting.Modifier.BeatXModifier);
		if (PlayState.instance != null && PlayState.SONG != null && PlayState.SONG.notITG && PlayState.instance.notITGMod)
			modcharting.ModchartFuncs.loadHScriptFunctions(this);
		else if (EditorPlayState.instance != null && PlayState.SONG != null && PlayState.SONG.notITG)
			modcharting.ModchartFuncs.loadHScriptFunctions(this);

		if(PlayState.instance == FlxG.state)
		{
			set('addBehindGF', PlayState.instance.addBehindGF);
			set('addBehindDad', PlayState.instance.addBehindDad);
			set('addBehindBF', PlayState.instance.addBehindBF);
		}else if (EditorPlayState.instance == FlxG.state)
		{
			set('addBehindGF', EditorPlayState.instance.addBehindGF);
			set('addBehindDad', EditorPlayState.instance.addBehindDad);
			set('addBehindBF', EditorPlayState.instance.addBehindBF);
		}

		set('setVarFromClass', function(instance:String, variable:String, value:Dynamic)
		{
			Reflect.setProperty(Type.resolveClass(instance), variable, value);
		});

		set('getVarFromClass', function(instance:String, variable:String)
		{
			Reflect.getProperty(Type.resolveClass(instance), variable);
		});
	}

	public function initMod(mod:modcharting.Modifier)
    {
        call("initMod", [mod]);
    }


	/**
	 * Loads the script
	 */
	public function load() {
		if(didLoad) return;

		var oldScript = curScript;
		curScript = this;
		onLoad();
		curScript = oldScript;

		didLoad = true;
	}

	/**
	 * HSCRIPT ONLY FOR NOW
	 * Sets the "public" variables map for ScriptPack
	 */
	public function setPublicMap(map:Map<String, Dynamic>) {

	}

	/**
	 * Hot-reloads the script, if possible
	 */
	public function reload() {

	}

	/**
	 * Traces something as this script.
	 */
	public function trace(v:Dynamic) {
		trace('${fileName}: ' + Std.string(v));
	}


	/**
	 * Calls the function `func` defined in the script.
	 * @param func Name of the function
	 * @param parameters (Optional) Parameters of the function.
	 * @return Result (if void, then null)
	 */
	public function call(func:String, ?parameters:Array<Dynamic>):Dynamic {
		var oldScript = curScript;
		curScript = this;

		var result = onCall(func, parameters == null ? [] : parameters);

		curScript = oldScript;
		return result;
	}

	/**
	 * Loads the code from a string, doesnt really work after the script has been loaded
	 * @param code The code.
	 */
	public function loadFromString(code:String) {
		return this;
	}

	/**
	 * Sets a script's parent object so that its properties can be accessed easily. Ex: Passing `PlayState.instance` will allow `boyfriend` to be typed instead of `PlayState.instance.boyfriend`.
	 * @param variable Parent variable.
	 */
	public function setParent(variable:Dynamic) {}

	/**
	 * Gets the variable `variable` from the script's variables.
	 * @param variable Name of the variable.
	 * @return Variable (or null if it doesn't exists)
	 */
	public function get(variable:String):Dynamic {return null;}

	/**
	 * Gets the variable `variable` from the script's variables.
	 * @param variable Name of the variable.
	 * @return Variable (or null if it doesn't exists)
	 */
	public function set(variable:String, value:Dynamic):Void {}

	/**
	 * Shows an error from this script.
	 * @param text Text of the error (ex: Null Object Reference).
	 * @param additionalInfo Additional information you could provide.
	 */
	public function error(text:String, ?additionalInfo:Dynamic):Void {
		trace(fileName);
		trace(text);
	}

	override public function toString():String {
		return FlxStringUtil.getDebugString(didLoad ? [
			LabelValuePair.weak("path", path),
			LabelValuePair.weak("active", active),
		] : [
			LabelValuePair.weak("path", path),
			LabelValuePair.weak("active", active),
			LabelValuePair.weak("loaded", didLoad),
		]);
	}

	/**
	 * PRIVATE HANDLERS - DO NOT TOUCH
	 */
	private function onCall(func:String, parameters:Array<Dynamic>):Dynamic {
		return null;
	}
	public function onCreate(path:String) {}

	public function onLoad() {}
}
