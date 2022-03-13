--See LICENSE for copyright info

--wrapper logging function for this file
local function Log(...)
    FF.Funcs.LogMessage(CurrentModDef.title, "XTemplates", ...)
end

-- yay "templates"
function FF.X.Create(Type, id, Parent, TextStyle)

    if not id then
        Log("ERROR", "Cannot create X object: no id specified!")
    end

    if not Parent then
        Log("ERROR", "Cannot create X object: no Parent specified!")
    end

    if Type == "Text" then

        if not TextStyles[TextStyle] then
            Log("ERROR", "Cannot create XText: Invalid TextStyle: ", tostring(TextStyle))
            return
        end

        local Text = XText:new({
            Dock = 'top',
            HandleKeyboard = false,
            Id = id,
            TextStyle = TextStyle,
            Translate = true,
            VAlign = 'stretch'
        }, Parent)
        return Text
    end

    if Type == "Window" then
        local Window = XWindow:new({
            Dock = "box",
            HAlign = "center",
            HandleKeyboard = false,
            HandleMouse = true,
            Id = id,
            IdNode = true,
            Padding = box(2,2,2,2),
            RolloverTemplate = "Rollover",
            VAlign = "top",
        }, Parent)
        return Window
    end

    if Type == "Frame" then
        local Frame = XFrame:new({
            Dock = "box",
            HandleKeyboard = false,
            Id = id,
            Padding = box(5,0,5,5),
            VAlign = "stretch",
        }, Parent)
        return Frame
    end
end