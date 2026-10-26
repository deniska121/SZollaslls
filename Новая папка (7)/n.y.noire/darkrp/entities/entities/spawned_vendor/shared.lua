--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/spawned_vendor/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Торговый автомат"
ENT.Author = "Mactavish"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Stocked")
	self:NetworkVar("Int",0,"Button")
	self:NetworkVar("String",0,"VendorType")
end

function ENT:GetNearestButton(client)
	client = client or (CLIENT and LocalPlayer())
	local vtype = DarkRP.Vendors[self:GetVendorType()]
	if not vtype then return nil end
	local hitPos = client:GetEyeTrace().HitPos
	local cls, but

	if hitPos then
		for k, v in pairs(vtype.buttons) do
			local pos = self:LocalToWorld(v.pos):DistToSqr(hitPos)

			if pos <= 10 and (not cls or cls > pos) then
				but = k
				cls = pos
			end
		end
	end

	return but
end

DarkRP.Vendors = {}

DarkRP.Vendors["office"] = {
	model = "models/props/cs_office/vending_machine.mdl",
	material = "gb_foods/vd",
	pos = Vector(-0.94,-18.31,15.68),
	ang = Angle(0,-90,-90),
	buttons = {
		[1] = {
			pos = Vector(22, -19, 42.6),
			food = "pop_cola",
			price = 5
		},
		[2] = {
			pos = Vector(22, -19, 40.6),
			food = "pop_fanta",
			price = 5
		},
		[3] = {
			pos = Vector(22, -19, 38.6),
			food = "pop_sprite",
			price = 5
		},
		[4] = {
			pos = Vector(22, -19, 36.6),
			food = "pop_whater",
			price = 3
		},
		[5] = {
			pos = Vector(22, -19, 34.6),
			food = "pop_carb",
			price = 3
		},
		[6] = {
			pos = Vector(22, -19, 32.6),
			food = "pop_cherry",
			price = 5
		},
		[7] = {
			pos = Vector(22, -19, 30.6),
			food = "pop_life",
			price = 20
		},
	}
}

DarkRP.Vendors["union"] = {
	model = "models/unioncity2/props_fastfood/vending_machine.mdl",
	material = "gmodla/vending_machine",
	pos = Vector(20.72,-0.44,23.33),
	ang = Angle(0,0,-90),
	buttons = {
		[1] = {
			pos = Vector(23.57,19.7,50.54),
			food = "pop_cola",
			price = 5
		},
		[2] = {
			pos = Vector(23.57,19.7,45.85),
			food = "pop_fanta",
			price = 5
		},
		[3] = {
			pos = Vector(23.57,19.7,48.22),
			food = "pop_sprite",
			price = 5
		},
		[4] = {
			pos = Vector(23.57,19.7,39.02),
			food = "pop_whater",
			price = 3
		},
		[5] = {
			pos = Vector(23.57,19.7,52.83),
			food = "pop_carb",
			price = 3
		},
		[6] = {
			pos = Vector(23.57,19.7,41.35),
			food = "pop_cherry",
			price = 5
		},
		[7] = {
			pos = Vector(23.57,19.7,43.72),
			food = "pop_life",
			price = 20
		},
	}
}

DarkRP.Vendors["snack"] = {
	model = "models/uc/props_fastfood/snack_machine_01a.mdl",
	pos = Vector(25.72,0,23.33),
	ang = Angle(0,90,0),
	buttons = {
		[1] = {
			pos = Vector(19.8,19.9,67),
			food = "chips_small",
			material = "gbskins/chips1",
			price = 5
		},
		[2] = {
			pos = Vector(19.8,21.9,67),
			food = "chips_small",
			material = "gbskins/chips2",
			price = 5
		},
		[3] = {
			pos = Vector(19.79,19.9,64),
			food = "chips_small",
			material = "gbskins/chips3",
			price = 5
		},
		[4] = {
			pos = Vector(19.79,21.9,64),
			food = "chips_small",
			material = "gbskins/chips4",
			price = 5
		},
		[5] = {
			pos = Vector(19.78,20.9,65.5),
			food = "chips_small",
			material = "gbskins/chips5",
			price = 5
		},
		[6] = {
			pos = Vector(19.78,22.9,65.5),
			food = "chips_small",
			material = "gbskins/chips6",
			price = 5
		},
		[7] = {
			pos = Vector(19.78,19.9,61),
			food = "chips_chocookie",
			price = 6
		},
		[8] = {
			pos = Vector(19.78,21.9,61),
			food = "kkkk",
			price = 8
		}
	}
}