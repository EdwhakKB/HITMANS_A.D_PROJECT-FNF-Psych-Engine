function initMod(mod)
{
    mod.curPosMath = function(lane, curPos, pf)
    {
        if (curPos <= -1250)
        {
            curPos = -1250 + (curPos*0.02);
        } 
        return curPos;
    };
    mod.noteMath = function(noteData, lane, curPos, pf)
    {
        var note = instance.notes.members[noteData.index];
        //desaturate the notes
        if (curPos <= -1250)
        {
            curPos = -1250 + (curPos*0.02);
            note.colorSwap.saturation = -0.95;
            note.colorSwap.brightness = -0.2;
        } 
        else if (curPos <= -700)
        {
            var a = (700-Math.abs(curPos))/(700-1250); //lerp out the desat
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