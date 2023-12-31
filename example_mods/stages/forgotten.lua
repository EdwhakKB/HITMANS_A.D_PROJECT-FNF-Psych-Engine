function onCreate()
    -- bg ofc
    makeAnimatedLuaSprite('bg', 'hitmans/BGs/Anby/Forgotten/dangerous-stage', -120, -100)
    addAnimationByPrefix('bg', 'anim', 'dangerous-stage', 24, true);
    addLuaSprite('bg', 'false')
    scaleObject('bg', 0.7, 0.7)
    setScrollFactor('bg', 0.2, 0.2);

    -- Corrupted... It's not BF, it just copied BF's body, remember this.
    makeAnimatedLuaSprite('corrupted', 'hitmans/BGs/Anby/Forgotten/corrupted', 925, 250)
    addAnimationByPrefix('corrupted', 'anim', 'idle', 24, true);
    addLuaSprite('corrupted', true)
    doTweenAlpha('corruptedTween', 'corrupted', 0, 0.4, 'sineOut')
    scaleObject('corrupted', 1, 1)
    setScrollFactor('corrupted', 0.2, 0.2);
    -- Corrupted... but in the dark.
    makeAnimatedLuaSprite('corrupted-dark', 'hitmans/BGs/Anby/Forgotten/corrupted-dark', 925, 250)
    addAnimationByPrefix('corrupted-dark', 'anim', 'idle', 24, true);
    addLuaSprite('corrupted-dark', true)
    doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 0, 0.4, 'sineOut')
    scaleObject('corrupted-dark', 1, 1)
    setScrollFactor('corrupted-dark', 0.2, 0.2);

    makeAnimatedLuaSprite('anby', 'hitmans/BGs/Anby/Forgotten/anby...', 100, 250)
    addAnimationByPrefix('anby', 'anim', 'talk', 24, true);
    addLuaSprite('anby', true)
    doTweenAlpha('anby', 'anby', 0, 0.01, 'sineOut')
    scaleObject('anby', 1, 1)
    setScrollFactor('anby', 0.2, 0.2);

    -- bg dark effect
    makeLuaSprite('bg-dark', 'hitmans/BGs/Anby/Forgotten/dangerous-stage-darkness', -100, 0)
    addLuaSprite('bg-dark', false)
    setGraphicSize('bg-dark', 1600, 900)
    setScrollFactor('bg-dark', 0.2, 0.2);

    --fog things
    makeLuaSprite('fog', 'hitmans/BGs/Anby/Forgotten/dark-fog', -200, -500)
    addLuaSprite('fog', true)
    scaleObject('fog', 1, 1)
    setScrollFactor('fog', 0, 0);

    -- effect for low hp, which is used in forgot.lua
    makeLuaSprite('frostbite', 'hitmans/BGs/Anby/Icebeat/frostbite', -580, -350)

    -- just glitch lol
    makeAnimatedLuaSprite('glitch', 'hitmans/BGs/Anby/Forgotten/glitch', -150, -100)
    addAnimationByPrefix('glitch', 'anim', 'glitch', 24, true);
    addLuaSprite('glitch', false)
    scaleObject('glitch', 3, 3)
    setScrollFactor('glitch', 0, 0);

    close(true); -- For perfomance reasons
end
