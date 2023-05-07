--modchart by EDWHAK
function onCreate()
    addLuaScript('SimpleModchartTemplate')
end


local scrollSwitch = 520 --height to move to when reverse
local noteXCenter = {412,524,636,748}-- Notes center : 0 , 1 , 2 , 3
local noteYPlace = {50,570} -- Up , Down
function lerp(a, b, ratio)
	return a + ratio * (b - a)
end
function onSongStart()--for step 0

    if downscroll then 
		scrollSwitch = -520
	end
    
end

function onUpdate(elapsed)
    songPos = getSongPosition()
    currentBeat = (songPos / 1000) * (bpm / 60)
end

local thing = 0

function onStepHit()

end 