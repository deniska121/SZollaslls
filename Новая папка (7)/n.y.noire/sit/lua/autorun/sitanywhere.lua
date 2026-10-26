--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/sit/lua/autorun/sitanywhere.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if SERVER then
	AddCSLuaFile("sitanywhere/client/sit.lua")
	AddCSLuaFile("sitanywhere/helpers.lua")
	include("sitanywhere/helpers.lua")
	include("sitanywhere/server/sit.lua")
	AddCSLuaFile("sitanywhere/ground_sit.lua")
	include("sitanywhere/server/unstuck.lua")
	include("sitanywhere/ground_sit.lua")
else
	include("sitanywhere/helpers.lua")
	include("sitanywhere/client/sit.lua")
	include("sitanywhere/ground_sit.lua")
end