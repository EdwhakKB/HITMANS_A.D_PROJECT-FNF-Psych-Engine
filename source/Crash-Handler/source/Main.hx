package;

import flixel.FlxGame;
import openfl.display.Sprite;

#if windows
import CppAPI;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.NumTween;
#end

class Main extends Sprite
{
	public function new()
	{
		setupEventListeners();
		lime.app.Application.current.window.setIcon(lime.utils.Assets.getImage('assets/art/iconOG.png'));
		super();
		addChild(new FlxGame(0, 0, PlayState, 60, 60, true, false));
	}

	static function setupEventListeners() 
		{
			lime.app.Application.current.window.onClose.add(mainWindowClosed);
		}

		static function mainWindowClosed() 
			{
				#if windows
					// The window will never close, therefore the app keeps running
					lime.app.Application.current.window.onClose.cancel();
	
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
		}
}
