local songSpeed=1 -- this is playback rate
function onCreatePost()
    songSpeed=getProperty('playbackRate')
end

function onCreate()
    makeAnimatedLuaSprite('bg', 'Hitmans/Bgs/Anby/SweetDreams/bg', 0, 0);
    addAnimationByPrefix('bg', 'pulse', 'kbBACK-pulse', 32, false)
    setProperty('bg.color', getColorFromHex('509696'))
    addLuaSprite('bg', false);
    setScrollFactor('bg', 0, 0);
    screenCenter('bg');

    makeLuaSprite('snowfloor', 'Hitmans/Bgs/Anby/SweetDreams/snow', 0, 0);
    addLuaSprite('snowfloor', true);
    setScrollFactor('snowfloor', 0, 0);
    screenCenter('snowfloor');

    makeLuaSprite('vignette', 'Hitmans/vignette', 0, 0);
    addLuaSprite('vignette', true);
    setScrollFactor('vignette', 0, 0);
    setObjectCamera('vignette', 'camOther')
    screenCenter('vignette');
    setProperty('vignette.alpha', 0.5)

    setProperty('camGame.alpha', 0)

    -- gas is opt
    makeAnimatedLuaSprite('gas-left', 'Hitmans/Bgs/Anby/SweetDreams/elements/gas', -650, 0)
    addAnimationByPrefix('gas-left', 'gas', 'gas-release', 80, false)
    setObjectCamera('gas-left', 'HUD')
    setProperty('gas-left.angle', -31)
    setProperty('gas-left.alpha', 0)
    scaleObject('gas-left', 1.5, 1.5)
    setScrollFactor('gas-left', 0, 0);
    addLuaSprite('gas-left', false)

    makeAnimatedLuaSprite('gas-right', 'Hitmans/Bgs/Anby/SweetDreams/elements/gas', 0, 0)
    addAnimationByPrefix('gas-right', 'gas', 'gas-release', 80, false)
    setObjectCamera('gas-right', 'HUD')
    setProperty('gas-right.angle', 31)
    setProperty('gas-right.alpha', 0)
    scaleObject('gas-right', 1.5, 1.5)
    setScrollFactor('gas-right', 0, 0);
    addLuaSprite('gas-right', false)

    makeAnimatedLuaSprite('snow', 'hitmans/DaSnow', 0, 0)
    addAnimationByPrefix('snow', 'move', 'noise', 24, true)
	scaleObject('snow', 2, 2)
	updateHitbox('snow')
	setObjectCamera('snow', 'other')
	setProperty('snow.alpha', 0)
	addLuaSprite('snow', true)
	objectPlayAnimation('snow', 'move', true)
end

function onSongStart()
    if songName == 'Sweet Dreams' then
        doTweenAlpha('camGameAlpha', 'camGame', 0.25, 5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 0.25, 5/songSpeed, 'sineInOut')
    end
end

function onBeatHit()
    if curBeat == 32 then
        doTweenAlpha('camGameAlpha', 'camGame', 0.5, 5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 0.5, 5/songSpeed, 'sineInOut')
    end
    if curBeat == 62 then
        doTweenAlpha('camGameAlpha', 'camGame', 0, 0.5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 0, 0.5/songSpeed, 'sineInOut')
    end
    if curBeat == 64 then
        doTweenAlpha('camGameAlpha', 'camGame', 1, 0.5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 1, 0.5/songSpeed, 'sineInOut')
    end
    if curBeat == 96 then
        setProperty('gas-left.alpha', 0.72)
        setProperty('gas-right.alpha', 0.72)
    end
    if curBeat == 100 or curBeat == 108 or curBeat == 116 or curBeat == 124 or curBeat == 132 or curBeat == 140 or curBeat == 148 or curBeat == 156 or curBeat == 164 or curBeat == 172 or curBeat == 180 or curBeat == 188 then
        playAnim('gas-left', 'gas', false)
        playAnim('gas-right', 'gas', false)
    end
    if curBeat == 192 then
        doTweenAlpha('camGameAlpha', 'camGame', 0.5, 0.5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 0.5, 0.5/songSpeed, 'sineInOut')
    end
    if curBeat == 256 then
        doTweenAlpha('camGameAlpha', 'camGame', 1, 0.5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 1, 0.5/songSpeed, 'sineInOut')
    end
    if curBeat == 196 or curBeat == 204 or curBeat == 212 or curBeat == 220 or curBeat == 228 or curBeat == 236 or curBeat == 244 or curBeat == 252 or curBeat == 260 or curBeat == 268 or curBeat == 276 or curBeat == 284 then
        playAnim('gas-left', 'gas', false)
        playAnim('gas-right', 'gas', false)
    end
    if curBeat == 292 or curBeat == 300 or curBeat == 308 or curBeat == 316 then
        playAnim('gas-left', 'gas', false)
        playAnim('gas-right', 'gas', false)
    end
    if curBeat == 320 then
        doTweenAlpha('camGameAlpha', 'camGame', 0.5, 5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 0.5, 5/songSpeed, 'sineInOut')
    end
    if curBeat == 356 then
        doTweenAlpha('camGameAlpha', 'camGame', 0.25, 5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 0.25, 5/songSpeed, 'sineInOut')
    end
    if curBeat == 384 then
        doTweenAlpha('camGameAlpha', 'camGame', 0, 5/songSpeed, 'sineInOut')
        doTweenAlpha('snowAlpha', 'snow', 0, 5/songSpeed, 'sineInOut')
    end
end