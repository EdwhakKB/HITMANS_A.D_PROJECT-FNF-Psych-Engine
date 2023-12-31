function onCreate()
	--Iterate over all notes
		if not mania == 3 then
			close(true)
	  end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Ice Note' then
		    setPropertyFromGroup('unspawnNotes', i, 'texture', 'HURTICENOTE_assets'); --Change texture' then
			setPropertyFromGroup('unspawnNotes', i, 'usedDifferentWidth', true);
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true); --Hit miss
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
			setPropertyFromGroup("unspawnNotes", i, "multAlpha", 0.3)
		end
	end
end

local locked = 4
local lockedb = 5
local lockedc = 6
local lockedd = 7
function noteMiss(id, direction, noteType, isSustainNote)
    if noteType == 'Ice Note' then
        locked = direction
		runTimer('UL', 2)
		--debugPrint("Locked.")
		runTimer('FR', 0.01, 1)
    end
end

function onUpdatePost(elapsed)
    for a = 0, getProperty('notes.length') - 1 do
        noteData = getPropertyFromGroup('notes', a, 'noteData')
		noteType = getPropertyFromGroup('notes', a, 'noteType')
        if noteData == locked then
            setPropertyFromGroup('notes', a, 'canBeHit', false)
		else
			if noteType ~= 'Ice Note' then
				setPropertyFromGroup('notes', a, 'hitCausesMiss', false)
			end
        end
    end
	if freezed then
		setPropertyFromGroup('playerStrums', locked, 'colorSwap.brightness', getPropertyFromGroup('playerStrums', locked, 'colorSwap.brightness') - 1)
	else
		setPropertyFromGroup('playerStrums', locked, 'colorSwap.brightness', getPropertyFromGroup('playerStrums', locked, 'colorSwap.brightness'))
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'UL' then
		locked = 4
		--debugPrint("Unlocked!")
		freezed = false
	elseif tag == 'FR' then
		freezed = true
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Fire Note' then
		freezed = false
	end
end
