--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/npcs/season_clues.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCS.Spawns["season_clue1"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Перед вычерневшим полом лежит металлический осколок. От чего именно - на глаз не понять.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Перед вычерневшим полом лежит металлический осколок. От чего именно - на глаз не понять.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["season_clue2"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Металлическая плитка лежит нагревательным элементом вниз. Кто-то скинул её со стола? Она упала сама?]],
			["Sound"] = "",
			["Answers"] = {
				{"Присмотреться к бутылкам", 2,},
				{"Заглянуть в кастрюлю", 3,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Следы копоти внутри, фольга снаружи на горлышках.. Кто-то собирался что-то сжечь. Скорее всего, сожглось совсем не то.]],
			["Sound"] = "",
			["Answers"] = {
				{"Заглянуть в кастрюлю", 3,},
				{"Принять к сведению", "close",},
			},
		},
		[3] = {
			["Line"] = [[Её не мыли годами. Если в ней и смешивали что-то незаконное - факты надёжно спрятались за слоем нагара.]],
			["Sound"] = "",
			["Answers"] = {
				{"Присмотреться к бутылкам", 2,},
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue3"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Пустая пепельница. Ох, эта ирония..]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue4"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Телевизор без стекла. Экран вышибли ещё до возгорания. Или его вышибло во время.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue5"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Разводной ключ с коробкой гвоздей. Кажется, развели покупателя.. если только этими же гвоздями не прибивались прогоревшие полки.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue6"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Под куском шифера раковина. Может, в ней есть ответы?]],
			["Sound"] = "",
			["Answers"] = {
				{"Отодвинуть шифер", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Увы, лишь большая идея как жили в этой квартире. Раковина застолблена грязной жидкостью с кучей мелкого мусора. Возможно, туда сливали вообще всё подряд. Водой и не пахнет.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue7"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube075x075x075.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Сейф совершенно не задело происходившее в квартире. Почти ни следа копоти.]],
			["Sound"] = "",
			["Answers"] = {
				{"Попробовать открыть сейф", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Защита работает как надо. Сейф не пускает любопытные глаза позади себя. Без кода внутрь не попасть - а любая идея о бумажке уже давно сгорела со всем помещением.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue8"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Разбитая ваза. Она или упала сама, или её специально столкнули с сейфа.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue9"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Канистра. Обычно в таких держат горючее.]],
			["Sound"] = "",
			["Answers"] = {
				{"Потрясти канистру", 2,},
				{"Поискать обозначения снаружи", 3,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Внутри ни капли. Словно всё содержимое выжгло во время пожара. Действительно горючее.]],
			["Sound"] = "",
			["Answers"] = {
				{"Поискать обозначения снаружи", 3,},
				{"Принять к сведению", "close",},
			},
		},
		[3] = {
			["Line"] = [[Этикетка пропала вместе с обоями, полом, возможным ковром, деревом.. В общем, узнать продукт в точности не получится.]],
			["Sound"] = "",
			["Answers"] = {
				{"Потрясти канистру", 2,},
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue10"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Радио серьёзно пострадало от пожара. Да и до него скорее всего тоже - по корпусу будто чем-то ударили.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue11"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x1x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Весь стеллаж выгорел вместе со своим содержимым. От огня не пострадали только бутылки. Странный поворот у мебели, однако..]],
			["Sound"] = "",
			["Answers"] = {
				{"Просмотреть сумки", 2,},
				{"Осмотреть бутылки", 3,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Внутренности разодраны. Неужели, постаралось домашнее животное?]],
			["Sound"] = "",
			["Answers"] = {
				{"Осмотреть бутылки", 3,},
				{"Принять к сведению", "close",},
			},
		},
		[3] = {
			["Line"] = [[Водка. В бутылках хранили алкоголь. Однако, на мини-бар окружающая конструкция совсем не похожа.]],
			["Sound"] = "",
			["Answers"] = {
				{"Просмотреть сумки", 2,},
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue12"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Выгоревший текстолит, в своём-то треснувшем состоянии, уже больше всего радио. Микросхема точно не принадлежит ничему из этой квартиры.]],
			["Sound"] = "",
			["Answers"] = {
				{"Оценить повреждения платы", 2,},
				{"Посмотреть на соединения платы", 4,},
			},
		},
		[2] = {
			["Line"] = [[Текстолит разорвало. От разрыва часть оказалась за диваном. Может, это имеет отношение к чёрному пятну возле кухни?]],
			["Sound"] = "",
			["Answers"] = {
				{"Посмотреть на соединения платы", 3,},
			},
		},
		[3] = {
			["Line"] = [[Плата точно не принадлежит никакому компьютеру или телевизору. Её грубо говоря собирали вручную - кустарным образом - для конкретной узкой цели.]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[4] = {
			["Line"] = [[Плата точно не принадлежит никакому компьютеру или телевизору. Её грубо говоря собирали вручную - кустарным образом - для конкретной узкой цели.]],
			["Sound"] = "",
			["Answers"] = {
				{"Оценить повреждения платы", 5,},
			},
		},
		[5] = {
			["Line"] = [[Текстолит разорвало. От разрыва часть оказалась за диваном. Может, это имеет отношение к чёрному пятну возле кухни?]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[6] = {
			["Line"] = [[Скорее всего, конечное устройство и является причиной возгорания. Нарочно или нет - оно взорвалось. По крайней мере, такая версия событий объясняет почернение с принудительной перестановкой квартиры. Ничто другое не состыковывается с вероятным взрывом.]],
			["Sound"] = "",
			["Answers"] = {
				{
					"Принять к сведению", {
						id = "MQS Skip to",
						data = {
							id = 18,
							quest_id = "season1_govern_1"
						}
					},
				},
			},
		},
	}
}

MCS.Spawns["season_clue13"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x2x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Стол почти целиком собран из металла. 'Рабочая' часть стола состоит из дерева. Самый верный вариант для бедных жителей.]],
			["Sound"] = "",
			["Answers"] = {
				{"Отодвинуть стол от стены", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[..Именно поэтому такие покупают только в крайних случаях. Стол не двигается, не складывается и не подаёт признаков работоспособности. Своими руками тут не справиться.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue14"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[За столом точно что-то есть. Что-то похожее на электро-бритву.]],
			["Sound"] = "",
			["Answers"] = {
				{"Присмотреться к объекту", 2,},
				{"Отодвинуть стол", 4,},
			},
		},
		[2] = {
			["Line"] = [[Ствол. От пистолета. Оружие не хранили в сейфе.]],
			["Sound"] = "",
			["Answers"] = {
				{"Отодвинуть стол", 3,},
			},
		},
		[3] = {
			["Line"] = [[Стол не двигается, не складывается и не подаёт признаков работоспособности. Своими руками тут не справиться.]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[4] = {
			["Line"] = [[Стол не двигается, не складывается и не подаёт признаков работоспособности. Своими руками тут не справиться.]],
			["Sound"] = "",
			["Answers"] = {
				{"Присмотреться к объекту", 5,},
			},
		},
		[5] = {
			["Line"] = [[Ствол. От пистолета. Оружие не хранили в сейфе.]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[6] = {
			["Line"] = [[Собирались оружие использовать, или же его владелец пренебрегал безопасностью - не важно. Важно то, что от пистолета остался только ствол. Оружие вполне могло рассыпаться от взрыва с кухни - чёрное пятно намекает на сильное внешнее воздействие.

Да и никто бы не переставлял мебель так странно даже если бы убирался. Защищавшихся застали врасплох. У них отняли любую готовность, любые намёки на ответную стрельбу внезапной бомбой. Но зачем возможные конкуренты это сделали? Почему не тронули сейф? Банально не успели?]],
			["Sound"] = "",
			["Answers"] = {
				{
					"Принять к сведению", {
						id = "MQS Skip to",
						data = {
							id = 25,
							quest_id = "season1_govern_1"
						}
					},
				},
			},
		},
	}
}

MCS.Spawns["season_clue15"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Ныне несуществующая часть стены отделяла кухню от гостиной.]],
			["Sound"] = "",
			["Answers"] = {
				{"Присмотреться к повреждениям", 2,},
			},
		},
		[2] = {
			["Line"] = [[Стена явно не несущая - заброшенные квартиры полны незаметных обрушений. Они совсем не мешают новым 'владельцам' работать над чем-нибудь незаконным. Здесь не живут.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
		[3] = {
			["Line"] = [[Ныне несуществующая часть стены отделяла кухню от гостиной.]],
			["Sound"] = "",
			["Answers"] = {
				{"Присмотреться к повреждениям", 4,},
			},
		},
		[4] = {
			["Line"] = [[Стена явно не несущая - заброшенные квартиры полны незаметных обрушений. Они совсем не мешают новым 'владельцам' работать над чем-нибудь незаконным. Здесь не живут.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["season_clue16"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Возможный охранник точно не скучал с возможно украденной аппаратурой. Если только телевизор не показывал текущую картинку круглосуточно.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue17"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Комод забит маленькими коробками. Что внутри, что снаружи.]],
			["Sound"] = "",
			["Answers"] = {
				{"Заглянуть в коробки", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Целофановые пакетики, ювелирные весы, щипцы.. Нет, в таких местах конечно зарабатывают схожие суммы, но контекст очевиден даже ребёнку.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue18"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Коробку от пиццы не оставили в спешке. Пищу давно съели. Возможно, запахом соуса пытались перебить вонь остального мусора.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue19"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Пепельницей пользовались по назначению. Хотя бы здесь.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue20"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Ни один уважающий себя человек не садился бы на этот диван. ..Впрочем, единственное заметное пятно появилось недавно - бутылку пива бросили на подушку сразу, как случилось что-то неладное.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue21"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Перешагивать каждый раз через тумбу куда неудобнее, чем через хлопья. Вывод один - её опрокинуло незадолго до приезда пожарных.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue22"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x105x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Обычно у отбросов общества способы их заработка стоят ровно. Обычно. Лишь очередное подтверждение теории о взрыве.]],
			["Sound"] = "",
			["Answers"] = {
				{"Осмотреть подносы", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[На удивление чистые. В них часто заливают противозаконные 'конфетки' для превращения холодильником в 'стекло'. Детектив порадуется находке.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue23"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Эта бутылка прям выделяется. Её зачем-то положили ровно на коробку, а не на пол.]],
			["Sound"] = "",
			["Answers"] = {
				{"Посмотреть на повреждения бутылки", 2,},
				{"Принюхаться к бутылке", 4,},
			},
		},
		[2] = {
			["Line"] = [[Единственная разбитая бутылка на всю квартиру. Ещё и нижняя часть. Где 'розочка'?]],
			["Sound"] = "",
			["Answers"] = {
				{"Принюхаться к бутылке", 3,},
			},
		},
		[3] = {
			["Line"] = [[Пахнет не только алкоголем. Коктейль Молотова?]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[4] = {
			["Line"] = [[Пахнет не только алкоголем. Коктейль Молотова?]],
			["Sound"] = "",
			["Answers"] = {
				{"Посмотреть на повреждения бутылки", 5,},
			},
		},
		[5] = {
			["Line"] = [[Единственная разбитая бутылка на всю квартиру. Ещё и нижняя часть. Где 'розочка'?]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[6] = {
			["Line"] = [[Допустим, бутылку с зажигательной смесью бросили во вторую часть квартиры. Откуда это сделали? Как 'сувенир' приземлился ровно на коробку для суши? Может, простое совпадение?]],
			["Sound"] = "",
			["Answers"] = {
				{
					"Принять к сведению", {
						id = "MQS Skip to",
						data = {
							id = 11,
							quest_id = "season1_govern_3"
						}
					},
				},
			},
		},
	}
}

MCS.Spawns["season_clue24"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube075x1x1.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Внезапным шкафом занимаются офицеры. Лучше им не мешать.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue25"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Хоть и раковина не от слова 'рак' - ею похоже пользовались клешнями.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue26"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x1x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Что здесь действительно съедобно? Ещё не распакованное.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue27"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Куча чужих записок. Из-за беспорядка и не понять, передавали их так или выкидывали.]],
			["Sound"] = "",
			["Answers"] = {
				{"Прочитать надписи", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Почерк почти нечитаем. За исключением огромных прописных оскорблений. Их все писал один и тот же человек на ломаном английском. Может, босс?]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue28"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube075x075x075.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Холодильник до сих пор гудит. Умели же делать технику..!]],
			["Sound"] = "",
			["Answers"] = {
				{"Заглянуть внутрь", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Пожалуй, это единственное более-менее организованное чистое место во всей квартире. По крайней мере, сохранившееся после инцидента.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue29"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Радио сами по себе не падают. Причины очевидны.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue30"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Из всего на столе выделяется один блокнот.]],
			["Sound"] = "",
			["Answers"] = {
				{"Прочитать надписи", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Рецепт метамфетамина в мельчайших подробностях. Даже не пытались как-то конспирироваться. ..Не особо надо, как оказывается - с таким-то исходом.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue31"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Специально такую здоровую бочку никто бросать не будет.]],
			["Sound"] = "",
			["Answers"] = {
				{"Изучить жидкость", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[..А учитывая содержимое - тем более. Это промышленная химия. Легко горит.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue32"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube075x075x075.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Увы, это не кожа. Креслу сильно досталось от огня.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue33"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube075x075x075.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Мужчина средних лет. Его отбросило взрывом вместе с остальным оборудованием. Приземлился уже мёртвым.]],
			["Sound"] = "",
			["Answers"] = {
				{"Изучить повреждения", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Множество ожогов и разрывов. Нет следов от порезов или выстрелов. Возможно сломан хребет.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue34"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x105x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Канистры с химией. Выгорели мгновенно.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue35"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x105x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Какая глупая растрата дорогостоящего химического оборудования.. Благо, оно больше никому не приготовит вреда.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue36"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube075x075x075.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Мужчина. Его отбросило взрывом вместе с остальным оборудованием. Вероятно, умер от удара затылком об стену.]],
			["Sound"] = "",
			["Answers"] = {
				{"Изучить повреждения", 2,},
				{"Принять к сведению", "close",},
			},
		},
		[2] = {
			["Line"] = [[Множество ожогов и разрывов. Нет следов от порезов или выстрелов. Нижняя часть таза заметно отделена от остального тела.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue37"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Часть бутылки сильно выделяется по сравнению с остальным окружением.]],
			["Sound"] = "",
			["Answers"] = {
				{"Посмотреть на повреждения бутылки", 2,},
				{"Принюхаться к бутылке", 4,},
			},
		},
		[2] = {
			["Line"] = [[Единственная разбитая бутылка на всю квартиру. Судя по горлу, её разбили не ради ближнего боя.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принюхаться к бутылке", 3,},
			},
		},
		[3] = {
			["Line"] = [[Любые намёки на первоисточник выгорели вместе с половиной квартиры.]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[4] = {
			["Line"] = [[Любые намёки на первоисточник выгорели вместе с половиной квартиры.]],
			["Sound"] = "",
			["Answers"] = {
				{"Посмотреть на повреждения бутылки", 5,},
			},
		},
		[5] = {
			["Line"] = [[Единственная разбитая бутылка на всю квартиру. Судя по горлу, её разбили не ради ближнего боя.]],
			["Sound"] = "",
			["Answers"] = {
				{"Сделать выводы", 6,},
			},
		},
		[6] = {
			["Line"] = [[Нет сомнений - это коктейль Молотова. Лабораторию кто-то поджёг в самый горячий момент производства.]],
			["Sound"] = "",
			["Answers"] = {
				{
					"Принять к сведению", {
						id = "MQS Skip to",
						data = {
							id = 13,
							quest_id = "season1_govern_3"
						}
					},
				},
			},
		},
	}
}

MCS.Spawns["season_safe"] = {
	name = "Сейф",
	model = "models/anthon/safebox.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	sequence = "",
	uselimit = true,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[В квартирах потерпевших постоянно встречаются сейфы. Если бы только сами квартиры так же защищали, как содержимое металлических коробок..]],
			["Sound"] = "",
			["Answers"] = {
				{"Открыть сейф", 2,},
				{"Отойти", "close",},
			},
		},
		[2] = {
			["Line"] = [[Руками его не открыть. В смысле одними руками. Здесь нужен ключ, отмычка или что-то схожее по находчивости.]],
			["Sound"] = "",
			["Answers"] = {
				{"Отойти", "close",},
			},
		},
		[3] = {
			["Line"] = [[В квартирах потерпевших постоянно встречаются сейфы. Если бы только сами квартиры так же защищали, как содержимое металлических коробок..]],
			["Sound"] = "",
			["Answers"] = {
				{"Открыть сейф ключом", 4, nil, nil, "open"},
				{"Отойти", "close",},
			},
		},
		[4] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"Изучить находку", 5, nil, nil, "idleopen"},
			},
		},
		[5] = {
			["Line"] = [[Пистолет без ствола. Даже патроны на месте. Интересно..]],
			["Sound"] = "",
			["Answers"] = {
				{"Закрыть сейф", 6, nil, nil, "close"},
			},
		},
		[6] = {
			["Line"] = [[Детектив точно захочет об этом услышать. Сразу после инспектора.]],
			["Sound"] = "",
			["Answers"] = {
				{"Отойти", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["season_clue38"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Пиво. Его так и не успели употребить.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue39"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[В кастрюле суп. Хоть и готовили его не лучшим образом - на причину возгорания совсем не похоже.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue40"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x05x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Хоть где-то курят как следует. Не только в плане выбора что конкретно курить. Это не причина квартирного ужаса.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue41"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube075x075x075.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Сейф нагло вскрыт. Даже не скрывают.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "close",},
			},
		},
	}
}

MCS.Spawns["season_clue42"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x1x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Мужчина, чернокожий. Обычно так не ложатся при догорании..]],
			["Sound"] = "",
			["Answers"] = {
				{"Оценить масштабы повреждений", 2,},
			},
		},
		[2] = {
			["Line"] = [[Несмотря на ожоги несовместимые с экспертизой, в теле наблюдается дыра приличных размеров. Как если бы в мужчину выстрелили из дробовика.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["season_clue43"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x1x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Мужчина, чернокожий. Обычно так не ложатся при догорании..]],
			["Sound"] = "",
			["Answers"] = {
				{"Оценить масштабы повреждений", 2,},
			},
		},
		[2] = {
			["Line"] = [[Несмотря на ожоги несовместимые с экспертизой, в голове видно несколько отверстий приличных размеров. Как если бы в мужчину выстрелили из крупнокалиберного пистолета.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "MQS Continue quest",},
			},
		},
	}
}

MCS.Spawns["season_clue44"] = {
	name = "Улика",
	model = "models/hunter/blocks/cube05x1x05.mdl",
	namepos = 80,
	theme = "Retro",
	scale = 1,
	questNPC = false,
	pos = {},
	noinfo = true,
	submat = {
		[0] = "null"
	},
	sequence = "",
	uselimit = false,
	skin = 1,
	bgr = {},
	ClModels = {},
	dialogs = {
		[1] = {
			["Line"] = [[Мужчина, чернокожий. Обычно так не ложатся при догорании..]],
			["Sound"] = "",
			["Answers"] = {
				{"Оценить масштабы повреждений", 2,},
			},
		},
		[2] = {
			["Line"] = [[Несмотря на ожоги несовместимые с экспертизой, в теле наблюдается дыра приличных размеров. Как если бы в мужчину выстрелили из дробовика.]],
			["Sound"] = "",
			["Answers"] = {
				{"Принять к сведению", "MQS Continue quest",},
			},
		},
	}
}