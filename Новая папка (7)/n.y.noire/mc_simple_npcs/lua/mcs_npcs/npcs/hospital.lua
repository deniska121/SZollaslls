--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/hospital.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["civilian_med"] = {
	name = "Терапевт",
	model = "models/cityrp/pm/normal/female_06.mdl",
	namepos = 80,
	theme = "Default",
	checkpos = true,
	scale = 1,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(7533.3212890625, 5420.03125, -55.968799591064), Angle(0, -90.584701538086, 0)},
		["rp_southside"] = {Vector(7533.3212890625, 5420.03125, -55.968799591064), Angle(0, -90.584701538086, 0)},
	},
	sequence = "lineidle01",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_sound = "vo/npc/female01/help01.wav",
	uselimit = true,
	submat = {
		[4] = "gbskins/outfit/top_746",
		[9] = "gbskins/outfit/pants_746"
	},
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
-- VOICE - VALERIA
		[1] = {
			["Line"] = [[..Ну? Что стоите? Молодой человек, вам чего?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/1.mp3",
			["Answers"] = {
				{
					"Подозреваемому нужно оказать медицинскую помощь.", "close", function()
						net.Start("Police.Arrest")
						net.WriteUInt(0, 2)
						net.SendToServer()
					end,
					function() return LocalPlayer():isCP() and LocalPlayer():getDarkRPVar("Player.Drag") end
				},
				{
					"Мне нужна медицинская помощь.", {
						id = "MQS Start quest",
						data = {
							quest_id = "heal_all"
						}
					},
					nil, function() return MQS.CanStartTask("heal_all") and LocalPlayer():Health() < 100 and not LocalPlayer():getDarkRPVar("meds3") end
				},
				{
					"Мне нужна медицинская помощь.", {
						id = "MQS Start quest",
						data = {
							quest_id = "heal_gov"
						}
					},
					nil, function() return MQS.CanStartTask("heal_gov") and LocalPlayer():Health() < 100 and not LocalPlayer():getDarkRPVar("meds3") end
				},
				{
					"Слушайте, я тут не в первый раз и метаться по этажам не горю желанием. Подпишите пожалуйста справку и поставьте печать сразу.", 35, function() end, function()
						local q = MQS.HasQuest()

						return q and q.quest == "heal_all" and MQS.QuestStatusCheck("heal_all") and MQS.GetNWdata(LocalPlayer(), "quest_objective") == 3
					end
				},
				{"У вас есть подработка?", 3,},
				{"Ну какой я вам молодой человек?", 4,},
				{"Пока ничего. Потом зайду.", 2,},
			},
		},
		[2] = {
			["Line"] = [[Что значит 'потом'? Вы что, сговорились все? Молодой человек, хватит отвлекать медперсонал от работы! Когда убьют - тогда и приходите!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/2.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Простите за беспокойство.", "close",},
				{"Да что-б тебя на ночную смену оставили!", "close",},
			},
		},
		[3] = {
			["Line"] = [[Это что такое? Нахал! Нахлебник! Найдите честную работу, а не отнимайте честно заработанные гроши у честно работающих работников! И вообще, не отвлекайте медперсонал от важных дел! Когда убьют - тогда и приходите!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/3.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Простите за беспокойство.", "close",},
				{"Да что-б тебя на ночную смену оставили!", "close",},
			},
		},
		[4] = {
			["Line"] = [[Что вам не нравится-то? Вы человек? Человек. Молодой? В самом расцвете сил!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/4.mp3",
			["Answers"] = {
				{"Спасибо за комплимент.", 1,},
				{"Вы мой возраст видите?", 5,},
			},
		},
		[5] = {
			["Line"] = [[Да вы что? Возраст, и видеть! Может, мне ещё морщины на заднице сосчитать? Совсем не умеете принимать комплименты! Хватит отвлекать медперсонал от работы! Когда убьют - тогда и приходите!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/5.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Простите за беспокойство.", "close",},
			},
		},
		[6] = {
			["Line"] = [[Все наши врачи сейчас заняты, приходите позже.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/6.mp3",
			["Answers"] = {
				{"Хорошо.", "close",},
				{"Как это все? Вообще все?", 7,},
			},
		},
		[7] = {
			["Line"] = [[Молодой человек, что-ж вы никак не понимаете-то! Все претензии мы принимаем только в седьмую пятницу месяца! Ваши выплески лишь сильнее отвлекают медперсонал от работы!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/7.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Простите за беспокойство.", "close",},
			},
		},
		[8] = {
			["Line"] = [[Наши врачи- ..О, только что один освободился. У вас страховка есть?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/8.mp3",
			["Answers"] = {
				{"Есть.", 9,},
				{"Знаете, я потом зайду.", 2,},
			},
		},
		[9] = {
			["Line"] = [[Тогда берите форму, заполняйте, и несите с документами в приёмную на втором этаже.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/9.mp3",
			["Answers"] = {
				{"Хорошо.", "close",},
			},
		},
		[10] = {
			["Line"] = [[Молодой человек, вам чего? Сказано же - в приёмную, на втором, этаже! Вы что, умудрились в вертикальности потеряться?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/10.mp3",
			["Answers"] = {
				{"Там мне сказали взять справку, здесь.", 11,},
			},
		},
		[11] = {
			["Line"] = [[Какую справку? Вы что, издеваетесь? Здесь только одних форм триста вариантов!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/11.mp3",
			["Answers"] = {
				{"Мне нужна справка, чтобы приняли в срочном порядке вашу приёмную форму!", 12,},
			},
		},
		[12] = {
			["Line"] = [[Да не кричите вы на меня так, не глухая! Как вы смеете вообще! С таким отношением сами и ищите! Вон, стопка перед вами - залезайте и смотрите!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/12.mp3",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Спасибо за помощь.", "MQS Continue quest",},
				{"Истеричка.", "MQS Continue quest",},
			},
		},
		[13] = {
			["Line"] = [[Да что-ж такое! Сколько ещё?!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/13.mp3",
			["Answers"] = {
				{"Вы не поставили печать.", 14,},
			},
		},
		[14] = {
			["Line"] = [[Ну конечно! Пустили свои ручища к бумаге, аж все фильмы ужасов вспомнились! Как некультурно!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/14.mp3",
			["Answers"] = {
				{"Так вы поставите печать?", 15,},
			},
		},
		[15] = {
			["Line"] = [[..Вот. Довольны?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/15.mp3",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
				{"Посмотрим.", "MQS Continue quest",},
			},
		},
		[16] = {
			["Line"] = [[Вы с дуба рухнули? Молодой человек, ну сколько можно?!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/16.mp3",
			["Answers"] = {
				{"Мне нужна ваша подпись.", 17,},
			},
		},
		[17] = {
			["Line"] = [[А мне нужно успокоительное! Из-за ваших налётов на приёмную у меня нет и секунды отойти в уборную! Это бесчеловечно!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/17.mp3",
			["Answers"] = {
				{"Просто поставь эту подпись и иди ссать!", 15,},
				{"Чем быстрее вы поставите подпись - тем быстрее вы уйдёте по 'делам'.", 15,},
				{"Простите. Мне очень нужна эта подпись.", 15,},
			},
		},
		[18] = {
			["Line"] = [[Вы с дуба рухнули? Молодой человек, ну сколько можно?!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/16.mp3",
			["Answers"] = {
				{"Мне нужна подпись главврача.", 19,},
			},
		},
		[19] = {
			["Line"] = [[А ко мне какие претензии? Я не главврач, я терапевт! Это я должна жаловаться, а не вы! Мне работать надо, а меня за компуктер поставили кнопки нажимать! Не умею я!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/19.mp3",
			["Answers"] = {
				{"Главврача нет, а санитар ничего не может сделать. Остаётесь вы.", 20,},
			},
		},
		[20] = {
			["Line"] = [[Ну и что? Мне теперь обосраться, что ли?!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/20.mp3",
			["Answers"] = {
				{"Подпишите хотя бы для галочки!", 15,},
			},
		},
		[21] = {
			["Line"] = [[Опять вы? Что на этот раз?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/21.mp3",
			["Answers"] = {
				{"Нужно какое-то разрешение.", 22,},
			},
		},
		[22] = {
			["Line"] = [[Знаете что? Я вам разрешаю! Всё, уходите!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/22.mp3",
			["Answers"] = {
				{"..Санитар сказал, что прошла какая-то реформа, и нужно обновить документы.", 23,},
			},
		},
		[23] = {
			["Line"] = [[Так обновите! Молодой человек, ко мне какие претензии?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/23.mp3",
			["Answers"] = {
				{"Так для этого нужно разрешение! Документ!", 24,},
			},
		},
		[24] = {
			["Line"] = [[Так бы сразу и сказали! Разрешение С0-СK5 в формате '1N-51D-E'! Что, так сложно запомнить?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/24.mp3",
			["Answers"] = {
				{"Да.", 25,},
				{"Нет.", 25,},
			},
		},
		[25] = {
			["Line"] = [[Ну-ну. По вам прям видно. Вечно дёргаете бедного человека - то это вам не так, то вот то не понятно! Забирайте и уходите!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/25.mp3",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
				{"Ну наконец-то!", "MQS Continue quest",},
			},
		},
		[26] = {
			["Line"] = [[Опять? Молодой человек, вы опять тут?!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/26.mp3",
			["Answers"] = {
				{"Мне нужна печать.", 27,},
				{"С твоей-то работой - и удивляться! Мне нужна печать.", 27,},
			},
		},
		[27] = {
			["Line"] = [[А мне нужно поесть! Вы столько нервов мне сожгли, что теперь придётся взять внеплановый обед! Неоплачиваемый!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/27.mp3",
			["Answers"] = {
				{"Так вы поставите печать?", 28,},
			},
		},
		[28] = {
			["Line"] = [[Молодой человек! У меня обед!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/28.mp3",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[29] = {
			["Line"] = [[Ну что вы над душой стоите так, молодой человек? Давайте сюда уже эту вашу бумажку.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/29.mp3",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[30] = {
			["Line"] = [[Всё? Закончили?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/30.mp3",
			["Answers"] = {
				{"Только начинаем. Тут речь про денежные средства.", 31,},
			},
		},
		[31] = {
			["Line"] = [[Так вы ещё не заплатили? Молодой человек, ну вы даёте! Небось ещё и цен не знаете..!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/31.mp3",
			["Answers"] = {
				{"Знаю. Дайте счёт.", 33,},
				{"Так у меня же страховка!", 32,},
			},
		},
		[32] = {
			["Line"] = [[Страховка покрывает только появление задокументированной инвалидности и фатальные случаи! Молодой человек, платите из своего кармана!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/32.mp3",
			["Answers"] = {
				{"..Хорошо. Сколько с меня?", 33,},
			},
		},
		[33] = {
			["Line"] = [[С вас пятьдесят шесть долларов за предоставление услуг и тридцать девять долларов за медикаменты и курс лечения.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/33.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Знаете, что? Я отказываюсь от такого лечения.", "MQS Fail quest",},
			},
		},
		[34] = {
			["Line"] = [[Ну чего вы над душой стоите? Молодой человек, вам не сюда!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/34.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[35] = {
			["Line"] = [[А ко мне какие претензии? ..Вот. Довольны?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/35.mp3",
			["Answers"] = {
				{
					"Спасибо.", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "heal_all"
						}
					}
				},
				{
					"Надеюсь.", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "heal_all"
						}
					}
				},
			},
		},
		[36] = {
			["Line"] = [[..Ну? Что вы тут бумажкой-то растыкались?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/36.mp3",
			["Answers"] = {
				{"Это направление. Для лицензии на бизнес.", 37,},
			},
		},
		[37] = {
			["Line"] = [[Ну так и направляйтесь отсюда! Чего вы мне-то мозги лицензируете?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/37.mp3",
			["Answers"] = {
				{"Разве здесь не должны выдать на заполнение какие-то бланки?", 38,},
				{"Потому что твоя тупость незаконна. Меня сюда направили - за бланками.", 38,},
			},
		},
		[38] = {
			["Line"] = [[Вы что, издеваетесь? ..Ожидайте.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/38.mp3",
			["Answers"] = {
				{"Сколько?", "MQS Continue quest",},
				{"Хорошо.", "MQS Continue quest",},
				{"Только попробуй превратить это в жалобу главврачу.", "MQS Continue quest",},
			},
		},
		[39] = {
			["Line"] = [[Заполнили?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/39.mp3",
			["Answers"] = {
				{"Да.", 40,},
			},
		},
		[40] = {
			["Line"] = [[Обработка на втором этаже.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/40.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"..Это было быстро.", "MQS Continue quest",},
			},
		},
		[41] = {
			["Line"] = [[..Ну? Что вы тут бумажкой растыкались?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/36.mp3",
			["Answers"] = {
				{"Это направление. Для лицензии на оружие.", 42,},
			},
		},
		[42] = {
			["Line"] = [[Знаете что? Отказано! Вы невменяемы! Постоянно лезете ко мне со всякими просьбами! Надоело!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/42.mp3",
			["Answers"] = {
				{"..Просто выдайте дальнейшее направление, и я уйду.", 43,},
			},
		},
		[43] = {
			["Line"] = [[Господи, дай мне сил! ..Вот.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/43.mp3",
			["Answers"] = {
				{"Взаимно.", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
			},
		},
		[44] = {
			["Line"] = [[Ну что? Обследовались?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/44.mp3",
			["Answers"] = {
				{"Да. Вот результат.", 45,},
			},
		},
		[45] = {
			["Line"] = [[Мне плевать, какой у вас результат. Вот справка, вот печать, и вот точка. Свободны!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/45.mp3",
			["Answers"] = {
				{"Какая же вы злая..", "MQS Continue quest",},
				{"Запечатай себе рот.", "MQS Continue quest",},
				{"Спасибо.", "MQS Continue quest",},
				{"..Мне же ещё нужно от полиции получить разрешение, да?", 46, nil, function() return MQS.GetDataStored(LocalPlayer(), "lflag") == 1 end},
			},
		},
		[46] = {
			["Line"] = [[Откуда мне знать?! Я в полиции работаю, или что? Ещё одно уточнение, и я вашу справку аннулирую!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/46.mp3",
			["Answers"] = {
				{
					"Какая же вы злая..", {
						id = "MQS Skip to",
						data = {
							id = 47,
							quest_id = "license_gun"
						}
					},
				},
				{
					"Аннулируй себя дефенестрацией.", {
						id = "MQS Skip to",
						data = {
							id = 47,
							quest_id = "license_gun"
						}
					},
				},
				{
					"Спасибо.", {
						id = "MQS Skip to",
						data = {
							id = 47,
							quest_id = "license_gun"
						}
					},
				},
			},
		},
		[47] = {
			["Line"] = [[..Да, он здесь. У меня на разыскиваемых аллергия. Приезжайте скорее!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med/47.mp3",
			["Answers"] = {
				{"..Ой.", "close",},
				{"Ну и ладно.", "close",},
				{"Не надо, я ухожу.", "close",},
			},
		},
	}
}

MCS.Spawns["civilian_med2"] = {
	name = "Санитар",
	model = "models/cityrp/pm/normal/male_05.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(7448.2133789063, 5391.96875, 228.5), Angle(0, 90, 0)},
		["rp_southside"] = {Vector(7448.2133789063, 5391.96875, 228.5), Angle(0, 90, 0)},
	},
	sequence = "drinker_sit_idle_ss",
	uselimit = false,
	skin = 1,
	bgr = {},
	submat = {
		[4] = "gbskins/outfit/top_745",
		[8] = "gbskins/outfit/pants_745",
	},
	ClModels = {},
	dialogs = {
-- VOICE - FUNNY JACKIE LEE
		[1] = {
			["Line"] = [[З-здравс-ствуйте. Вы з-запис-саны на приём-ём-ём?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/1.mp3",
			["Answers"] = {
				{"Я хочу записаться на приём.", 4,},
				{"Что с вами?", 2,},
				{"Прошу прощения.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Я не американец. Плюс з-заикаюс-сь. Ро-ро-логоневроз-з.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/2.mp3",
			["Answers"] = {
				{"Мои соболезнования.", 5,},
				{"Вы же врач - как вы такое подцепить умудрились?", 3,},
			},
		},
		[3] = {
			["Line"] = [[Каже-жется, вас-с в детс-стве недос-статочно наз-зывари ос-с-собен-н-ной ри-ли-личнос-стью.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/3.mp3",
			["Answers"] = {
				{"...", 5,},
			},
		},
		[4] = {
			["Line"] = [[За-за-запись проходит на ре-ре-ре-ре- ..вниз-зу.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/4.mp3",
			["Answers"] = {
				{"Спасибо.", "close",},
			},
		},
		[5] = {
			["Line"] = [[..Вы что-то хотери-ри?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/5.mp3",
			["Answers"] = {
				{"Я хочу записаться на приём.", 4,},
				{"Нет, прошу прощения.", "close",},
			},
		},
		[6] = {
			["Line"] = [[З-здравс-ствуйте. Вы з-запис-саны на приём-ём-ём?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/1.mp3",
			["Answers"] = {
				{"Да. Вот форма.", 7,},
			},
		},
		[7] = {
			["Line"] = [[Вам не хватает с-с-с-справки.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/7.mp3",
			["Answers"] = {
				{"Какой справки?", 8,},
			},
		},
		[8] = {
			["Line"] = [[У нас-с очередь. Вы пытаетес-сь без-з очереди. Дря-ря этого нуж-ж-жна с-справка. Попрос-сите вниз-зу.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/8.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"А мы можем как-нибудь договориться?", 9,},
			},
		},
		[9] = {
			["Line"] = [[Нам не хватает рук, вы о чём-ём? Хотите с-срочно - берите с-справку.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/9.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Щас тебе зубов не хватать будет.", "MQS Continue quest",},
			},
		},
		[10] = {
			["Line"] = [[..Вам не хватает печати.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/10.mp3",
			["Answers"] = {
				{"Какой ещё печати?", 11,},
			},
		},
		[11] = {
			["Line"] = [[Мы не мож-ж-жем принять без-з печати.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/11.mp3",
			["Answers"] = {
				{"Пойду спущусь и попрошу поставить печать.", "MQS Continue quest",},
				{"С этим совсем ничего нельзя сделать?", 11,},
			},
		},
		[12] = {
			["Line"] = [[..Так.. У вас-с нет подпис-си терапевта.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/12.mp3",
			["Answers"] = {
				{"Я за подписью.", "MQS Continue quest",},
				{"А вы не можете поставить её? Вы же врач!", 13,},
			},
		},
		[13] = {
			["Line"] = [[Ме-ме-медбрат. Ещё-щё-щё не врач.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/13.mp3",
			["Answers"] = {
				{"Я за подписью.", "MQS Continue quest",},
				{"Не удивительно.", "MQS Continue quest",},
			},
		},
		[14] = {
			["Line"] = [[..Так.. У вас-с нет подпис-си глав-в-врача. Это выше.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/14.mp3",
			["Answers"] = {
				{"Я за подписью.", "MQS Continue quest",},
				{"А вы не можете поставить её? Вы же врач!", 15,},
			},
		},
		[15] = {
			["Line"] = [[Ме-ме-медбрат. Ещё-щё-щё не врач. И не гра-ра-лавный.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/15.mp3",
			["Answers"] = {
				{"Я за подписью.", "MQS Continue quest",},
				{"Не удивительно.", "MQS Continue quest",},
			},
		},
		[16] = {
			["Line"] = [[..Да-да? Вам к глав-в-врачу.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/16.mp3",
			["Answers"] = {
				{"Его нет. Можете пропустить так?", 17,},
			},
		},
		[17] = {
			["Line"] = [[Не-не-не-не могу. Попрос-сите с-старшего.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/17.mp3",
			["Answers"] = {
				{"Я за подписью.", "MQS Continue quest",},
				{"А вы не можете поставить подпись? Вы же врач!", 13,},
			},
		},
		[18] = {
			["Line"] = [[..Так.. Почти вс-сё-сё. Нужно раз-зрешение.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/18.mp3",
			["Answers"] = {
				{"Какое ещё разрешение?", 19,},
			},
		},
		[19] = {
			["Line"] = [[На-на обновре-рение документов.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/19.mp3",
			["Answers"] = {
				{"А это ещё зачем?", 20,},
			},
		},
		[20] = {
			["Line"] = [[Ре-ре-реформа. Мы не мож-жем обслуж-живать ж-ж-жителей без-з пор-рного пакета инф-ф-формации.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/20.mp3",
			["Answers"] = {
				{"Дайте угадаю - бланк брать внизу? Я сейчас.", "MQS Continue quest",},
				{"Я вам разрешаю. Теперь можете.", 21,},
			},
		},
		[21] = {
			["Line"] = [[Нуж-жно пис-сьмен-н-ное с-сограс-сие. Воз-зьмите бра-ланк вниз-зу.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/21.mp3",
			["Answers"] = {
				{"Я сейчас.", "MQS Continue quest",},
			},
		},
		[22] = {
			["Line"] = [[..С-спас-сибо. Подож-ждите, пока мы дераем з-запрос-с в ра-ра-ратуш-ш-шу.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/22.mp3",
			["Answers"] = {
				{"Вы шутите?", 23,},
			},
		},
		[23] = {
			["Line"] = [[Нет. Ожид-жид-жидайте.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/23.mp3",
			["Answers"] = {
				{"...", "MQS Continue quest",},
			},
		},
		[24] = {
			["Line"] = [[..Так.. Вы за-запратири?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/24.mp3",
			["Answers"] = {
				{"Нет ещё.", 25,},
				{"Нет, у меня же страховка.", 25,},
			},
		},
		[25] = {
			["Line"] = [[Опрат-рата вниз-зу.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/25.mp3",
			["Answers"] = {
				{"Секунду.", "MQS Continue quest",},
				{"Так у меня страховка!", 25,},
			},
		},
		[26] = {
			["Line"] = [[..Вс-сё-сё-сё готово. Про-роходите. Срева от вас.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/26.mp3",
			["Answers"] = {
				{"Спасибо.", "MQS Continue quest",},
				{"Наконец-то!", "MQS Continue quest",},
			},
		},
		[27] = {
			["Line"] = [[Дож-ж-ждитес-сь с-своей очереди!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/27.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Может как-нибудь договоримся?", 27,},
			},
		},
		[28] = {
			["Line"] = [[..Эт-эт-это что?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/28.mp3",
			["Answers"] = {
				{"Мне нужно разрешение от санитарного надзора. Это для лицензии на бизнес.", 29,},
			},
		},
		[29] = {
			["Line"] = [[Ож-ж-жидайте.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/29.mp3",
			["Answers"] = {
				{"Хоть где-то работают сразу..", "MQS Continue quest",},
				{"Хорошо.", "MQS Continue quest",},
			},
		},
		[30] = {
			["Line"] = [[Се-сейчас врач подо-дойдёт. Как-как-как.. вызовут - в общую комрату.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/civilian_med2/30.mp3",
			["Answers"] = {
				{"Окей.", "MQS Continue quest",},
			},
		},
	}
}