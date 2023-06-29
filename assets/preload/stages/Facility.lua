function onCreate()
	-- background shit
	makeLuaSprite('Facility', 'hitmans/Bgs/Mia/Duality/Facility', -100, 150);
	scaleObject('Facility', 0.7, 0.7)
	setScrollFactor('Facility', 1, 1);

	addLuaSprite('Facility', false);

	makeLuaSprite('vignette', 'hitmans/vignette', 0, 0);
    addLuaSprite('vignette', true);
    setProperty('vignette.alpha', 1)
    setObjectCamera('vignette', 'other');
    scaleObject('vignette', 1, 1)

	addLuaSprite('vignette', true);
end

function onCreatePost()

	initLuaShader("chromaticRadialBlur")
 
    setSpriteShader('Facility',"chromaticRadialBlur")

end
 
function onUpdate()
    setShaderFloat("chromaticRadialBlur", "iTime", os.clock())
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('Facility', 'Facility', -200, 5, 'ExponentialOut')
end

function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag

	if tag == 'Facility' then 
		doTweenX('Facility1', 'Facility', -100, 5, 'ExponentialOut')
	end
	if tag == 'Facility1' then 
		doTweenX('Facility', 'Facility', -200, 5, 'ExponentialOut')
	end
end