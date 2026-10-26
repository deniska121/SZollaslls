-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\season_interns.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MCS.Spawns["season_intern1"] = {
	name = "Посетитель",
	model = "models/cityrp/pm/normal/male_09.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_2",
		[8] = "gbskins/outfit/pants_1",
		[4] = "gbskins/outfit/top_1",
		[3] = "models/gmodbest/citizens/facemaps/erdim_facemap6"
	},
	namepos = 80,
	noinfo = true,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "lineidle03",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Пожалуйста, не мешайте.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_interns/1.mp3",
			["Answers"] = {
				{"Простите.", "close",},
			},
		},
	}
}

MCS.Spawns["season_intern2"] = {
	name = "Посетитель",
	model = "models/cityrp/pm/normal/male_07.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_3",
		[8] = "gbskins/outfit/pants_14",
		[4] = "gbskins/outfit/top_14"
	},
	namepos = 80,
	theme = "Default",
	noinfo = true,
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "lineidle03",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Не беспокойте меня, я очень занят.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_interns/2.mp3",
			["Answers"] = {
				{"Простите.", "close",},
			},
		},
	}
}