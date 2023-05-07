--the player 2 thing visual
local allowCountdown = false
local startedFirstDialogue = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not startedFirstDialogue then
		setProperty('inCutscene', true);
		triggerEvent('loadDialogue', 'fatal-error');
        triggerEvent('startDialogue', 'fatal-error', 'teaTime');
		startedFirstDialogue = true;
		return Function_Stop;
	end
	return Function_Continue;
end