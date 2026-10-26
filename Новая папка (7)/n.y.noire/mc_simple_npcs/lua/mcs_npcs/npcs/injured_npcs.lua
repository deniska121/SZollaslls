--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/injured_npcs.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["civilian_injured_sit"] = {
	name = "Раненый подозреваемый",
	model = "models/humans/group01/male_01.mdl",
	namepos = 80,
	submat = {
		[3] = "gbskins/male/sheet_22"
	},
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "injured1",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {
	},
}

MCS.Spawns["civilian_injured_lie"] = {
	name = "Раненый гражданский",
	model = "models/humans/group02/female_03.mdl",
	submat = {
		[0] = "gbskins/female/sheet_12"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "d1_town05_wounded_idle_1",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {
	},
}

MCS.Spawns["civilian_injured_dead"] = {
	name = "Убитый подозреваемый",
	model = "models/humans/group01/male_04.mdl",
	submat = {
		[4] = "gbskins/male/sheet_35"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "arrestpreidle",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {
	},
}