--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/health/lua/autorun/mc_haes.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MES = {}

function MES.Load()
	if SERVER then
		include("mc_haes/sh_config.lua")
		AddCSLuaFile("mc_haes/sh_config.lua")
		local f = file.Find("mc_haes/core/*", "LUA")

		for _, v in ipairs(f) do
			if string.StartWith(v, "sh_") then
				include("mc_haes/core/" .. v)
				AddCSLuaFile("mc_haes/core/" .. v)
			elseif string.StartWith(v, "sv_") then
				include("mc_haes/core/" .. v)
			elseif string.StartWith(v, "cl_") then
				AddCSLuaFile("mc_haes/core/" .. v)
			end
		end

		f = file.Find("mc_haes/ui/*", "LUA")

		for _, v in ipairs(f) do
			AddCSLuaFile("mc_haes/ui/" .. v)
		end
	else
		include("mc_haes/sh_config.lua")
		local f = file.Find("mc_haes/core/*", "LUA")

		for _, v in ipairs(f) do
			if string.StartWith(v, "sh_") then
				include("mc_haes/core/" .. v)
			elseif string.StartWith(v, "cl_") then
				include("mc_haes/core/" .. v)
			end
		end

		f = file.Find("mc_haes/ui/*", "LUA")

		for _, v in ipairs(f) do
			include("mc_haes/ui/" .. v)
		end
	end
end

MES.Load()