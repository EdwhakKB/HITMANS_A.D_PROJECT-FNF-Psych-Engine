--Visuals by EDWHAK
function onCreate()

end
local angleMultiplier = -1
local yMultiplier = 1
function onCreatePost()
    if downscroll then
        angleMultiplier = 1
        yMultiplier = -1
    end
    for i = 0,3 do
        setProperty('noteCameras'..i..'.visible', true)
    end
    for i = 0,3 do
        setProperty('noteCameras'..i..'.alpha', 0)
    end

    setProperty('noteCameras0.angle', 0)
    setProperty('noteCameras0.y', -600 * yMultiplier)
    setProperty('noteCameras0.x', -400)

    setProperty('noteCameras1.angle', 90 * angleMultiplier)
    setProperty('noteCameras1.y', 130)
    setProperty('noteCameras1.x', -600)

    setProperty('noteCameras2.angle', 180)
    setProperty('noteCameras2.y', 600 * yMultiplier)
    setProperty('noteCameras2.x', 400)

    setProperty('noteCameras3.angle', 270 * angleMultiplier)
    setProperty('noteCameras3.y', -130)
    setProperty('noteCameras3.x', 600)
end

function onSongStart()--for step 0

end

function onStepHit() 

end 

function onBeatHit()
    if curBeat == 512 then
        setProperty('camHUD.visible', false)
        doTweenAlpha('Camera0a', 'noteCameras0', 1, 0.5, 'easeOut')
        doTweenY('Camera0y', 'noteCameras0', 0, 1, 'smoothStepOut')
        doTweenX('Camera0x', 'noteCameras0', 400, 2.5, 'smoothStepOut')
    end
    if curBeat == 517 then
        doTweenAlpha('Camera0a', 'noteCameras0', 0, 0.5, 'easeOut')
        doTweenY('Camera0y', 'noteCameras0', -600 * yMultiplier, 1, 'smoothStepOut')

        doTweenAlpha('Camera2a', 'noteCameras2', 1, 0.5, 'easeOut')
        doTweenY('Camera2y', 'noteCameras2', 0, 0.6, 'smoothStepOut')
        doTweenX('Camera2x', 'noteCameras2', -400, 1.7, 'smoothStepOut')
    end
    if curBeat == 520 then
        doTweenAlpha('Camera2a', 'noteCameras2', 0, 0.5, 'easeOut')
        doTweenY('Camera2y', 'noteCameras2', 600 * yMultiplier, 1, 'smoothStepOut')

        doTweenAlpha('Camera3a', 'noteCameras3', 1, 0.5, 'easeOut')
        doTweenY('Camera3y', 'noteCameras3', 130, 2.5, 'smoothStepOut')
        doTweenX('Camera3x', 'noteCameras3', 200, 1, 'smoothStepOut')
    end
    if curBeat == 525 then
        doTweenAlpha('Camera3a', 'noteCameras3', 0, 0.5, 'easeOut')
        doTweenX('Camera3x', 'noteCameras3', 600, 1, 'smoothStepOut')

        doTweenAlpha('Camera1a', 'noteCameras1', 1, 0.5, 'easeOut')
        doTweenY('Camera1y', 'noteCameras1', -130, 2.5, 'smoothStepOut')
        doTweenX('Camera1x', 'noteCameras1', -200, 1, 'smoothStepOut')
    end
end
local stopzoom = false
function onUpdate(elapsed)
    if curBeat >= 64 and curBeat <= 192 then
        doTweenZoom('bruhZ', 'camHUD', 0.8, 1, 'easeOut')
        stopzoom = true
    elseif curBeat >= 192 then
        stopzoom = false
    end
    if stopzoom then
        setProperty('camZooming', false)
    else
        setProperty('camZooming', true) 
    end
end

function onUpdatePost(elapsed)
    songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
end