function initMod(mod)
{
    mod.curPosMath = function(lane, curPos, pf)
    {
        if (curPos <= -950)
        {
            curPos = -950 + (curPos*0.02);
        } 
        /*else if (curPos <= -700)
        {
            //var a = (700-Math.abs(curPos))/(700-1250);
        }
        else 
        {

        }*/
            /*
            setPropertyFromGroup('notes', i, 'colorSwap.saturation', -0.95)
            setPropertyFromGroup('notes', i, 'colorSwap.brightness', -0.2)
        elseif curPos <= -700 then 
            
            setPropertyFromGroup('notes', i, 'colorSwap.saturation', -0.95*a)
            setPropertyFromGroup('notes', i, 'colorSwap.brightness', -0.2*a)
        else
            setPropertyFromGroup('notes', i, 'colorSwap.saturation', 0)
            setPropertyFromGroup('notes', i, 'colorSwap.brightness', 0)
        end*/
        return curPos;
    };
    mod.noteMath = function(noteData, lane, curPos, pf)
    {
        var note = instance.notes.members[noteData.index];
        //desaturate the notes
        if (curPos <= -950)
        {
            curPos = -950 + (curPos*0.02);
            note.colorSwap.saturation = -0.95;
            note.colorSwap.brightness = -0.2;
        } 
        else if (curPos <= -500)
        {
            var a = (500-Math.abs(curPos))/(500-950); //lerp out the desat
            note.colorSwap.saturation = -0.95*a;
            note.colorSwap.brightness = -0.2*a;
        }
        else 
        {
            note.colorSwap.saturation = 0;
            note.colorSwap.brightness = 0;
        }
    };
}