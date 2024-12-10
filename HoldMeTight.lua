local _, addonTable = ...
local soundPlayedThisFight = false -- Змінна для відстеження стану звуку за бій


-- Локальна функція для перевірки стану групи
function addonTable.HoldMeTight()
    local isInGroup = IsInGroup()
    local isInRaid = IsInRaid()

    if not (isInGroup or isInRaid) then
        return
    end

    local numGroupMembers = GetNumGroupMembers()
    for i = 1, numGroupMembers do
        local unit = (IsInRaid() and "raid" .. i) or "party" .. i
        if UnitGroupRolesAssigned(unit) == "TANK" then
            local currentHP = UnitHealth(unit)
            local maxHP = UnitHealthMax(unit)
            local currentHPPercent = ((currentHP / maxHP) * 100)

            if currentHPPercent <= TakeItEasyDB.tankHpAmount and not soundPlayedThisFight then
                soundPlayedThisFight = true
                return PlaySoundFile("Interface/AddOns/MemePack/sounds/hold_me_tight.mp3", "Master")
            elseif currentHPPercent >= 90 then
                soundPlayedThisFight = false
            end
        end
    end

    if deadCount == 0 then
        soundPlayedThisFight = false
    end

end

