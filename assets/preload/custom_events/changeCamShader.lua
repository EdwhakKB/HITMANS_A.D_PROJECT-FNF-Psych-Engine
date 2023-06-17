--shaders = {'bnw', 'chromaticAbber', 'chromaticPincush', 'flip', 'invert', 'chromaticRadialBlur', 'glitch', 'rainbow', 'vcr', 'vcrglitch'}
local currentShader = 'null'

function onEvent(n, v1, v2)
    if n == "changeCamShader" then
        if v1 == 'none' then
            runHaxeCode([[
                game.]].. v2 ..[[.setFilters([]);
            ]])
        else
            shaderCoordFix()
            currentShader = v1
            applyShader(v1,v2)
        end
    end
end

function onCreatePost()
	shaderCoordFix() -- initialize a fix for textureCoord when resizing game window
	makeLuaSprite("tempShader0") --xtra cam support
    setFloat(1)
end

function onUpdate()
	setShaderFloat("tempShader0", "iTime", os.clock())
end

function setFloat(value)
    runHaxeCode([[
        shader0.setFloat('tempShader0',]]..value..[[);
    ]])
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end

function applyShader(shaderName,cameraToApply)

    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);

		var shader0 = game.createRuntimeShader(shaderName);
        game.]]..cameraToApply..[[.setFilters([new ShaderFilter(shader0)]);

        game.getLuaObject("tempShader0").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
        return;
    ]])
end