function opponentNoteHit(id, noteData, noteType, isSustainNote)
    health = getProperty('health')
    if noteType == '' then
        if getProperty('health') > 0.05 then
            setProperty('health', health- 0.023);
        end
    end
end