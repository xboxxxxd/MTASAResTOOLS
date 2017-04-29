fwShader = dxCreateShader('fwShader.fx', 0, 0, false, 'object') 
dxSetShaderValue(fwShader, 'red', 1.0) 
dxSetShaderValue(fwShader, 'green', 0.0) 
dxSetShaderValue(fwShader, 'blue', 0.0) 
dxSetShaderValue(fwShader, 'alpha', 1.0) 
  
objects = getElementsByType('object') 
for _, object in ipairs(objects) do 
        local model = getElementModel(object) 
        if (model == 3515) then 
                engineApplyShaderToWorldTexture(fwShader, '*',object)
end)