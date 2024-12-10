local _, addonTable = ...

-- Події для перевірки бою
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_HEALTH")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(_, event, ...)
    if event == "ADDON_LOADED" then
        addonTable.InitBD(_, event, ...)
    elseif event == "UNIT_HEALTH" then
        addonTable.CheckDancingInTheMoonlight()
        addonTable.HoldMeTight()
    end
end)

SLASH_tiedeath1 = "/tiedeath"
SlashCmdList["tiedeath"] = function(msg)
    local args = { strsplit(" ", msg) }
    local value = tonumber(args[1])

    if value then
        if value >= 1 and value <= 100 then
            TakeItEasyDB.deathAmount = value
            print("Кількість смертей встановлено: ", value)
        else
            print("Треба вказувати значення від 1 до 100")
        end
    else
        print("Ви не вказали значення для кількості смертей. Поточна кількість: ", TakeItEasyDB.deathAmount)
    end
end

SLASH_tietankhp1 = "/tietankhp"
SlashCmdList["tietankhp"] = function(msg)
    local args = { strsplit(" ", msg) }
    local value = tonumber(args[1])

    if value then
        if value >= 1 and value <= 100 then
            TakeItEasyDB.tankHpAmount = value
            print("Хп танка встановлено: ", value)
        else
            print("Треба вказувати значення від 1 до 100")
        end
    else
        print("Ви не вказали значення хп танка. Поточне значення: ", TakeItEasyDB.tankHpAmount)
    end
end

SLASH_tiereset1 = "/tiereset"
SlashCmdList["tiereset"] = function(msg)
    TakeItEasyDB = {}
end