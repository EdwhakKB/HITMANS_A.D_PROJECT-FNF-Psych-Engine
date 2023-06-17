--Idea and Code by EDWHAK
--Very low effot

local stepsMoment = 4 -- to avoid bugs
local firstStop = false

function onEvent(n, v1, v2)
    if n == 'JumpNote' then
        stepsMoment = v1 --basic mode to make the step function work lmao
        if v2 == 'disable' then 
            enableJump = false
            firstStop = true
        elseif v2 == 'enable' then
            firstStop = false
            enableJump = true
        end
        if v1 == '' then
            stepsMoment = 4
        end
    end
end

function onStepHit()
    if enableJump and not firstStop then
        if curStep % stepsMoment == stepsMoment-1 then
			
        triggerEvent('Change Scroll Speed', 0.3, 0.076)
        
        elseif curStep % stepsMoment == 0 then
    
        triggerEvent('Change Scroll Speed', 1, 0.230)
        
        end
    elseif not enableJump and firstStop then
        triggerEvent('Change Scroll Speed', 1, 0.230)
        firstStop = false
    end
end