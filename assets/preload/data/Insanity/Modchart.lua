--modchart by EDWHAK
function onCreate()
    addLuaScript('SimpleModchartTemplate')
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
    if curStep >= 1408 and curStep <= 1790 then
        if curStep % 8 == 4 then 
            setProperty('scale.y', 0.25)
            doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            setProperty('scale.x', 1)
            doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            setProperty('camHUD.angle', 10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        elseif curStep % 8 == 0 then 
            setProperty('drunk.angle', 6)
            setProperty('drunkSpeed.angle', 8)
            doTweenAngle('t', 'drunk', 0, stepCrochet/250, 'quantInOut')
            setProperty('camHUD.angle', -10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        end
    end
    if curStep >= 2176 and curStep <= 2300 then
        setProperty('drunk.x', 1)
        setProperty('drunkSpeed.x', 5)
    end
    if curStep == 2302 then
        setProperty('drunk.x', 0)
        setProperty('drunkSpeed.x', 0)
    end
end 