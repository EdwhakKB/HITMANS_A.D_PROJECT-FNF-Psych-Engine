--Visuals by EDWHAK
function onCreate()
end
local doMoveCameras = false
local enableShit = true
function onCreatePost()
    if downscroll then
        angleMultiplier = 1
        yMultiplier = -1
    end
    for i = 0,1 do
        setProperty('noteCameras'..i..'.visible', true)
    end
    for i = 0,1 do
        setProperty('noteCameras'..i..'.alpha', 0)
    end
    for i = 0,1 do
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

    if doMoveCameras then 
        local speed = 1
        setProperty('camHUD.alpha', 0.5)
    else
        setProperty('camHUD.alpha', 1)
    end
end

function onBeatHit()
    if curBeat == 192 then
        doMoveCameras = true
        setProperty('noteCameras0.angle', -10)
        setProperty('noteCameras1.angle', 10)
    end
    if curBeat == 238 then
        doMoveCameras = false
        enableShit = false
    end
    if curBeat >= 192 then
        if curBeat % 4 == 0 then
            doAlphas(1)
        elseif curBeat %4 == 2 then
            doAlphas(2)
        end
    end
end

function onUpdatePost(elapsed)
    songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
end

function doAlphas(value)
    if enableShit then
        if value == 1 then
            setProperty('noteCameras1.alpha', 1)
            doTweenAlpha('note1', 'noteCameras1', 0, 0.5, 'easeOut')
        elseif value == 2 then
            setProperty('noteCameras0.alpha', 1)
            doTweenAlpha('note2', 'noteCameras0', 0, 0.5, 'easeOut')
        end
    end
end