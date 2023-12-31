--shaders = {'bnw', 'chromaticAbber', 'chromaticPincush', 'flip', 'invert', 'chromaticRadialBlur', 'glitch', 'rainbow', 'vcr', 'vcrglitch'}
local theShader = 'null'
function onEvent(n, v1, v2)
    if n == "changeObjectShader" then
        if v1 == 'none' then
            removeSpriteShader(v2)
        else
            setSpriteShader(v2, v1)
            theShader = v2
        end
    end
end

function onCreatePost()
    setFloat(1)
end

function onUpdate()
	setShaderFloat(theShader, "uTime", os.clock())
end

function setFloat(value)
    runHaxeCode([[
        shader0.setFloat(']]..theShader..[[',]]..value..[[);
    ]])
end