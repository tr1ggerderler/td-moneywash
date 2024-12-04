local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('td-moneywash:server', function(amount, playerCoords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if tonumber(amount) <= 0 then 
        TriggerClientEvent('QBCore:Notify', src, 'Geçersiz miktar!', 'error')
        return
    end

    if Player.Functions.RemoveItem('markedbills', amount) then
        Player.Functions.AddMoney('cash', amount)
        TriggerClientEvent('QBCore:Notify', src, 'Para başarıyla aklandı!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Yeterli miktarda kara paranız yok!', 'error')
    end
end)

RegisterNetEvent('td-moneywash:server:GetMarkedBills', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local markedBills = 0

    if Player then
        local item = Player.Functions.GetItemByName('markedbills')
        if item then
            markedBills = item.amount
        end
    end

    TriggerClientEvent('td-moneywash:client:OpenWithAmount', src, markedBills)
end)
