package crashHandler;


import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;

import flixel.ui.FlxButton;
import flixel.tweens.misc.NumTween;
import flixel.system.scaleModes.*;

import flixel.group.FlxGroup;
import Sys;

import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;

import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import Discord.DiscordClient;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

using StringTools;

class CrashHandler 
{

    static var gitHubLink:String = "...";

	public static function symbolPrevent(error:Dynamic)
		{
			onUncaughtError(error);
		}

	public static var noReturnToThisState:Bool = false;
	static var engineEXEName:String = "Hitmans.exe";

	static final quotes:Array<String> = 
	[
		"Ha, a null object reference?", // Slushi
        "What the fuck you did!?", //Edwhak
		"CAGASTE.", // Slushi
		"It was Bolo!", //Glowsoony
		"El pollo ardiente", // Edwhak
	];

	static function onUncaughtError(e:Dynamic):Void
	{	
		var randomsMsg:String = "";
		var errMsg:String = "";
		var callstackText:String = "Call Stack:\n";
		var build = Sys.systemName();
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();
		var build = lime.system.System.platformLabel;

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "HitmansEngineCrash_" + dateNow + ".txt";

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
			+ "\n\nThis build is running in " + build + "\n(Hitmans v" + MainMenuState.psychEngineVersion + ")" 
			+ "\nPlease report this error to Github page: ..."	 
			+ "\n\n"
			+ "Uncaught Error:\n"
			+ e;

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, callstackText + "\n");

		Sys.println( "CRASH:\n\n" + callstackText);

		crashHandlerTerminal(callstackText);
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////

	static var args:Array<String> = Sys.args();
    static var canContinue:Bool = false;
	static var camCrashHandler:FlxCamera;

	static var time:Float = 0.0;


	@:noStack public static var assetGrp:FlxGroup;


    public static function crashHandlerTerminal(text:String = "") {
        lime.app.Application.current.window.title = "Hitmans Corporation Crash Handler Mode";
        Main.fpsVar.visible = false;
		FlxG.mouse.useSystemCursor = false;
		FlxG.mouse.visible = false;
        lime.app.Application.current.window.resizable = false;
		//noReturnToThisState = true;

		camCrashHandler = new FlxCamera();
        camCrashHandler.bgColor.alpha = 0;
        FlxG.cameras.add(camCrashHandler, false);

        assetGrp = new FlxGroup();
		FlxG.state.add(assetGrp);

		assetGrp.camera = camCrashHandler;

		trace("Starting Crash Handler");

		var contents:String = text;
		//trace("\n[--newCrashHandler arg in use] TXT CONTENT:\n" + contents);

		var split:Array<String> = contents.split("\n");

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.scrollFactor.set();
        assetGrp.add(bg);
		bg.alpha = 0.7;

		var watermark = new FlxText(10, 0, 0, "Hitmans Engine Crash Handler [v1.3] by Slushi ");
		watermark.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		watermark.scrollFactor.set();
		watermark.borderSize = 1.25;
		watermark.antialiasing = true;
		assetGrp.add(watermark);

		var text0 = new FlxText(10, watermark.y + 20, 0, "Hitmans Engine [" + MainMenuState.psychEngineVersion + "]");
        text0.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text0.scrollFactor.set();
        text0.borderSize = 1.25;
        assetGrp.add(text0);
		text0.visible = false;

		var text1 = new FlxText(10, text0.y + 30, 0, "SYSTEM CRASH.\nCrash log:");
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
		assetGrp.add(crashtext);

		var text2 = new FlxText(10, crashtext.height + 70, 0, "");
        text2.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text2.scrollFactor.set();
        text2.borderSize = 1.25;
		#if windows
		text2.text = "\n\nH\\FNF> REBOOTING SYSTEM...";
		#else
		text2.text = "\n\nH/FNF> REBOOTING SYSTEM...";
		#end
        assetGrp.add(text2);
		text2.visible = false;

		new FlxTimer().start(2, function(tmr:FlxTimer)
                {
					text0.visible = true;
					FlxG.sound.play(Paths.sound('Edwhak/beep'));
                });

            new FlxTimer().start(3, function(tmr:FlxTimer)
                {
					text1.visible = true;
					FlxG.sound.play(Paths.sound('Edwhak/beep2'));
                });

			new FlxTimer().start(5, function(tmr:FlxTimer)
                {
					crashtext.visible = true;
					text2.visible = true;
                    canContinue = true;
					new FlxTimer().start(5, function(tmr:FlxTimer)
						{
							FlxG.resetGame();
						});	
                });	
			}
}