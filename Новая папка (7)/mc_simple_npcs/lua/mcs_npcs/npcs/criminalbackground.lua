-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\criminalbackground.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MCS.Spawns["chapter2_hobo"] = {
	name = "Бездомный",
	model = "models/cityrp/pm/normal/male_03.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {
	},
	sequence = "idle_all_angry",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {
	},
	dialogs = {
		[1] = {
			["Line"] = [[Мелочи не найдётся?]],
			["Sound"] = "",
			["Answers"] = {
				{"Не найдётся.", "close",},
				{"У меня только карта.", "close",},
				{"В мотеле вам помогут.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Мелочи не найдётся?]],
			["Sound"] = "",
			["Answers"] = {
				{"Не видишь я по телефону говорю?", "MQS Continue quest",},
				{"Отстань.", "MQS Continue quest",},
				{"Отъебись!", "MQS Continue quest",},
				{"Пошёл нахуй, тупой ниггер!", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["chapter2_hooder"] = {
	name = "Худер",
	model = "models/cityrp/pm/normal/male_01.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {
	},
	sequence = "idle_melee_angry",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {
		{ model = "models/mr.l/cscz/cso_mac10.mdl", pos = Vector(1,3,1), ang = Angle(130,90,355), bone = 39},
	},
	dialogs = {
		[1] = {
			["Line"] = [[А ты куда смотришь?]],
			["Sound"] = "",
			["Answers"] = {
				{"Чего вы там не поделили?", 2,},
				{"Кто ты такой чтоб так разговаривать?", 6,},
				{"Забудь.", "close",},
			},
		},
		[2] = {
			["Line"] = [[..Нигга ты ваще не вдупляешь как тут всё устроено!]],
			["Sound"] = "",
			["Answers"] = {
				{"Я и пытаюсь понять.", 3,},
				{"Забудь.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Худеры и Биферы - шумное прикрытие когда оно нужно нам всем. Только мы никуда с худа не суёмся, а Биферы никак ненабифятся!]],
			["Sound"] = "",
			["Answers"] = {
				{"Прикрытие?", 4,},
				{"Нам всем?", 4,},
				{"Окей.", "close",},
			},
		},
		[4] = {
			["Line"] = [[Нигга какого хуя?]],
			["Sound"] = "",
			["Answers"] = {
				{"Как шум скрывает организацию?", 5,},
				{"Вы две банды - как вы уживаетесь-то?", 5,},
				{"А, всё, дошло.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Если ты этого не понимаешь - я точняк не объясню. Те к хэндлерам, к более приближённым - к Томми или Слиму.]],
			["Sound"] = "",
			["Answers"] = {
				{"Ладно.", "close",},
			},
		},
		[6] = {
			["Line"] = [[Нигга мы все в этой хуйне равны, ты хули возникаешь?]],
			["Sound"] = "",
			["Answers"] = {
				{"Сутенёр-по-Имени-Прилизанный - мой босс.", 7,},
				{"Ты - старший, чтоб общаться на равных со старшими?", 7,},
				{"Забудь.", "close",},
			},
		},
		[7] = {
			["Line"] = [[Нигга, мы все вместе существуем не потому что есть какой-то главный хуй и все ходят под ним.]],
			["Sound"] = "",
			["Answers"] = {
				{"Это как?", 5,},
				{"Тогда почему ты здесь?", 5,},
				{"Кажется, до меня дошло.", "close",},
			},
		},
		[8] = {
			["Line"] = [[Чё мне делать с Биферами? Они на клубе не остановятся!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[9] = {
			["Line"] = [[Нигга они прям щас собираются стреляться с моими нигерами, внатуре!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[10] = {
			["Line"] = [[..Я тебя замочу щас нигга!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[11] = {
			["Line"] = [[Мы так не договаривались нигга! Худеры сидят у себя - а Биферы должны сидеть у себя!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[12] = {
			["Line"] = [[Нигга нихуя! Эта мясорубка пахнет жетонами! Сколько раз повторять что мы все сука в доле? На кого копам обращать внимание если не на нас?]],
			["Sound"] = "",
			["Answers"] = {
				{"Что тут блять происходит?", "MQS Continue quest",},
			},
		},
		[13] = {
			["Line"] = [[У тоннеля, на Норт Стрит.]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[14] = {
			["Line"] = [[Да не будем мы нихуя обсуждать! Не случится этого тупо!]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["chapter2_beef"] = {
	name = "Бифер",
	model = "models/cityrp/pm/normal/male_01.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {
	},
	sequence = "idle_all_scared",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {
		{ model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl", pos = Vector(3,1.7999999523163,3), ang = Angle(0,0,-7), bone = 16},
	},
	dialogs = {
		[1] = {
			["Line"] = [[Хули палишь?]],
			["Sound"] = "",
			["Answers"] = {
				{"Ничего.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Хули палишь?]],
			["Sound"] = "",
			["Answers"] = {
				{"Остановитесь. Худеры не хотят стрелять - ваш гнев мешает нам всем.", 3,},
				{"Ничего.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Тя набифить или чё? Отштукатурить? В биф зарендерить?]],
			["Sound"] = "",
			["Answers"] = {
				{"Не надо, я с миром.", 4,},
				{"Себя набифь.", 4,},
				{"А чё ты дёргаешься? Боишься?", 4,},
				{"Рот закрой и слушай когда с тобой говорит подручный.", 5, function() end, function()
                        return MQS.GetSData(nil, "mcs.bold", 0) > 0
                    end
				},
			},
		},
		[4] = {
			["Line"] = [[Неправильный ответ.]],
			["Sound"] = "",
			["Answers"] = {
				{"А ну попробуй!", "MQS Continue quest",},
				{"Стой!", "MQS Continue quest",},
			},
		},
		[5] = {
			["Line"] = [[Пиздючный! Молоко ещё не отсохло выебоны выдавать! Ты - такая же пешка как и Худеры!]],
			["Sound"] = "",
			["Answers"] = {
				{"А ты нет, что ли? Дохуя особенный?", 6,},
				{"И это мне говорит озабоченный по беспределу?", 6,},
				{"Неправильный ответ.", 6,},
			},
		},
		[6] = {
			["Line"] = [[Пизда тебе!]],
			["Sound"] = "",
			["Answers"] = {
				{"Что, больно?", "MQS Continue quest",},
				{"Хуй тебе!", "MQS Continue quest",},
			},
		},
	}
}