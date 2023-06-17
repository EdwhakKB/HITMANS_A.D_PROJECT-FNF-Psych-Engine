--[[
	
	Legit stage change script
	
	Original by soushi0210#4026
	Cleaned up by InvertZ#0306
	
]]--

local jsonText = nil
local jsonSplited = nil
local jsonSplitedPost = nil

function makeLuaStage(stage)
	removeLuaScript('stages/' .. getPropertyFromClass('PlayState','curStage'))
	
	--make black bg(for reset stage)
	removeLuaSprite('black')

	removeLuaSprite('black')
	makeLuaSprite('black', 'Gone', -300, -100);
	makeGraphic('black', 100, 100, '000000');
	addLuaSprite('black', false);
	scaleObject('black', 1000, 1000);

	addLuaScript('stages/' .. stage)
		
	jsonText = getTextFromFile('stages/' .. stage .. '.json')
		
	jsonSplitedPost = split(jsonText,"{")
	jsonSplited = jsonSplitedPost[1]
		
	jsonSplitedPost = split(jsonSplited,"}")
	jsonSplited = jsonSplitedPost[1]
		
	jsonSplitedPost = split(jsonSplited,"\n")
	table.remove(jsonSplitedPost, 1)
		
	jsonSplited = jsonSplitedPost
	
	configPositions()
end

function configPositions()
	local bfposPost = split(jsonSplited[5],'"boyfriend" :')
	table.remove(bfposPost, 1)
		
	local bfposX = split(bfposPost[1],'],')
	local bfposY = split(bfposPost[2],'],')
		
	local bfposYPost = split(bfposY[1],'[')
	bfposY = split(bfposYPost[1],'[')

	local bfposXPost = split(bfposX[1],'[')
	bfposX = split(bfposXPost[1],'[')

	posarray = getProperty('boyfriend.positionArray')
	setProperty('bf.x', bfposX[1] + posarray[1])
	setProperty('bf.y', bfposY[1] + posarray[2])
	
	local dadposPost = split(jsonSplited[5],'"opponent" :')
	table.remove(dadposPost, 1)
		
	local dadposX = split(dadposPost[1],'],')
	local dadposY = split(dadposPost[2],'],')
		
	local dadposYPost = split(dadposY[1],'[')
	dadposY = split(dadposYPost[1],'[')

	local dadposXPost = split(dadposX[1],'[')
	dadposX = split(dadposXPost[1],'[')

	posarray = getProperty('dad.positionArray')
	setProperty('dad.x', dadposX[1] + posarray[1])
	setProperty('dad.y', dadposY[1] + posarray[2])

	--remove "girlfriend": [ (and make pos table)
	local gfposPost = split(jsonSplited[5],'"girlfriend" :')
	table.remove(gfposPost, 1)
		
	local gfposX = split(gfposPost[1],'],')
	local gfposY = split(gfposPost[2],'],')
		
	local gfposYPost = split(gfposY[1],'[')
	gfposY = split(gfposYPost[1],'[')

	local gfposXPost = split(gfposX[1],'[')
	gfposX = split(gfposXPost[1],'[')
		
	posarray = getProperty('gf.positionArray')
	setProperty('gf.x', gfposX[1] + posarray[1])
	setProperty('gf.y', gfposY[1] + posarray[2])

	--set cam zoom
	local camzoom = split(jsonSplited[2],'"defaultZoom" :')
	table.remove(camzoom, 1)
	setProperty('defaultCamZoom',camzoom[1])
end

function onEvent(name, value1, value2)
	if name == "change_stage" then
		makeLuaStage(value1) -- value1: new stage, value2: stage to remove
	end
end

-- cleaned up this function a little bit
function split(str, ts)
	if ts == nil then return {} end
	
	local t = {}; i=1
	
	for s in string.gmatch(str, "([^"..ts.."]+)") do
		t[i] = s
		i = i + 1
	end
  
	return t
end