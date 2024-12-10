local _, addonTable = ...
local defaults = {
    deathAmount = 50, -- Скільки % групи має померти
    tankHpAmount = 20, -- Скільки % хп має бути у танка для програшу музики
    playingNow = nil
}

function addonTable.InitBD(_, _, name)
    if string.lower(name) == "takeiteasy" then
        TakeItEasyDB = TakeItEasyDB or {}
        for k, v in pairs(defaults) do
            -- copy the defaults table and possibly any new options
            if TakeItEasyDB[k] == nil then
                -- avoids resetting any false values
                TakeItEasyDB[k] = v
            end
        end
    end
end