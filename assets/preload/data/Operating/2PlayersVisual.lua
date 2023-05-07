--the player 2 thing visual
local allowCountdown = false
local startedFirstDialogue = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not startedFirstDialogue then
		setProperty('inCutscene', true);
		triggerEvent('loadDialogue', 'dialogue');
        triggerEvent('startDialogue', 'dialogue', 'teaTime');
		startedFirstDialogue = true;
		return Function_Stop;
	end
	return Function_Continue;
end
function onUpdatePost(elapsed)

    if getProperty('health') <= .375 then
        setProperty('iconP2.animation.curAnim.curFrame', 1)
    else
        setProperty('iconP2.animation.curAnim.curFrame', 0)
    end
    
end