--Modchart By EDWHAK
function onCreatePost()
    startMod('DrunkX','DrunkXModifier','',-1)
    startMod('DrunkZ','DrunkZModifier','',-1)
    startMod('TipsyY','TipsyYModifier','',-1)
    startMod('ScaleAll','ScaleModifier','',-1)
    startMod('ScaleY','ScaleYModifier','',-1)
    startMod('ScaleX','ScaleXModifier','',-1)
    startMod('Rev', 'ReverseModifier','',-1)
    startMod('Beat', 'BeatXModifier','',-1)
    startMod('BeatZ', 'BeatZModifier','',-1)
    startMod('InvSine', 'InvertSineModifier','',-1)
    set(8, [[
        1, DrunkX,
        2, DrunkX:speed
    ]])
    for i = 1,8 do
        local beat = i*8 --so it does this 8 times!
    --8 to 71
    set((beat), [[
        1.5, ScaleY,
    ]])
    ease((beat), 0.5, 'cubeInOut', [[
        1, ScaleY,
    ]])
    set((beat)+1, [[
        1.5, ScaleX,
    ]])
    ease((beat)+1, 0.5, 'cubeInOut', [[
        1, ScaleX,
    ]])
    set((beat)+2, [[
        1.5, ScaleY,
    ]])
    ease((beat)+2, 0.5, 'cubeInOut', [[
        1, ScaleY,
    ]])
    set((beat)+3, [[
        1.5, ScaleX,
    ]])
    ease((beat)+3, 0.5, 'cubeInOut', [[
        1, ScaleX,
    ]])
    set((beat)+4, [[
        1.5, ScaleY,
    ]])
    ease((beat)+4, 0.5, 'cubeInOut', [[
        1, ScaleY,
    ]])
    set((beat)+5, [[
        1, TipsyY,
    ]])
    set((beat)+5.5, [[
        -1, TipsyY,
    ]])
    set((beat)+6, [[
        0, TipsyY,
    ]])
    set((beat)+7, [[
        2, ScaleAll,
    ]])
    ease((beat)+7, 0.5, 'cubeInOut', [[
        1, ScaleAll,
    ]])
    end
    set(40, [[
        0.5, DrunkX,
        6, DrunkX:speed
    ]])
    ease(75, 1, 'backOut', [[
        0, DrunkX,
        1, DrunkX:speed
    ]])
    ease(106, 1.5, 'cubeInOut', [[
        1, Rev
    ]])
    ease(122, 1.5, 'cubeInOut', [[
        0, Rev
    ]])
    set(132, [[
        1, DrunkX,
        10, DrunkX:speed
    ]])
    ease(140, 0.5, 'backOut', [[
        0, DrunkX,
        1, DrunkX:speed,
        2, Beat
    ]])
    ease(172, 0.3, 'cubeInOut', [[
        1, Rev
    ]])
    ease(204, 0.3, 'cubeInOut', [[
        0, Rev,
        0, Beat,
    ]])
    for i = 26,33.5 do
        local beat = i*8
    set((beat),[[
        6, DrunkZ,
        8, DrunkZ:speed
    ]])
    ease((beat), 1, 'quantInOut',[[
        0, DrunkZ
    ]])
    end
    ease(210, 0.3, 'cubeInOut', [[
        1, InvSine
    ]])
    ease(212, 0.3, 'cubeInOut', [[
        1, Rev,
        0, InvSine
    ]])
    ease(218, 0.3, 'cubeInOut', [[
        1, InvSine
    ]])
    ease(220, 0.3, 'cubeInOut', [[
        0, Rev,
        0, InvSine
    ]])
    ease(226, 0.3, 'cubeInOut', [[
        1, InvSine
    ]])
    ease(228, 0.3, 'cubeInOut', [[
        1, Rev,
        0, InvSine
    ]])
    set(234, [[
        1, DrunkX,
        10, DrunkX:speed
    ]])
    set(236, [[
        0, DrunkX,
        1, DrunkX:speed
    ]])
    ease(236, 0.3, 'cubeInOut', [[
        0, Rev
    ]])
    ease(242, 0.3, 'cubeInOut', [[
        1, InvSine
    ]])
    ease(244, 0.3, 'cubeInOut', [[
        1, Rev,
        0, InvSine
    ]])
    ease(250, 0.3, 'cubeInOut', [[
        1, InvSine
    ]])
    ease(252, 0.3, 'cubeInOut', [[
        0, Rev,
        0, InvSine
    ]])
    ease(258, 0.3, 'cubeInOut', [[
        1, InvSine
    ]])
    ease(260, 0.3, 'cubeInOut', [[
        1, Rev,
        0, InvSine
    ]])
    set(266, [[
        1, DrunkX,
        10, DrunkX:speed
    ]])
    ease(268, 0.3, 'cubeInOut', [[
        0, Rev,
        0, DrunkX,
        1, DrunkX:speed
    ]])
    set(304, [[
        0.3, DrunkX,
        30, DrunkX:speed
    ]])
    set(312, [[
        0.3, DrunkX,
        1, DrunkX:speed
    ]])
end