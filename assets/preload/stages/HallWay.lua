function onCreate()
	-- background shit
	makeAnimatedLuaSprite('hallway', 'hitmans/Bgs/Johan/Hallucination/hallway', -100, 150);
	addAnimationByPrefix('hallway', 'lights on', 'hallway-normal', 24, false)
	addAnimationByPrefix('hallway', 'lights off', 'hallway-dark', 24, false)
	scaleObject('hallway', 2, 2)
	setScrollFactor('hallway', 1, 1);

    addLuaSprite('hallway', false);
	runTimer('off', 10)
end

function onCreatePost()

	initLuaShader("chromaticAbber")
 
    setSpriteShader('hallway',"chromaticAbber")

end
 
function onUpdate()
    setShaderFloat("chromaticAbber", "iTime", os.clock())
end

function onTimerCompleted(t)
	if t == 'off' then
		objectPlayAnimation('hallway', 'lights off', true)
		runTimer('on', 0.1)
	end
	if t == 'on' then
		objectPlayAnimation('hallway', 'lights on', true)
		runTimer('off2', 0.2)
	end
	if t == 'off2' then
		objectPlayAnimation('hallway', 'lights off', true)
		runTimer('on2', 0.3)
	end
	if t == 'on2' then
		objectPlayAnimation('hallway', 'lights on', true)
		runTimer('off3', 0.1)
	end
	if t == 'off3' then
		objectPlayAnimation('hallway', 'lights off', true)
		runTimer('on4', 0.1)
	end
	if t == 'on4' then
		objectPlayAnimation('hallway', 'lights on', true)
		runTimer('off4', 0.1)
	end
	if t == 'off4' then
		objectPlayAnimation('hallway', 'lights off', true)
		runTimer('on5', 0.2)
	end
	if t == 'on5' then
		objectPlayAnimation('hallway', 'lights on', true)
		runTimer('off', 10)
	end
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('hallway', 'hallway', -50, 5, 'ExponentialOut')
end

function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag

	if tag == 'hallway' then 
		doTweenX('hallway1', 'hallway', -100, 5, 'ExponentialOut')
	end
	if tag == 'hallway1' then 
		doTweenX('hallway', 'hallway', -50, 5, 'ExponentialOut')
	end
end