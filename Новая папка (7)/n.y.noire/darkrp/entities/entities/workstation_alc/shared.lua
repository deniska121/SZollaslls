--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_alc/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "workstation_base"
ENT.PrintName = "Дистиллятор"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.SortBy = "order"
ENT.TeamLimit = "Кулинар"
ENT.XPTable = "alc"

ENT.BluePrints = {
	["beer"] = {
		name = "Пиво",
		order = "a0",
		time = 10,
		category = "Лёгкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "beer",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sack_grain",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "sack_yeast",
				count = 1
			}
		}
	},
	["vodka"] = {
		name = "Водка",
		order = "a5",
		time = 15,
		category = "Крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "vodka",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sack_grain",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 4,
			},
			{
				type = INV_JUNK,
				class = "sack_yeast",
				count = 1,
			}
		}
	},
	["wine"] = {
		name = "Вино",
		order = "a1",
		time = 20,
		category = "Средне-крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "wine",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sack_grape",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "sack_yeast",
				count = 1,
			}
		}
	},
	["rum"] = {
		name = "Ром",
		order = "a6",
		time = 15,
		category = "Средне-крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "rum",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sack_sugar",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 4,
			},
			{
				type = INV_JUNK,
				class = "sack_yeast",
				count = 1,
			}
		}
	},
	["absinthe"] = {
		name = "Абсент",
		order = "a8",
		time = 45,
		category = "Крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "absinthe",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "vodka",
				count = 3,
				consume = true,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 2,
			}
		}
	},
	["whiskey"] = {
		name = "Виски",
		order = "a7",
		time = 25,
		category = "Крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "whiskey",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sack_grain",
				count = 1,
			},
			{
				type = INV_FOOD,
				class = "whater",
				count = 4,
			},
			{
				type = INV_JUNK,
				class = "sack_yeast",
				count = 1,
			}
		}
	},
	["brandy"] = {
		name = "Бренди",
		order = "a2",
		time = 20,
		category = "Средне-крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "brandy",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "wine",
				count = 1,
				consume = true,
			}
		}
	},
	["gin"] = {
		name = "Джин",
		order = "a3",
		time = 20,
		category = "Крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "gin",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "vodka",
				count = 1,
				consume = true,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 1,
			}
		}
	},
	["fernet"] = {
		name = "Фернет",
		order = "a4",
		time = 25,
		category = "Средне-крепкий алкоголь",
		products = {
			{
				type = INV_FOOD,
				class = "fernet",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "vodka",
				count = 1,
				consume = true,
			},
			{
				type = INV_FOOD,
				class = "sugar",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 1,
			}
		}
	}
}