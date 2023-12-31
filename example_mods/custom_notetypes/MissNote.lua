function onCreatePost()

	for i=0,getProperty('unspawnNotes.length') do
		if getPropertyFromGroup('unspawnNotes',i,'noteType') == 'MissNote' then
			setPropertyFromGroup('unspawnNotes',i,'ignoreNote',true)
			setPropertyFromGroup('unspawnNotes',i,'noAnimation',true)
		end
		
	end
end

function onUpdate(elapsed)
	for i=0,getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes',i,'noteType') == 'MissNote' then
			setPropertyFromGroup('notes',i,'lateNote',true)
			setPropertyFromGroup('notes',i,'canBeHit',false)
		end
		
	end
end