package editors;

import openfl.display.BitmapData;
#if LUA_ALLOWED
import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;
#end

import animateatlas.AtlasFrameMaker;
import flixel.FlxG;
import flixel.addons.effects.FlxTrail;
import flixel.input.keyboard.FlxKey;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxCamera;
import FlxTransWindow;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets;
import flixel.math.FlxMath;
import flixel.util.FlxSave;
import flixel.addons.transition.FlxTransitionableState;
import flixel.system.FlxAssets.FlxShader;
import flixel.group.FlxSpriteGroup;
import flixel.addons.effects.FlxSkewedSprite;
import editors.content.EditorPlayState;

#if (!flash && sys)
import flixel.addons.display.FlxRuntimeShader;
#end

#if sys
import sys.FileSystem;
import sys.io.File;
#end

import Type.ValueType;
import Controls;
import DialogueBoxPsych;
import Shaders.ShaderEffectNew as ShaderEffect;
import Shaders;
import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;

#if hscript
import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
#end

#if desktop
import Discord;
#end

import codenameengine.CustomCodeShader;
import lime.app.Application;

import RGBPalette;
import RGBPalette.RGBShaderReference;

using StringTools;

typedef LuaCamera =
{
    var cam:FlxCamera;
    var shaders:Array<BitmapFilter>;
    var shaderNames:Array<String>;
}

typedef  NewNote = Note; typedef StrumNew = StrumNote;

class EditorLua {
	public static var Function_Stop:Dynamic = "##PSYCHLUA_FUNCTIONSTOP";
	public static var Function_Continue:Dynamic = "##PSYCHLUA_FUNCTIONCONTINUE";
	public static var Function_StopLua:Dynamic = "##PSYCHLUA_FUNCTIONSTOPLUA";

	public static var Function_StopHScript:Dynamic = "##PSYCHLUA_FUNCTIONSTOPHSCRIPT";
	public static var Function_StopAll:Dynamic = "##PSYCHLUA_FUNCTIONSTOPALL";

	//public var errorHandler:String->Void;
	#if LUA_ALLOWED
	public var lua:State = null;
	#end
	public var camTarget:FlxCamera;
	public var scriptName:String = '';
	public var closed:Bool = false;

	#if hscript
	public static var hscript:HScript = null;
	#end

	#if SScript
	public var ssHscript:SSHScriptEditor = null;
	#end
	public var callbacks:Map<String, Dynamic> = new Map<String, Dynamic>();
	public var playbackRate:Float = ClientPrefs.getGameplaySetting('songspeed', 1); //so i can make this auto instead of do it every lua ig?

	public static var lua_Cameras:Map<String, LuaCamera> = [];
	public static var lua_Shaders:Map<String, Shaders.ShaderEffectNew> = [];
	public static var lua_Custom_Shaders:Map<String, codenameengine.CustomCodeShader> = [];

	public function new(script:String) {
		#if LUA_ALLOWED
		lua_Cameras.set("game", {cam: EditorPlayState.instance.camGame, shaders: [], shaderNames: []});
		lua_Cameras.set("interfaz", {cam: EditorPlayState.instance.camInterfaz, shaders: [], shaderNames: []});
		lua_Cameras.set("visuals", {cam: EditorPlayState.instance.camVisuals, shaders: [], shaderNames: []});
		lua_Cameras.set("notecameras1", {cam: EditorPlayState.instance.noteCameras1, shaders: [], shaderNames: []});
		lua_Cameras.set("notecameras0", {cam: EditorPlayState.instance.noteCameras0, shaders: [], shaderNames: []});
		lua_Cameras.set("proxy", {cam: EditorPlayState.instance.camProxy, shaders: [], shaderNames: []});
		lua_Cameras.set("hud", {cam: EditorPlayState.instance.camHUD, shaders: [], shaderNames: []});
        lua_Cameras.set("other", {cam: EditorPlayState.instance.camOther, shaders: [], shaderNames: []});

		lua = LuaL.newstate();
		LuaL.openlibs(lua);
		Lua.init_callbacks(lua);

		//trace('Lua version: ' + Lua.version());
		//trace("LuaJIT version: " + Lua.versionJIT());

		//LuaL.dostring(lua, CLENSE);
		// script = scriptName.trim();
		// try{
		// 	var result:Dynamic = LuaL.dofile(lua, script);
		// 	var resultStr:String = Lua.tostring(lua, result);
		// 	if(resultStr != null && result != 0) {
		// 		trace('Error on lua script! ' + resultStr);
		// 		#if windows
		// 		lime.app.Application.current.window.alert(resultStr, 'Error on lua script!');
		// 		#else
		// 		luaTrace('Error loading lua script: "$script"\n' + resultStr, true, false, FlxColor.RED);
		// 		#end
		// 		lua = null;
		// 		return;
		// 	}
		// } catch(e:Dynamic) {
		// 	trace(e);
		// 	return;
		// }
		this.scriptName = script.trim();
		EditorPlayState.instance.luaArray.push(this);
		initHaxeModule();

		// trace('lua file loaded succesfully:' + script);

		// Lua shit
		set('Function_StopLua', Function_StopLua);
		set('Function_Stop', Function_Stop);
		set('Function_Continue', Function_Continue);
		set('luaDebugMode', false);
		set('luaDeprecatedWarnings', true);
		set('inChartEditor', true);

		// Song/Week shit
		set('curBpm', Conductor.bpm);
		set('bpm', PlayState.SONG.bpm);
		set('scrollSpeed', PlayState.SONG.speed);
		set('crochet', Conductor.crochet);
		set('stepCrochet', Conductor.stepCrochet);
		set('songLength', FlxG.sound.music.length);
		set('songName', PlayState.SONG.song);
		set('songPath', Paths.formatToSongPath(PlayState.SONG.song));
		set('startedCountdown', false);
		set('curStage', PlayState.SONG.stage);

		set('isStoryMode', PlayState.isStoryMode);
		set('difficulty', PlayState.storyDifficulty);

		var difficultyName:String = CoolUtil.difficulties[PlayState.storyDifficulty].toLowerCase();
		set('difficultyName', difficultyName);
		set('difficultyPath', Paths.formatToSongPath(difficultyName));
		set('weekRaw', PlayState.storyWeek);
		set('week', WeekData.weeksList[PlayState.storyWeek]);
		set('seenCutscene', PlayState.seenCutscene);

		// Camera poo
		set('cameraX', 0);
		set('cameraY', 0);

		// Screen stuff
		set('screenWidth', FlxG.width);
		set('screenHeight', FlxG.height);

		// PlayState cringe ass nae nae bullcrap
		set('curBeat', 0);
		set('curStep', 0);
		set('curDecBeat', 0);
		set('curDecStep', 0);

		set('score', 0);
		set('misses', 0);
		set('hits', 0);

		set('rating', 0);
		set('ratingName', '');
		set('ratingFC', '');
		set('version', MainMenuState.psychEngineVersion.trim());

		set('inGameOver', false);
		set('mustHitSection', false);
		set('altAnim', false);
		set('gfSection', false);

		// Gameplay settings
		set('healthGainMult', EditorPlayState.instance.healthGain);
		set('healthLossMult', EditorPlayState.instance.healthLoss);
		set('playbackRate', EditorPlayState.instance.playbackRate);
		set('instakillOnMiss', EditorPlayState.instance.instakillOnMiss);
		set('botPlay', EditorPlayState.instance.cpuControlled);
		set('practice', EditorPlayState.instance.practiceMode);
		set('modchart', EditorPlayState.instance.notITGMod);
		set('chaosMod', EditorPlayState.instance.chaosMod);
		set('chaosDiff', EditorPlayState.instance.chaosDifficulty);

		for (i in 0...4) {
			set('defaultPlayerStrumX' + i, 0);
			set('defaultPlayerStrumY' + i, 0);
			set('defaultOpponentStrumX' + i, 0);
			set('defaultOpponentStrumY' + i, 0);
		}

		// Default character positions woooo
		set('defaultBoyfriendX', EditorPlayState.instance.BF_X);
		set('defaultBoyfriendY', EditorPlayState.instance.BF_Y);
		set('defaultOpponentX', EditorPlayState.instance.DAD_X);
		set('defaultOpponentY', EditorPlayState.instance.DAD_Y);
		set('defaultGirlfriendX', EditorPlayState.instance.GF_X);
		set('defaultGirlfriendY', EditorPlayState.instance.GF_Y);

		// Character shit
		set('boyfriendName', PlayState.SONG.player1);
		set('dadName', PlayState.SONG.player2);
		set('gfName', PlayState.SONG.gfVersion);

		// Some settings, no jokes
		set('downscroll', ClientPrefs.downScroll);
		set('middlescroll', ClientPrefs.middleScroll);
		set('framerate', ClientPrefs.framerate);
		set('ghostTapping', ClientPrefs.ghostTapping);
		set('hideHud', ClientPrefs.hideHud);
		set('timeBarType', ClientPrefs.timeBarType);
		set('scoreZoom', ClientPrefs.scoreZoom);
		set('cameraZoomOnBeat', ClientPrefs.camZooms);
		set('flashingLights', ClientPrefs.flashing);
		set('noteOffset', ClientPrefs.noteOffset);
		set('healthBarAlpha', ClientPrefs.healthBarAlpha);
		set('noResetButton', ClientPrefs.noReset);
		set('lowQuality', ClientPrefs.lowQuality);
		set('shadersEnabled', ClientPrefs.shaders);
		set('scriptName', scriptName);
		set('currentModDirectory', Mods.currentModDirectory);

		#if windows
		set('buildTarget', 'windows');
		#elseif linux
		set('buildTarget', 'linux');
		#elseif mac
		set('buildTarget', 'mac');
		#elseif html5
		set('buildTarget', 'browser');
		#elseif android
		set('buildTarget', 'android');
		#else
		set('buildTarget', 'unknown');
		#end
		
		// custom substate
		Lua_helper.add_callback(lua, "openCustomSubstate", function(name:String, pauseGame:Bool = false) {
			if(pauseGame)
			{
				EditorPlayState.instance.persistentUpdate = false;
				EditorPlayState.instance.persistentDraw = true;
				EditorPlayState.instance.paused = true;
				if(FlxG.sound.music != null) {
					FlxG.sound.music.pause();
					EditorPlayState.instance.vocals.pause();
				}
			}
			EditorPlayState.instance.openSubState(new CustomSubstate(name));
		});

		Lua_helper.add_callback(lua, "closeCustomSubstate", function() {
			if(CustomSubstate.instance != null)
			{
				EditorPlayState.instance.closeSubState();
				CustomSubstate.instance = null;
				return true;
			}
			return false;
		});

		// shader shit
		Lua_helper.add_callback(lua, "initLuaShader", function(name:String, classString:String, ?glslVersion:Int = 120) {
			if(!ClientPrefs.shaders) return false;

			#if (!flash && MODS_ALLOWED && sys)
			return initLuaShader(name, glslVersion);
			#else
			luaTrace("initLuaShader: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
			return false;
		});
		
		Lua_helper.add_callback(lua, "setSpriteShader", function(obj:String, shader:String) {
			if(!ClientPrefs.shaders) return false;

			#if (!flash && MODS_ALLOWED && sys)
			if(!EditorPlayState.instance.runtimeShaders.exists(shader) && !initLuaShader(shader))
			{
				luaTrace('setSpriteShader: Shader $shader is missing!', false, false, FlxColor.RED);
				return false;
			}

			var killMe:Array<String> = obj.split('.');
			var leObj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				leObj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(leObj != null) {
				var arr:Array<String> = EditorPlayState.instance.runtimeShaders.get(shader);
				leObj.shader = new FlxRuntimeShader(arr[0], arr[1]);
				return true;
			}
			#else
			luaTrace("setSpriteShader: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
			return false;
		});
		Lua_helper.add_callback(lua, "removeSpriteShader", function(obj:String) {
			var killMe:Array<String> = obj.split('.');
			var leObj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				leObj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(leObj != null) {
				leObj.shader = null;
				return true;
			}
			return false;
		});


		Lua_helper.add_callback(lua, "getShaderBool", function(obj:String, prop:String) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if (shader == null)
			{
				Lua.pushnil(lua);
				return null;
			}
			return shader.getBool(prop);
			#else
			luaTrace("getShaderBool: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
			#end
		});
		Lua_helper.add_callback(lua, "getShaderBoolArray", function(obj:String, prop:String) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if (shader == null)
			{
				Lua.pushnil(lua);
				return null;
			}
			return shader.getBoolArray(prop);
			#else
			luaTrace("getShaderBoolArray: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
			#end
		});
		Lua_helper.add_callback(lua, "getShaderInt", function(obj:String, prop:String) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if (shader == null)
			{
				Lua.pushnil(lua);
				return null;
			}
			return shader.getInt(prop);
			#else
			luaTrace("getShaderInt: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
			#end
		});
		Lua_helper.add_callback(lua, "getShaderIntArray", function(obj:String, prop:String) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if (shader == null)
			{
				Lua.pushnil(lua);
				return null;
			}
			return shader.getIntArray(prop);
			#else
			luaTrace("getShaderIntArray: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
			#end
		});
		Lua_helper.add_callback(lua, "getShaderFloat", function(obj:String, prop:String) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if (shader == null)
			{
				Lua.pushnil(lua);
				return null;
			}
			return shader.getFloat(prop);
			#else
			luaTrace("getShaderFloat: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
			#end
		});
		Lua_helper.add_callback(lua, "getShaderFloatArray", function(obj:String, prop:String) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if (shader == null)
			{
				Lua.pushnil(lua);
				return null;
			}
			return shader.getFloatArray(prop);
			#else
			luaTrace("getShaderFloatArray: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
			#end
		});


		Lua_helper.add_callback(lua, "setShaderBool", function(obj:String, prop:String, value:Bool) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if(shader == null) return;

			shader.setBool(prop, value);
			#else
			luaTrace("setShaderBool: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});
		Lua_helper.add_callback(lua, "setShaderBoolArray", function(obj:String, prop:String, values:Dynamic) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if(shader == null) return;

			shader.setBoolArray(prop, values);
			#else
			luaTrace("setShaderBoolArray: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});
		Lua_helper.add_callback(lua, "setShaderInt", function(obj:String, prop:String, value:Int) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if(shader == null) return;

			shader.setInt(prop, value);
			#else
			luaTrace("setShaderInt: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});
		Lua_helper.add_callback(lua, "setShaderIntArray", function(obj:String, prop:String, values:Dynamic) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if(shader == null) return;

			shader.setIntArray(prop, values);
			#else
			luaTrace("setShaderIntArray: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});
		Lua_helper.add_callback(lua, "setShaderFloat", function(obj:String, prop:String, value:Float) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if(shader == null) return;

			shader.setFloat(prop, value);
			#else
			luaTrace("setShaderFloat: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});
		Lua_helper.add_callback(lua, "setShaderFloatArray", function(obj:String, prop:String, values:Dynamic) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if(shader == null) return;

			shader.setFloatArray(prop, values);
			#else
			luaTrace("setShaderFloatArray: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});

		Lua_helper.add_callback(lua, "setShaderSampler2D", function(obj:String, prop:String, bitmapdataPath:String) {
			#if (!flash && MODS_ALLOWED && sys)
			var shader:FlxRuntimeShader = getShader(obj);
			if(shader == null) return;

			// trace('bitmapdatapath: $bitmapdataPath');
			var value = Paths.image(bitmapdataPath);
			if(value != null && value.bitmap != null)
			{
				// trace('Found bitmapdata. Width: ${value.bitmap.width} Height: ${value.bitmap.height}');
				shader.setSampler2D(prop, value.bitmap);
			}
			#else
			luaTrace("setShaderSampler2D: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});


		// Lua_helper.add_callback(lua,"setCameraLuaShader", function(camStr:String, shaderName:String) {
        //     if (!ClientPrefs.shaders)
        //         return;
        //     var cam = getCameraByName(camStr);
        //     var shad = EditorPlayState.instance.runtimeShaders.exists(shaderName);

        //     if(cam != null && shad != null)
        //     {
        //         cam.shaders.push(new ShaderFilter(Reflect.getProperty(shad, 'shader'))); //use reflect to workaround compiler errors
        //         cam.shaderNames.push(shaderName);
        //         cam.cam.setFilters(cam.shaders);
        //         //trace('added shader '+shaderName+" to " + camStr);
        //     }
        // });

		Lua_helper.add_callback(lua, "tweenLuaShader", function(tag:String, usedShader:String, prop:String, val:Float , time:Float, easeStr:String = "linear") {
			#if (!flash && MODS_ALLOWED && sys)
			var exist:Dynamic = EditorPlayState.instance.runtimeShaders.exists(usedShader);
			var easing = getFlxEaseByString(easeStr);
			if (exist != null){
				var shader = EditorPlayState.instance.runtimeShaders.get(usedShader);
				var name = prop;
    			var sertProperty = 'shader.${name}.value';
    			var serted = 'shader.${name}';
        		if (Type.typeof(serted) == null) return;
        		if (Type.typeof(sertProperty) == null) Type.typeof('shader.${name}.value = [0];');
        		EditorPlayState.instance.modchartTweens.set(tag, FlxTween.num(Std.parseFloat('shader.${name}.value[0]'), val, time, {
           			ease: easing,
            		onComplete: function(test:FlxTween){
						// Std.parseFloat('shader.${name}.value[0]') = val;
            			EditorPlayState.instance.runtimeShaders.remove(tag);
            			EditorPlayState.instance.callOnLuas("onTweenCompleted", [tag, name]);
        			}
    			}));
			}else{
				luaTrace('tweenShaders: Couldnt find shader: ' + usedShader, false, false, FlxColor.RED);
			}
			#else
				luaTrace("tweenShaders: Platform unsupported for Runtime Shaders!", false, false, FlxColor.RED);
			#end
		});


		//
		Lua_helper.add_callback(lua, "getRunningScripts", function(){
			var runningScripts:Array<String> = [];
			for (idx in 0...EditorPlayState.instance.luaArray.length)
				runningScripts.push(EditorPlayState.instance.luaArray[idx].scriptName);


			return runningScripts;
		});

		Lua_helper.add_callback(lua, "callOnLuas", function(?funcName:String, ?args:Array<Dynamic>, ignoreStops=false, ignoreSelf=true, ?exclusions:Array<String>){
			if(funcName==null){
				#if (linc_luajit >= "0.0.6")
				LuaL.error(lua, "bad argument #1 to 'callOnLuas' (string expected, got nil)");
				#end
				return;
			}
			if(args==null)args = [];

			if(exclusions==null)exclusions=[];

			Lua.getglobal(lua, 'scriptName');
			var daScriptName = Lua.tostring(lua, -1);
			Lua.pop(lua, 1);
			if(ignoreSelf && !exclusions.contains(daScriptName))exclusions.push(daScriptName);
			EditorPlayState.instance.callOnLuas(funcName, args, ignoreStops, exclusions);
		});

		Lua_helper.add_callback(lua, "callScript", function(?luaFile:String, ?funcName:String, ?args:Array<Dynamic>){
			if(luaFile==null){
				#if (linc_luajit >= "0.0.6")
				LuaL.error(lua, "bad argument #1 to 'callScript' (string expected, got nil)");
				#end
				return;
			}
			if(funcName==null){
				#if (linc_luajit >= "0.0.6")
				LuaL.error(lua, "bad argument #2 to 'callScript' (string expected, got nil)");
				#end
				return;
			}
			if(args==null){
				args = [];
			}
			var cervix = luaFile + ".lua";
			if(luaFile.endsWith(".lua"))cervix=luaFile;
			var doPush = false;
			#if MODS_ALLOWED
			if(FileSystem.exists(Paths.modFolders(cervix)))
			{
				cervix = Paths.modFolders(cervix);
				doPush = true;
			}
			else if(FileSystem.exists(cervix))
			{
				doPush = true;
			}
			else {
				cervix = Paths.getPreloadPath(cervix);
				if(FileSystem.exists(cervix)) {
					doPush = true;
				}
			}
			#else
			cervix = Paths.getPreloadPath(cervix);
			if(Assets.exists(cervix)) {
				doPush = true;
			}
			#end
			if(doPush)
			{
				for (luaInstance in EditorPlayState.instance.luaArray)
				{
					if(luaInstance.scriptName == cervix)
					{
						luaInstance.call(funcName, args);

						return;
					}

				}
			}
			Lua.pushnil(lua);

		});

		Lua_helper.add_callback(lua, "getGlobalFromScript", function(?luaFile:String, ?global:String){ // returns the global from a script
			if(luaFile==null){
				#if (linc_luajit >= "0.0.6")
				LuaL.error(lua, "bad argument #1 to 'getGlobalFromScript' (string expected, got nil)");
				#end
				return;
			}
			if(global==null){
				#if (linc_luajit >= "0.0.6")
				LuaL.error(lua, "bad argument #2 to 'getGlobalFromScript' (string expected, got nil)");
				#end
				return;
			}
			var cervix = luaFile + ".lua";
			if(luaFile.endsWith(".lua"))cervix=luaFile;
			var doPush = false;
			#if MODS_ALLOWED
			if(FileSystem.exists(Paths.modFolders(cervix)))
			{
				cervix = Paths.modFolders(cervix);
				doPush = true;
			}
			else if(FileSystem.exists(cervix))
			{
				doPush = true;
			}
			else {
				cervix = Paths.getPreloadPath(cervix);
				if(FileSystem.exists(cervix)) {
					doPush = true;
				}
			}
			#else
			cervix = Paths.getPreloadPath(cervix);
			if(Assets.exists(cervix)) {
				doPush = true;
			}
			#end
			if(doPush)
			{
				for (luaInstance in EditorPlayState.instance.luaArray)
				{
					if(luaInstance.scriptName == cervix)
					{
						Lua.getglobal(luaInstance.lua, global);
						if(Lua.isnumber(luaInstance.lua,-1)){
							Lua.pushnumber(lua, Lua.tonumber(luaInstance.lua, -1));
						}else if(Lua.isstring(luaInstance.lua,-1)){
							Lua.pushstring(lua, Lua.tostring(luaInstance.lua, -1));
						}else if(Lua.isboolean(luaInstance.lua,-1)){
							Lua.pushboolean(lua, Lua.toboolean(luaInstance.lua, -1));
						}else{
							Lua.pushnil(lua);
						}
						// TODO: table

						Lua.pop(luaInstance.lua,1); // remove the global

						return;
					}

				}
			}
			Lua.pushnil(lua);
		});
		Lua_helper.add_callback(lua, "setGlobalFromScript", function(luaFile:String, global:String, val:Dynamic){ // returns the global from a script
			var cervix = luaFile + ".lua";
			if(luaFile.endsWith(".lua"))cervix=luaFile;
			var doPush = false;
			#if MODS_ALLOWED
			if(FileSystem.exists(Paths.modFolders(cervix)))
			{
				cervix = Paths.modFolders(cervix);
				doPush = true;
			}
			else if(FileSystem.exists(cervix))
			{
				doPush = true;
			}
			else {
				cervix = Paths.getPreloadPath(cervix);
				if(FileSystem.exists(cervix)) {
					doPush = true;
				}
			}
			#else
			cervix = Paths.getPreloadPath(cervix);
			if(Assets.exists(cervix)) {
				doPush = true;
			}
			#end
			if(doPush)
			{
				for (luaInstance in EditorPlayState.instance.luaArray)
				{
					if(luaInstance.scriptName == cervix)
					{
						luaInstance.set(global, val);
					}

				}
			}
			Lua.pushnil(lua);
		});
		/*Lua_helper.add_callback(lua, "getGlobals", function(luaFile:String){ // returns a copy of the specified file's globals
			var cervix = luaFile + ".lua";
			if(luaFile.endsWith(".lua"))cervix=luaFile;
			var doPush = false;
			#if MODS_ALLOWED
			if(FileSystem.exists(Paths.modFolders(cervix)))
			{
				cervix = Paths.modFolders(cervix);
				doPush = true;
			}
			else if(FileSystem.exists(cervix))
			{
				doPush = true;
			}
			else {
				cervix = Paths.getPreloadPath(cervix);
				if(FileSystem.exists(cervix)) {
					doPush = true;
				}
			}
			#else
			cervix = Paths.getPreloadPath(cervix);
			if(Assets.exists(cervix)) {
				doPush = true;
			}
			#end
			if(doPush)
			{
				for (luaInstance in EditorPlayState.instance.luaArray)
				{
					if(luaInstance.scriptName == cervix)
					{
						Lua.newtable(lua);
						var tableIdx = Lua.gettop(lua);

						Lua.pushvalue(luaInstance.lua, Lua.LUA_GLOBALSINDEX);
						Lua.pushnil(luaInstance.lua);
						while(Lua.next(luaInstance.lua, -2) != 0) {
							// key = -2
							// value = -1

							var pop:Int = 0;

							// Manual conversion
							// first we convert the key
							if(Lua.isnumber(luaInstance.lua,-2)){
								Lua.pushnumber(lua, Lua.tonumber(luaInstance.lua, -2));
								pop++;
							}else if(Lua.isstring(luaInstance.lua,-2)){
								Lua.pushstring(lua, Lua.tostring(luaInstance.lua, -2));
								pop++;
							}else if(Lua.isboolean(luaInstance.lua,-2)){
								Lua.pushboolean(lua, Lua.toboolean(luaInstance.lua, -2));
								pop++;
							}
							// TODO: table


							// then the value
							if(Lua.isnumber(luaInstance.lua,-1)){
								Lua.pushnumber(lua, Lua.tonumber(luaInstance.lua, -1));
								pop++;
							}else if(Lua.isstring(luaInstance.lua,-1)){
								Lua.pushstring(lua, Lua.tostring(luaInstance.lua, -1));
								pop++;
							}else if(Lua.isboolean(luaInstance.lua,-1)){
								Lua.pushboolean(lua, Lua.toboolean(luaInstance.lua, -1));
								pop++;
							}
							// TODO: table

							if(pop==2)Lua.rawset(lua, tableIdx); // then set it
							Lua.pop(luaInstance.lua, 1); // for the loop
						}
						Lua.pop(luaInstance.lua,1); // end the loop entirely
						Lua.pushvalue(lua, tableIdx); // push the table onto the stack so it gets returned

						return;
					}

				}
			}
			Lua.pushnil(lua);
		});*/
		/*Lua_helper.add_callback(lua, 'addWindowTransparency', function(value:Dynamic){
        	#if desktop
			var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(24, 24, 24));
			bg.cameras = [EditorPlayState.instance.camGame];
			{
				bg.scale.scale(1 / EditorPlayState.instance.defaultCamZoom);
		  	}
		  	bg.scrollFactor.set();
			if (value == true){
				getInstance().add(bg);
				FlxTransWindow.getWindowsTransparent();
			}else{
				getInstance().remove(bg);
				FlxTransWindow.getWindowsbackward();
			}
			#else
			luaTrace("WindowsModifiers: Transparency, can't add transparency since device its not supported!", false, false, FlxColor.RED);
			#end
			return false;
		});
		#if desktop
		Lua_helper.add_callback(lua, 'setWindowModifier', function(modifier:Dynamic, value:Int){
			//this is kinda hard but cmon if it does what i want, come here code! -Ed
			switch(modifier)
			{
				case 'Xmodifier' | 'xmodifier' | 'X' | 'x':
					Lib.application.window.x = value;
				case 'Ymodifier' | 'ymodifier' | 'Y' | 'y':
					Lib.application.window.y = value;
				default:
					Lib.application.window.x = 0;
					Lib.application.window.y = 0;
					luaTrace("WindowsModifiers: nonExistent modifier name", false, false, FlxColor.WHITE);
			}
		});
		#end
		#if desktop
		Lua_helper.add_callback(lua, 'easeWindowModifier', function(modifier:Dynamic, value:Int, duration:Int, ease:String){
			//this is kinda hard but cmon if it does what i want, come here code! -Ed
			switch(modifier)
			{
				case 'Xmodifier' | 'xmodifier' | 'X' | 'x':
					FlxTween.tween(Lib.application.window, {x: value}, duration, {ease: getFlxEaseByString(ease)});
				case 'Ymodifier' | 'ymodifier' | 'Y' | 'y':
					FlxTween.tween(Lib.application.window, {y: value}, duration, {ease: getFlxEaseByString(ease)});
				default:
					FlxTween.tween(Lib.application.window, {x: 0}, 1, {ease:FlxEase.sineInOut});
					FlxTween.tween(Lib.application.window, {y: 0}, 1, {ease:FlxEase.sineInOut});
					luaTrace("WindowsModifiers: nonExistent modifier name", false, false, FlxColor.WHITE);
			}
		});
		#end*/
		Lua_helper.add_callback(lua, "isRunning", function(luaFile:String){
			var cervix = luaFile + ".lua";
			if(luaFile.endsWith(".lua"))cervix=luaFile;
			var doPush = false;
			#if MODS_ALLOWED
			if(FileSystem.exists(Paths.modFolders(cervix)))
			{
				cervix = Paths.modFolders(cervix);
				doPush = true;
			}
			else if(FileSystem.exists(cervix))
			{
				doPush = true;
			}
			else {
				cervix = Paths.getPreloadPath(cervix);
				if(FileSystem.exists(cervix)) {
					doPush = true;
				}
			}
			#else
			cervix = Paths.getPreloadPath(cervix);
			if(Assets.exists(cervix)) {
				doPush = true;
			}
			#end

			if(doPush)
			{
				for (luaInstance in EditorPlayState.instance.luaArray)
				{
					if(luaInstance.scriptName == cervix)
						return true;

				}
			}
			return false;
		});


		Lua_helper.add_callback(lua, "addLuaScript", function(luaFile:String, ?ignoreAlreadyRunning:Bool = false) { //would be dope asf.
			var cervix = luaFile + ".lua";
			if(luaFile.endsWith(".lua"))cervix=luaFile;
			var doPush = false;
			#if MODS_ALLOWED
			if(FileSystem.exists(Paths.modFolders(cervix)))
			{
				cervix = Paths.modFolders(cervix);
				doPush = true;
			}
			else if(FileSystem.exists(cervix))
			{
				doPush = true;
			}
			else {
				cervix = Paths.getPreloadPath(cervix);
				if(FileSystem.exists(cervix)) {
					doPush = true;
				}
			}
			#else
			cervix = Paths.getPreloadPath(cervix);
			if(Assets.exists(cervix)) {
				doPush = true;
			}
			#end

			if(doPush)
			{
				if(!ignoreAlreadyRunning)
				{
					for (luaInstance in EditorPlayState.instance.luaArray)
					{
						if(luaInstance.scriptName == cervix)
						{
							luaTrace('addLuaScript: The script "' + cervix + '" is already running!');
							return;
						}
					}
				}
				EditorPlayState.instance.luaArray.push(new EditorLua(cervix));
				return;
			}
			luaTrace("addLuaScript: Script doesn't exist!", false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "removeLuaScript", function(luaFile:String, ?ignoreAlreadyRunning:Bool = false) { //would be dope asf.
			var cervix = luaFile + ".lua";
			if(luaFile.endsWith(".lua"))cervix=luaFile;
			var doPush = false;
			#if MODS_ALLOWED
			if(FileSystem.exists(Paths.modFolders(cervix)))
			{
				cervix = Paths.modFolders(cervix);
				doPush = true;
			}
			else if(FileSystem.exists(cervix))
			{
				doPush = true;
			}
			else {
				cervix = Paths.getPreloadPath(cervix);
				if(FileSystem.exists(cervix)) {
					doPush = true;
				}
			}
			#else
			cervix = Paths.getPreloadPath(cervix);
			if(Assets.exists(cervix)) {
				doPush = true;
			}
			#end

			if(doPush)
			{
				if(!ignoreAlreadyRunning)
				{
					for (luaInstance in EditorPlayState.instance.luaArray)
					{
						if(luaInstance.scriptName == cervix)
						{
							//luaTrace('The script "' + cervix + '" is already running!');

								EditorPlayState.instance.luaArray.remove(luaInstance);
							return;
						}
					}
				}
				return;
			}
			luaTrace("removeLuaScript: Script doesn't exist!", false, false, FlxColor.RED);
		});

		Lua_helper.add_callback(lua, "runHaxeCode", function(codeToRun:String) {
			var retVal:Dynamic = null;

			#if hscript
			initHaxeModule();
			try {
				retVal = hscript.execute(codeToRun);
			}
			catch (e:Dynamic) {
				luaTrace(scriptName + ":" + lastCalledFunction + " - " + e, false, false, FlxColor.RED);
			}
			#else
			luaTrace("runHaxeCode: HScript isn't supported on this platform!", false, false, FlxColor.RED);
			#end

			if(retVal != null && !isOfTypes(retVal, [Bool, Int, Float, String, Array])) retVal = null;
			if(retVal == null) Lua.pushnil(lua);
			return retVal;
		});

		Lua_helper.add_callback(lua, "addHaxeLibrary", function(libName:String, ?libPackage:String = '') {
			#if hscript
			initHaxeModule();
			try {
				var str:String = '';
				if(libPackage.length > 0)
					str = libPackage + '.';

				hscript.variables.set(libName, Type.resolveClass(str + libName));
			}
			catch (e:Dynamic) {
				luaTrace(scriptName + ":" + lastCalledFunction + " - " + e, false, false, FlxColor.RED);
			}
			#end
		});

		Lua_helper.add_callback(lua, "loadSong", function(?name:String = null, ?difficultyNum:Int = -1) {
			if(name == null || name.length < 1)
				name = PlayState.SONG.song;
			if (difficultyNum == -1)
				difficultyNum = PlayState.storyDifficulty;

			var poop = Highscore.formatSong(name, difficultyNum);
			Song.loadFromJson(poop, name);
			PlayState.storyDifficulty = difficultyNum;
			EditorPlayState.instance.persistentUpdate = false;
			LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.pause();
			FlxG.sound.music.volume = 0;
			if(EditorPlayState.instance.vocals != null)
			{
				EditorPlayState.instance.vocals.pause();
				EditorPlayState.instance.vocals.volume = 0;
			}
		});

		Lua_helper.add_callback(lua, "loadGraphic", function(variable:String, image:String, ?gridX:Int = 0, ?gridY:Int = 0) {
			var killMe:Array<String> = variable.split('.');
			var spr:FlxSprite = getObjectDirectly(killMe[0]);
			var animated = gridX != 0 || gridY != 0;

			if(killMe.length > 1) {
				spr = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(spr != null && image != null && image.length > 0)
			{
				spr.loadGraphic(Paths.image(image), animated, gridX, gridY);
			}
		});
		Lua_helper.add_callback(lua, "loadFrames", function(variable:String, image:String, spriteType:String = "sparrow") {
			var killMe:Array<String> = variable.split('.');
			var spr:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				spr = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(spr != null && image != null && image.length > 0)
			{
				loadFrames(spr, image, spriteType);
			}
		});

		Lua_helper.add_callback(lua, "getProperty", function(variable:String) {
			var result:Dynamic = null;
			var killMe:Array<String> = variable.split('.');
			if(killMe.length > 1)
				result = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			else
				result = getVarInArray(getInstance(), variable);

			if(result == null) Lua.pushnil(lua);
			return result;
		});
		Lua_helper.add_callback(lua, "setProperty", function(variable:String, value:Dynamic) {
			var killMe:Array<String> = variable.split('.');
			if(killMe.length > 1) {
				setVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1], value);
				return true;
			}
			setVarInArray(getInstance(), variable, value);
			return true;
		});
		Lua_helper.add_callback(lua, "getPropertyFromGroup", function(obj:String, index:Int, variable:Dynamic) {
			var shitMyPants:Array<String> = obj.split('.');
			var realObject:Dynamic = Reflect.getProperty(getInstance(), obj);
			if(shitMyPants.length>1)
				realObject = getPropertyLoopThingWhatever(shitMyPants, true, false);


			if(Std.isOfType(realObject, FlxTypedGroup))
			{
				var result:Dynamic = getGroupStuff(realObject.members[index], variable);
				if(result == null) Lua.pushnil(lua);
				return result;
			}


			var leArray:Dynamic = realObject[index];
			if(leArray != null) {
				var result:Dynamic = null;
				if(Type.typeof(variable) == ValueType.TInt)
					result = leArray[variable];
				else
					result = getGroupStuff(leArray, variable);

				if(result == null) Lua.pushnil(lua);
				return result;
			}
			luaTrace("getPropertyFromGroup: Object #" + index + " from group: " + obj + " doesn't exist!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
		});
		Lua_helper.add_callback(lua, "setPropertyFromGroup", function(obj:String, index:Int, variable:Dynamic, value:Dynamic) {
			var shitMyPants:Array<String> = obj.split('.');
			var realObject:Dynamic = Reflect.getProperty(getInstance(), obj);
			if(shitMyPants.length>1)
				realObject = getPropertyLoopThingWhatever(shitMyPants, true, false);

			if(Std.isOfType(realObject, FlxTypedGroup)) {
				setGroupStuff(realObject.members[index], variable, value);
				return;
			}

			var leArray:Dynamic = realObject[index];
			if(leArray != null) {
				if(Type.typeof(variable) == ValueType.TInt) {
					leArray[variable] = value;
					return;
				}
				setGroupStuff(leArray, variable, value);
			}
		});
		Lua_helper.add_callback(lua, "removeFromGroup", function(obj:String, index:Int, dontDestroy:Bool = false) {
			if(Std.isOfType(Reflect.getProperty(getInstance(), obj), FlxTypedGroup)) {
				var sex = Reflect.getProperty(getInstance(), obj).members[index];
				if(!dontDestroy)
					sex.kill();
				Reflect.getProperty(getInstance(), obj).remove(sex, true);
				if(!dontDestroy)
					sex.destroy();
				return;
			}
			Reflect.getProperty(getInstance(), obj).remove(Reflect.getProperty(getInstance(), obj)[index]);
		});

		Lua_helper.add_callback(lua, "getPropertyFromClass", function(classVar:String, variable:String) {
			@:privateAccess
			var killMe:Array<String> = variable.split('.');
			if(killMe.length > 1) {
				var coverMeInPiss:Dynamic = getVarInArray(Type.resolveClass(classVar), killMe[0]);
				for (i in 1...killMe.length-1) {
					coverMeInPiss = getVarInArray(coverMeInPiss, killMe[i]);
				}
				return getVarInArray(coverMeInPiss, killMe[killMe.length-1]);
			}
			return getVarInArray(Type.resolveClass(classVar), variable);
		});
		Lua_helper.add_callback(lua, "setPropertyFromClass", function(classVar:String, variable:String, value:Dynamic) {
			@:privateAccess
			var killMe:Array<String> = variable.split('.');
			if(killMe.length > 1) {
				var coverMeInPiss:Dynamic = getVarInArray(Type.resolveClass(classVar), killMe[0]);
				for (i in 1...killMe.length-1) {
					coverMeInPiss = getVarInArray(coverMeInPiss, killMe[i]);
				}
				setVarInArray(coverMeInPiss, killMe[killMe.length-1], value);
				return true;
			}
			setVarInArray(Type.resolveClass(classVar), variable, value);
			return true;
		});

		//shitass stuff for epic coders like me B)  *image of obama giving himself a medal*
		Lua_helper.add_callback(lua, "getObjectOrder", function(obj:String) {
			var killMe:Array<String> = obj.split('.');
			var leObj:FlxBasic = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				leObj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(leObj != null)
			{
				return getInstance().members.indexOf(leObj);
			}
			luaTrace("getObjectOrder: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
			return -1;
		});
		Lua_helper.add_callback(lua, "setObjectOrder", function(obj:String, position:Int) {
			var killMe:Array<String> = obj.split('.');
			var leObj:FlxBasic = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				leObj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(leObj != null) {
				getInstance().remove(leObj, true);
				getInstance().insert(position, leObj);
				return;
			}
			luaTrace("setObjectOrder: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
		});

		// gay ass tweens
		Lua_helper.add_callback(lua, "doTweenX", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String) {
			var penisExam:Dynamic = tweenShit(tag, vars);
			if(penisExam != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(penisExam, {x: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			} else {
				luaTrace('doTweenX: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});
		Lua_helper.add_callback(lua, "doTweenY", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String) {
			var penisExam:Dynamic = tweenShit(tag, vars);
			if(penisExam != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(penisExam, {y: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			} else {
				luaTrace('doTweenY: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});
		Lua_helper.add_callback(lua, "doTweenAngle", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String) {
			var penisExam:Dynamic = tweenShit(tag, vars);
			if(penisExam != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(penisExam, {angle: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			} else {
				luaTrace('doTweenAngle: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});
		Lua_helper.add_callback(lua, "doTweenAlpha", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String) {
			var penisExam:Dynamic = tweenShit(tag, vars);
			if(penisExam != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(penisExam, {alpha: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			} else {
				luaTrace('doTweenAlpha: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});
		Lua_helper.add_callback(lua, "doTweenZoom", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String) {
			var penisExam:Dynamic = tweenShit(tag, vars);
			if(penisExam != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(penisExam, {zoom: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			} else {
				luaTrace('doTweenZoom: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});
		Lua_helper.add_callback(lua, "doTweenColor", function(tag:String, vars:String, targetColor:String, duration:Float, ease:String) {
			var penisExam:Dynamic = tweenShit(tag, vars);
			if(penisExam != null) {
				var color:Int = Std.parseInt(targetColor);
				if(!targetColor.startsWith('0x')) color = Std.parseInt('0xff' + targetColor);

				var curColor:FlxColor = penisExam.color;
				curColor.alphaFloat = penisExam.alpha;
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.color(penisExam, duration/playbackRate, curColor, color, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.modchartTweens.remove(tag);
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
					}
				}));
			} else {
				luaTrace('doTweenColor: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});

		//Tween shit, but for strums
		Lua_helper.add_callback(lua, "noteTweenX", function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String) {
			cancelTween(tag);
			if(note < 0) note = 0;
			var testicle:StrumNote = EditorPlayState.instance.strumLineNotes.members[note % EditorPlayState.instance.strumLineNotes.length];

			if(testicle != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(testicle, {x: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			}
		});
		Lua_helper.add_callback(lua, "noteTweenY", function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String) {
			cancelTween(tag);
			if(note < 0) note = 0;
			var testicle:StrumNote = EditorPlayState.instance.strumLineNotes.members[note % EditorPlayState.instance.strumLineNotes.length];

			if(testicle != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(testicle, {y: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			}
		});
		Lua_helper.add_callback(lua, "noteTweenAngle", function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String) {
			cancelTween(tag);
			if(note < 0) note = 0;
			var testicle:StrumNote = EditorPlayState.instance.strumLineNotes.members[note % EditorPlayState.instance.strumLineNotes.length];

			if(testicle != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(testicle, {angle: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			}
		});
		Lua_helper.add_callback(lua, "noteTweenDirection", function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String) {
			cancelTween(tag);
			if(note < 0) note = 0;
			var testicle:StrumNote = EditorPlayState.instance.strumLineNotes.members[note % EditorPlayState.instance.strumLineNotes.length];

			if(testicle != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(testicle, {direction: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			}
		});

		//New tweens lol
		Lua_helper.add_callback(lua, "tweenObj", function(type:String, beat:Float, tag:String, vars:String, subVars:String, value:Dynamic, duration:Float, ease:String, mode:Bool = false){
			var playbackRate:Float = EditorPlayState.instance.playbackRate;
			var penisExam:Dynamic = tweenShit(tag, vars);
			var time:Float = !mode ? duration : duration*Conductor.crochet*0.001;
			time /= playbackRate;
			if (type == null || type == '') type = 'ease';
			if(penisExam != null) 
			{
				EditorPlayState.instance.tweenEventManager.addTweenEvent(beat, function(){
					if (Conductor.songPosition >= getTimeFromBeat(beat)+(time*1000)) //cancel if should have ended
					{
						switch (subVars.toLowerCase()) {
							case 'x':
								if (type == 'ease') penisExam.x = value;
								else if (type == 'add') penisExam.x += value;
							case 'y':
								if (type == 'ease') penisExam.y = value;
								else if (type == 'add') penisExam.y += value;
							case 'angle':
								if (type == 'ease') penisExam.angle = value;
								else if (type == 'add') penisExam.angle += value;
							case 'alpha':
								if (type == 'ease') penisExam.alpha = value;
								else if (type == 'add') penisExam.alpha += value;
							case 'zoom':
								if (Std.isOfType(penisExam, FlxCamera))
								{
									if (type == 'ease') penisExam.zoom = value;
									else if (type == 'add') penisExam.zoom += value;
								}
								else luaTrace('tweenObj: Tried to tween zoom on an object that is not a Camera', false, false, FlxColor.RED);
							case 'skewX':
								if (Std.isOfType(penisExam, FlxSkewedSprite)) 
								{
									if (type == 'ease') penisExam.skew.x = value;
									else if (type == 'add') penisExam.skew.x += value;
								}
								else luaTrace('tweenObj: Tried to tween skewX on an object that is not a SkewedSprite', false, false, FlxColor.RED);
							case 'skewY':
								if (Std.isOfType(penisExam, FlxSkewedSprite)) 
								{
									if (type == 'ease') penisExam.skew.y = value;
									else if (type == 'add') penisExam.skew.y += value;
								}
								else luaTrace('tweenObj: Tried to tween skewY on an object that is not a SkewedSprite', false, false, FlxColor.RED);
							case 'skew':
								if (Std.isOfType(penisExam, FlxSkewedSprite)) 
								{
									if (type == 'ease') 
									{
										penisExam.skew.x = value;
										penisExam.skew.y = value;
									}
									else if (type == 'add') 
									{
										penisExam.skew.x += value;
										penisExam.skew.y += value;
									}
								}
								else luaTrace('tweenObj: Tried to tween skew on an object that is not a SkewedSprite', false, false, FlxColor.RED);
							case 'scaleX':
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										if (type == 'ease') penisExam.flashSprite.scaleX = value;
										else if (type == 'add') penisExam.flashSprite.scaleX += value;
									}
									else luaTrace('tweenObj: Tried to tween scaleX a camera\'s null flashSprite', false, false, FlxColor.RED);
								}else{
									if (type == 'ease') penisExam.scale.x = value;
									else if (type == 'add') penisExam.scale.x += value;
								}
							case 'scaleY':
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										if (type == 'ease') penisExam.flashSprite.scaleY = value;
										else if (type == 'add') penisExam.flashSprite.scaleY += value;
									}
									else luaTrace('tweenObj: Tried to tween scaleY a camera\'s null flashSprite', false, false, FlxColor.RED);
								}else{
									if (type == 'ease') penisExam.scale.y = value;
									else if (type == 'add') penisExam.scale.y += value;
								}
							case 'scale':
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null){ 
										if (type == 'ease')
										{
											penisExam.flashSprite.scaleX = value;
											penisExam.flashSprite.scaleY = value;
										}
										else if (type == 'add')
										{
											penisExam.flashSprite.scaleX += value;
											penisExam.flashSprite.scaleY += value;
										}
									}else{
										luaTrace('tweenObj: Tried to tween scale a camera\'s null flashSprite', false, false, FlxColor.RED);
									}
								}else{
									if (type == 'ease') 
									{
										penisExam.scale.x = value;
										penisExam.scale.y = value;
									}
									else if (type == 'add') 
									{
										penisExam.scale.x += value;
										penisExam.scale.y += value;
									}
								}
							case 'color':
								penisExam.color = value;
						}
						return;
					}
					var tween = null;
					if (type == 'ease')
					{
						switch (subVars.toLowerCase())
						{
							case "x":
								tween = EditorPlayState.instance.createTween(penisExam, {x: value}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "y":
								tween = EditorPlayState.instance.createTween(penisExam, {y: value}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "angle":
								tween = EditorPlayState.instance.createTween(penisExam, {angle: value}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "alpha":
								tween = EditorPlayState.instance.createTween(penisExam, {alpha: value}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "zoom":
								if (Std.isOfType(penisExam, FlxCamera))
								{
									tween = EditorPlayState.instance.createTween(penisExam, {zoom: value}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}else{
									luaTrace('tweenObj: Can\'t tween zoom of an none camera object.', false, false, FlxColor.RED);
								}
							case "skewX":
								if (Std.isOfType(penisExam, FlxSkewedSprite))
								{
									tween = EditorPlayState.instance.createTween(penisExam, {"skew.x": value}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
								else{
									luaTrace('tweenObj: Can\'t tween skewX of an object that isn\'t FlxSkewedSprite', false, false, FlxColor.RED);
								}
							case "skewY":
								if (Std.isOfType(penisExam, FlxSkewedSprite))
								{
									tween = EditorPlayState.instance.createTween(penisExam, {"skew.y": value}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
								else{
									luaTrace('tweenObj: Can\'t tween skewX of an object that isn\'t FlxSkewedSprite', false, false, FlxColor.RED);
								}
							case "skew":
								if (Std.isOfType(penisExam, FlxSkewedSprite))
								{
									tween = EditorPlayState.instance.createTween(penisExam, {"skew.x": value, "skew.y": value}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
								else{
									luaTrace('tweenObj: Can\'t tween skewX of an object that isn\'t FlxSkewedSprite', false, false, FlxColor.RED);
								}
							case "scaleX":
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										tween = EditorPlayState.instance.createTween(penisExam, {"flashSprite.scaleX": value}, time, {ease: getFlxEaseByString(ease),
											onComplete: function(twn:FlxTween) {
												EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
												EditorPlayState.instance.modchartTweens.remove(tag);
											}});
									}
									else luaTrace('tweenObj: Tried to tween scaleX a camera\'s null flashSprite', false, false, FlxColor.RED);
								}
								else
								{
									tween = EditorPlayState.instance.createTween(penisExam, {"scale.x": value}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
							case "scaleY":
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										tween = EditorPlayState.instance.createTween(penisExam, {"flashSprite.scaleY": value}, time, {ease: getFlxEaseByString(ease),
											onComplete: function(twn:FlxTween) {
												EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
												EditorPlayState.instance.modchartTweens.remove(tag);
											}});
									}
									else luaTrace('tweenObj: Tried to tween scaleY a camera\'s null flashSprite', false, false, FlxColor.RED);
								}
								else
								{
									tween = EditorPlayState.instance.createTween(penisExam, {"scale.y": value}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
							case "scale":
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										tween = EditorPlayState.instance.createTween(penisExam, {"flashSprite.scaleX": value, "flashSprite.scaleY": value}, time, {ease: getFlxEaseByString(ease),
											onComplete: function(twn:FlxTween) {
												EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
												EditorPlayState.instance.modchartTweens.remove(tag);
											}});
									}
									else luaTrace('tweenObj: Tried to tween scale a camera\'s null flashSprite', false, false, FlxColor.RED);
								}
								else
								{
									tween = EditorPlayState.instance.createTween(penisExam, {"scale.x": value, "scale.y": value}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
							case "color":
								var color:Int = 0;
								if (Std.isOfType(value, String)) 
								{
									color = Std.parseInt(!value.startsWith('0x') ? '0xff' + value : value);
								}
								else if (Std.isOfType(value, Int)) color = value;
								var curColor:FlxColor = penisExam.color;
								curColor.alphaFloat = penisExam.alpha;
								tween = EditorPlayState.instance.createTweenColor(penisExam, time, curColor, color, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
						}
					}
					else if (type == 'add')
					{
						switch (subVars.toLowerCase())
						{
							case "x":
								var finalValue:Float = penisExam.x + value;
								tween = EditorPlayState.instance.createTween(penisExam, {x: finalValue}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "y":
								var finalValue:Float = penisExam.y + value;
								tween = EditorPlayState.instance.createTween(penisExam, {y: finalValue}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "angle":
								var finalValue:Float = penisExam.angle + value;
								tween = EditorPlayState.instance.createTween(penisExam, {angle: finalValue}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "alpha":
								var finalValue:Float = penisExam.alpha + value;
								tween = EditorPlayState.instance.createTween(penisExam, {alpha: finalValue}, time, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
							case "zoom":
								if (Std.isOfType(penisExam, FlxCamera))
								{
									var finalValue:Float = penisExam.zoom + value;
									tween = EditorPlayState.instance.createTween(penisExam, {zoom: finalValue}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}else{
									luaTrace('tweenObj: Can\'t tween zoom of an none camera object.', false, false, FlxColor.RED);
								}
							case "skewX":
								if (Std.isOfType(penisExam, FlxSkewedSprite))
								{
									var finalValue:Float = penisExam.skew.x + value;
									tween = EditorPlayState.instance.createTween(penisExam, {"skew.x": finalValue}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
								else{
									luaTrace('tweenObj: Can\'t tween skewX of an object that isn\'t FlxSkewedSprite', false, false, FlxColor.RED);
								}
							case "skewY":
								if (Std.isOfType(penisExam, FlxSkewedSprite))
								{
									var finalValue:Float = penisExam.skew.y + value;
									tween = EditorPlayState.instance.createTween(penisExam, {"skew.y": finalValue}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
								else{
									luaTrace('tweenObj: Can\'t tween skewX of an object that isn\'t FlxSkewedSprite', false, false, FlxColor.RED);
								}
							case "skew":
								if (Std.isOfType(penisExam, FlxSkewedSprite))
								{
									var finalValue:Float = penisExam.skew.x + value;
									var finalValue2:Float = penisExam.skew.y + value;
									tween = EditorPlayState.instance.createTween(penisExam, {"skew.x": finalValue, "skew.y": finalValue2}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
								else{
									luaTrace('tweenObj: Can\'t tween skewX of an object that isn\'t FlxSkewedSprite', false, false, FlxColor.RED);
								}
							case "scaleX":
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										var finalValue:Float = penisExam.flashSprite.scaleX + value;
										tween = EditorPlayState.instance.createTween(penisExam, {"flashSprite.scaleX": finalValue}, time, {ease: getFlxEaseByString(ease),
											onComplete: function(twn:FlxTween) {
												EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
												EditorPlayState.instance.modchartTweens.remove(tag);
											}});
									}
									else luaTrace('tweenObj: Tried to tween scaleX a camera\'s null flashSprite', false, false, FlxColor.RED);
								}
								else
								{
									var finalValue:Float = penisExam.scale.x + value;
									tween = EditorPlayState.instance.createTween(penisExam, {"scale.x": finalValue}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
							case "scaleY":
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										var finalValue:Float = penisExam.flashSprite.scaleY + value;
										tween = EditorPlayState.instance.createTween(penisExam, {"flashSprite.scaleY": finalValue}, time, {ease: getFlxEaseByString(ease),
											onComplete: function(twn:FlxTween) {
												EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
												EditorPlayState.instance.modchartTweens.remove(tag);
											}});
									}
									else luaTrace('tweenObj: Tried to tween scaleY a camera\'s null flashSprite', false, false, FlxColor.RED);
								}
								else
								{
									var finalValue:Float = penisExam.scale.y + value;
									tween = EditorPlayState.instance.createTween(penisExam, {"scale.y": finalValue}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
							case "scale":
								if (Std.isOfType(penisExam, FlxCamera)){
									if (penisExam.flashSprite != null) 
									{
										var finalValue:Float = penisExam.flashSprite.scaleX + value;
										var finalValue2:Float = penisExam.flashSprite.scaleY + value;
										tween = EditorPlayState.instance.createTween(penisExam, {"flashSprite.scaleX": finalValue, "flashSprite.scaleY": finalValue2}, time, {ease: getFlxEaseByString(ease),
											onComplete: function(twn:FlxTween) {
												EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
												EditorPlayState.instance.modchartTweens.remove(tag);
											}});
									}
									else luaTrace('tweenObj: Tried to tween scale a camera\'s null flashSprite', false, false, FlxColor.RED);
								}
								else
								{
									var finalValue:Float = penisExam.scale.x + value;
									var finalValue2:Float = penisExam.scale.y + value;
									tween = EditorPlayState.instance.createTween(penisExam, {"scale.x": finalValue, "scale.y": finalValue2}, time, {ease: getFlxEaseByString(ease),
										onComplete: function(twn:FlxTween) {
											EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
											EditorPlayState.instance.modchartTweens.remove(tag);
										}});
								}
							case "color":
								var color:Int = 0;
								if (Std.isOfType(value, String)) 
								{
									color = Std.parseInt(!value.startsWith('0x') ? '0xff' + value : value);
								}
								else if (Std.isOfType(value, Int)) color = value;
								var curColor:FlxColor = penisExam.color;
								curColor.alphaFloat = penisExam.alpha;

								var finalColor:FlxColor = curColor + color; //Add on
								tween = EditorPlayState.instance.createTweenColor(penisExam, time, curColor, finalColor, {ease: getFlxEaseByString(ease),
									onComplete: function(twn:FlxTween) {
										EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
										EditorPlayState.instance.modchartTweens.remove(tag);
									}});
						}
					}
	
					if (tween != null)
					{
						if (Conductor.songPosition > getTimeFromBeat(beat)) //skip to where it should be i guess??
						{
							@:privateAccess
							tween._secondsSinceStart += ((Conductor.songPosition-getTimeFromBeat(beat))*0.001);
							@:privateAccess
							tween.update(0);
						}
						if (EditorPlayState.instance.paused)
							tween.active = false;
						EditorPlayState.instance.modchartTweens.set(tag, tween);
					}
					else
					{
						luaTrace('tweenObj: Tween is null!', false, false, FlxColor.RED);	
					}
				});
			}
			else
			{
				luaTrace('tweenObj: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});

		Lua_helper.add_callback(lua, "mouseClicked", function(button:String) {
			var boobs = FlxG.mouse.justPressed;
			switch(button){
				case 'middle':
					boobs = FlxG.mouse.justPressedMiddle;
				case 'right':
					boobs = FlxG.mouse.justPressedRight;
			}


			return boobs;
		});
		Lua_helper.add_callback(lua, "mousePressed", function(button:String) {
			var boobs = FlxG.mouse.pressed;
			switch(button){
				case 'middle':
					boobs = FlxG.mouse.pressedMiddle;
				case 'right':
					boobs = FlxG.mouse.pressedRight;
			}
			return boobs;
		});
		Lua_helper.add_callback(lua, "mouseReleased", function(button:String) {
			var boobs = FlxG.mouse.justReleased;
			switch(button){
				case 'middle':
					boobs = FlxG.mouse.justReleasedMiddle;
				case 'right':
					boobs = FlxG.mouse.justReleasedRight;
			}
			return boobs;
		});
		Lua_helper.add_callback(lua, "noteTweenAngle", function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String) {
			cancelTween(tag);
			if(note < 0) note = 0;
			var testicle:StrumNote = EditorPlayState.instance.strumLineNotes.members[note % EditorPlayState.instance.strumLineNotes.length];

			if(testicle != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(testicle, {angle: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			}
		});
		Lua_helper.add_callback(lua, "noteTweenAlpha", function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String) {
			cancelTween(tag);
			if(note < 0) note = 0;
			var testicle:StrumNote = EditorPlayState.instance.strumLineNotes.members[note % EditorPlayState.instance.strumLineNotes.length];

			if(testicle != null) {
				EditorPlayState.instance.modchartTweens.set(tag, FlxTween.tween(testicle, {alpha: value}, duration/playbackRate, {ease: getFlxEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}
				}));
			}
		});

		Lua_helper.add_callback(lua, "cancelTween", function(tag:String) {
			cancelTween(tag);
		});

		Lua_helper.add_callback(lua, "runTimer", function(tag:String, time:Float = 1, loops:Int = 1) {
			cancelTimer(tag);
			EditorPlayState.instance.modchartTimers.set(tag, new FlxTimer().start(time/playbackRate, function(tmr:FlxTimer) {
				if(tmr.finished) {
					EditorPlayState.instance.modchartTimers.remove(tag);
				}
				EditorPlayState.instance.callOnLuas('onTimerCompleted', [tag, tmr.loops, tmr.loopsLeft]);
				//trace('Timer Completed: ' + tag);
			}, loops));
		});
		Lua_helper.add_callback(lua, "cancelTimer", function(tag:String) {
			cancelTimer(tag);
		});

		/*Lua_helper.add_callback(lua, "getPropertyAdvanced", function(varsStr:String) {
			var variables:Array<String> = varsStr.replace(' ', '').split(',');
			var leClass:Class<Dynamic> = Type.resolveClass(variables[0]);
			if(variables.length > 2) {
				var curProp:Dynamic = Reflect.getProperty(leClass, variables[1]);
				if(variables.length > 3) {
					for (i in 2...variables.length-1) {
						curProp = Reflect.getProperty(curProp, variables[i]);
					}
				}
				return Reflect.getProperty(curProp, variables[variables.length-1]);
			} else if(variables.length == 2) {
				return Reflect.getProperty(leClass, variables[variables.length-1]);
			}
			return null;
		});
		Lua_helper.add_callback(lua, "setPropertyAdvanced", function(varsStr:String, value:Dynamic) {
			var variables:Array<String> = varsStr.replace(' ', '').split(',');
			var leClass:Class<Dynamic> = Type.resolveClass(variables[0]);
			if(variables.length > 2) {
				var curProp:Dynamic = Reflect.getProperty(leClass, variables[1]);
				if(variables.length > 3) {
					for (i in 2...variables.length-1) {
						curProp = Reflect.getProperty(curProp, variables[i]);
					}
				}
				return Reflect.setProperty(curProp, variables[variables.length-1], value);
			} else if(variables.length == 2) {
				return Reflect.setProperty(leClass, variables[variables.length-1], value);
			}
		});*/

		//stupid bietch ass functions
		Lua_helper.add_callback(lua, "addScore", function(value:Int = 0) {
			EditorPlayState.instance.songScore += value;
			EditorPlayState.instance.RecalculateRating();
		});
		Lua_helper.add_callback(lua, "addMisses", function(value:Int = 0) {
			EditorPlayState.instance.songMisses += value;
			EditorPlayState.instance.RecalculateRating();
		});
		Lua_helper.add_callback(lua, "addHits", function(value:Int = 0) {
			EditorPlayState.instance.songHits += value;
			EditorPlayState.instance.RecalculateRating();
		});
		Lua_helper.add_callback(lua, "setScore", function(value:Int = 0) {
			EditorPlayState.instance.songScore = value;
			EditorPlayState.instance.RecalculateRating();
		});
		Lua_helper.add_callback(lua, "setMisses", function(value:Int = 0) {
			EditorPlayState.instance.songMisses = value;
			EditorPlayState.instance.RecalculateRating();
		});
		Lua_helper.add_callback(lua, "setHits", function(value:Int = 0) {
			EditorPlayState.instance.songHits = value;
			EditorPlayState.instance.RecalculateRating();
		});
		Lua_helper.add_callback(lua, "getScore", function() {
			return EditorPlayState.instance.songScore;
		});
		Lua_helper.add_callback(lua, "getMisses", function() {
			return EditorPlayState.instance.songMisses;
		});
		Lua_helper.add_callback(lua, "getHits", function() {
			return EditorPlayState.instance.songHits;
		});

		Lua_helper.add_callback(lua, "setHealth", function(value:Float = 0) {
			EditorPlayState.instance.health = value;
		});
		Lua_helper.add_callback(lua, "addHealth", function(value:Float = 0) {
			EditorPlayState.instance.health += value;
		});
		Lua_helper.add_callback(lua, "getHealth", function() {
			return EditorPlayState.instance.health;
		});

		//Identical functions
		Lua_helper.add_callback(lua, "FlxColor", function(color:String) return FlxColor.fromString(color));
		Lua_helper.add_callback(lua, "getColorFromName", function(color:String) return FlxColor.fromString(color));
		Lua_helper.add_callback(lua, "getColorFromString", function(color:String) return FlxColor.fromString(color));
		Lua_helper.add_callback(lua, "getColorFromHex", function(color:String) return FlxColor.fromString('#$color'));
		Lua_helper.add_callback(lua, "getColorFromParsedInt", function(color:String) {
			if(!color.startsWith('0x')) color = '0xFF' + color;
			return Std.parseInt(color);
		});

		Lua_helper.add_callback(lua, "keyboardJustPressed", function(name:String)
		{
			return Reflect.getProperty(FlxG.keys.justPressed, name);
		});
		Lua_helper.add_callback(lua, "keyboardPressed", function(name:String)
		{
			return Reflect.getProperty(FlxG.keys.pressed, name);
		});
		Lua_helper.add_callback(lua, "keyboardReleased", function(name:String)
		{
			return Reflect.getProperty(FlxG.keys.justReleased, name);
		});

		Lua_helper.add_callback(lua, "anyGamepadJustPressed", function(name:String)
		{
			return FlxG.gamepads.anyJustPressed(name);
		});
		Lua_helper.add_callback(lua, "anyGamepadPressed", function(name:String)
		{
			return FlxG.gamepads.anyPressed(name);
		});
		Lua_helper.add_callback(lua, "anyGamepadReleased", function(name:String)
		{
			return FlxG.gamepads.anyJustReleased(name);
		});

		Lua_helper.add_callback(lua, "gamepadAnalogX", function(id:Int, ?leftStick:Bool = true)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null)
			{
				return 0.0;
			}
			return controller.getXAxis(leftStick ? LEFT_ANALOG_STICK : RIGHT_ANALOG_STICK);
		});
		Lua_helper.add_callback(lua, "gamepadAnalogY", function(id:Int, ?leftStick:Bool = true)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null)
			{
				return 0.0;
			}
			return controller.getYAxis(leftStick ? LEFT_ANALOG_STICK : RIGHT_ANALOG_STICK);
		});
		Lua_helper.add_callback(lua, "gamepadJustPressed", function(id:Int, name:String)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null)
			{
				return false;
			}
			return Reflect.getProperty(controller.justPressed, name) == true;
		});
		Lua_helper.add_callback(lua, "gamepadPressed", function(id:Int, name:String)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null)
			{
				return false;
			}
			return Reflect.getProperty(controller.pressed, name) == true;
		});
		Lua_helper.add_callback(lua, "gamepadReleased", function(id:Int, name:String)
		{
			var controller = FlxG.gamepads.getByID(id);
			if (controller == null)
			{
				return false;
			}
			return Reflect.getProperty(controller.justReleased, name) == true;
		});

		Lua_helper.add_callback(lua, "keyJustPressed", function(name:String) {
			var key:Bool = false;
			switch(name) {
				case 'left': key = EditorPlayState.instance.getControl('NOTE_LEFT_P');
				case 'down': key = EditorPlayState.instance.getControl('NOTE_DOWN_P');
				case 'up': key = EditorPlayState.instance.getControl('NOTE_UP_P');
				case 'right': key = EditorPlayState.instance.getControl('NOTE_RIGHT_P');
				case 'accept': key = EditorPlayState.instance.getControl('ACCEPT');
				case 'back': key = EditorPlayState.instance.getControl('BACK');
				case 'pause': key = EditorPlayState.instance.getControl('PAUSE');
				case 'reset': key = EditorPlayState.instance.getControl('RESET');
				case 'space': key = FlxG.keys.justPressed.SPACE;//an extra key for convinience
			}
			return key;
		});
		Lua_helper.add_callback(lua, "keyPressed", function(name:String) {
			var key:Bool = false;
			switch(name) {
				case 'left': key = EditorPlayState.instance.getControl('NOTE_LEFT');
				case 'down': key = EditorPlayState.instance.getControl('NOTE_DOWN');
				case 'up': key = EditorPlayState.instance.getControl('NOTE_UP');
				case 'right': key = EditorPlayState.instance.getControl('NOTE_RIGHT');
				case 'space': key = FlxG.keys.pressed.SPACE;//an extra key for convinience
			}
			return key;
		});
		Lua_helper.add_callback(lua, "keyReleased", function(name:String) {
			var key:Bool = false;
			switch(name) {
				case 'left': key = EditorPlayState.instance.getControl('NOTE_LEFT_R');
				case 'down': key = EditorPlayState.instance.getControl('NOTE_DOWN_R');
				case 'up': key = EditorPlayState.instance.getControl('NOTE_UP_R');
				case 'right': key = EditorPlayState.instance.getControl('NOTE_RIGHT_R');
				case 'space': key = FlxG.keys.justReleased.SPACE;//an extra key for convinience
			}
			return key;
		});
		Lua_helper.add_callback(lua, "addCharacterToList", function(name:String, type:String) {
			var charType:Int = 0;
			switch(type.toLowerCase()) {
				case 'dad': charType = 1;
				case 'gf' | 'girlfriend': charType = 2;
			}
			EditorPlayState.instance.addCharacterToList(name, charType);
		});
		Lua_helper.add_callback(lua, "precacheImage", function(name:String) {
			Paths.image(name);
		});
		Lua_helper.add_callback(lua, "precacheSound", function(name:String) {
			CoolUtil.precacheSound(name);
		});
		Lua_helper.add_callback(lua, "precacheMusic", function(name:String) {
			CoolUtil.precacheMusic(name);
		});
		Lua_helper.add_callback(lua, "triggerEvent", function(name:String, arg1:Dynamic, arg2:Dynamic) {
			var value1:String = arg1;
			var value2:String = arg2;
			EditorPlayState.instance.triggerEventNote(name, value1, value2, Conductor.songPosition);
			//trace('Triggered event: ' + name + ', ' + value1 + ', ' + value2);
			return true;
		});

		Lua_helper.add_callback(lua, "startCountdown", function() {
			EditorPlayState.instance.startCountdown();
			return true;
		});
		Lua_helper.add_callback(lua, "endSong", function() {
			EditorPlayState.instance.KillNotes();
			EditorPlayState.instance.endSong();
			return true;
		});
		Lua_helper.add_callback(lua, "startRating", function() {
			EditorPlayState.instance.KillNotes();
			EditorPlayState.instance.rating();
			return true;
		});
		Lua_helper.add_callback(lua, "restartSong", function(?skipTransition:Bool = false) {
			EditorPlayState.instance.persistentUpdate = false;
			EditorPauseSubState.restartSong(skipTransition);
			return true;
		});
		Lua_helper.add_callback(lua, "exitSong", function(?skipTransition:Bool = false) {
			if(skipTransition)
			{
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
			}

			EditorPlayState.cancelMusicFadeTween();
			CustomFadeTransition.nextCamera = EditorPlayState.instance.camOther;
			if(FlxTransitionableState.skipNextTransIn)
				CustomFadeTransition.nextCamera = null;

			if(PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());
			
			#if desktop DiscordClient.resetClientID(); #end

			FlxG.sound.playMusic(Paths.music('bloodtained'));
			EditorPlayState.changedDifficulty = false;
			EditorPlayState.chartingMode = false;
			EditorPlayState.instance.transitioning = true;
			Mods.loadTopMod();
			return true;
		});
		Lua_helper.add_callback(lua, "getSongPosition", function() {
			return Conductor.songPosition;
		});

		Lua_helper.add_callback(lua, "getCharacterX", function(type:String) {
			switch(type.toLowerCase()) {
				case 'dad' | 'opponent':
					return EditorPlayState.instance.dadGroup.x;
				case 'gf' | 'girlfriend':
					return EditorPlayState.instance.gfGroup.x;
				default:
					return EditorPlayState.instance.boyfriendGroup.x;
			}
		});
		Lua_helper.add_callback(lua, "setCharacterX", function(type:String, value:Float) {
			switch(type.toLowerCase()) {
				case 'dad' | 'opponent':
					EditorPlayState.instance.dadGroup.x = value;
				case 'gf' | 'girlfriend':
					EditorPlayState.instance.gfGroup.x = value;
				default:
					EditorPlayState.instance.boyfriendGroup.x = value;
			}
		});
		Lua_helper.add_callback(lua, "getCharacterY", function(type:String) {
			switch(type.toLowerCase()) {
				case 'dad' | 'opponent':
					return EditorPlayState.instance.dadGroup.y;
				case 'gf' | 'girlfriend':
					return EditorPlayState.instance.gfGroup.y;
				default:
					return EditorPlayState.instance.boyfriendGroup.y;
			}
		});
		Lua_helper.add_callback(lua, "setCharacterY", function(type:String, value:Float) {
			switch(type.toLowerCase()) {
				case 'dad' | 'opponent':
					EditorPlayState.instance.dadGroup.y = value;
				case 'gf' | 'girlfriend':
					EditorPlayState.instance.gfGroup.y = value;
				default:
					EditorPlayState.instance.boyfriendGroup.y = value;
			}
		});
		Lua_helper.add_callback(lua, "cameraSetTarget", function(target:String) {
			var isDad:Bool = false;
			if(target == 'dad') {
				isDad = true;
			}
			EditorPlayState.instance.moveCamera(isDad);
			return isDad;
		});
		Lua_helper.add_callback(lua, "cameraShake", function(camera:String, intensity:Float, duration:Float) {
			cameraFromString(camera).shake(intensity, duration);
		});

		Lua_helper.add_callback(lua, "cameraFlash", function(camera:String, color:String, duration:Float,forced:Bool) {
			var colorNum:Int = Std.parseInt(color);
			if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);
			cameraFromString(camera).flash(colorNum, duration,null,forced);
		});
		Lua_helper.add_callback(lua, "cameraFade", function(camera:String, color:String, duration:Float,forced:Bool) {
			var colorNum:Int = Std.parseInt(color);
			if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);
			cameraFromString(camera).fade(colorNum, duration,false,null,forced);
		});
		Lua_helper.add_callback(lua, "setRatingPercent", function(value:Float) {
			EditorPlayState.instance.ratingPercent = value;
		});
		Lua_helper.add_callback(lua, "setRatingName", function(value:String) {
			EditorPlayState.instance.ratingName = value;
		});
		Lua_helper.add_callback(lua, "setRatingFC", function(value:String) {
			EditorPlayState.instance.ratingFC = value;
		});
		Lua_helper.add_callback(lua, "getMouseX", function(camera:String) {
			var cam:FlxCamera = cameraFromString(camera);
			return FlxG.mouse.getScreenPosition(cam).x;
		});
		Lua_helper.add_callback(lua, "getMouseY", function(camera:String) {
			var cam:FlxCamera = cameraFromString(camera);
			return FlxG.mouse.getScreenPosition(cam).y;
		});

		Lua_helper.add_callback(lua, "getMidpointX", function(variable:String) {
			var killMe:Array<String> = variable.split('.');
			var obj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				obj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}
			if(obj != null) return obj.getMidpoint().x;

			return 0;
		});
		Lua_helper.add_callback(lua, "getMidpointY", function(variable:String) {
			var killMe:Array<String> = variable.split('.');
			var obj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				obj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}
			if(obj != null) return obj.getMidpoint().y;

			return 0;
		});
		Lua_helper.add_callback(lua, "getGraphicMidpointX", function(variable:String) {
			var killMe:Array<String> = variable.split('.');
			var obj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				obj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}
			if(obj != null) return obj.getGraphicMidpoint().x;

			return 0;
		});
		Lua_helper.add_callback(lua, "getGraphicMidpointY", function(variable:String) {
			var killMe:Array<String> = variable.split('.');
			var obj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				obj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}
			if(obj != null) return obj.getGraphicMidpoint().y;

			return 0;
		});
		Lua_helper.add_callback(lua, "getScreenPositionX", function(variable:String) {
			var killMe:Array<String> = variable.split('.');
			var obj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				obj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}
			if(obj != null) return obj.getScreenPosition().x;

			return 0;
		});
		Lua_helper.add_callback(lua, "getScreenPositionY", function(variable:String) {
			var killMe:Array<String> = variable.split('.');
			var obj:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				obj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}
			if(obj != null) return obj.getScreenPosition().y;

			return 0;
		});
		Lua_helper.add_callback(lua, "characterDance", function(character:String) {
			switch(character.toLowerCase()) {
				case 'dad': EditorPlayState.instance.dad.dance();
				case 'gf' | 'girlfriend': if(EditorPlayState.instance.gf != null) EditorPlayState.instance.gf.dance();
				default: EditorPlayState.instance.boyfriend.dance();
			}
		});

		Lua_helper.add_callback(lua, "makeLuaSprite", function(tag:String, image:String, x:Float, y:Float) {
			tag = tag.replace('.', '');
			resetSpriteTag(tag);
			var leSprite:ModchartSprite = new ModchartSprite(x, y);
			if(image != null && image.length > 0)
			{
				leSprite.loadGraphic(Paths.image(image));
			}
			leSprite.antialiasing = ClientPrefs.globalAntialiasing;
			EditorPlayState.instance.modchartSprites.set(tag, leSprite);
			leSprite.active = true;
		});
		Lua_helper.add_callback(lua, "makeAnimatedLuaSprite", function(tag:String, image:String, x:Float, y:Float, ?spriteType:String = "sparrow") {
			tag = tag.replace('.', '');
			resetSpriteTag(tag);
			var leSprite:ModchartSprite = new ModchartSprite(x, y);

			loadFrames(leSprite, image, spriteType);
			leSprite.antialiasing = ClientPrefs.globalAntialiasing;
			EditorPlayState.instance.modchartSprites.set(tag, leSprite);
		});

		Lua_helper.add_callback(lua, "makeGraphic", function(obj:String, width:Int, height:Int, color:String) {
			var colorNum:Int = Std.parseInt(color);
			if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);

			var spr:FlxSprite = EditorPlayState.instance.getLuaObject(obj,false);
			if(spr!=null) {
				EditorPlayState.instance.getLuaObject(obj,false).makeGraphic(width, height, colorNum);
				return;
			}

			var object:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if(object != null) {
				object.makeGraphic(width, height, colorNum);
			}
		});
		Lua_helper.add_callback(lua, "addAnimationByPrefix", function(obj:String, name:String, prefix:String, framerate:Int = 24, loop:Bool = true) {
			if(EditorPlayState.instance.getLuaObject(obj,false)!=null) {
				var cock:FlxSprite = EditorPlayState.instance.getLuaObject(obj,false);
				cock.animation.addByPrefix(name, prefix, framerate, loop);
				if(cock.animation.curAnim == null) {
					cock.animation.play(name, true);
				}
				return;
			}

			var cock:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if(cock != null) {
				cock.animation.addByPrefix(name, prefix, framerate, loop);
				if(cock.animation.curAnim == null) {
					cock.animation.play(name, true);
				}
			}
		});

		Lua_helper.add_callback(lua, "addAnimation", function(obj:String, name:String, frames:Array<Int>, framerate:Int = 24, loop:Bool = true) {
			if(EditorPlayState.instance.getLuaObject(obj,false)!=null) {
				var cock:FlxSprite = EditorPlayState.instance.getLuaObject(obj,false);
				cock.animation.add(name, frames, framerate, loop);
				if(cock.animation.curAnim == null) {
					cock.animation.play(name, true);
				}
				return;
			}

			var cock:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if(cock != null) {
				cock.animation.add(name, frames, framerate, loop);
				if(cock.animation.curAnim == null) {
					cock.animation.play(name, true);
				}
			}
		});

		Lua_helper.add_callback(lua, "addAnimationByIndices", function(obj:String, name:String, prefix:String, indices:String, framerate:Int = 24) {
			return addAnimByIndices(obj, name, prefix, indices, framerate, false);
		});
		Lua_helper.add_callback(lua, "addAnimationByIndicesLoop", function(obj:String, name:String, prefix:String, indices:String, framerate:Int = 24) {
			return addAnimByIndices(obj, name, prefix, indices, framerate, true);
		});
		Lua_helper.add_callback(lua, "makeLuaSkewedSprite", function(tag:String, ?image:String = null, ?x:Float = 0, ?y:Float = 0, ?skewX:Float = 0, ?skewY:Float = 0) {
			tag = tag.replace('.', '');
			resetSkewedSpriteTag(tag);
			var leSprite:FlxSkewedSprite = null;
			if(image != null && image.length > 0)
			{
				leSprite = new FlxSkewedSprite();
				leSprite.loadGraphic(Paths.image(image));
				leSprite.x = x;
				leSprite.y = y;
				leSprite.skew.x = skewX;
				leSprite.skew.y = skewY;
			}
			EditorPlayState.instance.modchartSkewedSprite.set(tag, leSprite);
			leSprite.active = true;
		});

		Lua_helper.add_callback(lua, "playAnim", function(obj:String, name:String, forced:Bool = false, ?reverse:Bool = false, ?startFrame:Int = 0)
		{
			if(EditorPlayState.instance.getLuaObject(obj, false) != null) {
				var luaObj:FlxSprite = EditorPlayState.instance.getLuaObject(obj,false);
				if(luaObj.animation.getByName(name) != null)
				{
					luaObj.animation.play(name, forced, reverse, startFrame);
					if(Std.isOfType(luaObj, ModchartSprite))
					{
						//convert luaObj to ModchartSprite
						var obj:Dynamic = luaObj;
						var luaObj:ModchartSprite = obj;

						var daOffset = luaObj.animOffsets.get(name);
						if (luaObj.animOffsets.exists(name))
						{
							luaObj.offset.set(daOffset[0], daOffset[1]);
						}
					}
				}
				return true;
			}

			var spr:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if(spr != null) {
				if(spr.animation.getByName(name) != null)
				{
					if(Std.isOfType(spr, Character))
					{
						//convert spr to Character
						var obj:Dynamic = spr;
						var spr:Character = obj;
						spr.playAnim(name, forced, reverse, startFrame);
					}
					else
						spr.animation.play(name, forced, reverse, startFrame);
				}
				return true;
			}
			return false;
		});
		Lua_helper.add_callback(lua, "addOffset", function(obj:String, anim:String, x:Float, y:Float) {
			if(EditorPlayState.instance.modchartSprites.exists(obj)) {
				EditorPlayState.instance.modchartSprites.get(obj).animOffsets.set(anim, [x, y]);
				return true;
			}

			var char:Character = Reflect.getProperty(getInstance(), obj);
			if(char != null) {
				char.addOffset(anim, x, y);
				return true;
			}
			return false;
		});

		Lua_helper.add_callback(lua, "setScrollFactor", function(obj:String, scrollX:Float, scrollY:Float) {
			if(EditorPlayState.instance.getLuaObject(obj,false)!=null) {
				EditorPlayState.instance.getLuaObject(obj,false).scrollFactor.set(scrollX, scrollY);
				return;
			}

			var object:FlxObject = Reflect.getProperty(getInstance(), obj);
			if(object != null) {
				object.scrollFactor.set(scrollX, scrollY);
			}
		});
		Lua_helper.add_callback(lua, "addLuaSprite", function(tag:String, front:Bool = false) {
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				var shit:ModchartSprite = EditorPlayState.instance.modchartSprites.get(tag);
				if(!shit.wasAdded) {
					if(front)
					{
						getInstance().add(shit);
					}
					else
					{
						var position:Int = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.gfGroup);
						if(EditorPlayState.instance.members.indexOf(EditorPlayState.instance.boyfriendGroup) < position) {
							position = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.boyfriendGroup);
						} else if(EditorPlayState.instance.members.indexOf(EditorPlayState.instance.dadGroup) < position) {
							position = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.dadGroup);
						}
						EditorPlayState.instance.insert(position, shit);
					}
					shit.wasAdded = true;
					//trace('added a thing: ' + tag);
				}
			}
		});
		Lua_helper.add_callback(lua, "addSkewedSprite", function(tag:String, front:Bool = false) {
			if(EditorPlayState.instance.modchartSkewedSprite.exists(tag)) {
				var spr:FlxSkewedSprite = EditorPlayState.instance.modchartSkewedSprite.get(tag);
				if(front)
					getInstance().add(spr);
				else{
					var position:Int = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.gfGroup);
					if(EditorPlayState.instance.members.indexOf(EditorPlayState.instance.boyfriendGroup) < position) {
						position = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.boyfriendGroup);
					} else if(EditorPlayState.instance.members.indexOf(EditorPlayState.instance.dadGroup) < position) {
						position = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.dadGroup);
					}
					EditorPlayState.instance.insert(position, spr);
				}
		}});
		Lua_helper.add_callback(lua, "setGraphicSize", function(obj:String, x:Int, y:Int = 0, updateHitbox:Bool = true) {
			if(EditorPlayState.instance.getLuaObject(obj)!=null) {
				var shit:FlxSprite = EditorPlayState.instance.getLuaObject(obj);
				shit.setGraphicSize(x, y);
				if(updateHitbox) shit.updateHitbox();
				return;
			}

			var killMe:Array<String> = obj.split('.');
			var poop:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				poop = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(poop != null) {
				poop.setGraphicSize(x, y);
				if(updateHitbox) poop.updateHitbox();
				return;
			}
			luaTrace('setGraphicSize: Couldnt find object: ' + obj, false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "scaleObject", function(obj:String, x:Float, y:Float, updateHitbox:Bool = true) {
			if(EditorPlayState.instance.getLuaObject(obj)!=null) {
				var shit:FlxSprite = EditorPlayState.instance.getLuaObject(obj);
				shit.scale.set(x, y);
				if(updateHitbox) shit.updateHitbox();
				return;
			}

			var killMe:Array<String> = obj.split('.');
			var poop:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				poop = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(poop != null) {
				poop.scale.set(x, y);
				if(updateHitbox) poop.updateHitbox();
				return;
			}
			luaTrace('scaleObject: Couldnt find object: ' + obj, false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "updateHitbox", function(obj:String) {
			if(EditorPlayState.instance.getLuaObject(obj)!=null) {
				var shit:FlxSprite = EditorPlayState.instance.getLuaObject(obj);
				shit.updateHitbox();
				return;
			}

			var poop:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if(poop != null) {
				poop.updateHitbox();
				return;
			}
			luaTrace('updateHitbox: Couldnt find object: ' + obj, false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "updateHitboxFromGroup", function(group:String, index:Int) {
			if(Std.isOfType(Reflect.getProperty(getInstance(), group), FlxTypedGroup)) {
				Reflect.getProperty(getInstance(), group).members[index].updateHitbox();
				return;
			}
			Reflect.getProperty(getInstance(), group)[index].updateHitbox();
		});

		Lua_helper.add_callback(lua, "removeLuaSprite", function(tag:String, destroy:Bool = true) {
			if(!EditorPlayState.instance.modchartSprites.exists(tag)) {
				return;
			}

			var pee:ModchartSprite = EditorPlayState.instance.modchartSprites.get(tag);
			if(destroy) {
				pee.kill();
			}

			if(pee.wasAdded) {
				getInstance().remove(pee, true);
				pee.wasAdded = false;
			}

			if(destroy) {
				pee.destroy();
				EditorPlayState.instance.modchartSprites.remove(tag);
			}
		});
		Lua_helper.add_callback(lua, "removeSkewedSprite", function(tag:String, destroy:Bool = true) {
			if(!EditorPlayState.instance.modchartSkewedSprite.exists(tag)) {
				return;
			}

			var pee:FlxSkewedSprite = EditorPlayState.instance.modchartSkewedSprite.get(tag);
			if(destroy) {
				pee.kill();
			}

			getInstance().remove(pee, true);
			if(destroy) {
				pee.destroy();
				EditorPlayState.instance.modchartSkewedSprite.remove(tag);
			}
		});
		Lua_helper.add_callback(lua, "luaSpriteExists", function(tag:String) {
			return EditorPlayState.instance.modchartSprites.exists(tag);
		});
		Lua_helper.add_callback(lua, "luaTextExists", function(tag:String) {
			return EditorPlayState.instance.modchartTexts.exists(tag);
		});
		Lua_helper.add_callback(lua, "luaSoundExists", function(tag:String) {
			return EditorPlayState.instance.modchartSounds.exists(tag);
		});

		Lua_helper.add_callback(lua, "setHealthBarColors", function(leftHex:String, rightHex:String) {
			var left:FlxColor = Std.parseInt(leftHex);
			if(!leftHex.startsWith('0x')) left = Std.parseInt('0xff' + leftHex);
			var right:FlxColor = Std.parseInt(rightHex);
			if(!rightHex.startsWith('0x')) right = Std.parseInt('0xff' + rightHex);

			EditorPlayState.instance.hitmansHUD.healthBar.createFilledBar(left, right);
			EditorPlayState.instance.hitmansHUD.healthBar.updateBar();
		});
		Lua_helper.add_callback(lua, "setTimeBarColors", function(leftHex:String, rightHex:String) {
			var left:FlxColor = Std.parseInt(leftHex);
			if(!leftHex.startsWith('0x')) left = Std.parseInt('0xff' + leftHex);
			var right:FlxColor = Std.parseInt(rightHex);
			if(!rightHex.startsWith('0x')) right = Std.parseInt('0xff' + rightHex);

			EditorPlayState.instance.hitmansHUD.timeBar.createFilledBar(right, left);
			EditorPlayState.instance.hitmansHUD.timeBar.updateBar();
		});

		Lua_helper.add_callback(lua, "setObjectCamera", function(obj:String, camera:String = '') {
			/*if(EditorPlayState.instance.modchartSprites.exists(obj)) {
				EditorPlayState.instance.modchartSprites.get(obj).cameras = [cameraFromString(camera)];
				return true;
			}
			else if(EditorPlayState.instance.modchartTexts.exists(obj)) {
				EditorPlayState.instance.modchartTexts.get(obj).cameras = [cameraFromString(camera)];
				return true;
			}*/
			var real = EditorPlayState.instance.getLuaObject(obj);
			if(real!=null){
				real.cameras = [cameraFromString(camera)];
				return true;
			}

			var killMe:Array<String> = obj.split('.');
			var object:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				object = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(object != null) {
				object.cameras = [cameraFromString(camera)];
				return true;
			}
			luaTrace("setObjectCamera: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setBlendMode", function(obj:String, blend:String = '') {
			var real = EditorPlayState.instance.getLuaObject(obj);
			if(real!=null) {
				real.blend = blendModeFromString(blend);
				return true;
			}

			var killMe:Array<String> = obj.split('.');
			var spr:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				spr = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(spr != null) {
				spr.blend = blendModeFromString(blend);
				return true;
			}
			luaTrace("setBlendMode: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "screenCenter", function(obj:String, pos:String = 'xy') {
			var spr:FlxSprite = EditorPlayState.instance.getLuaObject(obj);

			if(spr==null){
				var killMe:Array<String> = obj.split('.');
				spr = getObjectDirectly(killMe[0]);
				if(killMe.length > 1) {
					spr = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
				}
			}

			if(spr != null)
			{
				switch(pos.trim().toLowerCase())
				{
					case 'x':
						spr.screenCenter(X);
						return;
					case 'y':
						spr.screenCenter(Y);
						return;
					default:
						spr.screenCenter(XY);
						return;
				}
			}
			luaTrace("screenCenter: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "objectsOverlap", function(obj1:String, obj2:String) {
			var namesArray:Array<String> = [obj1, obj2];
			var objectsArray:Array<FlxSprite> = [];
			for (i in 0...namesArray.length)
			{
				var real = EditorPlayState.instance.getLuaObject(namesArray[i]);
				if(real!=null) {
					objectsArray.push(real);
				} else {
					objectsArray.push(Reflect.getProperty(getInstance(), namesArray[i]));
				}
			}

			if(!objectsArray.contains(null) && FlxG.overlap(objectsArray[0], objectsArray[1]))
			{
				return true;
			}
			return false;
		});
		Lua_helper.add_callback(lua, "getPixelColor", function(obj:String, x:Int, y:Int) {
			var killMe:Array<String> = obj.split('.');
			var spr:FlxSprite = getObjectDirectly(killMe[0]);
			if(killMe.length > 1) {
				spr = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
			}

			if(spr != null)
			{
				if(spr.framePixels != null) spr.framePixels.getPixel32(x, y);
				return spr.pixels.getPixel32(x, y);
			}
			return 0;
		});
		Lua_helper.add_callback(lua, "getRandomInt", function(min:Int, max:Int = FlxMath.MAX_VALUE_INT, exclude:String = '') {
			var excludeArray:Array<String> = exclude.split(',');
			var toExclude:Array<Int> = [];
			for (i in 0...excludeArray.length)
			{
				toExclude.push(Std.parseInt(excludeArray[i].trim()));
			}
			return FlxG.random.int(min, max, toExclude);
		});
		Lua_helper.add_callback(lua, "getRandomFloat", function(min:Float, max:Float = 1, exclude:String = '') {
			var excludeArray:Array<String> = exclude.split(',');
			var toExclude:Array<Float> = [];
			for (i in 0...excludeArray.length)
			{
				toExclude.push(Std.parseFloat(excludeArray[i].trim()));
			}
			return FlxG.random.float(min, max, toExclude);
		});
		Lua_helper.add_callback(lua, "getRandomBool", function(chance:Float = 50) {
			return FlxG.random.bool(chance);
		});
		Lua_helper.add_callback(lua, "startDialogue", function(dialogueFile:String, music:String = null) {
			EditorPlayState.instance.startCallback = null;

			var path:String;
			#if MODS_ALLOWED
			path = Paths.modsJson(Paths.formatToSongPath(PlayState.SONG.song) + '/' + dialogueFile);
			if(!FileSystem.exists(path))
			#end
				path = Paths.json(Paths.formatToSongPath(PlayState.SONG.song) + '/' + dialogueFile);

			luaTrace('startDialogue: Trying to load dialogue: ' + path);

			#if MODS_ALLOWED
			if(FileSystem.exists(path))
			#else
			if(Assets.exists(path))
			#end
			{
				var shit:DialogueFile = DialogueBoxPsych.parseDialogue(path);
				if(shit.dialogue.length > 0) {
					EditorPlayState.instance.startDialogue(shit, music);
					luaTrace('startDialogue: Successfully loaded dialogue', false, false, FlxColor.GREEN);
					return true;
				} else {
					luaTrace('startDialogue: Your dialogue file is badly formatted!', false, false, FlxColor.RED);
				}
			} else {
				luaTrace('startDialogue: Dialogue file not found', false, false, FlxColor.RED);
				if(EditorPlayState.instance.endingSong) {
					if (!EditorPlayState.inResultsScreen) EditorPlayState.instance.endSong();
				} else {
					if (!EditorPlayState.inResultsScreen) EditorPlayState.instance.startCountdown();
				}
			}
			return false;
		});

		Lua_helper.add_callback(lua, "startVideo", function(videoFile:String) {
			#if VIDEOS_ALLOWED
			if(FileSystem.exists(Paths.video(videoFile))) {
				EditorPlayState.instance.startVideo(videoFile);
				return true;
			} else {
				luaTrace('startVideo: Video file not found: ' + videoFile, false, false, FlxColor.RED);
			}
			return false;

			#else
			if(EditorPlayState.instance.endingSong) {
				EditorPlayState.instance.endSong();
			} else {
				EditorPlayState.instance.startCountdown();
			}
			return true;
			#end
		});

		Lua_helper.add_callback(lua, "playMusic", function(sound:String, volume:Float = 1, loop:Bool = false) {
			FlxG.sound.playMusic(Paths.music(sound), volume, loop);
		});
		Lua_helper.add_callback(lua, "playSound", function(sound:String, volume:Float = 1, ?tag:String = null) {
			if(tag != null && tag.length > 0) {
				tag = tag.replace('.', '');
				if(EditorPlayState.instance.modchartSounds.exists(tag)) {
					EditorPlayState.instance.modchartSounds.get(tag).stop();
				}
				EditorPlayState.instance.modchartSounds.set(tag, FlxG.sound.play(Paths.sound(sound), volume, false, function() {
					EditorPlayState.instance.modchartSounds.remove(tag);
					EditorPlayState.instance.callOnLuas('onSoundFinished', [tag]);
				}));
				return;
			}
			FlxG.sound.play(Paths.sound(sound), volume);
		});
		Lua_helper.add_callback(lua, "stopSound", function(tag:String) {
			if(tag != null && tag.length > 1 && EditorPlayState.instance.modchartSounds.exists(tag)) {
				EditorPlayState.instance.modchartSounds.get(tag).stop();
				EditorPlayState.instance.modchartSounds.remove(tag);
			}
		});
		Lua_helper.add_callback(lua, "pauseSound", function(tag:String) {
			if(tag != null && tag.length > 1 && EditorPlayState.instance.modchartSounds.exists(tag)) {
				EditorPlayState.instance.modchartSounds.get(tag).pause();
			}
		});
		Lua_helper.add_callback(lua, "resumeSound", function(tag:String) {
			if(tag != null && tag.length > 1 && EditorPlayState.instance.modchartSounds.exists(tag)) {
				EditorPlayState.instance.modchartSounds.get(tag).play();
			}
		});
		Lua_helper.add_callback(lua, "soundFadeIn", function(tag:String, duration:Float, fromValue:Float = 0, toValue:Float = 1) {
			if(tag == null || tag.length < 1) {
				FlxG.sound.music.fadeIn(duration, fromValue, toValue);
			} else if(EditorPlayState.instance.modchartSounds.exists(tag)) {
				EditorPlayState.instance.modchartSounds.get(tag).fadeIn(duration, fromValue, toValue);
			}

		});
		Lua_helper.add_callback(lua, "soundFadeOut", function(tag:String, duration:Float, toValue:Float = 0) {
			if(tag == null || tag.length < 1) {
				FlxG.sound.music.fadeOut(duration, toValue);
			} else if(EditorPlayState.instance.modchartSounds.exists(tag)) {
				EditorPlayState.instance.modchartSounds.get(tag).fadeOut(duration, toValue);
			}
		});
		Lua_helper.add_callback(lua, "soundFadeCancel", function(tag:String) {
			if(tag == null || tag.length < 1) {
				if(FlxG.sound.music.fadeTween != null) {
					FlxG.sound.music.fadeTween.cancel();
				}
			} else if(EditorPlayState.instance.modchartSounds.exists(tag)) {
				var theSound:FlxSound = EditorPlayState.instance.modchartSounds.get(tag);
				if(theSound.fadeTween != null) {
					theSound.fadeTween.cancel();
					EditorPlayState.instance.modchartSounds.remove(tag);
				}
			}
		});
		Lua_helper.add_callback(lua, "getSoundVolume", function(tag:String) {
			if(tag == null || tag.length < 1) {
				if(FlxG.sound.music != null) {
					return FlxG.sound.music.volume;
				}
			} else if(EditorPlayState.instance.modchartSounds.exists(tag)) {
				return EditorPlayState.instance.modchartSounds.get(tag).volume;
			}
			return 0;
		});
		Lua_helper.add_callback(lua, "setSoundVolume", function(tag:String, value:Float) {
			if(tag == null || tag.length < 1) {
				if(FlxG.sound.music != null) {
					FlxG.sound.music.volume = value;
				}
			} else if(EditorPlayState.instance.modchartSounds.exists(tag)) {
				EditorPlayState.instance.modchartSounds.get(tag).volume = value;
			}
		});
		Lua_helper.add_callback(lua, "getSoundTime", function(tag:String) {
			if(tag != null && tag.length > 0 && EditorPlayState.instance.modchartSounds.exists(tag)) {
				return EditorPlayState.instance.modchartSounds.get(tag).time;
			}
			return 0;
		});
		Lua_helper.add_callback(lua, "setSoundTime", function(tag:String, value:Float) {
			if(tag != null && tag.length > 0 && EditorPlayState.instance.modchartSounds.exists(tag)) {
				var theSound:FlxSound = EditorPlayState.instance.modchartSounds.get(tag);
				if(theSound != null) {
					var wasResumed:Bool = theSound.playing;
					theSound.pause();
					theSound.time = value;
					if(wasResumed) theSound.play();
				}
			}
		});

		Lua_helper.add_callback(lua, "debugPrint", function(text1:Dynamic = '', text2:Dynamic = '', text3:Dynamic = '', text4:Dynamic = '', text5:Dynamic = '') {
			if (text1 == null) text1 = '';
			if (text2 == null) text2 = '';
			if (text3 == null) text3 = '';
			if (text4 == null) text4 = '';
			if (text5 == null) text5 = '';
			luaTrace('' + text1 + text2 + text3 + text4 + text5, true, false);
		});
		
		Lua_helper.add_callback(lua, "close", function() {
			closed = true;
			return closed;
		});

		Lua_helper.add_callback(lua, "changePresence", function(details:String, state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float) {
			#if desktop
			DiscordClient.changePresence(details, state, smallImageKey, hasStartTimestamp, endTimestamp);
			#end
		});


		// LUA TEXTS
		Lua_helper.add_callback(lua, "makeLuaText", function(tag:String, text:String, width:Int, x:Float, y:Float) {
			tag = tag.replace('.', '');
			resetTextTag(tag);
			var leText:ModchartText = new ModchartText(x, y, text, width);
			EditorPlayState.instance.modchartTexts.set(tag, leText);
		});

		Lua_helper.add_callback(lua, "setTextString", function(tag:String, text:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				obj.text = text;
				return true;
			}
			luaTrace("setTextString: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setTextSize", function(tag:String, size:Int) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				obj.size = size;
				return true;
			}
			luaTrace("setTextSize: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setTextWidth", function(tag:String, width:Float) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				obj.fieldWidth = width;
				return true;
			}
			luaTrace("setTextWidth: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setTextBorder", function(tag:String, size:Int, color:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				var colorNum:Int = Std.parseInt(color);
				if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);

				obj.borderSize = size;
				obj.borderColor = colorNum;
				return true;
			}
			luaTrace("setTextBorder: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setTextColor", function(tag:String, color:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				var colorNum:Int = Std.parseInt(color);
				if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);

				obj.color = colorNum;
				return true;
			}
			luaTrace("setTextColor: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setTextFont", function(tag:String, newFont:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				obj.font = Paths.font(newFont);
				return true;
			}
			luaTrace("setTextFont: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setTextItalic", function(tag:String, italic:Bool) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				obj.italic = italic;
				return true;
			}
			luaTrace("setTextItalic: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});
		Lua_helper.add_callback(lua, "setTextAlignment", function(tag:String, alignment:String = 'left') {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				obj.alignment = LEFT;
				switch(alignment.trim().toLowerCase())
				{
					case 'right':
						obj.alignment = RIGHT;
					case 'center':
						obj.alignment = CENTER;
				}
				return true;
			}
			luaTrace("setTextAlignment: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});

		Lua_helper.add_callback(lua, "getTextString", function(tag:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null && obj.text != null)
			{
				return obj.text;
			}
			luaTrace("getTextString: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
		});
		Lua_helper.add_callback(lua, "getTextSize", function(tag:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				return obj.size;
			}
			luaTrace("getTextSize: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return -1;
		});
		Lua_helper.add_callback(lua, "getTextFont", function(tag:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				return obj.font;
			}
			luaTrace("getTextFont: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			Lua.pushnil(lua);
			return null;
		});
		Lua_helper.add_callback(lua, "getTextWidth", function(tag:String) {
			var obj:FlxText = getTextObject(tag);
			if(obj != null)
			{
				return obj.fieldWidth;
			}
			luaTrace("getTextWidth: Object " + tag + " doesn't exist!", false, false, FlxColor.RED);
			return 0;
		});

		Lua_helper.add_callback(lua, "addLuaText", function(tag:String) {
			if(EditorPlayState.instance.modchartTexts.exists(tag)) {
				var shit:ModchartText = EditorPlayState.instance.modchartTexts.get(tag);
				if(!shit.wasAdded) {
					getInstance().add(shit);
					shit.wasAdded = true;
					//trace('added a thing: ' + tag);
				}
			}
		});
		Lua_helper.add_callback(lua, "removeLuaText", function(tag:String, destroy:Bool = true) {
			if(!EditorPlayState.instance.modchartTexts.exists(tag)) {
				return;
			}

			var pee:ModchartText = EditorPlayState.instance.modchartTexts.get(tag);
			if(destroy) {
				pee.kill();
			}

			if(pee.wasAdded) {
				getInstance().remove(pee, true);
				pee.wasAdded = false;
			}

			if(destroy) {
				pee.destroy();
				EditorPlayState.instance.modchartTexts.remove(tag);
			}
		});

		Lua_helper.add_callback(lua, "initSaveData", function(name:String, ?folder:String = 'psychenginemods') {
			if(!EditorPlayState.instance.modchartSaves.exists(name))
			{
				var save:FlxSave = new FlxSave();
				save.bind(name, folder);
				EditorPlayState.instance.modchartSaves.set(name, save);
				return;
			}
			luaTrace('initSaveData: Save file already initialized: ' + name);
		});
		Lua_helper.add_callback(lua, "flushSaveData", function(name:String) {
			if(EditorPlayState.instance.modchartSaves.exists(name))
			{
				EditorPlayState.instance.modchartSaves.get(name).flush();
				return;
			}
			luaTrace('flushSaveData: Save file not initialized: ' + name, false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "getDataFromSave", function(name:String, field:String, ?defaultValue:Dynamic = null) {
			if(EditorPlayState.instance.modchartSaves.exists(name))
			{
				var retVal:Dynamic = Reflect.field(EditorPlayState.instance.modchartSaves.get(name).data, field);
				return retVal;
			}
			luaTrace('getDataFromSave: Save file not initialized: ' + name, false, false, FlxColor.RED);
			return defaultValue;
		});
		Lua_helper.add_callback(lua, "setDataFromSave", function(name:String, field:String, value:Dynamic) {
			if(EditorPlayState.instance.modchartSaves.exists(name))
			{
				Reflect.setField(EditorPlayState.instance.modchartSaves.get(name).data, field, value);
				return;
			}
			luaTrace('setDataFromSave: Save file not initialized: ' + name, false, false, FlxColor.RED);
		});

		Lua_helper.add_callback(lua, "checkFileExists", function(filename:String, ?absolute:Bool = false) {
			#if MODS_ALLOWED
			if(absolute)
			{
				return FileSystem.exists(filename);
			}

			var path:String = Paths.modFolders(filename);
			if(FileSystem.exists(path))
			{
				return true;
			}
			return FileSystem.exists(Paths.getPath('assets/$filename', TEXT));
			#else
			if(absolute)
			{
				return Assets.exists(filename);
			}
			return Assets.exists(Paths.getPath('assets/$filename', TEXT));
			#end
		});
		Lua_helper.add_callback(lua, "saveFile", function(path:String, content:String, ?absolute:Bool = false)
		{
			try {
				if(!absolute)
					File.saveContent(Paths.mods(path), content);
				else
					File.saveContent(path, content);

				return true;
			} catch (e:Dynamic) {
				luaTrace("saveFile: Error trying to save " + path + ": " + e, false, false, FlxColor.RED);
			}
			return false;
		});
		Lua_helper.add_callback(lua, "deleteFile", function(path:String, ?ignoreModFolders:Bool = false)
		{
			try {
				#if MODS_ALLOWED
				if(!ignoreModFolders)
				{
					var lePath:String = Paths.modFolders(path);
					if(FileSystem.exists(lePath))
					{
						FileSystem.deleteFile(lePath);
						return true;
					}
				}
				#end

				var lePath:String = Paths.getPath(path, TEXT);
				if(Assets.exists(lePath))
				{
					FileSystem.deleteFile(lePath);
					return true;
				}
			} catch (e:Dynamic) {
				luaTrace("deleteFile: Error trying to delete " + path + ": " + e, false, false, FlxColor.RED);
			}
			return false;
		});
		Lua_helper.add_callback(lua, "getTextFromFile", function(path:String, ?ignoreModFolders:Bool = false) {
			return Paths.getTextFromFile(path, ignoreModFolders);
		});

		// DEPRECATED, DONT MESS WITH THESE SHITS, ITS JUST THERE FOR BACKWARD COMPATIBILITY
		Lua_helper.add_callback(lua, "objectPlayAnimation", function(obj:String, name:String, forced:Bool = false, ?startFrame:Int = 0) {
			// luaTrace("objectPlayAnimation is deprecated! Use playAnim instead", false, true);
			if(EditorPlayState.instance.getLuaObject(obj,false) != null) {
				EditorPlayState.instance.getLuaObject(obj,false).animation.play(name, forced, false, startFrame);
				return true;
			}

			var spr:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if(spr != null) {
				spr.animation.play(name, forced, false, startFrame);
				return true;
			}
			return false;
		});
		Lua_helper.add_callback(lua, "characterPlayAnim", function(character:String, anim:String, ?forced:Bool = false) {
			luaTrace("characterPlayAnim is deprecated! Use playAnim instead", false, true);
			switch(character.toLowerCase()) {
				case 'dad':
					if(EditorPlayState.instance.dad.animOffsets.exists(anim))
						EditorPlayState.instance.dad.playAnim(anim, forced);
				case 'gf' | 'girlfriend':
					if(EditorPlayState.instance.gf != null && EditorPlayState.instance.gf.animOffsets.exists(anim))
						EditorPlayState.instance.gf.playAnim(anim, forced);
				default:
					if(EditorPlayState.instance.boyfriend.animOffsets.exists(anim))
						EditorPlayState.instance.boyfriend.playAnim(anim, forced);
			}
		});
		Lua_helper.add_callback(lua, "luaSpriteMakeGraphic", function(tag:String, width:Int, height:Int, color:String) {
			luaTrace("luaSpriteMakeGraphic is deprecated! Use makeGraphic instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				var colorNum:Int = Std.parseInt(color);
				if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);

				EditorPlayState.instance.modchartSprites.get(tag).makeGraphic(width, height, colorNum);
			}
		});
		Lua_helper.add_callback(lua, "luaSpriteAddAnimationByPrefix", function(tag:String, name:String, prefix:String, framerate:Int = 24, loop:Bool = true) {
			luaTrace("luaSpriteAddAnimationByPrefix is deprecated! Use addAnimationByPrefix instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				var cock:ModchartSprite = EditorPlayState.instance.modchartSprites.get(tag);
				cock.animation.addByPrefix(name, prefix, framerate, loop);
				if(cock.animation.curAnim == null) {
					cock.animation.play(name, true);
				}
			}
		});
		Lua_helper.add_callback(lua, "luaSpriteAddAnimationByIndices", function(tag:String, name:String, prefix:String, indices:String, framerate:Int = 24) {
			luaTrace("luaSpriteAddAnimationByIndices is deprecated! Use addAnimationByIndices instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				var strIndices:Array<String> = indices.trim().split(',');
				var die:Array<Int> = [];
				for (i in 0...strIndices.length) {
					die.push(Std.parseInt(strIndices[i]));
				}
				var pussy:ModchartSprite = EditorPlayState.instance.modchartSprites.get(tag);
				pussy.animation.addByIndices(name, prefix, die, '', framerate, false);
				if(pussy.animation.curAnim == null) {
					pussy.animation.play(name, true);
				}
			}
		});
		Lua_helper.add_callback(lua, "luaSpritePlayAnimation", function(tag:String, name:String, forced:Bool = false) {
			luaTrace("luaSpritePlayAnimation is deprecated! Use playAnim instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				EditorPlayState.instance.modchartSprites.get(tag).animation.play(name, forced);
			}
		});
		Lua_helper.add_callback(lua, "setLuaSpriteCamera", function(tag:String, camera:String = '') {
			luaTrace("setLuaSpriteCamera is deprecated! Use setObjectCamera instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				EditorPlayState.instance.modchartSprites.get(tag).cameras = [cameraFromString(camera)];
				return true;
			}
			luaTrace("Lua sprite with tag: " + tag + " doesn't exist!");
			return false;
		});
		Lua_helper.add_callback(lua, "setLuaSpriteScrollFactor", function(tag:String, scrollX:Float, scrollY:Float) {
			luaTrace("setLuaSpriteScrollFactor is deprecated! Use setScrollFactor instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				EditorPlayState.instance.modchartSprites.get(tag).scrollFactor.set(scrollX, scrollY);
				return true;
			}
			return false;
		});
		Lua_helper.add_callback(lua, "scaleLuaSprite", function(tag:String, x:Float, y:Float) {
			luaTrace("scaleLuaSprite is deprecated! Use scaleObject instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				var shit:ModchartSprite = EditorPlayState.instance.modchartSprites.get(tag);
				shit.scale.set(x, y);
				shit.updateHitbox();
				return true;
			}
			return false;
		});
		Lua_helper.add_callback(lua, "getPropertyLuaSprite", function(tag:String, variable:String) {
			luaTrace("getPropertyLuaSprite is deprecated! Use getProperty instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				var killMe:Array<String> = variable.split('.');
				if(killMe.length > 1) {
					var coverMeInPiss:Dynamic = Reflect.getProperty(EditorPlayState.instance.modchartSprites.get(tag), killMe[0]);
					for (i in 1...killMe.length-1) {
						coverMeInPiss = Reflect.getProperty(coverMeInPiss, killMe[i]);
					}
					return Reflect.getProperty(coverMeInPiss, killMe[killMe.length-1]);
				}
				return Reflect.getProperty(EditorPlayState.instance.modchartSprites.get(tag), variable);
			}
			return null;
		});
		Lua_helper.add_callback(lua, "setPropertyLuaSprite", function(tag:String, variable:String, value:Dynamic) {
			luaTrace("setPropertyLuaSprite is deprecated! Use setProperty instead", false, true);
			if(EditorPlayState.instance.modchartSprites.exists(tag)) {
				var killMe:Array<String> = variable.split('.');
				if(killMe.length > 1) {
					var coverMeInPiss:Dynamic = Reflect.getProperty(EditorPlayState.instance.modchartSprites.get(tag), killMe[0]);
					for (i in 1...killMe.length-1) {
						coverMeInPiss = Reflect.getProperty(coverMeInPiss, killMe[i]);
					}
					Reflect.setProperty(coverMeInPiss, killMe[killMe.length-1], value);
					return true;
				}
				Reflect.setProperty(EditorPlayState.instance.modchartSprites.get(tag), variable, value);
				return true;
			}
			luaTrace("setPropertyLuaSprite: Lua sprite with tag: " + tag + " doesn't exist!");
			return false;
		});
		Lua_helper.add_callback(lua, "musicFadeIn", function(duration:Float, fromValue:Float = 0, toValue:Float = 1) {
			FlxG.sound.music.fadeIn(duration, fromValue, toValue);
			luaTrace('musicFadeIn is deprecated! Use soundFadeIn instead.', false, true);

		});
		Lua_helper.add_callback(lua, "musicFadeOut", function(duration:Float, toValue:Float = 0) {
			FlxG.sound.music.fadeOut(duration, toValue);
			luaTrace('musicFadeOut is deprecated! Use soundFadeOut instead.', false, true);
		});

		// Other stuff
		Lua_helper.add_callback(lua, "stringStartsWith", function(str:String, start:String) {
			return str.startsWith(start);
		});
		Lua_helper.add_callback(lua, "stringEndsWith", function(str:String, end:String) {
			return str.endsWith(end);
		});
		Lua_helper.add_callback(lua, "stringSplit", function(str:String, split:String) {
			return str.split(split);
		});
		Lua_helper.add_callback(lua, "stringTrim", function(str:String) {
			return str.trim();
		});
		
		Lua_helper.add_callback(lua, "directoryFileList", function(folder:String) {
			var list:Array<String> = [];
			#if sys
			if(FileSystem.exists(folder)) {
				for (folder in FileSystem.readDirectory(folder)) {
					if (!list.contains(folder)) {
						list.push(folder);
					}
				}
			}
			#end
			return list;
		});
        
        Lua_helper.add_callback(lua,"removeActorShader", function(id:String) {
			if (getObjectDirectly(id, false) != null)
			{
				lua_Shaders.remove(id);
                getObjectDirectly(id, false).shader = null;
			}

            if(getActorByName(id) != null)
            {
                lua_Shaders.remove(id);
                getActorByName(id).shader = null;
            }
        });

        Lua_helper.add_callback(lua, "summongHxShader", function(name:String, classString:String, ?hardCoded:Bool) {

            if (!ClientPrefs.shaders && !hardCoded) //now it should get some shaders hardcoded if i need
                return;

            var shaderClass = Type.resolveClass(classString);
            if (shaderClass != null)
            {
                var shad = Type.createInstance(shaderClass, []);
                lua_Shaders.set(name, shad);
                trace('created shader: '+name);
            }
            else 
            {
                lime.app.Application.current.window.alert("shader broken:\n"+classString+" is non existent","Hitmans Corps!");
            }
        });
        Lua_helper.add_callback(lua,"setActorShader", function(actorStr:String, shaderName:String) {
			var shad = lua_Shaders.get(shaderName);
			var actor = getActorByName(actorStr);
			var spr:FlxSprite = EditorPlayState.instance.getLuaObject(actorStr);
	
			if(spr==null){
				var split:Array<String> = actorStr.split('.');
				spr = getObjectDirectly(split[0]);
				if(split.length > 1) {
					spr = getVarInArray(getPropertyLoopThingWhatever(split), split[split.length-1]);
				}
			}

			if (shad != null)
			{
				if (spr != null)
					spr.shader = Reflect.getProperty(shad, 'shader');
				if (actor != null)
					actor.shader = Reflect.getProperty(shad, 'shader');
				
				if (actor == null && spr == null) trace('Actor and spr are both null!');
			}
        });

        Lua_helper.add_callback(lua, "setShaderProperty", function(shaderName:String, prop:String, value:Dynamic) {
            var shad = lua_Shaders.get(shaderName);

            if(shad != null)
            {
                Reflect.setProperty(shad, prop, value);
                //trace('set shader prop');
            }else if (shad == null){
				return;
			}
        });

        Lua_helper.add_callback(lua,"tweenShaderProperty", function(shaderName:String, prop:String, value:Dynamic, time:Float, easeStr:String = "linear", ?tag:String = 'shader') {
            var shad = lua_Shaders.get(shaderName);
            var ease = getFlxEaseByString(easeStr);

            if(shad != null)
            {
                var startVal = Reflect.getProperty(shad, prop);

				EditorPlayState.instance.modchartTweens.set(tag, 
                    EditorPlayState.tweenManager.num(startVal, value, time, {
                    ease: ease,
                    onUpdate: function(tween:FlxTween) {
                        var ting = FlxMath.lerp(startVal,value, ease(tween.percent));
                        Reflect.setProperty(shad, prop, ting);
                    }, 
                    onComplete: function(tween:FlxTween) {
                        Reflect.setProperty(shad, prop, value);
                        EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
                        EditorPlayState.instance.modchartTweens.remove(tag);
                    }})
                );
                //trace('set shader prop');
			}else if(shad == null){
				return;
			}
        });

		Lua_helper.add_callback(lua,"setCameraShader", function(camStr:String, shaderName:String) {
            var cam = getCameraByName(camStr);
            var shad = lua_Shaders.get(shaderName);

            if(cam != null && shad != null)
            {
                cam.shaders.push(new ShaderFilter(Reflect.getProperty(shad, 'shader'))); //use reflect to workaround compiler errors
                cam.shaderNames.push(shaderName);
                cam.cam.setFilters(cam.shaders);
                //trace('added shader '+shaderName+" to " + camStr);
			}else if(cam == null && shad == null){
				return;
			}
        });
        Lua_helper.add_callback(lua,"removeCameraShader", function(camStr:String, shaderName:String) {
            var cam = getCameraByName(camStr);
            if (cam != null)
            {
                if (cam.shaderNames.contains(shaderName))
                {
                    var idx:Int = cam.shaderNames.indexOf(shaderName);
                    if (idx != -1)
                    {
                        cam.shaderNames.remove(cam.shaderNames[idx]);
                        cam.shaders.remove(cam.shaders[idx]);
                        cam.cam.setFilters(cam.shaders); //refresh filters
                    }
                    
                }
            }
        });

		Lua_helper.add_callback(lua, "createLuaShader", function(id:String, file:String, glslVersion:String = '120'){
			var funnyCustomShader:CustomCodeShader = new CustomCodeShader(file, glslVersion);
			lua_Custom_Shaders.set(id, funnyCustomShader);
		});

		Lua_helper.add_callback(lua, "setActorCustomShader", function(id:String, actor:String){
			var funnyCustomShader:CustomCodeShader = lua_Custom_Shaders.get(id);
			if (getActorByName(actor) != null)
				getActorByName(actor).shader = funnyCustomShader;
			if (getObjectDirectly(actor, false) != null)
				getObjectDirectly(actor, false).shader = funnyCustomShader;
		});

		Lua_helper.add_callback(lua, "removeActorCustomShader", function(actor:String){
			if (getActorByName(actor) != null)
				getActorByName(actor).shader = null;
			if (getObjectDirectly(actor, false) != null)
				getObjectDirectly(actor, false).shader = null;
		});

		Lua_helper.add_callback(lua, "setCameraCustomShader", function(id:String, camera:String){
			var funnyCustomShader:CustomCodeShader = lua_Custom_Shaders.get(id);
			cameraFromString(camera).setFilters([new ShaderFilter(funnyCustomShader)]);
		});

		Lua_helper.add_callback(lua, "pushShaderToCamera", function(id:String, camera:String){
			var funnyCustomShader:CustomCodeShader = lua_Custom_Shaders.get(id);
			#if (flixel >= "5.4.0")
				@:privateAccess
				cameraFromString(camera)._filters.push(new ShaderFilter(funnyCustomShader));
			#else
				@:privateAccess
				cameraFromString(camera)._filters.push(new ShaderFilter(funnyCustomShader));
			#end
		});

		Lua_helper.add_callback(lua, "setCameraNoCustomShader", function(camera:String){
			cameraFromString(camera).setFilters(null);
		});

		Lua_helper.add_callback(lua, "getCustomShaderProperty", function(id:String, property:Dynamic) {
			var funnyCustomShader:CustomCodeShader = lua_Custom_Shaders.get(id);
			return funnyCustomShader.hget(property);
		});

		Lua_helper.add_callback(lua, "setCustomShaderProperty", function(id:String, property:String, value:Dynamic) {
			var funnyCustomShader:CustomCodeShader = lua_Custom_Shaders.get(id);
			funnyCustomShader.hset(property, value);
		});

		//Custom shader made by me (glowsoony)
		Lua_helper.add_callback(lua, "tweenCustomShaderProperty", function(tag:String, shaderName:String, prop:String, value:Dynamic, time:Float, easeStr:String = "linear", startVal:Null<Float> = null) {
            if (!ClientPrefs.shaders) return;
            var shad:CustomCodeShader = lua_Custom_Shaders.get(shaderName);
            var ease = getFlxEaseByString(easeStr);
			var startValue:Null<Float> = startVal;
			if (startValue == null) startValue = shad.hget(prop);

            if(shad != null)
            {
				EditorPlayState.instance.modchartTweens.set(tag, 
					EditorPlayState.tweenManager.num(startValue, value, time, {
					onUpdate: function(tween:FlxTween){
						var ting = FlxMath.lerp(startValue, value, ease(tween.percent));
                    	shad.hset(prop, ting);
					}, ease: ease, 
					onComplete: function(tween:FlxTween) {
						shad.hset(prop, value);
						EditorPlayState.instance.callOnLuas('onTweenCompleted', [tag]);
						EditorPlayState.instance.modchartTweens.remove(tag);
					}})
				);
                //trace('set shader prop');
            }
        });

		//SHADER PROPERTY FROM LUA BRUH
		Lua_helper.add_callback(lua, "getLuaShaderProperty", function(shaderName:String, prop:String) {
            var shad = EditorPlayState.instance.runtimeShaders.get(shaderName);

            if(shad != null)
            {
                Reflect.getProperty(shad, prop);
                //trace('set shader prop');
            }else if (shad == null){
				return;
			}
        });

		Lua_helper.add_callback(lua, "setLuaShaderProperty", function(shaderName:String, prop:String, value:Dynamic) {
            var shad = EditorPlayState.instance.runtimeShaders.get(shaderName);

            if(shad != null)
            {
                Reflect.setProperty(shad, prop, value);
                //trace('set shader prop');
            }else if (shad == null){
				return;
			}
        });

		//Welp finally this code is FINAL! (unless you want to make changes edwhak!)
		Lua_helper.add_callback(lua, "makeArrowCopy", function(tag:String = '', ?compositionArray:Array<Dynamic>) {
            tag = tag.replace('.', '');
            resetSpriteTag(tag);
			
			if (compositionArray == null) compositionArray = [0, 0, 0, false, "camHUD", '', '', '', 1, 1]; // works ig?
			//X = 0, Y = 1, noteData = 2, isStrum = 3, camera = 4, daSkin = 5, daType = 6, daNoteTypeStyle = 7, daScaleX = 8, daScaleY = 9

            trace('what the x, ' + compositionArray[0] + ', y, ' + compositionArray[1] + ', noteData, ' + compositionArray[2] + 
				', isStrum, ' + compositionArray[3] + ', camera, ' + compositionArray[4] + ', daSkin, ' + compositionArray[5] + 
				', daType, ' + compositionArray[6] + ', daNoteTypeStyle, ' + compositionArray[7] + 
				', daScaleX, ' + compositionArray[8] + ', daScaleY, ' + compositionArray[9]);

            var noteTypeSkin = compositionArray[7];

            var theSkin = 'Skins/Notes/${ClientPrefs.notesSkin[0]}/NOTE_assets';
            if (compositionArray[5] != '') theSkin = compositionArray[5];

 			var colArray:Array<String> = ['purple', 'blue', 'green', 'red'];

            if (compositionArray[3] == true){
                var spriteCopy:StrumNew = new StrumNew(compositionArray[0],compositionArray[1],Std.int(compositionArray[2]),0,theSkin,null,false);
				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length], true);
                spriteCopy.camera = cameraFromString(compositionArray[4]);
                getInstance().add(spriteCopy);
                EditorPlayState.instance.modchartSprites.set(tag, spriteCopy);
            }else{
                var spriteCopy:NewNote = new NewNote(0,Std.int(compositionArray[2]),false,true);
                spriteCopy.setPosition(compositionArray[0],compositionArray[1]);
                spriteCopy.scale.set(compositionArray[8],compositionArray[9]);

                if (compositionArray[6] != '' && (compositionArray[5] == '')) {
                    spriteCopy.noteType = compositionArray[6];
                    if (noteTypeSkin != '' && (compositionArray[6].toLowerCase() == 'hurt' || compositionArray[6].toLowerCase() == 'mine'))
                        spriteCopy.reloadNote('', 'Skins/${noteTypeSkin}');
                }
                else if (compositionArray[5] != '' && (compositionArray[6] == '')) {
                   spriteCopy.noteType = '';
                   spriteCopy.reloadNote('', compositionArray[5]);
                }
                else{
                   spriteCopy.reloadNote('', 'Skins/Notes/${ClientPrefs.notesSkin[0]}/NOTE_assets');
                }

				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length] + 'Scroll', true);
                spriteCopy.camera = cameraFromString(compositionArray[4]);
                getInstance().add(spriteCopy);
                EditorPlayState.instance.modchartSprites.set(tag, spriteCopy);
            }
        });

		/*Lua_helper.add_callback(lua, "makeArrowCopy", function(tag:String = '', x:Float, y:Float, noteData:Int, isStrum:Bool, 
			camera:String, daSkin:String, daType:String, daNoteTypeStyle:String, daScaleX:Float, daScaleY:Float) 
		{
            tag = tag.replace('.', '');
            resetSpriteTag(tag);
			
			if (compositionArray == null) compositionArray = [0, 0, 0, false, "camHUD", '', '', '', 1, 1]; // works ig?
			//X = 0, Y = 1, noteData = 2, isStrum = 3, camera = 4, daSkin = 5, daType = 6, daNoteTypeStyle = 7, daScaleX = 8, daScaleY = 9

            trace('what the x, ' + compositionArray[0] + ', y, ' + compositionArray[1] + ', noteData, ' + compositionArray[2] + 
				', isStrum, ' + compositionArray[3] + ', camera, ' + compositionArray[4] + ', daSkin, ' + compositionArray[5] + 
				', daType, ' + compositionArray[6] + ', daNoteTypeStyle, ' + compositionArray[7] + 
				', daScaleX, ' + compositionArray[8] + ', daScaleY, ' + compositionArray[9]);

            var noteTypeSkin = compositionArray[7];

            var theSkin = 'Skins/Notes/${ClientPrefs.notesSkin[0]}/NOTE_assets';
            if (compositionArray[5] != '') theSkin = compositionArray[5];

 			var colArray:Array<String> = ['purple', 'blue', 'green', 'red'];

            if (compositionArray[3] == true){
                var spriteCopy:StrumNew = new StrumNew(compositionArray[0],compositionArray[1],compositionArray[2],0,theSkin,null,false);
				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length], true);
                spriteCopy.camera = cameraFromString(compositionArray[4]);
                getInstance().add(spriteCopy);
                EditorPlayState.instance.modchartSprites.set(tag, spriteCopy);
            }else{
                var spriteCopy:NewNote = new NewNote(0,compositionArray[2],false,true);
                spriteCopy.setPosition(compositionArray[0],compositionArray[1]);
                spriteCopy.scale.set(compositionArray[8],compositionArray[9]);

                if (compositionArray[6] != '' && (compositionArray[5] == '')) {
                    spriteCopy.noteType = compositionArray[6];
                    if (noteTypeSkin != '' && (compositionArray[6].toLowerCase() == 'hurt' || compositionArray[6].toLowerCase() == 'mine'))
                        spriteCopy.reloadNote('', 'Skins/${noteTypeSkin}');
                }
                else if (compositionArray[5] != '' && (compositionArray[6] == '')) {
                   spriteCopy.noteType = '';
                   spriteCopy.reloadNote('', compositionArray[5]);
                }
                else{
                   spriteCopy.reloadNote('', 'Skins/Notes/${ClientPrefs.notesSkin[0]}/NOTE_assets');
                }

				spriteCopy.animation.play(colArray[Std.int(compositionArray[2]) % colArray.length] + 'Scroll', true);
                spriteCopy.camera = cameraFromString(compositionArray[4]);
                getInstance().add(spriteCopy);
                EditorPlayState.instance.modchartSprites.set(tag, spriteCopy);
            }
        });*/

		Lua_helper.add_callback(lua, "objectPlayLoopNoteAnimation", function(obj:String, name:String, forced:Bool = false, ?startFrame:Int = 0, ?isStrum:Bool = false) {
			// luaTrace("objectPlayAnimation is deprecated! Use playAnim instead", false, true)

			var spr:Dynamic = EditorPlayState.instance.modchartSprites.get(obj);

			if(spr != null) {
				spr.animation.play(name, forced, false, startFrame);
				spr.animation.finishCallback = function(na:String)
				{
					spr.animation.play(name, forced, false, startFrame);
				}
				return true;
			}
			return false;
		});

		// Lua_helper.add_callback(lua, "threadBeat", function(beat:Float, func:Dynamic) {
        //     EditorPlayState.threadBeat(beat, func);
            // var retVal:Dynamic = null;

            // #if hscript
            // initHaxeModule();
            // try {
            //     retVal = hscript.execute('game.threadBeat($beat, () -> {$func});');
            // }
            // catch (e:Dynamic) {
            //     luaTrace(scriptName + ": threadBeat("+ beat +") failed: " + e, false, false, FlxColor.RED);
            // }
            // #else
            // luaTrace("threadBeat: doesn't work in this platform!", false, false, FlxColor.RED);
            // #end

            // if(retVal != null && !isOfTypes(retVal, [Bool, Int, Float, String, Array])) retVal = null;
            // if(retVal == null) Lua.pushnil(lua);
            // return retVal;
        // });

		// Lua_helper.add_callback(lua, "threadUpdate", function(beatStart:Float, beatEnd:Float, func:Dynamic, onComp:Dynamic) {
        //     EditorPlayState.threadUpdate(beatStart, beatEnd, func, onComp);
            // var retVal:Dynamic = null;

            // #if hscript
            // initHaxeModule();
            // try {
            //     retVal = hscript.execute('game.threadUpdate($beatStart,$beatEnd, () -> {$func}, () -> {$onComp});');
            // }
            // catch (e:Dynamic) {
            //     luaTrace(scriptName + ": threadUpdate("+ beatStart +"," + beatEnd + ") failed: " + e, false, false, FlxColor.RED);
            // }
            // #else
            // luaTrace("threadUpdate: doesn't work in this platform!", false, false, FlxColor.RED);
            // #end

            // if(retVal != null && !isOfTypes(retVal, [Bool, Int, Float, String, Array])) retVal = null;
            // if(retVal == null) Lua.pushnil(lua);
            // return retVal;
        // });

		Lua_helper.add_callback(lua, "makeLuaProxy", function(tag:String, x:Float, y:Float, ?camera:String = '') {
			var micamara:FlxCamera = EditorPlayState.instance.camProxy;

			if(EditorPlayState.instance.aftBitmap != null)
			{
				tag = tag.replace('.', '');
				resetSkewedSpriteTag(tag);
				var leSprite:FlxSkewedSprite = new FlxSkewedSprite(x, y);

				leSprite.loadGraphic(EditorPlayState.instance.aftBitmap.bitmap); //idk if this even works but whatever
				
				leSprite.antialiasing = ClientPrefs.globalAntialiasing;
				EditorPlayState.instance.modchartSkewedSprite.set(tag, leSprite);
				leSprite.active = true;

				if (camera != null && camera != '') {
					leSprite.camera = cameraFromString(camera);
				}else{
					leSprite.camera = micamara;
				}
			}else{
				luaTrace('makeLuaProxy: attempted to make a proxy but aftBitmap is null!', false, false, FlxColor.RED);
			}
		});

		Discord.DiscordClient.addLuaCallbacks(lua);
		#if SScript SSHScriptEditor.implement(this); #end
		
		try{
			var isString:Bool = !FileSystem.exists(scriptName);
			var result:Dynamic = null;
			if(scriptName.endsWith('.lua')) result = LuaL.dofile(lua, scriptName);
			else
			{
   	 			result = LuaL.dostring(lua, scriptName);
    			scriptName = 'stringscript';
			}

			var resultStr:String = Lua.tostring(lua, result);
			if(resultStr != null && result != 0) {
				trace(resultStr);
				#if windows
				Application.current.window.alert(resultStr, 'Error on lua script!');
				#else
				luaTrace('$scriptName\n$resultStr', true, false, FlxColor.RED);
				#end
				lua = null;
				EditorPlayState.instance.luaArray.remove(this);
				EditorPlayState.instance.luaArray = [];
				return;
			}
			if(isString) scriptName = 'unknown';
		} catch(e:Dynamic) {
			Application.current.window.alert('Failed to catch error on script and error on loading script!', 'Error on loading...');
			trace(e);
			return;
		}
		trace('lua file loaded succesfully:' + scriptName);
		call('onCreate', []);
		#end
	}

	public static function isOfTypes(value:Any, types:Array<Dynamic>)
	{
		for (type in types)
		{
			if(Std.isOfType(value, type)) return true;
		}
		return false;
	}

	#if hscript
	public function initHaxeModule()
	{
		if(hscript == null)
		{
			trace('initializing haxe interp for: $scriptName');
			hscript = new HScript(); //TO DO: Fix issue with 2 scripts not being able to use the same variable names
		}
	}
	#end

	public static function setVarInArray(instance:Dynamic, variable:String, value:Dynamic):Any
	{
		var shit:Array<String> = variable.split('[');
		if(shit.length > 1)
		{
			var blah:Dynamic = null;
			if(EditorPlayState.instance.variables.exists(shit[0]))
			{
				var retVal:Dynamic = EditorPlayState.instance.variables.get(shit[0]);
				if(retVal != null)
					blah = retVal;
			}
			else
				blah = Reflect.getProperty(instance, shit[0]);

			for (i in 1...shit.length)
			{
				var leNum:Dynamic = shit[i].substr(0, shit[i].length - 1);
				if(i >= shit.length-1) //Last array
					blah[leNum] = value;
				else //Anything else
					blah = blah[leNum];
			}
			return blah;
		}
		/*if(Std.isOfType(instance, Map))
			instance.set(variable,value);
		else*/
			
		if(EditorPlayState.instance.variables.exists(variable))
		{
			EditorPlayState.instance.variables.set(variable, value);
			return true;
		}

		Reflect.setProperty(instance, variable, value);
		return true;
	}
	public static function getVarInArray(instance:Dynamic, variable:String):Any
	{
		var shit:Array<String> = variable.split('[');
		if(shit.length > 1)
		{
			var blah:Dynamic = null;
			if(EditorPlayState.instance.variables.exists(shit[0]))
			{
				var retVal:Dynamic = EditorPlayState.instance.variables.get(shit[0]);
				if(retVal != null)
					blah = retVal;
			}
			else
				blah = Reflect.getProperty(instance, shit[0]);

			for (i in 1...shit.length)
			{
				var leNum:Dynamic = shit[i].substr(0, shit[i].length - 1);
				blah = blah[leNum];
			}
			return blah;
		}

		if(EditorPlayState.instance.variables.exists(variable))
		{
			var retVal:Dynamic = EditorPlayState.instance.variables.get(variable);
			if(retVal != null)
				return retVal;
		}

		return Reflect.getProperty(instance, variable);
	}

	inline static function getTextObject(name:String):FlxText
	{
		return EditorPlayState.instance.modchartTexts.exists(name) ? EditorPlayState.instance.modchartTexts.get(name) : Reflect.getProperty(EditorPlayState.instance, name);
	}

	#if (!flash && sys)
	public function getShader(obj:String):FlxRuntimeShader
	{
		var killMe:Array<String> = obj.split('.');
		var leObj:FlxSprite = getObjectDirectly(killMe[0]);
		if(killMe.length > 1) {
			leObj = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length-1]);
		}

		if(leObj != null) {
			var shader:Dynamic = leObj.shader;
			var shader:FlxRuntimeShader = shader;
			return shader;
		}
		return null;
	}
	#end
	
	function initLuaShader(name:String, ?glslVersion:Int = 120)
	{
		if(!ClientPrefs.shaders) return false;

		#if (!flash && sys)
		if(EditorPlayState.instance.runtimeShaders.exists(name))
		{
			luaTrace('Shader $name was already initialized!');
			return true;
		}
		
		var foldersToCheck:Array<String> = [Paths.mods('shaders/')];
		if(Mods.currentModDirectory != null && Mods.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Mods.currentModDirectory + '/shaders/'));

		for(mod in Mods.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/shaders/'));
		
		
		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				var frag:String = folder + name + '.frag';
				var vert:String = folder + name + '.vert';
				var found:Bool = false;
				if(FileSystem.exists(frag))
				{
					frag = File.getContent(frag);
					found = true;
				}
				else frag = null;

				if(FileSystem.exists(vert))
				{
					vert = File.getContent(vert);
					found = true;
				}
				else vert = null;

				if(found)
				{
					EditorPlayState.instance.runtimeShaders.set(name, [frag, vert]);
					//trace('Found shader $name!');
					return true;
				}
			}
		}
		luaTrace('Missing shader $name .frag AND .vert files!', false, false, FlxColor.RED);
		#else
		luaTrace('This platform doesn\'t support Runtime Shaders!', false, false, FlxColor.RED);
		#end
		return false;
	}

	function getGroupStuff(leArray:Dynamic, variable:String) {
		var killMe:Array<String> = variable.split('.');
		if(killMe.length > 1) {
			var coverMeInPiss:Dynamic = Reflect.getProperty(leArray, killMe[0]);
			for (i in 1...killMe.length-1) {
				coverMeInPiss = Reflect.getProperty(coverMeInPiss, killMe[i]);
			}
			switch(Type.typeof(coverMeInPiss)){
				case ValueType.TClass(haxe.ds.StringMap) | ValueType.TClass(haxe.ds.ObjectMap) | ValueType.TClass(haxe.ds.IntMap) | ValueType.TClass(haxe.ds.EnumValueMap):
					return coverMeInPiss.get(killMe[killMe.length-1]);
				default:
					return Reflect.getProperty(coverMeInPiss, killMe[killMe.length-1]);
			};
		}
		switch(Type.typeof(leArray)){
			case ValueType.TClass(haxe.ds.StringMap) | ValueType.TClass(haxe.ds.ObjectMap) | ValueType.TClass(haxe.ds.IntMap) | ValueType.TClass(haxe.ds.EnumValueMap):
				return leArray.get(variable);
			default:
				return Reflect.getProperty(leArray, variable);
		};
	}

	function loadFrames(spr:FlxSprite, image:String, spriteType:String)
	{
		switch(spriteType.toLowerCase().trim())
		{
			case "texture" | "textureatlas" | "tex":
				spr.frames = AtlasFrameMaker.construct(image);

			case "texture_noaa" | "textureatlas_noaa" | "tex_noaa":
				spr.frames = AtlasFrameMaker.construct(image, null, true);

			case "packer" | "packeratlas" | "pac":
				spr.frames = Paths.getPackerAtlas(image);

			default:
				spr.frames = Paths.getSparrowAtlas(image);
		}
	}

	function setGroupStuff(leArray:Dynamic, variable:String, value:Dynamic) {
		var killMe:Array<String> = variable.split('.');
		if(killMe.length > 1) {
			var coverMeInPiss:Dynamic = Reflect.getProperty(leArray, killMe[0]);
			for (i in 1...killMe.length-1) {
				coverMeInPiss = Reflect.getProperty(coverMeInPiss, killMe[i]);
			}
			Reflect.setProperty(coverMeInPiss, killMe[killMe.length-1], value);
			return;
		}
		Reflect.setProperty(leArray, variable, value);
	}

	function resetTextTag(tag:String) {
		if(!EditorPlayState.instance.modchartTexts.exists(tag)) {
			return;
		}

		var pee:ModchartText = EditorPlayState.instance.modchartTexts.get(tag);
		pee.kill();
		if(pee.wasAdded) {
			EditorPlayState.instance.remove(pee, true);
		}
		pee.destroy();
		EditorPlayState.instance.modchartTexts.remove(tag);
	}

	function resetSpriteTag(tag:String) {
		if(!EditorPlayState.instance.modchartSprites.exists(tag)) {
			return;
		}

		var pee:ModchartSprite = EditorPlayState.instance.modchartSprites.get(tag);
		pee.kill();
		if(pee.wasAdded) {
			EditorPlayState.instance.remove(pee, true);
		}
		pee.destroy();
		EditorPlayState.instance.modchartSprites.remove(tag);
	}
	function resetSkewedSpriteTag(tag:String) {
        #if LUA_ALLOWED
        if(!EditorPlayState.instance.modchartSkewedSprite.exists(tag)) {
            return;
        }
        
        var target:FlxSkewedSprite = EditorPlayState.instance.modchartSkewedSprite.get(tag);
        target.kill();
        EditorPlayState.instance.remove(target, true);
        target.destroy();
        EditorPlayState.instance.modchartSkewedSprite.remove(tag);
        #end
    }

	function cancelTween(tag:String) {
		if(EditorPlayState.instance.modchartTweens.exists(tag)) {
			EditorPlayState.instance.modchartTweens.get(tag).cancel();
			EditorPlayState.instance.modchartTweens.get(tag).destroy();
			EditorPlayState.instance.modchartTweens.remove(tag);
		}
	}

	function tweenShit(tag:String, vars:String) {
		cancelTween(tag);
		var variables:Array<String> = vars.split('.');
		var sexyProp:Dynamic = getObjectDirectly(variables[0]);
		if(variables.length > 1) {
			sexyProp = getVarInArray(getPropertyLoopThingWhatever(variables), variables[variables.length-1]);
		}
		return sexyProp;
	}

	function cancelTimer(tag:String) {
		if(EditorPlayState.instance.modchartTimers.exists(tag)) {
			var theTimer:FlxTimer = EditorPlayState.instance.modchartTimers.get(tag);
			theTimer.cancel();
			theTimer.destroy();
			EditorPlayState.instance.modchartTimers.remove(tag);
		}
	}

	//Better optimized than using some getProperty shit or idk
	function getFlxEaseByString(?ease:String = '') {
		switch (ease.toLowerCase().trim())
        {
            case 'backin':
                return ImprovedEases.backIn;
            case 'backinout':
                return ImprovedEases.backInOut;
            case 'backout':
                return ImprovedEases.backOut;
            case 'backoutin':
                return ImprovedEases.backOutIn;
            case 'bounce':
                return ImprovedEases.bounce;
            case 'bouncein':
                return ImprovedEases.bounceIn;
            case 'bounceinout':
                return ImprovedEases.bounceInOut;
            case 'bounceout':
                return ImprovedEases.bounceOut;
            case 'bounceoutin':
                return ImprovedEases.bounceOutIn;
            case 'bell':
                return ImprovedEases.bell;
            case 'circin':
                return ImprovedEases.circIn;
            case 'circinout':
                return ImprovedEases.circInOut;
            case 'circout':
                return ImprovedEases.circOut;
            case 'circoutin':
                return ImprovedEases.circOutIn;
            case 'cubein':
                return ImprovedEases.cubeIn;
            case 'cubeinout':
                return ImprovedEases.cubeInOut;
            case 'cubeout':
                return ImprovedEases.cubeOut;
            case 'cubeoutin':
                return ImprovedEases.cubeOutIn;
            case 'elasticin':
                return ImprovedEases.elasticIn;
            case 'elasticinout':
                return ImprovedEases.elasticInOut;
            case 'elasticout':
                return ImprovedEases.elasticOut;
            case 'elasticoutin':
                return ImprovedEases.elasticOutIn;
            case 'expoin':
                return ImprovedEases.expoIn;
            case 'expoinout':
                return ImprovedEases.expoInOut;
            case 'expoout':
                return ImprovedEases.expoOut;
            case 'expooutin':
                return ImprovedEases.expoOutIn;
            case 'inverse':
                return ImprovedEases.inverse;
            case 'instant':
                return ImprovedEases.instant;
            case 'pop':
                return ImprovedEases.pop;
            case 'popelastic':
                return ImprovedEases.popElastic;
            case 'pulse':
                return ImprovedEases.pulse;
            case 'pulseelastic':
                return ImprovedEases.pulseElastic;
            case 'quadin':
                return ImprovedEases.quadIn;
            case 'quadinout':
                return ImprovedEases.quadInOut;
            case 'quadout':
                return ImprovedEases.quadOut;
            case 'quadoutin':
                return ImprovedEases.quadOutIn;
            case 'quartin':
                return ImprovedEases.quartIn;
            case 'quartinout':
                return ImprovedEases.quartInOut;
            case 'quartout':
                return ImprovedEases.quartOut;
            case 'quartoutin':
                return ImprovedEases.quartOutIn;
            case 'quintin':
                return ImprovedEases.quintIn;
            case 'quintinout':
                return ImprovedEases.quintInOut;
            case 'quintout':
                return ImprovedEases.quintOut;
            case 'quintoutin':
                return ImprovedEases.quintOutIn;
            case 'sinein':
                return ImprovedEases.sineIn;
            case 'sineinout':
                return ImprovedEases.sineInOut;
            case 'sineout':
                return ImprovedEases.sineOut;
            case 'sineoutin':
                return ImprovedEases.sineOutIn;
            case 'spike':
                return ImprovedEases.spike;
            case 'smoothstepin':
                return ImprovedEases.smoothStepIn;
            case 'smoothstepinout':
                return ImprovedEases.smoothStepInOut;
            case 'smoothstepout':
                return ImprovedEases.smoothStepOut;
            case 'smootherstepin':
                return ImprovedEases.smootherStepIn;
            case 'smootherstepinout':
                return ImprovedEases.smootherStepInOut;
            case 'smootherstepout':
                return ImprovedEases.smootherStepOut;
            case 'tap':
                return ImprovedEases.tap;
            case 'tapelastic':
                return ImprovedEases.tapElastic;
            case 'tri':
                return ImprovedEases.tri;
        }
        return ImprovedEases.linear;
	}

	function blendModeFromString(blend:String):BlendMode {
		switch(blend.toLowerCase().trim()) {
			case 'add': return ADD;
			case 'alpha': return ALPHA;
			case 'darken': return DARKEN;
			case 'difference': return DIFFERENCE;
			case 'erase': return ERASE;
			case 'hardlight': return HARDLIGHT;
			case 'invert': return INVERT;
			case 'layer': return LAYER;
			case 'lighten': return LIGHTEN;
			case 'multiply': return MULTIPLY;
			case 'overlay': return OVERLAY;
			case 'screen': return SCREEN;
			case 'shader': return SHADER;
			case 'subtract': return SUBTRACT;
		}
		return NORMAL;
	}

	public static function pushCustomCameras(name:String, camera:FlxCamera)
	{
		var camBool:Bool = (camera != null);
		trace('name for cam: ' + name + ', is camera not null: ' + camBool);
		lua_Cameras.set(name, {cam: camera, shaders: [], shaderNames: []});
	}

	public function cameraFromString(cam:String):FlxCamera {
		var camera:LuaCamera = getCameraByName(cam);
		if (camera == null)
		{
			trace('I am null!');
			switch(cam.toLowerCase()) {
				case 'camhud' | 'hud': return EditorPlayState.instance.camHUD;
				case 'notecameras0' | 'notes0': return EditorPlayState.instance.noteCameras0;
				case 'notecameras1' | 'notes1': return EditorPlayState.instance.noteCameras1;
				case 'camproxy' | 'proxy': return EditorPlayState.instance.camProxy;
				case 'camother' | 'other': return EditorPlayState.instance.camOther;
				case 'caminterfaz' | 'interfaz': return EditorPlayState.instance.camInterfaz;
				case 'camvisuals' | 'visuals': return EditorPlayState.instance.camVisuals;
			}
			
			//modded cameras
			if (Std.isOfType(EditorPlayState.instance.variables.get(cam), FlxCamera)){
				return EditorPlayState.instance.variables.get(cam);
			}
			return EditorPlayState.instance.camGame;
		}
		return camera.cam;
	}

	public static function getCameraByName(id:String):LuaCamera
    {
        if(lua_Cameras.exists(id)) return lua_Cameras.get(id);
        switch(id.toLowerCase())
        {
            case 'camhud' | 'hud': return lua_Cameras.get("hud");
			case 'notecameras0' | 'notes0': return lua_Cameras.get("notecameras0");
			case 'notecameras1' | 'notes1': return lua_Cameras.get("notecameras1");
			case 'camproxy' | 'proxy': return lua_Cameras.get("proxy");
			case 'camother' | 'other': return lua_Cameras.get("other");
			case 'caminterfaz' | 'interfaz': return lua_Cameras.get("interfaz");
			case 'camvisuals' | 'visuals': return lua_Cameras.get("visuals");
			case 'camgame' | 'game': return lua_Cameras.get('game');
        }
        return null;
    }

    public static function killShaders() //dead
    {
        for (cam in lua_Cameras)
        {
            cam.shaders = [];
            cam.shaderNames = [];
        }
    }

	public static function getActorByName(id:String):Dynamic //kade to psych
	{
		if (lua_Cameras.exists(id))
            return lua_Cameras.get(id).cam;
		
		// pre defined names
		switch(id)
		{
			case 'boyfriend' | 'bf':
				@:privateAccess
				return EditorPlayState.instance.boyfriend;
		}

		if (Std.parseInt(id) == null)
			return Reflect.getProperty(getTargetInstance(), id);

		return EditorPlayState.instance.strumLineNotes.members[Std.parseInt(id)];
	}

	public static inline function getTargetInstance()
		{
			return EditorPlayState.instance;
		}
	
		public static inline function getLowestCharacterGroup():FlxSpriteGroup
		{
			var group:FlxSpriteGroup = EditorPlayState.instance.gfGroup;
			var pos:Int = EditorPlayState.instance.members.indexOf(group);
	
			var newPos:Int = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.boyfriendGroup);
			if(newPos < pos)
			{
				group = EditorPlayState.instance.boyfriendGroup;
				pos = newPos;
			}
			
			newPos = EditorPlayState.instance.members.indexOf(EditorPlayState.instance.dadGroup);
			if(newPos < pos)
			{
				group = EditorPlayState.instance.dadGroup;
				pos = newPos;
			}
			return group;
		}

	public static function luaTrace(text:String, ignoreCheck:Bool = false, deprecated:Bool = false, color:FlxColor = FlxColor.WHITE) {
		#if LUA_ALLOWED
		if(ignoreCheck || getBool('luaDebugMode')) {
			if(deprecated && !getBool('luaDeprecatedWarnings')) {
				return;
			}
			editors.content.EditorPlayState.instance.addTextToDebug(text, color);
			trace(text);
		}
		#end
	}

	function getErrorMessage(status:Int):String {
		#if LUA_ALLOWED
		var v:String = Lua.tostring(lua, -1);
		Lua.pop(lua, 1);

		if (v != null) v = v.trim();
		if (v == null || v == "") {
			switch(status) {
				case Lua.LUA_ERRRUN: return "Runtime Error";
				case Lua.LUA_ERRMEM: return "Memory Allocation Error";
				case Lua.LUA_ERRERR: return "Critical Error";
			}
			return "Unknown Error";
		}

		return v;
		#end
		return null;
	}

	public var lastCalledFunction:String = '';
	public static var lastCalledScript:EditorLua = null;
	public function call(func:String, args:Array<Dynamic>):Dynamic {
		#if LUA_ALLOWED
		if(closed) return Function_Continue;

		lastCalledFunction = func;
		lastCalledScript = this;
		try {
			if(lua == null) return Function_Continue;

			Lua.getglobal(lua, func);
			var type:Int = Lua.type(lua, -1);

			if (type != Lua.LUA_TFUNCTION) {
				if (type > Lua.LUA_TNIL)
					luaTrace("ERROR (" + func + "): attempt to call a " + typeToString(type) + " value", false, false, FlxColor.RED);

				Lua.pop(lua, 1);
				return Function_Continue;
			}

			for (arg in args) Convert.toLua(lua, arg);
			var status:Int = Lua.pcall(lua, args.length, 1, 0);

			// Checks if it's not successful, then show a error.
			if (status != Lua.LUA_OK) {
				var error:String = getErrorMessage(status);
				luaTrace("ERROR (" + func + "): " + error, false, false, FlxColor.RED);
				return Function_Continue;
			}

			// If successful, pass and then return the result.
			var result:Dynamic = cast Convert.fromLua(lua, -1);
			if (result == null) result = Function_Continue;

			Lua.pop(lua, 1);
			if(closed) stop();
			return result;
		}
		catch (e:Dynamic) {
			Application.current.window.alert('Failed to call $func in script!', 'Error on $func...');
			trace(e);
		}
		#end
		return Function_Continue;
	}

	static function addAnimByIndices(obj:String, name:String, prefix:String, indices:String, framerate:Int = 24, loop:Bool = false)
	{
		var strIndices:Array<String> = indices.trim().split(',');
		var die:Array<Int> = [];
		for (i in 0...strIndices.length) {
			die.push(Std.parseInt(strIndices[i]));
		}

		if(EditorPlayState.instance.getLuaObject(obj, false)!=null) {
			var pussy:FlxSprite = EditorPlayState.instance.getLuaObject(obj, false);
			pussy.animation.addByIndices(name, prefix, die, '', framerate, loop);
			if(pussy.animation.curAnim == null) {
				pussy.animation.play(name, true);
			}
			return true;
		}

		var pussy:FlxSprite = Reflect.getProperty(getInstance(), obj);
		if(pussy != null) {
			pussy.animation.addByIndices(name, prefix, die, '', framerate, loop);
			if(pussy.animation.curAnim == null) {
				pussy.animation.play(name, true);
			}
			return true;
		}
		return false;
	}

	public static function getPropertyLoopThingWhatever(killMe:Array<String>, ?checkForTextsToo:Bool = true, ?getProperty:Bool=true):Dynamic
	{
		var coverMeInPiss:Dynamic = getObjectDirectly(killMe[0], checkForTextsToo);
		var end = killMe.length;
		if(getProperty)end=killMe.length-1;

		for (i in 1...end) {
			coverMeInPiss = getVarInArray(coverMeInPiss, killMe[i]);
		}
		return coverMeInPiss;
	}

	public static function getObjectDirectly(objectName:String, ?checkForTextsToo:Bool = true):Dynamic
	{
		var coverMeInPiss:Dynamic = EditorPlayState.instance.getLuaObject(objectName, checkForTextsToo);
		if(coverMeInPiss==null)
			coverMeInPiss = getVarInArray(getInstance(), objectName);

		return coverMeInPiss;
	}

	function typeToString(type:Int):String {
		#if LUA_ALLOWED
		switch(type) {
			case Lua.LUA_TBOOLEAN: return "boolean";
			case Lua.LUA_TNUMBER: return "number";
			case Lua.LUA_TSTRING: return "string";
			case Lua.LUA_TTABLE: return "table";
			case Lua.LUA_TFUNCTION: return "function";
		}
		if (type <= Lua.LUA_TNIL) return "nil";
		#end
		return "unknown";
	}

	public function set(variable:String, data:Dynamic) {
		#if LUA_ALLOWED
		if(lua == null) {
			return;
		}

		Convert.toLua(lua, data);
		Lua.setglobal(lua, variable);
		#end
	}

	public function addLocalCallback(name:String, myFunction:Dynamic)
	{
		callbacks.set(name, myFunction);
		Lua_helper.add_callback(lua, name, null); //just so that it gets called
	}

	#if LUA_ALLOWED
	public static function getBool(variable:String) {
		if(lastCalledScript == null) return false;

		var lua:State = lastCalledScript.lua;
		if(lua == null) return false;
		
		var result:String = null;
		Lua.getglobal(lua, variable);
		result = Convert.fromLua(lua, -1);
		Lua.pop(lua, 1);

		if(result == null) {
			return false;
		}
		return (result == 'true');
	}
	#end

	public function stop() {
		#if LUA_ALLOWED
		EditorPlayState.instance.luaArray.remove(this);
		closed = true;
		
		lua_Cameras.clear();
		lua_Custom_Shaders.clear();
		
		if(lua == null) {
			return;
		}

		Lua.close(lua);
		lua = null;

		#if SScript
		if(ssHscript != null)
		{
			#if (SScript > "6.1.80" || SScript != "6.1.80")
			ssHscript.destroy();
			#else
			ssHscript.kill();
			#end
			ssHscript = null;
		}
		#end
		#end
	}

	public function get(var_name:String, type:Dynamic):Dynamic
	{
		var result:Any = null;

		Lua.getglobal(lua, var_name);
		result = Convert.fromLua(lua, -1);
		Lua.pop(lua, 1);

		if (result == null) return null;
		else
		{
			var result = convert(result, type);
			return result;
		}
	}

	public static function convert(v:Any, type:String):Dynamic
	{
		if (Std.isOfType(v, String) && type != null)
		{
		var v:String = v;
		if (type.substr(0, 4) == 'array')
		{
			if (type.substr(4) == 'float')
			{
				var array:Array<String> = v.split(',');
				var array2:Array<Float> = new Array();

				for (vars in array)
				{
					array2.push(Std.parseFloat(vars));
				}

				return array2;
			}
			else if (type.substr(4) == 'int')
				{
				var array:Array<String> = v.split(',');
				var array2:Array<Int> = new Array();

				for (vars in array)
				{
					array2.push(Std.parseInt(vars));
				}

				return array2;
			}
			else
			{
				var array:Array<String> = v.split(',');
				return array;
			}
		}
		else if (type == 'float')
		{
			return Std.parseFloat(v);
		}
		else if (type == 'int')
		{
			return Std.parseInt(v);
		}
		else if (type == 'bool')
		{
			if (v == 'true')
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return v;
		}
		}
		else
		{
			return v;
		}
	}

	public static inline function getInstance()
	{
		return EditorPlayState.instance;
	}

	public function getTimeFromBeat(beat:Float)
	{
		var totalTime:Float = 0;
		var curBpm = Conductor.bpm;
		if (PlayState.SONG != null)
			curBpm = PlayState.SONG.bpm;
		for (i in 0...Math.floor(beat))
		{
			if (Conductor.bpmChangeMap.length > 0)
			{
				for (j in 0...Conductor.bpmChangeMap.length)
				{
					if (totalTime >= Conductor.bpmChangeMap[j].songTime)
						curBpm = Conductor.bpmChangeMap[j].bpm;
				}
			}
			totalTime += (60/curBpm)*1000;
		}

		var leftOverBeat = beat - Math.floor(beat);
		totalTime += (60/curBpm)*1000*leftOverBeat;

		return totalTime;
	}
}

class ModchartSprite extends FlxSprite
{
	public var wasAdded:Bool = false;
	public var animOffsets:Map<String, Array<Float>> = new Map<String, Array<Float>>();
	//public var isInFront:Bool = false;

	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		antialiasing = ClientPrefs.globalAntialiasing;
	}
}

class ModchartText extends FlxText
{
	public var wasAdded:Bool = false;
	public function new(x:Float, y:Float, text:String, width:Float)
	{
		super(x, y, width, text, 16);
		setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		//cameras = [EditorPlayState.instance.camHUD];
		scrollFactor.set();
		borderSize = 2;
	}
}

class DebugLuaText extends FlxText
{
	public var disableTime:Float = 6;
	public var parentGroup:FlxTypedGroup<DebugLuaText>;
	public function new(text:String, parentGroup:FlxTypedGroup<DebugLuaText>, color:FlxColor) {
		this.parentGroup = parentGroup;
		super(10, 10, 0, text, 16);
		setFormat(Paths.font("vcr.ttf"), 20, color, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scrollFactor.set();
		borderSize = 1;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		disableTime -= elapsed;
		if(disableTime < 0) disableTime = 0;
		if(disableTime < 1) alpha = disableTime;
	}
}

class CustomSubstate extends MusicBeatSubstate
{
	public static var name:String = 'unnamed';
	public static var instance:CustomSubstate;

	override function create()
	{
		instance = this;

		EditorPlayState.instance.callOnLuas('onCustomSubstateCreate', [name]);
		super.create();
		EditorPlayState.instance.callOnLuas('onCustomSubstateCreatePost', [name]);
	}
	
	public function new(name:String)
	{
		CustomSubstate.name = name;
		super();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}
	
	override function update(elapsed:Float)
	{
		EditorPlayState.instance.callOnLuas('onCustomSubstateUpdate', [name, elapsed]);
		super.update(elapsed);
		EditorPlayState.instance.callOnLuas('onCustomSubstateUpdatePost', [name, elapsed]);
	}

	override function destroy()
	{
		EditorPlayState.instance.callOnLuas('onCustomSubstateDestroy', [name]);
		super.destroy();
	}
}

#if hscript
class HScript
{
	public static var parser:Parser = new Parser();
	public var interp:Interp;

	public var variables(get, never):Map<String, Dynamic>;

	public function get_variables()
	{
		return interp.variables;
	}

	public function new()
	{
		interp = new Interp();
		interp.variables.set('FlxG', FlxG);
		interp.variables.set('FlxSprite', FlxSprite);
		interp.variables.set('FlxCamera', FlxCamera);
		interp.variables.set('FlxTimer', FlxTimer);
		interp.variables.set('FlxTween', FlxTween);
		interp.variables.set('FlxEase', FlxEase);
		interp.variables.set('PlayState', PlayState);
		interp.variables.set('game', EditorPlayState.instance);
		interp.variables.set('Paths', Paths);
		interp.variables.set('Conductor', Conductor);
		interp.variables.set('ClientPrefs', ClientPrefs);
		interp.variables.set('Character', Character);
		interp.variables.set('Alphabet', Alphabet);
		interp.variables.set('CustomSubstate', CustomSubstate);
		#if (!flash && sys)
		interp.variables.set('FlxRuntimeShader', FlxRuntimeShader);
		#end
		interp.variables.set('ShaderFilter', openfl.filters.ShaderFilter);
		interp.variables.set('StringTools', StringTools);

		interp.variables.set('setVar', function(name:String, value:Dynamic)
		{
			EditorPlayState.instance.variables.set(name, value);
		});
		interp.variables.set('getVar', function(name:String)
		{
			var result:Dynamic = null;
			if(EditorPlayState.instance.variables.exists(name)) result = EditorPlayState.instance.variables.get(name);
			return result;
		});
		interp.variables.set('removeVar', function(name:String)
		{
			if(EditorPlayState.instance.variables.exists(name))
			{
				EditorPlayState.instance.variables.remove(name);
				return true;
			}
			return false;
		});
		interp.variables.set('pushCustomCameraToLua', function(name:String, camera:FlxCamera){
			return EditorLua.pushCustomCameras(name, camera);
		});
		interp.variables.set('startNewCustomCamera', function(name:String, newCamera:FlxCamera){
			newCamera.bgColor.alpha = 0;
			EditorLua.pushCustomCameras(name, newCamera);
			EditorPlayState.instance.variables.set(name, newCamera);
			return newCamera;
		});
	}

	public function execute(codeToRun:String):Dynamic
	{
		@:privateAccess
		HScript.parser.line = 1;
		HScript.parser.allowTypes = true;
		return interp.execute(HScript.parser.parseString(codeToRun));
	}
}
#end

class ExclusiveCopy extends FlxSkewedSprite
{
	public var noteData:Int = 0;

	public var rgbShader:RGBShaderReference;
	public static var globalRgbShaders:Array<RGBPalette> = [];

	public var colArray:Array<String> = ['purple', 'blue', 'green', 'red'];
	public var dirArray:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

	public var swagWidth:Float = 160 * 0.7;

	public var isStrum:Bool = true;
	public var usedCamera:FlxCamera = null;

	public var useRGBShader:Bool = true;

	public function new(noteData:Int, x:Float, y:Float, isStrum:Bool, usedCamera:FlxCamera, daSkin:String)
	{
		super(x, y);
		// x += (ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) + 50;
		// if (noteData > -1) x += swagWidth * (noteData);
		// y -= 2000;
		this.isStrum = isStrum;
		this.camera = usedCamera;
		this.noteData = noteData;

		rgbShader = new RGBShaderReference(this, initializeGlobalRGBShader(noteData));
		if (isStrum) rgbShader.enabled = false;
		if(PlayState.SONG != null && PlayState.SONG.disableNoteRGB && isStrum) useRGBShader = false;
		if(PlayState.SONG != null && PlayState.SONG.disableNoteRGB && !isStrum) rgbShader.enabled = false;

		defaultRGB();

		if (daSkin != '') frames = Paths.getSparrowAtlas(daSkin, 'shared');
		else frames = Paths.getSparrowAtlas('Skins/Notes/${ClientPrefs.notesSkin[0]}/NOTE_assets', 'shared');
		if (frames != null)
		{
			addNoteAnims();
			playAnims();
		}
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function addNoteAnims() { 
		if (isStrum)
			animation.addByPrefix(colArray[noteData], 'arrow' + dirArray[noteData], 24, true);
		else animation.addByPrefix(colArray[noteData] + 'Scroll', colArray[noteData] + '0', 24, true);
		setGraphicSize(Std.int(width * 0.65));
		updateHitbox();
	}
	public function playAnims() {
		// if(useRGBShader && isStrum) rgbShader.enabled = (animation.curAnim != null && animation.curAnim.name != colArray[noteData % colArray.length]);
		if (isStrum)
			animation.play(colArray[noteData % colArray.length], true);
		else animation.play(colArray[noteData % colArray.length] + 'Scroll', true);
	}

	public function defaultRGB() 
	{
		var arr:Array<FlxColor> = ClientPrefs.arrowRGB[noteData];

		if (noteData > -1 && noteData <= arr.length)
		{
			rgbShader.r = arr[0];
			rgbShader.g = arr[1];
			rgbShader.b = arr[2];
		}	
	}

	public static function initializeGlobalRGBShader(noteData:Int)
	{
		if(globalRgbShaders[noteData] == null)
		{
			var newRGB:RGBPalette = new RGBPalette();
			globalRgbShaders[noteData] = newRGB;

			var arr:Array<FlxColor> = ClientPrefs.arrowRGB[noteData];
			if (noteData > -1 && noteData <= arr.length)
			{
				newRGB.r = arr[0];
				newRGB.g = arr[1];
				newRGB.b = arr[2];
			}
		}
		return globalRgbShaders[noteData];
	}
}
