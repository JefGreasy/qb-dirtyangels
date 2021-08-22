QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterServerEvent('sbrulezop:server:tequilasunrise')
AddEventHandler('sbrulezop:server:clubsandwich', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("tequilesunrise", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["tequilasunrise"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Tequila Sunrise..', 'error')  
     end
end)

RegisterServerEvent('sbrulezop:server:cubalibre')
AddEventHandler('sbrulezop:server:cubalibre', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("cubalibre", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cubalibre"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Cuba Libre ..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:sexonthebeach')
AddEventHandler('sbrulezop:server:sexonthebeach', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("sexonthebeach", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["sexonthebeach"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Sex on the beach..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:mojito')
AddEventHandler('sbrulezop:server:mojito', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("mojito", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["mojito"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Mojito..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:tequilashot')
AddEventHandler('sbrulezop:server:tequilashot', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("tequilashot", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["tequilashot"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Tequila Shot..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:margarita')
AddEventHandler('sbrulezop:server:margarita', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("margarita", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["margarita"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A Margarita..', 'error')      
     end
end)

RegisterServerEvent('sbrulezop:server:dirtyangel')
AddEventHandler('sbrulezop:server:dirtyangel', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
     local amount = 1
           if Player.Functions.AddItem("dirtyangel", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["dirtyangel"], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You Just Made A dirtyangel..', 'error')      
     end
end)


