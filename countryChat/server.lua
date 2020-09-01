local countriesAndMembers = {}

function toggleChat(player)
    local country = exports.admin:getPlayerCountry(player)
    if (countriesAndMembers[country]) then
        if (countriesAndMembers[country][player]) then
            countriesAndMembers[country][player] = false
        else
            countriesAndMembers[country][player] = true
        end
    end
end
addCommandHandler("toggleCountry", toggleChat)

function onPlayerJoin()
    local player = source
    local country = exports.admin:getPlayerCountry(player)
    if (countriesAndMembers[country]) then
        countriesAndMembers[country][player] = true
    else
        countriesAndMembers[country] = {}
        countriesAndMembers[country][player] = true
    end
end
addEventHandler("onPlayerJoin", getRootElement(), onPlayerJoin)

function onResourceStart()
    for key, player in ipairs(Element.getAllByType("player")) do
        local country = exports.admin:getPlayerCountry(player)
        if (countriesAndMembers[country]) then
            countriesAndMembers[country][player] = true
        else
            countriesAndMembers[country] = {}
            countriesAndMembers[country][player] = true
        end
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

function sendChatMessage(player, _, ...)
    local country = exports.admin:getPlayerCountry(player)
    if (countriesAndMembers[country]) then
        if countriesAndMembers[country][player] then
            local messageHead = "#000000(" .. country .. ") " .. player.name .. ": "
            local message = "#ffffff" .. table.concat(arg, " ")
            for player, status in pairs(countriesAndMembers[country]) do
                if (player.type == "player" and status) then
                    outputChatBox(messageHead .. message, player, 255, 255, 255, true)
                end
            end
        end
    end
end
addCommandHandler("country", sendChatMessage)
