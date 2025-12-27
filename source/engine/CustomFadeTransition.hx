package engine;

import engine.Conductor.BPMChangeEvent;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxGradient;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	private var leTween:FlxTween = null;
	var isTransIn:Bool = false;
	var transBlack:FlxSprite;
	var staticTrans:FlxSprite;

	public function new(duration:Float, isTransIn:Bool, ?usesBlack:Bool = false) {
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		super();

		// trace(usesBlack);
		this.isTransIn = isTransIn;
		var width:Int = Std.int(FlxG.width / Math.max(camera.zoom, 0.001));
		var height:Int = Std.int(FlxG.height / Math.max(camera.zoom, 0.001));

		transBlack = new FlxSprite().makeGraphic(width, height + 400, FlxColor.BLACK);
		transBlack.scrollFactor.set();
		transBlack.alpha = isTransIn ? 1 : 0;
		transBlack.visible = usesBlack;
		add(transBlack);

		staticTrans = new FlxSprite();
		staticTrans.frames = Paths.getSparrowAtlas('menuPause');
        staticTrans.animation.addByPrefix('glitch', 'glitch', 48, true);	
        staticTrans.antialiasing = ClientPrefs.data.antialiasing;
		staticTrans.setGraphicSize(Std.int(FlxG.width),Std.int(FlxG.height));
        staticTrans.screenCenter();
		staticTrans.scrollFactor.set();
        staticTrans.alpha = usesBlack ? 0 : 1;
        staticTrans.animation.play("glitch");
        add(staticTrans);

		if(isTransIn) {
			switch (usesBlack) {
				case false:
					FlxTween.tween(staticTrans, {alpha: 0}, 0.6, {ease: FlxEase.smoothStepIn});
				case true:
					FlxTween.tween(transBlack, {alpha: 0}, duration, {ease: FlxEase.quadInOut});
			}
		} else {
			switch (usesBlack) {
				case false:
					//do nothing ig
				case true:
					leTween = FlxTween.tween(transBlack, {alpha: 1}, duration, {ease: FlxEase.quadInOut});
			}
		}
		new FlxTimer().start(usesBlack ? duration : (isTransIn ? 0.6 : 0.3), function(twn:FlxTimer) {
			close();
			leTween?.cancel();
		});
	}

	override function close() {
		super.close();
		leTween?.cancel();
		if (finishCallback != null) {
			finishCallback();
			finishCallback = null;
		}
	}
}