--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/spawnlist/junk.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--Drugs
DarkRP.Junk["junk_zero"] = {
	model = "models/props_lab/huladoll.mdl",
	name = "Предмет",
	weight = 1,
	noresell = true,
	price = 1,
}

DarkRP.Junk["junk_cheap"] = {
	model = "models/props_arcade/ping_pong_paddle-1.mdl",
	name = "Предмет дешёвый",
	weight = 1,
	price = 50,
}

DarkRP.Junk["junk_medium"] = {
	model = "models/props_electronics/camera-6.mdl",
	name = "Предмет средний",
	weight = 1,
	price = 200,
}

DarkRP.Junk["junk_rich"] = {
	model = "models/props_books/blueprints-2.mdl",
	name = "Предмет дорогой",
	weight = 1,
	price = 800,
}

DarkRP.Junk["book"] = {
	model = "models/props_lab/binderblue.mdl",
	name = "Книга",
	weight = 0.2,
	noresell = true,
	price = 5,
}

DarkRP.Junk["const"] = {
	model = "models/noire/books/book5.mdl",
	material = "gbskins/bookshelf3",
	name = "Конституция",
	weight = 0.05,
	noresell = true,
	price = 100,
	shop = "law"
}

DarkRP.Junk["pdd"] = {
	model = "models/noire/books/book4.mdl",
	name = "Книжка ПДД",
	material = "gbskins/bookshelf2",
	weight = 0.05,
	noresell = true,
	price = 100,
	shop = "law"
}

DarkRP.Junk["doc"] = {
	model = "models/props_lab/papersheet001a.mdl",
	material = "gbskins/doc",
	name = "Документ",
	weight = 0.01,
	noresell = true,
	price = 1,
}

DarkRP.Junk["cuffs"] = {
	model = "models/weapons/spy/cuffs.mdl",
	name = "Наручники",
	weight = 0.35,
	noresell = true,
	price = 1,
}

DarkRP.Junk["seed_weed"] = {
	name = "Семена конопли",
	model = "models/meth2/meth_ziplock_small.mdl",
	submat = {
		[0] = "phoenix_storms/potato"
	},
	weight = 0.1,
	price = 50,
	shop = "green"
}

DarkRP.Junk["coffee"] = {
	model = "models/foodnhouseholditems/coffee_nescafe.mdl",
	name = "Кофе",
	weight = 0.05,
	conwht = 0.09,
	uses = 5,
	price = 5,
	shop = "shop"
}

DarkRP.Junk["tea"] = {
	model = "models/cityrp/box4.mdl",
	material = "gbskins/tea",
	name = "Чай",
	weight = 0.05,
	conwht = 0.09,
	uses = 5,
	price = 4,
	shop = "shop"
}

DarkRP.Junk["phone_bj"] = {
	model = "models/props_electronics/cellphone-5.mdl",
	name = "Телефон",
	weight = 0.1,
	price = 100,
	phone_type = 7,
	ud = {
		Ringtone = "cell/redsun.mp3",
		Sleep = false,
		PhoneColor = color_white,
		WallPaper = "bch/1.png",
		PhoneType = "Beijing"
	},
}

DarkRP.Junk["phone_se"] = {
	model = "models/cityrp/se_phone.mdl",
	color = Color(39,39,39),
	name = "Телефон",
	weight = 0.1,
	price = 400,
	phone_type = 5,
	noresell = true,
	ud = {
		Ringtone = "cell/tone_1.wav",
		Sleep = false,
		PhoneColor = Color(39,39,39),
		WallPaper = "wp_1.png",
		PhoneType = "Exp"
	},
	shop = "shop"
}

DarkRP.Junk["phone_n"] = {
	model = "models/cityrp/camphone.mdl",
	name = "Телефон",
	weight = 0.1,
	price = 200,
	xp = {"cook", 200},
	phone_type = 6,
	ud = {
		Ringtone = "cell/tone_1.wav",
		Sleep = false,
		PhoneColor = color_white,
		WallPaper = "n/1.png",
		PhoneType = "Nocla"
	},
	shop = "shop"
}

DarkRP.Junk["phone_mc"] = {
	model = "models/mactavish/mactavish_phone.mdl",
	color = Color(80, 130, 200),
	name = "Телефон",
	weight = 0.1,
	price = 499,
	phone_type = 1,
	noresell = true,
	ud = {
		Ringtone = "tone_1.wav",
		Sleep = false,
		PhoneColor = Color(80, 130, 200),
		WallPaper = "phone_wallpaper_McPhonedefault.png",
		PhoneType = "McPhone"
	},
}

DarkRP.Junk["phone_bg"] = {
	model = "models/mactavish/bg_phone.mdl",
	color = Color(20, 140, 30),
	name = "Телефон",
	weight = 0.1,
	price = 699,
	phone_type = 2,
	noresell = true,
	ud = {
		Ringtone = "tone_8.wav",
		Sleep = false,
		PhoneColor = Color(20, 140, 30),
		WallPaper = "phone_wallpaper_badgerdefault.png",
		PhoneType = "Badger"
	},
}

DarkRP.Junk["phone_lm"] = {
	model = "models/mactavish/lm_phone.mdl",
	color = Color(110, 20, 20),
	name = "Телефон",
	weight = 0.1,
	price = 999,
	phone_type = 3,
	noresell = true,
	ud = {
		Ringtone = "tone_4.wav",
		Sleep = false,
		PhoneColor = Color(110, 20, 20),
		WallPaper = "",
		PhoneType = "Bloom"
	},
}

DarkRP.Junk["seed_coca"] = {
	name = "Семена коки",
	submat = {
		[0] = "phoenix_storms/potato"
	},
	model = "models/meth2/meth_ziplock_small.mdl",
	weight = 0.1,
	price = 60,
	shop = "green"
}

DarkRP.Junk["seed_opium"] = {
	name = "Семена мака",
	submat = {
		[0] = "phoenix_storms/potato"
	},
	model = "models/meth2/meth_ziplock_small.mdl",
	weight = 0.1,
	price = 70,
	shop = "green"
}

DarkRP.Junk["dough"] = {
	name = "Тесто",
	model = "models/props_junk/garbage_bag001a.mdl",
	material = "models/props_c17/FurnitureMetal001a",
	weight = 0.4,
	price = 10,
}

DarkRP.Junk["green_weed"] = {
	name = "Листья конопли",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sack",
	w_price = true,
	weight = 1,
	price = 250,
	sell = true
}

DarkRP.Junk["green_coca"] = {
	name = "Листья коки",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sack",
	w_price = true,
	weight = 1,
	price = 247,
	sell = true
}

DarkRP.Junk["green_opium"] = {
	name = "Цветы мака",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sack",
	w_price = true,
	weight = 1,
	price = 244,
	sell = true
}

DarkRP.Junk["dry_weed"] = {
	name = "Сухие листья конопли",
	model = "models/meth/meth_ziplock_small.mdl",
	submat = {
		[0] = "models/weed/prop_weed_bud_d"
	},
	weight = 1,
	w_price = true,
	price = 524,
	sell = true
}

DarkRP.Junk["dry_coca"] = {
	name = "Сухие листья коки",
	model = "models/meth/meth_ziplock_small.mdl",
	submat = {
		[0] = "models/weed/fresh_bud_d"
	},
	weight = 1,
	w_price = true,
	price = 504,
	sell = true
}

DarkRP.Junk["dry_opium"] = {
	name = "Беспримесный морфин",
	model = "models/props_junk/garbage_plasticbottle003a.mdl",
	weight = 1,
	w_price = true,
	price = 500,
	sell = true
}

DarkRP.Junk["done_heroin"] = {
	name = "Героин",
	model = "models/props_junk/garbage_plasticbottle002a.mdl",
	weight = 1,
	w_price = true,
	price = 1300,
	sell = true
}

DarkRP.Junk["done_coca"] = {
	name = "Брикет кокаина",
	model = "models/srcocainelab/cocainebrick.mdl",
	weight = 1,
	w_price = true,
	price = 1200,
	sell = true
}

DarkRP.Junk["dry_opium_small"] = {
	name = "Морфин",
	model = "models/props_junk/garbage_plasticsyringe001a.mdl",
	weight = 0.05,
	price = 30,
}

DarkRP.Junk["done_heroin_small"] = {
	name = "Пакетик героина",
	model = "models/srcocainelab/ziplockedcocaine.mdl",
	weight = 0.1,
	price = 130,
}

DarkRP.Junk["done_heroin_syr"] = {
	name = "Шприц с героином",
	model = "models/props_junk/garbage_plasticsyringe001a.mdl",
	weight = 0.05,
	price = 60,
}

DarkRP.Junk["done_coca_small"] = {
	name = "Пакетик кокаина",
	model = "models/srcocainelab/ziplockedcocaine.mdl",
	weight = 0.1,
	price = 120,
}

DarkRP.Junk["done_meth"] = {
	name = "Пакет метамфетамина",
	model = "models/meth/meth_ziplock_small.mdl",
	weight = 1,
	w_price = true,
	price = 999,
	sell = true
}

DarkRP.Junk["done_meth_small"] = {
	name = "Пакетик метамфетамина",
	model = "models/meth2/meth_ziplock_small.mdl",
	weight = 0.1,
	price = 111,
}

DarkRP.Junk["dry_weed_small"] = {
	name = "Пакетик конопли",
	model = "models/meth2/meth_ziplock_small.mdl",
	submat = {
		[0] = "models/weed/prop_weed_bud_d"
	},
	weight = 0.3,
	price = 82,
}

DarkRP.Junk["dry_tabacco_small"] = {
	name = "Табак для трубки",
	model = "models/meth2/meth_ziplock_small.mdl",
	material = "gbskins/sack",
	weight = 0.1,
	price = 30,
}

DarkRP.Junk["fentanyl"] = {
	name = "Фентанил",
	model = "models/props_junk/garbage_plasticsyringe001a.mdl",
	weight = 0.05,
	price = 120,
	sell = true
}

-- Drug components
DarkRP.Junk["craft_coca"] = {
	name = "Сгущённые листья коки",
	model = "models/props_lab/jar01a.mdl",
	weight = 1,
	w_price = true,
	price = 600,
	sell = true
}

DarkRP.Junk["craft_coca_small"] = {
	name = "Пакетик крэка",
	model = "models/srcocainelab/ziplockedcocaine.mdl",
	weight = 0.1,
	price = 60,
}

DarkRP.Junk["craft_sphingosine"] = {
	name = "Сфингозин",
	model = "models/props_junk/garbage_plasticbottle001a.mdl",
	material = "gbskins/garbage_items",
	weight = 1,
	w_price = true,
	price = 685,
	sell = true
}

DarkRP.Junk["craft_meth"] = {
	name = "Толуоловый растворитель",
	model = "models/props_junk/garbage_plasticbottle001a.mdl",
	material = "gbskins/garbage_items",
	weight = 1,
	price = 150,
	xp = {"drugs", 2000},
	shop = "hardware",
	sell = true
}

DarkRP.Junk["craft_meth_ice"] = {
	name = "Жидкий 'лёд'",
	model = "models/meth/meth_tray.mdl",
	w_price = true,
	weight = 1,
}

-- Chemicals
DarkRP.Junk["sacid"] = {
	name = "Бензоат натрия",
	model = "models/meth/sacid.mdl",
	weight = 1,
	price = 60,
	shop = "hardware"
}

DarkRP.Junk["toulene"] = {
	name = "Толуол",
	model = "models/meth/toulene.mdl",
	weight = 1.3,
	price = 45,
	shop = "hardware"
}

DarkRP.Junk["ammonia"] = {
	name = "Аммиак",
	model = "models/meth/ammonia.mdl",
	submat = {
		[2] = "gbskins/ammonia"
	},
	weight = 1,
	price = 35,
	shop = "hardware"
}

DarkRP.Junk["acetone"] = {
	name = "Ацетон",
	model = "models/meth/acetone.mdl",
	weight = 1.2,
	price = 20,
	shop = "hardware"
}

DarkRP.Junk["sodium"] = {
	name = "Перекись водорода",
	model = "models/meth/sodium.mdl",
	weight = 1,
	price = 12,
	shop = "hardware"
}

-- Neutral
DarkRP.Junk["water_can"] = {
	name = "Канистра с водой",
	model = "models/props_junk/metalgascan.mdl",
	material = "gbskins/metalgascan",
	weight = 1,
	conwht = 0.5,
	uses = 5,
	price = 8,
	shop = "hardware"
}

DarkRP.Junk["ice_bag"] = {
	name = "Пакет со льдом",
	model = "models/props_junk/garbage_bag001a.mdl",
	material = "gbskins/garbagebag_ice1",
	weight = 0.5,
	price = 5,
	btime = 3000,
	shop = "shop"
}

DarkRP.Junk["paper"] = {
	name = "Бумага",
	model = "models/props_junk/paperbox1.mdl",
	weight = 0.1,
	price = 50,
	uses = 5,
	shop = "hardware"
}

DarkRP.Junk["sack_yeast"] = {
	name = "Мешок дрожжей",
	model = "models/meth2/meth_ziplock_small.mdl",
	material = "gbskins/sacky",
	weight = 0.1,
	price = 10,
	uses = 3,
	shop = "green"
}

DarkRP.Junk["sack_grain"] = {
	name = "Мешок зерна",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sackg",
	weight = 1.6,
	price = 10,
	shop = "green"
}

DarkRP.Junk["sack_herb"] = {
	name = "Мешок трав",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sackh",
	weight = 1.6,
	price = 10,
	shop = "green"
}

DarkRP.Junk["sack_grape"] = {
	name = "Мешок винограда",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sackw",
	weight = 1.6,
	price = 12,
	shop = "green"
}

DarkRP.Junk["sack_sugar"] = {
	name = "Мешок сахарного тростника",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sacks",
	weight = 1.6,
	price = 12,
	shop = "green"
}

DarkRP.Junk["sack_flour"] = {
	name = "Мешок муки",
	model = "models/meth/meth_ziplock_small.mdl",
	material = "gbskins/sackf",
	weight = 1.6,
	price = 10,
	shop = "shop"
}

-- Gunsgunsguns
DarkRP.Junk["parts_all"] = {
	name = "Запчасти универсальные",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.2,
	uses = 5,
	price = 360,
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_pm"] = {
	name = "Запчасти от ПМ",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 750,
	job = {
		[TEAM_GUN] = true
	},
	shop = "kwpns"
}

DarkRP.Junk["parts_b725"] = {
	name = "Запчасти от BC 725",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 900,
	xp = {"guns", 300},
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_beretta"] = {
	name = "Запчасти от Beretta M9",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 900,
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_m1911"] = {
	name = "Запчасти от M1911",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 1050,
	job = {
		[TEAM_GUN] = true
	},
	shop = "kwpns"
}

DarkRP.Junk["parts_glock"] = {
	name = "Запчасти от Glock",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 1100,
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_p220"] = {
	name = "Запчасти от P220",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 1050,
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_magnum"] = {
	name = "Запчасти от Colt King Cobra",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 1400,
	xp = {"guns", 1800},
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_m590"] = {
	name = "Запчасти от Mossberg 590",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 1000,
	xp = {"guns", 500},
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_ithaca"] = {
	name = "Запчасти от Ithaca 37",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 1000,
	xp = {"guns", 500},
	job = {
		[TEAM_GUN] = true
	},
	shop = "kwpns"
}

DarkRP.Junk["parts_marlin"] = {
	name = "Запчасти от Marlin 1895",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.5,
	uses = 5,
	xp = {"guns", 500},
	price = 1500,
	shop = "kwpns"
}

DarkRP.Junk["parts_kar"] = {
	name = "Запчасти от Mauser 98k",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.7,
	uses = 5,
	price = 3500,
	xp = {"guns",  2000},
	shop = "kwpns"
}

DarkRP.Junk["parts_deagle"] = {
	name = "Запчасти от Deagle",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 2250,
	xp = {"guns", 2600},
	shop = "kwpns"
}

DarkRP.Junk["parts_uzi"] = {
	name = "Запчасти от UZI",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	xp = {"guns", 700},
	uses = 5,
	price = 1000,
	shop = "kwpns"
}

DarkRP.Junk["parts_tec"] = {
	name = "Запчасти от Tec-9",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	xp = {"guns", 1000},
	uses = 5,
	price = 2500,
	shop = "kwpns"
}

DarkRP.Junk["parts_mac"] = {
	name = "Запчасти от MAC-10",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	xp = {"guns", 500},
	uses = 5,
	price = 1500,
	shop = "kwpns"
}

DarkRP.Junk["parts_mp5"] = {
	name = "Запчасти от MP5",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 2000,
	xp = {"guns", 2000},
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_thompson"] = {
	name = "Запчасти от Thompson",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.7,
	uses = 5,
	price = 2000,
	xp = {"guns", 1500},
	shop = "kwpns"
}

DarkRP.Junk["parts_ak"] = {
	name = "Запчасти от АК",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.7,
	uses = 5,
	price = 2800,
	xp = {"guns", 2500},
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_m4"] = {
	name = "Запчасти от AR-15",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.7,
	uses = 5,
	price = 4500,
	xp = {"guns", 1300},
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_scar"] = {
	name = "Запчасти от FN Scar 17",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	uses = 5,
	price = 5000,
	xp = {"guns", 2500},
	job = {
		[TEAM_GUN] = true
	},
	shop = "rdm"
}

DarkRP.Junk["parts_aug"] = {
	name = "Запчасти от AUG",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.7,
	price = 3000,
	uses = 5,
	xp = {"guns", 3000},
	shop = "kwpns"
}

DarkRP.Junk["parts_spas"] = {
	name = "Запчасти от SPAS12",
	model = "models/props_junk/cardboard_box004a.mdl",
	material = "gbskins/boxes_rdm",
	weight = 0.4,
	price = 5000,
	uses = 5,
	xp = {"guns", 3500},
	shop = "kwpns"
}

DarkRP.Junk["car_radio"] = {
	name = "Радио (от машины)",
	model = "models/props_lab/reciever01d.mdl",
	weight = 0.5,
	xp = {"car", 5000},
	price = 500,
	shop = "hardware",
}

DarkRP.Junk["radio"] = {
	name = "Радио",
	model = "models/physics_props/electronics/boombox_03.mdl",
	weight = 0.5,
	xp = {"cook", 800},
	price = 600,
	shop = "hardware"
}

DarkRP.Junk["boombox"] = {
	name = "БумБокс",
	model = "models/physics_props/electronics/boombox_02.mdl",
	weight = 5.2,
	price = 550,
}

DarkRP.Junk["labpack"] = {
	name = "Лабораторный набор",
	model = "models/props_junk/garbage_carboard002a_box.mdl",
	weight = 1,
	price = 250,
	job = {
		[TEAM_GANG] = true
	},
	shop = "hardware"
}

DarkRP.Junk["armor"] = {
	name = "Лёгкий бронежилет",
	model = "models/tnb/items/wintercoat.mdl",
	material = "gbskins/armor2",
	weight = 2.5,
	xp = {"guns", 800},
	price = 1300,
	shop = "rdm_o"
}

DarkRP.Junk["headcure"] = {
	name = "Средство от головы",
	model = "models/props_junk/garbage_plasticcup002a.mdl",
	weight = 0.1,
	price = 15
}

DarkRP.Junk["pills0"] = {
	name = "Таблетки С0",
	model = "models/unioncity2/props_unioncity/painkillers.mdl",
	weight = 0.1,
	price = 15
}

DarkRP.Junk["wtf"] = {
	model = "models/food/props_shops/prop_butcher_sausage_01_a.mdl",
	material = "cityrp/foil",
	name = "Сосиска в фольге",
	weight = 0.1,
	price = 15
}

DarkRP.Junk["pills1"] = {
	name = "Таблетки A51",
	model = "models/unioncity2/props_unioncity/painkillers.mdl",
	weight = 0.1,
	price = 50
}

DarkRP.Junk["pills2"] = {
	name = "Таблетки B73",
	model = "models/unioncity2/props_unioncity/painkillers.mdl",
	weight = 0.1,
	price = 50
}

DarkRP.Junk["pills3"] = {
	name = "Таблетки C1",
	model = "models/unioncity2/props_unioncity/painkillers.mdl",
	weight = 0.1,
	price = 50
}

DarkRP.Junk["pills4"] = {
	name = "Таблетки P5",
	model = "models/unioncity2/props_unioncity/painkillers.mdl",
	weight = 0.1,
	price = 60
}

DarkRP.Junk["pills5"] = {
	name = "Активированный уголь",
	model = "models/unioncity2/props_unioncity/painkillers.mdl",
	weight = 0.1,
	price = 40
}

DarkRP.Junk["pills6"] = {
	name = "Кофеиновые таблетки",
	model = "models/unioncity2/props_unioncity/painkillers.mdl",
	weight = 0.1,
	price = 30
}

DarkRP.Junk["pills7"] = {
	name = "Средство от кашля",
	model = "models/pills.mdl",
	material = "gbskins/pills7",
	weight = 0.1,
	price = 40
}

DarkRP.Junk["pills8"] = {
	name = "Таблетки LS4",
	model = "models/pills.mdl",
	weight = 0.1,
	price = 100
}

DarkRP.Junk["bandage"] = {
	name = "Медицинская повязка",
	model = "models/props_equipment/surgicaltray_01_bandage.mdl",
	weight = 0.2,
	price = 20
}

DarkRP.Junk["whater_dis"] = {
	name = "Дистиллированная вода",
	model = "models/props_junk/garbage_plasticbottle003a.mdl",
	material = "models/props_junk/garbage001a_02",
	weight = 0.5,
	uses = 3,
	price = 5
}

DarkRP.Junk["hookah"] = {
	name = "Кальян",
	model = "models/cincy/z_hookah_is01.mdl",
	weight = 1000,
	price = 50000
}

DarkRP.Junk["bong"] = {
	name = "Бонг",
	model = "models/henry/gta sa/gmod/objects/bottle/bottle.mdl",
	weight = 0.01,
	conwht = 0.8,
	uses = 6,
	price = 100
}

DarkRP.Junk["helmet"] = {
	name = "Баллистический Шлем",
	model = "models/helmets/camo_swat.mdl",
	weight = 1,
	price = 950
}

DarkRP.Junk["chefhat"] = {
	name = "Колпак повара",
	model = "models/tnb/items/beanie.mdl",
	material = "models/shiny",
	weight = 1,
	xp = {"cook", 5000},
	shop = "urban",
	price = 300
}

DarkRP.Junk["hardhat"] = {
	name = "Каска",
	model = "models/items/worker_helmet.mdl",
	weight = 0.5,
	shop = "hardware",
	xp = {"car", 1000},
	price = 89
}

DarkRP.Junk["foilhat"] = {
	name = "Шапочка из фольги",
	model = "models/tnb/items/beanie.mdl",
	material = "cityrp/foil",
	weight = 0.01,
	price = 89
}

DarkRP.Junk["gasmask"] = {
	name = "Противогаз",
	model = "models/half-dead/metroll/p_mask_1.mdl",
	weight = 1,
	shop = "hardware",
	price = 850,
	xp = {"fdny", 2500},
}

DarkRP.Junk["weldingmask"] = {
	name = "Сварочная маска",
	model = "models/ez2models/humans/group03b/welding_mask.mdl",
	weight = 1,
	shop = "hardware",
	xp = {"car", 5000},
	price = 550,
}

DarkRP.Junk["lighter"] = {
	name = "Зажигалка",
	model = "models/weapons/w_lighter.mdl",
	weight = 0.08,
	shop = "hardware",
	price = 15
}

DarkRP.Junk["pipe"] = {
	name = "Трубка",
	model = "models/crackpipe/hollowpipe.mdl",
	weight = 0.1,
	shop = "hardware",
	price = 55
}

DarkRP.Junk["joint"] = {
	name = "Самокрутка",
	model = "models/joint/joint.mdl",
	weight = 0.06,
	price = 16
}

DarkRP.Junk["sigar"] = {
	name = "Сигара",
	model = "models/env/decor/ashtray/sigar02.mdl",
	weight = 0.05,
	price = 100
}

DarkRP.Junk["pack_paddolo"] = {
	name = "Cигареты Paddolo",
	model = "models/mordeciga/mordes/pachkacig.mdl",
	material = "models/shibboro/opensesshib",
	weight = 0.01,
	conwht = 0.01,
	uses = 10,
	shop = "shop",
	price = 5
}

DarkRP.Junk["pack_jamal"] = {
	name = "Cигареты Jamal",
	model = "models/mordeciga/mordes/pachkacig.mdl",
	material = "models/shibboro/emptyboxshib",
	weight = 0.01,
	conwht = 0.01,
	uses = 10,
	shop = "shop",
	price = 4
}

DarkRP.Junk["pack_whisher"] = {
	name = "Cигареты Wisher",
	model = "models/mordeciga/mordes/pachkacig.mdl",
	weight = 0.01,
	conwht = 0.01,
	uses = 10,
	shop = "shop",
	price = 3
}

DarkRP.Junk["pack_bigc"] = {
	name = "Cигареты BIG C",
	model = "models/mordeciga/mordes/pachkacig.mdl",
	material = "models/shibboro/blue",
	weight = 0.01,
	conwht = 0.01,
	uses = 10,
	shop = "shop",
	price = 3
}

DarkRP.Junk["pack_noir"] = {
	name = "Cигареты Noir",
	model = "models/mordeciga/mordes/pachkacig.mdl",
	material = "models/shibboro/noire",
	weight = 0.01,
	conwht = 0.01,
	uses = 10,
	price = 6
}

DarkRP.Junk["toolbox"] = {
	model = "models/props/toolbox.mdl",
	name = "Рем. комплект",
	weight = 0.4,
	conwht = 2,
	uses = 10,
	price = 700,
	job = {
		[12] = true
	},
	shop = "hardware"
}

DarkRP.Junk["armor1"] = {
	name = "Бронежилет NYPD",
	model = "models/tnb/items/wintercoat.mdl",
	material = "models/gmodbest/acc/armor2",
	weight = 12
}

DarkRP.Junk["armor1a"] = {
	name = "Бронежилет NYPD CT",
	model = "models/tnb/items/wintercoat.mdl",
	material = "models/gmodbest/acc/armor2a",
	weight = 12
}

DarkRP.Junk["armor2"] = {
	name = "Бронежилет FBI",
	model = "models/tnb/items/wintercoat.mdl",
	material = "models/gmodbest/acc/armor2f",
	weight = 12
}

DarkRP.Junk["scba"] = {
	name = "СИЗОД",
	model = "models/tnb/items/shirt_citizen1.mdl",
	material = "cityrp/fdny/torso_fire",
	weight = 12
}

DarkRP.Junk["box_primer"] = {
	name = "Упаковка капсюль",
	model = "models/cityrp/small/box4.mdl",
	material = "gbskins/box_primer",
	weight = 0.01,
	uses = 10,
	job = {
		[TEAM_GUN] = true
	},
	price = 20,
	shop = "rdm"
}

DarkRP.Junk["gunpowder"] = {
	name = "Оружейный порох",
	model = "models/props_lab/jar01b.mdl",
	material = "gbskins/lab_objects01",
	weight = 0.021,
	conwht = 0.1,
	uses = 10,
	job = {
		[TEAM_GUN] = true
	},
	price = 80,
	shop = "rdm"
}

DarkRP.Junk["reloadingpress"] = {
	name = "Перезарядный пресс",
	model = "models/props/cs_militia/reloadingpress01.mdl",
	weight = 1.8,
	job = {
		[TEAM_GUN] = true
	},
	price = 200,
	shop = "hardware"
}

DarkRP.Junk["bullets9"] = {
	name = "Пули 9мм",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.006,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 70,
	shop = "rdm"
}

DarkRP.Junk["cases9"] = {
	name = "Гильзы 9мм",
	model = "models/cityrp/box4.mdl",
	weight = 0.004,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 110,
	shop = "rdm"
}

DarkRP.Junk["bullets10"] = {
	name = "Пули 10мм",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.007,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 80,
	shop = "rdm"
}

DarkRP.Junk["cases10"] = {
	name = "Гильзы 10мм",
	model = "models/cityrp/box4.mdl",
	weight = 0.004,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 130,
	shop = "rdm"
}

DarkRP.Junk["bullets45"] = {
	name = "Пули .45",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.009,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 110,
	shop = "rdm"
}

DarkRP.Junk["cases45"] = {
	name = "Гильзы .45 ACP",
	model = "models/cityrp/box4.mdl",
	weight = 0.006,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 160,
	shop = "rdm"
}

DarkRP.Junk["bullets50"] = {
	name = "Пули .50 AE",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.015,
	uses = 100,
	xp = {"guns", 200},
	job = {
		[TEAM_GUN] = true
	},
	price = 320,
	shop = "kwpns"
}

DarkRP.Junk["cases50"] = {
	name = "Гильзы .50 AE",
	model = "models/cityrp/box4.mdl",
	weight = 0.01,
	uses = 100,
	xp = {"guns", 200},
	job = {
		[TEAM_GUN] = true
	},
	price = 510,
	shop = "kwpns"
}

DarkRP.Junk["bullets357"] = {
	name = "Пули .357",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.012,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 250,
	shop = "rdm"
}

DarkRP.Junk["cases357"] = {
	name = "Гильзы .357",
	model = "models/cityrp/box4.mdl",
	weight = 0.008,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 410,
	shop = "rdm"
}

DarkRP.Junk["bullets545"] = {
	name = "Пули 5.45",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.0066,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 150,
	shop = "rdm"
}

DarkRP.Junk["cases545"] = {
	name = "Гильзы 5.45x39",
	model = "models/cityrp/box3.mdl",
	weight = 0.0044,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 200,
	shop = "rdm"
}

DarkRP.Junk["bullets556"] = {
	name = "Пули 5.56",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.0072,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 180,
	shop = "rdm"
}

DarkRP.Junk["cases556"] = {
	name = "Гильзы 5.56x45",
	model = "models/cityrp/box3.mdl",
	weight = 0.0048,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 270,
	shop = "rdm"
}

DarkRP.Junk["bullets762"] = {
	name = "Пули 7.62x39",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.012,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 220,
	shop = "rdm"
}

DarkRP.Junk["cases762"] = {
	name = "Гильзы 7.62x39",
	model = "models/cityrp/box3.mdl",
	weight = 0.008,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 335,
	shop = "rdm"
}

DarkRP.Junk["bullets308"] = {
	name = "Пули .308 Win",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.0078,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 267,
	shop = "rdm"
}

DarkRP.Junk["cases308"] = {
	name = "Гильзы .308 Win",
	model = "models/cityrp/box3.mdl",
	weight = 0.0052,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 412,
	shop = "rdm"
}

DarkRP.Junk["cases792"] = {
	name = "Гильзы 7.92x57мм",
	model = "models/cityrp/box3.mdl",
	weight = 0.0052,
	uses = 100,
	price = 412,
}

DarkRP.Junk["buckshot_row"] = {
	name = "Дробь охотничья",
	model = "models/cityrp/small/box4.mdl",
	weight = 0.018,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 100,
	shop = "rdm"
}

DarkRP.Junk["cases_buckshot"] = {
	name = "Гильзы 12 калибр",
	model = "models/cityrp/box3.mdl",
	weight = 0.0012,
	uses = 100,
	job = {
		[TEAM_GUN] = true
	},
	price = 180,
	shop = "rdm"
}

DarkRP.Junk["ied_charge"] = {
	model = "models/weapons/door_charge-1.mdl",
	name = "СВУ",
	weight = 12,
	price = 1000,
	noresell = true,
	ud = {
		number = "4332666",
	},
}

DarkRP.Junk["att_vm_minireddot01"] = {
	name = "Коллиматор 'Вертекс'",
	model = "models/cityrp/small/box5.mdl",
	material = "gbskins/box_parts1",
	weight = 0.4,
	xp = {"guns", 400},
	price = 500,
	isatts = true,
	shop = "rdm_o"
}

DarkRP.Junk["att_vm_reflex_east01"] = {
	name = "Коллиматор 'Кобра'",
	model = "models/cityrp/small/box5.mdl",
	material = "gbskins/box_parts2",
	weight = 0.3,
	xp = {"guns", 500},
	price = 200,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_holo_east01"] = {
	name = "Голограф 'Восток'",
	model = "models/cityrp/small/box5.mdl",
	material = "gbskins/box_parts2",
	weight = 0.23,
	xp = {"guns", 400},
	price = 500,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_holo_west01"] = {
	name = "Голограф 'РубиТек'",
	model = "models/cityrp/small/box5.mdl",
	material = "gbskins/box_parts1",
	weight = 0.3,
	xp = {"guns", 500},
	price = 700,
	isatts = true,
	shop = "rdm_o"
}

DarkRP.Junk["att_vm_reflex_west02"] = {
	name = "Голограф 'Вольт'",
	model = "models/cityrp/small/box5.mdl",
	material = "gbskins/box_parts3",
	weight = 0.28,
	xp = {"guns", 500},
	price = 500,
	isatts = true,
	shop = "rdm_o"
}

DarkRP.Junk["att_vm_optics_axial"] = {
	name = "Оптика 'Ось'",
	model = "models/cityrp/small/box2.mdl",
	material = "gbskins/box_parts1",
	weight = 0.4,
	xp = {"guns", 500},
	price = 820,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_optics_vision"] = {
	name = "Оптика 'Окуляр'",
	model = "models/cityrp/small/box2.mdl",
	material = "gbskins/box_parts1",
	weight = 0.42,
	xp = {"guns", 500},
	price = 950,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_4x_west02"] = {
	name = "Профессиональная оптика",
	model = "models/cityrp/small/box2.mdl",
	material = "gbskins/box_parts1",
	weight = 0.5,
	xp = {"guns", 800},
	price = 1200,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_scope_vz"] = {
	name = "Снайперский прицел",
	model = "models/cityrp/small/box2.mdl",
	material = "gbskins/box_parts3",
	weight = 0.8,
	xp = {"guns", 800},
	price = 2570,
	isatts = true,
	shop = "rdm_o"
}

DarkRP.Junk["weapon_vm_scope_kilo98"] = {
	name = "Прицел для Mauser 98k",
	model = "models/cityrp/small/box2.mdl",
	material = "gbskins/box_parts2",
	weight = 0.9,
	xp = {"guns", 650},
	price = 2570,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["attachment_vm_pi_cpapa_scope"] = {
	name = "Прицел для Colt King Cobra",
	model = "models/cityrp/small/box2.mdl",
	material = "gbskins/box_parts2",
	weight = 0.4,
	xp = {"guns", 500},
	price = 550,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_silencer05"] = {
	name = "Глушитель для АК универсальный",
	model = "models/cityrp/small/box7.mdl",
	material = "gbskins/box_parts2",
	weight = 0.22,
	xp = {"guns", 700},
	price = 390,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_silencer01"] = {
	name = "Глушитель универсальный",
	model = "models/cityrp/small/box7.mdl",
	material = "gbskins/box_parts2",
	weight = 0.22,
	xp = {"guns", 800},
	price = 380,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_silencer02"] = {
	name = "Глушитель для AR-15",
	model = "models/cityrp/small/box7.mdl",
	material = "gbskins/box_parts1",
	weight = 0.18,
	xp = {"guns", 750},
	price = 300,
	isatts = true,
	shop = "rdm_o"
}

DarkRP.Junk["att_vm_silencer04_pstl"] = {
	name = "Глушитель пистолетный",
	model = "models/cityrp/small/box7.mdl",
	material = "gbskins/box_parts2",
	weight = 0.11,
	xp = {"guns", 700},
	price = 360,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_silencer02_pstl"] = {
	name = "Глушитель на M1911",
	model = "models/cityrp/small/box7.mdl",
	material = "gbskins/box_parts2",
	weight = 0.11,
	xp = {"guns", 700},
	price = 360,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["attachment_vm_pi_decho_muzzlebrake"] = {
	name = "Дульный тормоз Deagle",
	model = "models/cityrp/small/box9.mdl",
	material = "gbskins/box_parts2",
	weight = 0.05,
	xp = {"guns", 300},
	price = 50,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["mac_sup_mac10"] = {
	name = "Глушитель MAC-10",
	model = "models/cityrp/box8.mdl",
	material = "gbskins/box_parts2",
	weight = 0.55,
	xp = {"guns", 600},
	price = 100,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["rail_mount"] = {
	name = "Планка крепления универсальная",
	model = "models/cityrp/small/box6.mdl",
	material = "gbskins/box_blank",
	weight = 0.01,
	xp = {"guns", 200},
	price = 50,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["rail_mount_uzi"] = {
	name = "Планка крепления UZI",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_blank",
	weight = 0.01,
	xp = {"guns", 150},
	price = 100,
	isatts = true,
}

DarkRP.Junk["rail_mount_ak"] = {
	name = "Планка крепления AK",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_blank",
	weight = 0.01,
	xp = {"guns", 130},
	price = 100,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["rail_mount_ext"] = {
	name = "Планка крепления AR-15",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_blank",
	weight = 0.01,
	xp = {"guns", 90},
	price = 100,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["rail_mount_mp5"] = {
	name = "Планка крепления MP5",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_blank",
	weight = 0.01,
	xp = {"guns", 150},
	price = 100,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["attachment_vm_ar_mike4_mike203barrel"] = {
	name = "Антикварный ствол",
	model = "models/cityrp/box0.mdl",
	material = "gbskins/box_blank",
	weight = 0.53,
	price = 200,
	isatts = true,
}

DarkRP.Junk["att_vm_angledgrip01"] = {
	name = "Тактическая рукоятка",
	model = "models/cityrp/small/box1.mdl",
	weight = 0.05,
	xp = {"guns", 500},
	price = 300,
	isatts = true,
	shop = "rdm_o"
}

DarkRP.Junk["att_vm_stubbygrip01"] = {
	name = "Вертикальная рукоятка (мини)",
	model = "models/cityrp/small/box1.mdl",
	material = "gbskins/box_parts2",
	weight = 0.06,
	xp = {"guns", 350},
	price = 300,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_vertgrip01"] = {
	name = "Вертикальная рукоятка",
	model = "models/cityrp/small/box1.mdl",
	weight = 0.07,
	xp = {"guns", 350},
	price = 300,
	isatts = true,
	shop = "rdm_o"
}

DarkRP.Junk["att_vm_vertgrip03"] = {
	name = "Вертикальная рукоятка (макси)",
	model = "models/cityrp/small/box1.mdl",
	material = "gbskins/box_parts2",
	weight = 0.1,
	xp = {"guns", 350},
	price = 300,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["attachment_vm_ar_mike4_laser03"] = {
	name = "ЛЦУ для винтовок",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_parts2",
	weight = 0.05,
	xp = {"guns", 350},
	price = 800,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_laser01_pstl"] = {
	name = "Пистолетный фонарь",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_parts2",
	weight = 0.05,
	xp = {"guns", 350},
	price = 300,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_vm_laser03_pstl"] = {
	name = "Пистолетный ЛЦУ",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_parts2",
	weight = 0.04,
	xp = {"guns", 350},
	price = 800,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_ar_bolt"] = {
	name = "УСМ Автоматический",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_parts2",
	weight = 0.04,
	xp = {"guns", 700},
	price = 800,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["att_m16_bolt"] = {
	name = "УСМ от M16",
	model = "models/cityrp/small/box0.mdl",
	material = "gbskins/box_parts2",
	weight = 0.04,
	xp = {"guns", 700},
	price = 800,
	isatts = true,
	shop = "kwpns"
}

DarkRP.Junk["parts_hull"] = {
	model = "models/props_junk/wood_crate001a_half.mdl",
	name = "Запчасти для автомобиля",
	weight = 27,
	noresell = true,
	price = 300,
}

DarkRP.Junk["parts_engine"] = {
	model = "models/props_junk/wood_crate003a.mdl",
	name = "Запчасти от двигателя",
	weight = 21,
	noresell = true,
	price = 800,
}

DarkRP.Junk["parts_glass"] = {
	model = "models/props_junk/wood_crate002a_half.mdl",
	name = "Стекла для автомобиля",
	weight = 21,
	noresell = true,
	price = 1000,
}

DarkRP.Junk["parts_battery"] = {
	model = "models/props_lighting/battery_unrigged.mdl",
	name = "Автомобильный аккумулятор",
	weight = 10,
	price = 550,
}

DarkRP.Junk["bat_charger"] = {
	model = "models/props_lab/hifituner006a.mdl",
	name = "Зарядное устройство",
	weight = 1,
	price = 900,
	job = {
		[12] = true
	},
	shop = "hardware"
}

DarkRP.Junk["lim_lipstick"] = {
	model = "models/props_electronics/battery-5.mdl",
	material = "models/uc2/propper/woodcabinets",
	name = "Дорогая помада",
	weight = 0.1,
	price = 789,
}

for k, v in pairs(DarkRP.Junk) do
	local _, icon

	if CLIENT then
		_, icon = MSD.IconRender.Get(v.model or "models/props_junk/CinderBlock01a.mdl", v.material, v.submat)
	end

	if v.isatts then
		DarkRP.ATWeight[k] = v.weight
		DarkRP.AttCost[k] = v.price

		for a,b in pairs(DarkRP.SameAtts) do
			if b == k then
				DarkRP.ATWeight[a] = v.weight
				DarkRP.AttCost[a] = v.price
			end
		end

		v.isatts = nil
	end

	list.Set("SpawnableEntities", k, {
		Name = v.name,
		Class = "spawned_junk",
		Category = "DarkRP Junk",
		PrintName = v.name,
		AdminOnly = false,
		Extras = INV_JUNK,
		IconOverride = icon and "data/msd_render/" .. icon,
		SpawnFunction = function(ply, pos) return DarkRP.CreateJunk(k, pos) end
	})
end