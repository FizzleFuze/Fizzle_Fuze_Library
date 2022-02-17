--Copyright
--[[
*******************************************************************************
Fizzle_Fuze's Surviving Mars Mods
Copyright (c) 2022 Fizzle Fuze Enterprises (mods@fizzlefuze.com)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

  If your software can interact with users remotely through a computer
network, you should also make sure that it provides a way for users to
get its source.  For example, if your program is a web application, its
interface could display a "Source" link that leads users to an archive
of the code.  There are many ways you could offer source, and different
solutions will be better for different programs; see section 13 for the
specific requirements.

  You should also get your employer (if you work as a programmer) or school,
if any, to sign a "copyright disclaimer" for the program, if necessary.
For more information on this, and how to apply and follow the GNU AGPL, see
<https://www.gnu.org/licenses/>.
*******************************************************************************
--]]

--logging variables
FFL_Debugging = false

--print log messages to console and disk
local function FFL_PrintLog()
    local MsgLog = SharedModEnv["Fizzle_FuzeLog"]

    if #MsgLog > 0 then
        for _, Msg in ipairs(MsgLog) do
            print(Msg)
        end
        FlushLogFile()

        SharedModEnv["Fizzle_FuzeLog"] = {}
        return
    end
end

--setup cross-mod variables for log if needed
if not SharedModEnv["Fizzle_FuzeLog"] then
    SharedModEnv["Fizzle_FuzeLog"] = { "*** ", CurrentModDef.title," Loaded! ***" }
end

--main logging function
function FFL_LogMessage(...)
    local Sev, Arg = nil, {...}
    local SevType = {"INFO", "DEBUG", "WARNING", "ERROR", "CRITICAL"}
    local MsgLog = SharedModEnv["Fizzle_FuzeLog"]

    if #Arg == 0 then
        print("/?.lua CRITICAL: No error message!")
        FlushLogFile()
        MsgLog[#MsgLog+1] = "/?.lua CRITICAL: No error message!"
        SharedModEnv["Fizzle_FuzeLog"] = MsgLog
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

    if (Sev == "DEBUG: " and FFL_Debugging == false) or (Sev == "INFO: " and Info == false) then
        return
    end

    local Msg = Arg[1].."/"..Arg[2]..".lua "
    for i = 3, #Arg do
        Msg = Msg..tostring(Arg[i])
    end
    MsgLog[#MsgLog+1] = Msg
    SharedModEnv["Fizzle_FuzeLog"] = MsgLog

    if FFL_Debugging == true then
        PrintLog()
    end
end

--wrapper logging function for this file
local function Log(...)
    FFL_LogMessage(CurrentModDef.title, "LibMain", ...)
end

--translation strings
FFL_Translate = { ID = {}, Text = {} }
--Translate.Text['MoxieDisable'] = "Replaced by Hydrolysis Reactor."

--get every string a unique ID
for k, _ in pairs(FFL_Translate.Text) do
    FFL_Translate.ID[k] = RandomLocId()
    if not FFL_Translate.ID[k] then
        Log("ERROR", "Could not find valid translation ID for '", k, "'!")
    end
end

function OnMsg.NewHour()
    if FFL_Debugging == true then
        FFL_PrintLog()
    end
end
function OnMsg.NewDay()
    FFL_PrintLog()
end