--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/services/lua/sh_services_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Dispatcher = Dispatcher or {}
Dispatcher.Config = {}
Dispatcher.Config.Grps = {}

local function CreateConfig()
	Dispatcher.Config.Grps = {
		["NYPD"] = {
			Teams = table.Copy(GAMEMODE.CivilProtection),
			Responders = function(ply)
				return ply:isCP()
			end,
			CustomCheck = function(ply) return true end,
		},
		["FDNY"] = {
			Teams = {
				[TEAM_REF] = true,
				[TEAM_FIREFIGHTER] = true,
			},
			Responders = function(ply)
				return ply:isEMS()
			end,
			CustomCheck = function(ply) return true end,
		},
	}
end

hook.Add("PostGamemodeLoaded", "CreateServicesConfig", function()
	CreateConfig()
end)

if GAMEMODE then
	CreateConfig()
end