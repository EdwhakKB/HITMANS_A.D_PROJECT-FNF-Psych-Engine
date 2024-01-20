package;

import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;


import sys.FileSystem;
import sys.io.File;

import flixel.ui.FlxButton;
import flixel.tweens.misc.NumTween;
import flixel.system.scaleModes.*;

import flixel.group.FlxGroup;
import Sys;

import flixel.FlxCamera;

import flixel.FlxGame;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import openfl.Lib;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

using StringTools;

/*
 * Crash Handler in game by Edwhak_KillBot, Niz, and Slushi
 */

class CrashHandler 
{
	public static function symbolPrevent(error:Dynamic)
		{
			onUncaughtError(error);
		}

	public static function initCrashHandler() {
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
	}

	static final quotes:Array<String> = 
	[
		"Ha, a null object reference?", // Slushi
        "What the fuck you did!?", //Edwhak
		"CAGASTE.", // Slushi
		"It was Bolo!", //Glowsoony
		"El pollo ardiente", // Edwhak -- wtf edwhak
		"FUE GLOW", // Edwhak
		"Player pressed enter, it crashed the game", //Edwhak
		"AHORA QUE CHUCHA HIZO GLOW!?", // Edwhak
	];

	static function onUncaughtError(e:Dynamic):Void
	{	
		var randomsMsg:String = "";
		var errMsg:String = "";
		var callstackText:String = "SafeCall:\n";
		var build = Sys.systemName();
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();
		var build = lime.system.System.platformLabel;

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "TAOSCrash_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
				callstackText += errMsg + file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		callstackText += 
			"\n---------------------"
			+ "\n" + quotes[Std.random(quotes.length)]
			+ "\n---------------------"
			+ "\n\nThis build is running in " + build + "\n(TAOS v" + MainMenuState.psychEngineVersion + ")" 
			+ "\nPlease report this error to the TAOS enginer contact: @edwhak_killbot"	 
			+ "\n\n"
			+ "Uncaught Error:\n"
			+ e;

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, callstackText + "\n");

		Sys.println( "CRASH:\n\n" + callstackText);

		crashHandlerTerminal(callstackText);

		#if SPECIAL_EFFECTS_CPP
		slushi.windows.WindowsFuncs.resetAllCPPFunctions();
		#end
		//Sys.exit(1);
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////

	static var args:Array<String> = Sys.args();
    static var canContinue:Bool = false;
	static var camCrashHandler:FlxCamera;

	public static var noReOpenTheCrashHandler:Bool = false;

	@:noStack public static var assetGrp:FlxGroup;
	@:noStack public static var assetGrpCrash:FlxGroup;

    public static function crashHandlerTerminal(text:String = "") {
		if (!noReOpenTheCrashHandler) {
			noReOpenTheCrashHandler = true; // DEJA DE ABRIR ESTO OTRA VEZ MALDITO FlxGame NO JODAAAAAA -- Slushi
			lime.app.Application.current.window.title = "Hitmans Corporation: Panic Command Prompt";
			Main.fpsVar.visible = false;
			FlxG.mouse.useSystemCursor = false;
			FlxG.mouse.visible = false;
			
			if (FlxG.sound.music!=null)
				FlxG.sound.music.stop();
			
			lime.app.Application.current.window.resizable = false;

			camCrashHandler = new FlxCamera();
			camCrashHandler.bgColor.alpha = 0;
			FlxG.cameras.add(camCrashHandler, false);

			assetGrp = new FlxGroup();
			FlxG.state.add(assetGrp);

			assetGrpCrash = new FlxGroup();
			FlxG.state.add(assetGrpCrash);

			assetGrp.camera = camCrashHandler;
			assetGrpCrash.camera = camCrashHandler;

			trace("Starting Crash Handler");

			var contents:String = text;

			var split:Array<String> = contents.split("\n");

			var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			bg.scrollFactor.set();
			assetGrp.add(bg);
			bg.alpha = 1;

			var watermark = new FlxText(10, 0, 0, "Hitmans Corporation [TAOS v" + MainMenuState.psychEngineVersion + "]");
			watermark.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			watermark.scrollFactor.set();
			watermark.borderSize = 1.25;
			watermark.antialiasing = true;
			assetGrp.add(watermark);

			var text0 = new FlxText(10, watermark.y + 20, 0, "System Symbol has crashed [Slushi's C.H. v1.3.8]");
			text0.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text0.scrollFactor.set();
			text0.borderSize = 1.25;
			assetGrp.add(text0);
			text0.visible = false;

			var text1 = new FlxText(10, text0.y + 30, 0, "Debug information.\nread carefully:");
			text1.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text1.scrollFactor.set();
			text1.color = FlxColor.RED;
			text1.borderSize = 1.25;
			assetGrp.add(text1);
			text1.visible = false;

			var crashtext = new FlxText(10, text1.y + 37, 0, '');
			crashtext.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			crashtext.scrollFactor.set();
			crashtext.borderSize = 1.25;
			crashtext.antialiasing = true;
			crashtext.visible = false;
			for (i in 0...split.length - 0)
			{
				if (i == split.length - 18)
					crashtext.text += split[i];
				else
					crashtext.text += split[i] + "\n";
			}
			assetGrpCrash.add(crashtext);

			var text2 = new FlxText(10, crashtext.height + 70, 0, "");
			text2.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text2.scrollFactor.set();
			text2.borderSize = 1.25;
			#if windows
			text2.text = "\n\nH\\TAOS> REBOOTING SYSTEM.";
			#else
			text2.text = "\n\nH/TAOS> REBOOTING SYSTEM.";
			#end
			// text2.color = FlxColor.RED;
			assetGrp.add(text2);
			text2.visible = false;

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				text0.visible = true;
				FlxG.sound.play(Paths.sound('Edwhak/beep'));
			});

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				text1.visible = true;
				FlxG.sound.play(Paths.sound('Edwhak/beep2'));
			});

			new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				crashtext.visible = true;
				FlxG.sound.play(Paths.sound('Edwhak/beep2'));
			});

			new FlxTimer().start(4, function(tmr:FlxTimer)
			{
				text2.visible = true;

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					text2.text += ".";
					FlxG.sound.play(Paths.sound('Edwhak/beep'));
				});

				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					text2.text += ".";
					FlxG.sound.play(Paths.sound('Edwhak/beep'));
				});

				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					text2.text += "\nRecovering system...";
					FlxG.sound.play(Paths.sound('Edwhak/beep'));
				});

				new FlxTimer().start(4, function(tmr:FlxTimer)
				{
					text2.text += "\nDesktop...";
				});

				new FlxTimer().start(5, function(tmr:FlxTimer)
				{
					text2.text += "[DONE]";
					FlxG.sound.play(Paths.sound('Edwhak/beep'));
				});

				new FlxTimer().start(6, function(tmr:FlxTimer)
				{
					text2.text += "\nClientPrefix...";
				});

				new FlxTimer().start(7, function(tmr:FlxTimer)
				{
					text2.text += "[DONE]";
					FlxG.sound.play(Paths.sound('Edwhak/beep'));
				});

				new FlxTimer().start(8, function(tmr:FlxTimer)
				{
					text2.text += "\n"+Type.getClass(MainGame.oldState)+"...";
				});

				new FlxTimer().start(9, function(tmr:FlxTimer)
				{
					text2.text += "[DONE]";
					FlxG.sound.play(Paths.sound('Edwhak/beep'));
				});

				new FlxTimer().start(10, function(tmr:FlxTimer)
				{
					text2.text += "\nPlease Wait...";
				});
				new FlxTimer().start(12, function(tmr:FlxTimer)
				{
					Main.fpsVar.visible = ClientPrefs.showFPS;
					lime.app.Application.current.window.resizable = true;
					lime.app.Application.current.window.title = lime.app.Application.current.meta.get('name');
					if(Type.getClass(FlxG.state) == PlayState)
					{
						if(!PlayState.isStoryMode)
						{
							MainGame.alredyOpen = false;
							Main.fpsVar.visible = ClientPrefs.showFPS;
							lime.app.Application.current.window.resizable = true;
							lime.app.Application.current.window.title = lime.app.Application.current.meta.get('name');
							FlxG.switchState(new FreeplayState());
						}
						else
						{
							MainGame.alredyOpen = false;
							Main.fpsVar.visible = ClientPrefs.showFPS;
							lime.app.Application.current.window.resizable = true;
							lime.app.Application.current.window.title = lime.app.Application.current.meta.get('name');
							FlxG.switchState(new StoryMenuState());
						}
					}
					else
					{
						MainGame.alredyOpen = false;
						Main.fpsVar.visible = ClientPrefs.showFPS;
						lime.app.Application.current.window.resizable = true;
						lime.app.Application.current.window.title = lime.app.Application.current.meta.get('name');
						FlxG.switchState(Type.createInstance(Type.getClass(MainGame.oldState), []));
					}
				});	
			});
		}
	}
}

class MainGame extends FlxGame
{
	public static var oldState:FlxState;
    public static var alredyOpen:Bool = false;

	override public function switchState():Void
	{
		try
		{
			oldState = _state;
			super.switchState();
			alredyOpen = false;
			CrashHandler.noReOpenTheCrashHandler = false;
		}
		catch (error)
		{
            if(!alredyOpen)
                {
                    CrashHandler.symbolPrevent(error);
                    alredyOpen = true;
                }
		}
	}

	override public function update()
	{
		try
        {
            super.update();
        }
		catch(error)
        {
            if(!alredyOpen)
            {
                CrashHandler.symbolPrevent(error);
                alredyOpen = true;
            }
        }
	}
}