-- Debug API exports for resedit.
-- Use those if you want a quick interface for error detection and server maintenance.
local dxRoot = dxRoot;

function openScript(resource, scriptPath, lineNumberOpt)
    -- Do some typechecking, since IIYAMA suggested to do that.
    if not (type(resource) == "string") or not (type(scriptPath) == "string") then
        return false, "invalid arguments";
    end
    
    if not (lineNumberOpt == nil) and not (type(lineNumberOpt) == "number") then
        return false, "invalid line number argument";
    end

    -- Before attempting anything volatile, see if a resource with that script even exists.
    if not (doesResourceHaveScript(resource, scriptPath)) then
        return false, "resource or script unavailable";
    end

    -- First try to actually show the editor GUI.
    local couldDisplayEditor, errMsg = showResourceGUI(true);
    
    if not (couldDisplayEditor) then
        local debugMsg = "failed to display editor";
        
        if (errMsg) then
            debugMsg = debugMsg .. ": " .. errMsg;
        end
    
        return false, debugMsg;
    end

    -- Now just open the script.
    local mainGUI = mainGUI;
    
    local openSuccess, errMsg = mainGUI.openScriptByPath(resource, scriptPath, lineNumberOpt);
    
    if not (openSuccess) then
        local debugMsg = "failed to open script";
        
        if (errMsg) then
            debugMsg = debugMsg .. ": " .. errMsg;
        end
        
        return false, debugMsg;
    end
    
    return true;
end

function isEditorDrawing()
    return dxRoot.isVisible();
end