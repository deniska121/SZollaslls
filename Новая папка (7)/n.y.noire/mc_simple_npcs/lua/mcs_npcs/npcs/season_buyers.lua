--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/season_buyers.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["season_buyer1"] = {
	name = "Мужчина",
	model = "models/cityrp/pm/normal/male_04.mdl",
	namepos = 80,
	submat = {
		[5] = "models/gmodbest/citizens/arms_latin",
		[4] = "gbskins/outfit/top_4",
		[2] = "models/gmodbest/citizens/facemaps/eric_facemap13"
	},
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "pose_standing_02",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Да?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/1.mp3",
			["Answers"] = {
				{"Прошу прощения.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Да?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/1.mp3",
			["Answers"] = {
				{"Здравствуй. Не хочешь прикупить кое-что интересное?", 3,},
				{"Здарова. Как дела?", 10,},
				{"Йоу. Пушка не нужна?", 5,},
			},
		},
		[3] = {
			["Line"] = [[Например?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/3.mp3",
			["Answers"] = {
				{"Ну, интересное. Понимаешь меня?", 4,},
				{"Кое-что не самое правильное.", 4,},
				{"Оружие.", 5,},
			},
		},
		[4] = {
			["Line"] = [[Оружие? Наркотики? Услуги?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/4.mp3",
			["Answers"] = {
				{"Может быть.", 5,},
				{"Оружие.", 5,},
				{"Мне не нравится твой тон.", 7,},
			},
		},
		[5] = {
			["Line"] = [[Покажи.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/5.mp3",
			["Answers"] = {
				{"Сейчас.", "MQS Continue quest",},
				{"Сначала скажи, интересует тебя такое или нет.", 6,},
				{"Мне не нравится твой тон.", 7,},
			},
		},
		[6] = {
			["Line"] = [[Так у тебя нету оружия? Покажи, а там поговорим.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/6.mp3",
			["Answers"] = {
				{"Сейчас.", "MQS Continue quest",},
				{"Мне не нравится твой тон.", 7,},
			},
		},
		[7] = {
			["Line"] = [[Да брось. Покажи товар, я готов с тобой поторговаться.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/7.mp3",
			["Answers"] = {
				{"Сейчас.", "MQS Continue quest",},
				{
					"Нет у меня никакого товара. Всего хорошего.", {
						id = "MQS Skip to",
						data = {
							id = 19,
							quest_id = "season1_criminal_3"
						}
					},
				},
			},
		},
		[8] = {
			["Line"] = [[Вот это новый год..]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/8.mp3",
			["Answers"] = {
				{"Нравится?", 9,},
			},
		},
		[9] = {
			["Line"] = [[Полицейский Департамент Нью-Йорка! Не двигаться!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/9.mp3",
			["Answers"] = {
				{"...", "JailPlayer",},
				{"Сдаюсь!", "JailPlayer",},
				{"Это шутка! Муляж!", "JailPlayer",},
				{"Сука!", "JailPlayer",},
			},
		},
		[10] = {
			["Line"] = [[Нормально. Ты по делу?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/10.mp3",
			["Answers"] = {
				{"Да.", 12,},
				{"Смотря по какому.", 11,},
			},
		},
		[11] = {
			["Line"] = [[Ты сначала покажи, а там поговорим.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/11.mp3",
			["Answers"] = {
				{"Сейчас.", "MQS Continue quest",},
				{"Мне не нравится твой тон.", 7,},
			},
		},
		[12] = {
			["Line"] = [[Покажи.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/12.mp3",
			["Answers"] = {
				{"Сейчас.", "MQS Continue quest",},
				{"Сначала скажи, что тебя интересует.", 13,},
				{"Мне не нравится твой тон.", 7,},
			},
		},
		[13] = {
			["Line"] = [[Ты сначала покажи, а там поговорим.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer1/13.mp3",
			["Answers"] = {
				{"Сейчас.", "MQS Continue quest",},
				{"Мне не нравится твой тон.", 7,},
			},
		},
	}
}

MCS.Spawns["season_buyer2"] = {
	name = "Мужчина",
	model = "models/cityrp/pm/normal/male_08.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_1",
		[8] = "gbskins/outfit/pants_20",
		[4] = "gbskins/outfit/top_20",
		[0] = "models/gmodbest/citizens/facemaps/vance_facemap6"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "plazaidle3",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Что-то хотели?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer2/1.mp3",
			["Answers"] = {
				{"Нет, ничего.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Что-то хотели?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer2/1.mp3",
			["Answers"] = {
				{"Здарова. Не хочешь прикупить кое-что интересное?", 3,},
				{"Здравствуйте. Как дела?", 3,},
				{"Йоу. Пушка не нужна?", 3,},
			},
		},
		[3] = {
			["Line"] = [[..Опять со своими пылесосами припёрлися? Отстаньте! Кто деньгу мне на него даст?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer2/3.mp3",
			["Answers"] = {
				{"Нет, не пылесос. Кое-что интереснее. Понимаешь меня?", 4,},
				{"На первый раз денег не надо. Тебе понравится.", 4,},
				{"С этой вещью у тебя будет сколько хочешь пылесосов. Пробник бесплатно.", 4,},
			},
		},
		[4] = {
			["Line"] = [[Знаю я это ваше самое! Шо угодно скажете шоб всосатеся как следует! Гремучие наркоманы!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer2/4.mp3",
			["Answers"] = {
				{"Да ты посмотри только!", "MQS Continue quest",},
				{"Я отвечаю за свои слова. Бесплатно есть бесплатно.", "MQS Continue quest",},
				{
					"..Ладно, я пойду. Удачи.", {
						id = "MQS Skip to",
						data = {
							id = 26,
							quest_id = "season1_criminal_3"
						}
					},
				},
			},
		},
		[5] = {
			["Line"] = [[Ой, это шо такое? ..Мне такое не надо, совсем не надо! Даже за бесплатно! Уходите! ..Помогите!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer2/5.mp3",
			["Answers"] = {
				{"Простите.", "MQS Continue quest",},
				{"Многое теряешь.", "MQS Continue quest",},
				{"Не кричи ты так!", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["season_buyer3"] = {
	name = "Мужчина",
	model = "models/cityrp/pm/normal/male_06.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_1",
		[8] = "gbskins/outfit/pants_91",
		[4] = "gbskins/outfit/top_91",
		[1] = "models/gmodbest/citizens/facemaps/sandro_facemap11"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "d1_t01_breakroom_sit02",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Чё зыришь?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/1.mp3",
			["Answers"] = {
				{"Ничего.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Чё зыришь?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/1.mp3",
			["Answers"] = {
				{"Здарова. Не хочешь прикупить кое-что интересное?", 3,},
				{"Привет. Как дела?", 26,},
				{"Йоу. Пушка не нужна?", 26,},
			},
		},
		[3] = {
			["Line"] = [[Ты ваще врубаешься кому ты это предлагаешь?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/3.mp3",
			["Answers"] = {
				{"Солидному мужчине, кому явно не хватает дополнительной огневой мощи.", 4,},
				{"Не совсем.", 5,},
				{"Ты даже не знаешь, что я предлагаю.", 4,},
			},
		},
		[4] = {
			["Line"] = [[Ну-ка, чё там у тя.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/4.mp3",
			["Answers"] = {
				{"Сейчас покажу.", "MQS Continue quest",},
				{"Что ты ожидаешь увидеть?", 6,},
				{"Мне не нравится твой тон.", 8,},
			},
		},
		[5] = {
			["Line"] = [[Я авторитет. Я с лёгкостью достану чё захочу. Давай, удиви меня - чё у тя в сумке?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/5.mp3",
			["Answers"] = {
				{"Пушка. Качество говорит за себя.", 4,},
				{"Нечто интересное.", 4,},
				{"Мне не нравится твой тон.", 8,},
			},
		},
		[6] = {
			["Line"] = [[Ты мне давай мозги не еби. Или показывай товар, или не привлекай больше внимания своей сумкой.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/6.mp3",
			["Answers"] = {
				{"Хорошо. Сейчас покажу.", "MQS Continue quest",},
				{"Надеюсь, ты не под прикрытием..", "MQS Continue quest",},
				{"У меня нет выбора, не так ли?", 7,},
			},
		},
		[7] = {
			["Line"] = [[Господи, какой ты новичок блять..]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/7.mp3",
			["Answers"] = {
				{"Успокойся. Сейчас увидишь.", "MQS Continue quest",},
				{"Нужно же удостовериться, что я не с детективом разговариваю?", "MQS Continue quest",},
				{"Первый блин комом. У всех бывает.", "MQS Continue quest",},
			},
		},
		[8] = {
			["Line"] = [[А мне не нравишься ты. Стоишь сука яйца мнёшь, внимание привлекаешь. Или показывай товар, или уёбывай.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/8.mp3",
			["Answers"] = {
				{"Хорошо. Сейчас покажу.", "MQS Continue quest",},
				{"Надеюсь, ты не под прикрытием..", "MQS Continue quest",},
				{"У меня нет выбора, не так ли?", 7,},
			},
		},
		[9] = {
			["Line"] = [[Неплохо. Есть тока одна проблема.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/9.mp3",
			["Answers"] = {
				{"Какая?", 10,},
			},
		},
		[10] = {
			["Line"] = [[У моего босса уже есть поставщик. Крупный.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/10.mp3",
			["Answers"] = {
				{"Мы лучше.", 11,},
				{"У всего есть своя цена. Назови свою.", 21,},
				{"То есть, сделки не будет?", 24,},
			},
		},
		[11] = {
			["Line"] = [[Нихуя. Я тя даже не знаю. Ты с кем работаешь?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/11.mp3",
			["Answers"] = {
				{"С Джо.", 12,},
				{"Джо Бабуз.", 12,},
				{"С очень квалифицированным мастером. В день таких десяток штук спокойно сделаем.", 19,},
			},
		},
		[12] = {
			["Line"] = [[С этим выхлопом? Ёбаный в рот..]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/12.mp3",
			["Answers"] = {
				{"Нормальный мужик, вытягивает большие объёмы работ.", 13,},
				{"У него в мастерской по несколько крупных ящиков с вооружением проходит в день. Справляется.", 13,},
				{"Он же не один этим занимается. Нормально всё будет.", 13,},
				{"Что не так?", 13,},
			},
		},
		[13] = {
			["Line"] = [[Он-ж совсем кукушка! Работать то может, да вот.. лять, слов не нахожу. Опасно с таким работать.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/13.mp3",
			["Answers"] = {
				{"Слушай, мы можем переплюнуть вашего текущего мастера. ", 14,},
				{"Результат оправдывает средства, не так ли?", 14,},
				{"Что насчёт работать сразу с двумя людьми?", 18,},
			},
		},
		[14] = {
			["Line"] = [[А чё я боссу скажу? 'Эл, забей на договорняк, я тут с ебанутым скорешился'? Мало того что у них история - так дела не делаются!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/14.mp3",
			["Answers"] = {
				{"Покажи ствол боссу. Пусть даст шанс.", 15,},
				{"У меня идея: устроим одну сделку. Всего одну, решающую. А там посмотрим, что к чему.", 16,},
				{"Давай я поговорю с твоим боссом.", 17,},
			},
		},
		[15] = {
			["Line"] = [[Смотри, как бы он за яйца всех нас не подвесил.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/15.mp3",
			["Answers"] = {
				{"То есть?", 25,},
				{"Мы в деле?", 25,},
			},
		},
		[16] = {
			["Line"] = [[А это мысль. ..Бля, охуенная мысль!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/16.mp3",
			["Answers"] = {
				{"По рукам?", 25,},
			},
		},
		[17] = {
			["Line"] = [[Мож тебя сразу грохнуть, шоб время не тратить?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/17.mp3",
			["Answers"] = {
				{"Покажи ствол боссу. Пусть даст шанс.", 15,},
				{"У меня идея: устроим одну сделку. Всего одну, решающую. А там посмотрим, что к чему.", 16,},
			},
		},
		[18] = {
			["Line"] = [[Как ты се это представляешь? 'Эл, только что встретил знакомого оружейника, расчехляй бабос на новую игрушку'? Мало того что у них история - так дела не делаются!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/18.mp3",
			["Answers"] = {
				{"Покажи ствол боссу. Пусть даст шанс.", 15,},
				{"У меня идея: устроим одну сделку. Всего одну, решающую. А там посмотрим, что к чему.", 16,},
				{"Давай я поговорю с твоим боссом.", 17,},
			},
		},
		[19] = {
			["Line"] = [[Удиви меня.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/19.mp3",
			["Answers"] = {
				{"Джо.", 12,},
				{"Джо Бабуз.", 12,},
				{"Оставлю в секрете.", 20,},
			},
		},
		[20] = {
			["Line"] = [[И чё дальше? Чё я боссу скажу? 'Эл, выцепил инкогнито через хуй знает кого, забей на реальный договорняк, я те ствол принёс'? Так дела не делаются!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/20.mp3",
			["Answers"] = {
				{"Покажи ствол боссу. Пусть даст шанс. Результат оправдывает средства.", 15,},
				{"У меня идея: устроим одну сделку. Всего одну, решающую. А там посмотрим, что к чему.", 16,},
				{"Давай я поговорю с твоим боссом. Решим сразу разногласия, раскроем карты.", 17,},
			},
		},
		[21] = {
			["Line"] = [[Во, наконец на моём языке базарим. ..Тока я хуй знает чё ты можешь предложить. Босс серьёзно настроен, договорняк расторгать не пацанское дело - тем более ради ноунейма. Как мне объяснять боссу кто ты? Ты с кем работаешь? Чем докажешь качество?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/21.mp3",
			["Answers"] = {
				{"Имя для друзей, поэтому у меня его нет. За меня говорят дела. Результат ты видишь перед собой.", 22,},
				{"Тебе понравился ствол. Покажи его боссу. Пусть даст шанс.", 23,},
				{"Я работаю с Джо. С Джо Бабузом.", 12,},
			},
		},
		[22] = {
			["Line"] = [[Вот как.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/22.mp3",
			["Answers"] = {
				{"...", 15,},
			},
		},
		[23] = {
			["Line"] = [[И не откажешь ведь.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/23.mp3",
			["Answers"] = {
				{"Ну так что?", 25,},
				{"По рукам?", 25,},
			},
		},
		[24] = {
			["Line"] = [[У всего есть своя цена. Тока я хуй знает чё ты можешь предложить. Босс серьёзно настроен, договорняк расторгать не пацанское дело - тем более ради ноунейма. Как мне объяснять боссу кто ты? Ты с кем работаешь? Чем докажешь качество?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/24.mp3",
			["Answers"] = {
				{"Имя для друзей, поэтому у меня его нет. За меня говорят дела. Результат ты видишь перед собой.", 22,},
				{"Тебе понравился ствол. Покажи его боссу. Пусть даст шанс.", 23,},
				{"Я работаю с Джо. С Джо Бабузом.", 12,},
			},
		},
		[25] = {
			["Line"] = [[Короче, я тя услышал. Убери ствол в сумку, сумку оставь мне. Я передам, уточню, еси чё позвоню. Контакт мастера оставь тока!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/25.mp3",
			["Answers"] = {
				{"В сумке все детали.", "MQS Continue quest",},
				{"Джо Бабуза знаешь? ..Вот ему и звони.", "MQS Continue quest",},
				{"Конечно. Приятно с вами иметь дело.", "MQS Continue quest",},
			},
		},
		[26] = {
			["Line"] = [[Нихуясе! Ты чё, коп?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/26.mp3",
			["Answers"] = {
				{"Ни в коем случае.", 27,},
				{"Мне делать нечего, стучать этим дуракам?", 27,},
				{"Я подмастерье оружейника. ", 4,},
			},
		},
		[27] = {
			["Line"] = [[А хуй тя знает.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/27.mp3",
			["Answers"] = {
				{"Что ты ожидаешь увидеть?", 6,},
				{"Ты даже не знаешь, что я предлагаю.", 4,},
				{"Я подмастерье оружейника. ", 4,},
			},
		},
	}
}

MCS.Spawns["season_buyer3_traitor"] = {
	name = "Мужчина",
	model = "models/cityrp/pm/normal/male_06.mdl",
	submat = {
		[9] = "gbskins/outfit/boots_1",
		[8] = "gbskins/outfit/pants_91",
		[4] = "gbskins/outfit/top_91",
		[1] = "models/gmodbest/citizens/facemaps/sandro_facemap11"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "lineidle02",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Под ногами не толпись!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/2_1.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[2] = {
			["Line"] = [[На месте?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/2_2.mp3",
			["Answers"] = {
				{"Да.", 3,},
				{"На месте.", 3,},
				{"Конечно, проверяй.", 3,},
			},
		},
		[3] = {
			["Line"] = [[Сейчас мои парни сё разгрузят, в конце загрузят деньги.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/2_3.mp3",
			["Answers"] = {
				{"Хорошо.", 4,},
			},
		},
		[4] = {
			["Line"] = [[Приятно с вами работать, сё ништяк.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_buyer3/2_4.mp3",
			["Answers"] = {
				{"Взаимно.", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
				{"Обязательно ещё сработаемся.", "MQS Continue quest",},
			},
		},
	}
}