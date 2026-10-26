--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_quests/lua/mqs/ui/user_panel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function MQS.OpenPlayerMenu()
end

MQS.EvenCategorys = {
	["Spawn"] = MSD.Icons48.box_open,
	["Remove"] = MSD.Icons48.cross,
	["Player"] = MSD.Icons48.account,
	["Quest"] = MSD.Icons48.cog,
	["Sounds"] = MSD.Icons48.music_circle,
	["Map"] = MSD.Icons48.compass_rose,
	["Server"] = MSD.Icons48.console,
	["Other"] = MSD.Icons48.exit_to_app,
}

MQS.EvenCategory = {
	["Spawn quest entity"] = "Spawn",
	["Spawn entity"] = "Spawn",
	["Passanger spawn random"] = "Spawn",
	["Spawn vehicle"] = "Spawn",
	["[MCS] Spawn npc"] = "Spawn",
	["Spawn quest entity"] = "Spawn",
	["Spawn entity"] = "Spawn",
	["Spawn npc"] = "Spawn",
	["Passanger spawn"] = "Spawn",
	["Remove entites by ID"] = "Remove",
	["Remove all entites"] = "Remove",
	["Remove vehicle"] = "Remove",
	["Passanger delete"] = "Remove",
	["Passanger delete random"] = "Remove",
	["Track player"] = "Player",
	["Teleport player"] = "Player",
	["Check Player HP"] = "Player",
	["Give ammo"] = "Player",
	["Set Armor"] = "Player",
	["Set HP"] = "Player",
	["Set spawn point"] = "Player",
	["DarkRP Wanted"] = "Player",
	["Give weapon"] = "Player",
	["Give quest item"] = "Player",
	["Restore All Weapons"] = "Player",
	["End track player"] = "Player",
	["Give Inv"] = "Player",
	["Strip Weapon"] = "Player",
	["Strip All FireArms"] = "Player",
	["Strip All Weapons"] = "Player",
	["Set Job Name"] = "Player",
	["Manage do time"] = "Quest",
	["Cinematic camera"] = "Quest",
	["Music player"] = "Sounds",
	["Emit sound"] = "Sounds",
	["Player emit sound"] = "Sounds",
	["Music player pos"] = "Sounds",
	["Ent Fire"] = "Map",
	["Ent Fire CID"] = "Map",
	["Load Scene"] = "Map",
	["Unload Scene"] = "Map",
	["Run Console Command"] = "Server",
}