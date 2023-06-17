function onCreate()
	-- the dark effect mhm
	makeLuaSprite('IceBeatEffect', nil, -700, -500);
	makeGraphic('IceBeatEffect', screenWidth * 2, screenHeight * 2, 'FFFFFF');
	setScrollFactor('IceBeatEffect', 0, 0);
	addLuaSprite('IceBeatEffect', true);
	setProperty('IceBeatEffect.alpha', 0.0000001);
	setProperty('IceBeatEffect.color', getColorFromHex('000000'));

    -- just glitch lol, which i took from forgotten
    makeAnimatedLuaSprite('glitch', 'forgotten/glitch', 0, 0)
    addAnimationByPrefix('glitch', 'anim', 'glitch', 24, true);
    addLuaSprite('glitch', true)
    setGraphicSize('glitch', 1286, 730)
    setScrollFactor('glitch', 0, 0);
	doTweenAlpha('glitchTween', 'glitch', 0, 0.1, 'sineOut');
end

function onEvent(name, value1, value2)
	if name == 'IceBeatEffect' then
		-- dark
		if value1 == 'dark' then
			doTweenAlpha('IceBeatEffectTween', 'IceBeatEffect', 0.5, 0.4, 'sineOut');
			setProperty('IceBeatEffect.color', getColorFromHex('000000'));
			setBlendMode('IceBeatEffect', 'normal');
		elseif value1 == 'darker' then
			doTweenAlpha('IceBeatEffectTween', 'IceBeatEffect', 0.8, 0.4, 'sineOut');
			setProperty('IceBeatEffect.color', getColorFromHex('000000'));
			setBlendMode('IceBeatEffect', 'normal');
		elseif value1 == 'black' then
			doTweenAlpha('IceBeatEffectTween', 'IceBeatEffect', 0.95, 0.4, 'sineOut');
			setProperty('IceBeatEffect.color', getColorFromHex('000000'));
			setBlendMode('IceBeatEffect', 'normal');
		elseif value1 == 'slow-end' then
			doTweenAlpha('IceBeatEffectTween', 'IceBeatEffect', 1, 5, 'sineOut');
			setProperty('IceBeatEffect.color', getColorFromHex('000000'));
			setBlendMode('IceBeatEffect', 'normal');

		-- normal
		elseif value1 == 'normal' then
			doTweenAlpha('IceBeatEffectTween', 'IceBeatEffect', 0, 0.4, 'sineOut');
			setProperty('IceBeatEffect.color', getColorFromHex('000000'));
			setBlendMode('IceBeatEffect', 'normal');
		elseif value1 == 'normal-flash' then
			doTweenAlpha('IceBeatEffectTween', 'IceBeatEffect', 0, 0.6, 'sineOut');
			setProperty('IceBeatEffect.color', getColorFromHex('FFFFFF'));
			if flashingLights then
				setBlendMode('IceBeatEffect', 'add');
			end
		end
	end

	--idk why i added it
	if name == 'Rotating' then
		if value1 == '1' then
			doTweenAlpha('glitchTween', 'glitch', 0.25, 0.4, 'sineOut');
		elseif value1 == '2' then
			doTweenAlpha('glitchTween', 'glitch', 0.5, 0.4, 'sineOut');	
		elseif value1 == '3' then
			doTweenAlpha('glitchTween', 'glitch', 0, 0.4, 'sineOut');
		end
	end
end