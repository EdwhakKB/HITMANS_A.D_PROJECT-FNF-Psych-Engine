--new LadyDodge system Made By EDWHAK_KB
--Credit me if You use this

local drilling = false
local LadyDodgeTiming = 0.2
local LadyDodgeCooldown = 0.030
local dodging = false
local canLadyDodge = true
Damage = 0.1
instakill = false

function onEvent(name, v1, v2)
	if name == 'LB_Alerts' then
		if v1 == '1' then
			doWarning()
		end
		if v1 == '2' then
			doWarningDuo()
		end
		if v1 == '3' then
			doWarningTriple()
		end
		if v1 == '4' then
			doWarningQuadruple()
		end
		if v2 == 'yes' then
			setProperty('SawBlade1.alpha', 1)
			objectPlayAnimation('SawBlade1', 'Preparing', true);
		end
	end
	if name == 'LB_Attacks' then
		if v1 == '1' then
			SdoAttack()
			setProperty('SawBlade1.alpha', 0)
		end
		if v1 == '2' then
			SdoAttackDuo()
			setProperty('SawBlade1.alpha', 0)
		end
		if v1 == '3' then
			SdoAttackTriple()
			setProperty('SawBlade1.alpha', 0)
		end
		if v1 == '4' then
			SdoAttackQuadruple()
			setProperty('SawBlade1.alpha', 0)
		end
		if v2 == 'yes' then
			instakill = true
		end
		if v2 == 'no' then
			instakill = false
		end
	end
    if name == 'Z20-LadyDodgeSingle' then
        Sbeat0 = curBeat+1
		Sbeat1 = curBeat+2
		Sbeat2 = curBeat+3

		if v1 == 'true' then
			instakill = true
		end
    end
    if name == 'Z21-LadyDodgeDuo' then
		Dbeat0 = curBeat+1
		Dbeat1 = curBeat+2
		Dbeat2 = curBeat+3
        Dbeat3 = curBeat+4

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == 'Z22-LadyDodgeTriple' then
		Tbeat0 = curBeat+1
		Tbeat1 = curBeat+2
		Tbeat2 = curBeat+3
        Tbeat3 = curBeat+4
		Tbeat4 = curBeat+5
		Tbeat5 = curBeat+6
        Tbeat6 = curBeat+7

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == 'Z23-LadyDodgeQuadruple' then
		Qbeat0 = curBeat+1
		Qbeat1 = curBeat+2
		Qbeat2 = curBeat+3
        Qbeat3 = curBeat+4
		Qbeat4 = curBeat+5
		Qbeat5 = curBeat+6
        Qbeat6 = curBeat+7
        Qbeat7 = curBeat+8

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == 'Z24-LadyDodgeTripleFast' then
		TFbeat0 = curBeat+1
		TFbeat1 = curBeat+2
		TFbeat2 = curBeat+3
        TFbeat3 = curBeat+4
		TFbeat4 = curBeat+5

		if v1 == 'true' then
			instakill = true
		end
	end
    if name == 'Z25-LadyDodgeQuadFast' then
		QFbeat0 = curBeat+1
		QFbeat1 = curBeat+2
		QFbeat2 = curBeat+3
        QFbeat3 = curBeat+4
		QFbeat4 = curBeat+5
        QFbeat5 = curBeat+6

		if v1 == 'true' then
			instakill = true
		end
	end
end

function onCreatePost()

    -- --SAWBLADE THING

	-- makeAnimatedLuaSprite('kill', 'attackv6', (defaultBoyfriendX)-3650, (defaultBoyfriendY)+450)
	-- addAnimationByPrefix('kill', 'fire', 'kb_attack_animation_fire', 24, false)
    -- scaleObject('kill', 1.18, 1.18)
	-- addLuaSprite('kill', true)
	-- setProperty('kill.alpha', 0)

    -- --PREPARE ANIMATION

	-- makeAnimatedLuaSprite('SawBlade1', 'attackv6Prepare', (defaultBoyfriendX)-1660, (defaultBoyfriendY)+485)
    -- addAnimationByPrefix('SawBlade1', 'Preparing', 'kb_attack_animation_prepare', 20, false)
	-- scaleObject('SawBlade1', 1.18, 1.18)
    -- addLuaSprite('SawBlade1', true)
    -- setProperty('SawBlade1.alpha', 0)

	    --SAWBLADE THING

		makeAnimatedLuaSprite('kill', 'attackv6', (defaultBoyfriendX)-3650, (defaultBoyfriendY)+250)
		addAnimationByPrefix('kill', 'fire', 'kb_attack_animation_fire', 24, false)
		scaleObject('kill', 1.18, 1.18)
		addLuaSprite('kill', true)
		setProperty('kill.alpha', 0)
	
		--PREPARE ANIMATION
	
		makeAnimatedLuaSprite('SawBlade1', 'attackv6Prepare', (defaultBoyfriendX)-1660, (defaultBoyfriendY)+285)
		addAnimationByPrefix('SawBlade1', 'Preparing', 'kb_attack_animation_prepare', 20, false)
		scaleObject('SawBlade1', 1.18, 1.18)
		addLuaSprite('SawBlade1', true)
		setProperty('SawBlade1.alpha', 0)

	--SINGLE ALERT

	makeAnimatedLuaSprite('AlertSingle', 'GirlsAlerts/love_alert-S', 385, 180)
	addAnimationByPrefix('AlertSingle', 'alert', 'LadyB_alert_Single', 24, false)
	scaleObject('AlertSingle', 0.5, 0.5)
	updateHitbox('AlertSingle')
	setObjectCamera('AlertSingle', 'other')
	addLuaSprite('AlertSingle', true)
	setProperty('AlertSingle.alpha', 0)

    --DUO ALERT

    makeAnimatedLuaSprite('AlertDouble', 'GirlsAlerts/love_alert-D', 275, 180)
    addAnimationByPrefix('AlertDouble', 'alertdouble', 'LadyB_alert_Double', 24, false)
	scaleObject('AlertDouble', 0.5, 0.5)
	updateHitbox('AlertDouble')
	setObjectCamera('AlertDouble', 'other')
	addLuaSprite('AlertDouble', true)
	setProperty('AlertDouble.alpha', 0)
	setProperty('AlertDouble.x', 370)
	setProperty('AlertDouble.y', 180)

    --TRIPLE ALERT

    makeAnimatedLuaSprite('AlertTriple', 'GirlsAlerts/love_alert-T', 275, 180)
	addAnimationByPrefix('AlertTriple', 'alerttriple', 'LadyB_alert_Triple', 24, false)
	scaleObject('AlertTriple', 0.5, 0.5)
	updateHitbox('AlertTriple')
	setObjectCamera('AlertTriple', 'other')
	addLuaSprite('AlertTriple', true)
	setProperty('AlertTriple.alpha', 0)
	setProperty('AlertTriple.x', 320)
	setProperty('AlertTriple.y', 170)

    --QUADRUPLE ALERT

	makeAnimatedLuaSprite('AlertQuadruple', 'GirlsAlerts/broken_alert-Q', 475, 280)
	addAnimationByPrefix('AlertQuadruple', 'alertquad', 'LadyB_broken_alert_quad', 24, false)
	scaleObject('AlertQuadruple', 0.5, 0.5)
	updateHitbox('AlertQuadruple')
	setObjectCamera('AlertQuadruple', 'other')
	addLuaSprite('AlertQuadruple', true)
	setProperty('AlertQuadruple.alpha', 0)
	setProperty('AlertQuadruple.x', 320)
	setProperty('AlertQuadruple.y', 130)
end

function LadyDodge()
    dodging = true
    canLadyDodge = false

	characterPlayAnim('bf', 'Dodge', true)
    setProperty('bf.specialAnim', true)
    playSound('Dodge01')

    runTimer('LadyDodge', LadyDodgeTiming)
	runTimer('dodging', 0.25)
end

function onUpdate(elapsed)

	--LadyDodge MECHANIC FUNCTION

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not dodging and canLadyDodge and not botPlay then
        LadyDodge()
    end

	if drilling then
		health = getProperty('health')
		if getProperty('health') > 0.05 then
			setProperty('health', health- 0.01);
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'LadyDodge' then
		characterDance('bf')

		runTimer('LadyDodgeCooldown', LadyDodgeCooldown)
	elseif tag == 'dodging' then
        dodging = false
	elseif tag == 'LadyDodgeCooldown' then
        canLadyDodge = true
	elseif tag == 'stopDrill' then
		drilling = false
    elseif tag == 'LadyCheckDodging' then
        if canLadyDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			runTimer('stopDrill', 2)
			drilling = true
            if instakill then
                setProperty('health', -1)
            end
        end
	elseif tag == 'LadyCheckDodging2' then
        if canLadyDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			runTimer('stopDrill', 2)
			drilling = true
            if instakill then
                setProperty('health', -1)
            end
        end
	elseif tag == 'LadyCheckDodging3' then
        if canLadyDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			runTimer('stopDrill', 2)
			drilling = true
            if instakill then
                setProperty('health', -1)
            end
        end
	elseif tag == 'LadyCheckDodging4' then
        if canLadyDodge and not Dodging and not botPlay then
            setProperty('health', getProperty('health') - Damage)
            characterPlayAnim('bf', 'hurt', true)
			setProperty('bf.specialAnim', true)
			playSound('sawbladeHit', 1)
			runTimer('stopDrill', 2)
			drilling = true
            if instakill then
                setProperty('health', -1)
            end
        end
    end
end

doWarning = function()
	playSound('alert', 1)
	setProperty('AlertSingle.alpha', 1)
	objectPlayAnimation('AlertSingle', 'alert', true);
	doTweenAlpha('1', 'AlertSingle', 0, 0.2, 'exponentialIn')
	setProperty('kill.alpha', 1)
end
doWarningDuo = function()
	playSound('alertDouble', 1)
	setProperty('AlertDouble.alpha', 1)
	objectPlayAnimation('AlertDouble', 'alertdouble', true);
	doTweenAlpha('2', 'AlertDouble', 0, 0.2, 'exponentialIn')
	setProperty('kill.alpha', 1)
end

doWarningTriple = function()
	playSound('alertTriple', 1)	
	setProperty('AlertTriple.alpha', 1)
	objectPlayAnimation('AlertTriple', 'alerttriple', true);
	doTweenAlpha('3', 'AlertTriple', 0, 0.2, 'exponentialIn')
end

doWarningQuadruple = function()
	playSound('alertQuadruple', 1)	
	setProperty('AlertQuadruple.alpha', 1)
	objectPlayAnimation('AlertQuadruple', 'alertquad', true);
	doTweenAlpha('4', 'AlertQuadruple', 0, 0.2, 'exponentialIn')
end

doAttack = function()
    playSound('attack', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('LadyCheckDodging', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'LadyDodge', true)
		setProperty('bf.specialAnim', true)
		playSound('LadyDodge01')
	end
end

doAttackDuo = function()
    playSound('attack-double', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('LadyCheckDodging2', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'LadyDodge', true)
		setProperty('bf.specialAnim', true)
		playSound('LadyDodge01')
	end
end

doAttackTriple = function()
    playSound('attack-triple', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('LadyCheckDodging', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'LadyDodge', true)
		setProperty('bf.specialAnim', true)
		playSound('LadyDodge01')
	end
end

doAttackQuadruple = function()
    playSound('attack-quadruple', 0.75)	
	objectPlayAnimation('kill', 'fire', true);
    runTimer('LadyCheckDodging3', 0.09)
	if botPlay then
		characterPlayAnim('bf', 'LadyDodge', true)
		setProperty('bf.specialAnim', true)
		playSound('LadyDodge01')
	end
end

function onBeatHit()

    --SINGLE MECHANIC

	if Sbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Sbeat1 == curBeat then
		doWarning()
	end
	if Sbeat2 == curBeat then
	    doAttack()
		setProperty('SawBlade1.alpha', 0)
	end

    --DUO MECHANIC

    if Dbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Dbeat1 == curBeat then
		doWarningDuo()
	end
	if Dbeat2 == curBeat then
	    doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if Dbeat3 == curBeat then
	    doAttackDuo()
	end

    --TRIPLE MECHANIC

    if Tbeat0 == curBeat then
		doWarningDuo()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Tbeat1 == curBeat then
		doWarningDuo()
	end
	if Tbeat2 == curBeat then
		doWarningTriple()
	end
    if Tbeat3 == curBeat then
		doWarningTriple()
    end
	if Tbeat4 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if Tbeat5 == curBeat then
		doAttackDuo()
	end
	if Tbeat6 == curBeat then
		doAttackTriple()
	end

    --TRIPLE FAST VARIANT

    if TFbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
    if TFbeat1 == curBeat then
		doWarningTriple()
    end
	if TFbeat2 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if TFbeat3 == curBeat then
		doAttackDuo()
	end
	if TFbeat4 == curBeat then
		doAttackTriple()
	end

    --QUADRUPLE MECHANIC

    if Qbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
	if Qbeat1 == curBeat then
		doWarningDuo()
	end
	if Qbeat2 == curBeat then
		doWarningTriple()
	end
    if Qbeat3 == curBeat then
		doWarningQuadruple()
    end
	if Qbeat4 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if Qbeat5 == curBeat then
		doAttackDuo()
	end
	if Qbeat6 == curBeat then
		doAttackTriple()
	end
    if Qbeat7 == curBeat then
		doAttackQuadruple()
	end

    --QUADRUPLE FAST VARIANT

    if QFbeat0 == curBeat then
		doWarning()
		setProperty('SawBlade1.alpha', 1)
        objectPlayAnimation('SawBlade1', 'Preparing', true);
	end
    if QFbeat1 == curBeat then
		doWarningQuadruple()
    end
	if QFbeat2 == curBeat then
		doAttack()
		setProperty('SawBlade1.alpha', 0)
	end
	if QFbeat3 == curBeat then
		doAttackDuo()
	end
	if QFbeat4 == curBeat then
		doAttackTriple()
	end
    if QFbeat5 == curBeat then
		doAttackQuadruple()
	end
end
