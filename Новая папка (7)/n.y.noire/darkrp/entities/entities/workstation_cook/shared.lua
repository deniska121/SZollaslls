--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_cook/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "workstation_base"
ENT.PrintName = "Плита"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.SortBy = "order"
ENT.TeamLimit = "Кулинар"
ENT.XPTable = "cook"

ENT.SameClasses = {
	["whater"] = {
		["whater_carb"] = true,
		["whater_jug"] = true,
	},
	["chocolate"] = {
		["choco"] = true,
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

ENT.BluePrints = {
	["dough"] = {
		name = "Тесто",
		order = "a0",
		time = 30,
		sound = "gb_sfx/craft/cooking_prep.wav",
		category = "Общее",
		products = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "milk",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sack_flour",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sack_yeast",
				count = 1,
			},
		}
	},
	["bacon_row"] = {
		name = "Сырой бекон",
		order = "a1",
		time = 11,
		category = "Общее",
		sound = "gb_sfx/craft/cooking_prep.wav",
		products = {
			{
				type = INV_FOOD,
				class = "bacon_row",
				count = 6,
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
	["meat_t1"] = {
		name = "Отбивные",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "a3",
		time = 17,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "meat_t1",
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
	["egg_t1"] = {
		name = "Омлет",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "a4",
		time = 15,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "egg_t1",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
		}
	},
	["bread_baked"] = {
		name = "Батон хлеба",
		sound = "gb_sfx/craft/microwave.wav",
		order = "a5",
		time = 15,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "bread_baked",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["pie"] = {
		name = "Пирог",
		sound = "gb_sfx/craft/microwave.wav",
		order = "a6",
		time = 60,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "pie",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyfruit",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 1,
			},
		}
	},
	["pie_meat"] = {
		name = "Пирог",
		sound = "gb_sfx/craft/microwave.wav",
		order = "a7",
		time = 60,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "pie",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 1,
			},
		}
	},
	["cake"] = {
		name = "Торт",
		order = "a8",
		sound = "gb_sfx/craft/microwave.wav",
		time = 60,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "cake",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "milk",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 2,
			},
		}
	},
	["cake_chocolate"] = {
		name = "Шоколадный торт",
		sound = "gb_sfx/craft/microwave.wav",
		order = "a9",
		time = 60,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "cake",
				count = 1,
				extras = {
					material = "models/foodnhouseholditems/birthdaycake2"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "milk",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "chocolate",
				count = 2,
			},
		}
	},
	["feesh_gut"] = {
		name = "Разделанная рыба",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "a2",
		time = 17,
		category = "Общее",
		products = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_row",
				count = 1,
			},
		}
	},
	-- COOKED FAST
	["noodles_spam"] = {
		name = "Спамен",
		order = "b1",
		sound = "gb_sfx/craft/boiling_pot.wav",
		time = 18,
		category = "Быстрая еда",
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
		sound = "gb_sfx/craft/boiling_pot.wav",
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
		sound = "gb_sfx/craft/boiling_water.wav",
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
		category = "Быстрая еда",
		sound = "gb_sfx/craft/boiling_water.wav",
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
		category = "Быстрая еда",
		sound = "gb_sfx/craft/cooking_oil.wav",
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
		category = "Быстрая еда",
		sound = "gb_sfx/craft/cooking_oil.wav",
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
		category = "Быстрая еда",
		sound = "gb_sfx/craft/cooking_oil.wav",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
		category = "Быстрая еда",
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
	["soy_cooked"] = {
		name = "Жареная соя",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "с9",
		time = 10,
		category = "Быстрая еда",
		products = {
			{
				type = INV_FOOD,
				class = "soy_cooked",
				count = 1,
			}
		},
		componets = {
			{
				type = INV_FOOD,
				class = "soy_bean",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	-- DRINKS
	["coffee_real"] = {
		name = "Латте",
		sound = "gb_sfx/craft/boiling_water.wav",
		order = "c0",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "coffee_real",
				count = 3,
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
				class = "milk",
				count = 1,
			},
		}
	},
	["coffeepl"] = {
		name = "Латте в стаканчике",
		sound = "gb_sfx/craft/boiling_water.wav",
		order = "c1",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "coffee_real",
				count = 3,
				extras = {
					name = "Латте",
					model = "models/props_junk/garbage_plasticcup001a.mdl"
				}
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
				class = "milk",
				count = 1,
			},
		}
	},
	["coffee_real2"] = {
		name = "Капучино",
		sound = "gb_sfx/craft/boiling_water.wav",
		order = "c2",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "coffee_real",
				count = 3,
				extras = {
					name = "Капучино",
					stamina = 360,
				}
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
				class = "milk",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chocolate",
				count = 1,
			},
		}
	},
	["coffee_real3"] = {
		name = "Корретто",
		sound = "gb_sfx/craft/boiling_water.wav",
		order = "c3",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "coffee_real",
				count = 2,
				extras = {
					name = "Корретто",
					alcohol = 9,
					stamina = 270,
				}
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
				class = "brandy",
				count = 1,
			},
		}
	},
	["coffee_real4"] = {
		name = "Кофе по-ирландски",
		sound = "gb_sfx/craft/boiling_water.wav",
		order = "c4",
		time = 10,
		xp = true,
		price = 1,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "coffee_real",
				count = 2,
				extras = {
					name = "Кофе по-ирландски",
					alcohol = 10,
					stamina = 310,
				}
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
				class = "whiskey",
				count = 1,
			},
		}
	},
	["juice"] = {
		name = "Апельсиновый сок",
		sound = "gb_sfx/craft/blender.wav",
		order = "c5",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "juice",
				count = 2,
				extras = {
					name = "Апельсиновый сок",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "orange",
				count = 3,
			},
		}
	},
	["juice2"] = {
		name = "Лаймовый сок",
		sound = "gb_sfx/craft/blender.wav",
		order = "c6",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "juice",
				count = 2,
				extras = {
					name = "Лаймовый сок",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "lime",
				count = 3,
			},
		}
	},
	["juice3"] = {
		name = "Яблочный сок",
		sound = "gb_sfx/craft/blender.wav",
		order = "c7",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "juice",
				count = 2,
				extras = {
					name = "Яблочный сок",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "apple",
				count = 3,
			},
		}
	},
	["juice4"] = {
		name = "Ананасовый сок",
		sound = "gb_sfx/craft/blender.wav",
		order = "c8",
		time = 10,
		xp = true,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "juice",
				count = 3,
				extras = {
					name = "Ананасовый сок",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "ananas",
				count = 1,
				consume = true,
			},
		}
	},
	["juice5"] = {
		name = "Банановый смузи",
		sound = "gb_sfx/craft/blender.wav",
		order = "c9",
		xp = true,
		time = 10,
		category = "Напитки",
		products = {
			{
				type = INV_FOOD,
				class = "juice",
				count = 2,
				extras = {
					name = "Банановый смузи",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "banana",
				count = 3,
			},
		}
	},
	-- EXPERIMENTS
	["toxic_jar"] = {
		name = "Консервация мяса",
		sound = "gb_sfx/craft/boiling.wav",
		order = "d2",
		time = 45,
		category = "Кулинарные эксперименты",
		products = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
				extras = {
					model = "models/props_junk/garbage_metalcan001a.mdl",
					material = "",
					name = "Сомнительные консервы",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "anymeat",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sacid",
				count = 1,
			},
		}
	},
	["toxic_jar2"] = {
		name = "Смена вкуса",
		sound = "gb_sfx/craft/boiling.wav",
		order = "d3",
		time = 90,
		category = "Кулинарные эксперименты",
		products = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				extras = {
					model = "models/gibs/shield_scanner_gib1.mdl",
					material = "models/weapons/v_crowbar/crowbar_cyl"
				},
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "noodles_cooked",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sacid",
				count = 1,
			},
		}
	},
	["toxic_jar3"] = {
		name = "Регуляция кислотности",
		sound = "gb_sfx/craft/boiling.wav",
		order = "d1",
		time = 90,
		category = "Кулинарные эксперименты",
		products = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
				extras = {
					model = "models/weapons/w_bugbait.mdl",
					material = "models/weapons/v_crowbar/crowbar_cyl"
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
				type = INV_JUNK,
				class = "ammonia",
				count = 1,
			},
		}
	},
	["cursed_burger"] = {
		name = "Ликвид-ация американской культуры",
		sound = "gb_sfx/craft/pepper_mill.wav",
		order = "d4",
		time = 90,
		price = 5,
		category = "Кулинарные эксперименты",
		products = {
			{
				type = INV_FOOD,
				class = "egg",
				count = 1,
				extras = {
					name = "Бургер?",
					model = "models/food/hbrgr.mdl",
					sound = "straw",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "burger",
				count = 1,
			},
		}
	},
	["cursed_cereal"] = {
		name = "Хлопья для взрослых",
		order = "d5",
		sound = "gb_sfx/craft/pepper_mill.wav",
		time = 4,
		category = "Кулинарные эксперименты",
		products = {
			{
				type = INV_FOOD,
				class = "cursed_cereal",
				count = 1,
				extras = nil
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
				class = "beer",
				count = 1,
			},
		}
	},
	["cursed_pizza"] = {
		name = "Запрещённый приём",
		sound = "gb_sfx/craft/microwave.wav",
		order = "d6",
		time = 7,
		category = "Кулинарные эксперименты",
		products = {
			{
				type = INV_FOOD,
				class = "cursed_cereal",
				count = 1,
				extras = {
					toxic = 4,
					name = "Пицца?",
					model = "models/food/props_shops/prop_shop_pizza.mdl",
					material = "models/props_shops/prop_shop_calzonex"
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "pizza",
				count = 1,
				consume = true,
			},
			{
				type = INV_FOOD,
				class = "ananas",
				count = 1,
				consume = true,
			},
		},
		endfunc = function(self)
			self:EmitSound("weapons/flaregun/fire.wav")
			self:Ignite(120, 200)
		end
	},
	-- AMERICAN
	["burger"] = {
		name = "Бургер",
		order = "e0",
		sound = "gb_sfx/craft/cooking_oil.wav",
		time = 28,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "burger",
				count = 6,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
	["burger2"] = {
		name = "Правильный бургер",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "e1",
		time = 32,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "burger",
				count = 5,
				extras = {
					name = "Правильный бургер",
					model = "models/foodnhouseholditems/burgergtasa.mdl",
					energy = 280,
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["burger3"] = {
		name = "Чикенбургер",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "e2",
		time = 32,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "burger",
				count = 5,
				extras = {
					name = "Чикенбургер",
					model = "models/foodnhouseholditems/burgergtasa.mdl",
					energy = 280,
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chickenany",
				count = 1,
				consume = true,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["burger4"] = {
		name = "Чизбургер",
		order = "e3",
		sound = "gb_sfx/craft/cooking_oil.wav",
		time = 29,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "burger",
				count = 6,
				extras = {
					name = "Чизбургер",
					model = "models/foodnhouseholditems/burgersims2.mdl",
					energy = 260,
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
		}
	},
	["burger5"] = {
		name = "Двойной чизбургер",
		order = "e4",
		sound = "gb_sfx/craft/cooking_oil.wav",
		time = 29,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "burger",
				count = 3,
				extras = {
					name = "Двойной чизбургер",
					model = "models/foodnhouseholditems/mcdburger.mdl",
					energy = 275,
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
		}
	},
	["america"] = {
		name = "Американский сэндвич",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "e5",
		time = 40,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "america",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
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
			{
				type = INV_FOOD,
				class = "tomato",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["dog"] = {
		name = "Хотдог",
		order = "e6",
		time = 30,
		sound = "gb_sfx/craft/cooking_prep.wav",
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "dog",
				count = 6,
				extras = {
					model = "models/food/fl/wastelandhotdog.mdl"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
		}
	},
	["dog2"] = {
		name = "Правильный хотдог",
		order = "e7",
		sound = "gb_sfx/craft/cooking_prep.wav",
		time = 33,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "dog",
				count = 5,
				extras = {
					name = "Правильный хотдог",
					hunger = 300,
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["dog3"] = {
		name = "Большой хотдог",
		order = "e8",
		sound = "gb_sfx/craft/cooking_prep.wav",
		time = 20,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "dog",
				count = 4,
				extras = {
					name = "Большой хотдог",
					hunger = 350,
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
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
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["ribs"] = {
		name = "Рёбра 'Барбекю'",
		order = "e9",
		sound = "gb_sfx/craft/microwave.wav",
		time = 70,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "ribs",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 3,
			},
			{
				type = INV_FOOD,
				class = "sauce4",
				count = 2,
			},
		}
	},
	["fries"] = {
		name = "Картофель фри",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "f0",
		time = 10,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "fries",
				count = 3,
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
	["chicken_t1"] = {
		name = "Курица по-американски",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "f1",
		time = 25,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "chicken",
				count = 4,
				extras = {
					model = "models/foodnhouseholditems/mcdfriedchickenlegs.mdl",
					energy = 130,
					hunger = 150,
					maxenergy = 450,
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "chicken_america",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "sack_flour",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 1,
			},
		}
	},
	["onion"] = {
		name = "Луковые кольца",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "f2",
		time = 35,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "onion",
				count = 16,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "leek",
				count = 8,
			},
			{
				type = INV_JUNK,
				class = "sack_flour",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 2,
			},
		}
	},
	["brownie"] = {
		name = "Брауни",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f3",
		time = 40,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "brownie",
				count = 6,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chocolate",
				count = 3,
			},
		}
	},
	["twinkie"] = {
		name = "Твинки",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f4",
		time = 38,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "twinkie",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "toffi",
				count = 1,
			},
		}
	},
	["moffin"] = {
		name = "Маффин",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f5",
		time = 32,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "moffin",
				count = 6,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chocolate",
				count = 1,
			},
		}
	},
	["donut"] = {
		name = "Пончик",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f6",
		time = 20,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "donut",
				count = 5,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
		}
	},
	["donut2"] = {
		name = "Пончик с глазурью",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f7",
		time = 25,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "donut",
				count = 6,
				extras = {
					name = "Пончик с глазурью",
					model = "models/foodnhouseholditems/bagel3.mdl"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 2,
			},
		}
	},
	["donut3"] = {
		name = "Шоколадный пончик",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f8",
		time = 30,
		xp = true,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "donut",
				count = 6,
				extras = {
					name = "Шоколадный пончик",
					model = "models/foodnhouseholditems/bagel2.mdl"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chocolate",
				count = 1,
			},
		}
	},
	["american_set"] = {
		name = "Набор пончиков",
		order = "f9",
		sound = "gb_sfx/craft/pepper_mill.wav",
		time = 15,
		xp = true,
		price = 8,
		category = "Американская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_set",
				count = 1,
				extras = {
					name = "Набор пончиков"
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "donut",
				count = 9,
			},
		}
	},
	-- ITALIAN
	["italian_bread"] = {
		name = "Чиабатта",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f1",
		time = 20,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_bread",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["italian_bread2"] = {
		name = "Фокачча",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f2",
		time = 40,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_bread",
				count = 6,
				extras = {
					name = "Фокачча",
					model = "models/food/bread/bread_roll_01a_sb01.mdl"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["italian_bread3"] = {
		name = "Скьячатта",
		order = "f3",
		sound = "gb_sfx/craft/microwave.wav",
		time = 33,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_bread",
				count = 4,
				extras = {
					name = "Скьячатта",
					model = "models/food/fl/mirelurkomelette.mdl"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["italian_bread4"] = {
		name = "Чесночный хлеб",
		sound = "gb_sfx/craft/microwave.wav",
		order = "f4",
		time = 40,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_bread2",
				count = 10,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "garleek",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["italian_bread5"] = {
		name = "Пьядина",
		order = "f5",
		sound = "gb_sfx/craft/microwave.wav",
		time = 40,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_bread3",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 2,
			},
		}
	},
	["italian_noodles"] = {
		name = "Спагетти",
		order = "f6",
		sound = "gb_sfx/craft/boiling_pot.wav",
		time = 20,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_noodles",
				count = 3,
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
				class = "sauce1",
				count = 1,
			},
		}
	},
	["italian_noodles2"] = {
		name = "Спагетти с фрикадельками",
		order = "f7",
		sound = "gb_sfx/craft/boiling_pot.wav",
		time = 33,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_noodles",
				count = 4,
				extras = {
					name = "Спагетти с фрикадельками",
					submat = {
						[2] = "models/spaghettiandmeatballs01/meatballbae01"
					},
				}
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
				class = "sauce1",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
		}
	},
	["italian_pizza"] = {
		name = "Пицца",
		order = "f8",
		sound = "gb_sfx/craft/microwave.wav",
		time = 60,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_pizza",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["italian_pizza2"] = {
		name = "Пицца Маргарита",
		order = "f9",
		time = 60,
		sound = "gb_sfx/craft/microwave.wav",
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_pizza",
				count = 2,
				extras = {
					name = "Пицца Маргарита",
					material = "models/props_shops/prop_shop_calzone2"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
	["italian_pizza3"] = {
		name = "Сырная пицца",
		order = "g0",
		sound = "gb_sfx/craft/microwave.wav",
		time = 50,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_pizza",
				count = 2,
				extras = {
					name = "Сырная пицца",
					material = "models/props_shops/prop_shop_calzone5"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 3,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["italian_pizza4"] = {
		name = "Пицца Пепперони",
		order = "g1",
		sound = "gb_sfx/craft/microwave.wav",
		time = 60,
		xp = true,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_pizza",
				count = 2,
				extras = {
					name = "Пицца Пепперони",
					material = "models/props_shops/prop_shop_calzone3"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["italian_pizza4"] = {
		name = "Грибная пицца",
		order = "g2",
		time = 60,
		sound = "gb_sfx/craft/microwave.wav",
		xp = true,
		price = 5,
		category = "Итальянская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "italian_pizza",
				count = 2,
				extras = {
					name = "Грибная пицца",
					material = "models/props_shops/prop_shop_calzone4"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "leek",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	-- GERMAN
	["german_soup"] = {
		name = "Пихельштайнер",
		order = "g1",
		sound = "gb_sfx/craft/boiling_pot.wav",
		xp = true,
		time = 50,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_soup",
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
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "potato",
				count = 1,
			},
		}
	},
	["german_sosig"] = {
		name = "Винер",
		order = "g2",
		time = 25,
		sound = "gb_sfx/craft/blender.wav",
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_sosig",
				count = 5,
				extras = {
					name = "Винер",
					model = "models/food/props_shops/prop_butcher_sausage_01_c.mdl"
				}
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
	["german_sosig2"] = {
		name = "Блатвурст",
		order = "g3",
		sound = "gb_sfx/craft/blender.wav",
		time = 25,
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_sosig",
				count = 5,
				extras = {
					name = "Блатвурст",
					model = "models/food/fl/bloodsausage.mdl"
				}
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
	["german_sosig3"] = {
		name = "Вурст",
		order = "g4",
		sound = "gb_sfx/craft/blender.wav",
		time = 20,
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_sosig",
				count = 5,
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
	["german_sosig4"] = {
		name = "Братвурст",
		order = "g5",
		time = 8,
		sound = "gb_sfx/craft/cooking_oil.wav",
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_sosig2",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "german_sosig",
				count = 1,
			},
		}
	},
	["german_sosig5"] = {
		name = "Карривурст",
		order = "g6",
		sound = "gb_sfx/craft/cooking_oil.wav",
		time = 10,
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_curry",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "german_sosig",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["german_chicken"] = {
		name = "Хендль",
		order = "g7",
		sound = "gb_sfx/craft/microwave.wav",
		time = 70,
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_chicken",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "chicken_germany",
				consume = true,
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "potato",
				count = 2,
			},
		}
	},
	["german_steak"] = {
		name = "Швайнебратен",
		order = "g8",
		sound = "gb_sfx/craft/cooking_oil.wav",
		time = 20,
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "meat_cooked",
				count = 1,
				extras = {
					name = "Швайнебратен",
					hunger = 200,
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "beer",
				count = 1,
			},
		}
	},
	["german_bread"] = {
		name = "Крендель",
		sound = "gb_sfx/craft/microwave.wav",
		order = "g9",
		time = 20,
		xp = true,
		category = "Немецкая кухня",
		products = {
			{
				type = INV_FOOD,
				class = "german_bread",
				count = 5,
				extras = {
					name = "Крендель",
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 1,
			},
		}
	},
	-- ASIAN
	["asian_rice"] = {
		name = "Рис",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "h1",
		time = 20,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 2,
			},
		}
	},
	["asian_soup"] = {
		name = "Фо",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "h2",
		time = 50,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_soup",
				count = 4,
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
				class = "noodles",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "anymeat",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["asian_ramen"] = {
		name = "Рамен",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "h3",
		time = 22,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 2,
				extras = {
					name = "Рамен",
					material = "fnv/clutter/food/ramen01",
					hunger = 250,
				}
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
				class = "stock",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chicken",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
		}
	},
	["asian_ramen2"] = {
		name = "Вегетарианский рамен",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "h4",
		time = 22,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 2,
				extras = {
					name = "Вегетарианский рамен",
					material = "fnv/clutter/food/ramen01",
					hunger = 210,
				}
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
				class = "stock",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 2,
			},
		}
	},
	["asian_ramen3"] = {
		name = "Острый рамен",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "h5",
		time = 27,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 2,
				extras = {
					name = "Рамен",
					material = "fnv/clutter/food/ramen01",
					hunger = 265,
				}
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
				class = "stock",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chicken",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sauce5",
				count = 1,
			},
		}
	},
	["asian_kebab"] = {
		name = "Сатэ",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "h6",
		time = 26,
		xp = true,
		price = 2,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_kebab",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["asian_salad"] = {
		name = "Кимчи",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "h7",
		time = 34,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_salad",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "leek",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "garleek",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sauce5",
				count = 1,
			},
		}
	},
	["asian_ice"] = {
		name = "Бин Чилинг",
		sound = "gb_sfx/craft/blender.wav",
		order = "h8",
		time = 12,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_ice",
				count = 6,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "milk",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "ice_bag",
				count = 1,
			},
		}
	},
	["asian_fish"] = {
		name = "Фугу",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "h9",
		time = 100,
		xp = true,
		toxic = 1,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_fish",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_asian",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
	["asian_sushi"] = {
		name = "Ролл Калифорния",
		order = "i0",
		sound = "gb_sfx/craft/cooking_prep.wav",
		time = 27,
		xp = true,
		price = 3,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Калифорния",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "veg_asian",
				count = 1,
			},
		}
	},
	["asian_sushi2"] = {
		name = "Ролл Филадельфия",
		order = "i1",
		sound = "gb_sfx/craft/cooking_prep.wav",
		time = 23,
		xp = true,
		price = 4,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Филадельфия",
					submat = {
						[0] = "gb_foods/rice2",
						[1] = "gb_foods/salmon",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "veg_asian",
				count = 1,
			},
		}
	},
	["asian_sushi3"] = {
		name = "Ролл с тунцом",
		order = "i2",
		sound = "gb_sfx/craft/cooking_prep.wav",
		time = 30,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Ролл с тунцом",
					submat = {
						[0] = "gb_foods/tuna",
						[1] = "gb_foods/rice",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
		}
	},
	["asian_sushi4"] = {
		name = "Урамаки",
		order = "i3",
		sound = "gb_sfx/craft/cooking_prep.wav",
		xp = true,
		time = 30,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Урамаки",
					submat = {
						[1] = "gb_foods/rice",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "veg_asian",
				count = 1,
			},
		}
	},
	["asian_nigiri"] = {
		name = "Нигири с лососем",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "i4",
		xp = true,
		time = 20,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Нигири с лососем",
					model = "models/food/cityrp/susi01.mdl",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
		}
	},
	["asian_nigiri2"] = {
		name = "Нигири с тунцом",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "i5",
		time = 20,
		xp = true,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Нигири с тунцом",
					model = "models/food/cityrp/susi01.mdl",
					submat = {
						[0] = "gb_foods/tuna",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
		}
	},
	["asian_oshizushi"] = {
		name = "Ошизуши с лососем",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "i6",
		time = 35,
		xp = true,
		price = 3,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Ошизуши с лососем",
					model = "models/food/cityrp/susi03.mdl",
					submat = {
						[2] = "gb_foods/salmon",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "veg_asian",
				count = 1,
			},
		}
	},
	["asian_oshizushi2"] = {
		name = "Ошизуши с тунцом",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "i7",
		time = 35,
		xp = true,
		price = 3,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Ошизуши с тунцом",
					model = "models/food/cityrp/susi03.mdl",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "veg_asian",
				count = 1,
			},
		}
	},
	["asian_oshizushi3"] = {
		name = "Ошизуши нори",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "i8",
		time = 35,
		xp = true,
		price = 5,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Ошизуши нори",
					model = "models/food/cityrp/susi04.mdl",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "veg_asian",
				count = 1,
			},
		}
	},
	["asian_oshizushi4"] = {
		name = "Ошизуши нори огурец",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "i9",
		time = 35,
		xp = true,
		price = 6,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Ошизуши нори с огурцом",
					model = "models/food/cityrp/susi04.mdl",
					submat = {
						[1] = "gb_foods/rice1",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
		}
	},
	["asian_oshizushi5"] = {
		name = "Ошизуши нори авокадо",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "j0",
		time = 35,
		xp = true,
		price = 8,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Ошизуши нори авокадо",
					model = "models/food/cityrp/susi04.mdl",
					submat = {
						[1] = "gb_foods/rice2",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
		}
	},
	["asian_oshizushi6"] = {
		name = "Ошизуши Филадельфия",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "j1",
		xp = true,
		time = 35,
		price = 7,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_sushi",
				count = 7,
				extras = {
					name = "Ошизуши Филадельфия",
					model = "models/food/cityrp/susi04.mdl",
					submat = {
						[0] = "gb_foods/salmon",
					},
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "feesh_gut",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "asian_rice",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "nori",
				count = 1,
			},
		}
	},
	["asian_set"] = {
		name = "Сет суши",
		sound = "gb_sfx/craft/pepper_mill.wav",
		order = "j2",
		time = 15,
		xp = true,
		price = 8,
		category = "Азиатская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "asian_set",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "sushi",
				count = 12,
			},
			{
				type = INV_FOOD,
				class = "sauce5",
				count = 1,
			},
		}
	},
	-- FRENCH
	["french_bread"] = {
		name = "Батард",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j1",
		time = 15,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_bread",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["french_bread2"] = {
		name = "Комплет",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j2",
		time = 15,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_bread",
				count = 4,
				extras = {
					name = "Комплет",
					model = "models/foodnhouseholditems/bread-3.mdl",
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["french_bread3"] = {
		name = "Полька",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j3",
		time = 15,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_bread",
				count = 4,
				extras = {
					name = "Полька",
					model = "models/food/props_shops/prop_bakery_bread_01_a.mdl",
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["french_bread4"] = {
		name = "Багет де Гранде",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j4",
		time = 20,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_baget",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["french_gougere"] = {
		name = "Гужер",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j5",
		time = 25,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_gougere",
				count = 5,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
		}
	},
	["french_pancake"] = {
		name = "Креп",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "j6",
		time = 25,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_pancake",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyfruit",
				count = 1,
			},
		}
	},
	["chocolatine"] = {
		name = "Чоколатин",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j7",
		time = 20,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "chocolatine",
				count = 5,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chocolate",
				count = 1,
			},
		}
	},
	["french_croissant"] = {
		name = "Круассан",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j8",
		time = 20,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_croissant",
				count = 5,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
		}
	},
	["french_finger"] = {
		name = "Хлебные палочки",
		sound = "gb_sfx/craft/microwave.wav",
		order = "j9",
		time = 11,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_finger",
				count = 9,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["french_waffle"] = {
		name = "Вафля",
		sound = "gb_sfx/craft/microwave.wav",
		order = "k0",
		time = 30,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_waffle",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
		}
	},
	["french_pie"] = {
		name = "Киш",
		sound = "gb_sfx/craft/microwave.wav",
		order = "k1",
		time = 60,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_pie",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg",
				count = 1,
			},
		}
	},
	["french_cake"] = {
		name = "Милле-фюлле",
		sound = "gb_sfx/craft/microwave.wav",
		order = "k2",
		time = 70,
		xp = true,
		category = "Французская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "french_cake",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "milk",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg",
				count = 1,
			},
		}
	},
	-- EURASIAN
	["europan_sosig"] = {
		name = "Сарделька",
		sound = "gb_sfx/craft/blender.wav",
		order = "k1",
		time = 10,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_sosig",
				count = 6,
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
	["europan_sandwich"] = {
		name = "Сосиска в тесте",
		sound = "gb_sfx/craft/microwave.wav",
		order = "k2",
		time = 10,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_sandwich",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "europan_sosig",
				count = 4,
			},
		}
	},
	["europan_dumpling"] = {
		name = "Пельмени",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "k3",
		time = 30,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_dumpling",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anymeat",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 1,
			},
		}
	},
	["europan_soup"] = {
		name = "Борщ",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "k4",
		time = 50,
		price = 5,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_soup",
				count = 5,
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
				class = "lettuce",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "potato",
				count = 3,
			},
			{
				type = INV_FOOD,
				class = "leek",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "sauce1",
				count = 2,
			},
		}
	},
	["europan_pancake"] = {
		name = "Блины",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "k5",
		time = 30,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_pancake",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["europan_bread"] = {
		name = "Ржаной хлеб",
		sound = "gb_sfx/craft/microwave.wav",
		order = "k6",
		time = 15,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_bread",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
		}
	},
	["europan_cheburek"] = {
		name = "Чебурек с мясом",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "k7",
		time = 20,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_cheburek",
				count = 3,
				extras = {
					name = "Чебурек с мясом"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
	["europan_cheburek2"] = {
		name = "Чебурек с сыром",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "k8",
		time = 20,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_cheburek",
				count = 3,
				extras = {
					name = "Чебурек с сыром"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
	["europan_cheburek3"] = {
		name = "Овощной чебурек",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "k9",
		time = 20,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_cheburek",
				count = 3,
				extras = {
					name = "Чебурек с овощами"
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "leek",
				count = 1,
			},
		}
	},
	["europan_cheburek4"] = {
		name = "Янтык",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "l0",
		time = 40,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_cheburek",
				count = 1,
				extras = {
					model = "models/food/props_shops/prop_shop_calzone.mdl",
					energy = 250,
					hunger = 300,
					name = "Янтык",
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meatproduct",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "leek",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 1,
			},
		}
	},
	["europan_samsa"] = {
		name = "Самса",
		sound = "gb_sfx/craft/microwave.wav",
		order = "l1",
		time = 30,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_samsa",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "meat_row",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "leek",
				count = 2,
			},
		}
	},
	["doner"] = {
		name = "Шаурма",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "l2",
		time = 40,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "doner",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "chickenany",
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
				count = 2,
			},
		}
	},
	["europan_hachapuri"] = {
		name = "Хачапури",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "l3",
		time = 20,
		xp = true,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_hachapuri",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 3,
			},
		}
	},
	["europan_hachapuri2"] = {
		name = "Классический хачапури",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "l4",
		xp = true,
		time = 40,
		category = "Восточно-Евразийская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "europan_hachapuri",
				count = 2,
				extras = {
					name = "Классический хачапури",
					model = "models/food/khachapuri.mdl",
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dough",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "cheese",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "egg_row",
				count = 2,
			},
		}
	},
	-- VEGAN
	["vegan_soup"] = {
		name = "Овощной суп",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "l1",
		time = 50,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "soup",
				count = 4,
				extras = {
					name = "Овощной суп"
				}
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
				class = "anyveg",
				count = 4,
			},
		}
	},
	["vegan_salad"] = {
		name = "Овощной салат",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "l2",
		time = 22,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "vegan_salad",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 4,
			},
			{
				type = INV_FOOD,
				class = "tomato",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "lettuce",
				count = 3,
			},
		}
	},
	["vegan_fruit"] = {
		name = "Фруктовый салат",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "l3",
		time = 17,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "vegan_fruit",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "anyfruit",
				count = 9,
			},
			{
				type = INV_FOOD,
				class = "orange",
				count = 4,
			},
			{
				type = INV_FOOD,
				class = "banana",
				count = 3,
			},
		}
	},
	["vegan_tofu"] = {
		name = "Тофу",
		sound = "gb_sfx/craft/cooking_prep.wav",
		order = "l4",
		time = 40,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "vegan_tofu",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "soy_bean",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "lemon",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 4,
			},
		}
	},
	["vegan_cooked"] = {
		name = "Жареный тофу",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "l5",
		time = 10,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "vegan_cooked",
				count = 1,
				extras = {
					name = "Жареный тофу",
				}
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "vegan_tofu",
				count = 1,
			},
		}
	},
	["vegan_kebab"] = {
		name = "Шашлык из тофу",
		sound = "gb_sfx/craft/cooking_oil.wav",
		order = "l6",
		time = 20,
		price = 2,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "vegan_kebab",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "vegan_tofu",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["vegan_stew"] = {
		name = "Рагу из тофу",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "l7",
		time = 20,
		price = 2,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "vegan_stew",
				count = 1,
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
				class = "vegan_tofu",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "anyveg",
				count = 2,
			},
			{
				type = INV_FOOD,
				class = "anysos",
				count = 1,
			},
		}
	},
	["vegan_noodles"] = {
		name = "Макароны из тофу",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "l8",
		time = 20,
		xp = true,
		category = "Вегетарианская кухня",
		products = {
			{
				type = INV_FOOD,
				class = "vegan_noodles",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "vegan_tofu",
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
}