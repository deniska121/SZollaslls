--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_table/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "workstation_base"
ENT.PrintName = "Рабочий стол"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.SortBy = "order"
ENT.CanPack = true

ENT.SameClasses = {
	["vodkan"] = {
		["vodka"] = true,
	},
	["winen"] = {
		["wine"] = true,
	},
	["rumn"] = {
		["rum"] = true,
	},
	["absinthen"] = {
		["absinthe"] = true,
	},
	["whiskeyn"] = {
		["whiskey"] = true,
	},
	["brandyn"] = {
		["brandy"] = true,
	},
	["ginn"] = {
		["gin"] = true,
	},
	["fernetn"] = {
		["fernet"] = true,
	},
	["fire_arms"] = table.Copy(DarkRP.SingleWep.FireArms),
}

ENT.SameClassesName = {
	["vodkan"] = "Распечатанная водка",
	["winen"] = "Распечатанное вино",
	["rumn"] = "Распечатанный ром",
	["absinthen"] = "Распечатанный абсент",
	["whiskeyn"] = "Распечатанный виски",
	["brandyn"] = "Распечатанный бренди",
	["ginn"] = "Распечатанный джин",
	["fernetn"] = "Распечатанный фернет",
	["fire_arms"] = "Оружие",
}

ENT.BluePrints = {
	["removeregisterid"] = {
		name = "Убрать серийный номер с оружия",
		time = 25,
		price = 12,
		skillchecker = 1,
		sound = "gb_sfx/craft/gun_cleaning.wav",
		category = "Оружие",
		componets = {
			{
				type = INV_WEAPON,
				class = "fire_arms",
				count = 1,
				change = {register = false,
				gunstate = function(item)
					if not item.gunstate then item.gunstate = 1 end
					return math.Clamp(item.gunstate - 0.05, 0, 1)
				end},
				failchange = {gunstate = function(item)
					if not item.gunstate then item.gunstate = 1 end
					return math.Clamp(item.gunstate - 0.1, 0, 1)
				end},
				check = function(e) return e.register end
			},
			{
				type = INV_JUNK,
				class = "toolbox",
				count = 1
			},
		}
	},
	["skin_fireaxe_salamanca"] = {
		name = "Покраска топора 'Нержавейка'",
		time = 1,
		category = "Покраска",
		sound = "gb_sfx/craft/gun_cleaning.wav",
		pack = "d_packhotline",
		nolimit = true,
		order = "e1",
		componets = {
			{
				type = INV_WEAPON,
				class = "mlw_fireaxe",
				count = 1,
				change = {
					wskin = "salamanca",
					material = function()
						local skin = DarkRP.GetWeaponSkin("mlw_fireaxe", "salamanca")
						return skin and skin.wm_material
					end,
				},
				check = function(e) return e.wskin ~= "salamanca" end
			},
		}
	},
	["skin_bat_wood"] = {
		name = "Покраска биты 'Дерево'",
		time = 1,
		category = "Покраска",
		sound = "gb_sfx/craft/gun_cleaning.wav",
		pack = "d_packhotline",
		nolimit = true,
		order = "e2",
		componets = {
			{
				type = INV_WEAPON,
				class = "mlw_bat",
				count = 1,
				change = {
					wskin = "wood",
					material = function()
						local skin = DarkRP.GetWeaponSkin("mlw_bat", "wood")
						return skin and skin.wm_material
					end,
				},
				check = function(e) return e.wskin ~= "wood" end
			},
		}
	},
	["tec2"] = {
		name = "'Изменения' Tec-9",
		time = 25,
		category = "Оружие",
		sound = "gb_sfx/craft/gun_cleaning.wav",
		skillchecker = 1,
		order = "a0",
		componets = {
			{
				type = INV_WEAPON,
				class = "mwb_tec9",
				change = {
					att_saved = function(item)
						item.att_saved[2]["m_Index"] = "attachment_vm_pi_tec9_bolt"
						return item.att_saved
					end,
					gunstate = function(item)
						if not item.gunstate then item.gunstate = 1 end
						return math.Clamp(item.gunstate - 0.1, 0, 1)
					end
				},
				failchange = {gunstate = function(item)
					if not item.gunstate then item.gunstate = 1 end
					return math.Clamp(item.gunstate - 0.15, 0, 1)
				end},
				check = function(e) return e.att_saved and e.att_saved[2] and e.att_saved[2]["m_Index"] == "att_bolt" end,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["battery"] = {
		name = "Зарядка аккумулятора",
		time = 200,
		category = "Другое",
		sound = "gb_sfx/craft/fan.wav",
		order = "a0",
		componets = {
			{
				type = INV_JUNK,
				class = "parts_battery",
				change = {
					batlvl = 100
				},
				check = function(e) return e.batlvl and e.batlvl < 100 end,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "bat_charger",
				count = 1,
				dont_use = true
			},
		}
	},
	["lab_set"] = {
		name = "Лабораторный стол",
		time = 15,
		category = "Другое",
		sound = "",
		nolimit = true,
		order = "d1",
		componets = {
			{
				type = INV_JUNK,
				class = "labpack",
				count = 1,
			},
			{
				type = INV_ENTITY,
				printName = "Домашная плитка",
				class = "spawned_shipment",
				check = function(e) return e.dt and e.dt.eclass and e.dt.eclass == "workstation_stove" end,
				count = 1,
			},
			{
				type = INV_ENTITY,
				printName = "Рабочий стол",
				class = "spawned_shipment",
				check = function(e) return e.dt and e.dt.eclass and e.dt.eclass == "workstation_table" end,
				change = {
					dt = {
						["Deploy"]	=	true,
						["DeployModel"]	=	"models/noire/labset.mdl",
						["eclass"]	=	"workstation_drugs",

					},
					name = "Лабораторный стол",
					weight = 3
				},
				count = 1,
			},
		}
	},
	["lab_set"] = {
		name = "Лабораторный стол",
		time = 15,
		category = "Другое",
		sound = "",
		nolimit = true,
		order = "d1",
		componets = {
			{
				type = INV_JUNK,
				class = "labpack",
				count = 1,
			},
			{
				type = INV_ENTITY,
				printName = "Домашная плитка",
				class = "spawned_shipment",
				check = function(e) return e.dt and e.dt.eclass and e.dt.eclass == "workstation_stove" end,
				count = 1,
			},
			{
				type = INV_ENTITY,
				printName = "Рабочий стол",
				class = "spawned_shipment",
				check = function(e) return e.dt and e.dt.eclass and e.dt.eclass == "workstation_table" end,
				change = {
					dt = {
						["Deploy"]	=	true,
						["DeployModel"]	=	"models/noire/labset.mdl",
						["eclass"]	=	"workstation_drugs",

					},
					name = "Лабораторный стол",
					weight = 3
				},
				count = 1,
			},
		}
	},
	["alc_set"] = {
		name = "Дистиллятор",
		time = 15,
		price = 50,
		category = "Другое",
		sound = "",
		nolimit = true,
		order = "d1",
		componets = {
			{
				type = INV_ENTITY,
				printName = "Домашная плитка",
				class = "spawned_shipment",
				check = function(e) return e.dt and e.dt.eclass and e.dt.eclass == "workstation_stove" end,
				count = 1,
			},
			{
				type = INV_ENTITY,
				printName = "Рабочий стол",
				class = "spawned_shipment",
				check = function(e) return e.dt and e.dt.eclass and e.dt.eclass == "workstation_table" end,
				change = {
					dt = {
						["Deploy"]	=	true,
						["DeployModel"]	=	"models/noire/alcset.mdl",
						["eclass"]	=	"workstation_alc",

					},
					name = "Дистиллятор",
					weight = 3
				},
				count = 1,
			},
		}
	},
	["vodka"] = {
		name = "Полная бутылка водки",
		order = "a1",
		time = 10,
		category = "Переливание",
		products = {
			{
				type = INV_FOOD,
				class = "vodka",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "vodkan",
				count = 5,
			},
		}
	},
	["wine"] = {
		name = "Полная бутылка вина",
		order = "a2",
		time = 10,
		category = "Переливание",
		products = {
			{
				type = INV_FOOD,
				class = "wine",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "winen",
				count = 2,
			},
		}
	},
	["rum"] = {
		name = "Полная бутылка рома",
		order = "a3",
		time = 10,
		category = "Переливание",
		products = {
			{
				type = INV_FOOD,
				class = "rum",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "rumn",
				count = 5,
			},
		}
	},
	["absinthe"] = {
		name = "Полная бутылка абсента",
		order = "a4",
		time = 10,
		category = "Переливание",
		products = {
			{
				type = INV_FOOD,
				class = "absinthe",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "absinthen",
				count = 5,
			},
		}
	},
	["whiskey"] = {
		name = "Полная бутылка виски",
		order = "a5",
		time = 10,
		category = "Переливание",
		products = {
			{
				type = INV_FOOD,
				class = "whiskey",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "whiskeyn",
				count = 5,
			},
		}
	},
	["brandy"] = {
		name = "Полная бутылка бренди",
		order = "a6",
		time = 10,
		category = "Переливание",
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
				class = "brandyn",
				count = 5,
			},
		}
	},
	["gin"] = {
		name = "Полная бутылка джина",
		order = "a7",
		time = 10,
		category = "Переливание",
		products = {
			{
				type = INV_FOOD,
				class = "gin",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "ginn",
				count = 5,
			},
		}
	},
	["fernet"] = {
		name = "Полная бутылка фернета",
		order = "a8",
		time = 10,
		category = "Переливание",
		products = {
			{
				type = INV_FOOD,
				class = "fernet",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "fernetn",
				count = 5,
			},
		}
	},
	["pack_morphine"] = {
		name = "Фасовка морфина",
		time = 90,
		category = "Фасовка",
		sound = "gb_sfx/craft/pills.wav",
		price = 9,
		order = "d2",
		nolimit = true,
		products = {
			{
				type = INV_JUNK,
				class = "dry_opium_small",
				weight_mult = true,
				count = 9,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dry_opium",
				weight_store = true,
				count = 1,
			},
		}
	},
	["pack_weed"] = {
		name = "Фасовка конопли",
		time = 45,
		category = "Фасовка",
		sound = "gb_sfx/craft/pills.wav",
		nolimit = true,
		price = 3,
		order = "d1",
		products = {
			{
				type = INV_JUNK,
				class = "dry_weed_small",
				weight_mult = true,
				count = 3,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dry_weed",
				weight_store = true,
				count = 1,
			},
		}
	},
	["pack_crack"] = {
		name = "Фасовка крэка",
		time = 60,
		category = "Фасовка",
		sound = "gb_sfx/craft/pills.wav",
		nolimit = true,
		price = 9,
		order = "d3",
		products = {
			{
				type = INV_JUNK,
				class = "craft_coca_small",
				weight_mult = true,
				count = 9,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "craft_coca",
				weight_store = true,
				count = 1,
			},
		}
	},
	["pack_coca"] = {
		name = "Фасовка кокаина",
		time = 70,
		category = "Фасовка",
		sound = "gb_sfx/craft/pills.wav",
		nolimit = true,
		price = 9,
		order = "d4",
		products = {
			{
				type = INV_JUNK,
				class = "done_coca_small",
				weight_mult = true,
				count = 9,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "done_coca",
				weight_store = true,
				count = 1,
			},
		}
	},
	["pack_meth"] = {
		name = "Фасовка метамфетамина",
		time = 45,
		category = "Фасовка",
		sound = "gb_sfx/craft/pills.wav",
		nolimit = true,
		price = 9,
		order = "d5",
		products = {
			{
				type = INV_JUNK,
				class = "done_meth_small",
				weight_mult = true,
				count = 9,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "done_meth",
				weight_store = true,
				count = 1,
			},
		}
	},
	["pack_heroin"] = {
		name = "Фасовка героина",
		time = 90,
		category = "Фасовка",
		sound = "gb_sfx/craft/pills.wav",
		nolimit = true,
		price = 9,
		order = "d5",
		products = {
			{
				type = INV_JUNK,
				class = "done_heroin_small",
				weight_mult = true,
				count = 9,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "done_heroin",
				weight_store = true,
				count = 1,
			},
		}
	},
	["pack_heroin_2"] = {
		name = "Шприц с героином",
		time = 30,
		category = "Фасовка",
		sound = "gb_sfx/craft/pepper_mill.wav",
		nolimit = true,
		price = 2,
		order = "d5",
		products = {
			{
				type = INV_JUNK,
				class = "done_heroin_syr",
				count = 2,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "done_heroin_small",
				count = 1,
			},
		}
	},
	["joint"] = {
		name = "Сворачивание самокруток",
		time = 120,
		category = "Фасовка",
		sound = "gb_sfx/craft/pepper_mill.wav",
		nolimit = true,
		order = "d1",
		products = {
			{
				type = INV_JUNK,
				class = "joint",
				count = 5,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dry_weed_small",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "paper",
				count = 1,
			}
		}
	},
}