local vehiclesIDs = {402, 542, 603, 475}

function onShoot(arguments)
    local vehicleID = vehiclesIDs[math.random(1, #vehiclesIDs)]
    local object = createObject(1222, arguments[8], arguments[9], arguments[10])
    setElementAlpha(object, 0)
    setElementCollisionsEnabled(object, false)
    local veh = createVehicle(vehicleID, arguments[8], arguments[9], arguments[10])
    attachElements(veh, object)
    setElementCollisionsEnabled(veh, false)
    local state = moveObject(object, 1000,arguments[4], arguments[5], arguments[6] )
    setTimer(function() 
        setElementCollisionsEnabled(veh, true)
        detachElements(veh)
        destroyElement(object)
        createExplosion(arguments[4], arguments[5], arguments[6], 11)
    end, 1000,1)
end
addEvent("onShoot", true)
addEventHandler("onShoot", getRootElement(), onShoot)
