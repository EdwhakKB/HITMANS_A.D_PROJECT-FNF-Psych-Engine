baseTextCoroMain = {'YourHeart', 'LADY'}

isBlack = false
enableChangeColor = false

local angle = 1
local angle2 = 0 --Just a set to make the stuff move when i need
local enableMovement = false
local enableMovementHUD = false
local enableMovementHard = false
local step = 2 --A simple way to fix the shit when it starts LMAO
local f = 1
local allowParticles = false --so at the start they won't spawn until i need them
local endPart = false

function mysplit (inputstr, sep)
    if sep == nil then
        sep = "%s";
    end
    local t={};
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str);
    end
    return t;
end

function onCreate()
    --HELP ME AAAKSLJHDALJKSDHAKLSJHDALKJSHDAKJLSHD -Ed
    addHaxeLibrary("FlxColor", 'flixel.util')
    makeLuaSprite('flash', 'flashcolors', -50,130)
    scaleObject('flash', 2, 2)
    addLuaSprite('flash', false)
    setProperty('flash.alpha',0)
    for i = 0,4 do
        makeLuaSprite('X'..i, 'hitmans/Visuals/iLoveYou/X', 300, 200)
        setObjectCamera('X'..i, 'camInterfaz')
        scaleObject('X'..i, 0.5, 0.5)
        scaleObject('X'..i, 0.5, 0.5)
        addLuaSprite('X'..i, false)
        setProperty('X'..i..'.alpha', 1)
        setProperty('X'..i..'.alpha', 1)

        setProperty('X'..i..'.visible', false)

        setProperty('X0.x', -250)
        setProperty('X0.y', -60)
        scaleObject('X0', 1, 1)

        setProperty('X1.x', 200)
        setProperty('X1.y', 500)
        scaleObject('X1', 0.7, 0.7)

        setProperty('X2.x', 950)
        setProperty('X2.y', 500)
        scaleObject('X2', 0.5, 0.5)

        setProperty('X3.x', 950)
        setProperty('X3.y', -150)
        scaleObject('X3', 0.85, 0.85)

        setProperty('X4.x', 620)
        setProperty('X4.y', 240)
        scaleObject('X4', 0.5, 0.5)
    end
    for i = 0,1 do
        makeLuaSprite('heart'..i, 'hitmans/Visuals/iLoveYou/A-Heart', 300, 200)
        setObjectCamera('heart'..i, 'camInterfaz')
        setObjectOrder('heart'..i, getObjectOrder('ratings') - 1)
        scaleObject('heart0', 0.5, 0.5)
        scaleObject('heart1', 0.5, 0.5)
        addLuaSprite('heart'..i, false)
        setProperty('heart0.alpha', 1)
        setProperty('heart1.alpha', 1)

        setProperty('heart'..i..'.visible', false)

        setProperty('heart0.x', 100)
        setProperty('heart1.x', 870)
    end
    for i = 0,4 do
        makeLuaSprite('na'..i, 'hitmans/Visuals/iLoveYou/NA', 0, 500)
        setObjectCamera('na'..i, 'caminterfaz')
        addLuaSprite('na'..i, false)
        setProperty('na0.x', -25)
        setProperty('na1.x', 50)
        setProperty('na2.x', 125)
        setProperty('na3.x', 375)
        setProperty('na4.x', 525)
        setProperty('na'..i..'.alpha', 0)
    end
    for i = 1,#baseTextCoroMain do
        makeLuaSprite('coroMain'..i, 'hitmans/Visuals/iLoveYou/'..baseTextCoroMain[i], 0, 500)
        setObjectCamera('coroMain'..i, 'camhud')
        addLuaSprite('coroMain'..i, false)
        setProperty('coroMain1.x',300)
        setProperty('coroMain1.alpha',0)
        setProperty('coroMain2.x',500)
        setProperty('coroMain2.alpha',0)
    end
    makeLuaSprite('flashGlow', 'whiteFrame', 0,0)
    setObjectCamera('flashGlow', 'camOTHER')
    addLuaSprite('flashGlow', false)
    setProperty('flashGlow.alpha',0)

    makeLuaSprite('City', 'hitmans/BGs/Lady/herNameIs/City', 0, 0)
    setObjectCamera('City', 'camInterfaz')
    scaleObject('City', 0.5, 0.5)
    setProperty('City.visible', false)
    addLuaSprite('City', false)

    setProperty('hitmansHUD.ratings.x',900)
    setProperty('hitmansHUD.ratingsOP.x',130)

    setProperty('hitmansHUD.ratings.y',280)
    setProperty('hitmansHUD.ratingsOP.y',280)

    setObjectCamera('hitmansHUD.ratings', 'camInterfaz')
    setObjectCamera('hitmansHUD.ratingsOP', 'camInterfaz')
    setObjectOrder('hitmansHUD.ratings',getObjectOrder('heart0')+1)
    setObjectOrder('hitmansHUD.ratingsOP',getObjectOrder('heart1')+1)
    setObjectCamera('hitmansHUD.noteScore', 'camInterfaz')
    setObjectCamera('hitmansHUD.noteScoreOp', 'camInterfaz')

    makeLuaSprite('TheLady', 'hitmans/Visuals/iLoveYou/TheLady', 0, 0)
    setObjectCamera('TheLady', 'camOTHER')
    scaleObject('TheLady', 0.5, 0.515)
    screenCenter('TheLady')
    setProperty('TheLady.visible', false)
    addLuaSprite('TheLady', false)

    makeLuaText('HerNameIsLady', 'Her', 890, 140, 120)
	setTextBorder('HerNameIsLady', 2, '000000')
	setTextSize('HerNameIsLady', 100)
    setTextFont('HerNameIsLady', 'BIRTLOVE.otf')
    setTextColor('HerNameIsLady', 'fa89de')
    setObjectCamera('HerNameIsLady', 'camOTHER')
    setProperty('HerNameIsLady.alpha', 0)
    addLuaText('HerNameIsLady', true)
	setTextAlignment('HerNameIsLady', 'left')

    makeLuaSprite('EndWords', 'hitmans/Visuals/iLoveYou/EndScreenWord', -125, 300)
    setObjectCamera('EndWords', 'camOTHER')
    scaleObject('EndWords', 1.5, 1.5)
    setProperty('EndWords.visible', false)
    addLuaSprite('EndWords', false)

    makeLuaSprite('clock', 'hitmans/Visuals/iLoveYou/timeNoMove', 800, 300)
    setObjectCamera('clock', 'camInterfaz')
    scaleObject('clock', 0.75, 0.75)
    setProperty('clock.alpha', 0)
    addLuaSprite('clock', false)

    makeLuaSprite('bigMane', 'hitmans/Visuals/iLoveYou/BIGMane', 0, 0)
    setObjectCamera('bigMane', 'camInterfaz')
    scaleObject('bigMane', 0.75, 0.75)
    setProperty('bigMane.alpha', 0)
    addLuaSprite('bigMane', false)

    makeLuaSprite('smallMane', 'hitmans/Visuals/iLoveYou/SmallMane', 0, 0)
    setObjectCamera('smallMane', 'camInterfaz')
    scaleObject('smallMane', 0.75, 0.75)
    setProperty('smallMane.alpha', 0)
    addLuaSprite('smallMane', false)

    setObjectCamera('hitmansHUD.iconP1', 'camOther')
    setObjectCamera('hitmansHUD.iconP2', 'camOther')
    setObjectCamera('hitmansHUD.healthBar', 'camOther')
    setObjectCamera('hitmansHUD.healthBarBG', 'camOther')
    setObjectCamera('hitmansHUD.scoreTxt', 'camOther')
end

function onCreatePost()
    summongHxShader('lovingGAME', 'MirrorRepeatEffect')
    setShaderProperty('lovingGAME', 'zoom', 1)
    setShaderProperty('lovingGAME', 'x', 0)
    setShaderProperty('lovingGAME', 'y', 0)
    setShaderProperty('lovingGAME', 'angle', 0)

    summongHxShader('lovingHUD', 'MirrorRepeatEffect')
    setShaderProperty('lovingHUD', 'zoom', 1)
    setShaderProperty('lovingHUD', 'x', 0)
    setShaderProperty('lovingHUD', 'y', 0)
    setShaderProperty('lovingHUD', 'angle', 0)

    summongHxShader('pixel', 'MosaicEffect')
    setShaderProperty('pixel', 'strength', 0)

    summongHxShader('Chroma', 'ChromAbEffect')
	setShaderProperty('Chroma','strength',0)

    summongHxShader('Bloom', 'BloomEffectBetter')
    setShaderProperty('Bloom','effect',5) --5
	setShaderProperty('Bloom','strength',0.2) --0.2
    setShaderProperty('Bloom','contrast',1) --1
    setShaderProperty('Bloom','brightness',0) --0
end

function onSongStart()
    setCameraShader('caminterfaz', 'lovingGAME')
    setCameraShader('caminterfaz', 'pixel')
    setCameraShader('caminterfaz', 'Chroma')
    setCameraShader('caminterfaz', 'Bloom')

    setCameraShader('camhud', 'lovingHUD')
    setCameraShader('camhud', 'pixel')
    setCameraShader('camhud', 'Chroma')
    setCameraShader('camhud', 'Bloom')

    setCameraShader('camgame', 'Bloom')

    doTweenColor('newScreenBG', 'bg', '000000', 0.01, 'linear')
    for i = 0,6 do
        doTweenColor('colorShitStartbro'..i, 'heart'..i, 'fa89de', 0.01, 'linear')
    end
    setProperty('heart0.visible', true)
    setProperty('heart1.visible', true)
    for i = 0,4 do
        doTweenColor('colorShitStartbroX'..i, 'X'..i, 'fa89de', 0.01, 'linear')
    end
    vocalsVariable('part1')
end

function onStepHit()
    if allowParticles then
        Particle()
    end
    -----SHITS FOR THE X THINGS-----
    if curStep >= 0 and curStep <= 1 then
        setShaderProperty('pixel', 'strength', 10)
        tweenShaderProperty('pixel', 'strength', 0, 20, 'easeOut')
    end
    if curStep == 128 then
        for i = 0,4 do
            setProperty('X'..i..'.visible', true)
        end
        angle = 2
    end
    if curStep == 252 or curStep == 920 or curStep == 1133 then
        angle = 2
    end
    if curStep == 264 or curStep == 272 or curStep == 432 or curStep == 440 or curStep == 880 then
        angle = -4
    end
    if curStep == 268 or curStep == 276 or curStep == 436 or curStep == 444 or curStep == 847 then
        angle = -2
    end

    if curStep == 280 or curStep == 448 or curStep == 883 or curStep == 1037 or curStep == 1153 then -- 320 - 4
        angle = 1
    end
    if curStep == 336 or curStep == 668 or curStep == 1031 or curStep == 1039 or curStep == 1137 or curStep == 1361 or curStep == 1560 then -- 376 - 56
        angle = -4
    end
    if curStep == 344 or curStep == 886 or curStep == 1028 or curStep == 1044 or curStep == 1565 then 
        angle = -2
    end
    if curStep == 378 or curStep == 477 or curStep == 665 or curStep == 844 or curStep == 1025 or curStep == 1345 or curStep == 1556 then 
        angle = 8
    end
    if curStep == 385 or curStep == 896 or curStep == 1129 or curStep == 1355 or curStep == 1571 then 
        angle = -0.2
    end

    if curStep == 465 or curStep == 617 or curStep == 674 or curStep == 1281 or curStep == 1335 or curStep == 1365 or curStep == 1548 then 
        angle = 3
    end
    if curStep == 466 or curStep == 912 or curStep == 1047 then 
        angle = 2
    end
    if curStep == 467 or curStep == 918 or curStep == 1053 then 
        angle = -1
    end

    if curStep == 471 or curStep == 481 or curStep == 613 or curStep == 1393 or curStep == 1545 then 
        angle = -2
    end
    if curStep == 472 or curStep == 564 or curStep == 733 or curStep == 868 or curStep == 1260 then 
        angle = 2
    end
    if curStep == 473 or curStep == 547 or curStep == 1125 or curStep == 1540 then 
        angle = -1
    end

    if curStep == 493 or curStep == 864 or curStep == 1095 or curStep == 1121 or curStep == 1169 or curStep == 1252 or curStep == 1538 then 
        angle = 0.8
    end

    if curStep == 496 or curStep == 541 or curStep == 589 or curStep == 609 or curStep == 729 or curStep == 1240 then 
        angle = 1
    end
    if curStep == 512 or curStep == 561 or curStep == 583 or curStep == 604  or curStep == 716 or curStep == 1245 or curStep == 1319 then 
        angle = 4
    end

    if curStep == 516 or curStep == 529 or curStep == 545 or curStep == 705 or curStep == 831 or curStep == 1020 or curStep == 1313 or curStep == 1510 then 
        angle = -4
    end

    if curStep == 599 or curStep == 641 or curStep == 695 or curStep == 827 or curStep == 832 or curStep == 1015 or curStep == 1185 or curStep == 1504 then
        angle = 5
    end

    if curStep == 621 or curStep == 689 or curStep == 830 or curStep == 841 or curStep == 1009 or curStep == 1057 or curStep == 1196 or curStep == 1484 then
        angle = -5
    end

    if curStep == 625 or curStep == 653 or curStep == 826 or curStep == 829 or curStep == 939 or curStep == 1111 or curStep == 1236 then
        angle = 0.25
    end

    if curStep == 635 or curStep == 657 or curStep == 891 or curStep == 1089 or curStep == 1178 or curStep == 1480 or curStep == 1583 then
        angle = 9
    end

    if curStep >= 757 and curStep <= 768 then
        angle = angle + 2
    end

    if curStep == 769 or curStep == 928 or curStep == 1089 or curStep == 1179 or curStep == 1231 or curStep == 1332 then
        angle = 0.8
    end

    if curStep == 849 or curStep == 944 or curStep == 1204 or curStep == 1221 or curStep == 1327 or curStep == 1408 then
        angle = -0.30
    end

    if curStep == 850 or curStep == 934 or curStep == 1079 or curStep == 1087 or curStep == 1213 or curStep == 1309 then
        angle = 0.40
    end

    if curStep == 851 or curStep == 993 or curStep == 1016 or curStep == 1083 or curStep == 1225 or curStep == 1303 then
        angle = 2
    end

    if curStep == 988 or curStep == 1073 or curStep == 1081 or curStep == 1207 or curStep == 1297 or curStep == 1399 or curStep == 1574 then
        angle = 7
    end

    if curStep == 1580 then
        setProperty('HerNameIsLady.alpha', 1)
    end
    if curStep == 1581 then
        setTextString('HerNameIsLady', 'Her  Name')
    end
    if curStep == 1582 then
        setTextString('HerNameIsLady', 'Her  Name  Is')
    end
    if curStep == 1583 then
        setProperty('EndWords.visible', true)
        setProperty('TheLady.visible', true)
        setProperty('hitmansHUD.ratings.visible',false)
        setProperty('hitmansHUD.ratingsOP.visible',false)
        setProperty('hitmansHUD.iconP1.visible', false);
		setProperty('hitmansHUD.iconP2.visible', false);
		setProperty('hitmansHUD.healthBar.visible', false);
		setProperty('hitmansHUD.scoreTxt.visible', false);
		setProperty('hitmansHUD.scoreTxtHit.visible', false);
		setProperty('hitmansHUD.healthBarHit.visible', false);
		setProperty('hitmansHUD.healthBarBG.visible', false);
		setProperty('hitmansHUD.healthHitBar.visible', false);
        endPart = false
    end
    
    if curStep == step then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == step+2 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == step+4 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == step+6 then
        vocalsAlpha('coroStart', 0.5, 3, 0.5, 'smoothStepOut') 
    elseif curStep == step+10 then
        vocalsAlpha('coroStart', 0.5, 4, 0.5, 'smoothStepOut') 
    elseif curStep == step+16 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == step+18 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == step+20 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == step+22 then
        vocalsAlpha('coroDrop', 0.5, 2, 0.8, 'smoothStepOut')

    ------------~SHOW ME YOUR HEART~-----------

    elseif curStep == step+33 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == step+35 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == step+37 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == step+38 then
        vocalsAlpha('coroStart', 0.5, 3, 0.5, 'smoothStepOut') 
    elseif curStep == step+41 then
        vocalsAlpha('coroStart', 0.5, 4, 0.5, 'smoothStepOut') 
    elseif curStep == step+44 then
        vocalsAlpha('coroDrop', 0.5, 1, 2, 'smoothStepOut')
    end

    ---------------SHADERS LMAO----------------
    if curStep == 240 or curStep == 1425 then
        tweenShaderProperty('pixel', 'strength', 5, 2, 'easeOut')
    end
    if curStep == 256 or curStep == 476 or curStep == 641 or curStep == 704 or curStep == 832 or curStep == 988 or curStep == 1456 then
        setShaderProperty('pixel', 'strength', 0)
    end
    if curStep == 444 or curStep == 957 then
        tweenShaderProperty('pixel', 'strength', 2.5, 1, 'easeOut')
    end
    if curStep == 633 then
        tweenShaderProperty('pixel', 'strength', 5, 1, 'easeOut')
    end
    if curStep == 700 then
        tweenShaderProperty('pixel', 'strength', 2.5, 0.5, 'easeOut')
    end
    if curStep == 769 then
        setShaderProperty('pixel', 'strength', 2.5)
    end
end

function onBeatHit()
    --------HER NAME IS CORO DROP SIMPLIFIED-------

    if curBeat == 16 then
        mainCoroPart(66)
    end
    if curBeat == 32 then
        changeScreen('normal', 0.01, 'linear')
        mainCoroPart(130)
    end
    if curBeat == 48 then
        mainCoroPart(194)
    end
    if curBeat == 160 then
        mainCoroPart(642)
    end
    if curBeat == 175 then
        mainCoroPart(706)
    end
    if curBeat == 364 then
        mainCoroPart(1458)
    end
    if curBeat == 380 then
        mainCoroPart(1522)
    end

    --------Change Screen simple 0.7 (yeah) shit--------

    if curBeat == 38 or curBeat == 54 or curBeat == 47 or curBeat == 94 or curBeat == 135 or curBeat == 158 or curBeat == 175 or curBeat == 303 or curBeat == 335 or curBeat == 379 then
        changeScreen('invert', 0.7, 'backInOut')
    end
    if curBeat == 40 or curBeat == 56 or curBeat == 48 or curBeat == 64 or curBeat == 136 or curBeat == 160 or curBeat == 176 or curBeat == 304 or curBeat == 336 or curBeat == 380 then
        changeScreen('normal', 0.01, 'backInOut')
    end

    --------------THIS ONE HAS NOTHING TO DO WITH THAT LMAO---------------

    if curBeat == 60 then
        changeScreen('invert', 2, 'backInOut')
    end

    --------Making the drop stuff like "lady" swap colors stuff--------

    if curBeat == 166 or curBeat == 182 or curBeat == 263 then
        changeScreen('invert', 0.4, 'backIn')
    end
    if curBeat == 167 or curBeat == 183 or curBeat == 264 then
        changeScreen('normal', 0.4, 'backOut')
    end

    ----------------------Visual effects---------------------------

    if curBeat == 64 then
        enableMovement = true
        enableMovementHUD = true
    end
    if curBeat == 96 then
        changeElements('city')
        enableChangeColor = true
        isBlack = false
    end
    if curBeat == 120-4 then
        enableChangeColor = false
        isBlack = false
    end
    if curBeat == 248-4 then
        enableChangeColor = false
    end
    if curBeat == 192 then
        angle2 = 1
        doTweenAlpha('clockShit', 'clock', 1, 4, 'quartOut')
        doTweenY('clockShitY', 'clock', 100, 4, 'quartOut')
        doTweenX('clockShitX', 'clock', 500, 4, 'quartOut')
    end
    if curBeat == 196 then
        doTweenAlpha('clockShit', 'clock', 0, 4, 'quartIn')
        doTweenY('clockShitY', 'clock', 300, 4, 'quartIn')
        doTweenX('clockShitX', 'clock', 200, 4, 'quartIn')
    end

    ----------SUBSET OF THE VISUALS, in this case the bg and the hearts--------
    if curBeat == 120 or curBeat == 208 or curBeat == 248 or curBeat == 364 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 224 then
        changeScreen('invert', 0.01, 'backInOut')
        enableChangeColor = true
        isBlack = false
    end
    if curBeat == 356 then
        changeScreen('invertEX', 3, 'backInOut')
    end
    --this bussy city uk?----
    if curBeat == 110 then
        doTweenAlpha('bussy', 'City', 0, 0.3, 'easeOut')
    end
    ---my heart~---
    if curBeat == 111 then
        changeElements('hearts')
    end
    ----oh cute!~----
    if curBeat == 189 then
        changeScreen('invertEX', 5, 'backOut')
        allowParticles = true
    end


    ---------FROM HERE AND FAR ITS THE VISUAL SHIT I DID----------
    if curBeat == 192 then
        enableMovement = false
        enableMovementHUD = false
    end
    if curBeat == 205 then
        enableMovement = true
        enableMovementHUD = true
    end
    if curBeat == 364 then
        endPart = true
        enableMovement = false
        enableMovementHUD = false
        enableMovementHard = true
    end
    if curBeat == 396 then
        changeScreen('invert', 0.01, 'backInOut')
        for i = 0,1 do
            setProperty('heart'..i..'.visible', false)
        end
        for i = 0,4 do
            setProperty('X'..i..'.visible', false)
        end
    end
    if curBeat %2 == 0 then
        heartBump('heart0', 0.7, 'smoothStepOut', 0.5, 0.5)
    elseif curBeat %2 == 1 then
        heartBump('heart1', 0.7, 'smoothStepOut', 0.5, 0.5)
    end
    if enableMovement then
        if curBeat %4 == 0 then
            lovingPotion('GAME', 'x', -0.02, 1.1, 'smoothStepInOut')
            lovingPotion('GAME', 'y', 0.03, 1.1, 'smoothStepInOut')
        elseif curBeat %4 == 2 then
            lovingPotion('GAME', 'x', 0.02, 1.1, 'smoothStepInOut')
            lovingPotion('GAME', 'y', -0.03, 1.1, 'smoothStepInOut')
        end
        if curBeat %8 == 0 then
            lovingPotion('GAME', 'angle', -2.5, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 2 then
            lovingPotion('GAME', 'angle', 2.5, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 4 then
            lovingPotion('GAME', 'angle', 4, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 6 then
            lovingPotion('GAME', 'angle', -1.5, 1.1, 'smoothStepInOut')
        end
    elseif not enableMovement and not enableMovementHard then
        setShaderProperty('lovingGAME', 'zoom', 1)
        setShaderProperty('lovingGAME', 'x', 0)
        setShaderProperty('lovingGAME', 'y', 0)
        setShaderProperty('lovingGAME', 'angle', 0)
    end
    if enableMovementHUD then
        if curBeat %4 == 0 then
            lovingPotion('HUD', 'x', -0.02, 1.1, 'smoothStepInOut')
            lovingPotion('HUD', 'y', 0.03, 1.1, 'smoothStepInOut')
        elseif curBeat %4 == 2 then
            lovingPotion('HUD', 'x', 0.02, 1.1, 'smoothStepInOut')
            lovingPotion('HUD', 'y', -0.03, 1.1, 'smoothStepInOut')
        end
        if curBeat %8 == 0 then
            lovingPotion('HUD', 'angle', -2.5, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 2 then
            lovingPotion('HUD', 'angle', 2.5, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 4 then
            lovingPotion('HUD', 'angle', 4, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 6 then
            lovingPotion('HUD', 'angle', -1.5, 1.1, 'smoothStepInOut')
        end
    elseif not enableMovementHard and not enableMovementHUD then
        setShaderProperty('lovingHUD', 'zoom', 1)
        setShaderProperty('lovingHUD', 'x', 0)
        setShaderProperty('lovingHUD', 'y', 0)
        setShaderProperty('lovingHUD', 'angle', 0)
    end
    if enableMovementHard then
        if curBeat %4 == 0 then
            lovingPotion('HUD', 'x', 0.04, 1.1, 'smoothStepInOut')
            lovingPotion('HUD', 'y', 0.08, 1.1, 'smoothStepInOut')

            lovingPotion('GAME', 'x', -0.04, 1.1, 'smoothStepInOut')
            lovingPotion('GAME', 'y', 0.08, 1.1, 'smoothStepInOut')
        elseif curBeat %4 == 2 then
            lovingPotion('HUD', 'x', -0.06, 1.1, 'smoothStepInOut')
            lovingPotion('HUD', 'y', -0.04, 1.1, 'smoothStepInOut')

            lovingPotion('GAME', 'x', 0.06, 1.1, 'smoothStepInOut')
            lovingPotion('GAME', 'y', -0.08, 1.1, 'smoothStepInOut')
        end
        if curBeat %8 == 0 then
            lovingPotion('HUD', 'angle', -4, 1.1, 'smoothStepInOut')

            lovingPotion('GAME', 'angle', -4, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 2 then
            lovingPotion('HUD', 'angle', 3.5, 1.1, 'smoothStepInOut')

            lovingPotion('GAME', 'angle', 4, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 4 then
            lovingPotion('HUD', 'angle', 5, 1.1, 'smoothStepInOut')

            lovingPotion('GAME', 'angle', 7, 1.1, 'smoothStepInOut')
        elseif curBeat %8 == 6 then
            lovingPotion('HUD', 'angle', -2, 1.1, 'smoothStepInOut')

            lovingPotion('GAME', 'angle', -6, 1.1, 'smoothStepInOut')
        end 
    elseif not enableMovement and not enableMovementHard and not enableMovementHUD then
        setShaderProperty('lovingGAME', 'zoom', 1)
        setShaderProperty('lovingGAME', 'x', 0)
        setShaderProperty('lovingGAME', 'y', 0)
        setShaderProperty('lovingGAME', 'angle', 0)

        setShaderProperty('lovingHUD', 'zoom', 1)
        setShaderProperty('lovingHUD', 'x', 0)
        setShaderProperty('lovingHUD', 'y', 0)
        setShaderProperty('lovingHUD', 'angle', 0)
    end
    if endPart then
        if curBeat %4 == 0 then
            changeScreen('invert', 1, 'backOut')
        elseif curBeat %4 == 2 then
            changeScreen('normal', 1, 'backOut')
        end
    end
end

local allowColorChange = false

local numberVar = 0
local theAlphaEase = 'linear'

local colorType = 'default' --added this to fix the issue when you change the colors all shits that became that color alpha to 1 lmao (will fix in source in a future)
local datime = 0.01 --no crash
local daease = 'linear' --default ease to antiCrash lmao

function vocalsAlpha(style, mainAlpha, num, time, ease)
    numberVar = num
    theAlphaEase = ease
    if style == 'coroStart' then
        theVariableTxt = 'na'
        setProperty('na'..num..'.alpha', mainAlpha)
    end
    if style == 'coroDrop' then
        theVariableTxt = 'coroMain'
        setProperty('coroMain'..num..'.alpha', mainAlpha)
    end
    if colorType == 'normal' then
        doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, '000000', datime, daease)
    elseif colorType == 'invert' then
        doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, 'ffffff', datime, daease)
    elseif colorType == 'invertWhite' then
        doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, 'ffffff', datime, daease)
    end
    doTweenAlpha('AlphaIn'..style..num, theVariableTxt..num, 0, time, ease)
end

function heartBump(heart, bumbValue, ease, time, endBumpValue)
    setProperty(heart..'.scale.x', bumbValue)
    setProperty(heart..'.scale.y', bumbValue)

    doTweenX(heart..'x', heart..'.scale', endBumpValue, time, ease)
    doTweenY(heart..'y', heart..'.scale', endBumpValue, time, ease)
end

function lovingPotion(style, variable, value, time, ease)
    tweenShaderProperty("loving"..style, variable, value, time, ease)
end

function mainCoroPart(val)
    step = val --Simple set up for a useless/useful function LMAO
end
function changeElements(style)
    if style == 'hearts' then
        for i = 0,1 do
            doTweenAlpha('heartVis'..i, 'heart'..i, 1, 0.3, 'easeOut')
            setProperty('heart'..i..'.visible', true)
        end
        for i = 0,4 do
            doTweenAlpha('XStuff'..i, 'X'..i, 1, 0.3, 'easeOut')
            setProperty('X'..i..'.visible', true)
        end
        setProperty('City.visible', false)
    elseif style == 'city' then
        for i = 0,1 do
            doTweenAlpha('heartVis'..i, 'heart'..i, 0, 0.3, 'easeOut')
            setProperty('heart'..i..'.visible', false)
        end
        for i = 0,4 do
            doTweenAlpha('XStuff'..i, 'X'..i, 0, 0.3, 'easeOut')
            setProperty('X'..i..'.visible', false)
        end
        setProperty('City.visible', true)
    elseif 'loving' then
        for i = 0,1 do
            doTweenAlpha('heartVis'..i, 'heart'..i, 0, 0.3, 'easeOut')
            setProperty('heart'..i..'.visible', false)
        end
        for i = 0,4 do
            doTweenAlpha('XStuff'..i, 'X'..i, 0, 0.3, 'easeOut')
            setProperty('X'..i..'.visible', false)
        end
        setProperty('City.visible', false)
    end
end

function changeScreen(newScreen, time, ease)
    cancelTimer('disable')
    colorType = newScreen
    if newScreen == 'normal' then
        doTweenColor('newScreenBG', 'bg', 'ffffff', time, ease)
        doTweenColor('City', 'City', 'fa89de', time, ease)
        triggerEvent('pink toggle', 'true', nil);
        for i = 0,1 do
            doTweenColor('newHearts'..i, 'heart'..i, '000000', time, ease)
        end
        for i = 0,4 do
            doTweenColor('newX'..i, 'X'..i, '000000', time, ease)
        end
        allowColorChange = true
        setProperty('flash.alpha', 0)
        setProperty('flashGlow.alpha', 0)
    elseif newScreen == 'invert' then
        doTweenColor('newScreenBG', 'bg', '000000', time, ease)
        doTweenColor('City', 'City', 'ffffff', time, ease)
        triggerEvent('pink toggle', 'false', nil);
        for i = 0,6 do
            doTweenColor('newHearts'..i, 'heart'..i, 'fa89de', time, ease)
        end
        for i = 0,4 do
            doTweenColor('newX'..i, 'X'..i, 'fa89de', time, ease)
        end
        allowColorChange = true
        setProperty('flash.alpha', 0)
        setProperty('flashGlow.alpha', 0)
    elseif newScreen == 'invertWhite' then
        doTweenColor('newScreenBG', 'bg', '000000', time, ease)
        triggerEvent('pink toggle', 'false', nil);
        for i = 0,6 do
            doTweenColor('newHearts'..i, 'heart'..i, 'ffffff', time, ease)
        end
        for i = 0,4 do
            doTweenColor('newX'..i, 'X'..i, 'ffffff', time, ease)
        end
        allowColorChange = true
        setProperty('flash.alpha', 0)
        setProperty('flashGlow.alpha', 0)
    elseif newScreen == 'invertEX' then
        doTweenAlpha('flash', 'flash', 1, time, ease)
        doTweenAlpha('flashG', 'flashGlow', 1, time, ease)
        setProperty('part'..f..'.color', 'ffffff')
        for i = 0,6 do
            doTweenColor('newHearts'..i, 'heart'..i, '000000', time, ease)
        end
        for i = 0,4 do
            doTweenColor('newX'..i, 'X'..i, '000000', time, ease)
        end
        runTimer('togglePink', time)
        allowColorChange = true
    end
    runTimer('disable', 1)
end

function vocalsVariable(var)
    if var == 'part1' then
        for i = 0,4 do
            setProperty('na'..i..'.visible', true)
        end
        for i = 1,#baseTextCoroMain do
            setProperty('coroMain'..i..'.visible', true)
        end
    else
        for i = 0,4 do
            setProperty('na'..i..'.visible', false)
        end
        for i = 1,#baseTextCoroMain do
            setProperty('coroMain'..i..'.visible', false)
        end
    end
end

function onTimerComplete(t)
    if t == 'disable' then
        -- allowColorChange = false
    end
    if t == 'togglePink' then
        triggerEvent('pink toggle', 'true');
    end
end

local ease2 = 'linear'
local easeOut = 'linear'
local alreadyAdded = false
function onEvent(n,v1,v2)
	local table=mysplit(v2,",");
	local tablev1=mysplit(v1,",");
	ease2 = table[2]
	if n == 'Chromatic Aberration' then

		if tablev1[1] == 'set' then
			setShaderProperty('Chroma','strength',tablev1[2])
			tweenShaderProperty('Chroma', 'strength', 0, table[1], ease2)
		elseif tablev1[1] == 'ease' then
			tweenShaderProperty('Chroma', 'strength', tablev1[2], table[1], ease2)
		end
		
	end
end

function Particle()
    songPos = getSongPosition()
    currentBeat = (songPos/500)
    f = f + 1
    sus = math.random(2, 1500)
    sus2 = math.random(2, 1500)
    sus3 = math.random(0.15, 0.3)
    makeLuaSprite('part' .. f, 'hitmans/Visuals/iLoveYou/LovingDestiny', math.random(500, 2000), 1600)
    setObjectCamera('part'..f, 'caminterfaz')
    setBlendMode('part'..f, 'add')
    if colorType == 'normal' then
        setProperty('part'..f..'.color', '000000')
    elseif colorType == 'invert' then
        setProperty('part'..f..'.color', 'ffffff')
    elseif colorType == 'invertWhite' then
        setProperty('part'..f..'.color', 'ffffff')
    end
    setProperty('part'..f..'.alpha', 0.55)
    doTweenY(sus, 'part' .. f, -900*math.tan((currentBeat+1*0.1)*math.pi), 6)
    doTweenX(sus2, 'part' .. f, -900*math.sin((currentBeat+1*0.1)*math.pi), 6)
    doTweenAlpha('Love'..f, 'part'..f, 0, 6)

    scaleObject('part' .. f, sus3, sus3);
      
    addLuaSprite('part' .. f, true)
  
    if f >= 50 then
        f = 1
    end
end

function onTweenComplete(t)
    for i = 0,50 do --since it goes to 50 ig
        if t == 'Love'..i then
            removeLuaSprite('part'..i)
        end
    end
end

function onUpdate(elapsed)
    setProperty('bigMane.angle', getProperty('bigMane.angle') + getProperty('clock.angle') + angle2/2)
    setProperty('smallMane.angle', getProperty('smallMane.angle') + angle2)
    setProperty('bigMane.x', getProperty('clock.x'))
    setProperty('smallMane.x', getProperty('clock.x'))
    setProperty('bigMane.y', getProperty('clock.y'))
    setProperty('smallMane.y', getProperty('clock.y'))
    setProperty('bigMane.alpha', getProperty('clock.alpha'))
    setProperty('smallMane.alpha', getProperty('clock.alpha'))

    setProperty('X0.angle',(getProperty('X0.angle') + angle/2)/playbackRate)
    setProperty('X1.angle',(getProperty('X1.angle') + angle/4*-1)/playbackRate)
    setProperty('X2.angle',(getProperty('X2.angle') + angle/5)/playbackRate)
    setProperty('X3.angle',(getProperty('X3.angle') + angle/8)/playbackRate)
    setProperty('X4.angle',(getProperty('X4.angle') + angle/7*-1)/playbackRate)
end

function onUpdatePost(elapsed)
    if enableChangeColor then
        if not isBlack then
            runHaxeCode([[
                for (note in game.notes) {
                    if (!note.isSustainNote){
                        note.rgbShader.r = 0xfffa89de;
                        note.rgbShader.g = 0xfffa89de;
                        note.rgbShader.b = 0xfffa89de;
                    }else{
                        note.rgbShader.r = note.prevNote.rgbShader.r;
                        note.rgbShader.g = note.prevNote.rgbShader.g;
                        note.rgbShader.b = note.prevNote.rgbShader.b;
                    }
                }
            ]])
        else
            runHaxeCode([[
                for (note in game.notes) {
                    if (!note.isSustainNote){
                        note.rgbShader.r = 0xff000000;
                        note.rgbShader.g = 0xff000000;
                        note.rgbShader.b = 0xff000000;
                    }else{
                        note.rgbShader.r = note.prevNote.rgbShader.r;
                        note.rgbShader.g = note.prevNote.rgbShader.g;
                        note.rgbShader.b = note.prevNote.rgbShader.b;  
                    }
                }
            ]])
        end
    end
end