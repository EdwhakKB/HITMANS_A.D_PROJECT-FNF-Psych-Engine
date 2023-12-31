function onCreatePost()
    runHaxeCode([[
        game.initLuaShader('multi');
        shader0 = game.createRuntimeShader('multisplit');
        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.camHUD.setFilters([new ShaderFilter(shader0)]);

        shader0.setFloat('multi',1);

    ]])
    
end

function onEvent(n,v1,v2)
    if n == 'multiplier' then
        runHaxeCode([[
            shader0.setFloat('multi',]]..v1..[[);
        ]])
    end
end