--Visuals by EDWHAK
function onCreate()
    addLuaScript('hitmansModchart')
    makeAnimatedLuaSprite('Ed', 'hitmans/Edwhak', 150, 50)
    addAnimationByPrefix('Ed', 'Idle', 'Edwhak_Idle', 24, false)
    addAnimationByPrefix('Ed', 'Smile', 'Edwhak_Smile', 24, false)
    setProperty('Ed.alpha', 0)
    addLuaSprite('Ed', true)
    randomPossX = 380
    randomPossY = 100
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
        setProperty('hand'..i..'.alpha', 0)
        if downscroll then
            setProperty('hand' .. i .. '.angle', 270)
        else
            setProperty('hand' .. i .. '.angle', 90)
        end
    end
    makeAnimatedLuaSprite('alert', 'hitmans/InsanityEye', 380, 100)
    addAnimationByPrefix('alert', 'rotate', 'InsanityEye attack_alert', 24, true)
    addAnimationByPrefix('alert', 'rotateSlow', 'InsanityEye attack_alert', 14, true)
    addAnimationByPrefix('alert', 'rotateFast', 'InsanityEye attack_alert', 34, true)
    setObjectCamera('alert', 'camOTHER')
    setProperty('alert.alpha', 0)

    makeLuaSprite('flash', 'whiteFrame', 0, 0);
    addLuaSprite('flash', true);
    setObjectCamera('flash', 'other');
    scaleObject('flash', 1, 1)
    setProperty('flash.alpha', 0)

    makeLuaSprite('red', 'Inhuman/alert-vignette', 0, 0);
    addLuaSprite('red', true);
    setProperty('red.alpha', 0)
    setObjectCamera('red', 'other');
    scaleObject('red', 0.55, 0.55)
end

function onSongStart()--for step 0

    addLuaSprite('alert', true)
    setProperty('alert.alpha', 0.5)
    objectPlayAnimation('alert', 'rotateFast', true)
    objectPlayAnimation('Ed', 'Smile', true)

end

local enableStatic = true
function onStepHit() 
    if curStep == 36 then
        setProperty('alert.alpha', 0)
        setProperty('flash.alpha', 1)
        doTweenAlpha('bye','flash',0,0.5,'quadOut')
    end
    if curStep == 420 then
        setProperty('flash.alpha', 1)
        doTweenAlpha('bye','flash',0,0.5,'quadOut')
    end
    if curStep == 548 then
        setProperty('flash.alpha', 1)
        doTweenAlpha('bye','flash',0,2,'quadOut')
    end
    if curStep == 676 then
        setProperty('flash.alpha', 1)
        doTweenAlpha('bye','flash',0,0.5,'quadOut')
    end
    if curStep == 805 then
        doTweenAlpha('Hi','Ed',1,1,'easeIn')
        for i = 4,7 do
            doTweenAlpha('Hand'..i,'hand'..i,1,1.5,'easeIn')
        end
        HandScroll(false)
    end
    if curStep == 299 then
        objectPlayAnimation('Ed', 'Smile', true)
    end
    if curStep == 820 then
        setProperty('flash.alpha', 1)
        doTweenAlpha('bye','flash',0,0.5,'quadOut')
        setProperty('Ed.alpha', 0)
    end
    if curStep >= 820 and curStep <= 1588 then
        if curStep % 4 == 0 then
            scaleObject('alert', 0.7, 0.7)
            doTweenX('alertScaleX', 'alert.scale', 0.2, 0.3, 'cubeInOut')
            doTweenY('alertScaleY', 'alert.scale', 0.2, 0.3, 'cubeInOut')
            setProperty('alert.x', randomPossX)
            setProperty('alert.y', randomPossY)
        end
        if curStep % 4 == 1 then
            randomPossX = getRandomInt(20, 870)
            randomPossY = getRandomInt(20, 370)
        end
        if curStep % 4 == 0 then
            setProperty('alert.alpha', 1)
            doTweenAlpha('alertAlpha', 'alert', 0, 0.3, 'cubeInOut')
        end
    end
    if curStep == 1588 then
        setProperty('alert.x', 380)
        setProperty('alert.y', 100)
    end

    -- if curStep == 425 then
    --     HandScroll(true)
    -- end
    -- if curStep == 488 then
    --     HandScroll(false)
    -- end
    -- if curStep == 682 then
    --     HandScroll(true)
    -- end
    -- if curStep == 688 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 810 then
    --     HandScroll(false)
    -- end
    -- if curStep == 816 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 842 then
    --     HandScroll(true)
    -- end
    -- if curStep == 848 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 874 then
    --     HandScroll(false)
    -- end
    -- if curStep == 880 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 906 then
    --     HandScroll(true)
    -- end
    -- if curStep == 912 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 938 then
    --     HandScroll(false)
    -- end
    -- if curStep == 944 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 970 then
    --     HandScroll(true)
    -- end
    -- if curStep == 976 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 1002 then
    --     HandScroll(false)
    -- end
    -- if curStep == 1008 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 1034 then
    --     HandScroll(true)
    -- end
    -- if curStep == 1040 then
    --     setProperty('flash.alpha', 1)
    --     doTweenAlpha('bye','flash',0,0.5,'quadOut')
    -- end
    -- if curStep == 1071 then
    --     for i = 4,7 do
    --         doTweenAlpha('Hand'..i,'hand'..i,0,0.3,'easeIn')
    --     end
    --     HandScroll(false)
    -- end
    -- if curStep == 1073 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,1,'quadOut')
    -- end
    -- if curStep == 1089 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,1,'quadOut')
    -- end
    -- if curStep == 1105 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,1,'quadOut')
    -- end
    -- if curStep == 1121 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,1,'quadOut')
    -- end
    -- if curStep == 1137 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.5,'quadOut')
    -- end
    -- if curStep == 1145 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.5,'quadOut')
    -- end
    -- if curStep == 1153 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.5,'quadOut')
    -- end
    -- if curStep == 1161 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.5,'quadOut')
    -- end
    -- if curStep == 1169 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.3,'quadOut')
    -- end
    -- if curStep == 1173 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.3,'quadOut')
    -- end
    -- if curStep == 1177 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.3,'quadOut')
    -- end
    -- if curStep == 1169 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.3,'quadOut')
    -- end
    -- if curStep == 1181 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,0.3,'quadOut')
    -- end

    -- if curStep == 1185 then
    --     setProperty('red.alpha', 1)
    --     doTweenAlpha('back','red',0,3,'quadOut')
    -- end

    -- if curStep >= 1248 and curStep <= 1487 then

    --     if curStep % 4 == 0 then
    --         setProperty('alert.alpha', 1)
    --         doTweenAlpha('alertAlpha', 'alert', 0, 0.3, 'cubeInOut')
    --         setProperty('red.alpha', 1)
    --         doTweenAlpha('back','red',0,0.5,'quadOut')
    --         scaleObject('alert', 1, 1)
    --         doTweenX('alertScaleX', 'alert.scale', 0.5, 0.3, 'cubeInOut')
    --         doTweenY('alertScaleY', 'alert.scale', 0.5, 0.3, 'cubeInOut')
    --     end

    -- end
end 

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