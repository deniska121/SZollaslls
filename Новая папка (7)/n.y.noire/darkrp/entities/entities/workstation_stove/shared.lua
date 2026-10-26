--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_stove/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "workstation_base"
ENT.PrintName = "Плитка"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.SortBy = "order"
ENT.BuffMult = 0.1

--ENT.XPTable = "cook"
ENT.SameClasses = {
	["whater"] = {
		["whater_carb"] = true,
		["whater_jug"] = true,
	},
	["meatproduct"] = {
		["meat_row"] = true,
		["meat_cooked"] = true,
		["meat_t1"] = true,
		["bacon_row"] = true,
		["bacon"] = true,
		["german_sosig"] = true,
		["german_sosig2"] = true,
		["europan_sosig"] = true,
	},
	["anyveg"] = {
		["potato"] = true,
		["leek"] = true,
		["garleek"] = true,
		["tomato"] = true,
	},
	["anyfruit"] = {
		["melon"] = true,
		["banana"] = true,
		["apple"] = true,
		["orange"] = true,
		["lemon"] = true,
		["lime"] = true,
		["ananas"] = true,
	},
	["anymeat"] = {
		["meat_row"] = true,
		["meat_steak"] = true,
		["chicken_row"] = true,
		["chicken"] = true,
		["feesh_row"] = true,
		["feesh_baked"] = true,
	},
	["anysos"] = {
		["sauce1"] = true,
		["sauce2"] = true,
		["sauce3"] = true,
		["sauce4"] = true,
		["sauce5"] = true,
	},
	["bread"] = {
		["bread_baked"] = true,
		["italian_bread"] = true,
		["italian_bread2"] = true,
		["italian_bread3"] = true,
		["french_bread"] = true,
		["french_baget"] = true,
		["europan_bread"] = true,
	},
	["pizza"] = {
		["italian_pizza"] = true,
	},
	["chickenany"] = {
		["chicken_row"] = true,
		["chicken"] = true,
	},
	["chicken_america"] = {
		["chicken_row"] = true,
	},
	["chicken_germany"] = {
		["chicken_row"] = true,
	},
	["feesh"] = {
		["feesh_steak"] = true,
		["feesh_gut"] = true,
		["feesh_row"] = true,
	},
	["feesh_asian"] = {
		["feesh_row"] = true,
	},
	["veg_asian"] = {
		["leek"] = true,
		["garleek"] = true,
		["tomato"] = true,
	},
	["sushi"] = {
		["asian_sushi"] = true,
	},
}

ENT.SameClassesName = {
	["whater"] = "Вода",
	["chickenany"] = "Курица",
	["feesh"] = "Рыба",
	["meatproduct"] = "Мясное изделие",
	["anymeat"] = "Мясо",
	["anyveg"] = "Овощ",
	["anysos"] = "Соус",
	["feesh_asian"] = "Сырая рыба",
	["chicken_america"] = "Сырая курица",
	["chicken_germany"] = "Сырая курица",
	["pizza"] = "Пицца",
	["bread"] = "Хлеб",
	["anyfruit"] = "Фрукт",
	["veg_asian"] = "Овощ",
	["sushi"] = "Суши/Ролы",
}

-- COOKED FAST
ENT.BluePrints = {
	["noodles_spam"] = {
		name = "Спамен",
		order = "b1",
		sound = "gb_sfx/craft/boiling_pot.wav",
		time = 18,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "noodles_spam",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "noodles",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "spam",
				count = 1,
			},
		}
	},
	["noodles_home"] = {
		name = "Макароны",
		order = "b2",
		time = 18,
		nolimit = true,
		sound = "gb_sfx/craft/boiling_pot.wav",
		products = {
			{
				type = INV_FOOD,
				class = "noodles_home",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "noodles",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["cereal_cooked"] = {
		name = "Хлопья",
		order = "b3",
		time = 4,
		sound = "gb_sfx/craft/pepper_mill.wav",
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "cereal_cooked",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "cereal",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "milk",
				count = 1,
			},
		}
	},
	["coffeecup"] = {
		name = "Кружка кофе",
		order = "b4",
		time = 10,
		sound = "gb_sfx/craft/boiling_water.wav",
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "coffeecup",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "coffee",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 1,
			},
		}
	},
	["teacup"] = {
		name = "Кружка чая",
		order = "b5",
		time = 10,
		sound = "gb_sfx/craft/boiling_water.wav",
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "teacup",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "tea",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 1,
			},
		}
	},
	["meat_cooked"] = {
		name = "Стейк",
		order = "b6",
		time = 25,
		sound = "gb_sfx/craft/cooking_oil.wav",
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "meat_cooked",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
		}
	},
	["bacon"] = {
		name = "Бекон",
		order = "b7",
		time = 10,
		sound = "gb_sfx/craft/cooking_oil.wav",
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "bacon",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "bacon_row",
				count = 1,
			},
		}
	},
	["chicken"] = {
		name = "Курица",
		order = "b8",
		time = 15,
		sound = "gb_sfx/craft/cooking_oil.wav",
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "chicken",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "chicken_row",
				count = 1,
			},
		}
	},
	["feesh_baked"] = {
		name = "Запечёная рыба",
		sound = "gb_sfx/craft/microwave.wav",
		order = "b9",
		time = 30,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "feesh_baked",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh",
				count = 1,
			},
		}
	},
	["feesh_steak"] = {
		name = "Жареная рыба",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "с1",
		time = 13,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "feesh_steak",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
		}
	},
	["egg"] = {
		name = "Яичница",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "с2",
		time = 10,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "egg",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 1,
			},
		}
	},
	["potato_cooked"] = {
		name = "Жареный картофель",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "с3",
		time = 16,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "potato_cooked",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "potato",
				count = 1,
			},
		}
	},
	["stock"] = {
		name = "Бульон",
		order = "с4",
		sound = "gb_sfx/craft/boiling_pot.wav",
		time = 20,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "stock",
				count = 6,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "whater",
				count = 4,
			},
			{
				type = INV_FOOD,
				class = "anymeat",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "leek",
				count = 2,
			},
		}
	},
	["soup"] = {
		name = "Суп",
		order = "с5",
		sound = "gb_sfx/craft/boiling_pot.wav",
		time = 50,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "soup",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "stock",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 3,
			},
		}
	},
	["sandwich"] = {
		name = "Сэндвич",
		order = "с6",
		sound = "gb_sfx/craft/cooking_prep.wav",
		time = 30,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "sandwich",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "bread",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "bacon",
				count = 4,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
	["sandwich_fish"] = {
		name = "Рыбный сэндвич",
		order = "с7",
		sound = "gb_sfx/craft/cooking_prep.wav",
		time = 40,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "sandwich",
				count = 3,
				extras = {
					material = "models/foodnhouseholditems/sandwich3",
					name = "Рыбный сэндвич"
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "bread",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "feesh",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
	["sandwich_chicken"] = {
		name = "Куриный сэндвич",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "с8",
		time = 20,
		nolimit = true,
		products = {
			{
				type = INV_FOOD,
				class = "sandwich",
				count = 4,
				extras = {
					material = "models/foodnhouseholditems/sandwich2",
					name = "Куриный сэндвич"
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "bread",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chicken",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
}