eventOffset = {}





--EVENTS NOTE
--[[ 'eventNotes'
   strumTime
   event
   value1
   value2
]]
function onCreatePost()
	for event = 0, getProperty('eventNotes.length') - 1 do
		local pauser = getPropertyFromGroup('eventNotes', event, 'event') == 'pauser'
      local eventtime = getPropertyFromGroup('eventNotes', event, 'strumTime')
      local time = getPropertyFromGroup('eventNotes', event, 'value1') 
		if pauser then
         local offse = (time * 450 * scrollSpeed) * (downscroll and 1 or -1)
         for note = 0, getProperty('unspawnNotes.length') - 1 do
            local strumTime = getPropertyFromGroup('unspawnNotes', note, 'strumTime')
            if eventtime < strumTime and getPropertyFromGroup('unspawnNotes', note, 'mustPress') then -- this doesnt work, gonna have to desync your chart traditionally
               
               
               setPropertyFromGroup('unspawnNotes', note, 'offsetY', getPropertyFromGroup('unspawnNotes', note, 'offsetY') + offse)
               
            end
         end
         table.insert( eventOffset, offse)
		end
	end
   setProperty("spawnTime", 10000)
end

paused = false



local pos = 0
curTime = 0
local pausing = false
function onEvent(name, value1, value2)
   if name == "pauser" then 
      local time = value1 
      curTime = time
      --setPropertyFromClass('Conductor', 'songPosition', pos) 
      runTimer('UPNotes', time, 1)
      for i = 0, getProperty('notes.length') - 1 do
         if getPropertyFromGroup('notes', i, 'mustPress') then
            --setPropertyFromGroup('notes', i, 'y', getPropertyFromGroup('notes', i, 'y') + (time * 450 * scrollSpeed) * (downscroll and 1 or -1))
             setPropertyFromGroup('notes', i, 'copyY', false)
         end
      end
      pausing = true
      pause(true)
   end
	-- event note triggered
	-- triggerEvent() does not call this function!!

	-- print('Event triggered: ', name, value1, value2);
end

function onUpdatePost(el)
   pos = getSongPosition()
   if pausing then 
      for i = 0, getProperty('notes.length') - 1 do
         
      end
   end
end

function onTimerCompleted(t)
	if t == 'UPNotes' then
      for i = 0, getProperty('notes.length') - 1 do
         if getPropertyFromGroup('notes', i, 'mustPress') then
            setPropertyFromGroup('notes', i, 'offsetY', getPropertyFromGroup('notes', i, 'offsetY') - eventOffset[1])
			   setPropertyFromGroup('notes', i, 'copyY', true)
         end
		end
      for i = 0, getProperty('unspawnNotes.length') - 1 do
         if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
            setPropertyFromGroup('unspawnNotes', i, 'offsetY', getPropertyFromGroup('unspawnNotes', i, 'offsetY') - eventOffset[1])
			   setPropertyFromGroup('unspawnNotes', i, 'copyY', true)
         end
		end
      table.remove( eventOffset, 1 )
      setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('flixel.FlxG', 'sound.music.time'))
      pausing = false
      pause(false)
	end
end