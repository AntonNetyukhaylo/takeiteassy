local _, addonTable = ...
local defaults = {
    deathAmount = 50
}

function addonTable.InitBD(self, _, name)
    if name == "TakeItEasy" then
        TakeItEasyDB = TakeItEasyDB or {}
        self.db = TakeItEasyDB -- makes it more readable and generally a good practice
        for k, v in pairs(defaults) do
            -- copy the defaults table and possibly any new options
            if self.db[k] == nil then
                -- avoids resetting any false values
                self.db[k] = v
            end
        end
    end
end