--See LICENSE for copyright info

--wrapper logging function for this file
local function Log(...)
    FF.Funcs.LogMessage(CurrentModDef.title, "TextStyles", ...)
end

--create/update text styles
function FF.Funcs.CreateTextStyles()--returns success status
    if not TextStyles then
        Log("ERROR", "Text styles not loaded!")
        return false
    end

    local TextStyle = { PrimaryAchievement = {  } }

        TextStyle.PrimaryAchievement.Title = {
            DisabledRolloverTextColor = -10197916,
            DisabledTextColor = -10197916,
            RolloverTextColor = -727947,
            TextColor = -727947,
            TextFont = FF.Funcs.Translate("LibelSuitRg, 18, aa"),
            group = "Game",
            save_in = "common"
        }

        TextStyle.PrimaryAchievement.Text = {
            DisabledRolloverTextColor = -7566196,
            DisabledTextColor = -7566196,
            RolloverTextColor = -1,
            TextColor = -1,
            TextFont = FF.Funcs.Translate("LibelSuitRg, 16, aa"),
            group = "Game",
            save_in = "common"
        }

        TextStyle.PrimaryAchievement.Progress = {
            DisabledRolloverTextColor = -7566196,
            DisabledTextColor = -7566196,
            RolloverTextColor = -1,
            TextColor = -1, --2do: find a better colour
            TextFont = FF.Funcs.Translate("LibelSuitRg, 18, aa"),
            group = "Game",
            save_in = "common"
        }

    --generate id
    for CatKey, Cat in pairs(TextStyle) do
        for StyleKey, Style in pairs(Cat) do
            Style.id = "FF_" .. tostring(CatKey) .. "_" .. tostring(StyleKey)
            if not Style.id then
                Log("ERROR", "No style id!")
                return false
            end

            if TextStyles[Style.id] then
                TextStyles[Style.id]:delete()
            end

            PlaceObj("TextStyle", Style)
        end
    end
    return true
end