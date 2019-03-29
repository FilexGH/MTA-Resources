-- In order to use don't forget to set oop on (<oop>true</oop>) in meta.xml file
local crackingPadElements = nil
local chooseNumberElements = nil
local randomNumber
local startTime
local endTime
local keys = {
    num_0 = 0,
    num_1 = 1,
    num_2 = 2,
    num_3 = 3,
    num_4 = 4,
    num_5 = 5,
    num_6 = 6,
    num_7 = 7,
    num_8 = 8,
    num_9 = 9
}

function chooseNumber()
    if crackingPadElements ~= nil or chooseNumberElements ~= nil then
        return
    end
    showCursor(true)
    createChooseTab()
    addEventHandler("onClientGUIClick", chooseNumberElements.buttonClose, onChooseCloseButtonClick, false)
    addEventHandler("onClientGUIClick", chooseNumberElements.buttonStart, onChooseStartButtonClick, false)
end
addCommandHandler("start", chooseNumber)

function createChooseTab()
    chooseNumberElements = {}
    local screenW, screenH = guiGetScreenSize()
    chooseNumberElements.window =
        GuiWindow((screenW - 195) / 2, (screenH - 116) / 2, 195, 116, "Cracking Pad - Number Interval", false)
    chooseNumberElements.window:setSizable(false)
    chooseNumberElements.window:setMovable(false)
    chooseNumberElements.buttonStart = GuiButton(9, 79, 173, 26, "Start", false, chooseNumberElements.window)
    chooseNumberElements.buttonClose = GuiButton(160, 23, 22, 22, "X", false, chooseNumberElements.window)
    chooseNumberElements.edit = GuiEdit(10, 51, 172, 23, "", false, chooseNumberElements.window)
    chooseNumberElements.label =
        GuiLabel(13, 25, 165, 20, "Insert a maximum interval", false, chooseNumberElements.window)
end

function onChooseCloseButtonClick()
    removeEventHandler("onClientGUIClick", chooseNumberElements.buttonClose, onChooseCloseButtonClick)
    removeEventHandler("onClientGUIClick", chooseNumberElements.buttonStart, onChooseStartButtonClick)
    chooseNumberElements.window:destroy()
    chooseNumberElements = nil
    showCursor(false)
end

function onChooseStartButtonClick()
    local interval = tonumber(chooseNumberElements.edit:getText())
    if interval then
        removeEventHandler("onClientGUIClick", chooseNumberElements.buttonClose, onChooseCloseButtonClick)
        removeEventHandler("onClientGUIClick", chooseNumberElements.buttonStart, onChooseStartButtonClick)
        startCracking(interval)
        chooseNumberElements.window:destroy()
        chooseNumberElements = nil
    else
        outputChatBox("Please provide a valid number.", 255, 0, 0)
    end
end

function startCracking(interval)
    makeCrackingTab()
    startTime = getTickCount()
    randomNumber = math.random(0, interval)
    addEventHandler("onClientGUIClick", getRootElement(), onButtonClick)
    addEventHandler("onClientKey", getRootElement(), onKeyPress)
end

function makeCrackingTab()
    crackingPadElements = {}
    local screenW, screenH = guiGetScreenSize()
    crackingPadElements.window = GuiWindow((screenW - 248) / 2, (screenH - 360) / 2, 248, 360, "Cracking Pad", false)
    crackingPadElements.window:setSizable(false)
    crackingPadElements.window:setMovable(false)
    crackingPadElements.edit = GuiEdit(10, 25, 226, 34, "", false, crackingPadElements.window)
    crackingPadElements.edit:setReadOnly(true)
    crackingPadElements.button0 = GuiButton(86, 278, 73, 67, "0", false, crackingPadElements.window)
    crackingPadElements.button1 = GuiButton(10, 63, 73, 67, "1", false, crackingPadElements.window)
    crackingPadElements.button2 = GuiButton(86, 63, 73, 67, "2", false, crackingPadElements.window)
    crackingPadElements.button3 = GuiButton(163, 63, 73, 67, "3", false, crackingPadElements.window)
    crackingPadElements.button4 = GuiButton(11, 134, 73, 67, "4", false, crackingPadElements.window)
    crackingPadElements.button5 = GuiButton(86, 134, 73, 67, "5", false, crackingPadElements.window)
    crackingPadElements.button6 = GuiButton(163, 134, 73, 67, "6", false, crackingPadElements.window)
    crackingPadElements.button7 = GuiButton(11, 206, 73, 67, "7", false, crackingPadElements.window)
    crackingPadElements.button8 = GuiButton(86, 206, 73, 67, "8", false, crackingPadElements.window)
    crackingPadElements.button9 = GuiButton(163, 206, 73, 67, "9", false, crackingPadElements.window)
    crackingPadElements.buttonEnter = GuiButton(163, 278, 73, 67, "ENTER", false, crackingPadElements.window)
    crackingPadElements.buttonDelete = GuiButton(11, 278, 73, 67, "#", false, crackingPadElements.window)
end

function onButtonClick()
    for _index, button in pairs(crackingPadElements) do
        if crackingPadElements == nil then
            return
        end
        if source == crackingPadElements.window or source == crackingPadElements.edit then
            return
        end
        if button == source then
            if crackingPadElements.edit:getText() == "HIGHER" or crackingPadElements.edit:getText() == "LOWER" then
                crackingPadElements.edit:setText("")
            end
            if _index == "buttonEnter" then
                onEnterButtonOrKeyClick()
            elseif _index == "buttonDelete" then
                onDeleteButtonOrKeyClick()
            else
                local value = _index:gsub("button", "")
                local editValue = crackingPadElements.edit:getText()
                crackingPadElements.edit:setText(editValue .. value)
            end
        end
    end
end

function onKeyPress(key, pOr)
    if crackingPadElements == nil then
        return
    end
    if pOr == false then
        if crackingPadElements.edit:getText() == "HIGHER" or crackingPadElements.edit:getText() == "LOWER" then
            crackingPadElements.edit:setText("")
        end
        for _index, keyValue in pairs(keys) do
            if _index:find(key) ~= nil then
                local editValue = crackingPadElements.edit:getText()
                crackingPadElements.edit:setText(editValue .. keyValue)
            end
        end
        if key == "num_enter" or key == "enter" then
            onEnterButtonOrKeyClick()
        elseif key == "backspace" then
            onDeleteButtonOrKeyClick()
        end
    end
end

function onDeleteButtonOrKeyClick()
    if crackingPadElements == nil then
        return
    end
    local editValue = crackingPadElements.edit:getText()
    local editValueLenght = editValue:len()
    editValue = editValue:sub(0, editValueLenght - 1)
    crackingPadElements.edit:setText(editValue)
end

function onEnterButtonOrKeyClick()
    if crackingPadElements == nil then
        return
    end
    value = crackingPadElements.edit:getText()
    value = tonumber(value)
    if value == nil then
        return
    end
    if value > randomNumber then
        crackingPadElements.edit:setText("LOWER")
    elseif value < randomNumber then
        crackingPadElements.edit:setText("HIGHER")
    elseif value == randomNumber then
        removeEventHandler("onClientGUIClick", getRootElement(), onButtonClick)
        removeEventHandler("onClientKey", getRootElement(), onKeyPress)
        showCursor(false)
        crackingPadElements.window:destroy()
        crackingPadElements = nil
        endTime = getTickCount()
        local timeSpent = math.floor((endTime - startTime) * 10 ^ -3)
        outputChatBox("You have spent " .. timeSpent .. " seconds to crack this number", 0, 255, 0)
        chooseNumber()
    end
end
