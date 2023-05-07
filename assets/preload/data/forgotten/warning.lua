-- script made and modified by arctic fox
--easy script configs
WarIntroTextSize = 35	--Size of the text.
WarIntroSubTextSize = 25 --size of the text.
WarIntroTagColor = '004A7F'	--Color of the tag at the end of the  box.
WarIntroTagWidth = 15	--Width of the box's tag thingy.
--easy script configs

--actual script
function onCreate()
	--the tag at the end of the box
	makeLuaSprite('WarningBoxTag', 'empty', -305-WarIntroTagWidth, 525)
	makeGraphic('WarningBoxTag', 300+WarIntroTagWidth, 100, WarIntroTagColor)
	setObjectCamera('WarningBoxTag', 'other')
	addLuaSprite('WarningBoxTag', true)

	--the box
	makeLuaSprite('WarningBox', 'empty', -305-WarIntroTagWidth, 525)
	makeGraphic('WarningBox', 300, 100, '000000')
	setObjectCamera('WarningBox', 'other')
	addLuaSprite('WarningBox', true)
	
	--the text for the "Warning" bit
	makeLuaText('WarningBoxText', 'WARNING!', 300, -305-WarIntroTagWidth, 540)
	setTextAlignment('WarningBoxText', 'left')
	setObjectCamera('WarningBoxText', 'other')
	setTextSize('WarningBoxText', WarIntroTextSize)
	addLuaText('WarningBoxText')
	
	--text which is for warning
	makeLuaText('WarningBoxSubText', "Don't get corrupted!", 300, -305-WarIntroTagWidth, 570)
	setTextAlignment('WarningBoxSubText', 'left')
	setObjectCamera('WarningBoxSubText', 'other')
	setTextSize('WarningBoxSubText', WarIntroSubTextSize)
	addLuaText('WarningBoxSubText')
end

--motion functions
function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('WarMoveInOne', 'WarningBoxTag', 0, 1, 'WarCircInOut')
	doTweenX('WarMoveInTwo', 'WarningBox', 0, 1, 'WarCircInOut')
	doTweenX('WarMoveInThree', 'WarningBoxText', 0, 1, 'WarCircInOut')
	doTweenX('WarMoveInFour', 'WarningBoxSubText', 0, 1, 'WarCircInOut')
	runTimer('WarningBoxWait', 3, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == 'WarningBoxWait' then
		doTweenX('WarMoveOutOne', 'WarningBoxTag', -450, 1.5, 'WarCircInOut')
		doTweenX('WarMoveOutTwo', 'WarningBox', -450, 1.5, 'WarCircInOut')
		doTweenX('WarMoveOutThree', 'WarningBoxText', -450, 1.5, 'WarCircInOut')
		doTweenX('WarMoveOutFour', 'WarningBoxSubText', -450, 1.5, 'WarCircInOut')
	end
end