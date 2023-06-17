function onEvent(name, value1, value2)
	if name == "RedGlow" then
		makeLuaSprite('imageC', 'Inhuman/alert-vignette', 0, 0);
		addLuaSprite('imageC', true);
        setProperty('imageC.alpha', 1)
		setObjectCamera('imageC', 'other');
		scaleObject('imageC', 0.55, 0.55)
        if value1 == 'low' then
            doTweenAlpha('byebyeC', 'imageC', 0, 3.7, 'linear');
        elseif value1 == 'mid' then
            doTweenAlpha('byebyeD', 'imageC', 0, 1.5, 'linear');
        elseif value1 == 'fast' then
            doTweenAlpha('byebyeD', 'imageC', 0, 0.45, 'linear');
        end
	end
end