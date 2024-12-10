local _, addonTable = ...
local soundPlayedThisFight = false -- Змінна для відстеження стану звуку за бій


-- Локальна функція для перевірки стану групи
function addonTable.CheckDancingInTheMoonlight()
    local isInGroup = IsInGroup()
    local isInRaid = IsInRaid()

    if not (isInGroup or isInRaid) then
        return
    end

    local numMembers = isInRaid and GetNumGroupMembers() or GetNumSubgroupMembers() + 1
    local deadCount = 0

    for i = 1, numMembers do
        local unit = isInRaid and "raid" .. i or (i == numMembers and "player" or "party" .. i)
        if UnitIsDeadOrGhost(unit) then
            deadCount = deadCount + 1
        end
    end

    if deadCount == 0 then
        soundPlayedThisFight = false
    end

    local deadPercent = (deadCount / numMembers) * 100

    if deadPercent >= TakeItEasyDB.deathAmount and not soundPlayedThisFight then
        -- Програємо звук, якщо його ще не грали за бій
        soundPlayedThisFight = true
        PlaySoundFile("Interface/AddOns/MemePack/sounds/Dancing_in_the_moonlight.mp3", "Master")

        -- Виводимо повідомлення в чат
        print("|cffff0000Warning: 50% of your group is dead!|r")
    end
end
