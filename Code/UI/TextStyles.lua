--See LICENSE for copyright info

--wrapper logging function for this file
local function Log(...)
    FFL_LogMessage(CurrentModDef.title, "XTemplates", ...)
end

--create/update text styles
function FFL_CreateTextStyles()--returns success status
    if not TextStyles then
        Log("ERROR", "No text styles!")
        return false
    end

    local TextStyle = {
        Achievement = {
            Title,
            Text,
            Text_2
        }
    }

    TextStyle.Achievement.Title = {
        DisabledRolloverTextColor = -10197916,
        DisabledTextColor = -10197916,
        RolloverTextColor = -727947,
        TextColor = -727947,
        TextFont = FFL_Translate("LibelSuitRg, 18, aa"),
        group = "Game",
        id = "Title",
        save_in = "common"
    }

    TextStyle.Achievement.Text = {
        DisabledRolloverTextColor = -7566196,
        DisabledTextColor = -7566196,
        RolloverTextColor = -1,
        TextColor = -1,
        TextFont = FFL_Translate("LibelSuitRg, 16, aa"),
        group = "Game",
        id = "Description",
        save_in = "common"
    }

    TextStyle.Achievement.Text_2 = {
        DisabledRolloverTextColor = -7566196,
        DisabledTextColor = -7566196,
        RolloverTextColor = -1,
        TextColor = -1, --2do: find a better colour
        TextFont = FFL_Translate("LibelSuitRg, 18, aa"),
        group = "Game",
        id = "Progress",
        save_in = "common"
    }


    for Category, Style in pairs(TextStyle) do

        Style.id = "FF_" .. tostring(Category) .. Style.id
        if TextStyle[Style.id] then
            if not TextStyle[Style.id] == TextStyles[Style.id] then
                TextStyles[Style.id]:delete()
            end
        end

        if not TextStyle[Style.id] then
            PlaceObj("TextStyle", Style)
        end
    end

    return true
end