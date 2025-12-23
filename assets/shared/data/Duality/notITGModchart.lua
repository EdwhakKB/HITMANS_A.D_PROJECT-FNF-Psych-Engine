--Modchart By EDWHAK
function onCreatePost()
    startMod('DrunkX','DrunkXModifier','',-1)
    startMod('TipsyY','TipsyYModifier','',-1)
    startMod('ScaleAll','ScaleModifier','',-1)
    startMod('ScaleY','ScaleYModifier','',-1)
    startMod('ScaleX','ScaleXModifier','',-1)
    startMod('Beat', 'BeatXModifier','',-1)
    startMod('AlphaO', 'AlphaModifier','OPPONENT',-1)
    startMod('BeatY', 'BeatYModifier','',-1)
    startMod('Z', 'ZModifier','PLAYER', -1)
    ----PF0/default
    startMod('AlphaPF0', 'AlphaModifier','PLAYER',0)
    startMod('backInPF0','BrakeModifier','PLAYER',0)
    startMod('ShrinkPF0','ShrinkModifier','PLAYER',0)
    startMod('SLRPF0','StrumLineRotateModifier','PLAYER',0)
    startMod('WavePF0','WaveXModifier','PLAYER',0)
    startMod('ZPF0', 'ZModifier','PLAYER', 0)
    startMod('YPF0', 'YModifier','PLAYER',0)
    
    ----PF1
    addPlayfield(0,0,0)
    startMod('AlphaPF1', 'AlphaModifier','PLAYER',1)
    startMod('ZPF1', 'ZModifier','PLAYER',1)
    startMod('XPF1', 'XModifier','PLAYER',1)
    startMod('YPF1', 'YModifier','PLAYER',1)

    ----PF2
    addPlayfield(0,0,0)
    startMod('AlphaPF2', 'AlphaModifier','PLAYER',2)
    startMod('ZPF2', 'ZModifier','PLAYER',2)
    startMod('XPF2', 'XModifier','PLAYER',2)
    startMod('YPF2', 'YModifier','PLAYER',2)

    ----PF3
    addPlayfield(0,0,0)
    startMod('AlphaPF3', 'AlphaModifier','PLAYER',3)
    startMod('ZPF3', 'ZModifier','PLAYER',3)
    startMod('XPF3', 'XModifier','PLAYER',3)
    startMod('RevPF3','ReverseModifier','PLAYER',3)
    startMod('YPF3', 'YModifier','PLAYER',3)

    ----PF4
    addPlayfield(0,0,0)
    startMod('AlphaPF4', 'AlphaModifier','PLAYER',4)
    startMod('ZPF4', 'ZModifier','PLAYER',4)
    startMod('XPF4', 'XModifier','PLAYER',4)
    startMod('RevPF4','ReverseModifier','PLAYER',4)
    startMod('YPF4', 'YModifier','PLAYER',4)

    ----PF5
    addPlayfield(0,0,0)
    startMod('AlphaPF5', 'AlphaModifier','PLAYER',5)
    startMod('ZPF5', 'ZModifier','PLAYER',5)
    startMod('XPF5', 'XModifier','PLAYER',5)
    startMod('RevPF5','ReverseModifier','PLAYER',5)
    startMod('YPF5', 'YModifier','PLAYER',5)

    -- startMod('BoostPF1', 'BoostModifier','',1)

    ease(0, 1, 'cubeInOut', [[
        1, AlphaO,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(63, 1, 'cubeInOut', [[
        2, Beat
    ]])
    set(64, [[
        0.3, AlphaPF1,
        -200, ZPF1
    ]])
    set(80, [[
        0.5, AlphaPF2,
        -400, ZPF2
    ]])
    set(96, [[
        0.7, AlphaPF3,
        -600, ZPF3
    ]])
    set(112, [[
        0.9, AlphaPF4,
        -800, ZPF4
    ]])
    set(126, [[
        1, AlphaPF4,
        -1, ZPF4
    ]])
    set(126.5, [[
        1, AlphaPF3,
        0, ZPF3
    ]])
    set(127, [[
        1, AlphaPF2,
        0, ZPF2
    ]])
    set(127.5, [[
        1, AlphaPF1,
        -0, ZPF1
    ]])
    ease(128, 1, 'cubeInOut', [[
        0, Beat,
        0.2, DrunkX,
        10, DrunkX:speed
    ]])
    ease(160, 1, 'cubeInOut', [[
        300, XPF1,
        300, XPF2,
        1, AlphaPF0,
        0, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(168, 2, 'cubeInOut', [[
        -300, XPF2,
        -300, XPF3,
        -300, XPF5,
        1, AlphaPF0,
        1, AlphaPF1,
        0, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(176, 1, 'cubeInOut', [[
        1, RevPF3,
        1, RevPF5,
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        0, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(184, 1, 'cubeInOut', [[
        0, XPF5,
        1, RevPF4,
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        0, AlphaPF5
    ]])
    ease(190, 1, 'cubeInOut', [[
        300, XPF4,
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(200, 2, 'cubeInOut', [[
        1, AlphaPF0,
        1, AlphaPF1,
        0, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(208, 2, 'cubeInOut', [[
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        0, AlphaPF5
    ]])
    ease(216, 2, 'cubeInOut', [[
        1, AlphaPF0,
        0, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(224, 2, 'cubeInOut', [[
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        0, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(232, 2, 'cubeInOut', [[
        0, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    if downscroll then
    set(256, [[
        -600, Z,
        600, XPF1,
        -600, XPF2,
        600, XPF4,
        -600, XPF3,
        200, YPF0,
        200, YPF1,
        200, YPF2,
        -200, YPF4,
        -200, YPF3,
        -200, YPF5,
        0, AlphaPF0,
        0.5, AlphaPF1,
        0.5, AlphaPF2,
        0, AlphaPF3,
        0, AlphaPF4,
        0.5, AlphaPF5
    ]])
    else
        set(256, [[
            -600, Z,
            600, XPF1,
            -600, XPF2,
            600, XPF4,
            -600, XPF3,
            -200, YPF0,
            -200, YPF1,
            -200, YPF2,
            200, YPF4,
            200, YPF3,
            200, YPF5,
            0, AlphaPF0,
            0.5, AlphaPF1,
            0.5, AlphaPF2,
            0, AlphaPF3,
            0, AlphaPF4,
            0.5, AlphaPF5
        ]])
    end
    ease(320,1,'cubeInOut', [[
        0, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        0, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(368,1,'cubeInOut', [[
        1, AlphaPF0,
        0, AlphaPF1,
        0, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        0, AlphaPF5
    ]])
    ease(384,1,'cubeInOut', [[
        0, Z,
        300, XPF1,
        -300, XPF2,
        300, XPF4,
        -300, XPF3,
        0, YPF0,
        0, YPF1,
        0, YPF2,
        0, YPF4,
        0, YPF3,
        0, YPF5,
        1, AlphaPF0,
        0, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(400,1,'cubeInOut', [[
        1, AlphaPF0,
        1, AlphaPF1,
        0, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(416,1,'cubeInOut', [[
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        0, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    ease(432,1,'cubeInOut', [[
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    set(448, [[
        1, AlphaPF0,
        0, AlphaPF1,
        1, AlphaPF2,
        0, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    set(449, [[
        1, AlphaPF0,
        1, AlphaPF1,
        0, AlphaPF2,
        1, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    set(450, [[
        0, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        0, AlphaPF5
    ]])
    set(452, [[
        0, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        0, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    set(452.5, [[
        1, AlphaPF0,
        1, AlphaPF1,
        0, AlphaPF2,
        1, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    set(453, [[
        1, AlphaPF0,
        0, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        0, AlphaPF5
    ]])
    set(453.5, [[
        0, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    set(454, [[
        0, AlphaPF0,
        0, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    set(454.25, [[
        0, AlphaPF0,
        0, AlphaPF1,
        0, AlphaPF2,
        1, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    set(454.5, [[
        0, AlphaPF0,
        0, AlphaPF1,
        0, AlphaPF2,
        0, AlphaPF3,
        0, AlphaPF4,
        1, AlphaPF5
    ]])
    set(454.75, [[
        0, AlphaPF0,
        0, AlphaPF1,
        0, AlphaPF2,
        0, AlphaPF3,
        0, AlphaPF4,
        0, AlphaPF5
    ]])
    ease(455,1,'backOut', [[
        300, Z
    ]])
    ease(456,1,'backInOut', [[
        -900, Z,
    ]])
    ease(457,1,'backInOut', [[
        1, AlphaPF0,
        1, AlphaPF1,
        1, AlphaPF2,
        1, AlphaPF3,
        1, AlphaPF4,
        1, AlphaPF5
    ]])
    --64
    -- for i = 0,10 do 
    --     local beat = i*17 --2 sections, loop 4x to last for 8 sections

    --     --start time, ease time, ease, modifier data (value, name)
    --     ease(0, 1, 'cubeInOut', [[
    --         25, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     set((beat),'0, SLRPF0:x')
    --     --reverse flips the scroll
    --     --confusion spins the notes

    --     --one section after
    --     ease(beat+2, 1, 'cubeInOut', [[
    --         50, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+3, 1, 'cubeInOut', [[
    --         75, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+4, 1, 'cubeInOut', [[
    --         100, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+5, 1, 'cubeInOut', [[
    --         125, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+6, 1, 'cubeInOut', [[
    --         150, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+7, 1, 'cubeInOut', [[
    --         175, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+8, 1, 'cubeInOut', [[
    --         200, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+9, 1, 'cubeInOut', [[
    --         225, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+10, 1, 'cubeInOut', [[
    --         250, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+11, 1, 'cubeInOut', [[
    --         275, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+12, 1, 'cubeInOut', [[
    --         300, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+13, 1, 'cubeInOut', [[
    --         325, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+14, 1, 'cubeInOut', [[
    --         350, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+15, 1, 'cubeInOut', [[
    --         375, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    --     ease(beat+16, 1, 'cubeInOut', [[
    --         400, SLRPF0:x,
    --         50, SLRPF0:rotatePointX,
    --     ]])
    -- end
end