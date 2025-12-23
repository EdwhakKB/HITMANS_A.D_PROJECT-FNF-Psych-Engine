package scripting;

import flixel.*;
import flixel.util.FlxAxes;

#if LUA_ALLOWED
import scripting.FunkinLua;
#end

#if SScript
import tea.SScript;
#end

#if SScript
class SSHScript extends SScript
{	
	#if LUA_ALLOWED
	public var parentLua:FunkinLua;
	public static function initHaxeModule(parent:FunkinLua)
	{
		#if (SScript >= "3.0.0")
		if(parent.ssHscript == null)
		{
			trace('initializing haxe interp for: ${parent.scriptName}');
			parent.ssHscript = new SSHScript(parent);
		}
		#end
	}

	public static function initHaxeModuleCode(parent:FunkinLua, code:String, ?varsToBring:Any = null)
	{
		#if (SScript >= "3.0.0")
		if(parent.ssHscript == null)
		{
			trace('initializing haxe interp for: ${parent.scriptName}');
			parent.ssHscript = new SSHScript(parent, code, varsToBring);
		}
		#end
	}
	#end

	public var origin:String;
	override public function new(?parent:Dynamic, ?file:String, ?varsToBring:Any = null)
	{
		if (file == null)
			file = '';

		this.varsToBring = varsToBring;
	
		super(file, false, false);
		#if LUA_ALLOWED
		parentLua = parent;
		#end
		if (parent != null)
			origin = parent.scriptName;
		if (scriptFile != null && scriptFile.length > 0)
			origin = scriptFile;
		preset();
		execute();
	}

	var varsToBring:Any = null;
	override function preset()
	{
		super.preset();

		// Some very commonly used classes
		set('FlxG', flixel.FlxG);
		set('FlxMath', flixel.math.FlxMath);
		set('FlxSprite', flixel.FlxSprite);
		set('FlxCamera', flixel.FlxCamera);
		set('FlxTimer', flixel.util.FlxTimer);
		set('FlxTween', flixel.tweens.FlxTween);
		set('FlxEase', flixel.tweens.FlxEase);
		set('FlxColor', scripting.CustomFlxColor);
		set('PlayState', play.PlayState);
		set('Paths', engine.Paths);
		set('Conductor', engine.Conductor);
		set('ClientPrefs', engine.ClientPrefs);
		#if ACHIEVEMENTS_ALLOWED
		set('Achievements', achievements.Achievements);
		#end
		set('Character', objects.Character);
		set('Alphabet', objects.Alphabet);
		set('Note', objects.Note);
		set('CustomSubstate', scripting.FunkinLua.CustomSubstate);
		#if (!flash && sys)
		set('FlxRuntimeShader', flixel.addons.display.FlxRuntimeShader);
		#end
		set('ShaderFilter', openfl.filters.ShaderFilter);
		#if LUA_ALLOWED
		set('FunkinLua', scripting.FunkinLua);
		#end
		#if flxanimate
		set('FlxAnimate', FlxAnimate);
		#end

		// Functions & Variables
		set('setVar', function(name:String, value:Dynamic)
		{
			PlayState.instance.variables.set(name, value);
		});
		set('getVar', function(name:String)
		{
			var result:Dynamic = null;
			if(PlayState.instance.variables.exists(name)) result = PlayState.instance.variables.get(name);
			return result;
		});
		set('removeVar', function(name:String)
		{
			if(PlayState.instance.variables.exists(name))
			{
				PlayState.instance.variables.remove(name);
				return true;
			}
			return false;
		});
		set('debugPrint', function(text:String, ?color:FlxColor = null) {
			if(color == null) color = FlxColor.WHITE;
			PlayState.instance.addTextToDebug(text, color);
		});

		// Keyboard & Gamepads
		set('keyboardJustPressed', function(name:String) return Reflect.getProperty(FlxG.keys.justPressed, name));
		set('keyboardPressed', function(name:String) return Reflect.getProperty(FlxG.keys.pressed, name));
		set('keyboardReleased', function(name:String) return Reflect.getProperty(FlxG.keys.justReleased, name));

		set('anyGamepadJustPressed', function(name:String) return FlxG.gamepads.anyJustPressed(name));
		set('anyGamepadPressed', function(name:String) FlxG.gamepads.anyPressed(name));
		set('anyGamepadReleased', function(name:String) return FlxG.gamepads.anyJustReleased(name));

		set('gamepadAnalogX', function(id:Int, ?leftStick:Bool = true)
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

		// For adding your own callbacks

		// not very tested but should work
		set('addHaxeLibrary', function(libName:String, ?libPackage:String = '') {
			try {
				var str:String = '';
				if(libPackage.length > 0)
					str = libPackage + '.';

				set(libName, Type.resolveClass(str + libName));
			}
			catch (e:Dynamic) {
				var msg:String = e.message.substr(0, e.message.indexOf('\n'));
				#if LUA_ALLOWED
				if(parentLua != null)
				{
					FunkinLua.lastCalledScript = parentLua;
					FunkinLua.luaTrace('$origin: ${parentLua.lastCalledFunction} - $msg', false, false, FlxColor.RED);
					return;
				}
				#end
				if(PlayState.instance != null) PlayState.instance.addTextToDebug('$origin - $msg', FlxColor.RED);
				else trace('$origin - $msg');
			}
		});
		#if LUA_ALLOWED
		set('parentLua', parentLua);
		#else
		set('parentLua', null);
		#end
		set('this', this);
		set('game', FlxG.state);
		//set('buildTarget', getBuildTarget());
		set('customSubstate', FunkinLua.CustomSubstate.instance);
		set('customSubstateName', FunkinLua.CustomSubstate.name);
		set('StringTools', StringTools);
		set('Function_Stop', FunkinLua.Function_Stop);
		set('Function_Continue', FunkinLua.Function_Continue);
		set('Function_StopLua', FunkinLua.Function_StopLua); //doesnt do much cuz HScript has a lower priority than Lua
		set('Function_StopHScript', FunkinLua.Function_StopHScript);
		set('Function_StopAll', FunkinLua.Function_StopAll);
		
		set('add', FlxG.state.add);
		set('insert', FlxG.state.insert);
		set('remove', FlxG.state.remove);

		// #if modchartingTools
		// set('Math', Math);
		// set('ModchartEditorState', modcharting.ModchartEditorState);
		// set('ModchartEvent', modcharting.ModchartEvent);
		// set('ModchartEventManager', modcharting.ModchartEventManager);
		// set('ModchartFile', modcharting.ModchartFile);
		// set('ModchartFuncs', modcharting.ModchartFuncs);
		// set('ModchartMusicBeatState', modcharting.ModchartMusicBeatState);
		// set('ModchartUtil', modcharting.ModchartUtil);
		// for (i in ['mod', 'Modifier'])
		// 	set(i, modcharting.Modifier); //the game crashes without this???????? what??????????? -- fue glow
		// set('ModifierSubValue', modcharting.Modifier.ModifierSubValue);
		// set('ModTable', modcharting.ModTable);
		// set('NoteMovement', modcharting.NoteMovement);
		// set('NotePositionData', modcharting.NotePositionData);
		// set('Playfield', modcharting.Playfield);
		// set('PlayfieldRenderer', modcharting.PlayfieldRenderer);
		// set('SimpleQuaternion', modcharting.SimpleQuaternion);
		// set('SustainStrip', modcharting.SustainStrip);

		// //Why?
		// set('BeatXModifier', modcharting.Modifier.BeatXModifier);
		// //if (PlayState.instance != null && PlayState.SONG != null && !isHxStage && PlayState.SONG.notITG && PlayState.instance.notITGMod)
		// #end

		modcharting.ModchartFuncs.loadHScriptFunctions(this);

		set('setAxes', function(fromString:Bool, axes:String, xAxes:Bool, yAxes:Bool, bothAxes:Bool)
		{
			if (fromString)
				return FlxAxes.fromString(axes);
			else if (xAxes)
				return FlxAxes.X;
			else if (yAxes)
				return FlxAxes.Y;
			else if (bothAxes)
				return FlxAxes.XY;
			return FlxAxes.fromString('XY');
		});

		if(PlayState.instance == FlxG.state)
		{
			set('addBehindGF', PlayState.instance.addBehindGF);
			set('addBehindDad', PlayState.instance.addBehindDad);
			set('addBehindBF', PlayState.instance.addBehindBF);
			//setSpecialObject(PlayState.instance, false, PlayState.instance.instancesExclude);
		}

		if(varsToBring != null)
		{
			for (key in Reflect.fields(varsToBring))
			{
				key = key.trim();
				var value = Reflect.field(varsToBring, key);
				//trace('Key $key: $value');
				set(key, Reflect.field(varsToBring, key));
			}
			varsToBring = null;
		}
	}

	public function executeCode(?funcToRun:String = null, ?funcArgs:Array<Dynamic> = null): #if (SScript >= "6.1.8") TeaCall #else SCall #end
	{
		if (funcToRun == null) return null;

		if(!exists(funcToRun))
		{
			#if LUA_ALLOWED
			FunkinLua.luaTrace(origin + ' - No HScript function named: $funcToRun', false, false, FlxColor.RED);
			#else
			PlayState.instance.addTextToDebug(origin + ' - No HScript function named: $funcToRun', FlxColor.RED);
			#end
			return null;
		}

		var callValue = call(funcToRun, funcArgs);
		if (!callValue.succeeded)
		{
			final e = callValue.exceptions[0];
			if (e != null)
			{
				var msg:String = e.toString();
				#if LUA_ALLOWED
				if(parentLua != null)
				{
					FunkinLua.luaTrace('$origin: ${parentLua.lastCalledFunction} - $msg', false, false, FlxColor.RED);
					return null;
				}
				#end
				PlayState.instance.addTextToDebug('$origin - $msg', FlxColor.RED);
			}
			return null;
		}
		return callValue;
	}

	public function executeFunction(funcToRun:String = null, funcArgs:Array<Dynamic>): #if (SScript >= "6.1.8") TeaCall #else SCall #end
	{
		if (funcToRun == null)
			return null;

		return call(funcToRun, funcArgs);
	}

	#if LUA_ALLOWED
	public static function implement(funk:FunkinLua)
	{
		funk.addLocalCallback("runSSHaxeCode", function(codeToRun:String, ?varsToBring:Any = null, ?funcToRun:String = null, ?funcArgs:Array<Dynamic> = null):Dynamic {
			#if (SScript >= "3.0.0")
			initHaxeModuleCode(funk, codeToRun, varsToBring);
			var retVal: #if (SScript >= "6.1.8") TeaCall #else SCall #end = funk.ssHscript.executeCode(funcToRun, funcArgs);
			retVal = funk.ssHscript.executeCode(funcToRun, funcArgs);
			if (retVal != null)
			{
				if(retVal.succeeded)
					return (retVal.returnValue == null || FunkinLua.isOfTypes(retVal.returnValue, [Bool, Int, Float, String, Array])) ? retVal.returnValue : null;

				var e = retVal.exceptions[0];
				if (e != null)
					FunkinLua.luaTrace(funk.ssHscript.origin + ":" + funk.lastCalledFunction + " - " + e, false, false, FlxColor.RED);
				return null;
			}
			else if (funk.ssHscript.returnValue != null)
				return funk.ssHscript.returnValue;
			#else
			FunkinLua.luaTrace("runHaxeCode: HScript isn't supported on this platform!", false, false, FlxColor.RED);
			#end
			return null;
		});
		
		funk.addLocalCallback("runSSHaxeFunction", function(funcToRun:String, ?funcArgs:Array<Dynamic> = null) {
			#if (SScript >= "3.0.0")
			var callValue = funk.ssHscript.executeFunction(funcToRun, funcArgs);
			if (!callValue.succeeded)
			{
				var e = callValue.exceptions[0];
				if (e != null)
					FunkinLua.luaTrace('ERROR (${funk.ssHscript.origin}: ${callValue.calledFunction}) - ' + e.message.substr(0, e.message.indexOf('\n')), false, false, FlxColor.RED);
				return null;
			}
			else
				return callValue.returnValue;
			#else
			FunkinLua.luaTrace("runHaxeFunction: HScript isn't supported on this platform!", false, false, FlxColor.RED);
			#end
		});
		// This function is unnecessary because import already exists in SScript as a native feature
		funk.addLocalCallback("addSSHaxeLibrary", function(libName:String, ?libPackage:String = '') {
			var str:String = '';
			if(libPackage.length > 0)
				str = libPackage + '.';
			else if(libName == null)
				libName = '';

			var c = Type.resolveClass(str + libName);

			#if (SScript >= "3.0.3")
			if (c != null)
				SScript.globalVariables[libName] = c;
			#end

			#if (SScript >= "3.0.0")
			if (funk.ssHscript != null)
			{
				try {
					if (c != null)
						funk.ssHscript.set(libName, c);
				}
				catch (e:Dynamic) {
					FunkinLua.luaTrace(funk.ssHscript.origin + ":" + funk.lastCalledFunction + " - " + e, false, false, FlxColor.RED);
				}
			}
			#else
			FunkinLua.luaTrace("addHaxeLibrary: HScript isn't supported on this platform!", false, false, FlxColor.RED);
			#end
		});
	}
	#end

	#if (SScript >= "3.0.3")
	override public function destroy()
	{
		origin = null;
		#if LUA_ALLOWED parentLua = null; #end

		super.destroy();
	}
	#else
	public function destroy()
	{
		active = false;
	}
	#end
}
#else
class SSHScript {
	public static function implement(funk:FunkinLua) {}
}
#end
