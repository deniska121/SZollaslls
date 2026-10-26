--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/includes/modules/ppp_includes/console.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
-- Convars
pk_pills.convars = {}
-- Admin vars
-- Client vars
if CLIENT then
    pk_pills.convars.cl_thirdperson = CreateClientConVar("pk_pill_cl_thirdperson", 1)
end

-- Admin var setter command.
if SERVER then
    local function admin_set(ply, cmd, args)
        if not ply then
            print("If you are using the server console, you should set the variables directly!")

            return
        end

        if not ply:IsSuperAdmin() then
            ply:PrintMessage(HUD_PRINTCONSOLE, "You must be a super admin to use this command.")

            return
        end

        local var = args[1]
        local value = args[2]

        if not var then
            if ply then
                ply:PrintMessage(HUD_PRINTCONSOLE, "Please supply a valid convar name. Do not include 'pk_pill_admin_'.")
            end

            return
        elseif not ConVarExists("pk_pill_admin_" .. var) then
            ply:PrintMessage(HUD_PRINTCONSOLE, "Convar 'pk_pill_admin_" .. var .. "' does not exist. Please supply a valid convar name. Do not include 'pk_pill_admin_'.")

            return
        end

        if not value then
            ply:PrintMessage(HUD_PRINTCONSOLE, "Please supply a value to set the convar to.")

            return
        end

        RunConsoleCommand("pk_pill_admin_" .. var, value)
    end

    concommand.Add("pk_pill_admin_set", admin_set, nil, "Helper command for setting Morph Mod admin convars. Available to super admins.")
end
