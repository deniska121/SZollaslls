--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/character/sh_outfits.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCR.shop = {}

MCR.shop.bgs = {
	["s"] = {1, 0},
	["c"] = {1, 0},
	["p"] = {1, 1},
	["wc"] = {1, 3},
}

MCR.shop.top = {
	{
		name = "Кофта, красная",
		id = 1,
		f = "s",
		price = 600
	},
	{
		name = "Кофта, фиолетовая",
		id = 5,
		f = "s",
		price = 600
	},
	{
		name = "Футболка, бежевая",
		id = 6,
		f = "s",
		price = 600
	},
	{
		name = "Футболка, такси",
		id = 11,
		f = "s",
		price = 600
	},
	{
		name = "Футболка, выживальщик",
		id = 12,
		f = "s",
		price = 600
	},
	{
		name = "Кофта, череп",
		id = 13,
		f = "s",
		price = 600
	},
	{
		name = "Кофта, серо-зелёная",
		id = 14,
		f = "s",
		price = 600
	},
	{
		name = "Футболка, сине-голубая",
		id = 15,
		f = "s",
		price = 600
	},
	{
		name = "Кофта, зомби",
		id = 16,
		f = "s",
		price = 600
	},
	{
		name = "Футболка, легенда",
		price = 30,
		id = 42,
		f = "s",
		don = true
	},
	{
		name = "Рубашка-поло, сине-чёрная",
		id = 40,
		f = "p",
		price = 600
	},
	{
		name = "Футболка, YOLO",
		id = 35,
		f = "s",
		price = 600
	},
	{
		name = "Клетчатая рубашка, синяя",
		price = 700,
		id = 2,
		f = "s"
	},
	{
		name = "Клетчатая рубашка, коричневая",
		price = 700,
		id = 4,
		f = "s"
	},
	{
		name = "Клетчатая рубашка, красная",
		price = 700,
		id = 22,
		f = "s"
	},
	{
		name = "Рубашка, синяя",
		price = 750,
		id = 28,
		f = "s"
	},
	{
		name = "Рубашка, бежевая",
		id = 36,
		f = "s",
		price = 600
	},
	{
		name = "Рубашка с галстуком, белая",
		price = 750,
		id = 37,
		f = "s"
	},
	-- +++++++++++++++++++++++++++++++++++++++++++++
	{
		name = "Рубашка-поло, оранжевая",
		price = 700,
		id = 46,
		f = "p"
	},
	{
		name = "Клетчатая рубашка, чёрно-белая",
		price = 10,
		id = 47,
		f = "s",
		don = true
	},
	{
		name = "Рубашка, белоснежная",
		price = 800,
		id = 43,
		f = "s"
	},
	{
		name = "Свитер, зелёный",
		id = 20,
		cp = true,
		f = "s",
		price = 600
	},
	{
		name = "Свитер, пламя",
		id = 44,
		f = "s",
		price = 25,
		don = true
	},
	{
		name = "Свитер, пентаграмма",
		id = 45,
		f = "s",
		price = 25,
		don = true
	},
	{
		name = "Модный жилет",
		id = 51,
		f = "s",
		cp = true,
		price = 99,
		don = true
	},
	{
		name = "Кофта, чёрная",
		id = 48,
		f = "s",
		price = 50,
		don = true
	},
	{
		name = "Толстовка, красная",
		price = 700,
		id = 17,
		f = "s"
	},
	{
		name = "Бомбер, тёмно-синий",
		cp = true,
		price = 1200,
		id = 3,
		f = "c"
	},
	{
		name = "Бомбер, болотный",
		price = 50,
		id = 39,
		f = "c",
		don = true
	},
	{
		name = "Бомбер, фанатский",
		price = 199,
		id = 49,
		f = "c",
		don = true
	},
	{
		name = "Ветровка, бледно-синяя",
		price = 800,
		id = 7,
		f = "c"
	},
	{
		name = "Ветровка, бежевая",
		price = 800,
		id = 8,
		f = "c"
	},
	{
		name = "Ветровка, зелёная",
		price = 800,
		id = 29,
		f = "c"
	},
	{
		name = "Ветровка, чёрная",
		price = 800,
		id = 30,
		f = "c"
	},
	{
		name = "Блузон, чёрный",
		cp = true,
		id = 24,
		price = 1000,
		f = "c"
	},
	{
		name = "Пуховик, чёрный",
		price = 900,
		id = 9,
		f = "wc"
	},
	{
		name = "Пуховик, зелёный",
		price = 900,
		id = 31,
		f = "wc"
	},
	{
		name = "Толстовка, череп",
		cp = true,
		id = 10,
		f = "s",
		price = 600
	},
	{
		name = "Куртка, чёрная",
		id = 18,
		price = 800,
		cp = true,
		f = "c"
	},
	{
		name = "Куртка, чёрная выцветшая",
		price = 700,
		id = 21,
		cp = true,
		f = "c"
	},
	{
		name = "Куртка, синяя",
		price = 800,
		cp = true,
		id = 41,
		f = "c"
	},
	{
		name = "Модная куртка",
		id = 50,
		f = "c",
		price = 99,
		don = true
	},
	{
		name = "Джинсовка, коричневая",
		id = 19,
		f = "c",
		price = 600
	},
	{
		name = "Джинсовка, классическая",
		id = 27,
		f = "c",
		price = 600
	},
	{
		name = "Джинсовка, уценённая",
		price = 340,
		id = 34,
		f = "c"
	},
	{
		name = "Олимпийка, тёмно-синяя",
		id = 23,
		cp = true,
		price = 620,
		f = "c"
	},
	{
		name = "Олимпийка, голубая",
		price = 620,
		id = 26,
		f = "c"
	},
	{
		name = "Олимпийка, оранжевая",
		price = 620,
		id = 33,
		f = "c"
	},
	{
		name = "Штормовка, бежевая",
		price = 1000,
		cp = true,
		id = 25,
		f = "c"
	},
	{
		name = "Штормовка, зелёная",
		cp = true,
		price = 1000,
		id = 32,
		f = "c"
	},
	{
		name = "Реплика бизнес-верха",
		price = 1990,
		cp = true,
		id = 38,
		f = "c"
	},
	{
		name = "Куртка, чёрная кожа",
		price = 1200,
		id = 55,
		f = "wc"
	},
	{
		name = "Куртка, коричневая",
		price = 1000,
		id = 56,
		f = "wc"
	},
	{
		name = "Пуховик, розовый",
		price = 900,
		id = 57,
		f = "wc"
	},
	{
		name = "Пуховик, синий",
		price = 900,
		id = 58,
		f = "wc"
	},
	{
		name = "Пуховик, оливковый",
		price = 900,
		id = 59,
		f = "wc"
	},
	{
		name = "Куртка, чёрная",
		price = 1000,
		id = 60,
		f = "wc"
	},
	{
		name = "Куртка, синяя",
		price = 1000,
		id = 61,
		f = "wc"
	},
	{
		name = "Клетчатая рубашка, белая",
		price = 800,
		id = 52,
		f = "s"
	},
	{
		name = "Клетчатая рубашка, оранжевая",
		price = 800,
		id = 54,
		f = "s"
	},
	{
		name = "Футболка, пульс",
		price = 15,
		id = 62,
		f = "s",
		don = true
	},
	{
		name = "Футболка, шутка оригинал",
		price = 20,
		id = 63,
		f = "s",
		don = true
	},
	{
		name = "Футболка, шутка ответ",
		price = 20,
		id = 64,
		f = "s",
		don = true
	},
	{
		name = "Рубашка-поло, США",
		price = 25,
		id = 65,
		f = "p",
		don = true
	},
	{
		name = "Рубашка-поло, Конфедерат",
		price = 90,
		id = 66,
		f = "p",
		don = true
	},
	{
		name = "Рубашка-поло, пицца",
		price = 15,
		id = 67,
		f = "p",
		don = true
	},
	{
		name = "Рубашка-поло, поиск",
		price = 15,
		id = 68,
		f = "p",
		don = true
	},
	{
		name = "Рубашка-поло, чёрно-серая",
		price = 600,
		id = 69,
		f = "p"
	},
	{
		name = "Футболка, Нью-Йорк",
		price = 30,
		id = 70,
		f = "s",
		don = true
	},
	{
		name = "Футболка, конституция",
		price = 20,
		id = 71,
		f = "s",
		don = true
	},
	{
		name = "Бомбер, драйв",
		price = 249,
		id = 72,
		f = "c",
		don = true
	},
	{
		name = "Бомбер, бордовый",
		cp = true,
		price = 1200,
		id = 73,
		f = "c"
	},
	{
		name = "Бомбер, коричневый",
		cp = true,
		price = 1200,
		id = 74,
		f = "c"
	},
	{
		name = "Бомбер, модный",
		price = 50,
		id = 75,
		f = "c",
		don = true
	},
	{
		name = "Рубашка, гавайская синяя",
		price = 20,
		id = 76,
		f = "s",
		don = true
	},
	{
		name = "Рубашка, гавайская красная",
		price = 20,
		id = 77,
		f = "s",
		don = true
	},
	{
		name = "Рубашка, Майами",
		price = 100,
		id = 78,
		f = "s",
		don = true
	},
	{
		name = "Футболка, сувенир",
		price = 0,
		pack = "d_packrat1",
		id = 79,
		f = "s"
	},
	{
		name = "Рубашка-поло, RDM",
		price = 15,
		id = 80,
		f = "p",
		don = true
	},
	{
		name = "Футболка, конопля",
		price = 15,
		id = 81,
		f = "s",
		don = true
	},
	{
		name = "Толстовка, белая",
		price = 800,
		cp = true,
		id = 82,
		f = "s"
	},
	{
		name = "Толстовка, синяя",
		price = 700,
		cp = true,
		id = 83,
		f = "s"
	},
	{
		name = "Толстовка, коричневая",
		price = 700,
		cp = true,
		id = 84,
		f = "s"
	},
	{
		name = "Толстовка, розовая",
		price = 90,
		cp = true,
		id = 85,
		f = "s",
		don = true
	},
	{
		name = "Толстовка, соцсеть",
		price = 20,
		cp = true,
		id = 86,
		f = "s",
		don = true
	},
	{
		name = "Толстовка, Нью-Йорк",
		price = 850,
		cp = true,
		id = 87,
		f = "s"
	},
	{
		name = "Толстовка, шум",
		price = 20,
		cp = true,
		id = 88,
		f = "s",
		don = true
	},
	{
		name = "Косуха, классическая кожа",
		price = 200,
		id = 89,
		cp = true,
		f = "c",
		don = true
	},
	{
		name = "Куртка, мятая коричневая",
		price = 700,
		cp = true,
		id = 90,
		f = "c"
	},
	{
		name = "Куртка, мятая чёрная",
		cp = true,
		price = 700,
		id = 91,
		f = "c"
	},
	{
		name = "Рубашка-поло, рэпер",
		price = 15,
		id = 92,
		f = "p",
		don = true
	},
	{
		name = "Толстовка, иероглифы",
		price = 20,
		id = 93,
		f = "s",
		don = true
	},
	{
		name = "Футболка, мюзикл",
		price = 15,
		id = 94,
		f = "s",
		don = true
	},
	{
		name = "Рубашка, камуфляж Нью-Йорка",
		price = 90,
		id = 95,
		f = "s",
		don = true
	},
	{
		name = "Толстовка, в голову",
		price = 15,
		id = 96,
		f = "s",
		don = true
	},
	{
		name = "Футболка, наркотики",
		price = 20,
		id = 97,
		f = "s",
		don = true
	},
	{
		name = "Футболка, клубная",
		price = 15,
		id = 98,
		f = "s",
		don = true
	},
	{
		name = "Свитер, бежевый",
		price = 600,
		cp = true,
		id = 99,
		f = "s"
	},
	{
		name = "Свитер, синий",
		price = 600,
		cp = true,
		id = 100,
		f = "s"
	},
	{
		name = "Свитер, красный",
		price = 600,
		cp = true,
		id = 101,
		f = "s"
	},
	{
		name = "Свитер, новогодний красный",
		--price = 70,
		price = 30,
		cp = true,
		id = 102,
		f = "s",
		don = true
	},
	{
		name = "Свитер, новогодний синий",
		--price = 70,
		price = 30,
		cp = true,
		id = 103,
		f = "s",
		don = true
	},
	{
		name = "Свитер, Микроник",
		price = 740,
		cp = true,
		id = 104,
		f = "s"
	},
	{
		name = "Футболка, революционер",
		price = 40,
		id = 106,
		f = "s",
		don = true
	},
	{
		name = "Куртка, бордовая",
		price = 800,
		cp = true,
		id = 107,
		f = "c"
	},
	{
		name = "Куртка, коричневая",
		price = 800,
		id = 108,
		cp = true,
		f = "c"
	},
	{
		name = "Куртка, коричневая выцветшая",
		price = 700,
		cp = true,
		id = 109,
		f = "c"
	},
	{
		name = "Куртка, бордовая выцветшая",
		cp = true,
		price = 700,
		id = 110,
		f = "c"
	},
	{
		name = "Блузон, коричневый",
		price = 1000,
		cp = true,
		id = 111,
		f = "c"
	},
	{
		name = "Блузон, бордовый",
		cp = true,
		price = 1000,
		id = 112,
		f = "c"
	},
	{
		name = "Блузон, синий",
		cp = true,
		price = 1000,
		id = 113,
		f = "c"
	},
	{
		name = "Футболка, модная чёрная",
		price = 25,
		don = true,
		id = 114,
		f = "s"
	},
	{
		name = "Джемпер, коричневый",
		pack = "d_packrat4",
		id = 135,
		cp = true,
		f = "c"
	},
	{
		name = "Джемпер, серый",
		pack = "d_packrat4",
		cp = true,
		id = 136,
		f = "c"
	},
	{
		name = "Джемпер, белый",
		pack = "d_packrat4",
		cp = true,
		id = 137,
		f = "c"
	},
	{
		name = "Джемпер, синий",
		pack = "d_packrat4",
		cp = true,
		id = 138,
		f = "c"
	},
	{
		name = "Джемпер, жёлтый",
		pack = "d_packrat4",
		cp = true,
		id = 139,
		f = "c"
	},
	{
		name = "Джемпер, зелёный",
		pack = "d_packrat4",
		cp = true,
		id = 140,
		f = "c"
	},
	{
		name = "Куртка с рубашкой, коричневая",
		pack = "d_packrat5",
		id = 129,
		cp = true,
		f = "c"
	},
	{
		name = "Куртка с рубашкой, чёрная",
		pack = "d_packrat5",
		cp = true,
		id = 130,
		f = "c"
	},
	{
		name = "Куртка с рубашкой, синяя",
		pack = "d_packrat5",
		cp = true,
		id = 131,
		f = "c"
	},
	{
		name = "Куртка с рубашкой, бордовая",
		pack = "d_packrat5",
		cp = true,
		id = 132,
		f = "c"
	},
	{
		name = "Куртка с рубашкой, зелёная",
		pack = "d_packrat5",
		cp = true,
		id = 133,
		f = "c"
	},
	{
		name = "Куртка с рубашкой, бежевая",
		pack = "d_packrat5",
		cp = true,
		id = 134,
		f = "c"
	},
	{
		name = "Куртка с олимпийкой",
		pack = "d_packrat5",
		cp = true,
		id = 201,
		f = "c"
	},
	{
		name = "Рубашка, малибу",
		pack = "d_packrat6",
		id = 115,
		f = "s"
	},
	{
		name = "Рубашка-поло, химик",
		price = 40,
		id = 116,
		f = "p",
		don = true
	},
	{
		name = "Рубашка-поло, лошадь",
		price = 15,
		id = 117,
		f = "p",
		don = true
	},
	{
		name = "Толстовка, модная",
		price = 15,
		id = 118,
		f = "s",
		don = true
	},
	{
		name = "Кофта, релакс",
		price = 600,
		id = 119,
		f = "s"
	},
	{
		name = "Рубашка-поло, НЛО",
		price = 30,
		id = 120,
		f = "p",
		don = true
	},
	{
		name = "Кофта, инопланетянин",
		price = 20,
		id = 121,
		f = "s",
		don = true
	},
	{
		name = "Штормовка, коричневая",
		price = 1000,
		cp = true,
		id = 122,
		f = "c"
	},
	{
		name = "Штормовка, морская",
		price = 1000,
		cp = true,
		id = 123,
		f = "c"
	},
	{
		name = "Спортивный поло, синий",
		pack = "d_fishy",
		id = 124,
		f = "p"
	},
	{
		name = "Спортивный поло, зелёный",
		pack = "d_fishy",
		id = 125,
		f = "p"
	},
	{
		name = "Косуха, коричневая кожа",
		price = 200,
		id = 126,
		cp = true,
		f = "c",
		don = true
	},
	{
		name = "Косуха, синяя кожа",
		price = 200,
		id = 127,
		cp = true,
		f = "c",
		don = true
	},
	{
		name = "Кофта, полёт",
		price = 20,
		id = 141,
		f = "s",
		don = true
	},
	{
		name = "Толстовка, бренд",
		pack = "dinkenson_pack",
		id = 801,
		noshow = true,
		f = "c"
	},
	{
		name = "Рубашка, бренд",
		pack = "dinkenson_pack",
		id = 802,
		noshow = true,
		f = "s"
	},
	{
		name = "Куртка, винтажная",
		id = 142,
		price = 850,
		only = "female",
		f = "wc"
	},
	{
		name = "Кофта, заяц",
		id = 143,
		price = 800,
		only = "female",
		f = "s"
	},
	{
		name = "Кофта, котик",
		id = 144,
		price = 750,
		only = "female",
		f = "s"
	},
	{
		name = "Кофта, лиловая",
		id = 145,
		price = 600,
		only = "female",
		f = "s"
	},
	{
		name = "Кофта, синяя",
		id = 146,
		price = 600,
		only = "female",
		f = "s"
	},
	{
		name = "Кофта, оливковая",
		id = 147,
		price = 600,
		only = "female",
		f = "s"
	},
	{
		name = "Кофта, вишнёвая",
		id = 148,
		price = 600,
		only = "female",
		f = "s"
	},
	{
		name = "Пальто, чёрное",
		id = 149,
		price = 900,
		only = "female",
		f = "c"
	},
	{
		name = "Пальто, коричневое",
		id = 150,
		price = 900,
		only = "female",
		f = "c"
	},
	{
		name = "Футболка, Бруклин",
		pack = "d_blueblood",
		id = 151,
		f = "s",
	},
	{
		name = "Толстовка, Ньюйоркер",
		pack = "d_blueblood",
		id = 152,
		f = "s",
	},
	{
		name = "Футболка, NYPD",
		pack = "d_blueblood",
		id = 153,
		f = "s",
	},
	{
		name = "Светоотражающий верх",
		pack = "d_packbluecolar",
		id = 159,
		f = "wc"
	},
	{
		name = "Светоотражающий верх, охрана",
		pack = "d_packbluecolar",
		id = 160,
		f = "wc"
	},
	{
		name = "Пуховик, лёгкий",
		price = 1000,
		id = 161,
		f = "wc"
	},
	{
		name = "Ветровка с бэйджем, морская",
		pack = "d_packbluecolar",
		id = 162,
		cp = true,
		f = "c"
	},
	{
		name = "Ветровка с бэйджем, бурая",
		pack = "d_packbluecolar",
		id = 163,
		cp = true,
		f = "c"
	},
	{
		name = "Штормовка с бэйджем, бежевая",
		pack = "d_packbluecolar",
		id = 164,
		cp = true,
		f = "c"
	},
	{
		name = "Комбинезон рабочего, верх",
		pack = "d_packbluecolar",
		id = 165,
		cp = true,
		f = "c"
	},
	{
		name = "Рубашка механика, в масле",
		pack = "d_packbluecolar",
		id = 166,
		f = "s"
	},
	{
		name = "Рубашка консультанта, сиреневая",
		pack = "d_packbluecolar",
		id = 167,
		f = "s"
	},
	{
		name = "Рубашка консультанта, красная",
		pack = "d_packbluecolar",
		id = 168,
		f = "s"
	},
	{
		name = "Рубашка консультанта, зелёная",
		pack = "d_packbluecolar",
		id = 169,
		f = "s"
	},
	{
		name = "Рубашка-поло консультанта, сиреневая",
		pack = "d_packbluecolar",
		id = 167,
		f = "p"
	},
	{
		name = "Рубашка-поло консультанта, красная",
		pack = "d_packbluecolar",
		id = 168,
		f = "p"
	},
	{
		name = "Рубашка-поло консультанта, зелёная",
		pack = "d_packbluecolar",
		id = 169,
		f = "p"
	},
	{
		name = "Бизнес-верх",
		pack = "d_packhotline",
		id = 170,
		f = "p",
	},
	{
		name = "Штормовка, фанатская",
		pack = "d_packhotline",
		cp = true,
		id = 155,
		f = "c"
	},
	{
		name = "Рабочая куртка",
		pack = "d_builder",
		id = 171,
		noshow = true,
		f = "wc"
	},
}

MCR.shop.pants = {
	{
		name = "Карго, бежевые",
		price = 800,
		id = 1
	},
	{
		name = "Джинсы, светлые",
		id = 2,
		price = 600
	},
	{
		name = "Джинсы, чёрные",
		id = 3,
		price = 600
	},
	{
		name = "Джинсы, бежевые",
		id = 4,
		price = 600
	},
	{
		name = "Карго, синие",
		price = 800,
		id = 5
	},
	{
		name = "Джинсы, уценённые",
		price = 290,
		id = 6
	},
	{
		name = "Брюки, чёрные",
		price = 1000,
		id = 7
	},
	{
		name = "Карго, серые",
		price = 800,
		id = 8
	},
	{
		name = "Брюки спортивные, синие",
		id = 9,
		price = 600
	},
	{
		name = "Карго, чёрные",
		price = 800,
		id = 10
	},
	{
		name = "Карго, белые",
		price = 800,
		id = 11
	},
	{
		name = "Брюки, коричневые",
		price = 1000,
		id = 12
	},
	{
		name = "Брюки, тёмно-синие",
		price = 1000,
		id = 13
	},
	{
		name = "Джинсы, тёмно-серые",
		id = 14,
		price = 600
	},
	{
		name = "Джинсы, индиго",
		id = 15,
		price = 600
	},
	{
		name = "Джинсы, тёмно-синие",
		price = 530,
		id = 16
	},
	{
		name = "Карго, коричневые",
		price = 800,
		id = 17
	},
	{
		name = "Карго, тёмно-серые",
		price = 800,
		id = 18
	},
	{
		name = "Джинсы, бледные",
		id = 19,
		price = 600
	},
	{
		name = "Штаны, чёрные с карманами",
		id = 20,
		price = 600
	},
	{
		name = "Штаны, коричневые",
		id = 21,
		price = 600
	},
	{
		name = "Джинсы, серые",
		id = 22,
		price = 600
	},
	{
		name = "Штаны, зелёные",
		id = 23,
		price = 600
	},
	{
		name = "Джинсы, тёмно-синие заправленные",
		id = 24,
		price = 530
	},
	{
		name = "Джинсы, болотные",
		id = 25,
		price = 600
	},
	{
		name = "Джинсы, отцветшие",
		price = 500,
		id = 26
	},
	{
		name = "Джинсы, модные синие",
		price = 800,
		id = 27
	},
	{
		name = "Штаны, бледно-синие",
		id = 28,
		price = 600
	},
	{
		name = "Штаны, серые",
		id = 29,
		price = 600
	},
	{
		name = "Штаны, чёрные брючные",
		id = 30,
		price = 600
	},
	{
		name = "Брюки спортивные, красные",
		id = 31,
		price = 600
	},
	{
		name = "Брюки, бежевые",
		price = 700,
		id = 36
	},
	{
		name = "Джинсы, отцветшие чёрные",
		price = 500,
		id = 37
	},
	{
		name = "Штаны, чёрные",
		id = 38,
		price = 600
	},
	{
		name = "Брюки, коричневые мятые",
		price = 1000,
		id = 39
	},
	{
		name = "Джинсы, уценённые",
		price = 440,
		id = 40
	},
	{
		name = "Брюки костюмные, индиго",
		id = 41,
		price = 600
	},
	{
		name = "Джинсы, тёмно-синие",
		id = 42,
		price = 600
	},
	{
		name = "Брюки, белые",
		price = 1000,
		id = 43
	},
	{
		name = "Штаны, пламя",
		id = 44,
		price = 50,
		don = true
	},
	{
		name = "Штаны, пентаграмма",
		id = 45,
		price = 50,
		don = true
	},
	{
		name = "Брюки, бордовые",
		price = 1000,
		id = 46
	},
	{
		name = "Джинсы, уценённые",
		price = 330,
		id = 47
	},
	{
		name = "Штаны, тёмно-серые",
		id = 48,
		price = 600
	},
	{
		name = "Брюки спортивные, зелёные",
		price = 600,
		id = 49
	},
	{
		name = "Брюки спортивные, чёрные",
		price = 1000,
		id = 50
	},
	{
		name = "Брюки, уценённые",
		id = 51,
		price = 600
	},
	{
		name = "Карго, модные",
		price = 900,
		id = 55
	},
	{
		name = "Брюки спортивные, тёмно-синие",
		price = 1000,
		id = 56
	},
	{
		name = "Карго, хаки",
		price = 800,
		id = 32
	},
	{
		name = "Карго, камо хакки",
		price = 100,
		id = 33,
		don = true
	},
	{
		name = "Карго, камо серые",
		price = 100,
		id = 57,
		don = true
	},
	{
		name = "Джинсы, модные чёрные",
		price = 800,
		id = 34
	},
	{
		name = "Карго, камо коричневые",
		price = 100,
		id = 35,
		don = true
	},
	{
		name = "Брюки костюмные, лососевые",
		id = 58,
		price = 600
	},
	{
		name = "Брюки костюмные, оливковые",
		id = 59,
		price = 600
	},
	{
		name = "Джинсы, оливковые",
		id = 60,
		price = 600
	},
	{
		id = 89,
		name = "Джинсы, ретро",
		price = 750
	},
	{
		id = 91,
		name = "Штаны, уценённые",
		price = 290
	},
	{
		id = 68,
		name = "Штаны, синие",
		price = 700
	},
	{
		id = 71,
		name = "Штаны, бежевые",
		price = 700
	},
	{
		id = 73,
		name = "Штаны механика, в масле",
		pack = "d_packbluecolar",
	},
	{
		id = 74,
		name = "Комбинезон рабочего, низ",
		pack = "d_packbluecolar",
	},
	{
		id = 75,
		name = "Штаны, морские",
		pack = "d_packbluecolar",
	},
	{
		id = 76,
		name = "Штаны, бурые",
		pack = "d_packbluecolar",
	},
	{
		id = 77,
		name = "Джинсы, карго",
		pack = "d_packbluecolar",
	},
	{
		id = 78,
		name = "Штаны консультанта, сиреневые",
		pack = "d_packbluecolar",
	},
	{
		id = 79,
		name = "Штаны консультанта, красные",
		pack = "d_packbluecolar",
	},
	{
		id = 80,
		name = "Штаны консультанта, зелёные",
		pack = "d_packbluecolar",
	},
}

MCR.shop.boots = {
	{
		id = 3,
		name = "Ботинки, уценённые",
		price = 150
	},
	{
		id = 18,
		name = "Ботинки, бежевые",
		price = 700
	},
	{
		id = 16,
		name = "Ботинки, коричневые",
		price = 700
	},
	{
		id = 5,
		name = "Ботинки, чёрные",
		price = 750
	},
	{
		id = 7,
		name = "Ботинки кожаные, коричневые",
		price = 800
	},
	{
		id = 26,
		name = "Ботинки кожаные, зелёные",
		price = 800
	},
	{
		id = 39,
		name = "Ботинки",
		price = 1200
	},
	{
		id = 44,
		name = "Ботинки с ярлыком, белые",
		don = true,
		price = 50
	},
	{
		id = 45,
		name = "Ботинки с ярлыком, золотые",
		don = true,
		price = 50
	},
	{
		id = 13,
		name = "Кеды, уценённые",
		price = 320
	},
	{
		id = 2,
		name = "Кеды, ретро",
		price = 450
	},
	{
		id = 17,
		name = "Кеды, белые",
		price = 600
	},
	{
		id = 1,
		name = "Кеды, красные",
		price = 600
	},
	{
		id = 4,
		name = "Кеды, оранжевые",
		price = 600
	},
	{
		id = 48,
		name = "Кроссовки, чёрные реплика",
		price = 600
	},
	{
		id = 24,
		name = "Кроссовки, чёрные",
		price = 690
	},
	{
		id = 40,
		name = "Кроссовки, зимние",
		price = 1500
	},
	{
		id = 47,
		name = "Кроссы, модные коричневые",
		price = 2100
	},
	{
		id = 6,
		name = "Кроссы, модные синие",
		price = 2100
	},
	{
		id = 49,
		name = "Кроссовки, белые",
		price = 1800
	},
	{
		id = 50,
		name = "Кроссы, брендовые красные",
		don = true,
		price = 149
	},
	{
		id = 51,
		name = "Кроссы, брендовые чёрные",
		don = true,
		price = 149
	},
	{
		id = 56,
		name = "Ботинки, бордовые",
		price = 700
	},
	{
		id = 53,
		name = "Туфли, кожаные",
		price = 1400
	},
	{
		id = 89,
		name = "Кроссовки, серые",
		price = 700
	},
	{
		id = 90,
		name = "Кроссовки, коричневые",
		price = 600
	},
	{
		id = 68,
		name = "Кроссовки, синие",
		price = 690
	},
	{
		id = 71,
		name = "Кроссовки, бежевые",
		price = 600
	},
}

MCR.shop.shirt = {
	{
		id = 1,
		name = "Белая",
		price = 21000
	},
	{
		id = 10,
		name = "Облачная",
		price = 30000
	},
	{
		id = 14,
		name = "Розовая",
		price = 35000
	},
	{
		id = 2,
		name = "Голубая",
		price = 37000
	},
	{
		id = 3,
		name = "Тёмно-серая",
		price = 270,
		don = true
	},
	{
		id = 4,
		name = "Пурпурная",
		price = 220,
		don = true
	},
	{
		id = 5,
		name = "Белоснежная",
		price = 270,
		don = true
	},
	{
		id = 6,
		name = "Аквамариновая",
		price = 350,
		don = true
	},
	{
		id = 7,
		name = "Медно-розовая",
		price = 220,
		don = true
	},
	{
		id = 8,
		name = "Чёрная",
		price = 250,
		don = true
	},
	{
		id = 9,
		name = "Светло-серая",
		price = 220,
		don = true
	},
	{
		id = 11,
		name = "Бежевая",
		price = 200,
		don = true
	},
	{
		id = 12,
		name = "Золотая",
		price = 350,
		don = true
	},
	{
		id = 13,
		name = "Небесная",
		price = 350,
		don = true
	},
	{
		id = 15,
		name = "Вишнёвая",
		price = 300,
		don = true
	},
	{
		id = 17,
		name = "Оранжевая",
		price = 400,
		don = true
	},
	{
		id = 18,
		name = "Снежная",
		price = 250,
		don = true
	},
	{
		id = 19,
		name = "Угольная",
		price = 300,
		don = true
	},
	{
		id = 20,
		name = "Заказная",
		pack = "d_packrat7",
	},
	{
		id = 21,
		name = "Пепельно-чёрная",
		price = 350,
		don = true
	},
	{
		id = 22,
		name = "Изумрудная",
		price = 250,
		don = true
	},
	{
		id = 23,
		name = "Таксидо",
		price = 350,
		don = true
	},
	{
		id = 24,
		name = "Ярко-голубая",
		pack = "d_packhotline",
	},
}

MCR.shop.suit = {
	{
		id = 1,
		name = "Классический",
		price = 3100
	},
	{
		id = 10,
		name = "Серый",
		price = 4000
	},
	{
		id = 14,
		name = "Тёмно-серый в полоску",
		price = 5500
	},
	{
		id = 2,
		name = "Нуарный",
		price = 5700
	},
	{
		id = 3,
		name = "Бежевый",
		price = 170,
		don = true
	},
	{
		id = 4,
		name = "Пепельный",
		price = 120,
		don = true
	},
	{
		id = 5,
		name = "Стальной",
		price = 170,
		don = true
	},
	{
		id = 6,
		name = "Изумрудный",
		price = 250,
		don = true
	},
	{
		id = 7,
		name = "Небесный",
		price = 120,
		don = true
	},
	{
		id = 8,
		name = "Тёмно-серый",
		price = 150,
		don = true
	},
	{
		id = 9,
		name = "Бледный",
		price = 120,
		don = true
	},
	{
		id = 11,
		name = "Белый",
		price = 100,
		don = true
	},
	{
		id = 12,
		name = "Пурпурный",
		price = 250,
		don = true
	},
	{
		id = 13,
		name = "Оранжевый",
		price = 250,
		don = true
	},
	{
		id = 15,
		name = "Тёмно-синий в полоску",
		price = 200,
		don = true
	},
	{
		id = 17,
		name = "Угольный",
		price = 300,
		don = true
	},
	{
		id = 18,
		name = "Морской",
		price = 150,
		don = true
	},
	{
		id = 19,
		name = "Белоснежный",
		price = 200,
		don = true
	},
	{
		id = 20,
		name = "Заказной",
		pack = "d_packrat7",
	},
	{
		id = 21,
		name = "Алый",
		price = 350,
		don = true
	},
	{
		id = 22,
		name = "Серо-синий",
		price = 250,
		don = true
	},
	{
		id = 23,
		name = "Таксидо",
		price = 350,
		don = true
	},
	{
		id = 24,
		name = "Снежный",
		pack = "d_packhotline",
	},
}

MCR.shop.spants = {
	{
		id = 1,
		name = "Классические",
		price = 3100
	},
	{
		id = 10,
		name = "Серые",
		price = 4000,
	},
	{
		id = 14,
		name = "Темно-серые в полоску",
		price = 5500
	},
	{
		id = 2,
		name = "Нуарные",
		price = 5700
	},
	{
		id = 3,
		name = "Бежевые",
		price = 170,
		don = true
	},
	{
		id = 4,
		name = "Пепельные",
		price = 120,
		don = true
	},
	{
		id = 5,
		name = "Стальные",
		price = 170,
		don = true
	},
	{
		id = 6,
		name = "Изумрудные",
		price = 150,
		don = true
	},
	{
		id = 7,
		name = "Небесные",
		price = 120,
		don = true
	},
	{
		id = 8,
		name = "Тёмно-серые",
		price = 150,
		don = true
	},
	{
		id = 9,
		name = "Бледные",
		price = 120,
		don = true
	},
	{
		id = 11,
		name = "Белые",
		price = 100,
		don = true
	},
	{
		id = 12,
		name = "Пурпурные",
		price = 250,
		don = true
	},
	{
		id = 13,
		name = "Оранжевые",
		price = 250,
		don = true
	},
	{
		id = 15,
		name = "Тёмно-синие в полоску",
		price = 200,
		don = true
	},
	{
		id = 17,
		name = "Угольные",
		price = 300,
		don = true
	},
	{
		id = 18,
		name = "Морские",
		price = 150,
		don = true
	},
	{
		id = 19,
		name = "Белоснежные",
		price = 200,
		don = true
	},
	{
		id = 20,
		name = "Заказные",
		pack = "d_packrat7",
	},
	{
		id = 21,
		name = "Алые",
		price = 350,
		don = true
	},
	{
		id = 22,
		name = "Серо-синие",
		price = 250,
		don = true
	},
	{
		id = 23,
		name = "Таксидо",
		price = 350,
		don = true
	},
	{
		id = 24,
		name = "Снежные",
		pack = "d_packhotline",
	},
}

MCR.shop.coat = {
	{
		id = 1,
		name = "Джинсы, модные",
		price = 900
	},
	{
		id = 2,
		name = "Джинсы, бледные",
		price = 900
	},
	{
		id = 3,
		name = "Лосины, леопардовые",
		price = 30,
		don = true
	},
	{
		id = 4,
		name = "Лосины, тигровые",
		price = 30,
		don = true
	},
	{
		id = 5,
		name = "Лосины, фиолетовые",
		price = 30,
		don = true
	},
	{
		id = 6,
		name = "Лосины, зебровые",
		price = 30,
		don = true
	},
	{
		id = 7,
		name = "Джинсы, голубые",
		price = 10,
		don = true
	},
	{
		id = 8,
		name = "Джинсы, сиреневые",
		price = 10,
		don = true
	},
	{
		id = 9,
		name = "Джинсы, розовые",
		price = 10,
		don = true
	},
	{
		id = 10,
		name = "Джинсы, персиковые",
		price = 10,
		don = true
	},
	{
		id = 11,
		name = "Джинсы, зелёные",
		price = 10,
		don = true
	},
	{
		id = 12,
		name = "Джинсы, салатовые",
		price = 10,
		don = true
	},
}

MCR.shop.wboots = {
	{
		id = 1,
		name = "Сапоги, уценённые",
		price = 700
	},
	{
		id = 2,
		name = "Сапоги, чёрные",
		price = 900
	},
	{
		id = 3,
		name = "Сапоги, крокодил",
		price = 10,
		don = true
	},
	{
		id = 4,
		name = "Сапоги, аллигатор",
		price = 10,
		don = true
	},
	{
		id = 99,
		name = "Сапоги, коричневая кожа",
		price = 20,
		don = true
	},
	{
		id = 6,
		name = "Сапоги, красная кожа",
		price = 20,
		don = true
	},
	{
		id = 7,
		name = "Сапоги, фиолетовая кожа",
		price = 20,
		don = true
	},
	{
		id = 8,
		name = "Сапоги, модные",
		price = 20,
		don = true
	},
	{
		id = 9,
		name = "Сапоги, модные камо",
		price = 25,
		don = true
	},
}

MCR.randomtop = {
	male = {1, 13, 14, 31, 32, 7, 8, 27, 43, 22, 15, 46, 49, 47, 44, 33, 34, 48, 45, 82, 83},
	female = {1, 2, 8, 27, 43, 22, 44, 33, 34, 45, 82, 83, 84, 143, 144, 145, 146, 147, 148, 147, 148}
}

MCR.randompants = {
	male = {1, 2, 3, 30, 33},
	female = {1, 2, 3, 30, 33}
}

MCR.male = {}

MCR.male.fgs = {
	[1] = {
		[3] = {2, 2}
	},
	[2] = {
		[2] = {1, 3},
		[3] = {1, 3}
	},
}

MCR.male.rgs = {
	[1] = {3},
	[2] = {2},
}

MCR.female = {}

MCR.female.fgs = {
	[1] = {
		[3] = {2, 3}
	},
	[2] = {
		[3] = {1, 3},
		[4] = {1, 3}
	},
}

MCR.female.rgs = {
	[1] = {3},
	[2] = {3, 4},
}

MCR.shop.topids = {}
MCR.shop.pantsids = {}
for k,v in ipairs(MCR.shop.top) do
	MCR.shop.topids[v.id] = k
end
for k,v in ipairs(MCR.shop.pants) do
	MCR.shop.pantsids[v.id] = k
end