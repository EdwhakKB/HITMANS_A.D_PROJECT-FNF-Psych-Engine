local show = false
local songSpeed = 0

function onCreatePost()
  makeAnimatedLuaSprite('pink', 'ladyB/hearts', -25, 0)
  addAnimationByPrefix('pink', 'boil', 'Symbol 2000', 24, true)
  playAnim('pink', 'boil')
  setObjectCamera('pink', 'other')
  setProperty('pink.alpha', 0)
  addLuaSprite('pink', true)

  makeAnimatedLuaSprite('pinkglow', 'ladyB/hearts', -25, 0)
  addAnimationByPrefix('pinkglow', 'boil', 'Symbol 2000', 24, true)
  playAnim('pinkglow', 'boil')
  setObjectCamera('pinkglow', 'other')
  setProperty('pinkglow.alpha', 0)
  addLuaSprite('pinkglow', true)
  setBlendMode('pinkglow', 'add')

  makeLuaSprite('pink2', 'ladyB/vignette', -500,-500)
  addLuaSprite('pink2')
  scaleObject('pink2', 5, 5)
  setProperty('pink2.alpha', 0)
  addLuaSprite('pink2', true)
  setObjectCamera('pink2', 'other')

  makeLuaSprite('pink22', 'ladyB/vignette2', 0,0)
  addLuaSprite('pink22')
  scaleObject('pink22', 1, 1)
  setProperty('pink22.alpha', 0)
  addLuaSprite('pink22', true)
  setObjectCamera('pink22', 'other')

  setBlendMode('pink2', 'add')
  setBlendMode('pink22', 'add')

	songSpeed = playbackRate
end

function onEvent(t, v1, v2)
  if t == 'pink toggle' then
    if v1 == 'true' then
      show = true
    elseif v1 == 'false' then
      show = false
    end
    if show then
      setBlendMode('pink', 'hardlight')
      setProperty('pink2.alpha', 0.55)
      setProperty('pink22.alpha', 0.8)
      doTweenAlpha('pinkTw', 'pink', 1, 0.3 / songSpeed, 'easein')
      doTweenAlpha('pinkTw3', 'pink2', 0.3, 0.4 / songSpeed, 'sinein')
      doTweenAlpha('pinkTw33', 'pink22', 0.5, 0.4 / songSpeed, 'sinein')
    
      setProperty('pinkglow.alpha', 0.5)
      doTweenAlpha('pinkTwGlow', 'pinkglow', 0, 0.6 / songSpeed, 'sinein')
    elseif not show then
      fadeTime = 0.5
      setBlendMode('pink', 'add')
      setBlendMode('pink22', 'add')
      setProperty('pink2.alpha', 0.75)
      setProperty('pink22.alpha', 1)
      cancelTween('pinkTw3')
      cancelTween('pinkTw33')
      doTweenAlpha('pinkTw', 'pink', 0, fadeTime/1.25, 'easeinout')
      doTweenAlpha('pinkTw2', 'pink2', 0, fadeTime, 'easeinout')
      doTweenAlpha('pinkTw22', 'pink22', 0, fadeTime, 'easeinout')
    
      setProperty('pinkglow.alpha', 1)
      doTweenAlpha('pinkTwGlow', 'pinkglow', 0, fadeTime/3, 'easeinout')
    end
  end
end