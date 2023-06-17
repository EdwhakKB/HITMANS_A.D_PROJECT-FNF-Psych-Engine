local shaderName = "glitch"
function onCreate()
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
    ]])
end

local glitching = false
function onUpdate()
    songi = getPropertyFromClass('Conductor', 'songPosition')
    if glitching then
        runHaxeCode([[
            shader0.setFloat("time", ]] .. (songi / 1000) .. [[);
            shader0.setFloat("prob", ]] .. "0.25" .. [[);
        ]])
    end
end

function onEvent(name,value1,value2)
    if name == 'Glitch' then
        runHaxeCode([[
            shader0.setFloat("prob", ]] .. value1 .. [[);
            shader0.setFloat("time", ]] .. songi .. [[);
        ]])
        if value1 == '' then
            runHaxeCode([[
                shader0.setFloat("prob", ]] .. getRandomFloat(0.10,0.50) .. [[);
                shader0.setFloat("time", ]] .. songi .. [[);
            ]])
        end
    end

    if value1 == 'glitching' then
        if value2 == 'on' then
            glitching = true
        elseif value2 == 'off' then
            glitching = false
            runHaxeCode([[
                shader0.setFloat("prob", ]] .. "0" .. [[);
            ]])
        end
    end
    
    if value1 == 'chromatic' then
        runHaxeCode([[
            shader0.setFloat("intensityChromatic", ]] .. value2 .. [[);
        ]])
    end
end