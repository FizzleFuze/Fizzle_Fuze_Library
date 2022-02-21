--See LICENSE for copyright info

--wrapper logging function for this file
local function Log(...)
    FF.Funcs.Log(CurrentModDef.title, "XTemplates", ...)
end

-- yay templates
function FF.Funcs.CreateXTemplates()

    --templates are for linking to objects it seems.. not what I need right now.

    --[[
    PlaceObj('XTemplate', {
        __is_kind_of = "XText",
        group = "FF_PrimaryAchievement",
        id = "FF_PrimaryAchievementText",
        PlaceObj('XTemplateWindow', {
          '__class', "XText",
          'Dock', 'Top',
          'HandleKeyboard', false,
          'HideOnEmpty', true,
          'Padding', box(2, 1, 2, 1),
          'Translate', true,
        }),
    })
    --]]

end