function onSongStart()
    x0 = defaultPlayerStrumX0
    x1 = defaultPlayerStrumX1
    x2 = defaultPlayerStrumX2
    x3 = defaultPlayerStrumX3
    strumLineY = getProperty('strumLine.y')
    doTweenAlpha('theshit', 'imageK', 0, 4, 'expIn');
end
function onCreatePost()
    makeLuaSprite('imageK', 'flash', 0, 0);
    addLuaSprite('imageK', true);
    setObjectCamera('imageK', 'other');
    setProperty('imageK.alpha', 0)
end

function onCountdownTick(counter)
	if counter == 0 then
    setProperty('imageK.alpha', 1)
    end
	if counter == 1 then
        triggerEvent('EnableEventModchart', 0, false)
    end
    if counter == 2 then

    end
    if counter == 3 then

    end
    if counter == 4 then
        outroFade(0)
        outroFade(1)
        outroFade(2)
        outroFade(3)
        outroFade(4)
        outroFade(5)
        outroFade(6)
        outroFade(7)
    end
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
end


function introFade(strum)
    if strum >= 4 then
        noteTweenAlpha("intro-alpha-player" .. strum, strum, 1, 4, "easeIn")
        noteTweenY("intro-y-player" .. strum, strum, strumLineY, 4, "easeOut")
    else
        noteTweenAlpha("intro-alpha-opponent" .. strum, strum, 0.5, 4, "easeOut")
        noteTweenY("intro-y-opponent" .. strum, strum, strumLineY, 4, "easeOut")
    end

    return true
end

function outroFade(strum)
    if strum >= 4 then
        noteTweenAlpha("intro-alpha-player" .. strum, strum, 0, crochet / 250, "circOut")
    else
        noteTweenAlpha("intro-alpha-opponent" .. strum, strum, 0, crochet / 250, "circOut")
    end

    return true
end

function fastSin(n)
    return math.sin(n * math.pi)
end

function pincerPrepare(strum, goAway)
    local strumX = getPropertyFromGroup('strumLineNotes', (strum + 4) % 8, 'x')
    local strumY = getPropertyFromGroup('strumLineNotes', (strum + 4) % 8, 'y')

    removeLuaSprite('pincer' .. (strum % 4), true)
    makeLuaSprite('pincer' .. (strum % 4), 'hitmans/hackhand-open', strumX, strumY)
    setLuaSpriteScrollFactor('pincer' .. (strum % 4), 0, 0)
    setObjectCamera('pincer' .. (strum % 4), 'camHUD')
    addLuaSprite('pincer' .. (strum % 4), true)

    if downscroll then
        setProperty('pincer' .. (strum % 4) .. '.angle', 270)
        setProperty('pincer' .. (strum % 4) .. '.offset.x', 192)
        setProperty('pincer' .. (strum % 4) .. '.offset.y', -75)
        setProperty('pincer' .. (strum % 4) .. '.visible', true)
    else
        setProperty('pincer' .. (strum % 4) .. '.angle', 40)
        setProperty('pincer' .. (strum % 4) .. '.offset.x', 218)
        setProperty('pincer' .. (strum % 4) .. '.offset.y', 240)
        setProperty('pincer' .. (strum % 4) .. '.visible', true)
    end

    if downscroll then
        if not goAway then
            setProperty('pincer' .. (strum % 4) .. '.y', strumY + 500)
            doTweenY('pincer' .. strum .. '-enter', 'pincer' .. (strum % 4), strumY, crochet / 500, 'elasticOut')
        else
            doTweenY('pincer' .. strum .. '-leaving', 'pincer' .. (strum % 4), strumY + 500, crochet / 500, 'elasticInOut')
        end
    else
        if not goAway then
            setProperty('pincer' .. (strum % 4) .. '.y', strumY - 500)
            doTweenY('pincer' .. strum .. '-enter', 'pincer' .. (strum % 4), strumY, crochet / 500, 'elasticOut')
        else
            doTweenY('pincer' .. strum .. '-leaving', 'pincer' .. (strum % 4), strumY - 500, crochet / 500, 'elasticInOut')
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'pincer0-leaving' then
        setProperty('pincer0.visible', false)
        removeLuaSprite('pincer0', true)
    elseif tag == 'pincer1-leaving' then
        setProperty('pincer1.visible', false)
        removeLuaSprite('pincer1', true)
    elseif tag == 'pincer2-leaving' then
        setProperty('pincer2.visible', false)
        removeLuaSprite('pincer2', true)
    elseif tag == 'pincer3-leaving' then
        setProperty('pincer3.visible', false)
        removeLuaSprite('pincer3', true)
    elseif tag == 'pincer4-leaving' then
        setProperty('pincer0.visible', false)
        removeLuaSprite('pincer0', true)
    end
end

function pincerGrab(pincer)
    pincer = pincer % 4

    local x = getProperty('pincer' .. pincer .. '.x')
    local y = getProperty('pincer' .. pincer .. '.y')

    removeLuaSprite('pincer' .. pincer, true)
    makeLuaSprite('pincer' .. pincer, 'hitmans/hackhand-closed', x, y)
    setLuaSpriteScrollFactor('pincer' .. pincer, 0, 0)
    setObjectCamera('pincer' .. pincer, 'camHUD')

    if downscroll then
        setProperty('pincer' .. pincer .. '.angle', 270)
        setProperty('pincer' .. pincer .. '.offset.x', 192)
        setProperty('pincer' .. pincer .. '.offset.y', -75)
    else
        setProperty('pincer' .. pincer .. '.angle', 40)
        setProperty('pincer' .. pincer .. '.offset.x', 218)
        setProperty('pincer' .. pincer .. '.offset.y', 240)
    end

    addLuaSprite('pincer' .. pincer, true)
    setProperty('pincer' .. pincer .. '.visible', true)
end

function AmovePincerX(pincer, toX)
    pincer = pincer % 4

    doTweenX('pincer' .. pincer .. '-moveX', 'pincer' .. pincer, toX, 10, 'circOut')
    noteTweenX('strum' .. (pincer + 4) .. '-moveX', pincer + 4, toX, 10, 'circOut')

    return true
end

function AmovePincerY(pincer, toY)
    pincer = pincer % 4

    doTweenY('pincer' .. pincer .. '-moveY', 'pincer' .. pincer, toY, 10, 'circOut')
    noteTweenY('strum' .. (pincer + 4) .. '-moveY', pincer + 4, toY, 10, 'circOut')

    return true
end

function movePincerX(pincer, toX)
    pincer = pincer % 4

    doTweenX('pincer' .. pincer .. '-moveX', 'pincer' .. pincer, toX, 0.5, 'elasticOut')
    noteTweenX('strum' .. (pincer + 4) .. '-moveX', pincer + 4, toX, 0.5, 'elasticOut')

    return true
end

function movePincerY(pincer, toY)
    pincer = pincer % 4

    doTweenY('pincer' .. pincer .. '-moveY', 'pincer' .. pincer, toY, 0.5, 'elasticOut')
    noteTweenY('strum' .. (pincer + 4) .. '-moveY', pincer + 4, toY, 0.5, 'elasticOut')

    return true
end

function BmovePincerX(pincer, toX)
    pincer = pincer % 4

    doTweenX('pincer' .. pincer .. '-moveX', 'pincer' .. pincer, toX, 1, 'elasticOut')
    noteTweenX('strum' .. (pincer + 4) .. '-moveX', pincer + 4, toX, 1, 'elasticOut')

    return true
end

function BmovePincerY(pincer, toY)
    pincer = pincer % 4

    doTweenY('pincer' .. pincer .. '-moveY', 'pincer' .. pincer, toY, 1, 'elasticOut')
    noteTweenY('strum' .. (pincer + 4) .. '-moveY', pincer + 4, toY, 1, 'elasticOut')

    return true
end

function CmovePincerX(pincer, toX)
    pincer = pincer % 4

    doTweenX('pincer' .. pincer .. '-moveX', 'pincer' .. pincer, toX, 0.02, 'easeIn')
    noteTweenX('strum' .. (pincer + 4) .. '-moveX', pincer + 4, toX, 0.02, 'easeIn')

    return true
end

function CmovePincerY(pincer, toY)
    pincer = pincer % 4

    doTweenY('pincer' .. pincer .. '-moveY', 'pincer' .. pincer, toY, 0.02, 'easeIn')
    noteTweenY('strum' .. (pincer + 4) .. '-moveY', pincer + 4, toY, 0.02, 'easeIn')

    return true
end

function DmovePincerX(pincer, toX)
    pincer = pincer % 4

    doTweenX('pincer' .. pincer .. '-moveX', 'pincer' .. pincer, toX, 10, 'elasticOut')
    noteTweenX('strum' .. (pincer + 4) .. '-moveX', pincer + 4, toX, 10, 'elasticOut')

    return true
end

function DmovePincerY(pincer, toY)
    pincer = pincer % 4

    doTweenY('pincer' .. pincer .. '-moveY', 'pincer' .. pincer, toY, 10, 'elasticOut')
    noteTweenY('strum' .. (pincer + 4) .. '-moveY', pincer + 4, toY, 10, 'elasticOut')

    return true
end


function rotatePincer(pincer, toAngle)
    pincer = (pincer % 4) + 4

    local oldAngle = 90
    if downscroll then
        oldAngle = 270
    end

    noteTweenAngle('strum' .. pincer .. '-rotate', pincer, toAngle, crochet / 1000, 'circInOut')

    return true
end

function resetToOriginalX(strum)
    strum = strum % 4

    if strum == 0 then
        movePincerX(strum, x0)
    elseif strum == 1 then
        movePincerX(strum, x1)
    elseif strum == 2 then
        movePincerX(strum, x2)
    elseif strum == 3 then
        movePincerX(strum, x3)
    end

    return true
end

function resetToOriginalY(strum)
    strum = strum % 4

    movePincerY(strum, strumLineY)

    return true
end

function resetToOriginalAngle(strum)
    strum = strum % 4

    rotatePincer(strum, 0)

    return true
end

--This is optional if you want screen shake LOL
-------DELETE THE '--' TO MAKE THIS CODE WORK AND CHANGE THE '--[[yourBeat]]' TO YOUR BEAT (XDDDD)

function onCreate()
    if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
        setPropertyFromClass('ClientPrefs', 'middleScroll', true)
    end
    if not middlescroll then
        restartSong(true);
    end
end

function onEndSong()
    return Function_Continue
end

function onStepHit()

end

--If you want copy the sections, only if you want more than 3 pincer movements!!!
function onBeatHit()
    if curBeat == 1 then
        introFade(4)
        if not downscroll then
            for strum = 0,7 do
                noteTweenY("intro-y-" .. strum, strum, strumLineY-50, 0.001, "easeOut")
            end
        elseif downscroll then
            for strum = 0,7 do
                noteTweenY("intro-y-" .. strum, strum, strumLineY+50, 0.001, "easeOut")
            end
        end
    elseif curBeat == 17 then
        introFade(5)
    elseif curBeat == 33 then
        introFade(6)
    elseif curBeat == 49 then
        introFade(7)
    elseif curBeat == 65 then
        introFade(0)
    elseif curBeat == 81 then
        introFade(1)
    elseif curBeat == 97 then
        introFade(2)
    elseif curBeat == 113 then
        introFade(3)
    elseif curBeat == 902 then
        outroFade(3)
        outroFade(2)
        outroFade(1)
        outroFade(0)
        outroFade(4)
        outroFade(5)
        outroFade(6)
        outroFade(7)
        setProperty('Static.alpha', 1)
        objectPlayAnimation('Static', 'show', true)
    end
end

--Good luck player!! I wish you the best experience and easy code!!! 
--ATT: Edwhak_KB
--        if downscroll then

--        else

--        end

function onUpdate(elapsed)
    local currentBeat = getSongPosition() / crochet

    -- if curBeat >= 680 and curBeat < 737 then
    --     local danced = getProperty('gf.danced')
    --     local angle = math.abs(fastSin(currentBeat))

    --     if danced then
    --         setProperty('camHUD.angle', 24 * angle)
    --     else
    --         setProperty('camHUD.angle', -24 * angle)
    --     end
    -- elseif curBeat >= 737 and curBeat < 739 then
    --     if getProperty('camHUD.angle') ~= 0 then
    --         setProperty('camHUD.angle', 0)
    --     end
    -- end
end

function changeScroll(strum,downscrollMode)
    if not downscrollMode then
    noteTweenY('NoteGoUpPlayerY'.. strum .. '-toUp', strum,50,0.2, 'linear')
    setPropertyFromGroup('strumLineNotes', strum,'downScroll',false)
    end
    if downscrollMode then
    noteTweenY('NoteGoDownPlayerY'.. strum .. '-toDown', strum,screenHeight - 150,0.2,'linear')
    setPropertyFromGroup('strumLineNotes', strum,'downScroll',true)
    end
end
function resetToDefaultStrum(strum)
    resetToOriginalY(0)
    resetToOriginalY(1)
    resetToOriginalY(2)
    resetToOriginalY(3)
    if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',true)
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',true)
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',true)
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',true)
    elseif getPropertyFromClass('ClientPrefs', 'downScroll') == false then
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',false)
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',false)
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',false)
        setPropertyFromGroup('strumLineNotes', strum,'downScroll',false)
    end
end

function pincerBounce(strum,bounce)
    if downscroll and not bounce then
        BmovePincerY(strum, strumLineY - 90)
    elseif not downscroll and not bounce then
        BmovePincerY(strum, strumLineY + 90)
    end
    if downscroll and bounce then
        CmovePincerY(strum, strumLineY)
    elseif not downscroll and bounce then
        CmovePincerY(strum, strumLineY)
    end
end

function pincerBounceX(bounceX)
    if bounceX then
        CmovePincerX(0, x0 - 90)
        CmovePincerX(1, x1 - 45)
        CmovePincerX(2, x2 + 45)
        CmovePincerX(3, x3 + 90)
    end
    if not bounceX then
        movePincerX(0, x0)
        movePincerX(1, x1)
        movePincerX(2, x2)
        movePincerX(3, x3)
    end
end

function onEvent(n, v1, v2)
    if n == 'PincerThings' then
        if v1 == 'prepare' then
            pincerPrepare(v2, false)
        end
        if v1 == 'gone' then
            pincerPrepare(v2, true)
        end
        if v1 == 'grab' then
            pincerGrab(v2)
        end
    end
    if n == 'PincerMoveY' then
        movePincerY(v1, strumLineY + v2)
    end
    if n == 'BounceArrows' then
        pincerBounce(0, true)
        pincerBounce(1, true)
        pincerBounce(2, true)
        pincerBounce(3, true)
        runTimer('arrowBounceY', 0.03)
    end
    if n == 'BounceArrowsX' then
        pincerBounceX(true)
        pincerBounceX(true)
        pincerBounceX(true)
        pincerBounceX(true)
        runTimer('arrowBounceX', 0.03)
    end
end

function onTimerCompleted(tag)
    if tag == 'arrowBounceY' then
        pincerBounce(0, false)
        pincerBounce(1, false)
        pincerBounce(2, false)
        pincerBounce(3, false)
    end
    if tag == 'arrowBounceX' then
        pincerBounceX(false)
        pincerBounceX(false)
        pincerBounceX(false)
        pincerBounceX(false)
    end
end