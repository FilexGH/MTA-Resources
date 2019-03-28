local blowVehicles = {
    402,
    542,
    603,
    475
}
function blowFuc(weapon, ex, ey, ex, hit, sx, sy, sz)
    if weapon == 30 or weapon == 31 then
        local model = blowVehicles[math.random(1, 4)]
        iprint(sx, sy, sz, ex, ey, ex)
        local vehicle = createVehicle(model, sx, sy, sz)
        setElementPosition(vehicle, ex, ey, ex)
        blowVehicle(vehicle, true)
        setTimer(
            function()
                destroyElement(vehicle)
            end,
            5000,
            1
        )
    end
end
addEventHandler("onPlayerWeaponFire", getRootElement(), blowFuc)
