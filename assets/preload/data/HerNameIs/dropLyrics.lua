function onSongStart()
    mainCoroPart(3,'1')
end

function onBeatHit()
    if curBeat == 16 then
        mainCoroPart(66, '1')
    end
    if curBeat == 32 then
        changeScreen('normal')
        mainCoroPart(130, '1')
    end
    if curBeat == 48 then
        mainCoroPart(194, '1')
    end
end

local theVariableTxt = 'empty'
local allowColorChange = false

local colorType = 'default' --added this to fix the issue when you change the colors all shits that became that color alpha to 1 lmao (will fix in source in a future)
local datime = 0.01 --no crash
local daease = 'linear' --default ease to antiCrash lmao

local numberVar = 0
local theAlphaEase = 'linear'

function vocalsAlpha(style, mainAlpha, num, time, ease)
    numberVar = num
    theAlphaEase = ease
    if style == 'coroStart' then
        theVariableTxt = 'na'
        setProperty('na'..num..'.alpha', mainAlpha)
    end
    if style == 'coroDrop' then
        theVariableTxt = 'coroMain'
        setProperty('coroMain'..num..'.alpha', mainAlpha)
    end
    if colorType == 'normal' then
        doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, '000000', datime, daease)
    elseif colorType == 'invert' then
        doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, 'ffffff', datime, daease)
    elseif colorType == 'invertWhite' then
        doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, 'ffffff', datime, daease)
    end
    doTweenAlpha('AlphaIn'..style..num, theVariableTxt..num, 0, time, ease)
end

function mainCoroPart(step, part)
    function onStepHit()
        if part == '1' then
            if curStep == step then
                vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
            elseif curStep == step+2 then
                vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
            elseif curStep == step+4 then
                vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
            elseif curStep == step+6 then
                vocalsAlpha('coroStart', 0.5, 3, 0.3, 'smoothStepOut') 
            elseif curStep == step+7 then
                vocalsAlpha('coroStart', 0.5, 4, 0.3, 'smoothStepOut') 
            elseif curStep == step+8 then
                vocalsAlpha('coroStart', 0.5, 5, 0.3, 'smoothStepOut')
            elseif curStep == step+9 then
                vocalsAlpha('coroStart', 0.5, 6, 0.3, 'smoothStepOut')
            elseif curStep == step+10 then
                vocalsAlpha('coroStart', 0.5, 7, 0.3, 'smoothStepOut')
            elseif curStep == step+15 then
                vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
            elseif curStep == step+17 then
                vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
            elseif curStep == step+19 then
                vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
            elseif curStep == step+21 then
                vocalsAlpha('coroDrop', 0.5, 2, 0.8, 'smoothStepOut')

            ------------~SHOW ME YOUR HEART~-----------

            elseif curStep == step+31 then
                vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
            elseif curStep == step+33 then
                vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
            elseif curStep == step+35 then
                vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
            elseif curStep == step+37 then
                vocalsAlpha('coroStart', 0.5, 3, 0.3, 'smoothStepOut') 
            elseif curStep == step+38 then
                vocalsAlpha('coroStart', 0.5, 4, 0.3, 'smoothStepOut') 
            elseif curStep == step+39 then
                vocalsAlpha('coroStart', 0.5, 5, 0.3, 'smoothStepOut')
            elseif curStep == step+40 then
                vocalsAlpha('coroStart', 0.5, 6, 0.3, 'smoothStepOut')
            elseif curStep == step+41 then
                vocalsAlpha('coroStart', 0.5, 7, 0.3, 'smoothStepOut')
            elseif curStep == step+43 then
                vocalsAlpha('coroDrop', 0.5, 1, 2, 'smoothStepOut')
            end
        elseif part == '2' then

        end
    end
end

function changeScreen(newScreen)
    colorType = newScreen
end