QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

isLoggedIn = false
local PlayerJob = {}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

-- Code

local HotdogBlip = nil
local IsWorking = false
local StandObject = nil
local IsPushing = false
local IsSelling = false
local IsUIActive = false
local PreparingFood = false
local SpatelObject = nil
local SellingData = {
    Enabled = false,
    Target = nil,
    HasTarget = false,
    RecentPeds = {},
    Hotdog = nil,
}
local OffsetData = {
    x = 0.0,
    y = -0.8,
    z = 1.0,
    Distance = 0.5
}
local LastStandPos = nil

local AnimationData = {
    lib = "missfinale_c2ig_11",
    anim = "pushcar_offcliff_f",
}
function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == Config.job then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["cook"].coords.x, Config.Locations["cook"].coords.y, Config.Locations["cook"].coords.z, "~g~E~w~ - Use The Machine Over Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                                MachineMenu()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == Config.job then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["dirtyangelsgarage"].coords.x, Config.Locations["dirtyangelsgarage"].coords.y, Config.Locations["dirtyangelsgarage"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["dirtyangelsgarage"].coords.x, Config.Locations["dirtyangelsgarage"].coords.y, Config.Locations["dirtyangelsgarage"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["dirtyangelsgarage"].coords.x, Config.Locations["dirtyangelsgarage"].coords.y, Config.Locations["dirtyangelsgarage"].coords.z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3D(Config.Locations["dirtyangelsgarage"].coords.x, Config.Locations["dirtyangelsgarage"].coords.y, Config.Locations["dirtyangelsgarage"].coords.z, "~g~E~w~ - Store The Vehicle")
                        else
                            DrawText3D(Config.Locations["dirtyangelsgarage"].coords.x, Config.Locations["dirtyangelsgarage"].coords.y, Config.Locations["dirtyangelsgarage"].coords.z, "~g~E~w~ - Remove A Vehicle")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                            else
                                ogVehicleSpawn()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == Config.job then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["stash"].coords.x, Config.Locations["stash"].coords.y, Config.Locations["stash"].coords.z, "~g~E~w~ - Use The Stash Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "dirtyangelsstash", {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", "dirtyangelsstash")
                            end
                        end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

function PrepareAnim()
    local ped = GetPlayerPed(-1)
    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)  
    ClearPedTasksImmediately(ped)
end

function glassofwhiskey()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()

    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
	QBCore.Functions.Progressbar("dirtyangels_makefood", "Making a Tequila Sunrise...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
   -- 
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
   TriggerServerEvent('sbrulezop:server:glassofwhiskey')
    end)
end

function cubalibre()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Making a Cuba Libre...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:cubalibre')
end)
end

function sexonthebeach()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Making a Sex on the beach...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:sexonthebeach')

end)
end

function mojito()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Making a mojito...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:mojito')

end)
end

function margarita()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Making a margarita...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:margarita')

end)
end

function glassofbeer ()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Pouring a Glass of Beer...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:glassofbeer ')

end)
end

function glassofwhiskey()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Pouring a Glass of Whiskey...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:glassofwhiskey')

end)
end

function shotofvodka()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Pouring a Shot of Vodka...", 20000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:shotofvodka')

end)
end

function tequilashot()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
    local src = source 


    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Making a Tequila Shot...", 20000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done    
    
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
    TriggerServerEvent('sbrulezop:server:tequilashot')

end)
end

function Dirtyangel()
    local ped = GetPlayerPed(-1)
    local playerPed = PlayerPedId()

    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    FreezeEntityPosition(playerPed, true)
    QBCore.Functions.Progressbar("dirtyangels_makefood", "Making a Dirty Angel...", 20000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done    
   -- 
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(playerPed, false)
   TriggerServerEvent('sbrulezop:server:dirtyangel')
    end)
end

function ogVehicleSpawn()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicle", "VehicleList", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function VehicleList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicle:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicle", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "MachineMenu",nil)
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["dirtyangelsgarage"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "TOWR"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end


function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end


function MachineMenu()
    ped = GetPlayerPed(-1);
    MenuTitle = "MachineMenu" 
    ClearMenu()
    Menu.addButton("Normal", "Normal Drinks", nil)
    Menu.addButton("Special", "Dirty Angels Special", nil)    
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function DrinksList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicles:"
    ClearMenu()
        Menu.addButton("Glass of beer", "glassofbeer", nil)
        Menu.addButton("Glass of whiskey", "glassofwhiskey", nil)
        Menu.addButton("Tequila Sunrise", "glassofwhiskey", nil)
        Menu.addButton("Cuba Libre", "cubalibre", nil)
        Menu.addButton("Sex on the beach", "sexonthebeach", nil)
        Menu.addButton("mojito", "mojito", nil)
        Menu.addButton("margarita", "margarita", nil)
        Menu.addButton("Glass of whiskey", "glassofwhiskey", nil)
        Menu.addButton("Shot of vodka", "shotofvodka", nil)
        Menu.addButton("Tequila shot", "tequilashot", nil)                

    Menu.addButton("Back", "MachineMenu",nil)
end

function DrinksaList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "MachineMenu:"
    ClearMenu()
        Menu.addButton("Dirty Angel", "Dirtyangel", nil)

    Menu.addButton("Back", "MachineMenu",nil)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end
