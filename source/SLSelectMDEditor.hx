package;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

class SLSelectMDEditor extends MusicBeatSubstate
{
	// public static var savedVars:Array<Dynamic> = [];

	var mainText1:FlxText;
	var mainText2:FlxText;

    var selected:Int = 0;

	override public function create()
	{
		super.create();

        // PlayState.persistentUpdate = false;
        // PlayState.instance.paused = true;

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.scrollFactor.set();
        add(bg);
        bg.alpha = 0.65;

		var mainText0:FlxText = new FlxText(0, 30, 0, "Select Editor", 30);
		mainText0.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		mainText0.scrollFactor.set();
		mainText0.screenCenter(X);
		mainText0.antialiasing = ClientPrefs.globalAntialiasing;
		add(mainText0);

		mainText1 = new FlxText(0, 0, 0, "Old Modchart Editor", 30);
		mainText1.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		mainText1.scrollFactor.set();
		mainText1.screenCenter();
		mainText1.y -= 40;
		mainText1.antialiasing = ClientPrefs.globalAntialiasing;
		add(mainText1);

		mainText2 = new FlxText(0, 0, 0, "New Modchart Editor", 30);
		mainText2.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		mainText2.scrollFactor.set();
		mainText2.screenCenter();
		mainText2.y += 40;
		mainText2.antialiasing = ClientPrefs.globalAntialiasing;
		add(mainText2);

        cameras = [FlxG.cameras.list[FlxG.cameras.list.indexOf(PlayState.instance.camOther)]];
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

        if (FlxG.keys.justPressed.UP) {
            selected--;
            FlxG.sound.play(Paths.sound('scrollMenu'));
            if (selected < 0) selected = 1;
        }
        else if (FlxG.keys.justPressed.DOWN) {
            selected++;
            FlxG.sound.play(Paths.sound('scrollMenu'));
            if (selected > 1) selected = 0;
        }

        if (selected == 0) {
            mainText1.alpha = 1;
            mainText2.alpha = 0.5;
        }
        else if (selected == 1) {
            mainText1.alpha = 0.5;
            mainText2.alpha = 1;
        }
        else if (controls.BACK) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            // PlayState.instance.persistentUpdate = true;
            // PlayState.instance.paused = false;
        }

        if(controls.ACCEPT && selected == 0) {
            FlxG.sound.play(Paths.sound('confirmMenu'));
            @:privateAccess
            PlayState.instance.openModchartEditor(true);
        }
        else if(controls.ACCEPT && selected == 1) {
            FlxG.sound.play(Paths.sound('confirmMenu'));
            @:privateAccess
            PlayState.instance.openModchartEditor();
        }
	}
}
