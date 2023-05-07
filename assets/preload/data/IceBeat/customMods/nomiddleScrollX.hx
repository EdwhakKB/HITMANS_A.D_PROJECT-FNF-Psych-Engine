function initMod(mod)
{
    mod.noteMath = function(noteData, lane, curPos, pf)
    {
        if (!ClientPrefs.middleScroll)
        {
            noteData.x += mod.currentValue;
        }
    };
    mod.strumMath = function(noteData, lane, pf)
    {
        mod.noteMath(noteData, lane, 0, pf);
    };
}