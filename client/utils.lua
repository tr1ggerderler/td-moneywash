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

    for _, coords in ipairs(Config.NPCs) do
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
                    label = "Para Akla"
                }
            },
            distance = 1.5
        })

        table.insert(spawnedNPCs, npc)
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