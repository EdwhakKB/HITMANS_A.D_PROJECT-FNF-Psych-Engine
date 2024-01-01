function initMod(mod)
    {
        mod.curPosMath = function(lane, curPos, pf)
        {
            if (curPos <= -1250)
            {
                curPos = -1250 + (curPos*1);
            } 
            return curPos;
        };
        mod.noteMath = function(noteData, lane, curPos, pf)
        {
            if (curPos <= -1250)
            {
                noteData.alpha = 0;
            } 
            else if (curPos <= -700)
            {
                var a = (700-Math.abs(curPos))/(700-1250); //lerp out the desat
                noteData.alpha = 1*a;
            }
            else 
            {
                noteData.alpha = 1;
            }
        };
    }