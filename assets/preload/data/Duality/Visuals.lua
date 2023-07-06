--Visuals by EDWHAK
function onCreate()

end

function onCreatePost()
    makeLuaSprite('flash', 'whiteFrame', 0, 0);
    addLuaSprite('flash', true);
    setObjectCamera('flash', 'other');
    scaleObject('flash', 1, 1)
    setProperty('flash.alpha', 0)

    makeLuaSprite('red', 'hitmans/alert-vignette', 0, 0);
    addLuaSprite('red', true);
    setProperty('red.alpha', 0)
    setObjectCamera('red', 'other');
    scaleObject('red', 0.55, 0.55)
end

function onSongStart()--for step 0

end

function onStepHit() 

end 

function onUpdatePost(elapsed)
    songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
end