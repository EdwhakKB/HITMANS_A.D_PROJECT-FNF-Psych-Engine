function  onUpdate(elapsed)
	health = getProperty('health')
	if health < 1 and health > 0.7 then
		doTweenAlpha('a', 'fear', 0.4, 1, 'linear')
	elseif health < 0.7 and health > 0.5 then
		doTweenAlpha('a', 'fear', 0.6, 1, 'linear')
	elseif health < 0.5 and health > 0.2 then
		doTweenAlpha('a', 'fear', 0.8, 1, 'linear')
	elseif health < 0.2 and health > 0 then
		doTweenAlpha('a', 'fear', 1, 1, 'linear')
	elseif health > 1 and health < 1.2 then
		doTweenAlpha('a', 'fear', 0.2, 1, 'linear')
	elseif health > 1.5 then
		doTweenAlpha('a', 'fear', 0, 1, 'linear')
	end
end 

function onCreatePost()
	makeLuaSprite('fear', 'hitmans/FearMe', 0, 0)
	setObjectCamera('fear', 'other');
    scaleObject('fear', 0.53, 0.53)
    setProperty('fear.alpha', 0)
	addLuaSprite('fear', true)
end

function onGameOver()
	setProperty('fear.visible', false)
end