function onCreate() -- from IceBeat
	makeLuaSprite('ForgottenEffect', nil, -700, -500);
	makeGraphic('ForgottenEffect', screenWidth * 2, screenHeight * 2, 'FFFFFF');
	setScrollFactor('ForgottenEffect', 0, 0);
	addLuaSprite('ForgottenEffect', true);
	setProperty('ForgottenEffect.alpha', 0.0000001);
	setProperty('ForgottenEffect.color', getColorFromHex('000000'));
		-- c-ceyes thing (lol reignite?)
		makeAnimatedLuaSprite('ceye', 'hitmans/BGs/Anby/Forgotten/ceye', 200, 800)
		addAnimationByPrefix('ceye', 'Animated', 'ceye', 24, false)
		setProperty('ceye.angle', 31)
		scaleObject('ceye', 2, 2)
		
		makeAnimatedLuaSprite('ceye1', 'hitmans/BGs/Anby/Forgotten/ceye', 1000, 750)
		addAnimationByPrefix('ceye1', 'Animated', 'ceye', 24, false)
		setProperty('ceye1.angle', 11)
		scaleObject('ceye1', 1.3, 1.3)
		
		makeAnimatedLuaSprite('ceye2', 'hitmans/BGs/Anby/Forgotten/ceye', 700, 650)
		addAnimationByPrefix('ceye2', 'Animated', 'ceye', 24, false)
		setProperty('ceye2.angle', -21)
		scaleObject('ceye2', 1.5, 1.5)
			
		makeAnimatedLuaSprite('ceye3', 'hitmans/BGs/Anby/Forgotten/ceye', 1300, 800)
		addAnimationByPrefix('ceye3', 'Animated', 'ceye', 24, false)
		setProperty('ceye3.angle', -40)
		scaleObject('ceye3', 1.25, 1.25)
	
		makeAnimatedLuaSprite('ceye4', 'hitmans/BGs/Anby/Forgotten/ceye', 400, 700)
		addAnimationByPrefix('ceye4', 'Animated', 'ceye', 24, false)
		setProperty('ceye4.angle', 11)
		scaleObject('ceye4', 1.1, 1.1)
	
		doTweenAlpha('ceyeTween', 'ceye', 0, 0.4, 'sineOut');
		doTweenAlpha('ceye1Tween', 'ceye1', 0, 0.4, 'sineOut');
		doTweenAlpha('ceye2Tween', 'ceye2', 0, 0.4, 'sineOut');
		doTweenAlpha('ceye3Tween', 'ceye3', 0, 0.4, 'sineOut');
		doTweenAlpha('ceye4Tween', 'ceye4', 0, 0.4, 'sineOut');
end

function onSongStart() -- ceyes thing^2
	addLuaSprite('ceye', true)
	addLuaSprite('ceye1', true)
	addLuaSprite('ceye2', true)
	addLuaSprite('ceye3', true)
	addLuaSprite('ceye4', true)
end

function onBeatHit() -- will start the c-eye animation - its random
	if curBeat % 3 == 0 then
		objectPlayAnimation('ceye', 'Animated', true)
	end
	if curBeat % 6 == 0 then
		objectPlayAnimation('ceye2', 'Animated', true)
	end
	if curBeat % 5 == 0 then
		objectPlayAnimation('ceye1', 'Animated', true)
	end
	if curBeat % 4 == 0 then
		objectPlayAnimation('ceye3', 'Animated', true)
	end
	if curBeat % 7 == 0 then
		objectPlayAnimation('ceye4', 'Animated', true)
	end
end

function onEvent(name, value1, value2)
	if name == 'ForgottenEffect' then
		if value1 == 'normal-v1' then
			doTweenAlpha('bgTween', 'bg', 1, 0.4, 'sineOut');
			setBlendMode('bg', 'normal');
			doTweenAlpha('corruptedTween', 'corrupted', 1, 0.4, 'sineOut')
			doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 0, 0.4, 'sineOut')
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0., 0.4, 'sineOut');
		
		elseif value1 == 'normal-v2' then
			doTweenAlpha('bgTween', 'bg', 1, 0.4, 'sineOut');
			setBlendMode('bg', 'normal');
			doTweenAlpha('corruptedTween', 'corrupted', 0, 0.4, 'sineOut')
			doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 1, 0.4, 'sineOut')
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0., 0.4, 'sineOut');

		elseif value1 == 'glitch' then
			doTweenAlpha('glitchTween', 'glitch', 0.5, 0.4, 'sineOut')

		elseif value1 == 'no-glitch' then
			doTweenAlpha('glitchTween', 'glitch', 0, 0.4, 'sineOut')

	    elseif value1 == 'dark-v1' then
			doTweenAlpha('bgTween', 'bg', 0.5, 0.4, 'sineOut');
			setBlendMode('bg', 'normal');
			doTweenAlpha('corruptedTween', 'corrupted', 1, 0.4, 'sineOut')
			doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 0, 0.4, 'sineOut')
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0.25, 0.4, 'sineOut');
			setProperty('ForgottenEffect.color', getColorFromHex('000000'));

		elseif value1 == 'dark-v2' then
			doTweenAlpha('bgTween', 'bg', 0.5, 0.4, 'sineOut');
			setBlendMode('bg', 'normal');
			doTweenAlpha('corruptedTween', 'corrupted', 0, 0.4, 'sineOut')
			doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 1, 0.4, 'sineOut')
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0.25, 0.4, 'sineOut');
			setProperty('ForgottenEffect.color', getColorFromHex('000000'));

		elseif value1 == 'darker-v1' then
			doTweenAlpha('bgTween', 'bg', 0, 0.4, 'sineOut');
			setBlendMode('bg', 'normal');
			doTweenAlpha('corruptedTween', 'corrupted', 1, 0.4, 'sineOut')
			doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 0, 0.4, 'sineOut')
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0.5, 0.4, 'sineOut');
			setProperty('ForgottenEffect.color', getColorFromHex('000000'));

		elseif value1 == 'darker-v2' then
			doTweenAlpha('bgTween', 'bg', 0, 0.4, 'sineOut');
			setBlendMode('bg', 'normal');
			doTweenAlpha('corruptedTween', 'corrupted', 0, 0.4, 'sineOut')
			doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 1, 0.4, 'sineOut')
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0.5, 0.4, 'sineOut');
			setProperty('ForgottenEffect.color', getColorFromHex('000000'));
			
		elseif value1 == 'slow-end' then
			doTweenAlpha('bgTween', 'bg', 0, 5, 'sineOut');
			setBlendMode('bg', 'normal');
			doTweenAlpha('corruptedTween', 'corrupted', 0, 5, 'sineOut')
			doTweenAlpha('corrupted-darkTween', 'corrupted-dark', 0, 5, 'sineOut')
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0.5, 5, 'sineOut');
			setProperty('ForgottenEffect.color', getColorFromHex('000000'));
		end

		if value2 == 'flash' then
			setProperty('ForgottenEffect.alpha',1)
			doTweenAlpha('ForgottenEffectTween', 'ForgottenEffect', 0, 0.6, 'sineOut');
			setProperty('ForgottenEffect.color', getColorFromHex('FFFFFF'));
			if flashingLights then
				setBlendMode('ForgottenEffect', 'add');
			end
		end

		if value2 == 'eyes-on' then
			doTweenAlpha('ceyeTween', 'ceye', 0.4, 0.2, 'sineOut');
			doTweenAlpha('ceye1Tween', 'ceye1', 0.5, 0.2, 'sineOut');
			doTweenAlpha('ceye2Tween', 'ceye2', 0.6, 0.2, 'sineOut');
			doTweenAlpha('ceye3Tween', 'ceye3', 0.3, 0.2, 'sineOut');
			doTweenAlpha('ceye4Tween', 'ceye4', 0.5, 0.2, 'sineOut');
		elseif value2 == 'eyes-off' then
			doTweenAlpha('ceyeTween', 'ceye', 0, 0.2, 'sineOut');
			doTweenAlpha('ceye1Tween', 'ceye1', 0, 0.2, 'sineOut');
			doTweenAlpha('ceye2Tween', 'ceye2', 0, 0.2, 'sineOut');
			doTweenAlpha('ceye3Tween', 'ceye3', 0, 0.2, 'sineOut');
			doTweenAlpha('ceye4Tween', 'ceye4', 0, 0.2, 'sineOut');
		end
		if value1 == 'anby' then
			doTweenAlpha('anby', 'anby', 1, 0.01, 'sineOut')
		end
		if value1 == 'noanby' then
			doTweenAlpha('anby', 'anby', 0, 0.01, 'sineOut')
		end
	end
end