-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\season_luiz.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MCS.Spawns["season_luiz"] = {
	name = "Фредди Луиз",
	model = "models/cityrp/pm/normal/male_09.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_18",
		[8] = "gbskins/outfit/pants_36",
		[4] = "gbskins/outfit/top_36",
		[3] = "models/gmodbest/citizens/facemaps/erdim_facemap16"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "d1_t01_trainride_sit_idle",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	-- voice - PAUL
	dialogs = {
		[1] = {
			["Line"] = [[Вы не врач. Мне нужен врач, настоящий врач.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/1.mp3",
			["Answers"] = {
				{"Простите.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Вы не врач. Мне нужен врач, настоящий врач.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/1.mp3",
			["Answers"] = {
				{"Я интерн. Я будущий врач.", 3,},
				{"Простите.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Я и говорю - пока не врач, если только от слова 'врать'. Вы мне не поможете.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/3.mp3",
			["Answers"] = {
				{"Обязательно помогу.", 4,},
				{"Мы можем попробовать.", 4,},
				{"Как скажете.", 4,},
			},
		},
		[4] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"Как самочувствие?", 5,},
				{"На что жалуетесь?", 5,},
				{"Почему вы трясётесь?", 5,},
				{"Что с тобой не так?", 14,},
			},
		},
		[5] = {
			["Line"] = [[Болит.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/5.mp3",
			["Answers"] = {
				{"Что?", 6,},
				{"Где?", 6,},
				{"Понимаю.", 6,},
			},
		},
		[6] = {
			["Line"] = [[Вы не поймёте. Тело стреляет везде абсолютно; по-разному.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/6.mp3",
			["Answers"] = {
				{"Как это происходит?", 7,},
				{"Где боль сильнее всего?", 7,},
				{"Вы выдумываете.", 9,},
			},
		},
		[7] = {
			["Line"] = [[По всему телу. Как только обращаю внимание на участок тела - начинаются неприятные ощущения.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/7.mp3",
			["Answers"] = {
				{"А если вы не стимулируете ощущения?", 8,},
				{"Поэтому вы трясётесь?", 8,},
				{"Вы выдумываете.", 9,},
			},
		},
		[8] = {
			["Line"] = [[Не могу иначе. Не могу не думать.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/8.mp3",
			["Answers"] = {
				{"Давайте поговорим о чём-нибудь. Отвлечём мысли.", 9,},
				{"Есть одно средство..", 9,},
				{"Вы выдумываете.", 9,},
			},
		},
		[9] = {
			["Line"] = [[Говорил же - вы мне не поможете.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/9.mp3",
			["Answers"] = {
				{"Есть один препарат - он способен помочь. Давайте просто попробуем!", 10,},
				{"Вы не даёте мне помочь.", 12,},
				{"Вы симулянт. Обманщик.", 13,},
				{"Простите. Давайте попробуем ещё раз?", 11,},
			},
		},
		[10] = {
			["Line"] = [[Что мне только ни давали - ничего не помогало.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/10.mp3",
			["Answers"] = {
				{"Этот точно поможет.", 11,},
				{"Тогда почему вы обращаетесь к врачам?", 12,},
				{"Вы даже не попробовали.", 11,},
			},
		},
		[11] = {
			["Line"] = [[Не надо.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/11.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Я сейчас..", "MQS Continue quest",},
			},
		},
		[12] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"Вот-вот.", "MQS Continue quest",},
				{"Я сейчас..", "MQS Continue quest",},
			},
		},
		[13] = {
			["Line"] = [[Я не обманываю! Это вы обманываете! Вы не можете мне помочь!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/13.mp3",
			["Answers"] = {
				{"Как скажете.", "MQS Continue quest",},
				{"Я сейчас..", "MQS Continue quest",},
			},
		},
		[14] = {
			["Line"] = [[Со мной всё так. Это с вами что-то не так, раз вы таким тоном с больным разговариваете.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_luiz/14.mp3",
			["Answers"] = {
				{"Тогда почему вы трясётесь?", 5,},
				{"Тогда почему вы обращаетесь к врачам?", 5,},
			},
		},
	}
}