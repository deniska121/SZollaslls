--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/config/rp_southside_noire.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

GM.Config.DmgBlockers = {}

GM.Config.Alarms = {
	[3261] = true,
	[3260] = true,
	[1690] = true,
	[4547] = true,
	[3302] = true,
	[3333] = true,
	[3329] = true,
	[3330] = true,
	[4382] = true,
	[4504] = true,
	[4504] = true
}

GM.Config.AlarmsLocked = {
	[3270] = true, -- Shop Port
	[2869] = true, -- CarShop
	[3340] = true, -- Harware
	[4548] = true, -- Jew
	[3341] = true, -- 7/12
	[3338] = true, -- Urban

	[4543] = true, -- Hall
	[4531] = true, -- Hall
	[4538] = true, -- Hall
	[4529] = true, -- Hall
	[4528] = true, -- Hall
	[4542] = true, -- Hall
}

GM.Config.CopDoor = 2818
GM.Config.JewButt = 4548
GM.Config.JunkDoor = 2004
GM.Config.ClubMusic = {}

GM.Config.QuestOpen = {
	{
		[2619] = true,
		[2736] = true,
		[2628] = true,
	},
	{
		[2117] = true
	},
	{
		[2467] = true
	},
	{
		[2619] = true,
		[2736] = true,
		[2628] = true,
		[2467] = true
	},
}

GM.Config.ManHall = {
	[4530] = true,
	[4533] = true,
	[4544] = true,
	[4541] = true,
	[4527] = true,
	[4532] = true,
}

GM.Config.RemoveProps = {
	[1395] = true,
	[1799] = true,
	[1798] = true,
	[1800] = true,
	[1801] = true,
	[1802] = true,
	[3527] = true,
	[3528] = true,
	[3540] = true,
	[3871] = true,
	[3901] = true,
	[3872] = true,
	[3873] = true,
	[3902] = true,
	[3490] = true,
	[2688] = true,
	[2686] = true,
	[1894] = true,
	[1893] = true,
	[1892] = true,
	[1891] = true,
	[1890] = true,
	[2868] = true,
	[2866] = true,
	[2055] = true,
	[2865] = true,
	[4342] = true,
	[3828] = true,
	[3830] = true,
	[3829] = true,
	[3985] = true,
	[3552] = true,
}

GM.Config.AutoClose = {
	[2445] = true,
	[2462] = true,
	[2591] = true,
	[1435] = true,
	[3525] = true,
}

local jobs = {
	["Доставщик товаров"] = true,
	["Водитель автобуса"] = true,
	["Водитель такси"] = true
}

GM.Config.ExtraDoors = {
	[2591] = function(ply, ent) -- Impound Lock
		if not IsValid(ply) or not ply:IsPlayer() then return true end
		if ply:isCP() or ply:isEMS() then return true end
		if ply:getDarkRPVar("job") and jobs[ply:getDarkRPVar("job")] then return true end

		return false
	end,
}

local sedan_colors = {
	Color(200, 200, 200),
	Color(104, 106, 108),
	Color(61, 67, 54),
	Color(35, 35, 35),
	Color(10, 10, 10),
	Color(39, 4, 8),
	Color(15, 29, 25),
	Color(39, 15, 3),
	Color(39, 15, 3),
	Color(213, 197, 153),
	Color(108, 100, 78),
	Color(104, 106, 108),
	Color(72, 72, 101),
	Color(51, 61, 46),
	Color(61, 67, 54),
	Color(51, 58, 52),
	Color(48, 50, 50),
	Color(38, 36, 40),
	Color(35, 35, 35),
	Color(10, 10, 10),
	Color(39, 4, 8),
	Color(19, 4, 43),
	Color(15, 29, 25),
	Color(3, 39, 15),
	Color(39, 15, 3),
	Color(60, 0, 0)
}

local vans_colors = {
	Color(88, 101, 102),
	Color(108, 100, 78),
	Color(91, 71, 71),
	Color(129, 124, 110),
	Color(120, 150, 127),
	Color(61, 67, 54),
	Color(39, 4, 8),
	Color(51, 61, 46),
	Color(61, 67, 54),
}

GM.Config.BGCars = {
	["69sedan"] = {
		model = "models/noire/cars/69sedan.mdl",
		clrs = sedan_colors
	},
	["82hatchback"] = {
		model = "models/noire/cars/82hatchback.mdl",
		clrs = sedan_colors
	},
	["82hatchback_wrecked"] = {
		model = "models/noire/cars/82hatchback_wrecked.mdl",
		clrs = sedan_colors
	},
	["84sedan"] = {
		model = "models/noire/cars/84sedan.mdl",
		clrs = sedan_colors
	},
	["95sedan"] = {
		model = "models/noire/cars/95sedan.mdl",
		clrs = sedan_colors
	},
	["95sedan_wrecked"] = {
		model = "models/noire/cars/95sedan_wrecked.mdl",
		clrs = sedan_colors
	},
	["deliveryvan"] = {
		model = "models/noire/cars/deliveryvan.mdl",
		clrs = vans_colors
	},
	["deliveryvan2"] = {
		model = "models/noire/cars/deliveryvan.mdl",
		clrs = vans_colors
	},
	["flatnose_truck"] = {
		model = "models/noire/cars/flatnose_truck.mdl",
		clrs = sedan_colors
	},
	["flatnose_truck_wrecked"] = {
		model = "models/noire/cars/flatnose_truck_wrecked.mdl",
		clrs = sedan_colors
	},
	["pickup_truck_2004"] = {
		model = "models/noire/cars/pickup_truck_2004.mdl",
		clrs = sedan_colors
	},
	["pickup_truck_78"] = {
		model = "models/noire/cars/pickup_truck_78.mdl",
		clrs = sedan_colors
	},
	["police_car_city"] = {
		model = "models/noire/cars/police_car_city.mdl",
		clrs = {color_white}
	},
	["semi_truck"] = {
		model = "models/noire/cars/semi_truck.mdl",
		clrs = sedan_colors
	},
	["suv_2001"] = {
		model = "models/noire/cars/suv_2001.mdl",
		clrs = sedan_colors
	},
	["suv_cher"] = {
		model = "models/noire/cars/suv_cher.mdl",
		clrs = sedan_colors
	},
	["utility_truck"] = {
		model = "models/noire/cars/utility_truck.mdl",
		clrs = {Color(200,200,200), Color(23, 23, 23)}
	},
	["van"] = {
		model = "models/noire/cars/van.mdl",
		clrs = vans_colors
	},
	["van2"] = {
		model = "models/noire/cars/van.mdl",
		clrs = vans_colors
	},
	["semi_trailer"] = {
		model = "models/noire/cars/semi_trailer_freestanding.mdl",
		clrs = {color_white}
	},
	["crownvic"] = {
		model = "models/noire/cars/crownvic.mdl",
		clrs = sedan_colors
	},
	["corolla"] = {
		model = "models/noire/cars/corolla.mdl",
		clrs = sedan_colors
	},
	["truck_open"] = {
		model = "models/noire/cars/truck_open.mdl",
		clrs = vans_colors
	},
}

if CLIENT then return end

local car_slots = util.JSONToTable(file.Read("car_slots.json", "DATA"))
local history = {}

function ReloadPermaCars()
	history = {}

	for id,slot in pairs(car_slots) do
		local cluster = string.Explode("_", id)[1]
		if history[cluster] and math.random(3) == 2 then continue end

		local car_p, car_id = table.Random(slot)
		local car_data = GAMEMODE.Config.BGCars[car_id]

		if history[cluster] then
			if history[cluster][car_id] then print("	", car_id, "skip") continue end
		else
			history[cluster] = {}
		end

		history[cluster][car_id] = true


		local ent = ents.Create("prop_physics")

		ent:SetPos(car_p[1])
		ent:SetAngles(car_p[2])
		ent:SetModel(car_data.model)
		ent.PermaCar = true
		ent:Spawn()
		ent:SetColor(car_data.clrs[math.random(#car_data.clrs)])

		local phys = ent:GetPhysicsObject()
		if phys and phys:IsValid() then
			phys:EnableMotion(false)
		end
	end
end