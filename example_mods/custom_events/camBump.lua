--this shit was made because MEPICANLOSCOCOS XDDD
--by EDWHAK
function onCreate()
defaultCamXPoss = getProperty('camHUD.x')
defaultCamYPoss = getProperty('camHUD.y')
end
function onEvent(n,v1,v2)
    if n == 'camBump' then
        if v1 == 'true' then
            doTweenX('cameraMove1', 'camHUD',defaultCamXPoss+20, 0.5, 'circOut')
            doTweenY('cameraMove2', 'camHUD',defaultCamYPoss-20, 0.25, 'circOut')
        end
        if v1 == 'false' then
            cancelTween('cameraMove1')
            cancelTween('cameraMove2')
            cancelTween('cameraMove3')
            cancelTween('cameraMove4')
            setProperty('camHUD.x', 0)
            setProperty('camHUD.y', 0)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'cameraMove1' then
        doTweenX('cameraMove3', 'camHUD',defaultCamXPoss-20, 0.5, 'circOut')
    end
    if tag == 'cameraMove2' then
        doTweenY('cameraMove4', 'camHUD',defaultCamYPoss, 0.25, 'elasticOut')
    end
    if tag == 'cameraMove3' then
        doTweenX('cameraMove1', 'camHUD',defaultCamXPoss+20, 0.5, 'circOut')
    end
    if tag == 'cameraMove4' then
        doTweenY('cameraMove2', 'camHUD',defaultCamYPoss-20, 0.25, 'circOut')
    end
end