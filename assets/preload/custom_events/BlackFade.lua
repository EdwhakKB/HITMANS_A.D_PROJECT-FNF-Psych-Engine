function onCreatePost()
	makeLuaSprite('image3', 'blackscreen', 0, 0);
	addLuaSprite('image3', true);
	setProperty('image3.alpha', 0)
	setObjectCamera('image3', 'other');
end
function onEvent(name, value1, value2)
	if name == "BlackFade" then
        doTweenAlpha('byebye3', 'image3', 1, value1, 'linear');
	end
end