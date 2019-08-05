function dataSending()
    local serverTime = getRealTime()
    local serverHours = serverTime.hour 
    local serverMinutes = serverTime.minute
    local serverSeconds = serverTime.second  
    triggerClientEvent("calculate:difference",client,serverHours,serverMinutes,serverSeconds)
end 
addEvent("data:sending",true)
addEventHandler("data:sending",getRootElement(),dataSending)
