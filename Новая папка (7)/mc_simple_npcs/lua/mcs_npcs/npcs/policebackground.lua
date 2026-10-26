-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\policebackground.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
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