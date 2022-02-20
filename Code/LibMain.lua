--See LICENSE for copyright info

--logging variables
FFL_Log = { "*** Fizzle Fuze's Library loaded! *** "}
if not SharedModEnv["FFL_Debug"] then
    SharedModEnv["FFL_Debug"] = false
end

--print log messages to console and disk
local function FFL_PrintLog()

    if #FFL_Log > 0 then
        for _, Msg in ipairs(FFL_Log) do
            print(Msg)
        end
        FlushLogFile()

        FFL_Log = {}
        return
    end
end

--main logging function
function FFL_LogMessage(...)
    local Sev, Arg = nil, {...}
    local SevType = {"INFO", "DEBUG", "WARNING", "ERROR", "CRITICAL"}

    if #Arg == 0 then
        print("/?.lua CRITICAL: No error message!")
        FlushLogFile()
        FFL_Log[#FFL_Log+1] = "/?.lua CRITICAL: No error message!"
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

    if (Sev == "DEBUG: " or Sev == "INFO: ") and not SharedModEnv["FFL_Debug"] then
        return
    end

    local Msg = Arg[1].."/"..Arg[2]..".lua "
    for i = 3, #Arg do
        Msg = Msg .. tostring(Arg[i])
    end
    FFL_Log[#FFL_Log + 1] = Msg

    if SharedModEnv["FFL_Debug"] then
        FFL_PrintLog()
    end
end

--wrapper logging function for this file
local function Log(...)
    FFL_LogMessage(CurrentModDef.title, "LibMain", ...)
end

function FFL_Translate(TString)
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

function FFL_FormatNumber(Number, AsT)
    AsT = AsT or false

    local Ret = InfobarObj.FmtRes(nil, Number)
    if not AsT then
        Ret = _InternalTranslate(Ret)
    end
    return Ret
end

function OnMsg.NewHour(Hour)
    if SharedModEnv["FFL_Debug"] then
        Log("New Hour: ", Hour)
        FFL_PrintLog()
    end
end

function OnMsg.NewDay(Day)
    if SharedModEnv["FFL_Debug"] then
        Log("New Day: ", Day)
    end
    FFL_PrintLog()
end