--Modchart By EDWHAK
function onCreatePost()
    startMod('DrunkX','DrunkXModifier','',-1)
    startMod('TipsyY','TipsyYModifier','',-1)
    startMod('ScaleAll','ScaleModifier','',-1)
    startMod('ScaleY','ScaleYModifier','',-1)
    startMod('ScaleX','ScaleXModifier','',-1)
    startMod('Beat', 'BeatXModifier','',-1)
    startMod('Alpha', 'StealthModifier','OPPONENT',-1)
    startMod('backIn','BrakeModifier','',0)
    startMod('Shrink','ShrinkModifier','',0)
    addPlayfield(0,0,0)
    startMod('DrunkXPF1','DrunkXModifier','',1)
    startMod('Reflaction', 'ReverseModifier','',1)
    startMod('AlphaPF1', 'StealthModifier','',1)
    startMod('AlphaNPF1', 'NoteStealthModifier','',1)
    startMod('zPF1', 'ZModifier', '', 1)
    startMod('tipsyPF1', 'TipsyYModifier', '', 1)
    startMod('JumpPF1', 'JumpModifier','',1)
    startMod('InvPF1', 'InvertSineModifier','',1)
    startMod('BumpyPF1', 'BumpyModifier','',1)
    startMod('Beat', 'BeatXModifier','',-1)
    startMod('BoostPF1', 'BoostModifier','',1)
    ease(0, 1, 'cubeInOut', [[
        0.6, AlphaPF1,
        1, Alpha,
    ]])
    set(1, [[
        5, JumpPF1
    ]])
    ease(96, 1, 'backOut', [[
        0, JumpPF1,
        -100, zPF1,
        1.5, DrunkXPF1,
        4, DrunkXPF1:speed,
    ]])
    ease(192, 1, 'backOut', [[
        2, InvPF1,
        -1, zPF1,
        0, DrunkXPF1,
        0, DrunkXPF1:speed,
    ]])
    ease(256, 1, 'smoothInOut', [[
        0, InvPF1,
        2, Beat,
    ]])
    ease(316, 2, 'backOut', [[
        1, Reflaction,
        0.5, AlphaPF1,
        0, Beat,
    ]])
    ease(383, 1, 'backOut', [[
        0, Reflaction,
    ]])
    ease(383, 1, 'backOut', [[
        1, BoostPF1,
    ]])
    ease(448, 1, 'backOut', [[
        1, Shrink,
    ]])
    ease(544, 1, 'backOut', [[
        0, BoostPF1,
        0, Shrink,
        1, backIn,
    ]])
end