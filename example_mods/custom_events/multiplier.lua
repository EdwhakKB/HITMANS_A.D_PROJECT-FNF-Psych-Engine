function onCreatePost()
    summongHxShader('split', 'MultiSplitEffect')
    setShaderProperty('split', 'multi', 1)
    setCameraShader('camHUD', 'split')
end

function onEvent(n,v1,v2)
    if n == 'multiplier' then
        setShaderProperty('split', 'multi', tonumber(v1))
    end
end