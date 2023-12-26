package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

//crash handler stuff
#if CRASH_HANDLER
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import Discord.DiscordClient;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

using StringTools;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = WindowsState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	public static var fpsVar:FPS;

	public static var focused:Bool = true; //pause stuff

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	var oldVol:Float = 1.0;
	var newVol:Float = 0.2;

	public static var focusMusicTween:FlxTween;

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		CrashHandler.initCrashHandler();
	
		addChild(new CrashHandler.MainGame(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end

		ClientPrefs.loadPrefs();

		#if ACHIEVEMENTS_ALLOWED Achievements.load(); 
		ClientPrefs.alreadyLoadedAchievements = true; #end

		
		FlxGraphic.defaultPersist = false;
	        FlxG.signals.preStateSwitch.add(function()
	        {

	            //i tihnk i finally fixed it

	            @:privateAccess
	            for (key in FlxG.bitmap._cache.keys())
	            {
	                var obj = FlxG.bitmap._cache.get(key);
	                if (obj != null)
	                {
	                    lime.utils.Assets.cache.image.remove(key);
	                    openfl.Assets.cache.removeBitmapData(key);
	                    FlxG.bitmap._cache.remove(key);
	                    //obj.destroy(); //breaks the game lol
	                }
	            }

	            //idk if this helps because it looks like just clearing it does the same thing
	            for (k => f in lime.utils.Assets.cache.font)
	                lime.utils.Assets.cache.font.remove(k);
	            for (k => s in lime.utils.Assets.cache.audio)
	                lime.utils.Assets.cache.audio.remove(k);

	            lime.utils.Assets.cache.clear();

	            openfl.Assets.cache.clear();

	            FlxG.bitmap.dumpCache();

	            #if polymod
	            polymod.Polymod.clearCache();

	            #end

	            #if cpp
	            cpp.vm.Gc.enable(true);
	            #end

	            #if sys
	            openfl.system.System.gc();
	            #end
	        });

	        FlxG.signals.postStateSwitch.add(function()
	        {
	            #if cpp
	            cpp.vm.Gc.enable(true);
	            #end

	            #if sys
	            openfl.system.System.gc();
	            #end
	        });
			// shader coords fix
        	FlxG.signals.gameResized.add(fixCameraShaders);

		#if CRASH_HANDLER
		//Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		lime.app.Application.current.window.onFocusIn.add(onWindowFocusIn);
		lime.app.Application.current.window.onFocusOut.add(onWindowFocusOut);
	}

	public static function fixCameraShaders(w:Int, h:Int) //fixes shaders after resizing the window / fullscreening
	{
		if (FlxG.cameras.list.length > 0)
	        {
	            for (cam in FlxG.cameras.list)
	            {
	                if (cam.flashSprite != null)
	                {
	                    @:privateAccess 
	                    {
	                        cam.flashSprite.__cacheBitmap = null;
	                        cam.flashSprite.__cacheBitmapData = null;
	                        cam.flashSprite.__cacheBitmapData2 = null;
	                        cam.flashSprite.__cacheBitmapData3 = null;
	                        cam.flashSprite.__cacheBitmapColorTransform = null;
	                    }
	                }
	            }
	        }
	}

	function onWindowFocusOut(){
		focused = false;

		if (Type.getClass(FlxG.state) != PlayState)
		{
			oldVol = FlxG.sound.volume;
			if (oldVol > 0.3)
			{
				newVol = 0.3;
			}
			else
			{
				if (oldVol > 0.1)
				{
					newVol = 0.1;
				}
				else
				{
					newVol = 0;
				}
			}

			if (focusMusicTween != null)
				focusMusicTween.cancel();
			focusMusicTween = FlxTween.tween(FlxG.sound, {volume: newVol}, 2);
		}
	}

	function onWindowFocusIn(){
		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			focused = true;
		});

		if (Type.getClass(FlxG.state) != PlayState)
		{
			// Normal global volume when focused
			if (focusMusicTween != null)
				focusMusicTween.cancel();

			focusMusicTween = FlxTween.tween(FlxG.sound, {volume: oldVol}, 2);
		}
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	// static final quotes:Array<String> = [
    //     "Ha, a null object reference?", // Slushi
	// 	"What the fuck you did!?", //Edwhak
	// 	"It was Bolo!" //Glowsoony
    // ];

	// function onCrash(e:UncaughtErrorEvent):Void
	// {
	// 	var build = Sys.systemName();
	// 	var errMsg:String = "";
	// 	var path:String;
	// 	var callStack:Array<StackItem> = CallStack.exceptionStack(true);
	// 	var dateNow:String = Date.now().toString();

	// 	dateNow = dateNow.replace(" ", "_");
	// 	dateNow = dateNow.replace(":", "'");

	// 	path = "./crash/" + "PsychEngine_" + dateNow + ".txt";

	// 	for (stackItem in callStack)
	// 	{
	// 		switch (stackItem)
	// 		{
	// 			case FilePos(s, file, line, column):
	// 				errMsg += file + " (line " + line + ")\n";
	// 			default:
	// 				Sys.println(stackItem);
	// 		}
	// 	}

	// 	errMsg += 
    //         "\n---------------------"
    //         + "\n" + quotes[Std.random(quotes.length)]
    //         + "\n---------------------"
    //         + "\n\nThis build is running in " + build + "\n(Hitmans AD V" + MainMenuState.psychEngineVersion +")" 
    //          + "\nPlease report this error to Github page: https://github.com/EdwhakKB/HITMANS_A.D_PROJECT-FNF-Psych-Engine"     
    //         + "\n\n"
    //         + "Uncaught Error:\n"
    //         + e.error;

	// 	if (!FileSystem.exists("./crash/"))
	// 		FileSystem.createDirectory("./crash/");

	// 	File.saveContent(path, errMsg + "\n");

	// 	Sys.println(errMsg);
	// 	Sys.println("Crash dump saved in " + Path.normalize(path));

	// 	var crashDialoguePath:String = "Hitmans-CrashDialog";

    //     #if windows
    //     crashDialoguePath += ".exe";
    //     #end

    //     if (FileSystem.exists(crashDialoguePath))
    //     {
    //         Sys.println("Found crash dialog: " + crashDialoguePath);
    //         new Process(crashDialoguePath, ["._. ", path]);
    //     }
    //     else
    //     {
    //         Sys.println("No crash dialog found! Making a simple alert instead...");
    //         Application.current.window.alert(errMsg, "Error!");
    //     }

    //     DiscordClient.shutdown();
	// 	Sys.exit(1);
	// }
	#end
}

