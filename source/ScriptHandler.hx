package;

#if HSCRIPT_ALLOWED
import flixel.*;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.effects.FlxTrail;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.*;
import flixel.system.*;
import flixel.system.scaleModes.StageSizeScaleMode;
import flixel.text.FlxText;
import flixel.tweens.*;
import flixel.ui.FlxBar;
import flixel.util.*;
import lime.app.Application;
import openfl.display.GraphicsShader;
import openfl.filters.ShaderFilter;
import flixel.*;
import states.*;
import shaders.*;
import flixel.util.FlxAxes;

using StringTools;
#end

/**
 * alot of scripts
 * based on Ghost's Forever Underscore
 * @see https://github.com/BeastlyGhost/Forever-Engine-Underscore/blob/master/source/base/ScriptHandler.hx
 * and on Lore engine FuckinHX/Yoshi engine's HxScript support 
 * @see https://github.com/sayofthelor/lore-engine/blob/main/source/lore/FunkinHX.hx
 */
class ScriptHandler #if SScript extends tea.SScript #end
{
	var ignoreErrors:Bool = false;
	var hxFileName:String = '';
	public var disabled:Bool = false;

	public function new(file:String, ?preset:Bool = true)
	{
        #if SScript
		if (file == null){
			disabled = true;
			return;
		}
		hxFileName = file;
		trace('Running script: ' + hxFileName);
		trace('haxe file loaded succesfully:' + hxFileName);
		super(file, preset);
        #end
	}

    #if SScript
	override public function preset():Void
	{
		super.preset();

		// here we set up the built-in imports
		// these should work on *any* script;

		/*trace('Running script: ' + hxFileName);
		trace('haxe file loaded succesfully:' + hxFileName);*/

		// CLASSES (HAXE)
		set('Type', Type);
		set('Math', Math);
		set('Std', Std);
		set('Date', Date);

		// CLASSES (FLIXEL);
		set('FlxG', FlxG);
		set('FlxBasic', FlxBasic);
		set('FlxObject', FlxObject);
		set('FlxCamera', FlxCamera);
		set('FlxSprite', FlxSprite);
        set('FlxColor', CustomFlxColor);
		set('FlxText', FlxText);
		set('FlxTextBorderStyle', FlxTextBorderStyle);
		#if (!flash && sys)
		set('FlxRuntimeShader', flixel.addons.display.FlxRuntimeShader);
		#end
		set('FlxSound', FlxSound);
		set('FlxState', flixel.FlxState);
		set('FlxSubState', flixel.FlxSubState);
		set('FlxTimer', FlxTimer);
		set('FlxTween', FlxTween);
		set('FlxEase', FlxEase);
		set('FlxMath', FlxMath);
		set('FlxGroup', FlxGroup);
		set('FlxTypedGroup', FlxTypedGroup);
		set('FlxSpriteGroup', FlxSpriteGroup);
		set('FlxTypedSpriteGroup', FlxTypedSpriteGroup);
		set('FlxStringUtil', FlxStringUtil);
		set('FlxAtlasFrames', FlxAtlasFrames);
		set('FlxSort', FlxSort);
		set('Application', Application);
		set('FlxGraphic', FlxGraphic);
		set('File', sys.io.File);
		set('FlxTrail', FlxTrail);
		set('FlxShader', FlxFixedShader);
		set('FlxBar', FlxBar);
		set('FlxBackdrop', FlxBackdrop);
		set('StageSizeScaleMode', StageSizeScaleMode);
		set('FlxBarFillDirection', FlxBarFillDirection);
		#if (flixel < "5.0.0")
		set('FlxAxes', FlxAxes);
		set('FlxPoint', FlxPoint);
		#end
		set('GraphicsShader', GraphicsShader);
		set('ShaderFilter', ShaderFilter);

		set('InputFormatter', InputFormatter);

		// CLASSES (BASE);
		set('BGSprite', BGSprite);
		set('HealthIcon', HealthIcon);
		set('MusicBeatState', MusicBeatState);
		set('MusicBeatSubstate', MusicBeatSubstate);
		set('AttachedText', AttachedText);
		set('Discord', Discord.DiscordClient);
		set('Alphabet', Alphabet);
		set('Character', Character);
		set('Controls', Controls);
		set('CoolUtil', CoolUtil);
        set('CustomFlxColor', CustomFlxColor);
		set('Conductor', Conductor);
		set('PlayState', PlayState);
		set('game', PlayState.instance);
		set('Main', Main);
		set('Note', Note);
		set('StrumNote', StrumNote);
		set('Paths', Paths);
		#if LUA_ALLOWED
		set('FunkinLua', FunkinLua);
		#end
		set('Achievements', Achievements);
		set('ClientPrefs', ClientPrefs);
		set('ColorSwap', shaders.ColorSwap);
        set('screenCenter', function(spr:Dynamic, center:String=''){
            switch (center.toLowerCase())
            {
                case 'x':
                    spr.x = (FlxG.width - spr.width) / 2;
                case 'y':
                    spr.y = (FlxG.height - spr.height) / 2;
                default:
                    spr.x = (FlxG.width - spr.width) / 2;
                    spr.y = (FlxG.height - spr.height) / 2;
            }
        });

		set('setVarFromClass', function(instance:String, variable:String, value:Dynamic)
		{
			Reflect.setProperty(Type.resolveClass(instance), variable, value);
		});

		set('getVarFromClass', function(instance:String, variable:String)
		{
			Reflect.getProperty(Type.resolveClass(instance), variable);
		});

		FlxG.signals.focusGained.add(function()
		{
			call("focusGained", []);
		});
		FlxG.signals.focusLost.add(function()
		{
			call("focusLost", []);
		});
		FlxG.signals.gameResized.add(function(w:Int, h:Int)
		{
			call("gameResized", [w, h]);
		});
		FlxG.signals.postDraw.add(function()
		{
			call("postDraw", []);
		});
		FlxG.signals.postGameReset.add(function()
		{
			call("postGameReset", []);
		});
		FlxG.signals.postGameStart.add(function()
		{
			call("postGameStart", []);
		});
		FlxG.signals.postStateSwitch.add(function()
		{
			call("postStateSwitch", []);
		});

		//set('buildTarget', getBuildTarget());

		set('sys', #if sys true #else false #end);

        callFunc('create', []);
	}
    #end

	public function callFunc(key:String, args:Array<Dynamic>)
	{
		#if SScript
		if (this == null || interp == null)
			return null;
		else
			return call(key, args);
		#else
		return null;
		#end
	}

	public function setVar(key:String, value:Dynamic)
	{
		#if SScript
		if (this == null || interp == null)
			return null;
		else
			return set(key, value);
		#else
		return null;
		#end
	}

	public function varExists(key:String):Bool
	{
        #if SScript
		if (this != null && interp != null)
			return exists(key);
        #end
		return false;
	}

	public function getVar(key:String):Dynamic
	{
        #if SScript
		if (this != null && interp != null)
			return get(key);
        #end
		return null;
	}

	// override public function destroy()
	// {
	// 	scriptFile = null;
	// 	interp = null;

	// 	super.destroy();
	// }
}
