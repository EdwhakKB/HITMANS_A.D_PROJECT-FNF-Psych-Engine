
function onStepHit()
    if curStep >= 819 and curStep <= 1587 then
        if curStep % 8 == 4 then 
            setProperty('camHUD.angle', 10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        elseif curStep % 8 == 0 then 
            setProperty('camHUD.angle', -10)
            doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
        end
    end
end