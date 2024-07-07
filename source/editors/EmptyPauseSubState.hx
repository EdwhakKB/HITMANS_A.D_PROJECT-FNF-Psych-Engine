package editors;

import flixel.text.FlxText;
import flixel.FlxG;

class EmptyPauseSubState extends MusicBeatSubstate
{
    public function new(x:Float, y:Float)
    {
        super();

        var pd = new FlxText(0, 0, 250, 'PAUSED', 50);
        pd.size = 50;
        pd.screenCenter(flixel.util.FlxAxes.XY);
        add(pd);

        cameras = [FlxG.cameras.list[FlxG.cameras.list.indexOf(EditorPlayState.instance.camOther)]];
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if(FlxG.keys.justPressed.F7) close();
    }
}