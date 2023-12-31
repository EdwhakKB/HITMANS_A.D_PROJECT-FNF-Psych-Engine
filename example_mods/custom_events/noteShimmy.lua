local strumDimen = 0.696774193548387
local bounce = 0
local flippy = false

function onEvent(name, value1, value2)
    if name == 'noteShimmy' then
        local songPos = getSongPosition()
        val = {-1,1}
        HUDPos = getProperty('camHUD.x')
        HUDZoom = getProperty('camHUD.zoom')
        doTweenX('cammyMove', 'camHUD', (29.4117647059 * getProperty('camHUD.zoom')) * val[(flippy and 1 or 2)], 0.2, 'circOut')
        for i = 0,7 do
            noteTweenDirection("noteFlippy" ..i, i, 90 + (-5 * val[(flippy and 1 or 2)]), 0.2, 'circOut')
            --noteTweenAngle('noteangleyier'..i, i, 15 * val[((HUDPos > 0) and 1 or 2)], 0.15, 'circOut')
        end
        bounce = 0.25
        flippy = not flippy
    end
end

function onUpdate(elapsed)
if bounce > 0.001 then
        for i = 0,7 do
            setPropertyFromGroup("playerStrums", i, "scale.x", strumDimen + bounce)
            setPropertyFromGroup("playerStrums", i, "scale.y", strumDimen - (bounce / 2))
        end
    bounce = bounce * 0.8
    if bounce < 0.001 then
        setPropertyFromGroup("playerStrums", i, "scale.x", strumDimen)
        setPropertyFromGroup("playerStrums", i, "scale.y", strumDimen)
    end
    end
end