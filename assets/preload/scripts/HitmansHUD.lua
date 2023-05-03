--------Quick Settings--------
local userNameDisplay = 'Edwhak'
local scoreToDisplay = 2
--                        (1 is for Score, 2 is for Accuracy)
local customRatings = true
local hudUnderlay = true
    underlayTransparency = 0.6

local customTimeBarColor = '0073FF'
    -- change this number to change judgements poss
    XjudgementsPoss = 500 
    YjudgementsPoss = 350
local difficultyBoxColors = {

    '04c000', --easy
    'd3c900', --normal
    'c70000', --hard
    'a2a2a2', --every other difficulty
}
------------------------------

local unlockLifeBars = false
function onCreatePost()
    local diff = getProperty('storyDifficultyText')
    makeSimplyLoveText('comboThing', 190, 670, '', 30, 'wendy', '0', 'ffffff')
    makeSimplyLoveText('comboThingTxt', 110, 670, '', 30, 'wendy', 'Combo:', 'ffffff')
    if (customRatings) then
        makeAnimatedLuaSprite('judgements', 'SimplyLoveHud/judgements', XjudgementsPoss, YjudgementsPoss)
        addAnimationByPrefix('judgements', 'fantastic', 'Fantastic', 1, true)
        addAnimationByPrefix('judgements', 'excellent Late', 'Excellent late', 1, true)
        addAnimationByPrefix('judgements', 'excellent Early', 'Excellent early', 1, true)
        addAnimationByPrefix('judgements', 'great Early', 'Great early', 1, true)
        addAnimationByPrefix('judgements', 'great Late', 'Great late', 1, true)
        addAnimationByPrefix('judgements', 'decent Early', 'Decent early', 1, true)
        addAnimationByPrefix('judgements', 'decent Late', 'Decent late', 1, true)
        addAnimationByPrefix('judgements', 'way Off Early', 'Way off early', 1, true)
        addAnimationByPrefix('judgements', 'way Off Late', 'Way off late', 1, true)
        addAnimationByPrefix('judgements', 'miss', 'Miss', 1, true)
        setObjectCamera('judgements', 'other')
        addLuaSprite('judgements')
        doTweenX('aldij', 'judgements.scale', 0, 0.1, 'linear')
        doTweenY('aijodsfb', 'judgements.scale', 0, 0.1, 'linear')
        for v = 0, 3 do
            setPropertyFromGroup('ratingsData', v, 'image', 'SimplyLoveHud/none')
        end
    end

    makeSimplyLoveText('playerName', 120, 40, 'right', 35, 'miso-bold', userNameDisplay, 'ffffff')
    setProperty('playerName.scale.y', 0.9)
    makeSimplyLoveText('playerAcc', 1002, 665, '', 40, 'wendy', 0, 'ffffff')

    setObjectCamera('playerDifficultyNum', 'other')
    setObjectCamera('playerName', 'other')
    setObjectCamera('playerAcc', 'other')
    setObjectCamera('comboThing', 'other')
    setObjectCamera('comboThingTxt', 'other')
    setObjectCamera('title', 'other')

    if downscroll then
        setProperty('playerAcc.y', -5)
        setProperty('comboThingTxt.y', -5)
        setProperty('comboThing.y', -5)
    end

    if (botPlay) then
        makeSimplyLoveText('bot', 140, 530, 'center', 40, 'miso-bold', 'BotPlay', 'ffffff')
        setObjectCamera('bot', 'other')
    end
end
function onSongStart()
    unlockLifeBars = true
end
function onUpdate()
    if getProperty('combo') == 0 then
        setProperty('comboThing.visible', false)
    else
        setProperty('comboThing.visible', true)
    end
    setTextString('comboThing', getProperty('combo'))
    if unlockLifeBars == true then
        setTextString('playerAcc', round((getProperty('songScore') * 100), 2))
        doTweenX('setPhealth', 'playerHealthBar.scale', getProperty('health'), 0.7, 'circOut')
    end
end

function onUpdatePost()
end

function goodNoteHit(id, direction, noteType, sus)
    if (customRatings) and not sus then
        strumTime = getPropertyFromGroup('notes', id, 'strumTime')
        objectPlayAnimation('judgements', setRatingImage(strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset')), true) --taken from bbpanzu's taiko script                                    pleasedontsuemebbibegyouimagoodperson:)
        bop()
    end
end

function noteMiss(piss, fart, asdoiaoifhsidgfkhjbssbfk, sus)
    if not sus then     --yeah
        bop()
        objectPlayAnimation('judgements', 'miss', true)
    end
end

function onTimerCompleted(name)
    if name == 'timeToShrink' then
        doTweenX('shrinkX', 'judgements.scale', 0, 0.2, 'circIn')
        doTweenY('shrinkY', 'judgements.scale', 0, 0.2, 'circIn')
    end
end

function makeSimplyLoveSprite(name, x, y, image, width, height, color)
    makeLuaSprite(name, 'SimplyLoveHud/'..image, x, y)
    if image == '' then
        makeGraphic(name, width, height, color)
        setProperty(name..'.origin.x', 0)
    end
    setObjectCamera(name, 'hud')
    addLuaSprite(name)
end

function makeSimplyLoveText(name, x, y, align, size, font, text, color)
    makeLuaText(name, text, 999, x, y)
    setTextColor(name, color)
    setTextFont(name, font..'.ttf')
    setTextSize(name, size)
    setTextAlignment(name, align)
    setTextBorder(name, 0)
    addLuaText(name)
end

function round(x, n) --the hundredth time you'll see the function from https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function setRatingImage(b)
	if b >= 0 then
		if b <= (getPropertyFromClass('ClientPrefs', 'sickWindow') / 2.5) then
			return 'fantastic'
		elseif b <= getPropertyFromClass('ClientPrefs', 'sickWindow') then
			return 'excellent Early'
		elseif b >= getPropertyFromClass('ClientPrefs', 'sickWindow') and b <= getPropertyFromClass('ClientPrefs', 'goodWindow') then
			return 'great Early'
		elseif b >= getPropertyFromClass('ClientPrefs', 'goodWindow') and b <= getPropertyFromClass('ClientPrefs', 'badWindow') then
			return 'decent Early'
		elseif b >= getPropertyFromClass('ClientPrefs', 'badWindow') then
			return 'way Off Early'
		end
	else
		if b >= ((getPropertyFromClass('ClientPrefs', 'sickWindow') * -1) / 2.5) then
			return 'fantastic'
		elseif b >= (getPropertyFromClass('ClientPrefs', 'sickWindow') * -1) then
			return 'excellent Late'
		elseif b <= (getPropertyFromClass('ClientPrefs', 'sickWindow') * -1) and b >= (getPropertyFromClass('ClientPrefs', 'goodWindow') * -1) then
			return 'great Late'
		elseif b <= (getPropertyFromClass('ClientPrefs', 'goodWindow') * -1) and b >= (getPropertyFromClass('ClientPrefs', 'badWindow') * -1) then
			return 'decent Late'
		elseif b <= (getPropertyFromClass('ClientPrefs', 'badWindow') * -1) then
			return 'way Off Late'
		end
	end
end

function setDifficultyNumber()
    if getProperty('storyDifficultyText') == 'Hard' then
        return 3
    elseif getProperty('storyDifficultyText') == 'Normal' then
        return 2
    elseif getProperty('storyDifficultyText') == 'Easy' then
        return 1
    else
        return 4
    end
end

function bop()
    cancelTween('decreaseHitX')
    cancelTween('decreaseHitY')
    cancelTween('shrinkX')
    cancelTween('shrinkY')
    scaleObject('judgements', 1.5, 1.5)
    doTweenX('decreaseHitX', 'judgements.scale', 1.3, 0.1, 'circOut')
    doTweenY('decreaseHitY', 'judgements.scale', 1.3, 0.1, 'circOut')
    runTimer('timeToShrink', 1)
end

--[[
        Simply Love Hud made by Clan TX / Kori
        Original (the original ORIGINAL release for Stepmania 3.95) Simply Love theme made by hurtpiggypig
        Download the current release of Simply Love for Stepmania 5 here: https://github.com/Simply-Love/Simply-Love-SM5/tree/5.1.2-ITGm                                                                                                                    (i did not get paid)

        Also remember to disable any other custom huds you have enabled so the game doesn't fuck up
--]]