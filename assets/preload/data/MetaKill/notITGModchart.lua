--Modchart By EDWHAK
function onCreatePost()
    ---------------MODIFIERS-----------------
    ---------DO NOT FUCKING TOUCH!-----------

    --PLAYER

    startMod('XPL','XModifier','PLAYER',-1)
    startMod('YPL','YModifier','PLAYER',-1)
    startMod('YTPL','TipsyYModifier','PLAYER',-1)
    startMod('DrunkXPL','DrunkXModifier','PLAYER',-1)
    startMod('DrunkYPL','DrunkYModifier','PLAYER',-1)
    startMod('DrunkZPL','DrunkZModifier','PLAYER',-1)
    startMod('BounceZPL','BounceZModifier','PLAYER',-1)
    startMod('WavePL','WaveXModifier','PLAYER',-1)
    startMod('Flip','FlipModifier','PLAYER',-1)

    --OPPONENT

    startMod('XOP','XModifier','OPPONENT',-1)
    startMod('YOP','YModifier','OPPONENT',-1)
    startMod('YTOP','TipsyYModifier','OPPONENT',-1)
    startMod('DrunkXOP','DrunkXModifier','OPPONENT',-1)
    startMod('DrunkYOP','DrunkYModifier','OPPONENT',-1)
    startMod('DrunkZOP','DrunkZModifier','OPPONENT',-1)
    startMod('BounceZOp','BounceZModifier','OPPONENT',-1)
    startMod('WaveOP','WaveXModifier','OPPONENT',-1)

    --LANE

    for i = 0,7 do
        startMod('Intro'..i,'YModifier','LANESPECIFIC',-1)
        setModTargetLane('Intro'..i, i)

        startMod('Alpha'..i,'StealthModifier','LANESPECIFIC',-1)
        setModTargetLane('Alpha'..i, i)

        startMod('X'..i,'XModifier','LANESPECIFIC',-1)
        setModTargetLane('X'..i, i)
    end

    --BOTH

    startMod('FlipBt','FlipModifier','',-1)

    --CUSTOM

    ---------------PLAYFIELDS---------------
    
    --PLAYER

    --OPPONENT

    --BOTH

    ------------END OF MODIFIERS------------
    ----------------MODCHART----------------
    for i = 0,7 do
        if downscroll then
            set(0, [[
                50, Intro]]..i..[[,
                1, Alpha]]..i..[[
            ]])
        else
            set(0, [[
            -50, Intro]]..i..[[,
            1, Alpha]]..i..[[
            ]])
        end
    end
    ease(0, 4, 'quadOut', [[
        0, Intro0,
        0, Intro4,
        0, Alpha0,
        0, Alpha4
    ]])
    ease(8, 4, 'quadOut', [[
        0, Intro1,
        0, Intro5,
        0, Alpha1,
        0, Alpha5
    ]])
    ease(16, 4, 'quadOut', [[
        0, Intro2,
        0, Intro6,
        0, Alpha2,
        0, Alpha6
    ]])
    ease(24, 4, 'quadOut', [[
        0, Intro3,
        0, Intro7,
        0, Alpha3,
        0, Alpha7
    ]])
    set(30, [[
        0.5, DrunkYPL,
        20, DrunkYPL:speed
    ]])
    if downscroll then
        if not middlescroll then
            ease(30, 2, 'backInOut', [[
                -100, YPL
            ]])
            ease(31, 1, 'backInOut', [[
                200, YPL
            ]])
        else
            ease(30, 2, 'backInOut', [[
                -100, YPL,
                340, XPL,
                -665, X2,
                -665, X3
            ]])
            ease(31, 1, 'backInOut', [[
                200, YPL
            ]])
        end
    else
        if not middlescroll then
            ease(30, 2, 'backInOut', [[
                100, YPL
            ]])
            ease(31, 1, 'backInOut', [[
                -200, YPL
            ]])
        else
            ease(30, 2, 'backInOut', [[
                100, YPL,
                340, XPL,
                -670, X2,
                -670, X3
            ]])
            ease(31, 1, 'backInOut', [[
                -200, YPL
            ]])
        end
    end
    ease(32, 1, 'quadOut', [[
        1, BounceZOp,
        0.5, YTOP,
        5, YTOP:speed
    ]])
    if downscroll then
        ease(46, 2, 'backInOut', [[
            -100, YPL,
            -100, YOP
        ]])
        ease(47.5, 1, 'backInOut', [[
            0, YPL,
            200, YOP
        ]])
    else
        ease(46, 2, 'backInOut', [[
            100, YPL,
            100, YOP
        ]])
        ease(47.5, 1, 'backInOut', [[
            0, YPL,
            -200, YOP
        ]])
    end
    set(48, [[
        0, DrunkYPL,
        1, DrunkYPL:speed,
        0.5, DrunkYOP,
        20, DrunkYOP:speed
    ]])
    ease(46, 1, 'quadOut', [[
        1, BounceZPL,
        0, BounceZOp,
        0.5, YTPL,
        5, YTPL:speed,
    ]])
    if downscroll then
        ease(62, 2, 'backInOut', [[
            -100, YOP,
            -100, YPL
        ]])
        ease(63.5, 1, 'backInOut', [[
            0, YOP,
            200, YPL
        ]])
    else
        ease(62, 2, 'backInOut', [[
            100, YOP,
            100, YPL
        ]])
        ease(63.5, 1, 'backInOut', [[
            0, YOP,
            -200, YPL
        ]])
    end
    set(62, [[
        0.5, DrunkYPL,
        20, DrunkYPL:speed
    ]])
    ease(76, 1, 'quadOut', [[
        0, BounceZPL,
    ]])
    if downscroll then
        ease(78, 2, 'backInOut', [[
            -100, YPL,
        ]])
        ease(79.5, 1, 'backInOut', [[
            0, YPL,
        ]])
    else
        ease(78, 2, 'backInOut', [[
            100, YPL
        ]])
        ease(79.5, 1, 'backInOut', [[
            0, YPL
        ]])
    end
    set(78, [[
        0.5, DrunkYPL,
        20, DrunkYPL:speed,
        0, DrunkYOP,
        1, DrunkYOP:speed
    ]])
    ease(96,1, 'quadOut', [[
        0, DrunkYPL,
        1, DrunkYPL:speed,
        0, DrunkYOP,
        1, DrunkYOP:speed
    ]])
    ease(100,0.2, 'quadOut', [[
        1, FlipBt
    ]])
    ease(104,0.2, 'quadOut', [[
        0, FlipBt
    ]])
    ease(116,0.2, 'quadOut', [[
        1, FlipBt
    ]])
    ease(120,0.2, 'quadOut', [[
        0, FlipBt
    ]])
    ease(384, 1, 'quadOut', [[
        -50, Intro4,
        50, Intro5,
        -100, Intro6,
        100, Intro7
    ]])
    ease(388,0.2, 'quadOut', [[
        1, Flip
    ]])
    ease(392, 1, 'quadOut', [[
        0, Intro4,
        0, Intro5,
        0, Intro6,
        0, Intro7
    ]])
    ease(448,1, 'quadOut', [[
        0, Flip
    ]])








    ease(1084, 2, 'quadOut', [[
        0, XPL,
        -340, X2,
        -340, X3,
        340, X0,
        340, X1
    ]])
    ease(1088, 1, 'quadOut', [[
        6, WavePL,
        -6, WaveOP,
        5, WavePL:speed,
        5, WaveOP:speed
    ]])
    -----------END OF THE MODCHART-----------
end