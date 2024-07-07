package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	private var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	var isTransIn:Bool = false;
	var transBlack:FlxSprite;
	var staticTrans:FlxSprite;

	public function new(duration:Float, isTransIn:Bool, ?usesBlack:Bool = false) {
		super();

		// trace(usesBlack);
		this.isTransIn = isTransIn;
		var zoom:Float = CoolUtil.boundTo(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);

		transBlack = new FlxSprite().makeGraphic(width, height + 400, FlxColor.BLACK);
		transBlack.scrollFactor.set();
		transBlack.alpha = isTransIn ? 1 : 0;
		transBlack.visible = usesBlack;
		add(transBlack);

		staticTrans = new FlxSprite();
		staticTrans.frames = Paths.getSparrowAtlas('menuPause');
        staticTrans.animation.addByPrefix('glitch', 'glitch', 48, true);	
        staticTrans.antialiasing = ClientPrefs.globalAntialiasing;
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
			new FlxTimer().start(usesBlack ? duration : 0.6, function(twn:FlxTimer) {
				close();
			});
		} else {
			switch (usesBlack) {
				case false:
					//do nothing ig
				case true:
					leTween = FlxTween.tween(transBlack, {alpha: 1}, duration, {ease: FlxEase.quadInOut});
			}
			new FlxTimer().start(usesBlack ? duration : 0.3, function(twn:FlxTimer) {
				if(finishCallback != null) {
					finishCallback();
				}
			});
		}

		if(nextCamera != null) {
			transBlack.cameras = [nextCamera];
			staticTrans.cameras = [nextCamera];
		}
		nextCamera = null;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}

	override function destroy() {
		if(leTween != null) {
			finishCallback();
			leTween.cancel();
		}
		super.destroy();
	}
}