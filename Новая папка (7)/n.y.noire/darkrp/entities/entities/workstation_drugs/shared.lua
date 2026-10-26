--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_drugs/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "workstation_base"
ENT.PrintName = "Лабораторный стол"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.SortBy = "order"
ENT.TeamLimit = "Нелегал"
ENT.XPTable = "drugs"

ENT.SameClasses = {
	["whater"] = {
		["whater_carb"] = true,
		["whater_jug"] = true,
	},
	["beer"] = {
		["whiskey"] = true,
		["wine"] = true,
		["gin"] = true,
		["vodka"] = true,
	},
	["vodka"] = {
		["absinthe"] = true,
		["moonshine"] = true,
		["gin"] = true,
		["whiskey"] = true,
	},
}

ENT.SameClassesName = {
	["whater"] = "Вода",
	["beer"] = "Круглая бутылка",
	["vodka"] = "Крепкий алкоголь"
}

ENT.BluePrints = {
	["dry_opium"] = {
		name = "Беспримесный морфин",
		category = "Опиум",
		sound = "gb_sfx/craft/blender.wav",
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
	["dry_coca"] = {
		name = "Сухие листья коки",
		time = 420,
		category = "Кокаин",
		sound = "gb_sfx/craft/fan.wav",
		order = "a2",
		products = {
			{
				type = INV_JUNK,
				class = "dry_coca",
				weight_apply = true,
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "green_coca",
				weight_store = true,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "acetone",
				count = 1,
			},
		}
	},
	["dry_weed"] = {
		name = "Сухие листья конопли",
		time = 420,
		category = "Конопля",
		sound = "gb_sfx/craft/fan.wav",
		order = "a1",
		products = {
			{
				type = INV_JUNK,
				class = "dry_weed",
				weight_apply = true,
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "green_weed",
				weight_store = true,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "acetone",
				count = 1,
			},
		}
	},
	["fentanyl"] = {
		name = "Фентанил",
		time = 180,
		category = "Опиум",
		sound = "gb_sfx/craft/boiling.wav",
		order = "b1",
		mintemp = 160,
		failtemp = 220,
		price = 6,
		products = {
			{
				type = INV_JUNK,
				class = "fentanyl",
				weight_mult = true,
				count = 6,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dry_opium",
				weight_store = true,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "ammonia",
				count = 1,
			},
		},
		failfunc = function(self, overhit)
			if overhit then
				self:EmitSound("ambient/fire/ignite.wav")
			else
				self:EmitSound("ambient/fire/mtov_flame2.wav")
			end
		end,
		failproducts = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
	["craft_coca"] = {
		name = "Сгущённые листья коки",
		time = 300,
		category = "Кокаин",
		sound = "gb_sfx/craft/boiling.wav",
		order = "e1",
		mintemp = 80,
		failtemp = 180,
		products = {
			{
				type = INV_JUNK,
				class = "craft_coca",
				weight_apply = true,
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dry_coca",
				weight_store = true,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "toulene",
				count = 1,
			},
		},
		failfunc = function(self, overhit)
			if overhit then
				self:EmitSound("ambient/fire/ignite.wav")
			else
				self:EmitSound("ambient/fire/mtov_flame2.wav")
			end
		end,
		failproducts = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
	["done_coca"] = {
		name = "Брикет кокаина",
		time = 300,
		category = "Кокаин",
		sound = "gb_sfx/craft/boiling.wav",
		order = "e2",
		mintemp = 80,
		failtemp = 180,
		products = {
			{
				type = INV_JUNK,
				class = "done_coca",
				weight_apply = true,
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "craft_coca",
				weight_store = true,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "ammonia",
				count = 1,
			},
		},
		failfunc = function(self, overhit)
			if overhit then
				self:EmitSound("ambient/fire/ignite.wav")
			else
				self:EmitSound("ambient/fire/mtov_flame2.wav")
			end
		end,
		failproducts = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
	["craft_sphingosine"] = {
		name = "Сфингозин",
		time = 120,
		category = "Опиум",
		sound = "gb_sfx/craft/boiling.wav",
		order = "e3",
		mintemp = 180,
		failtemp = 220,
		products = {
			{
				type = INV_JUNK,
				class = "craft_sphingosine",
				weight_apply = true,
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "dry_opium",
				weight_store = true,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "sacid",
				count = 1,
			},
		},
		failfunc = function(self, overhit)
			if overhit then
				self:EmitSound("ambient/fire/ignite.wav")
			else
				self:EmitSound("ambient/fire/mtov_flame2.wav")
			end
		end,
		failproducts = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
	["done_heroin"] = {
		name = "Героин",
		time = 600,
		category = "Опиум",
		sound = "gb_sfx/craft/boiling.wav",
		order = "e4",
		mintemp = 130,
		failtemp = 280,
		products = {
			{
				type = INV_JUNK,
				class = "done_heroin",
				weight_apply = true,
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "craft_sphingosine",
				weight_store = true,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "acetone",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "toulene",
				count = 1,
			},
		},
		failfunc = function(self, overhit)
			if overhit then
				self:EmitSound("ambient/fire/ignite.wav")
			else
				self:EmitSound("ambient/fire/mtov_flame2.wav")
			end
		end,
		failproducts = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
	["craft_meth"] = {
		name = "Толуоловый растворитель",
		time = 360,
		category = "Метамфетамин",
		sound = "gb_sfx/craft/blender.wav",
		order = "f1",
		mintemp = 130,
		failtemp = 220,
		products = {
			{
				type = INV_JUNK,
				class = "craft_meth",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "acetone",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "toulene",
				count = 1,
			},
		},
		failfunc = function(self, overhit)
			if overhit then
				self:EmitSound("ambient/fire/ignite.wav")
			else
				self:EmitSound("ambient/fire/mtov_flame2.wav")
			end
		end,
		failproducts = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
	["craft_meth_ice"] = {
		name = "Жидкий 'лёд'",
		time = 360,
		category = "Метамфетамин",
		sound = "gb_sfx/craft/boiling.wav",
		order = "f2",
		mintemp = 120,
		failtemp = 180,
		products = {
			{
				type = INV_JUNK,
				class = "craft_meth_ice",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "craft_meth",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "ammonia",
				count = 1,
			},
		},
		failfunc = function(self, overhit)
			self:EmitSound("weapons/flaregun/fire.wav")
			self:Explode("blue")
		end
	},
	["done_meth"] = {
		name = "Метамфетамин",
		time = 300,
		category = "Метамфетамин",
		sound = "gb_sfx/craft/fan.wav",
		order = "f3",
		products = {
			{
				type = INV_JUNK,
				class = "done_meth",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "craft_meth_ice",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "ice_bag",
				count = 5,
			},
		}
	},
	["molotov"] = {
		name = "Коктейль Молотова",
		time = 360,
		category = "Другое",
		sound = "gb_sfx/craft/boiling.wav",
		order = "f4",
		mintemp = 60,
		failtemp = 100,
		products = {
			{
				type = INV_WEAPON,
				class = "weapon_molotov",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_FOOD,
				class = "beer",
				count = 1,
				consume = true,
				ignuses = true,
			},
			{
				type = INV_FOOD,
				class = "vodka",
				count = 3,
				consume = true,
			},
			{
				type = INV_JUNK,
				class = "acetone",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "paper",
				count = 2,
			},
		},
		failfunc = function(self, overhit)
			if not overhit then return end
			self:EmitSound("weapons/flaregun/fire.wav")
			self:Ignite(120, 200)
		end,
		failproducts = {
			{
				type = INV_FOOD,
				class = "toxic_jar",
				count = 1,
			},
		}
	},
}