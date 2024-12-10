local _, addonTable = ...
local soundPlayedThisFight = false -- Змінна для відстеження стану звуку за бій


-- Локальна функція для перевірки стану групи
function addonTable.HoldMeTight()
    local isInGroup = IsInGroup()
    local isInRaid = IsInRaid()

    if not (isInGroup or isInRaid) then
        return
    end

    local numGroupMembers = isInRaid and GetNumGroupMembers() or GetNumSubgroupMembers() + 1

    for i = 1, numGroupMembers do
        local unit = isInRaid and "raid" .. i or (i == numGroupMembers and "player" or "party" .. i)
        if UnitGroupRolesAssigned(unit) == "TANK" then

            local currentHP = UnitHealth(unit)
            local maxHP = UnitHealthMax(unit)
            local currentHPPercent = ((currentHP / maxHP) * 100)
            if currentHPPercent <= TakeItEasyDB.tankHpAmount and not soundPlayedThisFight then
                soundPlayedThisFight = true
                if TakeItEasyDB.playingNow then
                    StopSound(TakeItEasyDB.playingNow)
                    TakeItEasyDB.playingNow = nil
                end

                _, TakeItEasyDB.playingNow = PlaySoundFile("Interface/AddOns/takeiteasy/sounds/hold_me_tight.mp3", "Master")
                return
            elseif currentHPPercent >= 90 then
                soundPlayedThisFight = false
            end
        end
    end
end

