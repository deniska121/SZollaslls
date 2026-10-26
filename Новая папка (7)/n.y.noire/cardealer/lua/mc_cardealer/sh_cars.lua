--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/cardealer/lua/mc_cardealer/sh_cars.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔══╗───╔╗╔══╗───────────╔╗──--
-- ║═╦╩╦╦╗║║║╔╗║╔═╦╦╦═╦╦═╦═╣╚╗─--
-- ║╔╣╬║╔╝║╚╣╠╣║║╬║╔╣╬╠╣╩╣═╣╔╣─--
-- ╚╝╚═╩╝─╚═╩╝╚╝║╔╩╝╚╦╝╠═╩═╩═╝─--
-- ─────────────╚╝───╚═╝───────--
-- ───── By Mactavish ─────────--
--
--McCD.Cars["242turbotdm"] = { -- Id скопировать можно из q меню
--   name = "Volvo 242 Turbo", -- Название
--   donate = true,
--	 fweels = true, -- Если машина за донат вставь в таблицу это
--   price = 20000, -- Цена
--   garage_zoom = 50, -- максимальный зум в гараже, дефолт 30, если клипится через машину, можно увеличить. Если все ок, то можно не вписывать в таблицу
--   garage_vect = Vector(0,0,5), -- Смещение в гараже по вектору если машина больше чем надо или под землей спавнится
--   garage_angle = Angle(0,180,0),  -- Поворот машины в гараже, если надо
--   grouprequirements = {"premium", "admin"},  -- группы доступа
--   noskin = true, -- запретить выбор скина 
--   allowed_skins = { -- разрешить только определенные скины
--       [0] = true, -- по id начиная с 0
--       [1] = true,
--       [2] = true,
--   },
--    baned_bg = {
--     [3] = true,
--     [4] = true,
--     [5] = true,
--     [6] = true,
--    },
--   baned_bgs = {
--        [айди группы] = {
--          [айди детали] = true,
--       }
--   },
--   bodygroups = {  -- Fix bumpers TDM
--       [3] = 1,  
--   },
--   description = "Описание", -- ни где не использую, можем вырезать
--}
--
------------------

McCD.Cars["sim_fphys_l4d_82hatchback"] = {
	name = "82 Hatchback",
	description = "",
	price = 61000,
	skins_pack = {
		["clear_cars"] = {
			[0] = "4carz1024clean",
			[1] = "models/left4dead/vehicles/4carz1024_glass_clean",
			[8] = "4carz1024clean2"
		}
	},
	tuneblock = true,
	garage_vect = Vector(0, 0, -3.8),
}

McCD.Cars["sim_fphys_l4d_94hatchback"] = {
	name = "94 Hatchback",
	description = "",
	price = 75500,
	skins_pack = {
		["clear_cars"] = {
			[0] = "models/drift_spirits/ford/skin1",
			[4] = "models/left4dead/vehicles/2carz_opaq2",
			[5] = "models/left4dead/vehicles/4carz1024_glass_clean",
		}
	},
	tuneblock = true,
	garage_vect = Vector(0, 0, 5),
}

McCD.Cars["sim_fphys_l4d_pickup_regcab"] = {
	name = "90 Ford 150",
	description = "",
	price = 76000,
	garage_zoom = 50,
	tuneblock = true,
	garage_vect = Vector(0, 0, 0.8),
}

McCD.Cars["sim_fphys_l4d_suv_2001"] = {
	name = "2001 Blazer",
	description = "",
	price = 80000,
	skins_pack = {
		["clear_cars"] = {
			[0] = "models/left4dead/vehicles/pickup_trucks2",
			[6] = "models/drift_spirits/other/glass",
		}
	},
	garage_zoom = 55,
	tuneblock = true,
	garage_vect = Vector(0, 0, -3.9),
}

McCD.Cars["sim_fphys_l4d_nuke_car"] = {
	name = "98 Corolla",
	description = "",
	price = 125000,
	tuneblock = true,
	garage_vect = Vector(0, 0, -4),
}

McCD.Cars["sim_fphys_l4d_95sedan"] = {
	name = "95 Buick",
	description = "",
	price = 160000,
	skins_pack = {
		["clear_cars"] = {
			[0] = "4carz1024clean",
			[7] = "models/left4dead/vehicles/4carz1024_glass_clean",
			[9] = "4carz1024clean2"
		}
	},
	tuneblock = true,
	garage_vect = Vector(0, 0, 1),
}

McCD.Cars["sim_fphys_l4d_van"] = {
	name = "90 Chevrolet",
	description = "",
	price = 190000,
	garage_zoom = 55,
	tuneblock = true,
	garage_vect = Vector(0, 0, -1),
}

McCD.Cars["sim_fphys_w123"] = {
	name = "85 Mercedes W123",
	description = "",
	price = 385000,
	skins_pack = {
		["clear_cars"] = {
			[0] = "models/left4dead/vehicles/dust_300d_color2",
			[9] = "models/left4dead/vehicles/4carz1024_glass_clean",
		}
	},
	tuneblock = true,
	garage_vect = Vector(15, 25, 7),
}

McCD.Cars["sim_fphys_l4d_pickup_dually"] = {
	name = "90 Ford 250",
	description = "",
	price = 210000,
	garage_zoom = 50,
	tuneblock = true,
	garage_vect = Vector(0, 0, 0.3),
}

McCD.Cars["sim_fphys_l4d_pickup_4x4"] = {
	name = "79 Ford (4x4)",
	description = "",
	price = 235000,
	garage_zoom = 55,
	tuneblock = true,
	garage_vect = Vector(0, 0, 2.5),
}

McCD.Cars["sim_fphys_l4d_crownvic"] = {
	name = "2004 Victoria",
	description = "",
	price = 270000,
	tuneblock = true,
	skins_pack = {
		["clear_cars"] = {
			[0] = "police_cab_civil",
			[6] = "models/left4dead/vehicles/4carz1024_glass_clean"
		}
	},
	garage_vect = Vector(0, 0, 0.8),
}

McCD.Cars["sim_fphys_l4d_pickup_78"] = {
	name = "78 Ford",
	description = "",
	price = 290000,
	skins_pack = {
		["clear_cars"] = {
			[0] = "models/left4dead/vehicles/pickup_trucks2",
			[4] = "models/drift_spirits/other/glass",
		}
	},
	garage_zoom = 50,
	tuneblock = true,
	garage_vect = Vector(0, 0, -3.9),
}

McCD.Cars["sim_fphys_l4d_cherokee"] = {
	name = "98 Cherokee",
	description = "",
	price = 300000,
	garage_zoom = 62,
	tuneblock = true,
	garage_vect = Vector(0, 0, -5.9),
}

McCD.Cars["sim_fphys_l4d_84sedan"] = {
	name = "84 Fleetwood",
	description = "",
	skins_pack = {
		["clear_cars"] = {
			[0] = "4carz1024clean",
			[6] = "models/left4dead/vehicles/4carz1024_glass_clean",
			[7] = "4carz1024clean2"
		}
	},
	price = 340000,
	garage_vect = Vector(0, 0, 1),
}

McCD.Cars["sim_fphys_l4d_69sedan"] = {
	name = "69 Roadrunner",
	description = "",
	price = 400000,
	skins_pack = {
		["clear_cars"] = {
			[0] = "4carz1024clean",
			[4] = "models/left4dead/vehicles/4carz1024_glass_clean",
			[5] = "4carz1024clean2"
		}
	},
	garage_vect = Vector(0, 0, 3.4),
}

McCD.Cars["sim_fphys_l4d_pickup_2004"] = {
	name = "2004 Ram",
	description = "",
	price = 400000,
	skins_pack = {
		["clear_cars"] = {
			[0] = "models/left4dead/vehicles/pickup_trucks2",
			[2] = "models/drift_spirits/other/glass",
		}
	},
	garage_zoom = 50,
	garage_vect = Vector(0, 0, 1.5),
}

McCD.Cars["sim_fphys_l4d_69charger"] = {
	name = "69 Charger",
	description = "",
	price = 510000,
	skins_pack = {
		["clear_cars"] = {
			[1] = "models/left4dead/vehicles/racecar_clear",
			[4] = "models/left4dead/vehicles/4carz1024_glass_clean",
			[6] = "4carz1024clean2"
		}
	},
	garage_vect = Vector(0, 0, 0.5),
}

-- Donate

McCD.Cars["chaser_simfphys"] = {
	name = "98 Toyota Chaser",
	description = "",
	price = 3000,
	donate = true,
	cantune = true,
	fweels = true,
	garage_vect = Vector(25,30,-3),
	garage_angle = Angle(0,180,0),
}

McCD.Cars["se3p_simfphys"] = {
	name = "2003 Mazda RX-8",
	description = "",
	price = 3000,
	donate = true,
	cantune = true,
	fweels = true,
	garage_vect = Vector(25,30,-8),
	garage_angle = Angle(0,180,0),
}
McCD.Cars["aristo_simfphys"] = {
	name = "2000 Toyota Aristo",
	description = "",
	price = 3500,
	donate = true,
	cantune = true,
	fweels = true,
	garage_vect = Vector(25,30,-6),
	garage_angle = Angle(0,180,0),
}
McCD.Cars["mk3_simfphys"] = {
	name = "90 Toyota Supra",
	description = "",
	nobuy = true,
	price = 3750,
	donate = true,
	cantune = true,
	fweels = true,
	garage_vect = Vector(25,30,-6),
	garage_angle = Angle(0,180,0),
}

McCD.Cars["fd3s_simfphys"] = {
	name = "2001 Mazda RX-7",
	description = "",
	nobuy = true,
	price = 4200,
	cantune = true,
	donate = true,
	fweels = true,
	garage_vect = Vector(25,30,-6.5),
	garage_angle = Angle(0,180,0),
}

McCD.Cars["ae86_simfphys"] = {
	name = "83 Toyota Trueno",
	description = "",
	nobuy = true,
	price = 5800,
	cantune = true,
	donate = true,
	fweels = true,
	garage_vect = Vector(25,30,-8.5),
	garage_angle = Angle(0,180,0),
}
McCD.Cars["mk4_simfphys"] = {
	name = "93 Toyota Supra",
	description = "",
	price = 4500,
	cantune = true,
	donate = true,
	fweels = true,
	garage_vect = Vector(25,30,-7.5),
	garage_angle = Angle(0,180,0),
}
McCD.Cars["r34_simfphys"] = {
	name = "99 Nissan Skyline",
	description = "",
	price = 5000,
	nobuy = true,
	cantune = true,
	donate = true,
	fweels = true,
	unlockedbg = true,
	nocase = true,
	garage_vect = Vector(25,30,-7),
	garage_angle = Angle(0,180,0),
}
McCD.Cars["simfphys_potomac_indian"] = {
	name = "53 Pontiac Chieftain",
	description = "",
	price = 5000,
	nobuy = true,
	cantune = false,
	donate = true,
	fweels = true,
	nocase = true,
	tuneblock = true,
	noskin = true,
	garage_vect = Vector(25,30,6),
	garage_angle = Angle(0,-90,0),
}
McCD.Cars["sim_fphys_l4d_hmmwv_civ"] = {
	name = "HMMWV Conversion",
	description = "",
	price = 9000,
	donate = true,
	tuneblock = true,
	garage_zoom = 50,
	garage_vect = Vector(25,30,3.5),
	garage_angle = Angle(0,-90,0),
}

McCD.Cars["sim_fphys_ats_mustang"] = {
	name = "2005 Mustang Convertible",
	description = "",
	price = 5000,
	donate = true,
	tuneblock = true,
	nocase = true,
	nobuy = true,
	garage_vect = Vector(15, 60, 17),
}

McCD.Cars["mustanggt"] = {
	name = "2005 Mustang GT",
	description = "",
	price = 5000,
	donate = true,
	fweels = {
		180,
		0,
		180,
		0,
	},
	garage_vect = Vector(15, 15, 3),
}

McCD.Cars["audi_a4"] = {
	name = "2004 Audi A4",
	description = "",
	price = 6000,
	donate = true,
	fweels = {
		180,
		0,
		180,
		0,
	},
	garage_vect = Vector(15, 25, 6),
}

McCD.Cars["bmw_m3"] = {
	name = "2002 BMW M3",
	description = "",
	price = 7000,
	donate = true,
	skins_pack = {
		["clear_cars"] = {
			[10] = "models/red_hd_bmwm3/interior3"
		}
	},
	fweels = {
		180,
		0,
		180,
		0,
	},
	garage_vect = Vector(15, 25, 3),
}

McCD.Cars["cayman_simfphys"] = {
	name = "2005 Porsche Cayman S",
	description = "",
	price = 15000,
	donate = true,
	tuneblock = true,
	nocase = true,
	palette = {
		{Color(15, 15, 15), "Черный"},
		{Color(182, 182, 182), "Белый"},
		{Color(111, 111, 111), "Серебро"},
		{Color(255, 34, 35), "Гвардейский Красный"},
		{Color(127, 159, 255), "Воздушный Синий"},
		{Color(15, 29, 25), "Лесной Зеленый"}
	},
	fweels = {
		180,
		0,
		180,
		0,
	},
	garage_vect = Vector(15, 25, 1),
}