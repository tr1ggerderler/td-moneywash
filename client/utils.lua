local QBCore = exports['qb-core']:GetCoreObject()
local spawnedNPCs = {}

function SpawnNPCs()
    local modelHash = GetHashKey(Config.NPCModel)
    local animation = Config.NPCAnimation

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(10)
        end
    end

    for _, npcData in ipairs(Config.NPCs) do
        local coords = npcData.position
        if coords and coords.z then
            local npc = CreatePed(5, modelHash, coords.x, coords.y, coords.z - 0.975, coords.w, false, false)
            FreezeEntityPosition(npc, true)
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            TaskStartScenarioInPlace(npc, animation, 0, false)

            exports['qb-target']:AddTargetEntity(npc, {
                options = {
                    {
                        event = "td-moneywash:client:Open",
                        icon = "fas fa-hands",
                        label = "Para Akla",
                        action = function()
                            local playerJob = QBCore.Functions.GetPlayerData().job.name
                            if playerJob == npcData.job then
                                TriggerServerEvent('td-moneywash:server:GetMarkedBills')
                            else
                                local jobLabel = QBCore.Shared.Jobs[npcData.job] and QBCore.Shared.Jobs[npcData.job].label or "geçersiz meslek"
                                QBCore.Functions.Notify("Bu işlemi yapabilmek için " .. jobLabel .. " mesleğine sahip olmalısın.", 'error')
                            end
                        end
                    }
                },
                distance = 1.5
            })
        else
            print("Birşeyler yanlış gitti!")
        end
    end
end

function RemoveNPCs()
    for _, npc in ipairs(spawnedNPCs) do
        if DoesEntityExist(npc) then
            DeleteEntity(npc)
        end
    end
    spawnedNPCs = {}
end

SpawnNPCs()

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        RemoveNPCs()
    end
end)
