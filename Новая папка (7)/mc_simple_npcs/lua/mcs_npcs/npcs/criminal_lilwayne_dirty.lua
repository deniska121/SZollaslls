-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\criminal_lilwayne_dirty.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MCS.Spawns["criminal_lilwayne_dirty"] = {
	name = "Лил Вэйн",
	model = "models/cityrp/pm/normal/male_01.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = true,
	submat = {
		[4] = "gbskins/outfit/top_36"
	},
	pos = {},
	sequence = "plazaidle4",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Какая боль..]],
			["Sound"] = "https://macnco.one/gmod/vo/wayne/dirty/1.mp3",
			["Answers"] = {
				{"Что случилось?", 2,},
				{"Прости. Я не смогу тебе помочь.", "close",},
				{"...", "close",},
			},
		},
		[2] = {
			["Line"] = [[Ног.. не чувствую.]],
			["Sound"] = "https://macnco.one/gmod/vo/wayne/dirty/2.mp3",
			["Answers"] = {
				{"Почему никто ничего не делает?", 3,},
				{"Прости. Я не смогу тебе помочь.", "close",},
				{"...", "close",},
			},
		},
		[3] = {
			["Line"] = [[Мир такой.]],
			["Sound"] = "https://macnco.one/gmod/vo/wayne/dirty/3.mp3",
			["Answers"] = {
				{"Прости. Я не смогу тебе помочь.", 4,},
				{"...", "close",},
			},
		},
		[4] = {
			["Line"] = [[Я о том же.]],
			["Sound"] = "https://macnco.one/gmod/vo/wayne/dirty/4.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
	}
}