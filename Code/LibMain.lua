--See LICENSE for copyright info

--setup global if needed
if not rawget(_G, 'FF') then
    FF = {
        Lib = {
            Debug = false,
            MsgLog = { "*** Fizzle Fuze's Library loaded! ***" }
        },
        Funcs = { },
        X = { }
    }
end

--print log messages to console and disk
local function PrintLog()

    if #FF.Lib.MsgLog > 0 then
        for _, Msg in ipairs(FF.Lib.MsgLog) do
            print(Msg)
        end
        FlushLogFile()

        FF.Lib.MsgLog = {}
        return
    end
end

--main logging function
function FF.LogMessage(...)
    local Sev, Arg = nil, {...}
    local SevType = {"INFO", "DEBUG", "WARNING", "ERROR", "CRITICAL"}

    if #Arg == 0 then
        print("/?.lua CRITICAL: No error message!")
        FlushLogFile()
        FF.Lib.MsgLog[#FF.Lib.MsgLog+1] = "/?.lua CRITICAL: No error message!"
        return
    end

    if #Arg < 3 then
        local Msg = "/?.lua CRITICAL: Logging error! Less than 3 arguments."
        print(Msg)
        print("Args = ", Arg)
        for k,v in pairs(Arg) do
            print (k, " = ", v)
        end
        FlushLogFile()
        FF.Lib.MsgLog[#FF.Lib.MsgLog+1] = Msg
        return
    end

    for _, ST in ipairs(SevType) do
        if Arg[3] == ST then -- 3rd arg = severity
            Arg[3] = Arg[3]..": "
            Sev = Arg[3]
            break
        end
    end

    if not Sev then
        Sev = "DEBUG: "
        Arg[3] = "DEBUG: "..Arg[3]
    end

    if (Sev == "DEBUG: " or Sev == "INFO: ") and not FF.Lib.Debug then
        return
    end

    local Msg = Arg[1].."/"..Arg[2]..".lua "
    for i = 3, #Arg do
        Msg = Msg .. tostring(Arg[i])
    end
    FF.Lib.MsgLog[#FF.Lib.MsgLog + 1] = Msg

    if FF.Lib.Debug then
        PrintLog()
    end
end
FF.Funcs.LogMessage = FF.LogMessage

--wrapper logging function for this file
local function Log(...)
    FF.Funcs.LogMessage(CurrentModDef.title, "LibMain", ...)
end

--Translate function which automatically gets ID
function FF.Translate(TString)
    local id = IsT(TString)

    if type(id) == "number" then -- already has a translation
        return T(TString)
    else
        id = RandomLocId()
        if type(id) ~= "number" then
            Log("ERROR", "Failed to find ID for translation!")
        end
        return T(id, TString)
    end
end
FF.Funcs.Translate = FF.Translate

--Format number as a pretty string or a T
function FF.FormatNumber(Number, AsT)
    AsT = AsT or false

    local Ret = InfobarObj.FmtRes(nil, Number)
    if not AsT then
        Ret = _InternalTranslate(Ret)
    end
    return Ret
end
FF.Funcs.FormatNumber = FF.FormatNumber

--start yer engines
local function Init()
    FF.Funcs.CreateTextStyles()
end

--event handling
OnMsg.CityStart = Init
OnMsg.LoadGame = Init

function OnMsg.ModsReloaded()
    Init()
end

function OnMsg.NewHour(Hour)
    if FF.Lib.Debug then
        Log("New Hour: ", Hour)
        PrintLog()
    end
end

function OnMsg.NewDay(Day)
    if FF.Lib.Debug then
        Log("New Day: ", Day)
    end
    PrintLog()
end