--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_pharm/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "workstation_base"
ENT.PrintName = "Фармацевтический стол"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.SortBy = "order"
ENT.TeamLimit = "Фармацевт"
ENT.XPTable = "pharm"

ENT.SameClasses = {
	["whater"] = {
		["whater_carb"] = true,
		["whater_jug"] = true,
	},
}

ENT.SameClassesName = {
	["whater"] = "Вода"
}

ENT.BluePrints = {
	["dry_opium"] = {
		name = "Беспримесный морфин",
		sound = "gb_sfx/craft/blender.wav",
		xp = true,
		category = "Первичная обработка",
		order = "a3",
		time = 420,
		products = {
			{
				type = INV_JUNK,
				class = "dry_opium",
				weight_apply = true,
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "paper",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sodium",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "green_opium",
				weight_store = true,
				count = 1,
			},
		}
	},
	["whater_dis"] = {
		name = "Дистиллированная вода",
		category = "Первичная обработка",
		sound = "gb_sfx/craft/boiling.wav",
		order = "a1",
		time = 60,
		products = {
			{
				type = INV_JUNK,
				class = "whater_dis",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "whater",
				count = 4,
			},
		}
	},
	["drug1"] = {
		name = "Обезболивающее",
		xp = true,
		category = "Контролируемые субстанции",
		sound = "gb_sfx/craft/pills.wav",
		order = "a1",
		price = 12,
		time = 180,
		products = {
			{
				type = INV_JUNK,
				class = "pills4",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dry_opium",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sacid",
				count = 1,
			},
		}
	},
	["bandage"] = {
		name = "Медицинская повязка",
		category = "Препараты",
		sound = "gb_sfx/craft/pepper_mill.wav",
		order = "a1",
		time = 30,
		products = {
			{
				type = INV_JUNK,
				class = "bandage",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "paper",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sodium",
				count = 1,
			},
		}
	},
	["drug2"] = {
		name = "Активированный уголь",
		category = "Препараты",
		sound = "gb_sfx/craft/pills.wav",
		order = "a2",
		time = 120,
		price = 12,
		products = {
			{
				type = INV_JUNK,
				class = "pills5",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "whater_dis",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sodium",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 1,
			},
		}
	},
	["drug3"] = {
		name = "Сироп от кашля",
		category = "Препараты",
		sound = "gb_sfx/craft/boiling_water.wav",
		order = "a3",
		price = 12,
		time = 180,
		products = {
			{
				type = INV_JUNK,
				class = "pills7",
				count = 4,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sacid",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sodium",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 1,
			},
		}
	},
	["drug4"] = {
		name = "Средство от похмелья",
		sound = "gb_sfx/craft/pills.wav",
		category = "Препараты",
		order = "a4",
		xp = true,
		price = 12,
		time = 300,
		products = {
			{
				type = INV_JUNK,
				class = "pills1",
				count = 4,
			},
		},
		componets = {
		{
				type = INV_JUNK,
				class = "whater_dis",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "sacid",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 2,
			},
		}
	},
	["drug5"] = {
		name = "Кофеиновые таблетки",
		category = "Препараты",
		sound = "gb_sfx/craft/pills.wav",
		xp = true,
		order = "a5",
		price = 9,
		time = 360,
		products = {
			{
				type = INV_JUNK,
				class = "pills6",
				count = 3,
			},
		},
		componets = {
		{
				type = INV_JUNK,
				class = "paper",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "coffee",
				count = 1,
			},
		}
	},
	["drug6"] = {
		name = "Антидепрессанты",
		category = "Контролируемые субстанции",
		sound = "gb_sfx/craft/pills.wav",
		xp = true,
		order = "a6",
		price = 20,
		time = 300,
		products = {
			{
				type = INV_JUNK,
				class = "pills2",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sacid",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "ammonia",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 1,
			},
		}
	},
	["teahp"] = {
		name = "Целебный чай",
		category = "Препараты",
		sound = "gb_sfx/craft/boiling_pot.wav",
		order = "a7",
		time = 60,
		price = 18,
		products = {
			{
				type = INV_FOOD,
				class = "teahp",
				count = 3,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "whater",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "tea",
				count = 1,
				consume = true,
			},
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 1,
			},
		}
	},
	["pills0"] = {
		name = "Плацебо",
		category = "Препараты",
		sound = "gb_sfx/craft/pills.wav",
		order = "c0",
		time = 60,
		price = 18,
		products = {
			{
				type = INV_JUNK,
				class = "pills0",
				count = 6,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "sack_herb",
				count = 1,
			},
		}
	}
}