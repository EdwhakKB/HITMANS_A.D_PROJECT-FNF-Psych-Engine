-- Idea by dk. 
-- Original code by Keoki
-- Made by Kevin Kuntz
function onCreate()
	if not mania == 3 then
		close(true)
  end
	rando = math.random(0, 3)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Switcher' and not isSustainNote then
	rando = math.random(0, 3)
	end
end

function onUpdatePost(elapsed)
	for a = 0, getProperty('notes.length') - 1 do
		strumTime = getPropertyFromGroup('notes', a, 'strumTime');
		noteData = getPropertyFromGroup('notes', a, 'noteData');
		if getPropertyFromGroup('notes', a, 'noteType') == 'Switcher' then
			setPropertyFromGroup('unspawnNotes', a, 'usedDifferentWidth', true);
			if getPropertyFromGroup('notes', a, 'animation.curAnim.curFrame') >= 3 then -- very important
				setPropertyFromGroup('notes', a, 'animation.curAnim.paused', true)
			end
			
			if (strumTime - getSongPosition()) < 250 then
				setPropertyFromGroup('notes', a, 'noteData', rando);
			
				if noteData == 0 then
					
					if getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'redScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 7, 'x') --[[+ 350]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'greenScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 6, 'x') --[[+ 230]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'blueScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 5, 'x') --[[+ 120]])
					end
				elseif noteData == 1 then
					
					if getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'purpleScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 4, 'x') --[[- 113]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'greenScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 6, 'x') --[[+ 113]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'redScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 7, 'x') --[[+ 230]])
					end
				elseif noteData == 2 then
				
					if getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'purpleScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 4, 'x') --[[- 230]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'redScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 7, 'x') --[[+ 115]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'blueScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 5, 'x') --[[- 115]])
					end
				elseif noteData == 3 then
					
					if getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'purpleScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 4, 'x') --[[- 350]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'blueScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 5, 'x') --[[- 230]])
					
					elseif getPropertyFromGroup('notes', a, 'animation.curAnim.name') == 'greenScroll' then
					setPropertyFromGroup('notes', a, 'x', getPropertyFromGroup('notes', 6, 'x') --[[- 115]])
					end
				end
			elseif (strumTime - getSongPosition()) < 370 then
				if rando == 0 and noteData ~= 0 then
				setPropertyFromGroup('notes', a, 'texture', 'purpleswitches');
				elseif rando == 1 and noteData ~= 1 then
				setPropertyFromGroup('notes', a, 'texture', 'blueswitches');
				elseif rando == 2 and noteData ~= 2 then
				setPropertyFromGroup('notes', a, 'texture', 'greenswitches');
				elseif rando == 3 and noteData ~= 3 then
				setPropertyFromGroup('notes', a, 'texture', 'redswitches');
				end
			end
		end
	end
end