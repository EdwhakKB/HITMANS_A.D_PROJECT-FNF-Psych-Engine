--da edkb code
function onCreatePost()

	makeAnimatedLuaSprite('imageRed3', 'hitmans/Cry', -130, -30);
	addAnimationByPrefix('imageRed3', 'cry', 'Cry', 24, true);
	setObjectCamera('imageRed3', 'other');
	scaleObject('imageRed3', 1.1, 1.1)
	setProperty('imageRed3.alpha', 0)
	addLuaSprite('imageRed3', true)

end

function onEvent(name, v1, v2)
	if name == "RedImagesKill" then
	if v1 == '1' then
		setProperty('imageRed3.alpha', 1)
		objectPlayAnimation('imageRed3', 'cry', true);
		runTimer('cry', v2)
	end
end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'cry' then
		doTweenAlpha('byebye3', 'imageRed3', 0, 0.01, 'linear');
	end
end
