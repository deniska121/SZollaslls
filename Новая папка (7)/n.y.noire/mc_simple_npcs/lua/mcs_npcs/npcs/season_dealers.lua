--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/season_dealers.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["season_dealer1"] = {
	name = "Дилер",
	model = "models/cityrp/pm/normal/male_04.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_24",
		[8] = "gbskins/outfit/pants_24",
		[4] = "gbskins/outfit/top_24",
		[2] = "models/gmodbest/citizens/facemaps/eric_facemap21"
	},
	namepos = 80,
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
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[2] = {
			["Line"] = [[Эй! Джо Бабуз?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer1/2.mp3",
			["Answers"] = {
				{"Да!", 3,},
				{"Его партнёр!", 3,},
			},
		},
		[3] = {
			["Line"] = [[Сейчас пойдут ящики! Приятного бизнеса!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer1/3.mp3",
			["Answers"] = {
				{"Взаимно!", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["season_dealer2"] = {
	name = "Дилер",
	model = "models/cityrp/pm/normal/male_07.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_24",
		[8] = "gbskins/outfit/pants_24",
		[4] = "gbskins/outfit/top_22",
		[2] = "models/gmodbest/citizens/facemaps/mike_facemap15"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "crouchidle_panicked4",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[2] = {
			["Line"] = [[Джо Бабуз?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer2/2.mp3",
			["Answers"] = {
				{"Да.", 3,},
				{"Его партнёр.", 3,},
				{"Кто спрашивает?", 4,},
			},
		},
		[3] = {
			["Line"] = [[Мой партнёр сейчас передаст ящики. В них пушки, как и договаривались.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer2/3.mp3",
			["Answers"] = {
				{"Окей.", "MQS Continue quest",},
				{"Отлично.", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
			},
		},
		[4] = {
			["Line"] = [[Блять, обижаешь! Мы на копов похожи или чё? Это мы должны бояться, у нас в багаже пушки а не у тебя.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer2/4.mp3",
			["Answers"] = {
				{"Точно. Простите.", 3,},
				{"Тогда давайте это исправим.", 3,},
				{"Успокойтесь, я от Джо. Давайте сделаем это.", 3,},
			},
		},
	}
}

MCS.Spawns["season_dealer3"] = {
	name = "Дилер",
	model = "models/cityrp/pm/normal/male_09.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_24",
		[8] = "gbskins/outfit/pants_54",
		[4] = "gbskins/outfit/top_52",
		[3] = "models/gmodbest/citizens/facemaps/erdim_facemap5"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "idle_angry",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Эй! Товар ждёшь?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer3/1.mp3",
			["Answers"] = {
				{"Да!", 2,},
				{"А вы кто?", 4,},
				{"Нет! Какой товар?", 7,},
			},
		},
		[2] = {
			["Line"] = [[Деньги на месте?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer3/2.mp3",
			["Answers"] = {
				{"Так вам же уже заплатили!", 3,},
				{"А оружие?", 3,},
				{"..До свидания!", 3,},
			},
		},
		[3] = {
			["Line"] = [[Руки вверх! Береговая охрана США!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer3/3.mp3",
			["Answers"] = {
				{"Ах вы суки!", "MQS Continue quest",},
				{"Только не они..", "MQS Continue quest",},
				{"Не дождётесь!", "MQS Continue quest",},
			},
		},
		[4] = {
			["Line"] = [[Мы торгуем!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer3/4.mp3",
			["Answers"] = {
				{"Чем?", 5,},
				{"Покупаю!", 3,},
				{"Меня не интересует!", 6,},
			},
		},
		[5] = {
			["Line"] = [[Ты покупаешь или нет?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer3/5.mp3",
			["Answers"] = {
				{"Покупаю!", 3,},
				{"Нет!", 6,},
			},
		},
		[6] = {
			["Line"] = [[Тогда уплывайте отсюда! Здесь пресекается нелегальная деятельность!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer3/6.mp3",
			["Answers"] = {
				{
					"...", {
						id = "MQS Skip to",
						data = {
							id = 61,
							quest_id = "season1_criminal_5"
						}
					},
				},
				{
					"Спасибо за вашу бдительность!", {
						id = "MQS Skip to",
						data = {
							id = 61,
							quest_id = "season1_criminal_5"
						}
					},
				},
				{
					"Уже уплываю!", {
						id = "MQS Skip to",
						data = {
							id = 61,
							quest_id = "season1_criminal_5"
						}
					},
				}
			},
		},
		[7] = {
			["Line"] = [[Точно? Мы торгуем!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_dealer3/7.mp3",
			["Answers"] = {
				{"Чем?", 5,},
				{"Тогда покупаю!", 3,},
				{"Меня не интересует!", 6,},
			},
		},
	}
}