--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/phone_all.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["phone_convos_all"] = {
	name = "Телефон",
	model = "models/props_trainstation/payphone001a.mdl",
	namepos = 80,
	theme = "Phone",
	scale = 1,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(-283.73333740234,-1613.015625,4537.03125), Angle(0, -90, 0)},
	},
	sequence = "",
	uselimit = false,
	ignore = true,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		-- JOE BABUZ
		[1] = {
			["Line"] = [[Алё!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/1.mp3",
			["Answers"] = {
				{"Алло.", 2,},
				{"Здравствуйте. Я по работе.", 3,},
				{"Здарова. Это я.", 4,},
			},
		},
		[2] = {
			["Line"] = [[По работе?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/2.mp3",
			["Answers"] = {
				{"Да.", 3,},
				{"Вроде. Это же к вам?", 3,},
			},
		},
		[3] = {
			["Line"] = [[13-я улица, дом 4. Квартира под лестницей, найдёшь.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/3.mp3",
			["Answers"] = {
				{"Окей.", "MQS Continue quest",},
				{"Хорошо. До свидания.", "MQS Continue quest",},
				{"Что за работа хоть меня ждёт?", 5,},
			},
		},
		[4] = {
			["Line"] = [[Кто 'ты'?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/4.mp3",
			["Answers"] = {
				{"По работе.", 3,},
				{"Ты мне смс писал. Работа.", 3,},
			},
		},
		[5] = {
			["Line"] = [[Это уже на месте.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/5.mp3",
			["Answers"] = {
				{"Ладно.", "MQS Continue quest",},
				{"13-я улица, дом 4. Хорошо.", "MQS Continue quest",},
				{"Мне это не нравится..", "MQS Continue quest",},
			},
		},
		[6] = {
			["Line"] = [[Алё!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/6.mp3",
			["Answers"] = {
				{"Алло, это я.", 7,},
				{"Алло, я по делу.", 7,},
				{"Алло. Нужно что сделать?", 7,},
			},
		},
		[7] = {
			["Line"] = [[Ага. Тащись за фургоном на гео-метку, надо химии с инструментами закупить. Как достанешь - вези на хату.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/7.mp3",
			["Answers"] = {
				{"Окей.", 9,},
				{"Где?", 8,},
				{"Не опасно?", 10,},
			},
		},
		[8] = {
			["Line"] = [[Свой поц есть, в хоз. товарах работает. В бардачке наличка, ему передашь.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/8.mp3",
			["Answers"] = {
				{"Окей.", "MQS Continue quest",},
			},
		},
		[9] = {
			["Line"] = [[В бардачке наличка, передашь куда надо.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/9.mp3",
			["Answers"] = {
				{"Ага.", "MQS Continue quest",},
			},
		},
		[10] = {
			["Line"] = [[Да не ссы, там поц свой. Еси очкуешь - ствол возьми. В бардачке наличка, ему передашь.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/10.mp3",
			["Answers"] = {
				{"Окей.", "MQS Continue quest",},
			},
		},
		[11] = {
			["Line"] = [[Алё. Не телефонный разговор, дуй ко мне.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/11.mp3",
			["Answers"] = {
				{"Уже бегу.", "MQS Continue quest",},
				{"Что случилось?", 12,},
				{"Это не может подождать?", 13,},
			},
		},
		[12] = {
			["Line"] = [[Я-ж сказал!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/12.mp3",
			["Answers"] = {
				{"Еду.", "MQS Continue quest",},
				{"Это не может подождать?", 13,},
			},
		},
		[13] = {
			["Line"] = [[Не может.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/13.mp3",
			["Answers"] = {
				{"Еду.", "MQS Continue quest",},
			},
		},
		[14] = {
			["Line"] = [[Алё. Твой выход, пора делать деньги.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/14.mp3",
			["Answers"] = {
				{"Клиент согласился на сделку?", 16,},
				{"Что от меня требуется?", 15,},
				{"Пора.", 15,},
			},
		},
		[15] = {
			["Line"] = [[Едь ко мне, бери фургон, и дуй на стоянку в длинном тоннеле. Багажник уже набит. Ещё это, возьми с собой личную пушку да патронов побольше.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/15.mp3",
			["Answers"] = {
				{"Ты ожидаешь подвоха?", 17,},
				{"Нас ждут проблемы?", 17,},
				{"Думаешь убить двух зайцев одним камнем?", 17,},
			},
		},
		[16] = {
			["Line"] = [[Да. Едь ко мне, бери фургон, и дуй на стоянку в длинном тоннеле. Багажник уже набит. Ещё это, возьми с собой личную пушку да патронов побольше.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/16.mp3",
			["Answers"] = {
				{"Ты ожидаешь подвоха?", 17,},
				{"Нас ждут проблемы?", 17,},
				{"Думаешь убить двух зайцев одним камнем?", 17,},
			},
		},
		[17] = {
			["Line"] = [[Никогда не знаешь шо этот котяра учудит. Эл тип мутный. Не так зырнешь - зырки твои в витрине окажутся.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/17.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Можешь на меня расчитывать.", "MQS Continue quest",},
				{"У меня нет пушки. Что делать?", 18,},
			},
		},
		[18] = {
			["Line"] = [[Купи.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/18.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Можешь на меня расчитывать.", "MQS Continue quest",},
				{"Жадина.", "MQS Continue quest",},
			},
		},
		[19] = {
			["Line"] = [[Алё.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/19.mp3",
			["CallBackRun"] = function()
				McPhone.OverlayMenu.PhoneType = 3
			end,
			["Answers"] = {
				{"Алло, это я.", 20,},
				{"Пиздец.", 21,},
				{"Нас надули. Не Эллиот - его подельник, с кем мы работали. Он за спиной у босса хотел дела вести.", 22,},
			},
		},
		[20] = {
			["Line"] = [[О, здарова! Чё там, как дела?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/20.mp3",
			["Answers"] = {
				{"Пиздец.", 21,},
				{"Нас надули.", 21,},
				{"Этот тип хотел использовать нас, чтобы Эллиота в делах сместить. Теперь мы ему должны.", 22,},
			},
		},
		[21] = {
			["Line"] = [[Чё? Чё случилось?!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/21.mp3",
			["Answers"] = {
				{"Мы теперь должны Эллиоту.", 24,},
				{"Этот тип за спиной у Эллиота промышлял. Меня за это чуть не убили.", 22,},
				{"Я тоже ничего не понимаю. Этот еблан рубашечный своих перекромсал за какой-то косяк.", 24,},
			},
		},
		[22] = {
			["Line"] = [[Пиздец он утюг.. чё теперь?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/22.mp3",
			["Answers"] = {
				{"Тебе позвонят. Готовься к большим заказам. Не оплачиваемым.", 23,},
			},
		},
		[23] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "MQS Continue quest",},
				{"Прости.", "MQS Continue quest",},
				{"Так только на первое время.", "MQS Continue quest",},
				{"Это не моя вина.", "MQS Continue quest",},
				{"Нам надо нарастить поставки, если мы реально хотим выжить.", "MQS Continue quest",},
			},
		},
		[24] = {
			["Line"] = [[В смысле? Чё там случилось?!]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/24.mp3",
			["Answers"] = {
				{"Да нас использовали, 'типа' мы для Эллиота работаем. Эллиот об этом узнал - и теперь мы реально на него работаем.", 22,},
			},
		},
		[25] = {
			["Line"] = [[Алё. У меня закончился материал. Понимаешь же к чему я?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/25.mp3",
			["Answers"] = {
				{"Да.", 27,},
				{"Химикаты?", 26,},
				{"Пушки?", 30,},
			},
		},
		[26] = {
			["Line"] = [[Нет, материал. То над чем сама работа ведётся. Смож помочь с этим?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/26.mp3",
			["Answers"] = {
				{"Попробую.", 27,},
				{"Смотря что требуется.", 29,},
			},
		},
		[27] = {
			["Line"] = [[Отлично. Я еси чё уже договорился с ребятами, те надо тока забрать товар. Дуй на моём фургоне на улицу Ривер на пирс, там лодка ждёт. Дальше поймёшь.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/27.mp3",
			["Answers"] = {
				{"Хорошо.", 28,},
				{"Мне ждать подвоха?", 28,},
			},
		},
		[28] = {
			["Line"] = [[Не забудь взять ствол. Запасись водой. Никогда не знаешь чё ждать от тех котов. Или от незваных гостей, чё уж.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/28.mp3",
			["Answers"] = {
				{"Без проблем.", "MQS Continue quest",},
				{"Спасибо за совет.", "MQS Continue quest",},
				{"Во что же мы ввязались..", "MQS Continue quest",},
			},
		},
		[29] = {
			["Line"] = [[Короче, я с ребятами уже договорился, те надо тока товар забрать. Дуй на моём фургоне на улицу Ривер на пирс, там лодка ждёт. Дальше поймёшь.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/29.mp3",
			["Answers"] = {
				{"Хорошо.", 28,},
				{"Мне ждать подвоха?", 28,},
			},
		},
		[30] = {
			["Line"] = [[Ты такими словами по телефону не бросайся, да?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/30.mp3",
			["Answers"] = {
				{"Это шутка такая.", 32,},
				{"Брось, это паранойя.", 32,},
				{"А то чё?", 31,},
			},
		},
		[31] = {
			["Line"] = [[А то вот чё.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/31.mp3",
			["Answers"] = {
				{"Постой..!", "MQS Fail quest",},
			},
		},
		[32] = {
			["Line"] = [[Параноики остаются параноиками тока пока чё нить не случится. ..Короче, я уже договорился с ребятами, так что дуй на моём фургоне на улицу Ривер. Там на пирсе лодка ждёт. Дальше поймёшь.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/32.mp3",
			["Answers"] = {
				{"Хорошо.", 33,},
				{"Мне ждать подвоха?", 34,},
			},
		},
		[33] = {
			["Line"] = [[Не забудь взять ствол. Он точно пригодится.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/33.mp3",
			["Answers"] = {
				{
					"Ага.", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "season1_criminal_5"
						}
					},
				},
				{
					"Спасибо за совет.", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "season1_criminal_5"
						}
					},
				},
				{
					"Во что же мы ввязались..", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "season1_criminal_5"
						}
					},
				},
			},
		},
		[34] = {
			["Line"] = [[После таких слов - точно. Возьми ствол.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/34.mp3",
			["Answers"] = {
				{
					"Ага.", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "season1_criminal_5"
						}
					},
				},
				{
					"Спасибо за совет.", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "season1_criminal_5"
						}
					},
				},
				{
					"Во что же мы ввязались..", {
						id = "MQS Skip to",
						data = {
							id = 86,
							quest_id = "season1_criminal_5"
						}
					},
				},
			},
		},
		[35] = {
			["Line"] = [[Алё. Чё-то случилось?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/35.mp3",
			["CallBackRun"] = function()
				McPhone.OverlayMenu.PhoneType = 3
			end,
			["Answers"] = {
				{"Меня ждали. Ещё чуть-чуть - и потянули бы за удочку.", 36,},
			},
		},
		[36] = {
			["Line"] = [[Никто больше не пришёл?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/36.mp3",
			["Answers"] = {
				{"Нет. Только берега.", 37,},
			},
		},
		[37] = {
			["Line"] = [[Машина?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/37.mp3",
			["Answers"] = {
				{"Там же.", 38,},
			},
		},
		[38] = {
			["Line"] = [[Ты это, молодец. Держи в курсе еси чё.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/38.mp3",
			["Answers"] = {
				{"Обязательно.", "MQS Continue quest",},
			},
		},
		-- FDNY INSPECTOR
		[39] = {
			["Line"] = [[Добрый день.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/39.mp3",
			["Answers"] = {
				{"Алло.", 40,},
				{"Добрый.", 40,},
				{"Это Марк?", 41,},
			},
		},
		[40] = {
			["Line"] = [[Вы по рекомендации звоните?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/40.mp3",
			["Answers"] = {
				{"Да.", 42,},
			},
		},
		[41] = {
			["Line"] = [[Да. Вы по рекомендации звоните?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/41.mp3",
			["Answers"] = {
				{"Да.", 42,},
			},
		},
		[42] = {
			["Line"] = [[..Вы в порядке? Не болеете?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/42.mp3",
			["Answers"] = {
				{"Нет.", 43,},
				{"С чего вы взяли?", 44,},
				{"Вы ожидали услышать кого-то другого?", 45,},
			},
		},
		[43] = {
			["Line"] = [[И не болейте. ..Сможете сегодня приехать на улицу Виски, дом 4?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/43.mp3",
			["Answers"] = {
				{"Могу.", 46,},
				{"Да.", 46,},
			},
		},
		[44] = {
			["Line"] = [[Ваш голос. Не болейте. ..Сможете сегодня приехать на улицу Виски, дом 4?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/44.mp3",
			["Answers"] = {
				{"Могу.", 46,},
				{"Да.", 46,},
			},
		},
		[45] = {
			["Line"] = [[Нет, я ожидал кого-то настолько внимательного. ..Сможете сегодня приехать на улицу Виски, дом 4?]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/45.mp3",
			["Answers"] = {
				{"Могу.", 46,},
				{"Да.", 46,},
			},
		},
		[46] = {
			["Line"] = [[Тогда жду вас там. До свидания.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/46.mp3",
			["Answers"] = {
				{"Удачи.", "MQS Continue quest",},
				{"Хорошо.", "MQS Continue quest",},
				{"До свидания.", "MQS Continue quest",},
			},
		},
		[47] = {
			["Line"] = [[День добрый. Вы вовремя.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/47.mp3",
			["Answers"] = {
				{"Алло.", 48,},
				{"Добрый.", 48,},
				{"Марк, есть что-то новое?", 49,},
			},
		},
		[48] = {
			["Line"] = [[Сегодня произошёл ещё один поджог. Подробности уже на месте. Едьте на Гранд Вэй, дом 3.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/48.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Уже еду.", "MQS Continue quest",},
			},
		},
		[49] = {
			["Line"] = [[Есть. К сожалению. Едьте на Гранд Вэй, дом 3. Подробности узнаете на месте.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/49.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Уже еду.", "MQS Continue quest",},
			},
		},
		[50] = {
			["Line"] = [[День. Едь на улицу Го, дом 1.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/50.mp3",
			["Answers"] = {
				{"Еду.", "MQS Continue quest",},
				{"День не добрый?", 51,},
				{"Очередной поджог?", 51,},
			},
		},
		[51] = {
			["Line"] = [[Да. Возможно, у нас открытие.]],
			["Sound"] = "https://macnco.one/cityrp/seasonsound/phone_all/51.mp3",
			["Answers"] = {
				{"Еду.", "MQS Continue quest",},
				{"Посмотрим.", "MQS Continue quest",},
			},
		},
	}
}