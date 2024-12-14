local _, addonTable = ...
local tanks = {}

local lastExecutionTime = 0 -- Змінна для збереження часу останнього запуску
local cooldown = 5 -- Час у секундах між запусками

-- Локальна функція для перевірки стану групи
function addonTable.HoldMeTight()
    local currentTime = GetTime() -- Отримуємо поточний час
    local isInGroup = IsInGroup()
    local isInRaid = IsInRaid()
    if currentTime - lastExecutionTime < cooldown then
        return ;
    end

    if not (isInGroup or isInRaid) then
        return
    end

    local numGroupMembers = isInRaid and GetNumGroupMembers() or GetNumSubgroupMembers() + 1

    -- Отримуємо всіх танків
    for i = 1, numGroupMembers do
        local unit = isInRaid and "raid" .. i or (i == numGroupMembers and "player" or "party" .. i)
        if UnitGroupRolesAssigned(unit) == "TANK" then
            -- Додаємо інформацію про танка до масиву
            table.insert(tanks, {
                unit = unit,
                name = UnitName(unit),
            })
        end
    end

    -- Перевіряємо чи треба грати пісню, та програємо її
    for _, tank in ipairs(tanks) do
        if not UnitIsDead(tank.unit) and not UnitIsDeadOrGhost(tank.unit) then
            local currentHP = UnitHealth(tank.unit)
            local maxHP = UnitHealthMax(tank.unit)
            local currentHPPercent = ((currentHP / maxHP) * 100)

            if currentHPPercent <= TakeItEasyDB.tankHpAmount then
                if TakeItEasyDB.playingNow then
                    StopSound(TakeItEasyDB.playingNow)
                    TakeItEasyDB.playingNow = nil
                end
                lastExecutionTime = currentTime
                _, TakeItEasyDB.playingNow = PlaySoundFile("Interface/AddOns/takeiteasy/sounds/hold_me_tight.mp3", "Master")
                return
            end
        end
    end
end



--for i = 1, numGroupMembers do
--    local unit = isInRaid and "raid" .. i or (i == numGroupMembers and "player" or "party" .. i)
--    if UnitGroupRolesAssigned(unit) == "TANK" then
--
--        local currentHP = UnitHealth(unit)
--        local maxHP = UnitHealthMax(unit)
--        local currentHPPercent = ((currentHP / maxHP) * 100)
--        if currentHPPercent <= TakeItEasyDB.tankHpAmount and not soundPlayedThisFight then
--            soundPlayedThisFight = true
--            if TakeItEasyDB.playingNow then
--                StopSound(TakeItEasyDB.playingNow)
--                TakeItEasyDB.playingNow = nil
--            end
--
--            _, TakeItEasyDB.playingNow = PlaySoundFile("Interface/AddOns/takeiteasy/sounds/hold_me_tight.mp3", "Master")
--            return
--        elseif currentHPPercent >= 90 then
--            soundPlayedThisFight = false
--        end
--    end
--end
--end

