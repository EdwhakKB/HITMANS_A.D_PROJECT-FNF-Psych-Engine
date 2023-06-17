function initMod(mod)
{
    mod.incomingAngleMath = function(lane, curPos, pf)
    {
        if (lane % 2 == 0)
        {
            return [0, 360*3 + curPos/6];
        }
            return [0, 360*3 - curPos/6];
    }
}