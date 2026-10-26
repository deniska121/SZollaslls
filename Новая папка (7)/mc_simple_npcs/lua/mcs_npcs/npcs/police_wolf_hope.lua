-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\police_wolf_hope.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MCS.Spawns["police_wolf_hope"] = {
	name = "Арианна Вульф",
	desc = "Детектив",
	n_icon = Material("ranks_ui/icons/nypd/dt1.png", "smooth"),
	model = "models/cityrp/pm/nypd/female_01.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = true,
	pos = {},
	sequence = "d2_coast03_postbattle_idle02",
	uselimit = false,
	skin = 1,
	bgr = {[2] = 1,[5] = 1,},
	ClModels = {
		{ model = "models/cityrp/nypd/badge_dt1.mdl", pos = Vector(3,-1.9,7.25), ang = Angle(0,150,60), bone = 4},
	},
	dialogs = {
		[1] = {
			["Line"] = [[Идёт.. расследование! Покиньте место пр- ..еступления!]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/1.mp3",
			["Answers"] = {
				{"Я вызову скорую.", 2,},
				{"...", "close",},
				{"Так вам свиньям и надо!", "close",},
				{"Надо просто притвориться, что тут ничего нет.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Не надо. Мой напарник в пути. У-уходите!]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/2.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[3] = {
			["Line"] = [[..Ты здесь! Я знала!]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/3.mp3",
			["Answers"] = {
				{"Что тут произошло?", 4,},
				{"Не двигайся, не говори, не напрягайся!", 5,},
				{"Ты чего тут кровью истекаешь?", 6,},
				{"Этот пиздец - результат твоих ребусов!", 5,},
			},
		},
		[4] = {
			["Line"] = [[Оглянись. Вызови скорую!]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/4.mp3",
			["Answers"] = {
				{"Не умирай!", "MQS Continue quest",},
				{"Держись.", "MQS Continue quest",},
				{"Только попробуй умереть.", "MQS Continue quest",},
				{"А как же первая помощь?", 7,},
			},
		},
		[5] = {
			["Line"] = [[Скорую вызови!]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/5.mp3",
			["Answers"] = {
				{"Не умирай!", "MQS Continue quest",},
				{"Держись.", "MQS Continue quest",},
				{"Только попробуй умереть.", "MQS Continue quest",},
				{"А как же первая помощь?", 7,},
			},
		},
		[6] = {
			["Line"] = [[Не смешно! Скорую!]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/6.mp3",
			["Answers"] = {
				{"Не умирай!", "MQS Continue quest",},
				{"Держись.", "MQS Continue quest",},
				{"Только попробуй умереть.", "MQS Continue quest",},
				{"А как же первая помощь?", 7,},
			},
		},
		[7] = {
			["Line"] = [[У меня артерия.. шина.. Звонок для гражданских.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/7.mp3",
			["Answers"] = {
				{"Не умирай!", "MQS Continue quest",},
				{"Держись.", "MQS Continue quest",},
				{"Только попробуй умереть.", "MQS Continue quest",},
			},
		},
		[8] = {
			["Line"] = [[Через.. сколько?]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/8.mp3",
			["Answers"] = {
				{"Не знаю, скоро.", 9,},
				{"Не знаю, скоро. Ты как?", 10,},
				{"Не знаю, скоро. Тебе срочно нужна помощь!", 11,},
			},
		},
		[9] = {
			["Line"] = [[Хорошо. Ну и угораздило..]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/9.mp3",
			["Answers"] = {
				{"Ты бледнеешь.", "MQS Continue quest",},
			},
		},
		[10] = {
			["Line"] = [[Паршиво. Рук не чувствую..]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/10.mp3",
			["Answers"] = {
				{"Ты бледнеешь.", "MQS Continue quest",},
			},
		},
		[11] = {
			["Line"] = [[Не то слово..]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/11.mp3",
			["Answers"] = {
				{"Ты бледнеешь.", "MQS Continue quest",},
			},
		},
		[12] = {
			["Line"] = [[..Спасибо.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/12.mp3",
			["Answers"] = {
				{"Ты главное не умирай. Не закрывай глаза. Ты сможешь!", 13,},
				{"Давай. Держись.", 14,},
				{"Что должно быть в голове, чтобы рейд целого клуба в одиночку показался хорошей затеей?", 15,},
			},
		},
		[13] = {
			["Line"] = [[Это так глупо звучит.. и-и очень мило одновременно.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/13.mp3",
			["Answers"] = {
				{"...", 16,},
			},
		},
		[14] = {
			["Line"] = [[А как же утеши- ..тельные.. разговоры?]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/14.mp3",
			["Answers"] = {
				{"...", 16,},
			},
		},
		[15] = {
			["Line"] = [[Мой мозг. И моя глупость..]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/15.mp3",
			["Answers"] = {
				{"...", 16,},
			},
		},
		[16] = {
			["Line"] = [[Знаешь, почему в этом городе.. люди такие болтливые?]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/16.mp3",
			["Answers"] = {
				{"Нет.", 17,},
				{"Догадываюсь.", 17,},
			},
		},
		[17] = {
			["Line"] = [[..Потому что в мире происходит такой.. пиздец, что эскапизм - единственное решение. Каждый хочет разговориться. Каждый хочет отвлечься. А потом.. получается, как сейчас. И люди перестают говорить. Иногда - насовсем.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/17.mp3",
			["Answers"] = {
				{"Ты хочешь поговорить?", 18,},
				{"Ты имеешь в виду сломанность психики и смерть?", 19,},
				{"Мне это не интересно. Из-за тебя из нормы унесло четыре жизни.", 20,},
				{"Что ты тут вообще делала?", 21,},
			},
		},
		[18] = {
			["Line"] = [[Хочу. Но сил нет. Даже сесть не могу.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/18.mp3",
			["Answers"] = {
				{"Ты молодец, ты справилась. Пора отдыхать.", "MQS Continue quest",},
				{"Ты сделала всё, что могла. Отдохни.", "MQS Continue quest",},
				{"Тебе повезло. Отдыхай.", "MQS Continue quest",},
			},
		},
		[19] = {
			["Line"] = [[Да. Я бы.. пофилософ- ..нет сил. Даже чтобы сесть.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/19.mp3",
			["Answers"] = {
				{"Ты молодец, ты справилась. Пора отдыхать.", "MQS Continue quest",},
				{"Ты сделала всё, что могла. Отдохни.", "MQS Continue quest",},
				{"Тебе повезло. Отдыхай.", "MQS Continue quest",},
			},
		},
		[20] = {
			["Line"] = [[..Тебя даже не беспокоит это.. дело, да? Лишь бы звёзд побольше на погонах! Ты так к каждому.. напарнику относишься? Только физические потери считаешь? Странно, как вы.. с Хогстоном не поладили.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/20.mp3",
			["Answers"] = {
				{"Ты права. Прости. Лучше отдохни.", "MQS Continue quest",},
				{"Ты права. Ты делала всё, что могла. Пора отдыхать.", "MQS Continue quest",},
				{"Тебе просто повезло. Отдыхай.", "MQS Continue quest",},
			},
		},
		[21] = {
			["Line"] = [[Следовала.. за наводкой. На 'Прилизанного'. Тайник. Какому-то чёрному не понрав- ..моя внешность. Я не начинала этого! ..Ловушка.]],
			["Sound"] = "https://macnco.one/gmod/vo/wolf/hope/21.mp3",
			["Answers"] = {
				{"Ты молодец, ты справилась. Пора отдыхать.", "MQS Continue quest",},
				{"Ты сделала всё, что могла. Отдохни.", "MQS Continue quest",},
				{"Тебе повезло. Отдыхай.", "MQS Continue quest",},
			},
		},
	}
}