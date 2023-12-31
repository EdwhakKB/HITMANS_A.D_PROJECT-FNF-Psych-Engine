function onCreate()
	setProperty('skipCountdown', true)

	makeAnimatedLuaSprite('bg', 'inhumanPack/background/bg', 0, 0);
	addAnimationByPrefix('bg', 'pulse', 'kbBACK-pulse', 24, false)
	setProperty('bg.color', getColorFromHex('2D4B82'))
	addLuaSprite('bg', false);
	setScrollFactor('bg', 0, 0);
	screenCenter('bg');
	setProperty('bg.alpha', 0)

	makeAnimatedLuaSprite('amelia', 'inhumanPack/ameliaTaunt', 0, 0)
	addAnimationByPrefix('amelia', 'idle', 'Amelia_Chuckle', 24, true)
	addAnimationByPrefix('amelia', 'laugh', 'Amelia_Laugh', 30, true)
	scaleObject('amelia', 0.7, 0.7)
	setProperty('amelia.alpha', 0)
	screenCenter('amelia')
	setProperty('amelia.x', getProperty('amelia.x')+50)
	addLuaSprite('amelia', true)

	makeLuaSprite('vignette', 'inhumanPack/background/vignette', 0, 0);
	addLuaSprite('vignette', false);
	setScrollFactor('vignette', 0, 0);
	screenCenter('vignette');
	setProperty('vignette.alpha', 0)
	
	makeLuaSprite('fog0', 'inhumanPack/background/elements/fogEffectTEST1', -300, 150)
	setProperty('fog0.alpha', 0)
	scaleObject('fog0', 1, 1)
	setScrollFactor('fog0', 0, 0)
	addLuaSprite('fog0', false)
	makeLuaSprite('fog1', 'inhumanPack/background/elements/fogEffectTEST1', -100, 150)
	setProperty('fog1.alpha', 0)
	scaleObject('fog1', 1, 1)
	setScrollFactor('fog1', 0, 0)
	addLuaSprite('fog1', false)
	makeLuaSprite('fog2', 'inhumanPack/background/elements/fogEffectTEST2', 0, 150)
	scaleObject('fog2', 1, 1)
	setProperty('fog2.alpha', 0)
	setScrollFactor('fog2', 0, 0)
	addLuaSprite('fog2', false)
	makeLuaSprite('fog3', 'inhumanPack/background/elements/fogEffectTEST3', 100, 150)
	setProperty('fog3.alpha', 0)
	scaleObject('fog3', 1, 1)
	setScrollFactor('fog3', 0, 0)
	addLuaSprite('fog3', false)
	makeLuaSprite('fog4', 'inhumanPack/background/elements/fogEffectTEST3', 200, 150)
	setProperty('fog4.alpha', 0)
	scaleObject('fog4', 1, 1)
	setScrollFactor('fog4', 0, 0)
	addLuaSprite('fog4', false)
	makeLuaSprite('fog5', 'inhumanPack/background/elements/fogEffectTEST1', 600, 150)
	scaleObject('fog5', 1, 1)
	setProperty('fog5.alpha', 0)
	setScrollFactor('fog5', 0, 0)
	addLuaSprite('fog5', false)
	makeLuaSprite('fog6', 'inhumanPack/background/elements/fogEffectTEST2', 400, 150)
	setProperty('fog6.alpha', 0)
	scaleObject('fog6', 1, 1)
	setScrollFactor('fog6', 0, 0)
	addLuaSprite('fog6', false)
	makeLuaSprite('fog7', 'inhumanPack/background/elements/fogEffectTEST2', 800, 150)
	setProperty('fog7.alpha', 0)
	scaleObject('fog7', 1, 1)
	setScrollFactor('fog7', 0, 0)
	addLuaSprite('fog7', false)
	
	setProperty('camHUD.alpha', 0)
end


function onUpdate(elapsed)
    -- this really helps to make true fog
    beat = (getPropertyFromClass('Conductor', 'songPosition')/1000) * (bpm / 120)
	for i = 0,7 do 
		setProperty('fog'..i..'.x', getProperty('fog'..i..'.x') + 0.1 * math.cos(((beat/10) + i) * math.pi))
	end
end

function onSongStart()
	doTweenAlpha('bgA', 'bg', 1, 100, 'sineInOut')
	for i = 0,7 do 
		doTweenAlpha('fog'..i..'A', 'fog'..i, 0.5, 100, 'sineInOut')
	end
end

PULSE = false
function onBeatHit()
    if PULSE == true then
		if flashingLights then
		   if curBeat % 1 == 0 then
			  playAnim('bg', 'pulse', false)
		   end
		end
	  end

	if curBeat == 124 then
		cancelTween('bgA')
		setProperty('bg.alpha', 0.5)
		for i = 0,7 do 
			cancelTween('fog'..i..'A')
			setProperty('fog'..i..'.alpha', 0.25)
		end
		setProperty('amelia.alpha', 1)
		playAnim('amelia', 'idle', false);
		setProperty('vignette.alpha', 1)
	end
	if curBeat == 128 then
		setProperty('bg.alpha', 1)
		for i = 0,7 do 
			setProperty('fog'..i..'.alpha', 0.5)
		end
		setProperty('amelia.alpha', 0)
		setProperty('vignette.alpha', 0)
	end
	if curBeat == 444 then
		setProperty('amelia.alpha', 1)
		playAnim('amelia', 'idle', false);
		setProperty('vignette.alpha', 1)
	end
	if curBeat == 447 then
		PULSE = true
	end
	if curBeat == 448 then
		setProperty('amelia.alpha', 0)
		setProperty('vignette.alpha', 0)
	end
	if curBeat == 510 then
		-- setProperty('amelia.x', 495)
		setProperty('amelia.alpha', 1)
		playAnim('amelia', 'laugh', false);
		setProperty('vignette.alpha', 1)
		PULSE = false
	end
	if curBeat == 511 then
		PULSE = true
	end
	if curBeat == 512 then
		setProperty('amelia.alpha', 0)
		setProperty('vignette.alpha', 0)
	end
	if curBeat == 574 then
		PULSE = false
	end
	if curBeat == 575 then
		PULSE = true
	end
	if curBeat == 640 then
		doTweenAlpha('bgA', 'bg', 0, 5, 'sineInOut')
		for i = 0,7 do 
			doTweenAlpha('fog'..i..'A', 'fog'..i, 0, 5, 'sineInOut')
		end
		PULSE = false
	end
	if curBeat == 648 then
		doTweenAlpha('bgA', 'bg', 0, 1, 'sineInOut')
		for i = 0,7 do 
			doTweenAlpha('fog'..i..'A', 'fog'..i,0, 1, 'sineInOut')
		end
	end
end