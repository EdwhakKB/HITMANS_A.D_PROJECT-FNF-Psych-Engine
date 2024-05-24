--YOU FUKING CHEATER OF SHIT
local window_default_x
local window_default_y
local window_shake_x = 0
local window_shake_y = 0
local window_shake_lerp = 0.05

function onCreate()
   window_default_x = getPropertyFromClass("openfl.Lib", "application.window.x")
	window_default_y = getPropertyFromClass("openfl.Lib", "application.window.y")
   makeLuaSprite('cheat', 'Inhuman/unused-things/cheat-bg', -800, -450);
   scaleObject('cheat', 2, 2);
   setLuaSpriteScrollFactor('cheat', 0.001, 0.001);
   addLuaSprite('cheat', false);
   setProperty('cheat.visible', false);
   setProperty('skipCountdown', true)

   precacheSound('cheatercheatercheater');

   makeLuaSprite('cheater', 'Inhuman/unused-things/cheat', 100, -100);
   scaleObject('cheater', 3, 3);
   setLuaSpriteScrollFactor('cheater', 0.1, 0.1);
   addLuaSprite('cheater', true);
   setProperty('cheater.visible', false);  

   makeLuaSprite('cheatEye', 'hitmans/Insanity eye', 200, -400);
   scaleObject('cheatEye', 2.5, 2.5);
   addLuaSprite('cheatEye', true);
   setProperty('cheatEye.visible', false); 

   doTweenAlpha('hud', 'camHUD', 0, 0.000001, 'linear')
   setProperty('playerHealthBar.visible', false)
   setProperty('comboThingTxt.visible', false)
   setProperty('comboThing.visible', false)
   setProperty('playerAcc.visible', false)
   setProperty('iconP1.visible', false)
   setProperty('iconP2.visible', false)
end

function onCreatePost()
   setPropertyFromClass("openfl.Lib", "application.window.title", "HITMANS... - YOU MOTHERFUCKER CHEATER")
   setProperty('playerName.visible', false)
   setProperty('playerHealthBar.visible', false)
   setProperty('playerHealthBar.visible', false)
   setProperty('comboThingTxt.visible', false)
   setProperty('comboThing.visible', false)
   setProperty('playerAcc.visible', false)
   setProperty('iconP1.visible', false)
   setProperty('iconP2.visible', false)
   addHaxeLibrary("Sys")
end


function onEvent(name, value1, value2)
   if name == "changestate" then
      if value1 == 'cheat' then
	      playSound('cheatercheatercheater', 10)
         setProperty('cheat.visible', true);
         setProperty('cheater.visible', true);
         setProperty('cheatEye.visible', true)
         setPropertyFromClass('openfl.Lib', 'application.window.width', 800)
         setPropertyFromClass('openfl.Lib', 'application.window.height', 405)
         window_shake_x = window_shake_x+800
         window_shake_y = window_shake_y+800
      end
      if value1 == 'crash' then
         runHaxeCode("Sys.exit(0);")
      end
   end 
end

local function lerp(start, goal, alpha)
	return (start + ((goal - start) * alpha))
end

function onUpdate()
	local window_shake_temp_x = math.random(-window_shake_x, window_shake_x)
	local window_shake_temp_y = math.random(-window_shake_y, window_shake_y)
	window_shake_x = lerp(window_shake_x , 0, window_shake_lerp)
	window_shake_y = lerp(window_shake_y , 0, window_shake_lerp)
	setPropertyFromClass("openfl.Lib", "application.window.x", window_default_x + window_shake_temp_x)
	setPropertyFromClass("openfl.Lib", "application.window.y", window_default_y + window_shake_temp_y)
end
