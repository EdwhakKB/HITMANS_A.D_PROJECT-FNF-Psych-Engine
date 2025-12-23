function onCreate()
	-- background shit
	makeLuaSprite('labs', 'hitmans/labsBG', -100, 150);
	scaleObject('labs', 0.7, 0.7)
	setScrollFactor('labs', 1, 1);

	makeLuaSprite('LabUpPart', 'hitmans/Visuals/quimical/3rd', -50, 170);
	scaleObject('LabUpPart', 0.67, 0.67)
	setScrollFactor('LabUpPart', 1, 1);

	makeLuaSprite('LabMidPart', 'hitmans/Visuals/quimical/2nd', -50, 150);
	scaleObject('LabMidPart', 0.7, 0.7)
	setScrollFactor('LabMidPart', 1, 1);

    addLuaSprite('labs', false);
	addLuaSprite('LabMidPart', false);
	addLuaSprite('LabUpPart', false);
end

function onCreatePost()

	initLuaShader("scroll")
 
    setSpriteShader('LabUpPart',"scroll")

end
 
function onUpdate()
    setShaderFloat("LabUpPart", "iTime", os.clock())
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('Lab', 'labs', -50, 5, 'ExponentialOut')
end

function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag

	if tag == 'Lab' then 
		doTweenX('Lab1', 'labs', -100, 5, 'ExponentialOut')
	end
	if tag == 'Lab1' then 
		doTweenX('Lab', 'labs', -50, 5, 'ExponentialOut')
	end
end

function onBeatHit()

	if curBeat % 2 == 1 then
        setProperty('LabMidPart.y',120)
		doTweenY('LabMid', 'LabMidPart', 150, 0.3, 'EaseOut')
	elseif curBeat % 2 == 0 then
		setProperty('LabMidPart.y',180)
		doTweenY('LabMid', 'LabMidPart', 150, 0.3, 'EaseOut')
	end

end