--Visuals by EDWHAK
function onCreate()

end
local startnoteCamerasX = {-400, 400, -400, 400, 0, 400, 0, -400}
local angleMultiplier = -1
local yMultiplier = 1
local moveXInfinite = false
local altXInfinite = false
local hellMode = false
local doMovesIn = false
local xOffset = 0
local xOffset2 = 0
local spinAngle = 0
function onCreatePost()
    if downscroll then
        angleMultiplier = 1
        yMultiplier = -1
    end
    for i = 0,15 do
        setProperty('noteCameras'..i..'.visible', true)
    end
    for i = 0,15 do
        setProperty('noteCameras'..i..'.alpha', 0)
    end
    for i = 0,15 do
        setProperty('noteCameras'..i..'.angle', 0)
    end
end

function onSongStart()--for step 0

end

function onStepHit() 

end 

function onUpdate(elapsed)

    if getProperty('isDead') then --stop crashing lol
        return
    end

    if doMovesIn then 
        local speed = 1 

        if moveXInfinite then 
            xOffset = (xOffset + elapsed*crochet*2*speed) % (screenWidth)
        else 
            xOffset = 0
        end

        if altXInfinite then 
            xOffset = (xOffset - elapsed*crochet*2.5*speed) % (screenWidth)
        end

        if BOTHXInfinite then 
            xOffset2 = (xOffset2 - elapsed*crochet*2.5*speed) % (screenWidth)
        -- else
        --     xOffset2 = 0
        end

        for i = 0,7 do
            local xpos = xOffset + (448*0.36*i)
            -- end
            if xpos < -screenWidth then --wrapping shi
                xpos = xpos + screenWidth
            end
            if xpos > screenWidth then 
                xpos = xpos - screenWidth
            end
            if moveXInfinite then 
                xpos = xpos - (screenWidth/2)
                setProperty('noteCameras'..i..'.alpha', 1)
            end
            setProperty('noteCameras'..i..'.x', xpos)

        end
        for i = 8,21 do
            local xpos2 = xOffset2 - (224*0.72*i)

            if xpos2 < -screenWidth then --wrapping shi
                xpos2 = xpos2 + screenWidth
            end
            if xpos2 > screenWidth then 
                xpos2 = xpos2 - screenWidth
            end
            if BOTHXInfinite then 
                xpos2 = xpos2 + (screenWidth/2)
                setProperty('noteCameras8.alpha', 0.8)
                setProperty('noteCameras8.zoom', 0.75)
                setProperty('noteCameras10.alpha', 0.8)
                setProperty('noteCameras10.zoom', 0.75)
                setProperty('noteCameras12.alpha', 0.8)
                setProperty('noteCameras12.zoom', 0.75)
                setProperty('noteCameras14.alpha', 0.8)
                setProperty('noteCameras14.zoom', 0.75)
            else
                setProperty('noteCameras'..i..'.alpha', 0)
            end

            setProperty('noteCameras'..i..'.x', xpos2)
            
            -- setProperty('noteCameras21.alpha', 0.5)

            -- setProperty('noteCameras'..i..'.alpha', 0.5)
        end
        setProperty('camHUD.alpha', 0)
        for i = 0,3 do 
            setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
        end
    
        for i = 0, getProperty('notes.length')-1 do 
            if not getPropertyFromGroup('notes', i, 'mustPress') then 
                setPropertyFromGroup('notes', i, 'alpha', 0)
            end
        end
    else
        setProperty('camHUD.alpha', 1)
    end
end
function onBeatHit()
    if curBeat == 820 then
        for i = 0,7 do
            setProperty('noteCameras'..i..'.x', startnoteCamerasX[i+1])
            doTweenZoom('noteCamerasz'..i, 'noteCameras'..i, 0.4, (stepCrochet/1000)*4, 'cubeInOut')
        end
        for i = 8,15 do
            for var = 0,7 do
                setProperty('noteCameras'..i..'.x', startnoteCamerasX[var+1])
            end
        end
    end
    if curBeat == 825 then --825
        doMovesIn = true
        moveXInfinite = true
        BOTHXInfinite = true
        -- for i = 0,7 do
        --     if getProperty('noteCameras'..i..'.x')+(screenWidth/2) > (screenWidth/2) then 
        --         doTweenX('noteCamerasx'..i, 'noteCameras'..i, 1500, (stepCrochet/1000)*16, 'cubeInOut')
        --     else 
        --         doTweenX('noteCamerasx'..i, 'noteCameras'..i, -1500, (stepCrochet/1000)*16, 'cubeInOut')
        --     end
        -- end
    end
end

function onUpdatePost(elapsed)
    songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
end