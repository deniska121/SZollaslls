-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\utill.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MCS.Spawns["cardealler"] = {
	name = "Продавец",
	model = "models/cityrp/pm/normal/male_02.mdl",
	submat = {
		[0] = "models/gmodbest/citizens/facemaps/ted_facemap17",
		[4] = "gbskins/outfit/top_21",
		[8] = "gbskins/outfit/pants_21",
		[9] = "gbskins/outfit/boots_3"
	},
	namepos = 72,
	theme = "Default",
	checkpos = true,
	scale = 1,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(-7569, 1591.5571289063, -31.96875), Angle(0, -1.6722683906555, 0)},
	},
	sequence = "d1_t01_breakroom_watchbreen",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_alarm = 2869,
	uselimit = true,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Formater"] = function(text)
				if LocalPlayer():GetPData("npc_car") then return "А, снова вы! Вас новое интересует, или ваш транспорт?", "https://macnco.one/cityrp/npcsound/cardealler/1a.mp3" end

				return "Приветствую в нашем скромном автосалоне! Не обращайте внимание на название - мы продаём как новые, так и подержанные автомобили! Да что там - го-готовы скупить ваш автотранспорт, прямо сейчас! ..Кхм, чем могу помочь?"
			end,
			["Line"] = [[]],
			["Gestures"] = {
				{"g_righthandroll", 0.01},
				{"g_righthandheavy", 4.5},
				{"g_lefthandmotion", 5.5},
				{"g_noway_big", 7.4}
			},
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/1.mp3",
			["Answers"] = {
				{
					"Я хочу посмотреть ваши автомобили..", "close", function()
						McCD.OpenGarage(true)
					end
				},
				{
					"Я хочу просмотреть свой гараж..", "close", function()
						net.Start("McCD.Msg")
						net.WriteUInt(0, 3)
						net.WriteBool(false)
						net.SendToServer()
					end
				},
				{
					"Я хочу убрать свой автомобиль в гараж..", "close", function()
						net.Start("McCD.Msg")
						net.WriteUInt(5, 3)
						net.SendToServer()
					end
				},
				--{"Я хочу арендовать транспорт.", 6,},
				{"Неужели автобизнесу настолько плохо, раз приходится заманивать такими замахами?", 2, nil, function() return not LocalPlayer():GetPData("npc_car") end},
				{"Спасибо, я просто смотрю.", "close",},
			},
		},
		[2] = {
			["Line"] = [[..И не говорите. Цены на бензин высокие, на материалы к машинам - тоже. Вот специально буд невыгодно делают, чтоб все на автобусах колесили и тратили почти столько же! В Юнио- ..В Нью-Йорке количество такси подобно жителям. Но зачем? Это-ж неудобно!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/2.mp3",
			["Answers"] = {
				{
					"Как думаете, кто в этом виноват?", 5, function()
						LocalPlayer():SetPData("npc_car", 1)
					end
				},
				{"Вы упомянули Юнион - почему Нью-Йорк иногда называют Юнионом?", 4,},
				{"Спасибо. Вернёмся к бизнесу?", 3,},
			},
		},
		[3] = {
			["Line"] = [[С удовольствием! Что вас интересует?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/3.mp3",
			["Answers"] = {
				{
					"Я хочу посмотреть ваши автомобили..", "close", function()
						McCD.OpenGarage(true)
					end
				},
				{
					"Я хочу просмотреть свой гараж..", "close", function()
						net.Start("McCD.Msg")
						net.WriteUInt(0, 3)
						net.WriteBool(false)
						net.SendToServer()
					end
				},
				{
					"Я хочу убрать свой автомобиль в гараж..", "close", function()
						net.Start("McCD.Msg")
						net.WriteUInt(5, 3)
						net.SendToServer()
					end
				},
				--{"Я хочу арендовать транспорт.", 6,},
				{"Пока ничего, просто смотрю.", "close",},
			},
		},
		[4] = {
			["Line"] = [[Сразу видно приезжего. Эт потому что наш Йорк якобы дружный город. Город-союз; мол все друг другу помогают. Знаете, эт брехня всё. Был бы город дружным - его бы не высмеивали в этих компуктерных игрушках. Не было бы сегодняшних проблем. Ни в бизнесе, ни в жизни.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/4.mp3",
			["Answers"] = {
				{
					"Как думаете, кто в этом виноват?", 5, function()
						LocalPlayer():SetPData("npc_car", 1)
					end
				},
				{"Спасибо. Вернёмся к бизнесу?", 3,},
			},
		},
		[5] = {
			["Line"] = [[Ну а вы как думаете? Конечно же проигрывающие партии! Игроманы, проститутки, черножопые с западного побережья! Они враги народа! Всех спонсируют с востока! Вы что, телевизор не смотрите? Там правда и только правда - там говорят, что виноваты все кроме правителей! Как же нам повезло с покровителями - вы только представьте, что было бы без RedNeck Voice..!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/5.mp3",
			["Answers"] = {
				{"..Давайте вернёмся к бизнесу?", 3,},
				{"Теперь понятно, почему у вас ничего не покупают. Пойду-ка я отсюда тоже.", "close",},
			},
		},
		[6] = {
			["Line"] = [[Вы.. серьёзно?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/6.mp3",
			["Answers"] = {
				{"В чём дело?", 7,},
				{"Простите, больше не интересует.", "close",},
			},
		},
		[7] = {
			["Line"] = [[Друже, сразу говорю - это ведро, а не машина! Там грань между неисправной и легальной ездой тоньше, чем.. Короче, хреново всё. Очень.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/7.mp3",
			["Answers"] = {
				{"Мне очень нужна машина.", 8,},
				{"Уговаривать не придётся. Вернёмся к обычному бизнесу?", 3,},
				{"Простите, больше не интересует.", "close",},
			},
		},
		[8] = {
			["Line"] = [[Ладно, моё дело - предупредить. На дорогах аккуратнее, в автосервис можешь не заезжать - виновен возраст. Такое не лечится.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/8.mp3",
			["Answers"] = {
				{"Спасибо!", "close", function() end},
				--LocalPlayer():SetPData("npc_car", 1)
				{"Простите, больше не интересует.", "close",},
			},
		},
		[9] = {
			["Line"] = [[Простите, ничем не могу помочь. Пробную машину уже арендовали.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler/9.mp3",
			["Answers"] = {
				{"Спасибо.", "close",},
			},
		},
	}
}

-- MCS.Spawns["cardealler_night"] = {
-- 	name = "Продавец",
-- 	model = "models/cityrp/pm/normal/male_09.mdl",
-- 	submat = {
-- 		[3] = "models/gmodbest/citizens/facemaps/erdim_facemap11",
-- 		[4] = "gbskins/outfit/top_21",
-- 		[8] = "gbskins/outfit/pants_21",
-- 		[9] = "gbskins/outfit/boots_17"
-- 	},
-- 	namepos = 72,
-- 	theme = "Default",
-- 	scale = 1,
-- 	questNPC = false,
-- 	bgr = {
-- 		[1] = 1,
-- 	},
-- 	pos = {
-- 		["rp_southside"] = {Vector(-7569, 1591.5571289063, -31.96875), Angle(0, -1.6722683906555, 0)},
-- 	},
-- 	sequence = "lineidle02",
-- 	scare_anim = {"cower", "crouch_to_stand"},
-- 	scare_timer = 39,
-- 	uselimit = true,
-- 	skin = 1,
-- 	ClModels = {},
-- 	dialogs = {
-- 		[1] = {
-- 			["Line"] = [[Добро пожаловать в салон подержанных автомобилей. Что вас интересует?]],
-- 			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler_night/1.mp3",
-- 			["Answers"] = {
-- 				{
-- 					"Я хочу посмотреть ваши автомобили..", "close", function()
-- 						McCD.OpenGarage(true)
-- 					end
-- 				},
-- 				{
-- 					"Я хочу просмотреть свой гараж..", "close", function()
-- 						net.Start("McCD.Msg")
-- 						net.WriteUInt(0, 3)
-- 						net.WriteBool(false)
-- 						net.SendToServer()
-- 					end
-- 				},
-- 				{"Спасибо, я просто смотрю.", 2,},
-- 			},
-- 		},
-- 		[2] = {
-- 			["Line"] = [[Ночью? Просто смотреть? Будьте добры, покиньте территорию, пока я не вызвал полицию.]],
-- 			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler_night/2.mp3",
-- 			["Answers"] = {
-- 				{"Простите, внутренние часы сбились.", "close",},
-- 				{"Вы открыты для бизнеса. Значит, имею право.", "close",},
-- 				{"А чё такого?", "close",},
-- 			},
-- 		},
-- 		[3] = {
-- 			["Line"] = [[Ночью не сдаём в аренду. Приходите утром.]],
-- 			["Sound"] = "https://macnco.one/cityrp/npcsound/cardealler_night/3.mp3",
-- 			["Answers"] = {
-- 				{"Жаль.", "close",},
-- 			},
-- 		},
-- 	}
-- }

MCS.Spawns["shop1"] = {
	name = "Продавец",
	model = "models/cityrp/pm/normal/male_02.mdl",
	models = {
		{
			model = "models/cityrp/pm/normal/male_02.mdl",
			sequence = "p_town05_radioleanloop",
			submat = {
				[4] = "gbskins/outfit/top_37",
				[8] = "gbskins/outfit/pants_3",
				[9] = "gbskins/outfit/boots_3",
				[0] = "models/gmodbest/citizens/facemaps/ted_facemap4"
			},
		},
		{
			model = "models/cityrp/pm/normal/male_03.mdl",
			sequence = "lineidle02",
			submat = {
				[4] = "gbskins/outfit/top_19",
				[8] = "gbskins/outfit/pants_3",
				[9] = "gbskins/outfit/boots_3",
				[3] = "models/gmodbest/citizens/facemaps/joe_facemap2"
			},
		}
	},
	namepos = 62,
	theme = "Default",
	checkpos = true,
	scale = 1,
	hint = "s",
	vendor = true,
	questNPC = true,
	pos = {
		["rp_southside_noire"] = {Vector(-5898.8852539063, 1540.03125, -15.968799591064), Angle(0, -91.426902770996, 0)},
		["rp_southside"] = {Vector(-5898.8852539063, 1540.03125, -15.968799591064), Angle(0, -91.426902770996, 0)},
	},
	sequence = "p_town05_radioleanloop",
	uselimit = true,
	skin = 1,
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_alarm = 3270,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Здравствуйте. Вам что-то нужно?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/1.mp3",
			["Answers"] = {
				{
					"Хочу посмотреть ассортимент..", "close", function()
						McINV.StoreUINpc("shop")
					end
				},
				{
					"У вас не найдётся подработки?", 2, nil, function()
						if not MQS.CanStartTask("gasstation_port_fridge") or not MQS.CanStartTask("gasstation_port_shelf") or not MQS.CanStartTask("gasstation_port_cleaning") then return false end

						return true
					end
				},
				{
					"У вас не найдётся подработки?", 8, nil, function()
						if not MQS.CanStartTask("gasstation_port_fridge") or not MQS.CanStartTask("gasstation_port_shelf") or not MQS.CanStartTask("gasstation_port_cleaning") then return true end

						return false
					end
				},
				{"Пока просто смотрю, спасибо.", "close"},
			},
		},
		[2] = {
			["Line"] = [[Хм-м.. Да, подработка есть. Сразу скажу - честная работа заслуживает честной оплаты - не очень большой. Нужно заполнить холодильник напитками, разложить товары по полкам и помыть полы. Что-нибудь из этого интересно?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/2.mp3",
			["Answers"] = {
				{
					"Могу заняться всем и сразу.", 3, nil, function()
						if not MQS.CanStartTask("gasstation_port_fridge") or not MQS.CanStartTask("gasstation_port_shelf") or not MQS.CanStartTask("gasstation_port_cleaning") then return false end

						return true
					end
				},
				{
					"Заполню холодильник напитками.", 4, nil, function()
						if not MQS.CanStartTask("gasstation_port_fridge") then return false end

						return true
					end
				},
				{
					"Разложу товары по полкам.", 5, nil, function()
						if not MQS.CanStartTask("gasstation_port_shelf") then return false end

						return true
					end
				},
				{
					"Помою полы.", 6, nil, function()
						if not MQS.CanStartTask("gasstation_port_cleaning") then return false end

						return true
					end
				},
				{"С другой стороны, у меня появились дела поважнее.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Воу. Мне нравится твоё рвение, но не слишком ли много ты на себя берёшь? Не пойми не правильно - я за честную работу, но такими темпами можно перенапрячься и оказаться на больничной койке. Может, выберешь что-то одно?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/3.mp3",
			["Answers"] = {
				{
					"Заполню холодильник напитками.", 4, nil, function()
						if not MQS.CanStartTask("gasstation_port_fridge") then return false end

						return true
					end
				},
				{
					"Разложу товары по полкам.", 5, nil, function()
						if not MQS.CanStartTask("gasstation_port_shelf") then return false end

						return true
					end
				},
				{
					"Помою полы.", 6, nil, function()
						if not MQS.CanStartTask("gasstation_port_cleaning") then return false end

						return true
					end
				},
				{"Тогда я пас.", "close",},
			},
		},
		[4] = {
			["Line"] = [[Отлично. Есть только одна проблема - холодильник сломан. Мастера я уже вызвал, однако товары должны стоять на месте и выглядеть красиво. На улице стоит контейнер со льдом - перед тем как взяться за бутылки, возьми пакет и высыпи кубики на дно. Идёт?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/4.mp3",
			["Answers"] = {
				{
					"Да.", {
						id = "MQS Start quest",
						data = {
							quest_id = "gasstation_port_fridge"
						}
					},
				},
				{"А можно заняться чем-то другим?", 7,},
				{"С другой стороны, у меня появились дела поважнее.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Хорошо. Коробки лежат на складе - сначала разбери их, а содержимое перенеси на полки. Не забудь про ценники!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/5.mp3",
			["Answers"] = {
				{
					"Хорошо.", {
						id = "MQS Start quest",
						data = {
							quest_id = "gasstation_port_shelf"
						}
					},
				},
				{"А можно заняться чем-то другим?", 7,},
				{"С другой стороны, у меня появились дела поважнее.", "close",},
			},
		},
		[6] = {
			["Line"] = [[Швабра с ведром находятся в служебном помещении. Только вот, воды нету. Но это не проблема - на улице стоит контейнер со льдом, лёд растопить на Солнце не сложно.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/6.mp3",
			["Answers"] = {
				{
					"Хорошо.", {
						id = "MQS Start quest",
						data = {
							quest_id = "gasstation_port_cleaning"
						}
					},
				},
				{"А можно заняться чем-то другим?", 7,},
				{"С другой стороны, у меня появились дела поважнее.", "close",},
			},
		},
		[7] = {
			["Line"] = [[Например?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/7.mp3",
			["Answers"] = {
				{
					"Заполню холодильник напитками.", 4, nil, function()
						if not MQS.CanStartTask("gasstation_port_fridge") then return false end

						return true
					end
				},
				{
					"Разложу товары по полкам.", 5, nil, function()
						if not MQS.CanStartTask("gasstation_port_shelf") then return false end

						return true
					end
				},
				{
					"Помою полы.", 6, nil, function()
						if not MQS.CanStartTask("gasstation_port_cleaning") then return false end

						return true
					end
				},
				{"Например, пойду поищу авантюры интереснее.", "close",},
			},
		},
		[8] = {
			["Line"] = [[Извини конечно, но кто тут официально работает - ты или я? Кому платят по-настоящему? Вот и я о том же. Давай как-нибудь попозже?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop1/8.mp3",
			["Answers"] = {
				{"Хорошо.", "close",},
			},
		}
	}
}

MCS.Spawns["shop2"] = {
	name = "Продавец",
	model = "models/cityrp/pm/normal/male_07.mdl",
	models = {
		{
			model = "models/cityrp/pm/normal/male_07.mdl",
			submat = {
				[4] = "gbskins/outfit/top_54",
				[2] = "models/gmodbest/citizens/facemaps/mike_facemap4",
				[8] = "gbskins/outfit/pants_3",
				[9] = "gbskins/outfit/boots_3",
			},
		},
		{
			model = "models/cityrp/pm/normal/male_09.mdl",
			submat = {
				[0] = "models/gmodbest/citizens/facemaps/erdim_facemap4",
				[4] = "gbskins/outfit/top_52",
				[8] = "gbskins/outfit/pants_3",
				[9] = "gbskins/outfit/boots_3",
			},
		},
		{
			model = "models/cityrp/pm/normal/male_04.mdl",
			submat = {
				[2] = "models/gmodbest/citizens/facemaps/eric_facemap10",
				[4] = "gbskins/outfit/top_14",
				[8] = "gbskins/outfit/pants_3",
				[9] = "gbskins/outfit/boots_3",
			},
		}
	},
	namepos = 62,
	theme = "Default",
	scale = 1,
	vendor = true,
	checkpos = true,
	hint = "s",
	questNPC = true,
	pos = {
		["rp_southside_noire"] = {Vector(455.96875, 14000.909179688, 128.03125), Angle(0, 0, 0)},
		["rp_southside"] = {Vector(455.96875, 14000.909179688, 128.03125), Angle(0, 0, 0)},
	},
	sequence = "lineidle02",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_alarm = 3341,
	uselimit = true,
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Здравствуйте. Чем могу помочь?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop2/1.mp3",
			["Answers"] = {
				{
					"Хочу посмотреть ассортимент..", "close", function()
						McINV.StoreUINpc("shop")
					end
				},
				{
					"У вас не найдётся подработки?", 2, nil, function()
						if not MQS.CanStartTask("gasstation_maple_fridge") or not MQS.CanStartTask("gasstation_maple_cleaning") then return false end

						return true
					end
				},
				{
					"У вас не найдётся подработки?", 3, nil, function()
						if not MQS.CanStartTask("gasstation_maple_fridge") or not MQS.CanStartTask("gasstation_maple_cleaning") then return true end

						return false
					end
				},
				{"Пока просто смотрю, спасибо.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Хм-м.. Да, подработка есть. Сразу скажу - честная работа заслуживает честной оплаты - не очень большой. Нужно заполнить холодильники напитками и помыть полы. Что-нибудь из этого интересно?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop2/2.mp3",
			["Answers"] = {
				{
					"Заполню холодильник напитками.", 4, nil, function()
						if not MQS.CanStartTask("gasstation_maple_fridge") then return false end

						return true
					end
				},
				{
					"Помою полы.", 5, nil, function()
						if not MQS.CanStartTask("gasstation_maple_cleaning") then return false end

						return true
					end
				},
				{"С другой стороны, у меня появились дела поважнее.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Извини конечно, но кто тут официально работает - ты или я? Кому платят по-настоящему? Вот и я о том же. Давай как-нибудь попозже?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop2/3.mp3",
			["Answers"] = {
				{"Хорошо.", "close",},
			},
		},
		[4] = {
			["Line"] = [[Отлично. Есть только одна проблема - холодильники сломаны. Мастера я уже вызвал, однако товары должны стоять на месте и выглядеть красиво. На улице стоит контейнер со льдом - перед тем как взяться за бутылки, возьми пакет и высыпи кубики на дно. Идёт?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop2/4.mp3",
			["Answers"] = {
				{
					"Да.", {
						id = "MQS Start quest",
						data = {
							quest_id = "gasstation_maple_fridge"
						}
					},
				},
				{"А можно заняться чем-то другим?", 6,},
				{"С другой стороны, у меня появились дела поважнее.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Швабра с ведром находятся в служебном помещении. Только вот, воды нету. Но это не проблема - на улице стоит контейнер со льдом, лёд растопить на Солнце не сложно.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop2/5.mp3",
			["Answers"] = {
				{
					"Хорошо.", {
						id = "MQS Start quest",
						data = {
							quest_id = "gasstation_maple_cleaning"
						}
					},
				},
				{"А можно заняться чем-то другим?", 6,},
				{"С другой стороны, у меня появились дела поважнее.", "close",},
			},
		},
		[6] = {
			["Line"] = [[Например?]],
			["Sound"] = "",
			["Answers"] = {
				{
					"Заполню холодильник напитками.", 4, nil, function()
						if not MQS.CanStartTask("gasstation_maple_fridge") then return false end

						return true
					end
				},
				{
					"Помою полы.", 5, nil, function()
						if not MQS.CanStartTask("gasstation_maple_cleaning") then return false end

						return true
					end
				},
				{"Например, пойду поищу авантюры интереснее.", "close",},
			},
		}
	}
}

MCS.Spawns["shop3"] = {
	name = "Продавец",
	model = "models/cityrp/pm/normal/male_08.mdl",
	submat = {
		[4] = "gbskins/outfit/top_22",
		[8] = "gbskins/outfit/pants_3",
		[9] = "gbskins/outfit/boots_3",
		[0] = "models/gmodbest/citizens/facemaps/vance_facemap2"
	},
	namepos = 80,
	theme = "Default",
	checkpos = true,
	scale = 1,
	vendor = true,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(1339.6507568359, -1572.03125, -95.96875), Angle(0, 90, 0)},
	},
	sequence = "lineidle02",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_alarm = 3340,
	uselimit = true,
	skin = 0,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Не стесняйтесь, рассматривайте товары не только глазами!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop3/1.mp3",
			["SoundVolume"] = 0.5,
			["Answers"] = {
				{
					"Хочу посмотреть ассортимент..", "close", function()
						McINV.StoreUINpc("hardware")
					end
				},
				{"У вас не найдётся подработки?", 2,},
				{"Это вы продали холодильники местным заправщикам?", 3, nil, function() return MQS.QuestStatusCheck("gasstation_maple_fridge") or MQS.QuestStatusCheck("gasstation_port_fridge") end},
				{"Пока просто смотрю, спасибо.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Прости, у меня для тебя ничего нет. Бизнес цветёт так сильно, что даже мусор толком не копится.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop3/2.mp3",
			["SoundVolume"] = 0.5,
			["Answers"] = {
				{"Жадина.", "close",},
				{"Хорошо.", "close",},
				{"Надеюсь, всё продолжится в том же направлении.", "close",},
			},
		},
		[3] = {
			["Line"] = [[..Опять? Я же столько раз просил перестать обращаться по этому поводу! Это не мои холодильники - мои никогда не перегорают, тем более так часто и так глупо! ..Вы на своей инициативе пришли, что-ли? Сколько вас ещё таких? Вы деда доведёте..!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop3/3.mp3",
			["SoundVolume"] = 0.5,
			["Answers"] = {
				{"Простите.", "close",},
			},
		},
	}
}

MCS.Spawns["shop3_n"] = {
	name = "Продавец",
	model = "models/cityrp/pm/normal/male_05.mdl",
	submat = {
		[4] = "gbskins/outfit/top_54",
		[8] = "gbskins/outfit/pants_54",
		[9] = "gbskins/outfit/boots_3",
		[3] = "models/gmodbest/citizens/facemaps/art_facemap3"
	},
	namepos = 80,
	theme = "Default",
	checkpos = true,
	scale = 1,
	vendor = true,
	questNPC = false,
	pos = {
		["rp_southside"] = {Vector(1339.6507568359, -1572.03125, -95.96875), Angle(0, 90, 0)},
	},
	sequence = "lineidle01",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_alarm = 4298,
	uselimit = true,
	skin = 0,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Ещё один.. Что-то хотели?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_worker/shop1.mp3",
			["SoundVolume"] = 0.5,
			["Answers"] = {
				{
					"Хочу посмотреть ассортимент..", "close", function()
						McINV.StoreUINpc("hardware")
					end
				},
				{"У вас не найдётся подработки?", 2,},
				{"Пока просто смотрю, спасибо.", 3,},
			},
		},
		[2] = {
			["Line"] = [[Сам подрабатываю. Устал уже. Или закупайся, или не отвлекай от ничегонеделанья.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_worker/shop2.mp3",
			["SoundVolume"] = 0.5,
			["Answers"] = {
				{
					"Хочу посмотреть ассортимент..", "close", function()
						McINV.StoreUINpc("hardware")
					end
				},
				{"Удачи тогда.", 3,},
			},
		},
		[3] = {
			["Line"] = [[Серьёзно?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/season_worker/shop3.mp3",
			["SoundVolume"] = 0.5,
			["Answers"] = {
				{"...", "close",},
			},
		},
	}
}

MCS.Spawns["shop4"] = {
	name = "Продавец",
	model = "models/cityrp/pm/normal/female_06.mdl",
	submat = {
		[0] = "models/gmodbest/citizens/facemaps/naomi_facemap2",
		[4] = "gbskins/outfit/top_88",
		[6] = "gbskins/coat/sheet_8",
		[11] = "gbskins/wboots/sheet_4",
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	checkpos = true,
	vendor = true,
	pos = {
		["rp_southside_noire"] = {Vector(-2166.7412109375, 10536.314453125, 128.03125), Angle(0, 64, 0)},
		["rp_southside"] = {Vector(-2166.7412109375, 10536.314453125, 128.03125), Angle(0, 64, 0)},
	},
	sequence = "lineidle01",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_alarm = 3338,
	uselimit = true,
	skin = 0,
	bgr = {
		[2] = 1,
	},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Йоу! Чё кого? Велкам в Urban Outfits! У нас самые модные тряпки - подойдут даже если у тя одни лапки! Ща мы те чё нить трендовое подберём, все-все на районе завидовать будут! Ты ведь за новым прикидом, или так, зенки таращить?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/1.mp3",
			["Answers"] = {
				{
					"Я хочу купить новую одежду.", "close", function()
						MCR.OpenShop()
					end
				},
				{
					"Хочу посмотреть аксессуары..", "close", function()
						McINV.StoreUINpc("urban")
					end
				},
				{"Чего-чего?", 2,},
				{
					"У вас не найдётся подработки?", 4, function() end, function()
						if not MQS.CanStartTask("urban_sorting") or not MQS.CanStartTask("urban_unload") then return false end

						return true
					end
				},
				{
					"У вас не найдётся подработки?", 9, function() end, function()
						if not MQS.CanStartTask("urban_sorting") or not MQS.CanStartTask("urban_unload") then return true end

						return false
					end
				},
				{"Пока просто смотрю, спасибо.", "close",},
			},
		},
		[2] = {
			["Line"] = [[..Говорю, шмотки новые хочешь или ты существо из вида 'гомо просто-смотрюпиенс'?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/2.mp3",
			["Answers"] = {
				{
					"Хочу купить новую одежду.", "close", function()
						MCR.OpenShop()
					end
				},
				{"Просто смотрю.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Э! Кыш! Ди отсюда! Ты грязнее чем мои подмышки, уйди! Противный! Бомжара! Кто-нибудь, вызовите полицию!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/3.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[4] = {
			["Line"] = [[А мне тогда как зарабатывать? ..Это типа подкуп лени такой?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/4.mp3",
			["Answers"] = {
				{"Может быть.", 5,},
				{"Я не понимаю ваш молодёжный сленг.", 5,},
				{"Больше не интересует, до свидания.", "close",},
			},
		},
		[5] = {
			["Line"] = [[..Короче, мне влом уходить с прилавка, а дел буквально целая гора. Эт одна из задач - сложить чтоб на прилавки сразу бросить. Ещё доставку прини- ..А, стоп, там уже - надо только разобрать и на продажу. Будешь чё?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/5.mp3",
			["Answers"] = {
				{"Сложу разбросанную одежду.", 6,},
				{"Разложу одежду по стендам", 7,},
				{"Как-то не интересно.", "close",},
			},
		},
		[6] = {
			["Line"] = [[Кинь короче всё под стол в служебке, а оттуда уже на столе собирай. Сразу говорю - плачу немного, а то так ваще не накоплю на телефон от Микроник.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/6.mp3",
			["Answers"] = {
				{
					"Хорошо.", {
						id = "MQS Start quest",
						data = {
							quest_id = "urban_sorting"
						}
					},
				},
				{"А можно заняться чем-то другим?", 8,},
				{"Немного? Тогда не надо.", "close",},
			},
		},
		[7] = {
			["Line"] = [[Там коробки надо сначала вскрыть, а дальше кидай куда по стилю зайдёт. Сразу говорю - плачу немного, а то так ваще не накоплю на телефон от Микроник.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/7.mp3",
			["Answers"] = {
				{
					"Хорошо.", {
						id = "MQS Start quest",
						data = {
							quest_id = "urban_unload"
						}
					},
				},
				{"А можно заняться чем-то другим?", 8,},
				{"Немного? Тогда не надо.", "close",},
			},
		},
		[8] = {
			["Line"] = [[Ну?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/8.mp3",
			["Answers"] = {
				{"Сложу разбросанную одежду.", 6,},
				{"Разложу одежду по стендам", 7,},
				{"Поищу что-то с платой, от какой не загнусь.", "close",},
			},
		},
		[9] = {
			["Line"] = [[Эй! Меня уволят за такое! Не-не-не!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shop4/9.mp3",
			["Answers"] = {
				{"Извините.", "close",},
			},
		},
	}
}

MCS.Spawns["bank"] = {
	name = "Джеймс Дэниэл",
	desc = "Работник Складов",
	model = "models/cityrp/pm/normal/male_01.mdl",
	namepos = 77,
	boneid = 6,
	theme = "Default",
	checkpos = true,
	scale = 1,
	hint = "u",
	questNPC = true,
	pos = {
		["rp_southside_noire"] = {Vector(500.71875,-5573.90625,-319.62677001953), Angle(0,90,0)},
		["rp_southside"] = {Vector(-500, -5555, -305.1), Angle(0, -20, 0)},
	},
	sequence = "d1_t01_breakroom_sit01_idle",
	scare_anim = {"cower", "idle_to_d1_t01_breakroom_sit01"},
	scare_timer = 41,
	uselimit = true,
	skin = 1,
	bgr = {},
	submat = {
		[4] = "gbskins/outfit/top_744",
		[8] = "gbskins/outfit/pants_744",
		[9] = "gbskins/outfit/boots_3"
	},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Хм-м.. Чем могу помочь?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/bank/1.mp3",
			["Animation"] = "d1_t01_breakroom_sit01_to_idle",
			["Answers"] = {
				{"Я по поводу моего хранилища..", 2},
				{"Пока просто смотрю, спасибо.", "close", nil, nil, "idle_to_d1_t01_breakroom_sit01"},
			},
		},
		[2] = {
			["Line"] = [[..Вам нужен доступ в хранилище, или хотите увеличить его размер?]],
			["Gestures"] = {
				{"g_righthandpoint", 0.2},
				{"g_look_small", 2.2}
			},
			["Sound"] = "https://macnco.one/cityrp/npcsound/bank/2.mp3",
			["Answers"] = {
				{
					"Хочу получить доступ к хранилищу.", "Get Unit", function()
						--McINV.CreateBankUI()
					end,
					nil, "idle_to_d1_t01_breakroom_sit01"
				},
				{
					"Хотелось бы увеличить хранилище.", "close", function()
						McINV.StorageUpgrade()
					end,
					nil, "idle_to_d1_t01_breakroom_sit01"
				},
				{"С другой стороны, у меня появились дела поважнее.", "close", nil, nil, "idle_to_d1_t01_breakroom_sit01"},
			},
		},
	}
}

MCS.Spawns["junkyard_temp"] = {
	name = "Рамон Колби",
	model = "models/cityrp/pm/normal/male_02.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(2859.21875,-1477.84375,-125.03125), Angle(0,133.96179199219,0)},
		["rp_southside"] = {Vector(2998.875, -1402.53125, -125.0625), Angle(0, -151.41357421875, 0)},
	},
	sequence = "sitccouchtv1",
	uselimit = false,
	skin = 0,
	bgr = {},
	submat = {
		[0] = "models/gmodbest/citizens/facemaps/ted_facemap11",
		[4] = "gbskins/outfit/top_53",
		[8] = "gbskins/outfit/pants_63",
		[9] = "gbskins/outfit/boots_3",
	},
	teams = {
		[2] = 11,
		[4] = 5,
		[5] = 5,
		[6] = 5,
		[7] = 5,
		[19] = 5,
	},
	dialogs = {
		[1] = {
			["Line"] = [[Да-да, я слушаю.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/1.mp3",
			["Answers"] = {
				{"Здравствуйте. А что тут находится?", 2,},
				{
					"У вас не найдётся подработки?", "close", function()
						DarkRP.OpenJobMenuRamon()
					end
				},
				{"Мне пора.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Таки глазеньки разуй - тут городская свалка. Мы разбираем мусор и делаем город чище. Не кошерно оттаки обычным работягам эту ношу тянуть..]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/2.mp3",
			["Answers"] = {
				{"Обычным работягам? То есть, город вас не поддерживает?", 3,},
				{"Понятно, мне не сюда. Спасибо за объяснение.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Таки да. Город уже давно ничегошеньки сам не делает. Послушай тех шлимазлов из World Corp - сразу поймёшь о чём я талдычу. ..О чём мы все тут мычим, точнее. Никому это не нравится, мы на честном слове кое-как барахтаемся.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/3.mp3",
			["Answers"] = {
				{"А откуда у вас тогда деньги всем платить?", 4,},
				{"И вправду тяжело. Простите, ничем не могу вам помочь.", "close",},
			},
		},
		[4] = {
			["Line"] = [[В том то и дело, что денег нет! Идише горбатимся на износ! Едим с одной тарелки! Иногда жертвуют неравнодушные, оттаки редкость несусветная. Таки никто не хочет ассоциироватеся себя с говночистом. При этом все в них нуждаются каждую секунду. Лицемерие!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/4.mp3",
			["Answers"] = {
				{
					"Как-то страшно спрашивать теперь, но у вас не найдётся подработки?", "close", function()
						DarkRP.OpenJobMenuRamon()
					end,
					function() return LocalPlayer():Team() == 1 end
				},
				{"Ужас какой. Тогда не буду вас отвлекать. Удачи вам!", "close",},
			},
		},
		[5] = {
			["Line"] = [[..Что, опять? Идише урл кецл? Вам что ли тута мёдом помазано?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/5.mp3",
			["Answers"] = {
				{"Как вы смеете так разговаривать с офицером полиции?", 6,},
				{"Простите, уже ухожу.", "close",},
			},
		},
		[6] = {
			["Line"] = [[Нет, это как вы смеете так относитеся к простым рабочим?! Мы и так пашем без выходных, а вы ещё Соломонами себя возомнили! Такие умные, всё про всех знают: то мы якобы воруем, то всякие заговоры шифруем, а вы самые честные и чистые..!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/6.mp3",
			["Answers"] = {
				{"Это опасный район. В Бруклине постоянно происходят преступления. Машины воруют, например.", 7,},
				{"Простите, уже ухожу.", "close",},
			},
		},
		[7] = {
			["Line"] = [[И поэтому вы каждый будний день копаетесь в нашем белье? А если к вам домой сшабашатеся без ордера и будут кричать 'лицом к стене', да 'у мене друже наркоман, я знаю как пахнут наркотики'? Думаете, по адвокатам бегать будете? Хозар с два!

Обидетеся и будете выть похлеще мусульманских молитв; таки проходили уже. Почему-то вас не обвиняют в антисемитизме после дикого гона в нашу сторону, така какого хера вы тепере нас башляете за честное гражданинское?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/7.mp3",
			["Answers"] = {
				{"...", 8,},
				{"..Чего?", 8,},
				{"Я еврейский не понимаю, можно на английском?", 8,},
			},
		},
		[8] = {
			["Line"] = [[..Вот об этом я и говорю. Гой, мы таки народ простой - просто выйдем на улицы всем коллективом и остановитеся вся городская инфраструктура. Что дальше будете делать? Продолжите ставить к стене, или задумаетеся наконец? ..Чтоб без ордера с адекватной причиной больше не приходили!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/8.mp3",
			["Answers"] = {
				{"Простите, уже ухожу.", "close",},
			},
		},
		[9] = {
			["Line"] = [[Вам что сказали? Пошли вон отсюда!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/9.mp3",
			["Answers"] = {
				{"Да я не по работе!", 10,},
				{"...", "close",},
			},
		},
		[10] = {
			["Line"] = [[Пошли вон отсюда!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/10.mp3",
			["Answers"] = {
				{"Я тут не по работе!", 10,},
				{"...", "close",},
			},
		},
		[11] = {
			["Line"] = [[Да-да, я слушаю.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/1.mp3",
			["Answers"] = {
				{
					"Здравствуйте. А что тут находится?", 2, nil, function()
						if not MQS.QuestStatusCheck("criminal_8_revelation") then return true end

						return not LocalPlayer().MQSdata.Stored["omon"] or LocalPlayer().MQSdata.Stored["omon"] < 1
					end
				},
				{
					"У вас не найдётся подработки?", 12, nil, function()
						if not MQS.QuestStatusCheck("criminal_8_revelation") then return false end

						return not LocalPlayer().MQSdata.Stored["omon"] or LocalPlayer().MQSdata.Stored["omon"] < 1
					end
				},
				{
					"У меня есть машина, хочу её сдать.", 23, nil, function()
						if not MQS.QuestStatusCheck("criminal_8_revelation") then return false end

						return LocalPlayer().MQSdata.Stored["omon"] and LocalPlayer().MQSdata.Stored["omon"] == 1
					end
				},
				{"Мне пора.", "close",},
			},
		},
		[12] = {
			["Line"] = [[А вы таки шо думаете?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/12.mp3",
			["Answers"] = {
				{"В смысле?", 13,},
				{"..Пойду-ка я отсюда.", "close",},
			},
		},
		[13] = {
			["Line"] = [[В смысле 'в смысле'? Это какая-то новая хохма?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/13.mp3",
			["Answers"] = {
				{"Я не понимаю о чём вы.", 14,},
				{"..Пойду-ка я отсюда.", "close",},
			},
		},
		[14] = {
			["Line"] = [[..Ну и шестёрки нынче пошли. Вам типа не говорят ничего, или это новый уличный кецл?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/14.mp3",
			["Answers"] = {
				{"..Подожди, ты о ком? Ты 'прилизанный'?", 15,},
			},
		},
		[15] = {
			["Line"] = [[Вот при нём точно так не выражайтеся. Не 'прилизанный', а Сутенёр-по-Имени-Прилизанный. Целиком всё вместе. Уважате надо старших!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/15.mp3",
			["Answers"] = {
				{"Так это ты?", 16,},
				{"Так ты его знаешь?", 17,},
			},
		},
		[16] = {
			["Line"] = [[Нет конечно. Разве это я ношу фиолетовый пиджак да шляпу с пером? Не кошерно таки наряжатеся.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/16.mp3",
			["Answers"] = {
				{"Получается, этот бизнес всё же как-то связан с этим Сутенёром?", 18,},
			},
		},
		[17] = {
			["Line"] = [[Естественно! А ты думаешь, чего я к тебе как к мишигину обращаюсь? Всё даже хуже оказалось..]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/17.mp3",
			["Answers"] = {
				{"Получается, этот бизнес всё же как-то связан с этим Сутенёром?", 18,},
			},
		},
		[18] = {
			["Line"] = [[Типа того. Мы не некейвами конечно занимаемся, хотя кому как. Людей машины интересуют как шиксы, а нам тоже надо на что-то жить. Вот мы и объединили усилия. Понимаешь, да?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/18.mp3",
			["Answers"] = {
				{"Да.", 19,},
				{"Нет.", 22,},
			},
		},
		[19] = {
			["Line"] = [[Вот и отлично. Можешь привозить сюда бесхозные машины, а мы дальше разберёмся. Тока это, не веди за собой хвост, а то шейгец а лох ин коп, да?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/19.mp3",
			["Answers"] = {
				{"Разумеется. До встречи.", "Omon_give",},
				{"Что-что?", 20,},
			},
		},
		[20] = {
			["Line"] = [[Говорю, плохо будет. Копам нельзя об этом знать.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/20.mp3",
			["Answers"] = {
				{"А, так это элементарно. До встречи.", "Omon_give",},
				{"Слушай, с твоим языком любой детектив сам обо всём догадается.", 21,},
			},
		},
		[21] = {
			["Line"] = [[Холоймыс, тшува. Сколько стою, и ничего. Не первый шаббат живу.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/21.mp3",
			["Answers"] = {
				{"..Как скажешь. Удачи.", "Omon_give",},
			},
		},
		[22] = {
			["Line"] = [[Господи, дай мне сил! ..Привози сюда бесхозные машины, а мы дальше разберёмся. Тока надеюсь у тебе мозгов хватит хотя бы полицию сюда не вести. А то шейгец а лох ин коп, да?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/junkyard_temp/22.mp3",
			["Answers"] = {
				{"А, так это элементарно. До встречи.", "Omon_give",},
				{"Слушай, с твоим языком любой детектив сам обо всём догадается.", 21,},
			},
		},
		[23] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Formater_SV"] = function(ply) return McCD.ChopShop(ply, true) end,
			["Answers"] = {
				{"По рукам!", "ChopShop", nil, function() return false end},
				{"...", "close"},
			},
		},
	}
}

if math.random(5) == 1 then
	MCS.Spawns["bank"].name = "Нэйт Додж"
	MCS.Spawns["bank"].model = "models/cityrp/pm/normal/male_04.mdl"
	MCS.Spawns["bank"].submat[2] = "models/gmodbest/citizens/facemaps/eric_facemap3"
end

MCS.Spawns["coltrdm"] = {
	name = "Кольт Магнуссон",
	desc = "Работник RDM",
	checkpos = true,
	model = "models/cityrp/pm/normal/male_06.mdl",
	submat = {
		[1] = "models/gmodbest/citizens/facemaps/sandro_facemap11",
		[4] = "gbskins/outfit/top_80",
		[8] = "gbskins/outfit/pants_57",
		[9] = "gbskins/outfit/boots_3",
	},
	namepos = 80,
	theme = "Default",
	hasinv = {1000, "Склад RDM"},
	extras = {
		RDMContract = true,
	},
	scale = 1,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(681.03125,-5587.25,-318.90625), Angle(0,124,0)},
	},
	sequence = "d1_t01_breakroom_sit02",
	uselimit = false,
	bgr = {
		[1] = 1,
	},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Здравствуйте. Все условия контрактов перечислены на официальном сайте Rhode Defence Manufacturer.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/rdm.mp3",
			["Answers"] = {
				{"Я хочу сдать товар по контракту.", "Loot Npc", nil, function() return LocalPlayer():Team() == 9 end},
				{"Это не ко мне, до свидания.", "close",},
			},
		},
	}
}