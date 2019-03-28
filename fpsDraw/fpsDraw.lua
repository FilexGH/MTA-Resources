local devScreenW, devScreenH = 1440,900 -- Developer Screen W/H
local ScreenW, ScreenH = guiGetScreenSize() 
local fpsDrawDimentions = {
    1345 / devScreenW*ScreenW,
    32 / devScreenW*ScreenW,
    1416 / devScreenW*ScreenW,
    52 / devScreenW*ScreenW
} 
local fps = 0
function system() 
    function updateFPS(frames)
        fps =  tostring((1 / frames) * 1000)
        fps = fps:sub(1,2 )
    end
    addEventHandler("onClientPreRender", getRootElement(), updateFPS)
    setTimer(
        function()
            removeEventHandler("onClientPreRender", getRootElement(),updateFPS) 
        end , 50,1)
end 
setTimer(
    function() 
         system()  
    end , 600, 0) 

function drawFPS()
    local fpsText = "FPS : "..fps
    dxDrawText(fpsText, fpsDrawDimentions[1] - 1, fpsDrawDimentions[2] - 1, fpsDrawDimentions[3] - 1, fpsDrawDimentions[4] - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText(fpsText, fpsDrawDimentions[1] + 1, fpsDrawDimentions[2] - 1, fpsDrawDimentions[3] + 1, fpsDrawDimentions[4] - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText(fpsText, fpsDrawDimentions[1] - 1, fpsDrawDimentions[2] + 1, fpsDrawDimentions[3] - 1, fpsDrawDimentions[4] + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText(fpsText, fpsDrawDimentions[1] + 1, fpsDrawDimentions[2] + 1, fpsDrawDimentions[3] + 1, fpsDrawDimentions[4] + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawText(fpsText, fpsDrawDimentions[1], fpsDrawDimentions[2], fpsDrawDimentions[3], fpsDrawDimentions[4], tocolor(fpsDrawDimentions[2], 230, 22, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
end 
addEventHandler("onClientRender", getRootElement(), drawFPS)
