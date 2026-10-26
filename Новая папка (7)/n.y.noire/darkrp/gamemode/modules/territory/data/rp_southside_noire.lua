--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/territory/data/rp_southside_noire.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local ters = {}
local map = "rp_southside_noire"

------------------ Начало списка зон ----------------------
ters["police"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(6207, 6655, -500),
		[2] = Vector(9594, 6655, -500),
		[3] = Vector(9594, 9726, -500),
		[4] = Vector(6207, 9726, -500)
	},
	printName = "Полицейский Участок №92",
	printStr = "Whiskey road 1",
	height = 2700,
	police_zone = true,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["shelter"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-3529.1840820313, -1981.4108886719, -9185),
		[2] = Vector(-3981.7768554688, -2434.0031738281, -9185),
		[3] = Vector(-3581.8620605469, -2825.384765625, -9185),
		[4] = Vector(-3122.5979003906, -2388.7482910156, -9185)
	},
	printName = "Приют",
	printStr = "Any way 133a",
	height = 180,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	police_zone = true,
	onEnterSV = function(ter, ply)
		if ter.loadedScene then return end
		ter.loadedScene = true
		MQS.Scenes.Load("shelter")
		MQS.Scenes.Load("hoboland")
	end,
	onExitSV = function(ter, ply)
		if not ter:IsEmpty() or not ter.loadedScene then return end
		ter.loadedScene = nil
		MQS.Scenes.UnLoad("shelter")
		MQS.Scenes.UnLoad("hoboland")
	end
}

ters["firestation"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(9024.12890625, 1024.03125, -117),
		[2] = Vector(9024.1953125, 2559.96875, -117),
		[3] = Vector(10003.784179688, 2560.09765625, -117),
		[4] = Vector(10358.578125, 2259.8957519531, -117),
		[5] = Vector(10358.407226562, 2004.2680664062, -117),
		[6] = Vector(9951.8857421875, 1136.0356445312, -117),
		[7] = Vector(9727.6416015625, 1040.2574462891, -117)
	},
	printName = "Пожарная станция №96",
	printStr = "Haviture way 5",
	height = 500,
	police_zone = true,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["club"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-6325, 4300, -45),
		[2] = Vector(-6325, 7750, -45),
		[3] = Vector(-9420, 7750, -45),
		[4] = Vector(-9420, 4330, -45)
	},
	printName = "Клуб",
	printStr = "Pleasant road 2",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["correctional_center"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-14174, -9220, -557),
		[2] = Vector(-14174, -11276, -557),
		[3] = Vector(-11327, -11276, -557),
		[4] = Vector(-11327, -9220, -557)
	},
	printName = "Заброшенный склад",
	printStr = "Any way 119",
	height = 1000,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["townhall"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(2239.0324707031, 4510, -20),
		[2] = Vector(3478.5051269531, 4510, -20),
		[3] = Vector(3478.5051269531, 5694.9995117188, -20),
		[4] = Vector(3328.03125, 5760.1123046875, -20),
		[5] = Vector(3328.03125, 6271.701171875, -20),
		[6] = Vector(2815.8488769531, 6271.4443359375, -20),
		[7] = Vector(2814.1491699219, 5763.1396484375, -20),
		[8] = Vector(2239.0324707031, 5694.9995117188, -20)
	},
	printName = "Ратуша",
	printStr = "New life street 5",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["hospital"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(6208.6225585938, 4351.96875, -70),
		[2] = Vector(8128.03125, 4351.96875, -70),
		[3] = Vector(8128.03125, 5759.5834960938, -70),
		[4] = Vector(6208.6225585938, 5759.5834960938, -70)
	},
	printName = "Медицинский центр",
	printStr = "New life street 1",
	height = 750,
	police_zone = true,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["macmillanscon"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(3386, -936, -109),
		[2] = Vector(3459, -936, -109),
		[3] = Vector(3459, -1018, -109),
		[4] = Vector(3386, -1018, -109)
	},
	printName = "Macmillan's corner",
	printStr = "Union square",
	height = 150,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false,
}

ters["aroom"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(7162.9580078125, 5114.96875, -765),
		[2] = Vector(7162.96875, 4933.791015625, -765),
		[3] = Vector(6981.03125, 4933.419921875, -765),
		[4] = Vector(6981.03125, 5113.6069335938, -765)
	},
	printName = "???",
	printStr = "Staten Island",
	height = 150,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false,
}

ters["big_wherehouse"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-9599.96875, 2696, -40),
		[2] = Vector(-8834.15625, 2696, -40),
		[3] = Vector(-8576.826171875, 3584, -40),
		[4] = Vector(-8576.826171875, 3967, -40),
		[5] = Vector(-9599.2724609375, 3967, -40)
	},
	gps_point = Vector(-9211.5732421875, 2874.0891113281, 5),
	printName = "Большая мастерская",
	printStr = "Pleasant road 4",
	terDescr = "Нежилое мануфактурное помещение с выходом на 2 этаж. Имеется гаражная дверь для упрощения логистики. Выход на задний двор осуществляется через балкон на 2 этаже.\n\n\nЗадний двор недоступен посторонним - только собственникам примыкающих помещений. 2 этаж хорошо вентилируется, работа снизу не помешает бумажной волоките сверху.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 880,
	camPos = Vector(-9061.0556640625, 2516.4931640625, 270.33801269531),
	camAng = Angle(5.8894119262695, 100.59911346436, 0),
	mailbox = {
		Vector(-8369,3744.75,-10.375),
		Angle(0.032958984375,88.379516601563,-0.010986328125)
	}
}

-- Union Squre

ters["us_art_3_i"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1824.1925048828, 3103.8891601563, 690),
		[2] = Vector(1760.1649169922, 3256.1147460938, 690),
		[3] = Vector(1760.1243896484, 3415.8510742188, 690),
		[4] = Vector(2304.03125, 3455.4509277344, 690),
		[5] = Vector(2304.03125, 2937.8193359375, 690),
		[6] = Vector(1983.96875, 2943.1823730469, 690),
		[7] = Vector(1983.96875, 3103.6975097656, 690)
	},
	gps_point = Vector(1900.9357910156, 3089.2915039063, 696.03125),
	printName = "Квартира I",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Просторная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на самую оживлённую улицу района.\n\n\nКвартира на 4 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_3_j"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(2304.03125, 2688.03125, 690),
		[2] = Vector(1660, 2688.03125, 690),
		[3] = Vector(1660, 2369, 690),
		[4] = Vector(2304.03125, 2369, 690)
	},
	gps_point = Vector(1902.5036621094, 2682.75390625, 696.03125),
	printName = "Квартира J",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Скромная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на сквер и залив Аппер.\n\n\nКвартира на 4 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_3_l"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1151.8778076172, 3103.5439453125, 690),
		[2] = Vector(1183.96875, 3272.0363769531, 690),
		[3] = Vector(1183.96875, 3431.9226074219, 690),
		[4] = Vector(703.96875, 3431.9226074219, 690),
		[5] = Vector(703.96875, 2904.49609375, 690),
		[6] = Vector(992.03125, 2904.49609375, 690),
		[7] = Vector(992.41491699219, 3103.5439453125, 690)
	},
	gps_point = Vector(1065.7877197266, 3099.041015625, 696.03125),
	printName = "Квартира L",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Скромная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на сквер и залив Аппер.\n\n\nКвартира на 4 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_3_k"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(703.96875, 2688.03125, 690),
		[2] = Vector(1344.03125, 2688.03125, 690),
		[3] = Vector(1344.03125, 2369, 690),
		[4] = Vector(703.96875, 2369, 690)
	},
	gps_point = Vector(1075.3187255859,2702.6791992188, 696.03125),
	printName = "Квартира K",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Просторная однокомнатная квартира с обустроенной ванной комнатой. Вид из окна на бизнес-центр.\n\n\nКвартира на 4 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_2_e"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1824.1925048828, 3103.8891601563, 425),
		[2] = Vector(1760.1649169922, 3256.1147460938, 425),
		[3] = Vector(1760.1243896484, 3415.8510742188, 425),
		[4] = Vector(2304.03125, 3455.4509277344, 425),
		[5] = Vector(2304.03125, 2937.8193359375, 425),
		[6] = Vector(1983.96875, 2943.1823730469, 425),
		[7] = Vector(1983.96875, 3103.6975097656, 425)
	},
	gps_point = Vector(1900.9357910156, 3089.2915039063, 428),
	printName = "Квартира E",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Просторная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на самую оживлённую улицу района.\n\n\nКвартира на 3 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_2_f"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(2304.03125, 2688.03125, 425),
		[2] = Vector(1660, 2688.03125, 425),
		[3] = Vector(1660, 2369, 425),
		[4] = Vector(2304.03125, 2369, 425)
	},
	gps_point = Vector(1902.5036621094, 2682.75390625, 428),
	printName = "Квартира F",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Скромная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на сквер и залив Аппер.\n\n\nКвартира на 3 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_2_h"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1151.8778076172, 3103.5439453125, 425),
		[2] = Vector(1183.96875, 3272.0363769531, 425),
		[3] = Vector(1183.96875, 3431.9226074219, 425),
		[4] = Vector(703.96875, 3431.9226074219, 425),
		[5] = Vector(703.96875, 2904.49609375, 425),
		[6] = Vector(992.03125, 2904.49609375, 425),
		[7] = Vector(992.41491699219, 3103.5439453125, 425)
	},
	gps_point = Vector(1065.7877197266, 3099.041015625, 428),
	printName = "Квартира H",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Просторная однокомнатная квартира с обустроенной ванной комнатой. Вид из окна на бизнес-центр.\n\n\nКвартира на 3 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_2_g"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(703.96875, 2688.03125, 425),
		[2] = Vector(1344.03125, 2688.03125, 425),
		[3] = Vector(1344.03125, 2369, 425),
		[4] = Vector(703.96875, 2369, 425)
	},
	gps_point = Vector(1075.3187255859,2702.6791992188,432.03125),
	printName = "Квартира G",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Скромная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на сквер и залив Аппер.\n\n\nКвартира на 3 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_1_a"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1824.1925048828, 3103.8891601563, 156),
		[2] = Vector(1760.1649169922, 3256.1147460938, 156),
		[3] = Vector(1760.1243896484, 3415.8510742188, 156),
		[4] = Vector(2304.03125, 3455.4509277344, 156),
		[5] = Vector(2304.03125, 2937.8193359375, 156),
		[6] = Vector(1983.96875, 2943.1823730469, 156),
		[7] = Vector(1983.96875, 3103.6975097656, 156)
	},
	gps_point = Vector(1900.9357910156, 3089.2915039063, 159),
	printName = "Квартира A",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Просторная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на самую оживлённую улицу района.\n\n\nКвартира на 2 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_1_b"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(2304.03125, 2688.03125, 156),
		[2] = Vector(1660, 2688.03125, 156),
		[3] = Vector(1660, 2369, 156),
		[4] = Vector(2304.03125, 2369, 156)
	},
	gps_point = Vector(1902.5036621094, 2682.75390625, 159),
	printName = "Квартира B",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Скромная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на сквер и залив Аппер.\n\n\nКвартира на 2 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_1_d"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1151.8778076172, 3103.5439453125, 156),
		[2] = Vector(1183.96875, 3272.0363769531, 156),
		[3] = Vector(1183.96875, 3431.9226074219, 156),
		[4] = Vector(703.96875, 3431.9226074219, 156),
		[5] = Vector(703.96875, 2904.49609375, 156),
		[6] = Vector(992.03125, 2904.49609375, 156),
		[7] = Vector(992.41491699219, 3103.5439453125, 156)
	},
	gps_point = Vector(1065.7877197266, 3099.041015625, 159),
	printName = "Квартира D",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Просторная однокомнатная квартира с обустроенной ванной комнатой. Вид из окна на бизнес-центр.\n\n\nКвартира на 2 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

ters["us_art_1_c"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(703.96875, 2688.03125, 156),
		[2] = Vector(1344.03125, 2688.03125, 156),
		[3] = Vector(1344.03125, 2369, 156),
		[4] = Vector(703.96875, 2369, 156)
	},
	gps_point = Vector(1075.3187255859,2702.6791992188, 159),
	printName = "Квартира C",
	printStr = "Union square 5",
	noDoorAction = true,
	terDescr = "Скромная однокомнатная квартира с обустроенной ванной комнатой. Красивый вид из окна на сквер и залив Аппер.\n\n\nКвартира на 2 этаже, есть лифт. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	group = "UnionSqure",
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(1475.5316162109, 1414.4315185547, 634.32153320313),
	camAng = Angle(7.2477402687073, 90.014938354492, 0),
}

-- Дома

ters["big_house_1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(3114.8464355469, 9925.9599609375, -70),
		[2] = Vector(3114.8464355469, 11270.637695313, -70),
		[3] = Vector(4096.6108398438, 11270.637695313, -70),
		[4] = Vector(4096.6108398438, 9925.9599609375, -70)
	},
	gps_point = Vector(3193.7426757813,10479.520507813,158.31924438477),
	printName = "Дом 1",
	printStr = "Maple road 1",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(2659.8471679688, 10812.491210938, 322.43353271484),
	camAng = Angle(8.1096248626709, -21.1969871521, 0),
	mailbox = {
		Vector(2799.59375,10676.90625,128.34375),
		Angle(0.032958984375,178.92883300781,-0.010986328125)
	}
}

ters["big_house_2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-1793.8757324219, 13200, -70),
		[2] = Vector(-752.56866455078, 13200, -70),
		[3] = Vector(-752.56866455078, 14265, -70),
		[4] = Vector(-1793.8757324219, 14265, -70)
	},
	gps_point = Vector(-1152.7565917969, 13193, 150.03125),
	printName = "Дом 2",
	printStr = "Maple road 2",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-902.94104003906, 12628.560546875, 351.31268310547),
	camAng = Angle(12.090915679932, 111.7723236084, 0),
	mailbox = {
		Vector(-1170.75,12781.71875,128.34375),
		Angle(0.032958984375,-91.466674804688,-0.010986328125)
	}
}

ters["big_house_3"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-2813, 13200, -70),
		[2] = Vector(-1793.8757324219, 13200, -70),
		[3] = Vector(-1793.8757324219, 14265, -70),
		[4] = Vector(-2813, 14265, -70)
	},
	gps_point = Vector(-2172.2333984375, 13193, 150.03125),
	printName = "Дом 3",
	printStr = "Maple road 3",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-2111.919921875, 12656.87890625, 350.24728393555),
	camAng = Angle(6.0386261940002, 94.834739685059, 0),
	mailbox = {
		Vector(-2192.3125,12782.21875,128.34375),
		Angle(0.032958984375,-91.466674804688,-0.010986328125)
	}
}

ters["big_house_4"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4793, 13200, -70),
		[2] = Vector(-3715.0356445313, 13200, -70),
		[3] = Vector(-3715.0356445313, 14265, -70),
		[4] = Vector(-4793, 14265, -70)
	},
	gps_point = Vector(-4216.5874023438, 13193, 118.03125),
	printName = "Дом 4",
	printStr = "Maple road 4",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-3895.7390136719, 12646.131835938, 236.6900177002),
	camAng = Angle(4.0476331710815, 108.93083190918, 0),
	mailbox = {
		Vector(-3979.375,12782.4375,128.34375),
		Angle(0.032958984375,-91.466674804688,-0.010986328125)
	}
}

ters["big_house_5"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4793, 13200, -70),
		[2] = Vector(-5764.9165039063, 13200, -70),
		[3] = Vector(-5764.9165039063, 14265, -70),
		[4] = Vector(-4793, 14265, -70)
	},
	gps_point = Vector(-5245.9599609375, 13193, 118.03125),
	printName = "Дом 5",
	printStr = "Maple road 5",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-4962.857421875, 12676.827148438, 305.75982666016),
	camAng = Angle(10.49319934845, 110.87144470215, 0),
	mailbox = {
		Vector(-4887.125,12785.5,128.34375),
		Angle(0.032958984375,-91.466674804688,-0.010986328125)
	}
}

ters["big_house_6"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-5764.9165039063, 13200, -70),
		[2] = Vector(-7044.4448242188, 13200, -70),
		[3] = Vector(-7044.4448242188, 14535, -70),
		[4] = Vector(-5764.9165039063, 14535, -70)
	},
	gps_point = Vector(-6178.5258789063, 13193, 128.03125),
	printName = "Дом 6",
	printStr = "Maple road 6",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-5955.7119140625, 12695.837890625, 301.08874511719),
	camAng = Angle(10.180116653442, 110.28466796875, 0),
	mailbox = {
		Vector(-6085.03125,12780.90625,128.34375),
		Angle(0.032958984375,-91.466674804688,-0.010986328125)
	}
}

ters["motel_10"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3030, 768, 70),
		[2] = Vector(-3600, 768, 70),
		[3] = Vector(-3600, 1155, 70),
		[4] = Vector(-3030, 1155, 70)
	},
	gps_point = Vector(-3616.369140625,864.8115234375,80.031242370605),
	printName = "Мотель 10",
	printStr = "Any way 133",
	terDescr = "Номер на 2 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_9"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3950, 1856, 70),
		[2] = Vector(-3950, 1190, 70),
		[3] = Vector(-3600, 1190, 70),
		[4] = Vector(-3600, 1856, 70)
	},
	gps_point = Vector(-3892.5668945313,1204.1319580078,80.031242370605),
	printName = "Мотель 9",
	printStr = "Any way 133",
	terDescr = "Номер на 2 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_8"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3950, 1190, 70),
		[2] = Vector(-4340, 1190, 70),
		[3] = Vector(-4340, 1856, 70),
		[4] = Vector(-3950, 1856, 70)
	},
	gps_point = Vector(-4259.3881835938,1199.96875,80.03125),
	printName = "Мотель 8",
	printStr = "Any way 133",
	terDescr = "Номер на 2 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_7"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4348, 1190, 70),
		[2] = Vector(-4727, 1190, 70),
		[3] = Vector(-4727, 1856, 70),
		[4] = Vector(-4348, 1856, 70)
	},
	gps_point = Vector(-4662.7001953125,1204.46875,80.03125),
	printName = "Мотель 7",
	printStr = "Any way 133",
	terDescr = "Номер на 2 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_6"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4727, 1856, 70),
		[2] = Vector(-4727, 1190, 70),
		[3] = Vector(-5120, 1190, 70),
		[4] = Vector(-5120, 1856, 70)
	},
	gps_point = Vector(-4795.939453125,1200.4605712891,80.03125),
	printName = "Мотель 6",
	printStr = "Any way 133",
	terDescr = "Номер на 2 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_5"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3030, 768, -97),
		[2] = Vector(-3600, 768, -97),
		[3] = Vector(-3600, 1155, -97),
		[4] = Vector(-3030, 1155, -97)
	},
	gps_point = Vector(-3616.369140625,864.8115234375,-95),
	printName = "Мотель 5",
	printStr = "Any way 133",
	terDescr = "Номер на 1 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_4"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3950, 1856, -97),
		[2] = Vector(-3950, 1190, -97),
		[3] = Vector(-3600, 1190, -97),
		[4] = Vector(-3600, 1856, -97)
	},
	gps_point = Vector(-3892.5668945313,1204.1319580078,-95),
	printName = "Мотель 4",
	printStr = "Any way 133",
	terDescr = "Номер на 1 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_3"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3950, 1190, -97),
		[2] = Vector(-4340, 1190, -97),
		[3] = Vector(-4340, 1856, -97),
		[4] = Vector(-3950, 1856, -97)
	},
	gps_point = Vector(-4259.3881835938,1199.96875,-95),
	printName = "Мотель 3",
	printStr = "Any way 133",
	terDescr = "Номер на 1 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4348, 1190, -97),
		[2] = Vector(-4727, 1190, -97),
		[3] = Vector(-4727, 1856, -97),
		[4] = Vector(-4348, 1856, -97)
	},
	gps_point = Vector(-4662.7001953125,1204.46875,-95),
	printName = "Мотель 2",
	printStr = "Any way 133",
	terDescr = "Номер на 1 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["motel_1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4727, 1856, -97),
		[2] = Vector(-4727, 1190, -97),
		[3] = Vector(-5120, 1190, -97),
		[4] = Vector(-5120, 1856, -97)
	},
	gps_point = Vector(-4795.939453125,1200.4605712891,-95),
	printName = "Мотель 1",
	printStr = "Any way 133",
	terDescr = "Номер на 1 этаже предлагает двухместную кровать, кабельное ТВ, просторный гардероб и рабочий туалет. Температура комфортная круглый год, комнаты в приличном состоянии.\n\n\nПо всем вопросам - в том числе за доступом к душу - обращаться на ресепшен.",
	height = 170,
	group = "Мотель",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 70,
	camPos = Vector(-3499.3510742188,-338.45394897461,339.62677001953),
	camAng = Angle(10.151799201965,131.47439575195,0),
}

ters["le_grande_6"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(7872, 1870, 760),
		[2] = Vector(7167, 1870, 760),
		[3] = Vector(7167, 2430, 760),
		[4] = Vector(7872, 2430, 760)
	},
	gps_point = Vector(7537.5346679688,1888.4642333984,768.03125),
	printName = "Номер 6",
	printStr = "Grand way 2",
	terDescr = "Пентхаус-номер на 4 этаже предоставит вам роскошные условия под любые ваши желания или проведение бизнес-встреч. В номере присутствует бар, настоящий камин, прекрасная шумоизоляция и невообразимый вид на Бруклин. На том же этаже есть публичный бассеин - а если вы предпочитаете приватность, то личный бассеин в ванной комнате примет вас в любую минуту.\n\n\nЕсть лифт. Ежедневное обслуживание номеров, 3 раза в день. По всем вопросам обращаться на ресепшен.",
	height = 170,
	group = "LeGrande",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 320,
	camPos = Vector(5486.7260742188,2353.056640625,572.18054199219),
	camAng = Angle(9.1570863723755,-30.408029556274,0)
}

ters["le_grande_5"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(7175, 1023, 760),
		[2] = Vector(6592, 1023, 760),
		[3] = Vector(6592, 385, 760),
		[4] = Vector(7410, 385, 760),
		[5] = Vector(7410, 623, 760),
		[6] = Vector(7175, 623, 760)
	},
	gps_point = Vector(7134.021484375,705.79058837891,768.03125),
	printName = "Номер 5",
	printStr = "Grand way 2",
	terDescr = "Пентхаус-номер на 4 этаже предоставит вам роскошные условия под любые ваши желания или проведение бизнес-встреч. В номере присутствует бар, настоящий камин, прекрасная шумоизоляция и невообразимый вид на Бруклин. На том же этаже есть публичный бассеин - а если вы предпочитаете приватность, то личный бассеин в ванной комнате примет вас в любую минуту.\n\n\nЕсть лифт. Ежедневное обслуживание номеров, 3 раза в день. По всем вопросам обращаться на ресепшен.",
	height = 170,
	group = "LeGrande",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 320,
	camPos = Vector(5486.7260742188,2353.056640625,572.18054199219),
	camAng = Angle(9.1570863723755,-30.408029556274,0)
}

ters["le_grande_4"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(7610, 1900, 445),
		[2] = Vector(7842, 1900, 445),
		[3] = Vector(7842, 2400, 445),
		[4] = Vector(7211, 2400, 445),
		[5] = Vector(7211, 2055, 445),
		[6] = Vector(7610, 2055, 445)
	},
	gps_point = Vector(7699.2670898438,1920.96875,448.03125),
	printName = "Номер 4",
	printStr = "Grand way 2",
	terDescr = "Изысканный номер на 3 этаже предоставит вам роскошные условия под любые ваши желания. В номере присутствует бар, прекрасная шумоизоляция и иные блага для комфортного времяпровождения. Ванная комната всегда готова обслужить любые ваши запросы - в том числе косметические. Здесь вы отдохнёте!\n\n\nЕсть лифт. Ежедневное обслуживание номеров, 3 раза в день. По всем вопросам обращаться на ресепшен.",
	height = 170,
	group = "LeGrande",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 280,
	camPos = Vector(5486.7260742188,2353.056640625,572.18054199219),
	camAng = Angle(9.1570863723755,-30.408029556274,0)
}

ters["le_grande_3"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(7660, 1588, 445),
		[2] = Vector(7660, 1720, 445),
		[3] = Vector(7614, 1720, 445),
		[4] = Vector(7614, 2055, 445),
		[5] = Vector(7175, 2055, 445),
		[6] = Vector(7175, 1585, 445)
	},
	gps_point = Vector(7631.03125,1656.1840820313,448.03125),
	printName = "Номер 3",
	printStr = "Grand way 2",
	terDescr = "Изысканный номер на 3 этаже предоставит вам роскошные условия под любые ваши желания. В номере присутствует бар, прекрасная шумоизоляция и иные блага для комфортного времяпровождения. Ванная комната всегда готова обслужить любые ваши запросы - в том числе косметические. Здесь вы отдохнёте!\n\n\nЕсть лифт. Ежедневное обслуживание номеров, 3 раза в день. По всем вопросам обращаться на ресепшен.",
	height = 170,
	group = "LeGrande",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 280,
	camPos = Vector(5486.7260742188,2353.056640625,572.18054199219),
	camAng = Angle(9.1570863723755,-30.408029556274,0)
}

ters["le_grande_2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(7610, 1900, 125),
		[2] = Vector(7842, 1900, 125),
		[3] = Vector(7842, 2400, 125),
		[4] = Vector(7211, 2400, 125),
		[5] = Vector(7211, 2055, 125),
		[6] = Vector(7610, 2055, 125)
	},
	gps_point = Vector(7694.6684570313,1920.96875,128.03125),
	printName = "Номер 2",
	printStr = "Grand way 2",
	terDescr = "Изысканный номер на 2 этаже предоставит вам роскошные условия под любые ваши желания. В номере присутствует бар, прекрасная шумоизоляция и иные блага для комфортного времяпровождения. Ванная комната всегда готова обслужить любые ваши запросы - в том числе косметические. Здесь вы отдохнёте!\n\n\nЕсть лифт. Ежедневное обслуживание номеров, 3 раза в день. По всем вопросам обращаться на ресепшен.",
	height = 170,
	group = "LeGrande",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 280,
	camPos = Vector(5486.7260742188,2353.056640625,572.18054199219),
	camAng = Angle(9.1570863723755,-30.408029556274,0)
}

ters["le_grande_1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(7660, 1588, 125),
		[2] = Vector(7660, 1720, 125),
		[3] = Vector(7614, 1720, 125),
		[4] = Vector(7614, 2055, 125),
		[5] = Vector(7175, 2055, 125),
		[6] = Vector(7175, 1585, 125)
	},
	gps_point = Vector(7631.03125,1659.3414306641,128.03125),
	printName = "Номер 1",
	printStr = "Grand way 2",
	terDescr = "Изысканный номер на 2 этаже предоставит вам роскошные условия под любые ваши желания. В номере присутствует бар, прекрасная шумоизоляция и иные блага для комфортного времяпровождения. Ванная комната всегда готова обслужить любые ваши запросы - в том числе косметические. Здесь вы отдохнёте!\n\n\nЕсть лифт. Ежедневное обслуживание номеров, 3 раза в день. По всем вопросам обращаться на ресепшен.",
	height = 170,
	group = "LeGrande",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 280,
	camPos = Vector(5486.7260742188,2353.056640625,572.18054199219),
	camAng = Angle(9.1570863723755,-30.408029556274,0)
}

ters["elec_shop"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-326, 11900, 120),
		[2] = Vector(-326, 11645, 120),
		[3] = Vector(-132, 11645, 120),
		[4] = Vector(-132, 11100, 120),
		[5] = Vector(-1112.0639648438, 11211.478515625, 120),
		[6] = Vector(-1150, 11900, 120)
	},
	gps_point = Vector(-717.04272460938,11513,136.03125),
	printName = "Магазин",
	printStr = "Maple road 12",
	terDescr = "Нежилое коммерческое помещение с соразмерной служебной комнатой. Имеется запасной выход и удобная парковка.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты.",
	height = 260,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 75,
	camPos = Vector(-1525.5567626953, 11936.8359375, 480.16012573242),
	camAng = Angle(22.663391113281, -45.408428192139, 0),
	mailbox = {
		Vector(-296.46875,11634.59375,128.34375),
		Angle(0.032958984375,179.82971191406,-0.010986328125)
	}
}

ters["guns_shop"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-1560, 10750, 125),
		[2] = Vector(-1560, 9735, 125),
		[3] = Vector(-140, 9735, 125),
		[4] = Vector(-140, 10750, 125)
	},
	printName = "Большой магазин",
	printStr = "Maple road 11",
	gps_point = Vector(-1024.03125,10425.068359375,136.03125),
	height = 200,
	terDescr = "Нежилое коммерческое здание с гигантским служебным помещением под мануфактурные нужды. Имеется запасной выход и удобная парковка.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Позади здания установлена лестница для доступа к кондиционерам.",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 200,
	camPos = Vector(-1819.2838134766, 10100.209960938, 299.82830810547),
	camAng = Angle(9.7472562789917, 30.356607437134, 0),
	mailbox = {
		Vector(-951.28125,10000.78125,128.34375),
		Angle(0.032958984375,178.92883300781,-0.010986328125)
	}
}

ters["cafe"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1435, 11445, 125),
		[2] = Vector(1435, 10628, 125),
		[3] = Vector(492, 10628, 125),
		[4] = Vector(492, 11445, 125)
	},
	printName = "Дайнер",
	printStr = "North street 14",
	gps_point = Vector(959,10952,168),
	height = 320,
	terDescr = "Нежилое коммерческое здание, оборудованное под классический американский дайнер. Примыкает к оживлённой улице, просторная парковка исключит инциденты.\n\n\nКухня полностью оборудована под любое меню. Мощная морозильная камера поддержит свежесть любых ингредиентов.",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 300,
	camPos = Vector(941, 10179, 316),
	camAng = Angle(13.133036613464, 87.515487670898, 0),
	buySpawn = {
		{ e = "workstation_cook", p = Vector(820,11325,168), a = Angle(0,0,0), m = "models/unioncity2/props_fastfood/kitchen_stove01.mdl", sf = function(ent, ter)
			ent:SetSpace(100)
			ter.propetytype = "food"
			TerritoriesInfoUpdate()
		end},
	},
	mailbox = {
		Vector(1499.21875,10738.5,136.3125),
		Angle(0.032958984375,178.92883300781,-0.010986328125)
	}
}

ters["big_house_7"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4735, 11603, -70),
		[2] = Vector(-4744, 10587, -70),
		[3] = Vector(-3721, 10651, -70),
		[4] = Vector(-3713, 11603, -70)
	},
	printName = "Дом 7",
	printStr = "Maple road 7",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	gps_point = Vector(-4147,11318,168),
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-3935.31640625, 12328.953125, 253.86293029785),
	camAng = Angle(2.2232458591461, -105.13799285889, 0),
	mailbox = {
		Vector(-3962.21875,11925.78125,128.34375),
		Angle(0.032958984375,94.279174804688,-0.010986328125)
	}
}

ters["big_house_8"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-4736, 11603, -70),
		[2] = Vector(-4744, 10587, -70),
		[3] = Vector(-5752, 10599, -70),
		[4] = Vector(-5761, 11603, -70)
	},
	gps_point = Vector(-5186,11318,168),
	printName = "Дом 8",
	printStr = "Maple road 8",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-5036.8559570313, 12236.2578125, 279.76538085938),
	camAng = Angle(9.9353256225586, -105.95318603516, 0),
	mailbox = {
		Vector(-4988.84375,11920.625,128.34375),
		Angle(0.032958984375,93.081665039063,-0.010986328125)
	}
}

ters["big_house_9"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	gps_point = Vector(-6227,11318,160),
	coords = {
		[1] = Vector(-5760, 11603, -70),
		[2] = Vector(-5750, 10165, -70),
		[3] = Vector(-7036, 10190, -70),
		[4] = Vector(-7039, 11603, -70)
	},
	printName = "Дом 9",
	printStr = "Maple road 9",
	terDescr = "Уютный одноэтажный дом предлагает просторную гостиную, две спальни, выделенную кухню и роскошную ванную комнату. Дом имеет большой гараж и функциональный подвал - всё что нужно для развития хобби у мужчины!\n\n\nСобственность числится в Ассоциации Домовладельцев: есть ограничения по архитектурному ремоделированию, смене внешнего покрытия дома, парковке личного транспорта на дороге. Ассоциация Домовладельцев имеет право налагать штрафы и расторгать договор аренды при нахождении нарушений из статей своего CC&R. Ассоциация Домовладельцев берёт на себя все расходы по обслуживанию близлежащих дорог, лужаек, заборов и дворов.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "big_house",
	price = 1300,
	camPos = Vector(-6097.2392578125, 11866.982421875, 258.67755126953),
	camAng = Angle(5.9852108955383, -100.93721008301, 0),
	mailbox = {
		Vector(-6212.5,11918.8125,128.34375),
		Angle(0.032958984375,139.92736816406,-0.010986328125)
	}
}

ters["workshop1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3839, 5916, 45),
		[2] = Vector(-3840, 7351, 45),
		[3] = Vector(-4710, 7362, 45),
		[4] = Vector(-4673, 5914, 45)
	},
	printName = "Мастерская",
	printStr = "Crooked lane 4",
	terDescr = "Нежилое мануфактурное помещение, с местом под офис и выходом на задний двор. Имеется гаражная дверь для упрощения логистики.\n\n\nВъезд через переулок. Задний двор недоступен посторонним - только собственникам примыкающих помещений. Помещение хорошо вентилируется.",
	height = 200,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "workshop",
	price = 700,
	camPos = Vector(-3344.8371582031, 5867.205078125, 300.03247070313),
	camAng = Angle(15.737697601318, 145.53102111816, 0),
	mailbox = {
		Vector(-4244.59375,7189.09375,128.34375),
		Angle(0.032958984375,88.379516601563,-0.010986328125)
	}
}

ters["workshop2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-1832.5584716797, 6450.8354492188, -10),
		[2] = Vector(-2432.03125, 6455.3188476563, -10),
		[3] = Vector(-2432.03125, 6591.9272460938, -10),
		[4] = Vector(-2671.8422851563, 6591.96875, -10),
		[5] = Vector(-2701.1062011719, 5951.615234375, -10),
		[6] = Vector(-1840.9039306641, 5951.9262695313, -10)
	},
	gps_point = Vector(-2013.4729003906,6459.6640625,53.321105957031),
	printName = "Авто Мастерская",
	printStr = "Gho street 2",
	terDescr = "Нежилое коммерческое помещение, оборудованное под авто-мастерскую. Удобный заезд с улицы внутрь. Есть запасной выход в переулок\n\n\nПод аренду сдаётся левая часть здания. Установлен автоподъёмник под малогабаритный транспорт.",
	height = 290,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "workshop",
	price = 370,
	camPos = Vector(-1119.3549804688, 6437.3828125, 324.36276245117),
	camAng = Angle(12.163775444031, 179.30313110352, 0),
	mailbox = {
		Vector(-2519.25,6165.96875,8.34375),
		Angle(0.032958984375,88.379516601563,-0.010986328125)
	}
}

ters["shop1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(862, 6700, 7),
		[2] = Vector(257, 6700, 7),
		[3] = Vector(268, 7742, 7),
		[4] = Vector(858, 7742, 7)
	},
	printName = "Магазин",
	printStr = "13th street 3",
	terDescr = "Нежилое коммерческое помещение с компактной служебной комнатой. Улица оживлённая, есть парковка прямо перед входом. Имеется запасной выход в переулок.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Установлена новая вентиляционная система.",
	height = 250,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 300,
	camPos = Vector(642.10223388672, 6084.740234375, 205.25006103516),
	camAng = Angle(5.9564604759216, 89.195091247559, 0),
	mailbox = {
		Vector(184.34375,7641.90625,16.34375),
		Angle(0.032958984375,-91.763305664063,-0.010986328125)
	}
}

ters["shop2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1919, 6530, 7),
		[2] = Vector(1280, 6530, 7),
		[3] = Vector(1279, 7556, 7),
		[4] = Vector(1901, 7557, 7)
	},
	printName = "Магазин",
	printStr = "13th street 2",
	terDescr = "Нежилое коммерческое помещение с компактной служебной комнатой. Рядом со входом парковка. Имеется запасной выход в переулок.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Установлена новая вентиляционная система.",
	height = 250,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 250,
	camPos = Vector(1617.9182128906, 6177.5107421875, 166.15048217773),
	camAng = Angle(8.652606010437, 82.384338378906, 0),
	mailbox = {
		Vector(1260.6875,7551.5625,16.34375),
		Angle(0.032958984375,-82.913818359375,-0.010986328125)
	}
}

ters["shop3"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(3584, 6140, 7),
		[2] = Vector(4159, 6140, 7),
		[3] = Vector(4158, 7182, 7),
		[4] = Vector(3417, 7182, 7),
		[5] = Vector(3453, 6857, 7),
		[6] = Vector(3584, 6521, 7)
	},
	printName = "Магазин",
	printStr = "Aversion avenue 1",
	terDescr = "Нежилое коммерческое помещение с компактной служебной комнатой. Примыкает к скверу с ратушей - поток посетилелей обеспечен. Имеется запасной выход в переулок.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Установлена новая вентиляционная система.",
	height = 250,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 400,
	camPos = Vector(3890.0446777344, 5883.5571289063, 215.08731079102),
	camAng = Angle(11.34881401062, 87.706481933594, 0),
	mailbox = {
		Vector(3545.75,7243.6875,20.34375),
		Angle(0.032958984375,26.229858398438,-0.010986328125)
	}
}

ters["shop4"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(4600, 5157, -59),
		[2] = Vector(5630, 5155, -59),
		[3] = Vector(5630, 5713, -59),
		[4] = Vector(4600, 5697, -59)
	},
	gps_point = Vector(5132,5545.2485351563,-47.060127258301),
	printName = "Магазин",
	printStr = "New life street 4",
	terDescr = "Нежилое коммерческое помещение с компактной служебной комнатой. Примыкает к скверу с ратушей - поток посетилелей обеспечен. Имеется запасной выход в переулок.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Установлена новая вентиляционная система.",
	height = 205,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 400,
	camPos = Vector(4262.8544921875, 5435.7329101563, 190.30474853516),
	camAng = Angle(19.277751922607, -0.23589228093624, 0),
	mailbox = {
		Vector(5635.21875,5378.53125,-55.625),
		Angle(0.032958984375,73.179931640625,-0.010986328125)
	}
}

ters["shop5"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(4600, 5157, -59),
		[2] = Vector(5630, 5155, -59),
		[3] = Vector(5630, 4579, -59),
		[4] = Vector(4600, 4597, -59)
	},
	gps_point = Vector(5132,4773.8911132813,-47.96875),
	printName = "Магазин",
	printStr = "New life street 3",
	terDescr = "Нежилое коммерческое помещение с компактной служебной комнатой. Примыкает к скверу с ратушей - поток посетилелей обеспечен. Имеется запасной выход в переулок.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Установлена новая вентиляционная система.",
	height = 205,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 400,
	camPos = Vector(4333.9545898438, 4750.3120117188, 135.52001953125),
	camAng = Angle(18.556411743164, 13.472339630127, 0),
	mailbox = {
		Vector(5634.5625,4931.875,-55.625),
		Angle(0.032958984375,0.977783203125,-0.010986328125)
	}
}

ters["pwanshop"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(4250, 7507, 125),
		[2] = Vector(3739, 7497, 125),
		[3] = Vector(3758, 8770, 125),
		[4] = Vector(4275, 8770, 125),
		[5] = Vector(4264, 7927, 125)
	},
	printName = "Ломбард",
	printStr = "North street 9",
	terDescr = "Нежилое коммерческое помещение, оборудованное под ломбард. Доступная парковка прямо у входа. Имеется запасной выход в переулок.\n\n\nВ публичной части установлен банкомат. Подключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Служебное помещение защищено от взломов со стороны переулка.",
	gps_point = Vector(4016.8337402344,8387.25,136.03125),
	height = 250,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 140,
	camPos = Vector(4308.7392578125, 9061.814453125, 340.54742431641),
	camAng = Angle(4.0757083892822, -129.6580657959, 0),
	mailbox = {
		Vector(4245.53125,7639.65625,128.34375),
		Angle(0.032958984375,-177.21496582031,-0.010986328125)
	}
}

ters["Bar"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(4480, 8770, -115),
		[2] = Vector(4480, 6958, -115),
		[3] = Vector(5522, 6950, -115),
		[4] = Vector(5552, 7723, -115),
		[5] = Vector(5450, 7708, -115),
		[6] = Vector(5450, 8770, -115)
	},
	gps_point = Vector(5141.6694335938,8476.03515625,144.03125),
	printName = "Бар",
	printStr = "Whiskey road 2",
	terDescr = "Нежилое коммерческое помещение, оборудованное под бар в ирландском стиле, в шаговой доступности от полицейского участка. Служебная часть разделена на офис и рабочую зону. Доступная парковка прямо у входа. Имеется запасной выход в переулок.\n\n\nЕсть караоке-зона с современной акустикой. Офис подготовлен для внезапных бизнес-встреч.",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 700,
	camPos = Vector(5585.5932617188, 8924.9912109375, 255.55662536621),
	camAng = Angle(6.361433506012, -138.52172851563, 0),
	mailbox = {
		Vector(4456.6875,7791.84375,128.34375),
		Angle(0.032958984375,-177.21496582031,-0.010986328125)
	}
}

ters["apr_13_8"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1565, 4976, 556),
		[2] = Vector(1565, 5183, 556),
		[3] = Vector(1408, 5312, 556),
		[4] = Vector(1405, 5569, 556),
		[5] = Vector(896, 5568, 556),
		[6] = Vector(895, 4981, 556)
	},
	printName = "Квартира 8",
	printStr = "13th street 1",
	noDoorAction = true,
	terDescr = "Просторная квартира с потенциалом под несколько комнат, и обустроенной ванной комнатой. Вид из окна на магазины шаговой доступности.\n\n\nКвартира на 4 этаже; лифт временами неисправен. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	gps_point = Vector(1526.9237060547, 5089.1899414063, 560),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["apr_13_7"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1335, 4865, 556),
		[2] = Vector(1168, 4865, 556),
		[3] = Vector(1170, 4686, 556),
		[4] = Vector(956, 4686, 556),
		[5] = Vector(964, 4353, 556),
		[6] = Vector(1408, 4359, 556),
		[7] = Vector(1408, 4605, 556),
		[8] = Vector(1340, 4606, 556)
	},
	printName = "Квартира 7",
	printStr = "13th street 1",
	noDoorAction = true,
	terDescr = "Скромная квартира с обустроенной ванной комнатой. Окно ведёт в переулок.\n\n\nКвартира на 4 этаже; лифт временами неисправен. Одиночное окно ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	gps_point = Vector(1247.1851806641, 4821.1845703125, 560),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["apr_13_6"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1565, 4976, 391),
		[2] = Vector(1565, 5183, 391),
		[3] = Vector(1408, 5312, 391),
		[4] = Vector(1405, 5569, 391),
		[5] = Vector(896, 5568, 391),
		[6] = Vector(895, 4981, 391)
	},
	printName = "Квартира 6",
	noDoorAction = true,
	printStr = "13th street 1",
	terDescr = "Просторная квартира с потенциалом под несколько комнат, и обустроенной ванной комнатой. Вид из окна на магазины шаговой доступности.\n\n\nКвартира на 3 этаже; лифт временами неисправен. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	gps_point = Vector(1526.9237060547, 5089.1899414063, 391),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["apr_13_5"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1335, 4865, 391),
		[2] = Vector(1168, 4865, 391),
		[3] = Vector(1170, 4686, 391),
		[4] = Vector(956, 4686, 391),
		[5] = Vector(964, 4353, 391),
		[6] = Vector(1408, 4359, 391),
		[7] = Vector(1408, 4605, 391),
		[8] = Vector(1340, 4606, 391)
	},
	printName = "Квартира 5",
	noDoorAction = true,
	printStr = "13th street 1",
	terDescr = "Скромная квартира с обустроенной ванной комнатой. Окно ведёт в переулок.\n\n\nКвартира на 3 этаже; лифт временами неисправен. Одиночное окно ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	gps_point = Vector(1247.1851806641, 4821.1845703125, 391),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["apr_13_4"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1565, 4976, 220),
		[2] = Vector(1565, 5183, 220),
		[3] = Vector(1408, 5312, 220),
		[4] = Vector(1405, 5569, 220),
		[5] = Vector(896, 5568, 220),
		[6] = Vector(895, 4981, 220)
	},
	printName = "Квартира 4",
	noDoorAction = true,
	printStr = "13th street 1",
	terDescr = "Просторная квартира с потенциалом под несколько комнат, и обустроенной ванной комнатой. Вид из окна на магазины шаговой доступности.\n\n\nКвартира на 2 этаже; лифт временами неисправен. Одно из окон ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	gps_point = Vector(1526.9237060547, 5089.1899414063, 223),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["apr_13_3"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1335, 4865, 220),
		[2] = Vector(1168, 4865, 220),
		[3] = Vector(1170, 4686, 220),
		[4] = Vector(956, 4686, 220),
		[5] = Vector(964, 4353, 220),
		[6] = Vector(1408, 4359, 220),
		[7] = Vector(1408, 4605, 220),
		[8] = Vector(1340, 4606, 220)
	},
	printName = "Квартира 3",
	noDoorAction = true,
	printStr = "13th street 1",
	terDescr = "Скромная квартира с обустроенной ванной комнатой. Окно ведёт в переулок.\n\n\nКвартира на 2 этаже; лифт временами неисправен. Одиночное окно ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	gps_point = Vector(1247.1851806641, 4821.1845703125, 223),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["apr_13_2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1335, 4865, 55),
		[2] = Vector(1168, 4865, 55),
		[3] = Vector(1170, 4686, 55),
		[4] = Vector(956, 4686, 55),
		[5] = Vector(964, 4353, 55),
		[6] = Vector(1408, 4359, 55),
		[7] = Vector(1408, 4605, 55),
		[8] = Vector(1340, 4606, 55)
	},
	printName = "Квартира 2",
	noDoorAction = true,
	printStr = "13th street 1",
	terDescr = "Скромная квартира с обустроенной ванной комнатой. Окно ведёт в переулок.\n\n\nКвартира на 1 этаже. Одиночное окно ведёт к пожарной лестнице - пожалуйста, не загораживайте проход себе и другим!",
	gps_point = Vector(1247.1851806641, 4821.1845703125, 55),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["apr_13_1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(1565, 4976, 55),
		[2] = Vector(1565, 5183, 55),
		[3] = Vector(1408, 5312, 55),
		[4] = Vector(1405, 5569, 55),
		[5] = Vector(896, 5568, 55),
		[6] = Vector(895, 4981, 55)
	},
	printName = "Квартира 1",
	noDoorAction = true,
	printStr = "13th street 1",
	terDescr = "Просторная квартира с потенциалом под несколько комнат, и обустроенной ванной комнатой. Вид из окна на магазины шаговой доступности.\n\n\nКвартира на 1 этаже. Окна стоят высоко - вор-домушник не дотянется до вашего имущества.",
	gps_point = Vector(1526.9237060547, 5089.1899414063, 55),
	height = 157,
	group = "apartment13",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 100,
	camPos = Vector(1751.3759765625,6100.9614257813,590.28918457031),
	camAng = Angle(13.85734462738,-114.61608886719,0),
}

ters["shop6"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(4355, 3390, -105),
		[2] = Vector(4930, 3390, -105),
		[3] = Vector(4930, 2105, -105),
		[4] = Vector(4355, 2105, -105)
	},
	printName = "Магазин",
	printStr = "New life street 7",
	terDescr = "Нежилое коммерческое помещение с компактной служебной комнатой. Самая оживлённая улица района, много парковочных мест возле магазина - поток посетилелей обеспечен. Имеется запасной выход в переулок.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 2-3 минуты. Установлена новая вентиляционная система.",
	gps_point = Vector(4669.4584960938, 3266.126953125, -47.968742370605),
	height = 300,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 400,
	camPos = Vector(4452.7885742188, 3703.5009765625, 217.42234802246),
	camAng = Angle(21.096071243286, -67.858505249023, 0),
	mailbox = {
		Vector(4497.78125,2238.03125,-103.625),
		Angle(0.032958984375,-130.71533203125,-0.010986328125)
	}
}

ters["jack"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(5304, -832, -232),
		[2] = Vector(3472, -832, -232),
		[3] = Vector(3472, -1024, -232),
		[4] = Vector(2192, -1024, -232),
		[5] = Vector(2192, -2543, -232),
		[6] = Vector(5304, -2551, -232)
	},
	printName = "Свалка",
	printStr = "Haviture way 1",
	gps_point = Vector(3058.6489257813,-1801.1917724609,-54.96134185791),
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_UNLOCK,
	type = "warehouse",
	onEnterSV = function(ter, ply)
		if ter.loadedScene then return end
		ter.loadedScene = true
		MQS.Scenes.Load("dumpco")
	end,
	onExitSV = function(ter, ply)
		if not ter:IsEmpty() or not ter.loadedScene then return end
		ter.loadedScene = nil
		MQS.Scenes.UnLoad("dumpco")
	end,
	camPos = Vector(5161.998046875, -189.78953552246, 542.17602539063),
	camAng = Angle(23.196413040161, -128.98277282715, 0),
}

ters["urban_outfits"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-1777, 10303, 118),
		[2] = Vector(-2303, 10303, 118),
		[3] = Vector(-2303, 10880, 118),
		[4] = Vector(-1777, 10880, 118)
	},
	printName = "Магазин одежды",
	printStr = "Maple road 10",
	height = 300,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["hard_shop"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(1022, -1023, -113),
		[2] = Vector(1920, -1023, -113),
		[3] = Vector(1920, -2047, -113),
		[4] = Vector(1022, -2047, -113)
	},
	printName = "Магазин хоз. товаров",
	printStr = "Any way 131",
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["wh1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-2000, -2431.7756347656, -95.968757629395),
		[2] = Vector(-224.18766784668, -2432.1938476563, -95.96875),
		[3] = Vector(-224.34506225586, -1183.1097412109, -95.96875),
		[4] = Vector(-2000, -1183.7540283203, -95.96875)
	},
	printName = "Склад",
	printStr = "Any way 130",
	terDescr = "Нежилое складское помещение под любые логистические или мануфактурные мероприятия. Прилегающая зона позволит совершать большие операции.\n\n\nТерритория огорожена от несанкционированных проникновений; здание делит зону с другим складом.",
	noDoorAction = true,
	gps_point = Vector(-1022.856262207,-1777.080078125,-73.08952331543),
	height = 500,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 1500,
	camPos = Vector(-2478.9020996094, -1525.2526855469, 360.44866943359),
	camAng = Angle(15.452916145325, -20.510330200195, 0),
	mailbox = {
		Vector(-1796.78125,-1954.21875,-95.625),
		Angle(0.032958984375,-37.216186523438,-0.010986328125)
	}
}

ters["wh2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3679.6599121094, -1087.6312255859, -96),
		[2] = Vector(-2802, -1087.8619384766, -96),
		[3] = Vector(-2802, -2111.8776855469, -96),
		[4] = Vector(-3673.4387207031, -2105.9731445313, -96)
	},
	printName = "Склад",
	printStr = "Any way 129",
	terDescr = "Нежилое складское помещение под логистические или мануфактурные мероприятия. Прилегающая зона позволит совершать большие операции.\n\n\nТерритория огорожена от несанкционированных проникновений; здание делит зону с другим складом.",
	noDoorAction = true,
	gps_point = Vector(-3254.9519042969,-1604.7550048828,-95.96875),
	height = 370,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 800,
	camPos = Vector(-2212.3586425781, -1144.1193847656, 242.39576721191),
	camAng = Angle(17.772804260254, -154.12408447266, 0),
	mailbox = {
		Vector(-2771.21875,-1096.21875,-95.625),
		Angle(0.032958984375,0.780029296875,-0.010986328125)
	}
}

ters["wh3"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-5338, 3967.9694824219, -77),
		[2] = Vector(-5338, 2753.7587890625, -77),
		[3] = Vector(-4062.9028320313, 2752.4448242188, -77),
		[4] = Vector(-4095.5666503906, 3968.1606445313, -77)
	},
	printName = "Склад",
	printStr = "North street 1",
	terDescr = "Нежилое складское помещение под логистические или мануфактурные мероприятия, с запасным выходом. Улица нечасто загружена - есть потенциал под беспрепятственную работу с крупногабаритным транспортом.\n\n\nЗадний двор недоступен посторонним - только собственникам примыкающих помещений.",
	gps_point = Vector(-4694.7768554688,3457.8369140625,-31.96875),
	height = 440,
	noDoorAction = true,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 1200,
	camPos = Vector(-5822.837890625, 2873.05078125, 293.10107421875),
	camAng = Angle(19.434335708618, 35.661449432373, 0),
	mailbox = {
		Vector(-4064.28125,3747.34375,-10.09375),
		Angle(0.032958984375,88.379516601563,-0.010986328125)
	}
}

ters["wh4"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(7230, -848, -170),
		[2] = Vector(6207, -848, -170),
		[3] = Vector(6207, -2560, -170),
		[4] = Vector(7230, -2560, -170)
	},
	printName = "Склад",
	printStr = "Haviture way 3",
	terDescr = "Нежилое складское помещение под любые логистические или мануфактурные мероприятия. Улица нечасто загружена - есть потенциал под беспрепятственную работу с крупногабаритным транспортом.\n\n\nПожарная станция на той же улице обеспечит своевременный ответ на возгорания.",
	gps_point = Vector(6716.787109375,-1770.1606445313,-103.96875),
	height = 440,
	noDoorAction = true,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 1200,
	camPos = Vector(7202.8276367188,-343.64450073242,183.12783813477),
	camAng = Angle(10.751503944397,-122.8120803833,0),
	mailbox = {
		Vector(6434.78125,-1001.625,-103.625),
		Angle(0.032958984375,-89.016723632813,-0.010986328125)
	}
}

ters["city_storage"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(831.990234375, -7232.03125, -350),
		[2] = Vector(-768.03125, -7231.673828125, -350),
		[3] = Vector(-768.03125, -5249.2373046875, -350),
		[4] = Vector(-58.834526062012, -5247.96875, -350),
		[5] = Vector(-32.03125, -3488.8205566406, -350),
		[6] = Vector(1152.03125, -3488.6899414063, -350),
		[7] = Vector(1152.03125, -4351.8022460938, -350),
		[8] = Vector(231.32409667969, -4352.03125, -350),
		[9] = Vector(230.41864013672, -5247.96875, -350),
		[10] = Vector(832.03125, -5249.6977539063, -350)
	},
	printName = "Городской склад",
	printStr = "River road 5",
	height = 1200,
	city_storage = true,
	police_zone = true,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_NOONE,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
}

ters["garage_unit_1"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-6647.8354492188, -3064.8520507813, -321),
		[2] = Vector(-6648.9565429688, -2568.1279296875, -321),
		[3] = Vector(-6275.4487304688, -2567.9748535156, -321),
		[4] = Vector(-6272.5961914063, -3067.1750488281, -321)
	},
	printName = "Гараж 1",
	printStr = "River road 4",
	terDescr = "Нежилое гаражное помещение, для хранения машины или использования под временный склад. Выделенный въезд на территорию.\n\n\nСкладские помещения Self Storage оперируются регламентом целевой эксплуатации: помещения обязаны арендовываться под хранение, а не коммерцию или жильё. Нарушение условий соглашения ведёт к занесению в чёрный список на операции с компанией Self Storage. Подробнее по номеру 222-777-7777.",
	gps_point = Vector(-6462.4296875, -3070.4914550781, -319.21160888672),
	height = 225,
	group = "garage_unit",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 50,
	camPos = Vector(-6840.7158203125,-4547.1850585938,406.33654785156),
	camAng = Angle(22.776849746704,90.271293640137,0),
}

ters["garage_unit_2"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-6266.8725585938, -3064.8198242188, -321),
		[2] = Vector(-6271.04296875, -2573.5344238281, -321),
		[3] = Vector(-5893.7661132813, -2568.3386230469, -321),
		[4] = Vector(-5895.3173828125, -3065.2163085938, -321)
	},
	printName = "Гараж 2",
	printStr = "River road 4",
	terDescr = "Нежилое гаражное помещение, для хранения машины или использования под временный склад. Выделенный въезд на территорию.\n\n\nСкладские помещения Self Storage оперируются регламентом целевой эксплуатации: помещения обязаны арендовываться под хранение, а не коммерцию или жильё. Нарушение условий соглашения ведёт к занесению в чёрный список на операции с компанией Self Storage. Подробнее по номеру 222-777-7777.",
	gps_point = Vector(-6066.064453125, -3072.3527832031, -320),
	height = 225,
	group = "garage_unit",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 50,
	camPos = Vector(-6840.7158203125,-4547.1850585938,406.33654785156),
	camAng = Angle(22.776849746704,90.271293640137,0),
}

ters["garage_unit_3"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-6272.5483398438, -3589.6875, -321),
		[2] = Vector(-6270.9233398438, -4085.7880859375, -321),
		[3] = Vector(-6648.2006835938, -4088.2119140625, -321),
		[4] = Vector(-6648.1611328125, -3590.9697265625, -321)
	},
	printName = "Гараж 3",
	printStr = "River road 3",
	terDescr = "Нежилое гаражное помещение, для хранения машины или использования под временный склад. Выделенный въезд на территорию.\n\n\nСкладские помещения Self Storage оперируются регламентом целевой эксплуатации: помещения обязаны арендовываться под хранение, а не коммерцию или жильё. Нарушение условий соглашения ведёт к занесению в чёрный список на операции с компанией Self Storage. Подробнее по номеру 222-777-7777.",
	gps_point = Vector(-6471.853515625, -3588.6083984375, -317.66149902344),
	height = 225,
	group = "garage_unit",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 50,
	camPos = Vector(-6840.7158203125,-4547.1850585938,406.33654785156),
	camAng = Angle(22.776849746704,90.271293640137,0),
}

ters["garage_unit_4"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-6272.5483398438, -3589.6875, -321),
		[2] = Vector(-6270.9233398438, -4085.7880859375, -321),
		[3] = Vector(-5892.6811523438, -4089.7875976563, -321),
		[4] = Vector(-5895.8095703125, -3590.587890625, -321)
	},
	printName = "Гараж 4",
	printStr = "River road 3",
	terDescr = "Нежилое гаражное помещение, для хранения машины или использования под временный склад. Выделенный въезд на территорию.\n\n\nСкладские помещения Self Storage оперируются регламентом целевой эксплуатации: помещения обязаны арендовываться под хранение, а не коммерцию или жильё. Нарушение условий соглашения ведёт к занесению в чёрный список на операции с компанией Self Storage. Подробнее по номеру 222-777-7777.",
	gps_point = Vector(-6073.0444335938, -3587.3706054688, -318.28051757813),
	height = 225,
	group = "garage_unit",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 50,
	camPos = Vector(-6840.7158203125,-4547.1850585938,406.33654785156),
	camAng = Angle(22.776849746704,90.271293640137,0),
}

ters["garage_unit_5"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-7551.3813476563, -3589.9140625, -321),
		[2] = Vector(-7560.1396484375, -4082.9313964844, -321),
		[3] = Vector(-7176.8999023438, -4088.37109375, -321),
		[4] = Vector(-7176.4213867188, -3590.2141113281, -321)
	},
	printName = "Гараж 5",
	printStr = "River road 2",
	terDescr = "Нежилое гаражное помещение, для хранения машины или использования под временный склад. Выделенный въезд на территорию.\n\n\nСкладские помещения Self Storage оперируются регламентом целевой эксплуатации: помещения обязаны арендовываться под хранение, а не коммерцию или жильё. Нарушение условий соглашения ведёт к занесению в чёрный список на операции с компанией Self Storage. Подробнее по номеру 222-777-7777.",
	gps_point = Vector(-7357.533203125, -3587.1247558594, -318.40344238281),
	height = 225,
	group = "garage_unit",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 50,
	camPos = Vector(-6840.7158203125,-4547.1850585938,406.33654785156),
	camAng = Angle(22.776849746704,90.271293640137,0),
}

ters["garage_unit_7"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-7560, -3065, -321),
		[2] = Vector(-7555, -2571, -321),
		[3] = Vector(-7175, -2570, -321),
		[4] = Vector(-7175, -3065, -321)
	},
	printName = "Гараж 7",
	printStr = "River road 1",
	terDescr = "Нежилое гаражное помещение, для хранения машины или использования под временный склад. Выделенный въезд на территорию.\n\n\nСкладские помещения Self Storage оперируются регламентом целевой эксплуатации: помещения обязаны арендовываться под хранение, а не коммерцию или жильё. Нарушение условий соглашения ведёт к занесению в чёрный список на операции с компанией Self Storage. Подробнее по номеру 222-777-7777.",
	gps_point = Vector(-7358.5024414063, -3066.6506347656, -317.29107666016),
	height = 225,
	group = "garage_unit",
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "warehouse",
	price = 50,
	camPos = Vector(-6840.7158203125,-4547.1850585938,406.33654785156),
	camAng = Angle(22.776849746704,90.271293640137,0),
}

ters["drugs"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-6143, 2915, -40),
		[2] = Vector(-6809, 2915, -40),
		[3] = Vector(-6826, 3776, -40),
		[4] = Vector(-6143, 3775, -40)
	},
	printName = "Аптека",
	printStr = "Pleasant road 1",
	terDescr = "Нежилое коммерческое помещение, оборудованное под аптеку. Небольшая служебная комната подойдёт под фармацевтические нужды. Есть парковка перед входом.\n\n\nЗадний двор недоступен посторонним - только собственникам аптеки.",
	gps_point = Vector(-6525.6909179688, 2943.96875, -32),
	height = 250,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 500,
	camPos = Vector(-5812.2265625, 2645.4689941406, 220.36218261719),
	camAng = Angle(4.0728001594543, 132.96354675293, 0),
	mailbox = {
		Vector(-6458.59375,3608.75,-39.625),
		Angle(0.032958984375,88.379516601563,-0.010986328125)
	}
}

ters["wc81"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-1024, 5183, 1200),
		[2] = Vector(-464, 5183, 1200),
		[3] = Vector(-464, 4560, 1200),
		[4] = Vector(-1024, 4560, 1200)
	},
	printName = "Офисы 8 этаж",
	printStr = "World Corp.",
	terDescr = "Офисное помещение под небольшую компанию.\n\n\nЗарезервировано для организаций, сотрудничающих с World Corp.",
	group = "world_corp",
	gps_point = Vector(-996.46875,5040.3447265625,1200.03125),
	height = 160,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 500,
	camPos = Vector(-1187.7083740234,3017.6264648438,1365.0870361328),
	camAng = Angle(11.61307144165,90.61164855957,0),
	restrict = {
		["76561198016218248"] = true,
		["76561199391250511"] = true,
	}
}

ters["wc61"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-1020, 4543, 905),
		[2] = Vector(-461, 4543, 905),
		[3] = Vector(-461, 4952, 905),
		[4] = Vector(-1020, 4952, 905)
	},
	printName = "Офисы 6 этаж",
	printStr = "World Corp.",
	terDescr = "Офисное помещение под небольшую компанию.\n\n\nЗарезервировано для организаций, сотрудничающих с World Corp.",
	group = "world_corp",
	gps_point = Vector(-738.185546875,4963.53125,920.03125),
	height = 180,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 500,
	camPos = Vector(-1187.7083740234,3017.6264648438,1365.0870361328),
	camAng = Angle(11.61307144165,90.61164855957,0),
	restrict = {
		["76561198016218248"] = true,
		["76561199391250511"] = true,
	}
}

------------------ Конец списка зон ----------------------
------------------- Загрузка списка ----------------------

ters["back_alley1"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-3857, 6673, -40),
		[2] = Vector(-3840, 5764, -40),
		[3] = Vector(-4096, 5759, -40),
		[4] = Vector(-4096, 4223, -40),
		[5] = Vector(-5232, 4223, -40),
		[6] = Vector(-5233, 3969, -40),
		[7] = Vector(-4096, 3966, -40),
		[8] = Vector(-4095., 3712, -40),
		[9] = Vector(-3840, 3710, -40),
		[10] = Vector(-3836, 5504, -40),
		[11] = Vector(-2240, 5513, -40),
		[12] = Vector(-2239, 5760, -40),
		[13] = Vector(-1861, 5760, -40),
		[14] = Vector(-1856, 5951, -40),
		[15] = Vector(-2495, 5951, -40),
		[16] = Vector(-3071, 5951, -40),
		[17] = Vector(-3072, 7423, -40),
		[18] = Vector(-3392, 7424, -40),
		[19] = Vector(-3391, 8834, -40),
		[20] = Vector(-3647.8078613281, 8832.5810546875, -40),
		[21] = Vector(-3647.9226074219, 7359.9125976563, -40),
		[22] = Vector(-4479.96875, 7359.9057617188, -40),
		[23] = Vector(-4479.96875, 7168.3203125, -40),
		[24] = Vector(-3263.6721191406, 7168.9619140625, -40),
		[25] = Vector(-3263.509765625, 6643.7934570313, -40)
	},
	printName = "Переулок",
	printStr = "North street",
	height = 600,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	camPos = Vector(-3947.6938476563, 4281.263671875, 678.54351806641),
	camAng = Angle(12.346346855164, 50.651958465576, 0),
}

ters["underground"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-3313.30859375, 5927.96875, -520),
		[2] = Vector(-2056.03125, 4477.427734375, -520),
		[3] = Vector(-2056.03125, 3198.9567871094, -520),
		[4] = Vector(-2632.03125, 1104.6665039063, -520),
		[5] = Vector(-2633.6389160156, 911.96875, -520),
		[6] = Vector(-783.96875, 909.76965332031, -520),
		[7] = Vector(4320.3994140625, 1855.96875, -520),
		[8] = Vector(4488.03125, 2516.9741210938, -520),
		[9] = Vector(4488.03125, 2703.9025878906, -520),
		[10] = Vector(4360.03125, 7159.41796875, -520),
		[11] = Vector(1195.4111328125, 8288.03125, -520),
		[12] = Vector(1006.2162475586, 8296.03125, -520),
		[13] = Vector(-3313.5495605469, 6120.03125, -520)
	},
	printName = "Стоки",
	printStr = "New York, Brooklyn, Sector 29",
	nozone = true,
	height = 300,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	camPos = Vector(4821.8618164063, 6889.1069335938, -117.71168518066),
	camAng = Angle(8.6434631347656, -165.91687011719, 0),
}

ters["pvp"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(576, 8514, 16),
		[2] = Vector(704, 8514, 16),
		[3] = Vector(704, 8256, 16),
		[4] = Vector(1152, 8254, 16),
		[5] = Vector(1152, 7808, 16),
		[6] = Vector(1279, 7807, 16),
		[7] = Vector(1280, 7425, 16),
		[8] = Vector(1087, 7424, 16),
		[9] = Vector(1088, 7039, 16),
		[10] = Vector(896, 7041, 16),
		[11] = Vector(896, 7999, 16),
		[12] = Vector(256, 8000, 16),
		[13] = Vector(255, 7360, 16),
		[14] = Vector(-191, 7360, 16),
		[15] = Vector(-752, 7552, 16),
		[16] = Vector(-752, 7807, 16),
		[17] = Vector(0, 8191, 16),
		[18] = Vector(569, 8191, 16)
	},
	printName = "Переулок",
	printStr = "North street",
	height = 400,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["pvp2"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(3714, 8640, 20),
		[2] = Vector(3456, 8640, 20),
		[3] = Vector(3456, 8352, 20),
		[4] = Vector(3520, 7935, 20),
		[5] = Vector(3456, 7423, 20),
		[6] = Vector(3456, 7168, 20),
		[7] = Vector(4160, 7168, 20),
		[8] = Vector(4160, 6415, 20),
		[9] = Vector(4351, 6416, 20),
		[10] = Vector(5135, 6912, 20),
		[11] = Vector(5134, 7104, 20),
		[12] = Vector(4480, 7104, 20),
		[13] = Vector(4479, 7807, 20),
		[14] = Vector(4224, 7807, 20),
		[15] = Vector(4224, 7424, 20),
		[16] = Vector(3712, 7424, 20)
	},
	printName = "Переулок",
	printStr = "Whiskey road",
	height = 400,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["pvp3"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(1792, 5136, -120),
		[2] = Vector(2048, 5137, -120),
		[3] = Vector(2192, 4351, -120),
		[4] = Vector(2192, 4160, -120),
		[5] = Vector(1663, 3457, -123),
		[6] = Vector(1007, 3456, -120),
		[7] = Vector(1007, 3647, -120),
		[8] = Vector(1408, 3647, -123),
		[9] = Vector(1408, 4607, -120),
		[10] = Vector(1791, 4607, -120)
	},
	printName = "Переулок",
	printStr = "Union square",
	height = 450,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["pvp4"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(3631, 2112, -105),
		[2] = Vector(3630, 2303, -105),
		[3] = Vector(4096, 3024, -105),
		[4] = Vector(4351, 3024, -105),
		[5] = Vector(4351, 2275, -105),
		[6] = Vector(4608, 2275, -105),
		[7] = Vector(4608, 2048, -105),
		[8] = Vector(4736, 2048, -105),
		[9] = Vector(4736, 1856, -105),
		[10] = Vector(4978, 512, -103),
		[11] = Vector(4416, -256, -105),
		[12] = Vector(4224, -256, -105),
		[13] = Vector(3647, 833, -105)
	},
	printName = "Переулок",
	printStr = "Grand way",
	height = 400,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["pvp5"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-1024, 832, -104),
		[2] = Vector(-1024, 320, -104),
		[3] = Vector(-832, 320, -104),
		[4] = Vector(-832, 640, -104),
		[5] = Vector(-367, 640, -104),
		[6] = Vector(-367, 832, -104)
	},
	printName = "Переулок",
	printStr = "Center street",
	height = 400,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["pvp6"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(7168, 2432, -119),
		[2] = Vector(7296, 2963, -119),
		[3] = Vector(7423, 2967, -119),
		[4] = Vector(7684, 2432, -119)
	},
	printName = "Переулок",
	printStr = "New life street",
	height = 400,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["pvp7"] = {
	m_type = TERRITORY_TYPE_PUBLIC,
	coords = {
		[1] = Vector(-8131, 3776, -40),
		[2] = Vector(-8131, 3584, -40),
		[3] = Vector(-8704, 3584, -40),
		[4] = Vector(-8704, 3968, -40),
		[5] = Vector(-8448, 3968, -40)
	},
	printName = "Переулок",
	printStr = "Pleasant road",
	height = 400,
	propSpawn = TERRITORY_DOOR_ACTION_DEFAULT,
	lockDoors = TERRITORY_DOOR_ACTION_DEFAULT,
	peace = false
}

ters["new_diner"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-1661.1748046875, -212.5107421875, -110),
		[2] = Vector(-1017.3528442383, -216.79197692871, -110),
		[3] = Vector(-1024.9993896484, 641.49291992188, -110),
		[4] = Vector(-1663.5709228516, 642.51452636719, -110)
	},
	printName = "Дайнер",
	printStr = "Any way 133",
	terDescr = "Нежилое коммерческое помещение, оборудованное под классический американский дайнер. Есть парковка, разделяемая с ближайшими коммерческими зданиями.\n\n\nКухня полностью оборудована под любое меню. Мощная морозильная камера поддержит свежесть любых ингредиентов.",
	gps_point = Vector(-1565.4190673828,-72.914474487305,-103.96875),
	height = 230,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 250,
	camPos = Vector(-1729.2886962891,-448.65689086914,62.098972320557),
	camAng = Angle(14.959819793701,60.976104736328,0),
	mailbox = {
		Vector(-1430.9375,-142.84375,-103.625),
		Angle(0.032958984375,-179.5166015625,-0.010986328125)
	}
}

ters["new_garage"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(-3264.3083496094, 6641.5688476562, 47),
		[2] = Vector(-3839.96875, 6621.4951171875, 47),
		[3] = Vector(-3836.2072753906, 7349.5688476562, 47),
		[4] = Vector(-3666.03125, 7334.5048828125, 47),
		[5] = Vector(-3666.3798828125, 7168.03125, 47),
		[6] = Vector(-3264.7109375, 7170.1279296875, 47)
	},
	printName = "Малая мастерская",
	printStr = "Crooked lane 3",
	terDescr = "Нежилое мануфактурное помещение с выходом на задний двор. Имеется гаражная дверь для упрощения логистики.\n\n\nВъезд через переулок. Задний двор недоступен посторонним - только собственникам примыкающих помещений.",
	height = 240,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "workshop",
	price = 450,
	camPos = Vector(-3560.5139160156,6269.2543945312,173.16004943848),
	camAng = Angle(17.039823532104,91.216094970703,0),
	mailbox = {
		Vector(-3827.84375,7187.875,128.34375),
		Angle(0.032958984375,120.77819824219,-0.010986328125)
	}
}

ters["new_apart_ns"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(103.41690063477, 8264.43359375, 190),
		[2] = Vector(369.90704345703, 8259.337890625, 190),
		[3] = Vector(369.80459594727, 8793.8203125, 190),
		[4] = Vector(160.20774841309, 8793.96875, 190),
		[5] = Vector(103.73187255859, 8477.1533203125, 190)
	},
	printName = "Квартира 1",
	printStr = "North street 5",
	terDescr = "Скромная квартира с обустроенной ванной комнатой. Район тихий, подойдёт для любителей спокойствия.\n\n\nКвартира на 1 этаже.",
	height = 180,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 200,
	camPos = Vector(67.045509338379, 9072.3740234375, 248.61820983887),
	camAng = Angle(-2.1924014091492, -88.559768676758, 0),
}

ters["new_aparts1_ns"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(5324.5200195312, 10399.010742188, 176),
		[2] = Vector(5590.2607421875, 10397.173828125, 176),
		[3] = Vector(5591.6616210938, 10316.669921875, 176),
		[4] = Vector(5751.73828125, 10299.872070312, 176),
		[5] = Vector(5751.8408203125, 10140.154296875, 176),
		[6] = Vector(5324.3725585938, 10096.479492188, 176)
	},
	printName = "Квартира 1",
	printStr = "North street 11",
	terDescr = "Доступная квартира с обустроенной ванной комнатой. Совсем рядом полицейский участок.\n\n\nКвартира на 1 этаже.",
	group = "North street",
	height = 170,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(5409.873046875,9447.6787109375,363.60043334961),
	camAng = Angle(12.894004821777,111.21025848389,0)
}

ters["new_aparts2_ns"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(5320.03515625, 10401.0625, 176),
		[2] = Vector(5318.0961914062, 10575.852539062, 176),
		[3] = Vector(5373.1064453125, 10607.88671875, 176),
		[4] = Vector(5794.9638671875, 10607.93359375, 176),
		[5] = Vector(5794.7670898438, 10468.005859375, 176),
		[6] = Vector(5751.853515625, 10316.168945312, 176),
		[7] = Vector(5589.0927734375, 10316.107421875, 176),
		[8] = Vector(5580.9506835938, 10407.034179688, 176)
	},
	printName = "Квартира 2",
	printStr = "North street 11",
	terDescr = "Доступная квартира с обустроенной ванной комнатой. Совсем рядом полицейский участок.\n\n\nКвартира на 1 этаже.",
	group = "North street",
	height = 170,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(5409.873046875,9447.6787109375,363.60043334961),
	camAng = Angle(12.894004821777,111.21025848389,0)
}

ters["new_aparts3_ns"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(5324.5200195312, 10399.010742188, 368),
		[2] = Vector(5590.2607421875, 10397.173828125, 368),
		[3] = Vector(5591.6616210938, 10316.669921875, 368),
		[4] = Vector(5751.73828125, 10299.872070312, 368),
		[5] = Vector(5751.8408203125, 10140.154296875, 368),
		[6] = Vector(5324.3725585938, 10096.479492188, 368)
	},
	printName = "Квартира 3",
	printStr = "North street 11",
	terDescr = "Доступная квартира с обустроенной ванной комнатой. Совсем рядом полицейский участок.\n\n\nКвартира на 2 этаже; лифт отсутствует.",
	group = "North street",
	height = 170,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(5409.873046875,9447.6787109375,363.60043334961),
	camAng = Angle(12.894004821777,111.21025848389,0)
}

ters["new_aparts4_ns"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(5320.03515625, 10401.0625, 368),
		[2] = Vector(5318.0961914062, 10575.852539062, 368),
		[3] = Vector(5373.1064453125, 10607.88671875, 368),
		[4] = Vector(5794.9638671875, 10607.93359375, 368),
		[5] = Vector(5794.7670898438, 10468.005859375, 368),
		[6] = Vector(5751.853515625, 10316.168945312, 368),
		[7] = Vector(5589.0927734375, 10316.107421875, 368),
		[8] = Vector(5580.9506835938, 10407.034179688, 368)
	},
	printName = "Квартира 4",
	printStr = "North street 11",
	terDescr = "Доступная квартира с обустроенной ванной комнатой. Совсем рядом полицейский участок.\n\n\nКвартира на 2 этаже; лифт отсутствует.",
	group = "North street",
	height = 170,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(5409.873046875,9447.6787109375,363.60043334961),
	camAng = Angle(12.894004821777,111.21025848389,0)
}

ters["new_aparts5_ns"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(5324.5200195312, 10399.010742188, 560),
		[2] = Vector(5590.2607421875, 10397.173828125, 560),
		[3] = Vector(5591.6616210938, 10316.669921875, 560),
		[4] = Vector(5751.73828125, 10299.872070312, 560),
		[5] = Vector(5751.8408203125, 10140.154296875, 560),
		[6] = Vector(5324.3725585938, 10096.479492188, 560)
	},
	printName = "Квартира 5",
	printStr = "North street 11",
	terDescr = "Доступная квартира с обустроенной ванной комнатой. Совсем рядом полицейский участок.\n\n\nКвартира на 3 этаже; лифт отсутствует.",
	group = "North street",
	height = 170,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(5409.873046875,9447.6787109375,363.60043334961),
	camAng = Angle(12.894004821777,111.21025848389,0)
}

ters["new_aparts6_ns"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(5320.03515625, 10401.0625, 560),
		[2] = Vector(5318.0961914062, 10575.852539062, 560),
		[3] = Vector(5373.1064453125, 10607.88671875, 560),
		[4] = Vector(5794.9638671875, 10607.93359375, 560),
		[5] = Vector(5794.7670898438, 10468.005859375, 560),
		[6] = Vector(5751.853515625, 10316.168945312, 560),
		[7] = Vector(5589.0927734375, 10316.107421875, 560),
		[8] = Vector(5580.9506835938, 10407.034179688, 560)
	},
	printName = "Квартира 6",
	printStr = "North street 11",
	terDescr = "Доступная квартира с обустроенной ванной комнатой. Совсем рядом полицейский участок.\n\n\nКвартира на 3 этаже; лифт отсутствует.",
	group = "North street",
	height = 170,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "apartment",
	price = 180,
	camPos = Vector(5409.873046875,9447.6787109375,363.60043334961),
	camAng = Angle(12.894004821777,111.21025848389,0)
}

ters["new_store"] = {
	m_type = TERRITORY_TYPE_BUYABLE,
	coords = {
		[1] = Vector(9470.8271484375, 4262.5654296875, -57),
		[2] = Vector(8935.3525390625, 4263.2329101562, -57),
		[3] = Vector(8934.4169921875, 4701.47265625, -57),
		[4] = Vector(9470.5810546875, 4671.5883789062, -57),
		[5] = Vector(9768.7021484375, 4671.5883789062, -57),
		[6] = Vector(9768.8720703125, 4362.08203125, -57)
	},
	printName = "Магазин",
	printStr = "Haviture way 7",
	terDescr = "Нежилое коммерческое помещение с компактной служебной комнатой. За углом полицейский участок - способствует низкой преступности. Отсутствует выделенная парковка.\n\n\nПодключена сигнализация, среднее время ожидания полиции составляет 1-2 минуты. Установлена новая вентиляционная система.",
	height = 200,
	propSpawn = TERRITORY_PROPSPAWN_ALLOWED_OWNERS,
	lockDoors = TERRITORY_DOOR_ACTION_LOCK,
	type = "store",
	price = 250,
	camPos = Vector(8744.986328125, 4242.4399414062, 94.684921264648),
	camAng = Angle(10.32795715332, 26.592697143555, 0),
	mailbox = {
		Vector(9365.9375,4323.9375,-55.625),
		Angle(0.032958984375,-130.71533203125,-0.010986328125)
	}
}

for id, data in pairs(ters) do
	local tr = Territories:New(id, data.m_type, map)
	table.Merge(tr, data)
end