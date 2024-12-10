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
    end
end)

SLASH_MEMEPACK1 = "/meme"
SlashCmdList["TAKEITEASY"] = function(msg)
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
        print("Ви не вказали значення для кількості смертей. Поточна кількість: ",  TakeItEasyDB.deathAmount)
    end
end
