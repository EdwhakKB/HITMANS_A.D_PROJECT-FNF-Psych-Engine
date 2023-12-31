local stageData = {
	--name, x, y, scale, scroll factor
	{'Background', 0, 10, 1, 1},
	{'Ame_2', 0, 257, 1, 1},
	{'Ame_4', 83, 22, 1, 1},
	{'Ame_3', 120, 208, 1, 1},
	{'Ame_5', 205, -90, 1, 1},
	{'Ame_6', 1021, 41, 1, 1},
	{'Ame_7', 1120, 174, 1, 1},
	{'EDSINGBLUSH-', 467, 360, 1, 1},
	{'Ame_1', 57, 433, 1, 1},
	{'Ame_8', 980, 426, 1, 1},
}

local bgFolder = 'hitmans/Visuals/Ame/'

function onCreate() --simple stage template

	for i = 0, #stageData-1 do 
		local name = stageData[i+1][1]
		makeLuaSprite(name, bgFolder..name, stageData[i+1][2], stageData[i+1][3]);
		setScrollFactor(name, stageData[i+1][5], stageData[i+1][5])
		scaleObject(name, stageData[i+1][4], stageData[i+1][4])
		updateHitbox(name)
		addLuaSprite(name, false);
	end
	for i = 1,8 do
		setProperty('Ame_'..i..'.alpha', 0)
	end
	setProperty('Background.alpha', 0)
	setProperty('EDSINGBLUSH-.alpha', 0)
	doTweenY('EDMOMENT1', 'EDSINGBLUSH-', 365, 1, 'smoothStepInOut')
end

function onBeatHit()
	if curBeat == 47 then
		changeAlphaStuff('Background',188,0.3,1,'smoothStepInOut')
	elseif curBeat == 48 then
		myLovePart(194,false)
	elseif curBeat == 62 then
		myLovePart(248,true)
	elseif curBeat == 64 then
		myLovePart(258,false)
	elseif curBeat == 78 then
		myLovePart(312,true)
	elseif curBeat == 80 then
		changeAlphaStuff('Background',320,0.8,1,'smoothStepInOut')
	elseif curBeat == 111 then
		changeAlphaStuff('Background',444,0.3,1,'smoothStepInOut')
	elseif curBeat == 112 then
		myLovePart(448,false)
	elseif curBeat == 126 then
		myLovePart(504,true)
	elseif curBeat == 140 then
		changeAlphaStuff('Background',562,0,2,'smoothStepInOut')
	elseif curBeat == 143 then
		hideEDStuff(574)
	end
end
function onSongStart()
	doTweenAlpha('TheED', 'EDSINGBLUSH-', 1, 5, 'smoothStepInOut')
	doTweenAlpha('TheBG', 'Background', 0.8, 25, 'smoothStepInOut')
end

function myLovePart(step, leave)
	function onStepHit()
		if not leave then
		if curStep == step then
			doTweenAlpha('Ame1', 'Ame_2', 1, 1, 'sineOut')
		elseif curStep == step+4 then
			doTweenAlpha('Ame2', 'Ame_7', 1, 1, 'sineOut')
		elseif curStep == step+7 then
			doTweenAlpha('Ame3', 'Ame_1', 1, 1, 'sineOut')
		elseif curStep == step+10 then
			doTweenAlpha('Ame4', 'Ame_6', 1, 1, 'sineOut')
		elseif curStep == step+12 then
			doTweenAlpha('Ame5', 'Ame_3', 1, 1, 'sineOut')
		elseif curStep == step+16 then
			doTweenAlpha('Ame6', 'Ame_8', 1, 1, 'sineOut')
		elseif curStep == step+20 then
			doTweenAlpha('Ame7', 'Ame_4', 1, 1, 'sineOut')
		elseif curStep == step+23 then
			doTweenAlpha('Ame8', 'Ame_5', 1, 2, 'sineOut')
		end
		else
		if curStep == step then
			for i = 1,8 do
				doTweenAlpha('Ame'..i, 'Ame_'..i, 0, 1, 'sineOut')
			end
		end
		end
	end
end

function changeAlphaStuff(sprite,step,alpha,time,ease)
	function onStepHit()
		if curStep == step then
			doTweenAlpha('DA'..sprite..'MOMENT', sprite, alpha, time, ease)
		end
	end
end

function hideEDStuff(step)
	function onStepHit()
		if curStep == step then
			doTweenAlpha('DAEDMOMENT', 'EDSINGBLUSH-', 0, 1, 'smoothStepInOut')
		end
	end
end

function onTweenCompleted(t)
	if t == 'EDMOMENT1' then
		doTweenY('EDMOMENT2', 'EDSINGBLUSH-', 355, 1, 'smoothStepInOut')
	end
	if t == 'EDMOMENT2' then
		doTweenY('EDMOMENT1', 'EDSINGBLUSH-', 365, 1, 'smoothStepInOut')
	end
end

function onUpdate()
    setProperty('botplayTxt.visible', false)
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('healthBarHit.visible', false)
    setProperty('healthHitBar.visible', false)
	setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('scoreTxtHit.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
end