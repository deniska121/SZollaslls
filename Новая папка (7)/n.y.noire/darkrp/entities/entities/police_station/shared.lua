--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/police_station/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true
ENT.PrintName = "Гос. траспорт"
ENT.Spawnable = false
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "NameType")
	self:NetworkVar("String", 1, "Type")
	self:NetworkVar("Int", 0, "Blinker")
	self:NetworkVar("Int", 1, "SpawnPoint")
end

GovCars = {}

GovCars.Price = 150
GovCars.PriceTow = 500

GovCars.DistToCar = 1000000

GovCars.Spwans = {
	[1] = {Vector(8168.78125,7467.78125,-122.25), Angle(0,90,0)},
	[2] = {Vector(9441.15625,1286.90625,-26.75), Angle(0,-180,0)},
	[3] = {Vector(3491.0625,-1703.6875,-120.625), Angle(0,-45,0)},
}

GovCars.EntSpawns = {
	{
		name = "NYPD",
		type = "police",
		effect = 2,
		spawn_point = 1,
		pos = Vector(8502.1875,7504.25,-55.78125),
		ang = Angle(0,0,0)
	},
	{
		name = "FDNY",
		type = "medic",
		effect = 2,
		spawn_point = 2,
		pos = Vector(9430.0625,1501.1875,-43.3125),
		ang = Angle(0,90,0)
	},
	{
		name = "Городские службы",
		type = "city",
		effect = 4,
		spawn_point = 3,
		pos = Vector(2568.6875,-1518.90625,-64.90625),
		ang = Angle(0,90,0)
	},
}

local carcl = {
	[1] = Color(121, 19, 19),
	[2] = Color(255, 223, 127),
	[3] = Color(96, 61, 43),
	[4] = Color(58, 85, 34),
	[5] = Color(53, 51, 59),
	[6] = Color(200, 200, 200),
	[7] = Color(35, 35, 35),
}

GovCars.Cars = {
	["sim_fphys_l4d_police_city"] = {
		teams = {
			[TEAM_POLICE] = true,
		},
		type = "police",
		max = 4,
		exam = "exam_pdcar",
		add_skin = true,
		rank = 4,
		color = color_white,
		skin = 2,
		Pov = -10,
	},
	["sim_cherokee_police"] = {
		teams = {
			[TEAM_POLICESV] = true,
			[TEAM_DETECTIVE] = true,
			[TEAM_POLICE] = true,
			[TEAM_SWAT] = true,
		},
		type = "police",
		max = 2,
		exam = "exam_pdcar",
		rank = 6,
		add_sub = 0,
		color = color_white,
		Pov = -10,
	},
	["sim_fphys_l4d_van_aux"] = {
		teams = {
			[TEAM_POLICESV] = true,
			[TEAM_WARDEN] = true,
		},
		type = "police",
		max = 1,
		rank = 6,
		skin = 0,
		exam = "exam_pdcar",
		color = color_white,
		Pov = -10,
	},
	["sim_fphys_l4d_van"] = {
		teams = {
			[TEAM_DETECTIVE] = true,
			[TEAM_POLICESV] = true,
		},
		type = "police",
		max = 1,
		rank = 5,
		skin = 0,
		exam = "exam_pdcar",
		color = carcl[#carcl],
		Pov = 100,
		pos_extra = Vector(0,100,5)
	},
	["sim_fphys_l4d_95sedan_pol"] = {
		teams = {
			[TEAM_DETECTIVE] = true,
			[TEAM_POLICESV] = true,
		},
		type = "police",
		exam = "exam_pdcar",
		max = 1,
		rank = 5,
		skin = 0,
		color = carcl[#carcl],
	},
	["sim_fphys_l4d_crownvic_pol"] = {
		teams = {
			[TEAM_DETECTIVE] = true,
			[TEAM_POLICESV] = true,
		},
		type = "police",
		max = 1,
		exam = "exam_pdcar",
		rank = 5,
		skin = 0,
		color = carcl[5],
	},
	["sim_cherokee_police_uc"] = {
		teams = {
			[TEAM_DETECTIVE] = true,
			[TEAM_POLICESV] = true,
		},
		exclus = {
			["STEAM_0:0:27976260"] = true,
			["STEAM_0:1:524313405"] = true,
			["STEAM_0:0:713737542"] = true,
			["STEAM_0:0:62160155"] = true,
			["STEAM_0:0:47288123"] = true,
			["STEAM_0:1:754512109"] = true,
			["STEAM_0:0:582137091"] = true,
		},
		type = "police",
		max = 1,
		exam = "exam_pdcar",
		rank = 5,
		skin = 0,
		color = carcl[5],
	},
	["sim_fphys_l4d_swat"] = {
		teams = {
			[TEAM_SWAT] = true,
		},
		type = "police",
		max = 1,
		exam = "exam_pdcar",
		rank = 4,
		skin = 0,
		color = color_white,
		Pov = 100,
		pos_extra = Vector(0,100,5)
	},
	["sim_fphys_l4d_fire_truck"] = {
		teams = {
			[TEAM_FIREFIGHTER] = true,
			[TEAM_INS] = true,
		},
		type = "medic",
		max = 1,
		rank = 4,
		grop = "FDNY",
		skin = 1,
		Pov = 100,
		pos_extra = Vector(0,0,0)
	},
	["sim_fphys_l4d_fire_engine"] = {
		teams = {
			[TEAM_FIREFIGHTER] = true,
			[TEAM_INS] = true,
		},
		type = "medic",
		max = 1,
		rank = 2,
		grop = "FDNY",
		skin = 1,
		Pov = 100,
		pos_extra = Vector(0,0,0)
	},
	["sim_fphys_l4d_ambulance"] = {
		teams = {
			[TEAM_REF] = true,
		},
		type = "medic",
		max = 2,
		rank = 2,
		grop = "FDNY",
		skin = 1,
		pos_extra = Vector(0,0,-70)
	},
	["sim_fphys_l4d_police_pickup"] = {
		teams = {
			[TEAM_INS] = true,
			[TEAM_REF] = true,
			[TEAM_FIREFIGHTER] = true,
		},
		type = "medic",
		max = 1,
		rank = 7,
		grop = "FDNY",
		skin = 1,
		pos_extra = Vector(0,0,-70)
	},
	["sim_fphys_l4d_pickup_tow"] = {
		teams = {
			[TEAM_CAR] = true,
		},
		type = "city",
		max = 2,
		color = color_white,
		price = 1000,
		Pov = -10,
	},
}