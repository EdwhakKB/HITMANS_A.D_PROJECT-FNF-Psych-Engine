function onCreate()
	-- background shit
	makeAnimatedLuaSprite('Cold', 'hitmans/cold-stage', 50, 130);
	addAnimationByPrefix('Cold', 'freeze', 'cold-stage', 24, true)
	scaleObject('Cold', 0.7, 0.7)
	setScrollFactor('Cold', 1, 1);
	addLuaSprite('Cold', false);

	makeLuaSprite('snowfloor', 'Hitmans/Bgs/Anby/SweetDreams/snow', 0, 0);
	scaleObject('snowfloor', 1.3, 1.2)
    setScrollFactor('snowfloor', 0, 0);
    screenCenter('snowfloor');
    addLuaSprite('snowfloor', true);

	makeAnimatedLuaSprite('snow', 'hitmans/DaSnow', 0, 0)
    addAnimationByPrefix('snow', 'move', 'noise', 24, true)
	scaleObject('snow', 2, 2)
	updateHitbox('snow')
	setObjectCamera('snow', 'other')
	setProperty('snow.alpha', 1)
	addLuaSprite('snow', false)
end