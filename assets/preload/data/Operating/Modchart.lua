--modchart by EDWHAK
function onCreatePost()
    startMod('DrunkY', 'DrunkYModifier', '', -1)

    for i = 0,3 do 
        local beat = i*8 --2 sections, loop 4x to last for 8 sections

        --start time, ease time, ease, modifier data (value, name)
        ease(beat, 2, 'expoOut', [[
            0.5, DrunkY,
        ]])
        --reverse flips the scroll
        --confusion spins the notes

        --one section after
    end

    startMod('drunkPF0', 'DrunkXModifier', '', 0) --playfield 0 = default playfield


    for i = 4,7 do 
        local beat = i*8

        --start time, ease time, ease, modifier data (value, name)
        ease(beat, 1, 'quantInOut', [[
            0.5, drunkPF0,
            2, drunkPF0:speed
        ]])
    end

    startMod('bumpZ', 'BounceZModifier', '', 0)

    ease(64, 1, 'cubeInOut', [[
        1, bumpZ,
    ]])

    startMod('TipsyY', 'TipsyYModifier', '', 0)
    startMod('WaveX', 'WaveXModifier', '', 0)

    ease(192, 1, 'cubeInOut', [[
        0.5, TipsyY,
        5, WaveX,
        1, WaveX:speed
    ]])

    set(224, [[
        0, bumpZ,
        1, drunkPF0,
        4, drunkPF0:speed
    ]])

    ease(352, 2, 'expoOut', [[
        0, TipsyY,
        0.5, drunkPF0,
        2, drunkPF0:speed,
        0, WaveX,
        1, WaveX:speed
    ]])

    startMod('Boost', 'BoostModifier', '', 0)

    --start time, ease time, ease, modifier data (value, name)
    ease(384, 1, 'expoOut', [[
        1, Boost,
        0, drunkPF0,
        1, drunkPF0:speed
    ]])

    startMod('DrunkZ', 'DrunkZModifier', '', 0)
    ease(480, 1, 'expoOut', [[
        4, DrunkZ,
        0.5, DrunkZ:speed,
    ]])
end