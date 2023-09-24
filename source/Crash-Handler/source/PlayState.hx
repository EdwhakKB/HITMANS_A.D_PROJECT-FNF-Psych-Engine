package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.FlxG;
import sys.io.File;
import sys.io.Process;
import sys.FileSystem;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var FNFExe:String = "Hitmans.exe";

	var timer1:FlxTimer;
    var timer2:FlxTimer;
	var timer3:FlxTimer;
    var timer4:FlxTimer;
	var timer5:FlxTimer;
	var timer6:FlxTimer;
	var timer7:FlxTimer;
	var timer8:FlxTimer;
	var timer9:FlxTimer;

	var resetGameButton:FlxButton;
	var viewGitHub:FlxButton;
	var closeCrashHandler:FlxButton;

	override public function create()
	{
		FlxG.mouse.useSystemCursor = true;
		FlxG.autoPause = false;
		try{
			crashHandler();
		} catch(e:Dynamic){
			lime.app.Application.current.window.alert("Error:\n" + e, "Crash Hanlder got an error..?");
			Sys.exit(1);
		}


		super.create();
	}


	public function crashHandler() {
		var args:Array<String> = Sys.args();
		if (args.length < 2) {
			lime.app.Application.current.window.alert("Se debe proporcionar la ruta del archivo como argumento.", "ERROR! in this crash handler..?");
			trace("Se debe proporcionar la ruta del archivo como argumento.");
			Sys.exit(1);
			return;
		}
	
		var path:String = args[1]; // El argumento en la posición 1 es la ruta del archivo.
		if (!FileSystem.exists(path)) {
			lime.app.Application.current.window.alert("El archivo no existe en la ruta especificada: " + path, "ERROR! in this crash handler..?");
			trace("El archivo no existe en la ruta especificada: " + path);
			Sys.exit(1);
			return;
		}
	
		var maxLength = 50; // Longitud máxima deseada

		var contents:String = File.getContent(path);
		trace("\nTXT CONTENT:\n" + contents);

		var split:Array<String> = contents.split("\n");


		var bg:FlxSprite;
		bg = new FlxSprite().loadGraphic("assets/images/Art/CrashHandlerBG.png");
		bg.screenCenter();
		bg.antialiasing = true;
		bg.alpha = 1;
		add(bg);

		var watermark = new FlxText(3, 2, 0, "Crash Handler [v1.0] by Slushi");
		watermark.setFormat("assets/fonts/vcr.ttf", 11, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		watermark.scrollFactor.set();
		watermark.borderSize = 1.25;
		watermark.antialiasing = true;
		watermark.alpha = 1;
		add(watermark);

		var logo:FlxSprite;
		logo = new FlxSprite(0, -225).loadGraphic("assets/images/Art/CrashHandlerLogo.png");
		logo.screenCenter(X);
		logo.visible = true;
		logo.antialiasing = true;
		add(logo);
	
		var text = new FlxText(10, 185, Std.int(FlxG.width * 0.9), "");
		text.setFormat("assets/fonts/vcr.ttf", 15, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.scrollFactor.set();
		text.borderSize = 1.25;
		text.visible = true;
		text.antialiasing = true;
		for (i in 0...split.length - 1)
			{
				if (i == split.length - 15)
					text.text += split[i];
				else
					text.text += split[i] + "\n";
			}
		add(text);
		text.alpha = 0;

		timer2 = new FlxTimer(); 
        timer2.start(0.3, function(tmr:FlxTimer)
            {
                FlxTween.tween(text, {alpha: 1}, 0.7, {ease: FlxEase.quadInOut});
                FlxTween.tween(text, {y: text.y - 30}, 0.7, {ease: FlxEase.quadInOut});
            });

		var crashReason = new FlxText(text.x, text.y+415, 435, "");
		crashReason.setFormat("assets/fonts/vcr.ttf", 13, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		crashReason.scrollFactor.set();
		crashReason.borderSize = 1.25;
		crashReason.antialiasing = true;

		// Concatenar el contenido dividido en crashReason hasta que alcance la parte inferior de la pantalla
		for (i in split.length - 1...split.length - 0) {
			if (i == split.length - 9) {
				crashReason.text += split[i];
			} else {
				crashReason.text += split[i] + "\n";
			}
		}
		add(crashReason);
		crashReason.alpha = 0;

		timer3 = new FlxTimer(); 
        timer3.start(0.3, function(tmr:FlxTimer)
            {
                FlxTween.tween(crashReason, {alpha: 1}, 0.7, {ease: FlxEase.quadInOut});
                FlxTween.tween(crashReason, {y: crashReason.y - 30}, 0.7, {ease: FlxEase.quadInOut});
            });

		resetGameButton = new FlxButton(70, 640, "Restart Game", function() {

			timer9 = new FlxTimer(); 
			timer9.start(0.1, function(tmr:FlxTimer)
            {
                FlxTween.tween(viewGitHub, {y: viewGitHub.y + 30}, 0.2, {ease: FlxEase.quadInOut});
				FlxTween.tween(closeCrashHandler, {y: closeCrashHandler.y + 30}, 0.2, {ease: FlxEase.quadInOut});
            });

			new Process(FNFExe, []);
			Sys.exit(0);
		});
		add(resetGameButton);

		timer4 = new FlxTimer(); 
		timer4.start(0.5, function(tmr:FlxTimer)
            {
                FlxTween.tween(resetGameButton, {y: resetGameButton.y - 30}, 0.7, {ease: FlxEase.quadInOut});
            });

			viewGitHub = new FlxButton(resetGameButton.x + 100, resetGameButton.y, "GitHub", function() {
			FlxG.openURL("https://github.com/EdwhakKB/HITMANS_A.D_PROJECT-FNF-Psych-Engine");
		});
		add(viewGitHub);

		timer5 = new FlxTimer(); 
		timer5.start(0.8, function(tmr:FlxTimer)
            {
                FlxTween.tween(viewGitHub, {y: viewGitHub.y - 30}, 0.7, {ease: FlxEase.quadInOut});
            });

		closeCrashHandler = new FlxButton(resetGameButton.x + 205, resetGameButton.y, "Close", function() {
			
			timer8 = new FlxTimer(); 
			timer8.start(0.1, function(tmr:FlxTimer)
            {
                FlxTween.tween(viewGitHub, {y: viewGitHub.y + 30}, 0.2, {ease: FlxEase.quadInOut});
				FlxTween.tween(resetGameButton, {y: resetGameButton.y + 30}, 0.2, {ease: FlxEase.quadInOut});
            });

			#if windows
			CppAPI._setWindowLayered();
					var numTween:NumTween = FlxTween.num(1, 0, 0.7, {
						onComplete: function(twn:FlxTween)
						{
							Sys.exit(0);
						}
					});		

					numTween.onUpdate = function(twn:FlxTween)
						{
							CppAPI.setWindowOppacity(numTween.value);
						}
			#else
			Sys.exit(0);
			#end
		});
		add(closeCrashHandler);

		timer6 = new FlxTimer(); 
		timer6.start(0.8, function(tmr:FlxTimer)
            {
                FlxTween.tween(closeCrashHandler, {y: closeCrashHandler.y - 30}, 0.9, {ease: FlxEase.quadInOut});
            });
	}
}
