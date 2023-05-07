--Visuals by EDWHAK
function onCreate()

end
function onCreatePost()

end

function onSongStart()--for step 0
    local extraFile = dofile('scripts/PincersCode.lua')
end

function onStepHit() 
    if curStep == 1528 then
        setProperty('MommyPincer4.alpha',1)
        setProperty('MommyPincer5.alpha',1)
        setProperty('MommyPincer6.alpha',1)
        setProperty('MommyPincer7.alpha',1)
    end
    if curStep == 2044 then
        setProperty('MommyPincer4.alpha',1)
        setProperty('MommyPincer7.alpha',1)
    end
end 

function onUpdatePost(elapsed)
    songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
end