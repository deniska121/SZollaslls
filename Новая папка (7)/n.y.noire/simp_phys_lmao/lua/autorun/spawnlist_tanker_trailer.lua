--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_tanker_trailer.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Tanker Trailer",
	Model = "models/left4dead/vehicles/tankertrailer.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1400.0,
		NAKTankerHB = {
			Tank = {
				OBBMax = Vector(270, 50, 50),
				OBBMin = Vector(-180, -50, -40),
			},
		},
		Trailers = {
			inputPos = Vector(202, 0, 50),
			inputType = "axis",
		},
		IsTrailer = true,
		NoDriverSeat = true,
		NoEngine = true,
		EnginePos = Vector(0, 0, 0),
		LightsTable = "tanker_trailer",
		OnSpawn = function(ent)
			ent:Lock()
			ent.supportphys = ents.Create("prop_physics")
			ent.supportphys:SetModel("models/props_phx/construct/metal_tube.mdl")
			ent.supportphys:SetPos(ent:LocalToWorld(Vector(90, 0, 0)))
			ent.supportphys:SetAngles(ent:GetAngles())
			ent.supportphys:SetNoDraw(true)
			ent.supportphys.DoNotDuplicate = true
			ent.supportphys:Spawn()
			constraint.Weld(ent, ent.supportphys, 0, 0, 0, true, true)
		end,
		OnTick = function(ent) end,
		OnDelete = function(ent)
			if IsValid(ent.supportphys) then
				ent.supportphys:Remove()
			end
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		CustomWheelPosFL = Vector(-97, 40, 22),
		CustomWheelPosFR = Vector(-97, -40, 22),
		CustomWheelPosRL = Vector(-148, 40, 22),
		CustomWheelPosRR = Vector(-148, -40, 22),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(50, 0, 10),
		CustomSteerAngle = 60,
		SeatOffset = Vector(0, 0, 0),
		SeatPitch = 0,
		SeatYaw = 90,
		FrontHeight = 5,
		FrontConstant = 50000,
		FrontDamping = 2000,
		FrontRelativeDamping = 350,
		RearHeight = 5,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 350,
		TurnSpeed = 3,
		MaxGrip = 150,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 40,
		BulletProofTires = false,
		IdleRPM = 0,
		LimitRPM = 0,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(0, 0, 0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 0,
		EngineSoundPreset = -1,
		snd_pitch = 1,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 1,
		snd_horn = "common/null.wav",
		DifferentialGear = 0,
		Gears = {-1, 0, 1}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_tanker_trailer", V)

local light_table = {
	-- projected texture - rear
	L_RearLampPos = Vector(-175.6, 34.6, 57.6),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-175.6, -34.6, 57.6),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(228, 51, 96),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(45, 51, 96),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-161, 51, 96),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(228, -51, 96),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(45, -51, 96),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-161, -51, 96),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(140, 41, 57),
			size = 100,
		},
		{
			pos = Vector(140, -41, 57),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-172, 5.5, 140.4),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-172, -5.6, 140.4),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-175.6, 34.6, 57.6),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-175.6, -34.6, 57.6),
			size = 50,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-172, 0.3, 140.3),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-175.6, 28.6, 57.6),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-175.6, -28.6, 57.6),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-175.6, 40, 57.6),
				size = 50,
				color = Color(255, 135, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(-175.6, -40, 57.6),
				size = 50,
				color = Color(255, 135, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[2] = "",
			},
			Brake = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}

list.Set("simfphys_lights", "tanker_trailer", light_table)

local V2 = {
	Name = "Tanker Trailer",
	Model = "models/left4dead/vehicles/tankertrailer2.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1400.0,
		NAKTankerHB = {
			Tank = {
				OBBMax = Vector(270, 50, 50),
				OBBMin = Vector(-180, -50, -40),
			},
		},
		EnginePos = Vector(0, 0, 0),
		LightsTable = "tankerdestruction_trailer",
		IsTrailer = true,
		Flammable = true,
		NoDriverSeat = true,
		OnSpawn = function(ent)
			ent:Lock()
			ent.supportphys = ents.Create("prop_physics")
			ent.supportphys:SetModel("models/props_phx/construct/metal_tube.mdl")
			ent.supportphys:SetPos(ent:LocalToWorld(Vector(90, 0, 0)))
			ent.supportphys:SetAngles(ent:GetAngles())
			ent.supportphys:SetNoDraw(true)
			ent.supportphys.DoNotDuplicate = true
			ent.supportphys:Spawn()
			constraint.Weld(ent, ent.supportphys, 0, 0, 0, true, true)
		end,
		Trailers = {
			inputPos = Vector(228, 0, 50),
			inputType = "axis",
		},
		OnTick = function(ent) end,
		OnDelete = function(ent)
			if IsValid(ent.supportphys) then
				ent.supportphys:Remove()
			end
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_tanker.mdl",
		CustomWheelPosFL = Vector(-140, 40, 25),
		CustomWheelPosFR = Vector(-140, -40, 25),
		CustomWheelPosRL = Vector(-200, 40, 25),
		CustomWheelPosRR = Vector(-200, -40, 25),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(50, 0, 10),
		CustomSteerAngle = 60,
		SeatOffset = Vector(0, 0, 0),
		SeatPitch = 0,
		SeatYaw = 90,
		FrontHeight = 5,
		FrontConstant = 50000,
		FrontDamping = 2000,
		FrontRelativeDamping = 350,
		RearHeight = 5,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 350,
		NoEngine = true,
		TurnSpeed = 3,
		MaxGrip = 150,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 40,
		BulletProofTires = false,
		IdleRPM = 0,
		LimitRPM = 0,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(0, 0, 0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 0,
		EngineSoundPreset = -1,
		snd_pitch = 1,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 1,
		snd_horn = "common/null.wav",
		DifferentialGear = 0,
		Gears = {-1, 0, 1}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_tankerdestruction_trailer", V2)

local light_table2 = {
	-- projected texture - rear
	L_RearLampPos = Vector(-232.5, 34.8, 57.2),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-232.5, -34.8, 57.2),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(233, 58.5, 90.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(22, 58.5, 90.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-212, 58.5, 90.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(233, -58.5, 90.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(22, -58.5, 90.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-212, -58.5, 90.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(140, 41, 57),
			size = 100,
		},
		{
			pos = Vector(140, -41, 57),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-232.5, 34.8, 57.2),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-232.5, -34.8, 57.2),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-232.5, 28.8, 57.2),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-232.5, -28.8, 57.2),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-232, 40.2, 57.2),
				size = 50,
				color = Color(255, 135, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(-232, -40.2, 57.2),
				size = 50,
				color = Color(255, 135, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[3] = "",
			},
			Brake = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "",
				[3] = "",
			},
			Brake_Reverse = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}

list.Set("simfphys_lights", "tankerdestruction_trailer", light_table2)