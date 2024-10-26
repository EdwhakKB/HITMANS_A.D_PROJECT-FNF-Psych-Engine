package;

import flixel.util.FlxSort;
import modcharting.ModchartUtil;

class LuaTweenEvent
{
  public var time:Float = 0;
  public var func:Void->Void;

  public function new(time:Float, func:Void->Void)
  {
    this.time = time;
    this.func = func;
  }
}

class LuaTweenManager
{ 
  public function new()
  {

  }
  
  public var events:Array<LuaTweenEvent> = [];

  public function update(elapsed:Float)
  {
    if (events.length > 1)
    {
      events.sort(function(a:LuaTweenEvent, b:LuaTweenEvent):Int {
        if (a.time < b.time) return -1;
        else if (a.time > b.time) return 1;
        return FlxSort.byValues(FlxSort.ASCENDING, a.time, b.time);
      });
    }
    while (events.length > 0)
    {
      var event:LuaTweenEvent = events[0];
      if (Conductor.songPosition < event.time)
      {
        break;
      }
      event.func();
      events.shift();
    }
  }

  public function addTweenEvent(beat:Float, func:Void->Void)
  {
    var time = modcharting.ModchartUtil.getTimeFromBeat(beat);
    events.push(new LuaTweenEvent(time, func));
  }

  public function clearTweenEvents()
  {
    events = [];
  }
}
