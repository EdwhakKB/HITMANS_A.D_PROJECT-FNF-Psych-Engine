package crashHandler;

import flixel.FlxGame as BaseGame;

class FlxGame extends BaseGame
{

    var alredyOpen:Bool = false;

	override public function switchState():Void
	{
		try
		{
			super.switchState();
		}
		catch (error)
		{
            if(!alredyOpen)
                {
                    alredyOpen = true;
                    CrashHandler.symbolPrevent(error);
                }
		}
	}

	override function update()
	{
		try
        {
            super.update();
        }
		catch(error)
        {
            if(!alredyOpen)
            {
                alredyOpen = true;
                CrashHandler.symbolPrevent(error);
            }
        }
	}
}
