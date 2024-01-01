drainAmount = 0.225
death = false
function  onUpdate(elapsed)
	health = getProperty('health')
	if not death then
	if curStep <=0 then
		if health > 1.5 then
			setProperty('health', health-elapsed*drainAmount)
		end
    else
        if health > 0.5 then
			setProperty('health', health-elapsed*drainAmount)
		end
	end
    end
	if health < 1 and health > 0.7 then
		doTweenAlpha('a', 'freeze', 0.2, 1, 'linear')
	elseif health < 0.7 and health > 0.5 then
		doTweenAlpha('a', 'freeze', 0.5, 1, 'linear')
	elseif health < 0.5 and health > 0.2 then
		doTweenAlpha('a', 'freeze', 0.7, 1, 'linear')
	elseif health < 0.2 and health > 0 then
		doTweenAlpha('a', 'freeze', 1, 1, 'linear')
	elseif health > 1 and health < 1.5 then
		doTweenAlpha('a', 'freeze', 0.1, 1, 'linear')
	elseif health > 1.5 then
		doTweenAlpha('a', 'freeze', 0, 1, 'linear')
	end
end 

function onCreatePost()
	for i = 0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums', i, 'visible', false) --fix for hitmans stuff too
	end
	makeLuaSprite('freeze', 'hitmans/frostbite', 0, 0)
	setObjectCamera('freeze', 'other');
    scaleObject('freeze', 0.53, 0.55)
    setProperty('freeze.alpha', 0)
	addLuaSprite('freeze', true)
end

function onGameOver()
    death = true
	setProperty('freeze.visible', false)
end