function opponentNoteHit(id, noteData, noteType, isSustainNote)
    health = getProperty('health')
    if noteType == '' then
        if getProperty('health') > 0.25 then
            setProperty('health', health- 0.025);
        end
    elseif noteType == 'Instakill Note' then
        if getProperty('health') > 0.25 then
            setProperty('health', health- 0.045);
        end
    elseif noteType == 'KillerBotGlitchNotes' then
        if getProperty('health') > 0.25 then
            setProperty('health', health- 0.055);
        end
    end
end