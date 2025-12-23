package modcharting.modifiers;

import modcharting.PlayfieldRenderer.StrumNoteType;
import flixel.tweens.FlxEase;
import flixel.math.FlxMath;
import flixel.math.FlxAngle;
import flixel.FlxG;
import modcharting.Modifier;
import objects.Note;
import modcharting.Modifier.ModifierSubValue;

class ReverseModifier extends Modifier
{
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        var ud = false;
        if (instance != null) if (ModchartUtil.getDownscroll(instance)) ud = true;

        var scrollSwitch = 520;
		if (ud) scrollSwitch *= -1;

        noteData.y += scrollSwitch * currentValue;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    {
        return noteDist * (1-(currentValue*2));
    }
}
class SplitModifier extends Modifier 
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        setSubMod("VarA", 0.0);
        setSubMod("VarB", 0.0);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        var ud = false;
        if (instance != null) if (ModchartUtil.getDownscroll(instance)) ud = true;

        var scrollSwitch = 520;
		if (ud) scrollSwitch *= -1;

        var laneThing = lane % NoteMovement.keyCount;

        if (laneThing > 1) noteData.y += (getSubMod("VarA")) * scrollSwitch;

        if (laneThing < 2) noteData.y += (getSubMod("VarB")) * scrollSwitch;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    {
        var laneThing = lane % NoteMovement.keyCount;

        if (laneThing > 1) return noteDist * (1-(getSubMod("VarA")*2));

        if (laneThing < 2) return noteDist * (1-(getSubMod("VarB")*2));

        return noteDist;
    }
    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
}
class CrossModifier extends Modifier 
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        setSubMod("VarA", 0.0);
        setSubMod("VarB", 0.0);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        var ud = false;
        if (instance != null) if (ModchartUtil.getDownscroll(instance)) ud = true;

        var scrollSwitch = 520;
		if (ud) scrollSwitch *= -1;
        
        var laneThing = lane % NoteMovement.keyCount;

        if (laneThing > 0 && laneThing < 3) noteData.y += (getSubMod("VarA")) * scrollSwitch;

        if (laneThing == 0 || laneThing == 3) noteData.y += (getSubMod("VarB")) * scrollSwitch;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    {
        var laneThing = lane % NoteMovement.keyCount;

        if (laneThing > 0 && laneThing < 3) return noteDist * (1-(getSubMod("VarA")*2));

        if (laneThing == 0 || laneThing == 3) return noteDist * (1-(getSubMod("VarB")*2));

        return noteDist;
    }
    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
}
class AlternateModifier extends Modifier 
{
    override function setupSubValues()
    {
        baseValue = 0.0;
        currentValue = 1.0;
        setSubMod("VarA", 0.0);
        setSubMod("VarB", 0.0);
    }
    override function strumMath(noteData:NotePositionData, lane:Int, pf:Int)
    {  
        var ud = false;
        if (instance != null) if (ModchartUtil.getDownscroll(instance)) ud = true;

        var scrollSwitch = 520;
		if (ud) scrollSwitch *= -1;

        if (lane%2 == 1) noteData.y += (getSubMod("VarA")) * scrollSwitch;

        if (lane%2 == 0) noteData.y += (getSubMod("VarB")) * scrollSwitch;
    }
    override function noteMath(noteData:NotePositionData, lane:Int, curPos:Float, pf:Int)
    {
        strumMath(noteData, lane, pf);
    }
    override function noteDistMath(noteDist:Float, lane:Int, curPos:Float, pf:Int)
    {
        if (lane%2 == 1) return noteDist * (1-(getSubMod("VarA")*2));

        if (lane%2 == 0) return noteDist * (1-(getSubMod("VarB")*2));

        return noteDist;
    }
    override function reset()
    {
        super.reset();
        baseValue = 0.0;
        currentValue = 1.0;
    }
}