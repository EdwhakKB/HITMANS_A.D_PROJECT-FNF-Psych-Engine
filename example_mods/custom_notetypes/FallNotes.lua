--Idea and code by EDWHAK
function onCreate()
	if not mania == 3 then
		close(true)
  end
end
local noteDefaultYs = {}
local noteYs = {}
function onUpdatePost(elapsed)
    notesLength = getProperty('notes.length')
	songPos = getSongPosition()
	local currentBeat = (songPos/1000)*(bpm/60)
	for i1 = 0, notesLength, 1 do
        if getPropertyFromGroup('notes', i1, 'noteType') == 'FallNotes' then
		Thisnotey = getPropertyFromGroup('notes',i1,'y')
		setPropertyFromGroup('unspawnNotes', i1, 'usedDifferentWidth', true);
		Thisnote = getPropertyFromGroup('notes',i1,'noteData')
		Thisnoteoriginy = getPropertyFromGroup('strumLineNotes',Thisnote,'y')
        setPropertyFromGroup('notes',i1,'y',Thisnotey+math.sin((currentBeat)*math.pi)*100)
        end
	end
end