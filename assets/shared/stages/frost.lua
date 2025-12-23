function onCreate()
	-- background shit
	makeAnimatedLuaSprite('Cold', 'hitmans/cold-stage', -50, 130);
	addAnimationByPrefix('Cold', 'freeze', 'cold-stage', 24, true)
	scaleObject('Cold', 0.7, 0.7)
	addAnimationByPrefix('Cold')
	setScrollFactor('Cold', 1, 1);

	makeLuaSprite('fog1', 'hitmans/cold-stage-fog1', 20, 520)
	setProperty('fog1.alpha', 0.5)
	scaleObject('fog1', 1, 1)
	setLuaSpriteScrollFactor('fog1', 1, 1)
	addLuaSprite('fog1', true)

	makeLuaSprite('fog2', 'hitmans/cold-stage-fog2', 200, 520)
	scaleObject('fog2', 1, 1)
	setProperty('fog2.alpha', 0.5)
	setLuaSpriteScrollFactor('fog2', 1, 1)
	addLuaSprite('fog2', true)

	makeLuaSprite('fog3', 'hitmans/cold-stage-fog3', 410, 520)
	setProperty('fog3.alpha', 0.5)
	scaleObject('fog3', 1, 1)
	setLuaSpriteScrollFactor('fog3', 1, 1)
	addLuaSprite('fog3', true)

	makeLuaSprite('fog4', 'hitmans/cold-stage-fog3', 320, 520)
	setProperty('fog4.alpha', 0.5)
	scaleObject('fog4', 1, 1)
	setLuaSpriteScrollFactor('fog4', 1, 1)
	addLuaSprite('fog4', true)

	makeLuaSprite('fog5', 'hitmans/cold-stage-fog1', 1000, 520)
	scaleObject('fog5', 1, 1)
	setProperty('fog5.alpha', 0.5)
	setLuaSpriteScrollFactor('fog5', 1, 1)
	addLuaSprite('fog5', true)

	makeLuaSprite('fog6', 'hitmans/cold-stage-fog2', 810, 520)
	setProperty('fog6.alpha', 0.5)
	scaleObject('fog6', 1, 1)
	setLuaSpriteScrollFactor('fog6', 1, 1)
	addLuaSprite('fog6', true)

	makeAnimatedLuaSprite('snow', 'hitmans/DaSnow', 0, 0)
    addAnimationByPrefix('snow', 'move', 'noise', 24, true)
	scaleObject('snow', 2, 2)
	updateHitbox('snow')
	setObjectCamera('snow', 'other')
	setProperty('snow.alpha', 1)
	addLuaSprite('snow', true)
	objectPlayAnimation('snow', 'move', true)

	addLuaSprite('Cold', false);
end

function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag

	if tag == 'moveA0' then 
		doTweenX('moveA1', 'fog1', 50, 6, 'ExponentialOut')
	elseif tag == 'moveA1' then
		doTweenX('moveA2', 'fog1', 90, 6, 'ExponentialOut')
	elseif tag == 'moveA2' then 
		doTweenX('moveA3', 'fog1', 50, 6, 'ExponentialOut')
	elseif tag == 'moveA3' then 
		doTweenX('moveA0', 'fog1', 20, 6, 'ExponentialOut')
	end
	if tag == 'moveB0' then 
		doTweenX('moveB1', 'fog2', 210, 4, 'ExponentialOut')
	elseif tag == 'moveB1' then
		doTweenX('moveB2', 'fog2', 220, 4, 'ExponentialOut')
	elseif tag == 'moveB2' then 
		doTweenX('moveB3', 'fog2', 210, 4, 'ExponentialOut')
	elseif tag == 'moveB3' then 
		doTweenX('moveB0', 'fog2', 200, 4, 'ExponentialOut')
	end
	if tag == 'moveC0' then 
		doTweenX('moveC1', 'fog3', 390, 2, 'ExponentialOut')
	elseif tag == 'moveC1' then
		doTweenX('moveC2', 'fog3', 370, 2, 'ExponentialOut')
	elseif tag == 'moveC2' then 
		doTweenX('moveC3', 'fog3', 390, 2, 'ExponentialOut')
	elseif tag == 'moveC3' then 
		doTweenX('moveC0', 'fog3', 410, 2, 'ExponentialOut')
	end
	if tag == 'moveD0' then 
		doTweenX('moveD1', 'fog4', 190, 6, 'ExponentialOut')
	elseif tag == 'moveD1' then
		doTweenX('moveD2', 'fog4', 160, 6, 'ExponentialOut')
	elseif tag == 'moveD2' then 
		doTweenX('moveD3', 'fog4', 190, 6, 'ExponentialOut')
	elseif tag == 'moveD3' then 
		doTweenX('moveD0', 'fog4', 320, 6, 'ExponentialOut')
	end
	if tag == 'moveE0' then 
		doTweenX('moveE1', 'fog5', 1050, 4, 'ExponentialOut')
	elseif tag == 'moveE1' then
		doTweenX('moveE2', 'fog5', 1080, 4, 'ExponentialOut')
	elseif tag == 'moveE2' then 
		doTweenX('moveE3', 'fog5', 1050, 4, 'ExponentialOut')
	elseif tag == 'moveE3' then 
		doTweenX('moveE0', 'fog5', 1000, 4, 'ExponentialOut')
	end
	if tag == 'moveF0' then 
		doTweenX('moveF1', 'fog6', 790, 2, 'ExponentialOut')
	elseif tag == 'moveF1' then
		doTweenX('moveF2', 'fog6', 770, 2, 'ExponentialOut')
	elseif tag == 'moveF2' then 
		doTweenX('moveF3', 'fog6', 790, 2, 'ExponentialOut')
	elseif tag == 'moveF3' then 
		doTweenX('moveF0', 'fog6', 810, 2, 'ExponentialOut')
	end
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('moveA1', 'fog1', 50, 6, 'ExponentialOut')
	doTweenX('moveB1', 'fog2', 210, 4, 'ExponentialOut')
	doTweenX('moveC1', 'fog3', 390, 2, 'ExponentialOut')
	doTweenX('moveD1', 'fog4', 190, 6, 'ExponentialOut')
	doTweenX('moveE1', 'fog5', 1050, 4, 'ExponentialOut')
	doTweenX('moveF1', 'fog6', 790, 2, 'ExponentialOut')
end