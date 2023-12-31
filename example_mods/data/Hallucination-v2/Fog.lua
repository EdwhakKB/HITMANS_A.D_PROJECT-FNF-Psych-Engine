function onCreate()
    setProperty('hallway.alpha', 0)
    setProperty('camHUD.alpha', 0)
end

function onCreatePost()
    summongHxShader('vcr', 'VCRDistortionEffect')
    setShaderProperty('vcr', 'glitchFactor', 0.1)
    setShaderProperty('vcr', 'distortion', true)
    setShaderProperty('vcr', 'perspectiveOn', true)
    setShaderProperty('vcr', 'vignetteMoving', true)
    setCameraShader('camHUD', 'vcr')
end

function onSongStart()
    doTweenAlpha('helloHud', 'camHUD', 1, 2, 'cubeOut')
    doTweenAlpha('hello', 'hallway', 1, 40, 'cubeOut')
end

function onBeatHit()
    if curBeat == 704 then
        doTweenAlpha('cya', 'hallway', 0, 4, 'cubeOut')
    end
end