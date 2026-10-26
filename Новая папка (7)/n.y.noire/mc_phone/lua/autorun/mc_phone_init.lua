--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/autorun/mc_phone_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- DO NOT EDIT ANYTHING HERE, UNLESS YOU KNOW WHAT YOU ARE DOING
McPhone = {}
McPhone.UserCfg = {}
McPhone.Config = {}
McPhone.Modules = {}
McPhone.WebModules = {}
McPhone.Language = {}
McPhone.Version = "1.2.0"
McPhone.ServerID = "mcphone_noire"

util.PrecacheModel("models/mactavish/mactavish_phone.mdl")

function McPhone.ModuleLoader()
	local files = file.Find("mc_phone/modules/*", "LUA")

	for k, v in pairs(files) do
		if McPhone.DisableModules and McPhone.DisableModules[v] then continue end

		if (SERVER) then
			include("mc_phone/modules/" .. v)
			AddCSLuaFile("mc_phone/modules/" .. v)
			MsgC(Color(0, 0, 255), "[McPhone] " .. v .. " module added\n")
		else
			include("mc_phone/modules/" .. v)
		end
	end
end

local function McPhoneLoad()
	MsgC(Color(0, 255, 0), "[McPhone] Initialization started\n")

	if not file.Exists(McPhone.ServerID, "DATA") then
		file.CreateDir(McPhone.ServerID)
		MsgC(Color(0, 255, 0), "[McPhone] Server DATA Dir created \n")
	end

	if SERVER then
		include("mc_phone/sh_config.lua")
		include("mc_phone/sh_language.lua")
		include("mc_phone/sh_init.lua")
		include("mc_phone/sv_init.lua")
		AddCSLuaFile("mc_phone/sh_config.lua")
		AddCSLuaFile("mc_phone/sh_language.lua")
		AddCSLuaFile("mc_phone/sh_init.lua")
		AddCSLuaFile("mc_phone/cl_hooks.lua")
		AddCSLuaFile("mc_phone/cl_init.lua")
		AddCSLuaFile("mc_phone/cl_util.lua")
		AddCSLuaFile("mc_phone/cl_config_manager.lua")
		local f = file.Find("mc_phone/extentions/*", "LUA")

		for k, v in pairs(f) do
			if string.StartWith(v, "sh_") then
				include("mc_phone/extentions/" .. v)
				AddCSLuaFile("mc_phone/extentions/" .. v)
			elseif string.StartWith(v, "sv_") then
				include("mc_phone/extentions/" .. v)
			elseif string.StartWith(v, "cl_") then
				AddCSLuaFile("mc_phone/extentions/" .. v)
			end
		end
	else
		include("mc_phone/sh_config.lua")
		include("mc_phone/sh_language.lua")
		include("mc_phone/sh_init.lua")
		include("mc_phone/cl_hooks.lua")
		include("mc_phone/cl_init.lua")
		include("mc_phone/cl_util.lua")
		include("mc_phone/cl_config_manager.lua")
		local f = file.Find("mc_phone/extentions/*", "LUA")

		for k, v in pairs(f) do
			if string.StartWith(v, "sh_") then
				include("mc_phone/extentions/" .. v)
			elseif string.StartWith(v, "cl_") then
				include("mc_phone/extentions/" .. v)
			end
		end
	end

	McPhone.ModuleLoader()
	MsgC(Color(0, 255, 0), "[McPhone] Initialization done\n")
end

if SERVER then
	McPhoneLoad()
else
	hook.Add("InitPostEntity", "McPhone.LoadCL", function()
		McPhoneLoad()
	end)
end

if GAMEMODE then
	McPhoneLoad()
end