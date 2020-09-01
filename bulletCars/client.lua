function onResourceStart()
    addEventHandler("onClientPlayerWeaponFire", getRootElement(), onShoot)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)

function onShoot(...)
    triggerServerEvent("onShoot", localPlayer, arg)
end
