--Visuals by EDWHAK
function onCreate()

end
function onCreatePost()
    for i = 4,7 do
        makeAnimatedLuaSprite('hand'..i, 'hitmans/HackHand', 0, 0)
        addAnimationByPrefix('hand'..i, 'close', 'HackHand Closed', 24, false)
        addAnimationByPrefix('hand'..i, 'open', 'HackHand Open', 24, false)
        setObjectCamera('hand'..i, 'HUD')
        addLuaSprite('hand4', true)
        addLuaSprite('hand5', true)
        addLuaSprite('hand6', true)
        addLuaSprite('hand7', true)
        setProperty('hand'..i..'.alpha', 1)
        if downscroll then
            setProperty('hand' .. i .. '.angle', 270)
        else
            setProperty('hand' .. i .. '.angle', 90)
        end
        setProperty('hand'..i..'.visible', false)
    end
end

function onSongStart()--for step 0

end

local enableStatic = true
-- function onStepHit() 

-- end 

function HandScroll(var)
    enableStatic = false
    for i = 4,7 do
        if downscroll then
            if not var then
                doTweenY('Dhand'..i, 'hand'..i, -500,0.5, 'elasticIn')
                objectPlayAnimation('hand'..i, 'open', true)
            else
                doTweenY('Uhand'..i, 'hand'..i, 1000,0.5, 'elasticIn')
                objectPlayAnimation('hand'..i, 'open', true)
            end
        else
            if var then
                doTweenY('Dhand'..i, 'hand'..i, -500,0.5, 'elasticIn')
                objectPlayAnimation('hand'..i, 'open', true)
            else
                doTweenY('Uhand'..i, 'hand'..i, 1000,0.5, 'elasticIn')
                objectPlayAnimation('hand'..i, 'open', true)
            end
        end
    end
end

function onUpdate(elapsed)
    if enableStatic then
    daNoteX1 = getPropertyFromGroup('strumLineNotes', 4, 'x')
    daNoteX2 = getPropertyFromGroup('strumLineNotes', 5, 'x')
    daNoteX3 = getPropertyFromGroup('strumLineNotes', 6, 'x')
    daNoteX4 = getPropertyFromGroup('strumLineNotes', 7, 'x')

    daY1 = getPropertyFromGroup('strumLineNotes', 4, 'y')
    daY2 = getPropertyFromGroup('strumLineNotes', 5, 'y')
    daY3 = getPropertyFromGroup('strumLineNotes', 6, 'y')
    daY4 = getPropertyFromGroup('strumLineNotes', 7, 'y')

    setProperty('hand4.x', daNoteX1-200)
    setProperty('hand5.x', daNoteX2-200)
    setProperty('hand6.x', daNoteX3-200)
    setProperty('hand7.x', daNoteX4-200)

    setProperty('hand4.y', daY1+20)
    setProperty('hand5.y', daY2+20)
    setProperty('hand6.y', daY3+20)
    setProperty('hand7.y', daY4+20)
    if not downscroll then
        setProperty('hand4.y', daY1-220)
        setProperty('hand5.y', daY2-220)
        setProperty('hand6.y', daY3-220)
        setProperty('hand7.y', daY4-220)
    end
    if change then
        if downscroll then
            setProperty('hand4.y', daY1-220)
            setProperty('hand5.y', daY2-220)
            setProperty('hand6.y', daY3-220)
            setProperty('hand7.y', daY4-220)
        else
            setProperty('hand4.y', daY1+20)
            setProperty('hand5.y', daY2+20)
            setProperty('hand6.y', daY3+20)
            setProperty('hand7.y', daY4+20)
        end
    else
        if downscroll then
            setProperty('hand4.y', daY1+20)
            setProperty('hand5.y', daY2+20)
            setProperty('hand6.y', daY3+20)
            setProperty('hand7.y', daY4+20)
        else
            setProperty('hand4.y', daY1-220)
            setProperty('hand5.y', daY2-220)
            setProperty('hand6.y', daY3-220)
            setProperty('hand7.y', daY4-220)
        end
    end
    end
end

function onTweenCompleted(tag)
    if tag == 'Uhand4' then
        for ae = 4,7 do
        doTweenY('UBhand'..ae, 'hand'..ae, -220,0.5, 'elasticOut')
        doTweenAngle('handflip'..ae, 'hand'..ae, 90, 0.01, 'cubeInOut')
        end
    end
    if tag == 'Dhand4' then
        for ae = 4,7 do
        doTweenY('DBhand'..ae, 'hand'..ae, screenHeight - 100,0.5, 'elasticOut')
        doTweenAngle('handflip'..ae, 'hand'..ae, 270, 0.01, 'cubeInOut')
        end
    end
    if tag == 'UBhand4' then
        if not downscroll then
            change = false
        else
            change = true
        end
        enableStatic = true
        for ae = 4,7 do
            objectPlayAnimation('hand'..ae, 'close', true)
        end
    end
    if tag == 'DBhand4' then
        if not downscroll then
            change = true
        else
            change = false
        end
        enableStatic = true
        for ae = 4,7 do
        objectPlayAnimation('hand'..ae, 'close', true)
        end
    end
end
function onUpdatePost(elapsed)
    songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
end