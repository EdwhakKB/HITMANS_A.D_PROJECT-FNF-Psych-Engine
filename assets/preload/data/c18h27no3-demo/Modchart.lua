--modchart by EDWHAK
function onCreate()
    --addLuaScript('SimpleModchartTemplate')
    addLuaScript('ModchartTemplate')
end


local scrollSwitch = 520 --height to move to when reverse

function lerp(a, b, ratio)
	return a + ratio * (b - a)
end
function onSongStart()--for step 0

    if downscroll then 
		scrollSwitch = -520
	end
    
end

local thing = 0

function onStepHit()
    if curStep == 32 then
    setProperty('drunk.x', 1)
    setProperty('drunkSpeed.x', 2)
    end
    if curStep >= 32 and curStep <=288 then
        if curStep % 32 == 0 then
            setProperty('scale.y', 1.3)
            doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
        elseif curStep % 32 == 4 then 
            setProperty('scale.x', 1.3)
            doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
        elseif curStep % 32 == 8 then
            setProperty('scale.y', 1.3)
            doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
        elseif curStep % 32 == 12 then 
            setProperty('scale.x', 1.3)
            doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
        elseif curStep % 32 == 16 then
            setProperty('scale.y', 1.3)
            doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
        elseif curStep % 32 == 19 then 
            doTweenY('a', 'tipsy', 1, 0.01, 'cubeInOut')
        elseif curStep % 32 == 21 then 
            doTweenY('a', 'tipsy', -1, 0.01, 'cubeInOut')
        elseif curStep % 32 == 23 then 
            doTweenY('a', 'tipsy', 0, 0.01, 'cubeInOut')
        elseif curStep % 32 == 27 then 
            setProperty('scale.x', 1.3)
            doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            setProperty('scale.y', 1.3)
            doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
        end
        if curStep == 160 then
            setProperty('drunk.y', 0.5)
            setProperty('drunkSpeed.y', 3)
        end
    end
    if curStep == 304 then
        setProperty('drunk.x', 0)
        setProperty('drunkSpeed.x', 0)
        setProperty('drunk.y', 0)
        setProperty('drunkSpeed.y', 0)
    end
    if curStep >= 304 and curStep <= 560 then
        if curStep % 8 == 4 then 
            setProperty('camHUD.angle', 10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        elseif curStep % 8 == 0 then 
            setProperty('camHUD.angle', -10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        end
    end
    if curStep == 425 then
        doTweenY('rev', 'reverse', 1, 0.5, 'cubeInOut')
    end
    if curStep == 488 then
        doTweenY('rev', 'reverse', 0, 0.5, 'cubeInOut')
    end
    if curStep == 528 then
        setProperty('drunk.x', 1)
        setProperty('drunkSpeed.x', 10)
    end
    if curStep == 560 then
        setProperty('drunk.x', 0)
        setProperty('drunkSpeed.x', 0)
    end
    if curStep >= 621 and curStep <= 632 then
        if curStep % 2 == 0 then
            setProperty('scale.x', 0.8)
            doTweenX('scalex', 'scale', 0.7, 0.1, 'cubeInOut')
            setProperty('scale.y', 0.8)
            doTweenY('scaley', 'scale', 0.7, 0.1, 'cubeInOut')
        end
        if curStep % 4 == 0 then
            setProperty('camHUD.angle', -10)
        elseif curStep % 4 == 2 then
            setProperty('camHUD.angle', 10)
        end
    end
    if curStep == 688 then
        doTweenY('rev', 'reverse', 1, 0.1, 'quadOut')
    end
    if curStep >= 560 and curStep <= 620 or curStep >= 632 and curStep <= 672 or curStep >= 688 and curStep <= 715 or curStep >= 720 and curStep <= 815 then
        if curStep % 4 == 0 then
        setProperty('drunk.angle', 3)
        setProperty('drunkSpeed.angle', 4)
        doTweenAngle('t', 'drunk', 0, stepCrochet/250, 'quantInOut')
        end
        if curStep % 8 == 0 then
            setProperty('camHUD.angle', -10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        elseif curStep % 8 == 4 then
            setProperty('camHUD.angle', 10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        end
    end
    if curStep >= 715 and curStep <= 720 then
        if curStep % 1 == 0 then
            setProperty('scale.x', 0.8)
            doTweenX('scalex', 'scale', 0.7, 0.1, 'cubeInOut')
            setProperty('scale.y', 0.8)
            doTweenY('scaley', 'scale', 0.7, 0.1, 'cubeInOut')
        end
        if curStep % 2 == 0 then
            setProperty('camHUD.angle', -10)
        elseif curStep % 2 == 1 then
            setProperty('camHUD.angle', 10)
        end
    end
    if curStep == 816 then
        doTweenY('rev', 'reverse', 0, 0.1, 'quadOut')
    end
    if curStep == 848 then
        doTweenY('rev', 'reverse', 1, 0.1, 'quadOut')
    end
    if curStep == 880 then
        doTweenY('rev', 'reverse', 0, 0.1, 'quadOut')
    end
    if curStep == 912 then
        doTweenY('rev', 'reverse', 1, 0.1, 'quadOut')
    end
    if curStep == 944 then
        doTweenY('rev', 'reverse', 0, 0.1, 'quadOut')
    end
    if curStep == 976 then
        doTweenY('rev', 'reverse', 1, 0.1, 'quadOut')
    end
    if curStep == 1008 then
        doTweenY('rev', 'reverse', 0, 0.1, 'quadOut')
    end
    if curStep == 1040 then
        doTweenY('rev', 'reverse', 1, 0.1, 'quadOut')
    end
    if curStep == 1073 then
        doTweenY('rev', 'reverse', 0, 0.1, 'quadOut')
    end
    if curStep == 681 then 
        setProperty('drunk.x', 0.1)
        setProperty('drunkSpeed.x', 10)
    end

    if curStep >= 816 and curStep <= 1073 then
        if curStep % 16 == 8 then 
            setProperty('scale.y', 0.25)
            doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            setProperty('scale.x', 1)
            doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            setProperty('camHUD.angle', 10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        elseif curStep % 16 == 0 then 
            setProperty('drunk.angle', 6)
            setProperty('drunkSpeed.angle', 8)
            doTweenAngle('t', 'drunk', 0, stepCrochet/250, 'quantInOut')
            setProperty('camHUD.angle', -10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        end
    end
    if curStep == 1216 then
        setProperty('drunk.x', 0.3)
        setProperty('drunkSpeed.x', 30)
    end
    if curStep >= 1232 and curStep <= 1247 then
        if curStep % 3 == 0 then
            triggerEvent('flip', 0.01, quadOut)
        elseif curStep % 3 == 1 then
            triggerEvent('invert', 0.01, quadOut)
        elseif curStep % 3 == 2 then
            triggerEvent('resetX', 0.01, quadOut)
        end
    end
    if curStep == 1248 then
        setProperty('drunk.x', 0)
        setProperty('drunkSpeed.x', 0)
        triggerEvent('resetX', 0.01, quadOut)
    end
    if curStep >= 1248 and curStep <= 1487 then
        if curStep % 6 == 3 then 
            setProperty('scale.y', 0.25)
            doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            setProperty('scale.x', 1)
            doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
        elseif curStep % 6 == 0 then 
            setProperty('drunk.angle', 3)
            setProperty('drunkSpeed.angle', 8)
            doTweenAngle('t', 'drunk', 0, stepCrochet/250, 'quantInOut')
        end
        if curStep % 8 == 4 then
            setProperty('camHUD.angle', 10)
            setProperty('confusion.angle', 360)
            doTweenAngle('confusioned', 'confusion', 0, stepCrochet/500, 'cubeInOut')
        elseif curStep % 8 == 0 then
            setProperty('camHUD.angle', -10)
            setProperty('confusion.angle', -360)
            doTweenAngle('confusioned', 'confusion', 0, stepCrochet/500, 'cubeInOut')
        end
    end
    if curStep == 1488 then
        doTweenAngle('camHUD', 'camHUD', 0, 5, 'quadInOut')
        setProperty('drunk.x', 0.3)
        setProperty('drunkSpeed.x', 30)
    end
    if curStep == 1448 then
        setProperty('drunk.x', 0)
        setProperty('drunkSpeed.x', 0)
        setProperty('drunk.y', 1)
        setProperty('drunkSpeed.y', 5)
    end
        if curStep == 1601 then
        setProperty('drunk.x', 0)
        setProperty('drunkSpeed.x', 0)
        setProperty('drunk.y', 0)
        setProperty('drunkSpeed.y', 0)
    end
end 