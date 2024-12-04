local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('td-moneywash:client:Open', function()
    TriggerServerEvent('td-moneywash:server:GetMarkedBills')
end)

RegisterNetEvent('td-moneywash:client:OpenWithAmount', function(markedBills)
    local input = lib.inputDialog('Kara Para Akla', { 
        { 
            type = "number", 
            label = "Kara Para", 
            default = markedBills 
        } 
    })

    if not input then return end

    if not tonumber(input[1]) then 
        QBCore.Functions.Notify('Lütfen geçerli bir sayı girin!', 'error')
        return
    end

    local inputAmount = tonumber(input[1])

    if inputAmount == 0 then 
        QBCore.Functions.Notify('Değer 0 olamaz', 'error')
        return
    end

    if inputAmount < 0 then 
        QBCore.Functions.Notify('Değer 0\'dan büyük olmalı', 'error')
        return
    end

    local newAmount = inputAmount

    if Config.UseprogressCircle then 
        if lib.progressCircle({
            duration = Config.Progressduration,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = {
                move = true,
                car = true,
            },
        }) then
            local playerCoords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('td-moneywash:server', newAmount, playerCoords)
        end
    else 
        local playerCoords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('td-moneywash:server', newAmount, playerCoords)
    end
end)