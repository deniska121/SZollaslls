--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/spawnlist/misc.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DarkRP.createEntity("Коробка на 15 кг", {
	ent = "spawned_storage",
	model = "models/props_junk/cardboard_box003b.mdl",
	rmdls = {"models/props_junk/cardboard_box003b.mdl", "models/props_junk/cardboard_box003a.mdl"},
	rmats = {"", "gbskins/boxes_rdm"},
	price = 10,
	max = 3,
	weight = 0.1,
	canstore = false,
	shop = "hardware"
})

DarkRP.createEntity("Пакет на 2 кг", {
	ent = "spawned_bag",
	model = "models/props_shops/prop_bakery_flourbag_01_a.mdl",
	rmdls = {"models/props_shops/prop_bakery_flourbag_01_a.mdl", "models/props_shops/prop_bakery_flourbag_01_b.mdl"},
	material = "gbskins/boxes_rdm",
	price = 2,
	max = 3,
	weight = 0.01,
	canstore = false,
	shop = "shop"
})

DarkRP.createEntity("Ящик", {
	ent = "spawned_shipment",
	model = "models/props_junk/cardboard_box001a.mdl",
	max = 3,
	weight = 2,
	canstore = false,
})

DarkRP.Stations["workstation_drugs"] = {
	model = "models/noire/labset.mdl",
	name = "Лабораторный стол",
	weight = 3,
	price = 350,
}

DarkRP.Stations["workstation_pharm"] = {
	model = "models/cityrp/pharmstation03.mdl",
	name = "Фармацевтический стол",
	job = {
		[TEAM_MED] = true
	},
	weight = 3,
	price = 350,
	shop = "hardware"
}

DarkRP.Stations["workstation_guns"] = {
	model = "models/mosi/fallout4/furniture/workstations/workshopbench.mdl",
	name = "Стол оружейника",
	weight = 3,
	job = {
		[TEAM_GUN] = true
	},
	price = 500,
	shop = "hardware"
}

DarkRP.Stations["workstation_table"] = {
	model = "models/h4_prop_h4_table_isl_02a.mdl",
	name = "Рабочий стол",
	weight = 1,
	price = 50,
	shop = "hardware"
}

DarkRP.Stations["workstation_alc"] = {
	model = "models/noire/alcset.mdl",
	name = "Дистиллятор",
	weight = 3,
	price = 150,
}

DarkRP.Stations["planter_base"] = {
	model = "models/props_foliage/urban_pot_xlsquare01.mdl",
	name = "Грядка",
	weight = 3,
	price = 320,
	shop = "hardware"
}

DarkRP.Stations["register_gun"] = {
	model = "models/drover/bigarmory.mdl",
	name = "Оружейный шкаф",
	weight = 3,
	job = {
		[TEAM_GUN] = true
	},
	price = 200,
	shop = "hardware"
}

DarkRP.Stations["register_cook"] = {
	model = "models/props_c17/furniturefridge001a.mdl",
	name = "Касса - холодильник",
	weight = 3,
	job = {
		[TEAM_COOK] = true
	},
	price = 35,
	shop = "hardware"
}

DarkRP.Stations["register_misc"] = {
	model = "models/props_wasteland/controlroom_storagecloset001a.mdl",
	name = "Касса - Шкаф",
	weight = 3,
	price = 50,
	shop = "hardware"
}

DarkRP.Stations["workstation_cook"] = {
	model = "models/props_wasteland/kitchen_stove003a.mdl",
	name = "Коммерческая плита",
	weight = 3,
	job = {
		[TEAM_COOK] = true
	},
	price = 150,
	shop = "hardware"
}

DarkRP.Stations["workstation_car"] = {
	model = "models/mark2580/gtav/mp_apa_hi_garage/garage_stuff/engine_hoist_02a.mdl",
	name = "Кран для двигателя",
	weight = 3,
	job = {
		[TEAM_CAR] = true
	},
	price = 250,
	shop = "hardware"
}

DarkRP.Stations["static_storage"] = {
	model = "models/props/cs_militia/footlocker01_closed.mdl",
	name = "Ящик на 45 кг",
	weight = 3,
	price = 50,
	shop = "hardware"
}

DarkRP.Stations["workstation_stove"] = {
	model = "models/props_city/burger_stove.mdl",
	name = "Домашная плитка",
	weight = 1.6,
	xp = {"cook", 500},
	price = 50,
	shop = "hardware"
}

DarkRP.Stations["static_safe"] = {
	model = "models/anthon/safebox.mdl",
	name = "Сейф на 4 кг",
	weight = 5,
	price = 150,
	shop = "hardware"
}