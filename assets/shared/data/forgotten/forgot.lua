--special script for Forgotten -- made and modified by arctic fox
drainAmount = 0.075
function onUpdate(elapsed)
		health = getProperty('health')

		doTweenAlpha('frostbiteTween', 'frostbite', 0, 0.4, 'sineOut');
		setProperty('frostbite.scale.x', 0.645)
		setProperty('frostbite.scale.y', 0.645)
		setScrollFactor('frostbite', 0, 0);
		addLuaSprite('frostbite', true)

		if curStep <=0 then
			if health > 1.5 then
				setProperty('health', health-elapsed*drainAmount)
			end
        else
            if health > 0.25 then
				setProperty('health', health-elapsed*drainAmount)
			end
		end

		-- when player has low hp, he starts to freeze
		if health < 0.55 then
			doTweenAlpha('frostbiteTween', 'frostbite', 1, 0.4, 'sineOut');
			setBlendMode('frostbite', 'normal');
		end
		if health > 0.55 and health < 1 then
			doTweenAlpha('frostbiteTween', 'frostbite', 0.5, 0.4, 'sineOut');
			setBlendMode('frostbite', 'normal');
		end
		if health > 1 then
			doTweenAlpha('frostbiteTween', 'frostbite', 0, 0.4, 'sineOut');
			setBlendMode('frostbite', 'normal');
		end

		-- middle scroll forced +invisible opponent notes
		setPropertyFromGroup('opponentStrums', 0, 'alpha', 0);
		setPropertyFromGroup('opponentStrums', 1, 'alpha', 0);
		setPropertyFromGroup('opponentStrums', 2, 'alpha', 0);
		setPropertyFromGroup('opponentStrums', 3, 'alpha', 0);
		if not getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
			setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0 - 321);
			setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1 - 321);
			setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 - 321);
			setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3 - 321);
		end

		-- anti-cheat LMAO
		-- if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
		-- 	startDialogue('messageEND');
		-- 	setProperty('health', health- 5000);
		-- 	playSound('hazard/cheatercheatercheater', 1);
		-- end
end

function onGameOver()
	-- if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
	-- 	addLuaSprite('cheatercheatercheater', true)
	-- 	addLuaSprite('cheater', true)
	-- 	exitSong(false)
	-- 	return Function_Stop
	-- end
end

function onCreate()
    setPropertyFromClass('GameOverSubstate', 'characterName', 'gameOver'); --Character json file for the death animation
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'InhumanDeath'); --put in mods/sounds/
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'InhumanDeathLoopC'); --put in mods/music/
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'InhumanDeathAcceptC'); --put in mods/music/
end

function onCreatePost()
	setProperty('botplayTxt.color', getColorFromHex("00B4CC")) -- changes color of bot text
	setProperty('timeBar.color', getColorFromHex("00B4CC")) -- changes color of time bar
	setProperty('timeTxt.color', getColorFromHex("00B4CC")) -- changes color of time text
	setProperty('JukeBoxSubText.color', getColorFromHex("004B69")) -- changes color jukebox subtext
	setProperty('JukeDifBoxSubText.color', getColorFromHex("004B69")) -- changes color jukebox subtext
	setProperty('WarningBoxText.color', getColorFromHex("004B69")) -- changes color of warning
	setProperty('WarningBoxSubText.color', getColorFromHex("FFFFFF")) -- changes color warning subtext
	setProperty('tauntKey', null);
	setProperty('debugKeysChart', null);
	setProperty('debugKeysCharacter', null);
end

function onCountdownTick(counter)
    if counter == 4 then
        doTweenAlpha('glitchTween', 'glitch', 0, 0.4, 'sineOut')
    end
end
