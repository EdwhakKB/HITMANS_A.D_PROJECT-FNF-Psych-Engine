--Modchart By EDWHAK
function onCreatePost()
    ---------------MODIFIERS-----------------
    ---------DO NOT FUCKING TOUCH!-----------

    --PLAYER
    startMod('Y','YModifier','PLAYER',-1)
    startMod('DrunkX','DrunkXModifier','PLAYER',-1)
    startMod('DrunkY','DrunkYModifier','PLAYER',-1)
    startMod('DrunkZ','DrunkZModifier','PLAYER',-1)
    startMod('WaveX','WaveXModifier','PLAYER',-1)
    startMod('Rev','ReverseModifier','PLAYER',-1)
    startMod('Zchanger','EaseCurveZModifier','PLAYER',-1)


    --OPPONENT
    startMod('StealthO','StealthModifier','OPPONENT',-1)

    --BOTH

    --CUSTOM

    ---------------PLAYFIELDS---------------
    --PLAYER

    --OPPONENT

    --BOTH

    ------------END OF MODIFIERS------------
    ----------------MODCHART----------------
    ease(0, 0.1, 'easeOut', [[
        1, StealthO
    ]])
    ease(32, 1, 'linear', [[
        5, WaveX,
        5, WaveX:speed
    ]])
    ease(64, 1, 'easeOut', [[
        0, WaveX,
        1, WaveX:speed,
        0.3, DrunkX,
        10, DrunkX:speed,
        0.3, DrunkY,
        20, DrunkY:speed
    ]])
    ease(96, 0.5, 'backOut', [[
        1, Rev
    ]])
    ease(128, 0.5, 'backOut', [[
        0, Rev
    ]])
    ease(160, 0.5, 'backOut', [[
        1, Rev
    ]])
    if downscroll then
        ease(191, 1, 'backOut', [[
            0, Rev,
            100, Zchanger
        ]])
    else
        ease(191, 1, 'backOut', [[
            0, Rev,
            -100, Zchanger
        ]])
    end
    ease(192, 1, 'backOut', [[
        0, Zchanger
    ]])
    for i = 47,80 do
        local beat = i*4
    set((beat),[[
        6, DrunkZ,
        8, DrunkZ:speed,
        0, backIn
    ]])
    ease((beat), 1, 'quantInOut',[[
        0, DrunkZ
    ]])
    end

    -----------END OF THE MODCHART-----------
end