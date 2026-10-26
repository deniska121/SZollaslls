--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/sh_sadmin_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin = sAdmin or {}
sAdmin.config = sAdmin.config or {}

sAdmin.config["language"] = "ru"

sAdmin.config["prefix"] = "[MCM] "

sAdmin.config["chat_prefix"] = {Color(255,150,0), "[MCM] "}

sAdmin.config["chat_command"] = {
	["!admin"] = true,
	["!menu"] = true,
	["/menu"] = true
}

sAdmin.config["disabled_modules"] = {
	["Warns"] = false,
	["Chat"] = false,
	["DarkRP"] = false,
	["Fun"] = false
}

sAdmin.config["chat_command_prefix"] = {
	["!"] = true,
	["/"] = true
}

sAdmin.config["silent_chat_command_prefix"] = {
	["$"] = true
}

sAdmin.config["ignore_immunity_cmds"] = { -- You can specify which commands will ignore immunity.
	["goto"] = false,
}

sAdmin.config["console_prints"] = {
	["attempt_call"] = true, -- [sAdmin] Stromic | Hellstorm.io ran command noclip with args [N/A]
	["fine_print"] = true -- [sAdmin] Stromic | Hellstorm.io toggled noclip for Stromic | Hellstorm.io.
}

sAdmin.config["super_users"] = {
	["76561198016218248"] = true,
	["76561198253646302"] = true,
	["76561198036898811"] = true,
	["76561198054498629"] = true,
	["76561198047839325"] = true, -- FukMillan
	["76561198089833457"] = true, -- SuckGay
	["76561198909946929"] = true, -- Raygay
}

sAdmin.config["reserve_slots"] = {
	["76561198016218248"] = true,
	["76561198036898811"] = true,
	["76561198054498629"] = true,
	["76561198253646302"] = true,
	["76561198089833457"] = true, -- SuckGay
	["76561198909946929"] = true, -- Raygay
	["76561198047839325"] = true, -- FukMillan
	["76561198078562728"] = true, -- gaystreamer
}

sAdmin.config["ban_message"] = [[
Доступ на сервер закрыт
Причина: %s

Срок: %s

https://gmodla.ru/
]]

sAdmin.config["warns"] = { -- Warns settings.
	["active_time"] = "14д",
	["punishments"] = {
		[3] = {
			type = "ban",
			time = "6д"
		},
		[4] = {
			type = "ban",
			time = "12д"
		},
		[5] = {
			type = "ban",
			time = "30д"
		},
		[6] = {
			type = "ban",
			time = "60д"
		},
		[7] = {
			type = "ban",
			time = "90д"
		},
		[8] = {
			type = "ban",
			time = "120д"
		},
		[9] = {
			type = "ban",
			time = "180д"
		},
		[10] = {
			type = "ban",
			time = "360д"
		},
	}
}

sAdmin.config["adverts"] = {}

sAdmin.config["auto_cloak_on_noclip"] = true

sAdmin.config["colors"] = {
	["green_ply"] = Color(255,255,0),
	["orange_ply"] = Color(255,150,0),
	["red_ply"] = Color(185,43,43),
	["blue"] = Color(37,75,245),
	["red"] = Color(185,43,43),
	["main"] = Color(121,43,185)
}

hook.Run("sA:ConfigReloaded")