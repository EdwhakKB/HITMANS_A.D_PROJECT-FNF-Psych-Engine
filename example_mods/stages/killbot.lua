function onCreate()
	-- background shit
	makeLuaSprite('killmoment', 'hitmans/killbotBG', -50, 130);
	scaleObject('killmoment', 0.7, 0.7)
	setScrollFactor('killmoment', 1, 1);

	addLuaSprite('killmoment', false);
end