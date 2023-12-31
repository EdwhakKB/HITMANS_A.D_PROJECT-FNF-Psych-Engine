function onEvent(name, value1, value2)
    if name == 'noteSpin' then
        for i = 0,7 do
            origAngle = getPropertyFromGroup('strumLineNotes', i, 'angle')
            noteTweenAngle('spinsies'..i, i, origAngle + 360, 0.5, 'circOut')
        end
    end
end