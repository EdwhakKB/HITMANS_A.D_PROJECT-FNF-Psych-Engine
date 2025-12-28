package engine;

import flixel.util.FlxGradient;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	var leTween:FlxTween = null;
	var isTransIn:Bool = false;
	var transBlack:FlxSprite;
	var staticTrans:FlxSprite;
	var duration:Float = 0.5;
	var usesBlack:Bool = false;

	public function new(duration:Float, isTransIn:Bool, ?usesBlack:Bool = false) {
		this.duration = duration;
		this.isTransIn = isTransIn;
		this.usesBlack = usesBlack;
		super();
	}

	override public function create() 
	{
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
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

		leTween = FlxTween.tween(usesBlack ? transBlack : staticTrans, {alpha: isTransIn ? 0 : 1}, usesBlack ? 0.6 : duration, {ease: usesBlack ? FlxEase.quadInOut : FlxEase.smoothStepIn});
		new FlxTimer().start(usesBlack ? duration : (isTransIn ? 0.6 : 0.3), function(twn:FlxTimer) close());

		super.create();
	}

	override function close() {
		super.close();
		leTween?.cancel();
		trace(finishCallback == null);
		if (finishCallback != null) {
			finishCallback();
			trace(finishCallback);
			finishCallback = null;
		}
	}
}