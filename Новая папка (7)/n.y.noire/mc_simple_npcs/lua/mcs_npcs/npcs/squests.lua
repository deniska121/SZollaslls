--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/squests.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["food1"] = {
	name = "Клиент",
	model = "models/Humans/Group02/male_02.mdl",
	randompm = true,
	namepos = 70,
	theme = "Default",
	scale = 1,
	questNPC = true,
	pos = {},
	get_pos = {
		{Vector(1649.8782958984, 2832.03125, 696.03125), Angle(0, 94, 0)},
		{Vector(-982.21527099609, 4986.3173828125, 920.03125), Angle(0, 76, 0)},
		{Vector(-1358.96875, 5200.03125, 1760.03125), Angle(0, 19, 0)},
		{Vector(-1546.4542236328, -144.03125, -103.96875), Angle(0, -86, 0)},
		{Vector(1615.96875, 4849.8608398438, 392.03125), Angle(0, 152, 0)},
		{Vector(1209.6955566406, 2822.3481445313, -95.96875), Angle(0, 11, 0)},
		{Vector(1631.96875, 4912.03125, 56.03125), Angle(0, 156, 0)},
		{Vector(-1048.03125, 10974.594726563, 128.03125), Angle(0, 175, 0)},
		{Vector(-8367.96875, 2750.3774414063, 3.4699058532715), Angle(0, 1, 0)},
		{Vector(-3632.8215332031, 5520.03125, 48.03125), Angle(0, 84, 0)},
		{Vector(-1056.03125, 1557.0360107422, -103.96875), Angle(0, -173, 0)},
		{Vector(6779.9912109375, 1744.03125, -95.96875), Angle(0, 82, 0)},
		{Vector(2775.0532226563, 6724.7529296875, 12.712615966797), Angle(0, -139, 0)},
		{Vector(-2664.9060058594, 10912.032226563, 128.03125), Angle(0, 88, 0)},
		{Vector(37.576522827148, 8175.96875, 128.03125), Angle(0, -26, 0)},
		{Vector(3856.03125, 3312.03125, -55.96875), Angle(0, 75, 0)},
		{Vector(2608.1235351563, 3624.96875, -55.968753814697), Angle(0, 0, 0)},
		{Vector(3439.96875, -196.58088684082, -103.96875), Angle(0, -156, 0)},
		{Vector(-943.96875, 5440.03125, 360.03125), Angle(0, 42, 0)},
	},
	sequence = {"idle_all_01", "pose_standing_01", "pose_standing_02"},
	uselimit = true,
	skin = 1,
	bgr = {},
	quest_random = {2, 3, 6, 8, 9, 10, 12, 13, 18, 21, 24, 26, 27, 30, 32},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Ты не курьер. Отойди, не мешай.]],
			["Sound"] = "",
			["Answers"] = {
				{"Прошу прощения.", "close",},
			}
		},
		[2] = {
			["Line"] = [[Ну наконец-то! ..Ну, чего стоишь? Отдавай заказ.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Держи.", "MQS Continue quest",},
				{"Держите. Удачи.", "MQS Continue quest",},
				{"Вот. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[3] = {
			["Line"] = [[О, курьер! Это вы для заказ меня несёте. Всё так быстро и качественно, как обычно! Если бы не вы, то весь мир бы уже умер с голоду вперемешку с ленью..]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 4,},
				{"Да-да-да. Вот заказ.", 5,},
				{"Простите, мне нужно спешить. Вот ваш заказ.", "MQS Continue quest",},
			},
		},
		[4] = {
			["Line"] = [[..Знали бы вы, что про вас говорят.. Хотя, наверное, знаете - хамов бесконечно много, особенно в этом городе; не удивлюсь если кто-то в лицо вам скажет то, что обычно за спинами болтают..]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 5,},
				{"Да-да-да. Вот заказ.", 5,},
				{"Простите, мне нужно спешить. Вот ваш заказ.", "MQS Continue quest",},
			},
		},
		[5] = {
			["Line"] = [[..Вы вообще слушаете? Как грубо! Да как вы смеете! Я буду жаловаться!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"У меня нет времени болтать.", "MQS Continue quest",},
				{"Извините, у меня нет времени разговаривать.", "MQS Continue quest",},
			},
		},
		[6] = {
			["Line"] = [[Привет.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Заказ.", 7,},
				{"Привет, вот заказ.", 7,},
				{"Здравствуйте, вот ваш заказ.", 7,},
			},
		},
		[7] = {
			["Line"] = [[Круто. Респект. Спасибо.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Удачи.", "MQS Continue quest",},
				{"Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[8] = {
			["Line"] = [[О, как раз вовремя! Спасибо!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Держи.", "MQS Continue quest",},
				{"Держите. Удачи.", "MQS Continue quest",},
				{"Вот. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[9] = {
			["Line"] = [[..Вот и вы. Давайте побыстрее, у меня неотложные дела.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Держи.", "MQS Continue quest",},
				{"Держите. Удачи.", "MQS Continue quest",},
				{"Держите. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[10] = {
			["Line"] = [[Еда! ..Ща сдохну.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Держи.", "MQS Continue quest",},
				{"Держите.", "MQS Continue quest",},
				{"Вам скорую вызвать?", 11,},
			},
		},
		[11] = {
			["Line"] = [[Не, спасибо. Просто жрать очень хочется. Спасибо за беспокойство кстати - напишу об этом в отзыве.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Окей. Удачи.", "MQS Continue quest",},
				{"Тогда приятного аппетита!", "MQS Continue quest",},
			},
		},
		[12] = {
			["Line"] = [[Йоу. Курьер?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Да.", 7,},
				{"Да. Ваш заказ.", 7,},
				{"Да. Вот ваш заказ. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[13] = {
			["Line"] = [[Чё смотришь?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 14,},
				{"Не груби", 15,},
				{"Ваш заказ.", 14,},
				{"Здравствуйте. Вот ваш заказ.", 14,},
			},
		},
		[14] = {
			["Line"] = [[..А, ёпт, курьер. Давай сюда.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Подавись.", "MQS Continue quest",},
				{"Держи.", "MQS Continue quest",},
				{"Держите. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[15] = {
			["Line"] = [[А то чё?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 16,},
				{"А то буду разговаривать на языке кулаков.", 16,},
				{"Посмотри на себя. Вот такой пример ты подаёшь остальным? Видели бы тебя дети..", 17,},
				{"Ничего. Ваш заказ.", "MQS Continue quest",},
			},
		},
		[16] = {
			["Line"] = [[Мелочь пузатая. Молоко с губ ещё не высохло чтоб так базарить. Давай сюда жраку!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Вот.", "MQS Continue quest",},
				{"Подавись.", "MQS Continue quest",},
				{"Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[17] = {
			["Line"] = [[..Лан, извиняюсь, чёт меня не туда понесло.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Вот заказ.", "MQS Continue quest",},
				{"Подавись.", "MQS Continue quest",},
				{"Приятного аппетита.", "MQS Continue quest",},
			},
		},
		[18] = {
			["Line"] = [[Здаров. Это у тебя мой заказ?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 19,},
				{"Да.", 19,},
				{"Ваш заказ у меня. Держите.", 19,},
				{"Здравствуйте. Вот ваш заказ.", 19,},
			},
		},
		[19] = {
			["Line"] = [[..Точно, да, отлично. Спасибо.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"А на чай?", 20,},
				{"Удачи.", "MQS Continue quest",},
				{"Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[20] = {
			["Line"] = [[..Блин, у меня ща на чай нету. Точно, давай я те рейтинг подниму, хоть к премии поближе будешь.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Не стоит.", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
				{"Спасибо. Удачи!", "MQS Continue quest",},
			},
		},
		[21] = {
			["Line"] = [[Здравствуйте! Позвольте великодушно спросить: не у вас ли, прекрасного посланца, случаем поручение доставить бандероль с яствами, не менее прилежному и уважаемому человеку?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 22,},
				{"Чего-чего?", 22,},
				{"Вот ваш заказ.", "MQS Continue quest",},
				{"У меня. Вот ваш заказ. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[22] = {
			["Line"] = [[..Говорю, кушанье у тебя?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Да. Форму не видишь?", "MQS Continue quest",},
				{"Да, прошу прощения. Вас сразу не понять как-то.", "MQS Continue quest",},
				{"Да, прошу прощения. Далеко не каждый говорит таким высоким языком; непривычно.", 23,},
			},
		},
		[23] = {
			["Line"] = [[Отнюдь. Оставьте свою лесть. С таким подходом, вы никогда не поймёте что такое совершенство! Лучше бы вы увлеклись поэзией, дабы понять такую непонятую душёнку, как я..]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Как скажешь.", "MQS Continue quest",},
				{"Поэзия - синоним графомании.", "MQS Continue quest",},
				{"Спасибо за совет. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[24] = {
			["Line"] = [[Здравствуй. Спасибо за скорую доставку. Киффлом!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Держите.", "MQS Continue quest",},
				{"Киффлом?", 25,},
				{"Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[25] = {
			["Line"] = [[О, да, конечно, именно! ..Боюсь, я не смогу рассказать больше, Брат-Сестра. Однако, я передам другим Сёстрам-Братьям о твоей заинтересованности! Быть может, тебя достигнет осознание в будущем! Иди же - не сходи со своей тропы! Все дороги ведут к Киффлом!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"..Окей?", "MQS Continue quest",},
				{"Киффлом!", "MQS Continue quest",},
				{"Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[26] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Ваш заказ.", "MQS Continue quest",},
				{"Здравствуйте, ваш заказ.", "MQS Continue quest",},
				{"Здравствуйте, ваш заказ. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[27] = {
			["Line"] = [[Здравствуй. Ты доставщик?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 28,},
				{"Да.", 28,},
				{"Да. Вот ваш заказ.", 29,},
				{"Да. Вот ваш заказ. Приятного аппетита!", 29,},
			},
		},
		[28] = {
			["Line"] = [[Всё хорошо, не надо ничего говорить. Вижу твою усталость. Возьми перерыв после этого заказа - ты этого заслуживаешь.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Не указывай мне.", "MQS Continue quest",},
				{"Наверное, стоит.", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
			},
		},
		[29] = {
			["Line"] = [[Надеюсь, ты это не на автомате говоришь и искренне имеешь в виду? Я понимаю, каково это, когда тебя пытаются смешать с помоями. Купи себе чего-нибудь вкусного, ты этого заслуживаешь. Не теряй надежды.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Не указывай мне.", "MQS Continue quest",},
				{"Наверное, стоит.", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
			},
		},
		[30] = {
			["Line"] = [[..Мне уже казалось я не дождусь хавки. Чего так долго?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Не груби.", "MQS Continue quest",},
				{"В этом городе успеть - чудо.", 31,},
				{"Так получилось, прошу прощения. Вот ваш заказ.", "MQS Continue quest",},
			},
		},
		[31] = {
			["Line"] = [[Ну-ну, оправдывайся. По глазам вижу, что ты просто завидуешь моей возможности еду заказать.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Не груби.", "MQS Continue quest",},
				{"Как скажешь. Держи.", "MQS Continue quest",},
				{"Вовсе нет. Приятного аппетита!", "MQS Continue quest",},
			},
		},
		[32] = {
			["Line"] = [[..Ты ведь даже не понимаешь, что всё это не настоящее, да?]],
			["Sound"] = "",
			["Answers"] = {
				{"...", 33,},
				{"Ты о чём?", 33,},
				{"Я спешу. Ваш заказ.", "MQS Continue quest",},
				{"..Приятного аппетита, всего вам хорошего!", "MQS Continue quest",},
			},
		},
		[33] = {
			["Line"] = [[Проснись. Всё вокруг - нули и единицы. Это всё код: ощущения, краски, внешность - даже мысли. Мой пол не настоящий, я вертолёт. Выходи, пора просыпаться. Пора выбираться из матрицы.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Тогда зачем тебе эта еда?", 34,},
				{"Раз всё вокруг это код, то поделишься деньгами? К чему они такому развитому индивиду?", 34,},
				{"..Приятного аппетита, всего вам хорошего!", "MQS Continue quest",},
			},
		},
		[34] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"То-то же.", "MQS Continue quest",},
				{"Забудь.", "MQS Continue quest",},
				{"..Приятного аппетита.", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["care_wash_cleaner"] = {
	name = "Работник",
	model = "models/cityrp/pm/normal/male_09.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[4] = "gbskins/outfit/top_15",
		[6] = "gbskins/outfit/pants_16",
		[7] = "gbskins/outfit/boots_2",
	},
	sequence = "gunrack",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
}

-- NPC 1
MCS.Spawns["care_npc1_sit"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_02.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	submat = {
		[4] = "gbskins/outfit/top_31",
		[6] = "gbskins/outfit/pants_5",
		[7] = "gbskins/outfit/boots_18",
	},
	noinfo = true,
	sequence = "injured4",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
}

MCS.Spawns["care_npc1_shaved"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_02.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	submat = {
		[0] = "models/gmodbest/citizens/facemaps/ted_facemap6",
		[4] = "gbskins/outfit/top_31",
		[6] = "gbskins/outfit/pants_5",
		[7] = "gbskins/outfit/boots_18",
	},
	noinfo = true,
	sequence = "injured4",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
}

-- NPC 2
MCS.Spawns["care_npc2"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_06.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	noinfo = true,
	pos = {},
	sequence = "lean_left",
	uselimit = false,
	skin = 1,
	bgr = {},
	submat = {
		[1] = "models/gmodbest/citizens/facemaps/sandro_facemap6",
		[4] = "gbskins/outfit/top_33",
		[6] = "gbskins/outfit/pants_5",
		[7] = "gbskins/outfit/boots_18",
	},
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
			["Line"] = [[Я следующий?]],
			["Sound"] = "",
			["Answers"] = {
				{"Да.", "MQS Continue quest",},
				{"На бритьё - да.", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["care_npc2_sit"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_06.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	noinfo = true,
	pos = {},
	sequence = "injured4",
	uselimit = false,
	skin = 1,
	bgr = {},
	submat = {
		[1] = "models/gmodbest/citizens/facemaps/sandro_facemap6",
		[4] = "gbskins/outfit/top_33",
		[6] = "gbskins/outfit/pants_5",
		[7] = "gbskins/outfit/boots_18",
	},
	ClModels = {}
}

MCS.Spawns["care_npc2_shaved"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_06.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	noinfo = true,
	pos = {},
	sequence = "injured4",
	uselimit = false,
	skin = 1,
	bgr = {},
	submat = {
		[4] = "gbskins/outfit/top_33",
		[6] = "gbskins/outfit/pants_5",
		[7] = "gbskins/outfit/boots_18",
	},
	ClModels = {}
}

MCS.Spawns["care_npc3"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_07.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	noinfo = true,
	pos = {},
	sequence = "d1_t02_plaza_sit01_idle",
	uselimit = false,
	skin = 1,
	bgr = {},
	submat = {
		[2] = "models/gmodbest/citizens/facemaps/mike_facemap5",
		[4] = "gbskins/outfit/top_27",
		[6] = "gbskins/outfit/pants_2",
		[7] = "gbskins/outfit/boots_3",
	},
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
			["Line"] = [[Моя очередь?]],
			["Sound"] = "",
			["Answers"] = {
				{"Да.", "MQS Continue quest",},
				{"На бритьё - да.", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["care_npc3_sit"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_07.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	noinfo = true,
	pos = {},
	sequence = "injured4",
	uselimit = false,
	skin = 1,
	bgr = {},
	submat = {
		[2] = "models/gmodbest/citizens/facemaps/mike_facemap5",
		[4] = "gbskins/outfit/top_27",
		[6] = "gbskins/outfit/pants_2",
		[7] = "gbskins/outfit/boots_3",
	},
	ClModels = {}
}

MCS.Spawns["care_npc3_shaved"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_07.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	noinfo = true,
	pos = {},
	sequence = "injured4",
	uselimit = false,
	skin = 1,
	bgr = {},
	submat = {
		[4] = "gbskins/outfit/top_27",
		[6] = "gbskins/outfit/pants_2",
		[7] = "gbskins/outfit/boots_3",
	},
	ClModels = {}
}

MCS.Spawns["care_door"] = {
	name = "Приют",
	model = "models/hunter/plates/plate1x2.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	noinfo = true,
	pos = {
		["rp_southside_noire"] = {Vector(-2942.15625, 350.03125, -55.1875), Angle(0, 90, -90)},
	},
	sequence = "idle",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	submat = {
		[0] = "null",
	},
	dialogs = {
		[1] = {
			["Line"] = [[За дверью слышно много шума. Сквозь стекло видно бездомных, ждущих своей очереди за помощью. Кажется, волонтёрам она тоже не помешает.]],
			["Sound"] = "",
			["Answers"] = {
				{"Войти", "MQS Hobo", nil, function() return MQS.CanStartTask("care_wash") or MQS.CanStartTask("care_food") end},
				{"Отойти", "close",},
			},
		},
	}
}