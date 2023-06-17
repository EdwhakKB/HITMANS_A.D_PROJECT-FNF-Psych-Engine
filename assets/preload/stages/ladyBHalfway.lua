
local enableBump = false
function onCreate()
	-- background shit
	makeLuaSprite('stars', 'ladyB/bg', -100, 30);
	scaleObject('stars', 2, 2)
	setScrollFactor('stars', 1, 1);

	makeLuaSprite('store', 'ladyB/storeNalley', -100, 130);
	scaleObject('store', 0.9, 0.8)
	setScrollFactor('store', 1, 1);

	makeLuaSprite('storeIn', 'ladyB/storeInside', -100, 130);
	scaleObject('storeIn', 0.9, 0.8)
	setScrollFactor('storeIN', 1, 1);

	-- makeLuaSprite('tv', 'ladyB/tvNeutral', -50, 130);
	-- scaleObject('tv', 0.8, 0.8)
	-- setScrollFactor('tv', 1, 1);

	-- makeLuaSprite('basetv', 'ladyB/baseTV', -50, 130);
	-- scaleObject('basetv', 0.8, 0.8)
	-- setScrollFactor('basetv', 1, 1);
	makeAnimatedLuaSprite('tv-animate', 'ladyB/TV', -50, 130)
	addAnimationByPrefix('tv-animate', 'off', 'TV-neutral', 24, true)
	addAnimationByPrefix('tv-animate', 'ready', 'TV-ready', 24, true)
	addAnimationByPrefix('tv-animate', 'alert', 'TV-Alert', 32, false)
	scaleObject('tv-animate', 0.8, 0.8)
	setScrollFactor('tv-animate', 1, 1);

	makeLuaSprite('floor', 'ladyB/floor', -100, 130);
	scaleObject('floor', 0.9, 0.8)
	setScrollFactor('floor', 1, 1);

	makeLuaSprite('light', 'ladyB/light', 110, 130);
	scaleObject('light', 0.7, 0.7)
	setScrollFactor('light', 1, 1);

	makeLuaSprite('pole', 'ladyB/metalPole', 180, 130);
	scaleObject('pole', 0.7, 0.7)
	setScrollFactor('pole', 1, 1);

	addLuaSprite('stars', false);
	addLuaSprite('storeIn', false);
	-- addLuaSprite('tv', false);
	addLuaSprite('tv-animate', false);
	addLuaSprite('store', false);
	addLuaSprite('floor', false);
	addLuaSprite('light', false);
	addLuaSprite('pole', false);

	function onEvent(t,v1,v2)
		if t == 'ladyBthings' then
			if v1 == '0' then
				enableBump = false
				objectPlayAnimation('tv-animate', 'off', true)
			elseif v1 == '1' then
				objectPlayAnimation('tv-animate', 'alert', true)
				enableBump = true
			elseif v1 == '2' then
				enableBump = false
				objectPlayAnimation('tv-animate', 'ready', true)
			elseif v1 == '3' then
				enableBump = false
				objectPlayAnimation('tv-animate', 'alert', true)
			end
		end
		if t == 'pink toggle' then
			if v1 == 'true' then
				enableBump = true
			elseif v1 == 'false' then
				enableBump = false
			end
		end
	end
end

function onBeatHit() -- will start the c-eye animation - its random
	if enableBump then
		if curBeat % 1 == 0 then
			objectPlayAnimation('tv-animate', 'alert', true)
		end
	end
end