--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/policebackground.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["chapter2_cop1"] = {
	name = "Офицер полиции",
	model = "models/cityrp/pm/nypd/male_07.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	pos = {},
	questNPC = false,
	sequence = "lineidle03",
	uselimit = false,
	skin = 1,
	bgr = {
		[1] = 1,
		[2] = 2,
		[3] = 0,
		[4] = 0,
		[5] = 1,
	},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Покиньте место преступления.]],
			["Sound"] = "",
			["Answers"] = {
				{"Хорошо.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Стоять! Полиция Нью-Йорка!]],
			["Sound"] = "",
			["Answers"] = {
				{"Сдаюсь!", "JailPlayer",},
				{
					"Чёрт, нет!", {
						id = "MQS Skip to",
						data = {
							id = 17,
							quest_id = "chapter2_criminal_1"
						}
					}
				}
			},
			[3] = {
				["Line"] = [[Полиция Нью-Йорка! Всем стоять на своих местах!]],
				["Sound"] = "",
				["Answers"] = {
					{"Сдаюсь!", "JailPlayer",},
					{
						"Только не это..", {
							id = "MQS Skip to",
							data = {
								id = 17,
								quest_id = "chapter2_criminal_1"
							}
						},
					},
				},
			}
		}
	}
}

MCS.Spawns["chapter2_cop2"] = {
	name = "Офицер полиции",
	model = "models/cityrp/pm/nypd/male_04.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	pos = {},
	questNPC = false,
	sequence = "lineidle02",
	uselimit = false,
	skin = 1,
	bgr = {
		[1] = 1,
		[2] = 2,
		[3] = 0,
		[4] = 0,
		[5] = 1,
	},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Покиньте место преступления.]],
			["Sound"] = "",
			["Answers"] = {
				{"Хорошо.", "close",},
			},
		},
	}
}