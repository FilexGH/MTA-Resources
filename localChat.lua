-- server side script 
function localMessage(player, _, ...)
    local r, g, b
    local team = getPlayerTeam(player)
    local startText
    local stringT
    if not team then
        r, g, b = 255, 255, 255
        startText = ("#%02x%02x%02x"):format(255, 0, 0) .. "LocalChat: " .. ("#%02x%02x%02x"):format(255, 255, 255)
    else
        r, g, b = getTeamColor(team)
        startText = ("#%02x%02x%02x"):format(r, g, b) .. "LocalChat: "
    end
    stringT = startText .. getPlayerName(player) .. ":#ffffff " .. table.concat(arg, " ")
    local x, y, z = getElementPosition(player)
    for _index, player in pairs(getElementsWithinRange(x, y, z, 300,"player")) do
        outputChatBox(stringT, player, 255, 255, 255, true)
    end
end
addCommandHandler("localChat", localMessage)

function chatBind()
    bindKey( source, "u", "down", "chatbox",  "localChat")
end
addEventHandler("onPlayerJoin",getRootElement(),chatBind)
