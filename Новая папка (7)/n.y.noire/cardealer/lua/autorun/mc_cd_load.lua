--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/cardealer/lua/autorun/mc_cd_load.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔══╗───╔╗╔══╗───────────╔╗──--
-- ║═╦╩╦╦╗║║║╔╗║╔═╦╦╦═╦╦═╦═╣╚╗─--
-- ║╔╣╬║╔╝║╚╣╠╣║║╬║╔╣╬╠╣╩╣═╣╔╣─--
-- ╚╝╚═╩╝─╚═╩╝╚╝║╔╩╝╚╦╝╠═╩═╩═╝─--
-- ─────────────╚╝───╚═╝───────--
-- ───── By Mactavish ─────────--

McCD = {}
McCD.Cars = {}
McCD.Config = {}

McCD.Version = "0.0.1"

local function McCDLoad()

	MsgC( Color(0, 255, 0), "[McCD] Initialization started\n" )

	if SERVER then

		include("mc_cardealer/sh_config.lua")
		include("mc_cardealer/sh_cars.lua")
		include("mc_cardealer/sv_db.lua")
		include("mc_cardealer/sv_init.lua")
		AddCSLuaFile("mc_cardealer/sh_config.lua")
		AddCSLuaFile("mc_cardealer/sh_cars.lua")
		AddCSLuaFile("mc_cardealer/cl_util.lua")
		AddCSLuaFile("mc_cardealer/cl_init.lua")
	else
		include("mc_cardealer/sh_config.lua")
		include("mc_cardealer/sh_cars.lua")
		include("mc_cardealer/cl_util.lua")
		include("mc_cardealer/cl_init.lua")
	end

	MsgC( Color(0, 255, 0), "[McCD] Initialization done\n" )

end

if SERVER then
	hook.Add("PostGamemodeLoaded", "McCD.LoadSV", function() McCDLoad() end)
else
	hook.Add("InitPostEntity", "McCD.LoadCL", function() McCDLoad() end)
end

if GAMEMODE then
	McCDLoad()
end