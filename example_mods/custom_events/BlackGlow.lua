function onEvent(name, value1, value2)
	if name == "BlackGlow" then
		makeLuaSprite('imageB', 'hitmans/vignette', 0, 0);
		addLuaSprite('imageB', true);
		setObjectCamera('imageB', 'other');
		scaleObject('imageB', 1, 1)
		runTimer('waitB', value2);
		setProperty('waitB.alpha', 1)
	end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'waitB' then
		doTweenAlpha('byebyeB', 'imageB', 0, 1, 'linear');
	end
end