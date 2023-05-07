-- --modchart by EDWHAK
function onCreate()
    addLuaScript('SimpleModchartTemplate')
end

function onCreatePost()
    makeLuaSprite('imageRed1', 'hitmans/RedImage1', 0, -100);
	addLuaSprite('imageRed1', true);
	setObjectCamera('imageRed1', 'other');
	scaleObject('imageRed1', 2.3, 2.3)
	setProperty('imageRed1.alpha', 0)

	makeLuaSprite('imageRed2', 'hitmans/RedImage2', 0, -70);
	addLuaSprite('imageRed2', true);
	setObjectCamera('imageRed2', 'other');
	scaleObject('imageRed2', 2.7, 2.7)
	setProperty('imageRed2.alpha', 0)

	makeLuaSprite('imageRed4', 'hitmans/Pain', -130, -30);
	addLuaSprite('imageRed4', true);
	setObjectCamera('imageRed4', 'other');
	scaleObject('imageRed4', 1.1, 1.1)
	setProperty('imageRed4.alpha', 0)

	makeLuaSprite('imageRed5', 'hitmans/Fear', -130, -30);
	addLuaSprite('imageRed5', true);
	setObjectCamera('imageRed5', 'other');
	scaleObject('imageRed5', 1.1, 1.1)
	setProperty('imageRed5.alpha', 0)

	makeLuaSprite('imageRed6', 'hitmans/Die', -130, -30);
	addLuaSprite('imageRed6', true);
	setObjectCamera('imageRed6', 'other');
	scaleObject('imageRed6', 1.1, 1.1)
	setProperty('imageRed6.alpha', 0)

	makeLuaSprite('imageRed7', 'hitmans/Fail', -130, -30);
	addLuaSprite('imageRed7', true);
	setObjectCamera('imageRed7', 'other');
	scaleObject('imageRed7', 1.1, 1.1)
	setProperty('imageRed7.alpha', 0)

	makeLuaSprite('imageRed8', 'hitmans/Death', -130, -30);
	addLuaSprite('imageRed8', true);
	setObjectCamera('imageRed8', 'other');
	scaleObject('imageRed8', 1.1, 1.1)
	setProperty('imageRed8.alpha', 0)

	makeLuaSprite('imageRed9', 'hitmans/youCant', -130, -30);
	addLuaSprite('imageRed9', true);
	setObjectCamera('imageRed9', 'other');
	scaleObject('imageRed9', 1.1, 1.1)
	setProperty('imageRed9.alpha', 0)

end
local RandomEdkbImage = 0
function lerp(a, b, ratio)
	return a + ratio * (b - a)
end

function onSongStart()--for step 0

end

local thing = 0

function onBeatHit()
    if curBeat >= 256 and curBeat <= 512 or curBeat >= 640 and curBeat <= 895 then
    if curBeat %2 == 0 then
        RandomEdkbImage = RandomEdkbImage+1
        if RandomEdkbImage == 9 then
            RandomEdkbImage = 1
        end
        if RandomEdkbImage == 1 then
            setProperty('imageRed1.alpha', 0.7)
             runTimer('giveup', 0.065)
        elseif RandomEdkbImage == 2 then
            setProperty('imageRed2.alpha', 0.7)
            runTimer('haha', 0.065)
        elseif RandomEdkbImage == 3 then
             setProperty('imageRed4.alpha', 0.7)
             runTimer('pain', 0.065)
        elseif RandomEdkbImage == 4 then
             setProperty('imageRed5.alpha', 0.7)
             runTimer('fear', 0.065)
        elseif RandomEdkbImage == 5 then
             setProperty('imageRed6.alpha', 0.7)
             runTimer('die', 0.065)
        elseif RandomEdkbImage == 6 then
             setProperty('imageRed7.alpha', 0.7)
             runTimer('fail', 0.065)
        elseif RandomEdkbImage == 7 then
             setProperty('imageRed8.alpha', 0.7)
             runTimer('death', 0.065)
        elseif RandomEdkbImage == 8 then
             setProperty('imageRed9.alpha', 0.7)
             runTimer('cant', 0.065)
        end
    end
    end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'giveup' then
		setProperty('imageRed1.alpha', 0)
	end
	if tag == 'haha' then
		setProperty('imageRed2.alpha', 0)
	end
	if tag == 'pain' then
		setProperty('imageRed4.alpha', 0)
	end
	if tag == 'fear' then
        setProperty('imageRed5.alpha', 0)
    end
	if tag == 'die' then
		setProperty('imageRed6.alpha', 0)
	end
	if tag == 'fail' then
		setProperty('imageRed7.alpha', 0)
	end
	if tag == 'death' then
		setProperty('imageRed8.alpha', 0)
	end
	if tag == 'cant' then
		setProperty('imageRed9.alpha', 0)
	end
end

function onStepHit()

end 