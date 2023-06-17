baseTextCoroMain = {'YourHeart', 'LADY'}
coro = {'PasasDeMi', 'NoMeImporta', "boyIDon'tCry", 'MuchosHombres', 'LocosPorMi', 'SoyUnaChicaOcupada'}

texts = {'dudar', 'disgustarEso', 'conocerme', 'siEsAsi', 'NoDesLaVuelta', 'DimeDirectamente', 'TiempoParaTi', 'CiudadOcupada', 'NoTeEspera', 'bebe,Bebe'}
texts2 = {'TicTac', 'ElTiempoNoSeDetiene', 'QueEsEso', 'SerAsi,Vete', 'UnaYOtraTeQuedaras', 'TeArrepientas', 'MiExpresionFria', 'SeEstaEnfriando', 'Frustrante', 'bebe,Bebe'}
lastTexts = {'Apurate', 'Ocupada'}

local angle = 1

function onCreate()
    --HELP ME AAAKSLJHDALJKSDHAKLSJHDALKJSHDAKJLSHD -Ed
    makeLuaSprite('flash', 'flashcolors', -50,130)
    scaleObject('flash', 2, 2)
    addLuaSprite('flash', false)
    setProperty('flash.alpha',0)
    for i = 0,4 do
        makeLuaSprite('X'..i, 'hitmans/Visuals/iLoveYou/X', 300, 200)
        setObjectCamera('X'..i, 'camHUD')
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
        setObjectCamera('heart'..i, 'camHUD')
        scaleObject('heart0', 0.5, 0.5)
        scaleObject('heart1', 0.5, 0.5)
        addLuaSprite('heart'..i, false)
        setProperty('heart0.alpha', 1)
        setProperty('heart1.alpha', 1)

        setProperty('heart'..i..'.visible', false)

        setProperty('heart0.x', 100)
        setProperty('heart1.x', 900)
    end
    for i = 0,7 do
        makeLuaSprite('na'..i, 'hitmans/Visuals/iLoveYou/NA', 0, 500)
        setObjectCamera('na'..i, 'camOTHER')
        addLuaSprite('na'..i, false)
        setProperty('na0.x', -25)
        setProperty('na1.x', 50)
        setProperty('na2.x', 125)
        setProperty('na3.x', 300)
        setProperty('na4.x', 375)
        setProperty('na5.x', 450)
        setProperty('na6.x', 525)
        setProperty('na7.x', 600)
        setProperty('na'..i..'.alpha', 0)
    end
    for i = 1,#baseTextCoroMain do
        makeLuaSprite('coroMain'..i, 'hitmans/Visuals/iLoveYou/'..baseTextCoroMain[i], 0, 500)
        setObjectCamera('coroMain'..i, 'camOTHER')
        addLuaSprite('coroMain'..i, false)
        setProperty('coroMain1.x',300)
        setProperty('coroMain1.alpha',0)
        setProperty('coroMain2.x',500)
        setProperty('coroMain2.alpha',0)
    end
    for i = 1,#coro do
        makeLuaSprite('coro'..i, 'hitmans/Visuals/iLoveYou/'..coro[i], 300, 500)
        setObjectCamera('coro'..i, 'camOTHER')
        addLuaSprite('coro'..i, false)
        setProperty('coro'..i..'.visible', false)
        setProperty('coro'..i..'.alpha', 0)
    end
    for i = 1,#texts do
        makeLuaSprite('textA-'..i, 'hitmans/Visuals/iLoveYou/'..texts[i], 300, 500)
        setObjectCamera('textA-'..i, 'camOTHER')
        addLuaSprite('textA-'..i, false)
        setProperty('textA-'..i..'.visible', false)
        setProperty('textA-'..i..'.alpha', 0)
    end
    for i = 1,#texts2 do
        makeLuaSprite('textB-'..i, 'hitmans/Visuals/iLoveYou/'..texts2[i], 300, 500)
        setObjectCamera('textB-'..i, 'camOTHER')
        addLuaSprite('textB-'..i, false)
        setProperty('textB-'..i..'.visible', false)
        setProperty('textB-'..i..'.alpha', 0)
    end
    for i = 1,#lastTexts do
        makeLuaSprite('textC-'..i, 'hitmans/Visuals/iLoveYou/'..lastTexts[i], 300, 500)
        setObjectCamera('textC-'..i, 'camOTHER')
        addLuaSprite('textC-'..i, false)
        setProperty('textC-'..i..'.visible', false)
        setProperty('textC-'..i..'.alpha', 0)
    end
    makeLuaSprite('flashGlow', 'whiteFrame', 0,0)
    setObjectCamera('flashGlow', 'camOTHER')
    addLuaSprite('flashGlow', false)
    setProperty('flashGlow.alpha',0)
end

function onSongStart()
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
    -----THE START PART (NA x8 + lady and show me your heart)-----
    if curStep == 5 or curStep == 69 or curStep == 134 or curStep == 196 or curStep == 260 or curStep == 324 or curStep == 388 or curStep == 452 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == 9 or curStep == 73 or curStep == 137 or curStep == 200 or curStep == 264 or curStep == 328 or curStep == 392 or curStep == 456 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == 13 or curStep == 77 or curStep == 140 or curStep == 203 or curStep == 268 or curStep == 332 or curStep == 396 or curStep == 460 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == 18 or curStep == 81 or curStep == 145 or curStep == 209 or curStep == 272 or curStep == 336 or curStep == 400 or curStep == 464 then
        vocalsAlpha('coroStart', 0.5, 3, 0.3, 'smoothStepOut') 
    elseif curStep == 20 or curStep == 83 or curStep == 147 or curStep == 211 or curStep == 274 or curStep == 338 or curStep == 402 or curStep == 466 then
        vocalsAlpha('coroStart', 0.5, 4, 0.3, 'smoothStepOut') 
    elseif curStep == 22 or curStep == 85 or curStep == 149 or curStep == 213 or curStep == 276 or curStep == 340 or curStep == 404 or curStep == 468 then
        vocalsAlpha('coroStart', 0.5, 5, 0.3, 'smoothStepOut')
    elseif curStep == 24 or curStep == 87 or curStep == 151 or curStep == 215 or curStep == 278 or curStep == 342 or curStep == 406 or curStep == 470 then
        vocalsAlpha('coroStart', 0.5, 6, 0.3, 'smoothStepOut')
    elseif curStep == 27 or curStep == 90 or curStep == 153 or curStep == 217 or curStep == 280 or curStep == 344 or curStep == 408 or curStep == 472 then
        vocalsAlpha('coroStart', 0.5, 7, 0.3, 'smoothStepOut')
    elseif curStep == 37 or curStep == 164 or curStep == 292 or curStep == 420 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == 41 or curStep == 169 or curStep == 296 or curStep == 424 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == 45 or curStep == 172 or curStep == 300 or curStep == 428  then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == 50 or curStep == 177 or curStep == 304 or curStep == 432 then
        vocalsAlpha('coroDrop', 0.5, 2, 0.8, 'smoothStepOut')
    elseif curStep == 93 or curStep == 220 or curStep == 348 or curStep == 476 then
        vocalsAlpha('coroDrop', 0.5, 1, 2, 'smoothStepOut')
    end

    -----VOCALS PART 1 (she gives you a chance)-----
    if curStep == 512 then
        vocalsVariable('part2')
        vocalsAlpha('part1', 0.5, 1, 2, 'smoothStepOut')
    end
    if curStep == 543 then
        vocalsAlpha('part1', 0.5, 2, 1.2, 'smoothStepOut')
    end
    if curStep == 562 then
        vocalsAlpha('part1', 0.5, 3, 3, 'smoothStepOut')
    end
    if curStep == 603 then
        vocalsAlpha('part1', 0.5, 4, 2, 'smoothStepOut')
    end
    if curStep == 638 then
        vocalsAlpha('part1', 0.5, 5, 2, 'smoothStepOut')
    end
    if curStep == 670 then
        vocalsAlpha('part1', 0.5, 6, 2, 'smoothStepOut')
    end
    if curStep == 690 then
        vocalsAlpha('part1', 0.5, 7, 4.2, 'smoothStepOut')
    end
    if curStep == 766 then
        vocalsAlpha('part1', 0.5, 8, 4, 'smoothStepOut')
    end
    if curStep == 828 then
        vocalsAlpha('part1', 0.5, 9, 4, 'smoothStepOut')
    end
    if curStep == 888 then
        vocalsAlpha('part1', 0.5, 10, 5, 'smoothStepOut')
    end

    -----CORO PART 1 (she explains that chance its the only one you have)-----
    if curStep == 965 then
        vocalsVariable('coro')
        vocalsAlpha('coro', 0.5, 1, 3, 'smoothStepOut')    
    end
    if curStep == 1013 then
        vocalsAlpha('coro', 0.5, 2, 2, 'smoothStepOut')    
    end
    if curStep == 1054 then
        vocalsAlpha('coro', 0.5, 3, 2, 'smoothStepOut')    
    end
    if curStep == 1090 then
        vocalsAlpha('coro', 0.5, 4, 4, 'smoothStepOut')    
    end
    if curStep == 1141 then
        vocalsAlpha('coro', 0.5, 5, 4, 'smoothStepOut')    
    end
    if curStep == 1213 then
        vocalsAlpha('coro', 0.5, 6, 5, 'smoothStepOut')    
    end

    -----THE HARD PART (NA x8 + lady and show me your heart)-----
    if curStep == 1280 then
        vocalsVariable('part1')
    end
    if curStep == 1284 or curStep == 1348 or curStep == 1412 or curStep == 1476 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == 1288 or curStep == 1352 or curStep == 1416 or curStep == 1480 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == 1292 or curStep == 1356 or curStep == 1420 or curStep == 1484 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == 1296 or curStep == 1360 or curStep == 1424 or curStep == 1488 then
        vocalsAlpha('coroStart', 0.5, 3, 0.3, 'smoothStepOut') 
    elseif curStep == 1298 or curStep == 1362 or curStep == 1426 or curStep == 1490 then
        vocalsAlpha('coroStart', 0.5, 4, 0.3, 'smoothStepOut') 
    elseif curStep == 1300 or curStep == 1364 or curStep == 1428 or curStep == 1492 then
        vocalsAlpha('coroStart', 0.5, 5, 0.3, 'smoothStepOut')
    elseif curStep == 1302 or curStep == 1366 or curStep == 1430 or curStep == 1494 then
        vocalsAlpha('coroStart', 0.5, 6, 0.3, 'smoothStepOut')
    elseif curStep == 1304 or curStep == 1368 or curStep == 1432 or curStep == 1496 then
        vocalsAlpha('coroStart', 0.5, 7, 0.3, 'smoothStepOut')
    elseif curStep == 1316 or curStep == 1444 or curStep == 1444 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == 1320 or curStep == 1448 or curStep == 1448 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == 1324 or curStep == 1452 or curStep == 1452 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == 1328 or curStep == 1456 or curStep == 1444 then
        vocalsAlpha('coroDrop', 0.5, 2, 0.8, 'smoothStepOut')
    elseif curStep == 1372 or curStep == 1500 then
        vocalsAlpha('coroDrop', 0.5, 1, 2, 'smoothStepOut')
    end

    -----SHE IS DISSAPOINTED WITH YOU-----
    if curStep == 1536 then
        vocalsVariable('part3')
        vocalsAlpha('part2', 0.5, 1, 3, 'smoothStepOut')
    end
    if curStep == 1568 then
        vocalsAlpha('part2', 0.5, 2, 3, 'smoothStepOut')
    end
    if curStep == 1588 then
        vocalsAlpha('part2', 0.5, 3, 3, 'smoothStepOut')
    end
    if curStep == 1620 then
        vocalsAlpha('part2', 0.5, 4, 2.4, 'smoothStepOut')
    end
    if curStep == 1664 then
        vocalsAlpha('part2', 0.5, 5, 3, 'smoothStepOut')
    end
    if curStep == 1720 then
        vocalsAlpha('part2', 0.5, 6, 3, 'smoothStepOut')
    end
    if curStep == 1791 then
        vocalsAlpha('part2', 0.5, 7, 4, 'smoothStepOut')
    end
    if curStep == 1850 then
        vocalsAlpha('part2', 0.5, 8, 4, 'smoothStepOut')
    end
    if curStep == 1910 then
        vocalsAlpha('part2', 0.5, 9, 4, 'smoothStepOut')
    end

    -----CORO PART 2 (she explains Again that chance its the only one you have)-----
    if curStep == 1982 or curStep == 2302 or curStep == 2556 then
        vocalsVariable('coro')
        vocalsAlpha('coro', 0.5, 1, 3, 'smoothStepOut')    
    end
    if curStep == 2033 or curStep == 2358 or curStep == 2608 then
        vocalsAlpha('coro', 0.5, 2, 2, 'smoothStepOut')    
    end
    if curStep == 2073 or curStep == 2391 or curStep == 2647 then
        vocalsAlpha('coro', 0.5, 3, 2, 'smoothStepOut')    
    end
    if curStep == 2110 or curStep == 2428 or curStep == 2684 then
        vocalsAlpha('coro', 0.5, 4, 4, 'smoothStepOut')    
    end
    if curStep == 2161 or curStep == 2480 or curStep == 2736 then
        vocalsAlpha('coro', 0.5, 5, 4, 'smoothStepOut')    
    end
    if curStep == 2237 then
        vocalsAlpha('coro', 0.5, 6, 5, 'smoothStepOut')    
    end

    -----HURRY!, SHE WILL JUST LEAVE IF YOU DON'T DO NOTHING!-----
    if curStep == 2806 then
        vocalsVariable('part3end')
        vocalsAlpha('lastPart', 0.5, 1, 3, 'smoothStepOut')    
    end
    if curStep == 2886 then
        vocalsAlpha('lastPart', 0.5, 2, 2, 'smoothStepOut')    
    end

    -----THE HARD PART (NA x8 + lady and show me your heart)-----
    if curStep == 2905 then
        vocalsVariable('part1')
    end
    if curStep == 2909 or curStep == 2973 or curStep == 3037 or curStep == 3101 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == 2913 or curStep == 2977 or curStep == 3041 or curStep == 3105 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == 2917 or curStep == 2981 or curStep == 3045 or curStep == 3109 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == 2921 or curStep == 2985 or curStep == 3049 or curStep == 3113 then
        vocalsAlpha('coroStart', 0.5, 3, 0.3, 'smoothStepOut') 
    elseif curStep == 2923 or curStep == 2987 or curStep == 3051 or curStep == 3115 then
        vocalsAlpha('coroStart', 0.5, 4, 0.3, 'smoothStepOut') 
    elseif curStep == 2925 or curStep == 2989 or curStep == 3053 or curStep == 3117 then
        vocalsAlpha('coroStart', 0.5, 5, 0.3, 'smoothStepOut')
    elseif curStep == 2927 or curStep == 2991 or curStep == 3055 or curStep == 3119 then
        vocalsAlpha('coroStart', 0.5, 6, 0.3, 'smoothStepOut')
    elseif curStep == 2929 or curStep == 2993 or curStep == 3057 or curStep == 3121 then
        vocalsAlpha('coroStart', 0.5, 7, 0.3, 'smoothStepOut')
    elseif curStep == 2941 or curStep == 3069 then
        vocalsAlpha('coroStart', 0.5, 0, 0.3, 'smoothStepOut')
    elseif curStep == 2945 or curStep == 3073 then
        vocalsAlpha('coroStart', 0.5, 1, 0.3, 'smoothStepOut')
    elseif curStep == 2949 or curStep == 3077 then
        vocalsAlpha('coroStart', 0.5, 2, 0.3, 'smoothStepOut')
    elseif curStep == 2953 or curStep == 3081 then
        vocalsAlpha('coroDrop', 0.5, 2, 0.8, 'smoothStepOut')
    elseif curStep == 2997 or curStep == 3125 then
        vocalsAlpha('coroDrop', 0.5, 1, 2, 'smoothStepOut')
    end


    -----SHITS FOR THE X THINGS-----
    if curStep == 248 then
        for i = 0,4 do
            setProperty('X'..i..'.visible', true)
        end
        angle = 4
    end
    if curStep == 252 then
        angle = 2
    end
    if curStep == 304 or curStep == 312 or curStep == 432 or curStep == 440 then
        angle = -4
    end
    if curStep == 308 or curStep == 316 or curStep == 436 or curStep == 444 then
        angle = -2
    end
    if curStep == 320 or curStep == 448 then
        angle = 1
    end
    if curStep == 376 then
        angle = -4
    end
    if curStep == 384 then
        angle = -2
    end
    if curStep == 512 then
        angle = 5
    end
    if curStep == 516 then
        angle = 1
    end
    if curStep == 529 then
        angle = 2
    end
    if curStep == 533 then
        angle = -4
    end
    if curStep == 538 or curStep == 551 or curStep == 595 or curStep == 600 or curStep == 626 then
        angle = 1
    end
    if curStep == 543 or curStep == 547 or curStep == 624 then
        angle = -8
    end
    if curStep == 545 or curStep == 549 then
        angle = -8
    end
    if curStep == 593 or curStep == 597 then
        angle = 4
    end 
    if curStep == 638 then
        angle = 8
    end
    if curStep == 640 then
        angle = 1
    end
    if curStep == 656 then
        angle = 4
    end
    if curStep == 658 then
        angle = 1
    end
    if curStep == 660 or curStep == 670 or curStep == 720 or curStep == 724 then
        angle = 4
    end
    if curStep == 662 or curStep == 678 or curStep == 722 or curStep == 726 then
        angle = 1
    end
    if curStep == 750 then
        angle = 2.5
    end
    if curStep == 766 then
        angle = 0.5
    end
    if curStep == 962 then
        angle = 4
    end
    if curStep == 964 then
        angle = 1
    end
    if curStep == 1013 then
        angle = -2
    end
    if curStep == 1090 then
        angle = -4
    end
    if curStep == 1092 then
        angle = -1
    end
    if curStep == 1142 then
        angle = 2
    end
    if curStep == 1217 then
        angle = 4
    end
    if curStep == 1219 then
        angle = 0.5
    end
    if curStep == 1272 then
        angle = 2
    end
    if curStep == 1274 then
        angle = 1
    end
    if curStep == 1276 then
        angle = 2.2
    end
    if curStep == 1280 then
        angle = 4
    end
    if curStep == 1282 then
        angle = 1
    end
    if curStep == 1328 or curStep == 1336 or curStep == 1456 or curStep == 1464 then
        angle = 4
    end
    if curStep == 1330 or curStep == 1338 or curStep == 1458 or curStep == 1466 then
        angle = 2
    end
    if curStep == 1400 then
        angle = -4
    end
    if curStep == 1410 then
        angle = 1
    end
    if curStep == 1472 then
        angle = -1
    end
    if curStep == 1520 then
        angle = -4
    end
    if curStep == 1536 or curStep == 1791 then
        angle = -0.2
    end
    if curStep == 1651 or curStep == 1657 then
        angle = 2
    end
    if curStep == 1653 or curStep == 1659 then
        angle = -2
    end
    if curStep == 1664 or curStep == 1681 or curStep == 1776 then
        angle = -4
    end
    if curStep == 1668 or curStep == 1682 or curStep == 1687 or curStep == 1702 or curStep == 1718 then
        angle = 1
    end
    if curStep == 1685 or curStep == 1694 or curStep == 1714 or curStep == 1982 then
        angle = 4
    end
    if curStep == 1986 then
        angle = 2
    end
    if curStep == 2033 then
        angle = -2
    end
    if curStep == 2100 or curStep == 2420 or curStep == 2556 or curStep == 2676 then
        angle = 4
    end
    if curStep == 2110 or curStep == 2352 or curStep == 2736 then
        angle = 2
    end
    if curStep == 2161 or curStep == 2480 or curStep == 2608 then
        angle = -2
    end
    if curStep == 2237 then
        angle = 0.2
    end
    if curStep == 2300 then
        angle = 4
    end
    if curStep == 2304 or curStep == 2428 or curStep == 2460 or curStep == 2684 then
        angle = 1
    end
    if curStep == 2810 then
        angle = -0.23
    end
    if curStep == 2905 or curStep == 2953 or curStep == 2961 then
        angle = -4
    end
    if curStep == 2909 or curStep == 2557 or curStep == 2965 then
        angle = -1
    end
    if curStep == 2969 or curStep == 3033 or curStep == 3085 or curStep == 3093 then
        angle = 1
    end
    if curStep == 3024 or curStep == 3081 or curStep == 3089 then
        angle = 4
    end
    if curStep == 3097 then
        angle = -1
    end
    if curStep == 3152 or curStep == 3156 then
        angle = 4
    end
    if curStep == 3154 or curStep == 3158 then
        angle = 4
    end
end

function onBeatHit()
    if curBeat == 62 then
        changeScreen('normal', 0.01, 'linear')
    end
    if curBeat == 76 or curBeat == 108 then
        changeScreen('invert', 0.7, 'backInOut')
    end
    if curBeat == 80 or curBeat == 112 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 94 then
        changeScreen('invert', 0.7, 'backInOut')
    end
    if curBeat == 96 or curBeat == 128 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 114 then
        changeScreen('invert', 2, 'smoothStepOut')
    end
    if curBeat == 188 then
        changeScreen('invertWhite', 1, 'smoothStepOut')
    end
    if curBeat == 241 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 270 then
        changeScreen('invert', 1, 'smoothStepOut')
    end
    if curBeat == 272 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 304 then
        changeScreen('invert', 4, 'smoothStepOut')
    end
    if curBeat == 320 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 332 or curBeat == 364 then
        changeScreen('invert', 0.2, 'smoothStepOut')
    end
    if curBeat == 350 then
        changeScreen('invert', 1, 'smoothStepOut')
    end
    if curBeat == 336 or curBeat == 352 or curBeat == 368 or curBeat == 416 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 380 then
        changeScreen('invertEX', 1, 'quadOut')
    end
    if curBeat == 444 then
        changeScreen('invert', 1, 'quadOut')
    end
    if curBeat == 495 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 525 then
        changeScreen('invert', 0.7, 'backInOut')
    end
    if curBeat == 527 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 559 then
        changeScreen('invert', 1, 'quadOut')
    end
    if curBeat == 575 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 669 then
        changeScreen('invert', 0.7, 'backInOut')
    end
    if curBeat == 671 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 703 then
        changeScreen('invertEX', 4, 'quadOut')
    end
    if curBeat == 726 or curBeat == 742 or curBeat == 758 or curBeat == 774 then
        changeScreen('normal', 0.01, 'backInOut')
    end
    if curBeat == 738 or curBeat == 756 or curBeat == 770 then
        changeScreen('invert', 0.7, 'backInOut')
    end
    if curBeat == 788 then
        changeScreen('invert', 0.01, 'backInOut')
    end
    if curBeat == 789 then
        for i = 0,1 do
            setProperty('heart'..i..'.visible', false)
        end
        for i = 0,4 do
            setProperty('X'..i..'.visible', false)
        end
    end
    if curBeat %4 == 0 then
        heartBump('heart0', 0.7, 'smoothStepOut', 0.5, 0.5)
    elseif curBeat %4 == 2 then
        heartBump('heart1', 0.7, 'smoothStepOut', 0.5, 0.5)
    end
end

local allowParticles = false
local theVariableTxt = 'empty'
local allowColorChange = false

local colorType = 'default' --added this to fix the issue when you change the colors all shits that became that color alpha to 1 lmao (will fix in source in a future)
local datime = 0.01 --no crash
local daease = 'linear' --default ease to antiCrash lmao

local numberVar = 0
local theAlphaEase = 'linear'

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
    if style == 'part1' then
        theVariableTxt = 'textA-'
        setProperty('textA-'..num..'.alpha', mainAlpha)
    end
    if style == 'part2' then
        theVariableTxt = 'textB-'
        setProperty('textB-'..num..'.alpha', mainAlpha)
    end
    if style == 'coro' then
        theVariableTxt = 'coro'
        setProperty('coro'..num..'.alpha', mainAlpha)
    end
    if style == 'lastPart' then
        theVariableTxt = 'textC-'
        setProperty('textC-'..num..'.alpha', mainAlpha)
    end
    if allowColorChange then
        if colorType == 'normal' then
            doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, '000000', datime, daease)
        elseif colorType == 'invert' then
            doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, 'ffffff', datime, daease)
        elseif colorType == 'invertWhite' then
            doTweenColor('changesIn'..theVariableTxt..num, theVariableTxt..num, 'ffffff', datime, daease)
        end
    end
    doTweenAlpha('AlphaIn'..style..num, theVariableTxt..num, 0, time, ease)
    -- runTimer('vocalsAlpha'..i, time)
end

function heartBump(heart, bumbValue, ease, time, endBumpValue)
    setProperty(heart..'.scale.x', bumbValue)
    setProperty(heart..'.scale.y', bumbValue)

    doTweenX(heart..'x', heart..'.scale', endBumpValue, time, ease)
    doTweenY(heart..'y', heart..'.scale', endBumpValue, time, ease)
end

function changeScreen(newScreen, time, ease)
    cancelTimer('disable')
    colorType = newScreen
    if newScreen == 'normal' then
        doTweenColor('newScreenBG', 'bg', 'ffffff', time, ease)
        triggerEvent('pink toggle', 'true');
        for i = 0,1 do
            doTweenColor('newHearts'..i, 'heart'..i, '000000', time, ease)
        end
        for i = 0,4 do
            doTweenColor('newX'..i, 'X'..i, '000000', time, ease)
        end
        allowColorChange = true
        setProperty('flash.alpha', 0)
        setProperty('flashGlow.alpha', 0)
        -- for i = 0,7 do
        --     doTweenColor('newNa'..i, 'na'..i, '000000', time, ease)
        -- end
        -- for i = 1,#baseTextCoroMain do
        --     doTweenColor('newBaseCoro'..i, 'coroMain'..i, '000000', time, ease)
        -- end
        -- for i = 1,#texts do
        --     doTweenColor('newVocals'..i, 'textA-'..i, '000000', time, ease)
        -- end
        -- for i = 1,#texts2 do
        --     doTweenColor('newVocals2'..i, 'textB-'..i, '000000', time, ease)
        -- end
        -- for i = 1,#coro do
        --     doTweenColor('newCoro'..i, 'coro'..i, '000000', time, ease)
        -- end
        -- for i = 1,#lastTexts do
        --     doTweenColor('newLastTexts'..i, 'textC-'..i, '000000', time, ease)
        -- end
    elseif newScreen == 'invert' then
        doTweenColor('newScreenBG', 'bg', '000000', time, ease)
        triggerEvent('pink toggle', 'false');
        for i = 0,6 do
            doTweenColor('newHearts'..i, 'heart'..i, 'fa89de', time, ease)
        end
        for i = 0,4 do
            doTweenColor('newX'..i, 'X'..i, 'fa89de', time, ease)
        end
        allowColorChange = true
        setProperty('flash.alpha', 0)
        setProperty('flashGlow.alpha', 0)
        -- for i = 0,7 do
        --     doTweenColor('newNa'..i, 'na'..i, 'fa89de', time, ease)
        -- end
        -- for i = 1,#baseTextCoroMain do
        --     doTweenColor('newBaseCoro'..i, 'coroMain'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#texts do
        --     doTweenColor('newVocals'..i, 'textA-'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#texts2 do
        --     doTweenColor('newVocals2'..i, 'textB-'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#coro do
        --     doTweenColor('newCoro'..i, 'coro'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#lastTexts do
        --     doTweenColor('newLastTexts'..i, 'textC-'..i, 'ffffff', time, ease)
        -- end
    elseif newScreen == 'invertWhite' then
        doTweenColor('newScreenBG', 'bg', '000000', time, ease)
        triggerEvent('pink toggle', 'false');
        for i = 0,6 do
            doTweenColor('newHearts'..i, 'heart'..i, 'ffffff', time, ease)
        end
        for i = 0,4 do
            doTweenColor('newX'..i, 'X'..i, 'ffffff', time, ease)
        end
        allowColorChange = true
        setProperty('flash.alpha', 0)
        setProperty('flashGlow.alpha', 0)
        -- for i = 0,7 do
        --     doTweenColor('newNa'..i, 'na'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#baseTextCoroMain do
        --     doTweenColor('newBaseCoro'..i, 'coroMain'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#texts do
        --     doTweenColor('newVocals'..i, 'textA-'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#texts2 do
        --     doTweenColor('newVocals2'..i, 'textB-'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#coro do
        --     doTweenColor('newCoro'..i, 'coro'..i, 'ffffff', time, ease)
        -- end
        -- for i = 1,#lastTexts do
        --     doTweenColor('newLastTexts'..i, 'textC-'..i, 'ffffff', time, ease)
        -- end
    elseif newScreen == 'invertEX' then
        doTweenAlpha('flash', 'flash', 1, time, ease)
        doTweenAlpha('flashG', 'flashGlow', 1, time, ease)
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
        for i = 0,7 do
            setProperty('na'..i..'.visible', true)
        end
        for i = 1,#baseTextCoroMain do
            setProperty('coroMain'..i..'.visible', true)
        end
    else
        for i = 0,7 do
            setProperty('na'..i..'.visible', false)
        end
        for i = 1,#baseTextCoroMain do
            setProperty('coroMain'..i..'.visible', false)
        end
    end
    if var == 'part2' then
        for i = 1,#texts do
            setProperty('textA-'..i..'.visible', true)
        end
    else
        for i = 1,#texts do
            setProperty('textA-'..i..'.visible', false)
        end
    end
    if var == 'coro' then
        for i = 1,#coro do
            setProperty('coro'..i..'.visible', true)
        end
    else
        for i = 1,#coro do
            setProperty('coro'..i..'.visible', false)
        end
    end
    if var == 'part3' then
        for i = 1,#texts2 do
            setProperty('textB-'..i..'.visible', true)
        end
    else
        for i = 1,#texts2 do
            setProperty('textB-'..i..'.visible', false)
        end
    end
    if var == 'part3end' then
        for i = 1,#lastTexts do
            setProperty('textC-'..i..'.visible', true)
        end
    else
        for i = 1,#lastTexts do
            setProperty('textC-'..i..'.visible', false)
        end
    end
end

function resetVocals()
    local val = 0
    local time = 0.01
    local ease = 'linear'
    for i = 0,7 do
        doTweenAlpha('newNa'..i, 'na'..i, val, time, ease)
    end
    for i = 1,#baseTextCoroMain do
        doTweenAlpha('newBaseCoro'..i, 'coroMain'..i, val, time, ease)
    end
    for i = 1,#texts do
        doTweenAlpha('newVocals'..i, 'textA-'..i, val, time, ease)
    end
    for i = 1,#texts2 do
        doTweenAlpha('newVocals2'..i, 'textB-'..i, val, time, ease)
    end
    for i = 1,#coro do
        doTweenAlpha('newCoro'..i, 'coro'..i, val, time, ease)
    end
    for i = 1,#lastTexts do
        doTweenAlpha('newLastTexts'..i, 'textC-'..i, val, time, ease)
    end
end

function onTimerComplete(t)
    if t == 'disable' then
        -- allowColorChange = false
    end
    if t == 'togglePink' then
        triggerEvent('pink toggle', 'true');
    end
    -- if t == 'vocalsAlpha' then
    --     doTweenAlpha('AlphaIn'..theVariableTxt..numberVar, theVariableTxt..num, 0, 0.2, theAlphaEase)
    -- end
end

function onUpdate(elapsed)
    setProperty('X0.angle',getProperty('X0.angle') + angle)
    setProperty('X1.angle',getProperty('X1.angle') + angle*-1)
    setProperty('X2.angle',getProperty('X2.angle') + angle/2)
    setProperty('X3.angle',getProperty('X3.angle') + angle/4)
    setProperty('X4.angle',getProperty('X4.angle') + angle/4*-1)
end