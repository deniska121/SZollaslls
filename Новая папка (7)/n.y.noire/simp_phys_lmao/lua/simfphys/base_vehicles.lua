--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/simfphys/base_vehicles.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_table = {
	R_HeadLampPos = Vector(15.71, 0, 21.31), -- the location of the headlights (Right - R)
	R_HeadLampAng = Angle(180, 180, 0), -- the angle of the headlights
	R_RearLampPos = Vector(-45, 0, 5), -- the location of the rear lights
	R_RearLampAng = Angle(180, 0, 0), -- the angle of the rear lights
	Headlight_sprites = {
		{
			pos = Vector(15.71, -0.31, 21.31),
			size = 100,
			color = Color(255, 255, 255)
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(15.71, -0.31, 21.31),
			size = 100,
			color = Color(255, 255, 255)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-45, 0, 5),
			size = 100,
			color = Color(182, 66, 31)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-45, 0, 5),
			size = 100,
			color = Color(182, 66, 31)
		},
	},
	Reverselight_sprites = {},
	Turnsignal_sprites = {
		Right = {
			{
				pos = Vector(-44.23, -7.21, -5.4),
				size = 50,
				color = Color(182, 66, 31)
			},
		},
		Left = {
			{
				pos = Vector(-44.23, 7.21, -5.4),
				size = 50,
				color = Color(182, 66, 31)
			},
		},
	}
}

list.Set("simfphys_lights", "moped", light_table)

V = {
	Name = "Мопед доставщика",
	Model = "models/tiggomods/gta/vc/pizzaboybody.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnAngleOffset = 90,
	Members = {
		Mass = 700,
		LightsTable = "moped",
		CustomWheels = true,
		NoDoorSound = true,
		CustomSuspensionTravel = 5,
		CustomWheelModel = "models/tiggomods/gta/vc/pizzaboywf.mdl",
		CustomWheelModel_R = "models/tiggomods/gta/vc/pizzaboywb.mdl",
		OnSpawn = function(self)
			REN.L4D2SimfphysInit(self, "moto")
		end,
		LPMountRear = Vector(-45.1, 0, -0.27),
		LPRotateRear = Angle(-17, 0, 0),
		CustomGostsW = {
			[1] = true,
			[3] = true
		},
		CustomWheelPosFL = Vector(23, 0, -7),
		CustomWheelPosFR = Vector(23, -23, -7),
		CustomWheelPosRL = Vector(-30, 0, -7),
		CustomWheelPosRR = Vector(-30, -23, -7),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, -1, 0),
		CustomSteerAngle = 15,
		SeatOffset = Vector(-20, 0, 32),
		SeatPitch = 15,
		SeatYaw = 90,
		FrontHeight = 11,
		MotoHoldType = true,
		FrontConstant = 12000,
		FrontDamping = 900,
		FrontRelativeDamping = 30,
		RearHeight = 11,
		Trunk = 0,
		RearConstant = 12000,
		RearDamping = 900,
		RearRelativeDamping = 30,
		TurnSpeed = 8,
		MaxGrip = 90,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 5,
		BulletProofTires = true,
		IdleRPM = 600,
		LimitRPM = 4200,
		PeakTorque = 80,
		PowerbandStart = 650,
		PowerbandEnd = 700,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		FuelType = FUELTYPE_ELECTRIC,
		FuelTankSize = 80,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "tiggomods/gta/vc/bikes/faggio.wav",
		Sound_IdlePitch = 0.15,
		Sound_Mid = "left4dead/vehicles/apbag_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		Sound_High = "",
		Sound_Throttle = "",
		snd_horn = "left4dead/vehicles/apbag_horn.wav",
		DifferentialGear = 0.7,
		Gears = {-0.01, 0, 0.1, 0.2}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_moped_del", V)

V = {
	Name = "Мопед",
	Model = "models/tiggomods/gta/vc/faggiobody.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnAngleOffset = 90,
	Members = {
		Mass = 700,
		LightsTable = "moped",
		CustomWheels = true,
		NoDoorSound = true,
		OnSpawn = function(self)
			REN.L4D2SimfphysInit(self, "moto")
		end,
		LPMountRear = Vector(-47.5, 0, -0.27),
		LPRotateRear = Angle(-17, 0, 0),
		CustomSuspensionTravel = 5,
		CustomWheelModel = "models/tiggomods/gta/vc/pizzaboywf.mdl",
		CustomWheelModel_R = "models/tiggomods/gta/vc/pizzaboywb.mdl",
		CustomGostsW = {
			[1] = true,
			[3] = true
		},
		CustomWheelPosFL = Vector(20, 0, -7),
		CustomWheelPosFR = Vector(20, -23, -7),
		CustomWheelPosRL = Vector(-33, 0, -7),
		CustomWheelPosRR = Vector(-33, -23, -7),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, -1, 0),
		CustomSteerAngle = 15,
		PassengerSeats = {
			{
				pos = Vector(-33, 0, 5),
				ang = Angle(0, 90, 0)
			}
		},
		SeatOffset = Vector(-24, 0, 30),
		SeatPitch = 22,
		SeatYaw = 90,
		FrontHeight = 12,
		MotoHoldType = true,
		FrontConstant = 12000,
		FrontDamping = 900,
		FrontRelativeDamping = 30,
		RearHeight = 12,
		Trunk = 0,
		RearConstant = 12000,
		RearDamping = 900,
		RearRelativeDamping = 30,
		TurnSpeed = 8,
		MaxGrip = 90,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 5,
		BulletProofTires = true,
		IdleRPM = 600,
		LimitRPM = 4200,
		PeakTorque = 80,
		PowerbandStart = 650,
		PowerbandEnd = 700,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		FuelType = FUELTYPE_ELECTRIC,
		FuelTankSize = 80,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "tiggomods/gta/vc/bikes/faggio.wav",
		Sound_IdlePitch = 0.15,
		Sound_Mid = "left4dead/vehicles/apbag_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		Sound_High = "",
		Sound_Throttle = "",
		snd_horn = "left4dead/vehicles/apbag_horn.wav",
		DifferentialGear = 0.7,
		Gears = {-0.01, 0, 0.1, 0.2}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_moped", V)

light_table = {
	R_HeadLampPos = Vector(20, 0, 17.93), -- the location of the headlights (Right - R)
	R_HeadLampAng = Angle(180, 180, 0), -- the angle of the headlights
	R_RearLampPos = Vector(-57.1, 0, 7.34), -- the location of the rear lights
	R_RearLampAng = Angle(180, 0, 0), -- the angle of the rear lights
	Headlight_sprites = {
		{
			pos = Vector(20, 0, 17.93),
			size = 100,
			color = Color(255, 255, 255)
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(20, 0, 17.93),
			size = 100,
			color = Color(255, 255, 255)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-57.1, 0, 7.34),
			size = 100,
			color = Color(182, 66, 31)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-57.1, 0, 7.34),
			size = 100,
			color = Color(182, 66, 31)
		},
	},
	Reverselight_sprites = {},
	Turnsignal_sprites = {
		Right = {
			{
				pos = Vector(-52, -7, 5),
				size = 50,
				color = Color(182, 66, 31)
			},
		},
		Left = {
			{
				pos = Vector(-52, 7, 5),
				size = 50,
				color = Color(182, 66, 31)
			},
		},
	}
}

list.Set("simfphys_lights", "fleeway", light_table)

V = {
	Name = "Free Way",
	Model = "models/tiggomods/gta/vc/freewaybody.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnAngleOffset = 90,
	Members = {
		Mass = 700,
		LightsTable = "fleeway",
		CustomWheels = true,
		CustomSuspensionTravel = 5,
		NoDoorSound = true,
		CustomWheelModel = "models/tiggomods/gta/vc/freewaywf.mdl",
		CustomWheelModel_R = "models/tiggomods/gta/vc/freewaywb.mdl",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "moto")
		end,
		CustomGostsW = {
			[1] = true,
			[3] = true
		},
		Attachments = {
			{
				model = "models/tiggomods/gta/vc/freewayhandlebars.mdl",
				color = color_white,
				pos = Vector(13, 0, 20),
				ang = Angle(-22, 0, 0)
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-54, -7.79, -9),
				ang = Angle(-90, 0, 0)
			},
			{
				pos = Vector(-54, 7.79, -9),
				ang = Angle(-90, 0, 0)
			}
		},
		CustomWheelPosFL = Vector(26.5, 0, -7),
		CustomWheelPosFR = Vector(26.5, -23, -7),
		CustomWheelPosRL = Vector(-47, 0, -7),
		CustomWheelPosRR = Vector(-47, -23, -7),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 1, 0),
		LPMountRear = Vector(-60.4, 0, -0.27),
		LPRotateRear = Angle(-15, 0, 0),
		CustomSteerAngle = 35,
		SeatOffset = Vector(-28, 0, 31),
		SeatPitch = 5,
		SeatYaw = 90,
		Trunk = 0,
		FrontHeight = 10,
		FrontConstant = 12000,
		FrontDamping = 1000,
		FrontRelativeDamping = 12,
		RearHeight = 10,
		RearConstant = 12000,
		RearDamping = 1000,
		MotoHoldType = true,
		RearRelativeDamping = 15,
		TurnSpeed = 8,
		MaxGrip = 50,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 5,
		BulletProofTires = true,
		IdleRPM = 600,
		LimitRPM = 3500,
		PeakTorque = 130,
		PowerbandStart = 650,
		PowerbandEnd = 700,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		FuelType = FUELTYPE_ELECTRIC,
		FuelTankSize = 80,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "iggomods/gta/vc/bikes/freeway.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "tiggomods/gta/vc/bikes/freeway.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		Sound_High = "",
		Sound_Throttle = "",
		snd_horn = "left4dead/vehicles/apbag_horn.wav",
		DifferentialGear = 0.7,
		Gears = {-0.01, 0, 0.1, 0.2}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_freeway", V)

light_table = {
	R_HeadLampPos = Vector(20, 0, 15), -- the location of the headlights (Right - R)
	R_HeadLampAng = Angle(180, 180, 0), -- the angle of the headlights
	R_RearLampPos = Vector(-56, 0, 7.34), -- the location of the rear lights
	R_RearLampAng = Angle(180, 0, 0), -- the angle of the rear lights
	Headlight_sprites = {
		{
			pos = Vector(20, 0, 15),
			size = 100,
			color = Color(255, 255, 255)
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(20, 0, 15),
			size = 100,
			color = Color(255, 255, 255)
		},
		{
			pos = Vector(20, -5, 18),
			size = 35,
			color = Color(255, 255, 255)
		},
		{
			pos = Vector(20, 5, 18),
			size = 35,
			color = Color(255, 255, 255)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-56, 0, 7.34),
			size = 100,
			color = Color(182, 66, 31)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-56, 0, 7.34),
			size = 100,
			color = Color(182, 66, 31)
		},
	},
	Reverselight_sprites = {},
	Turnsignal_sprites = {
		Right = {
			{
				pos = Vector(-56, -7, 1),
				size = 50,
				color = Color(182, 66, 31)
			},
		},
		Left = {
			{
				pos = Vector(-56, 7, 1),
				size = 50,
				color = Color(182, 66, 31)
			},
		},
	}
}

list.Set("simfphys_lights", "angleway", light_table)

V = {
	Name = "Angel Body",
	Model = "models/tiggomods/gta/vc/angelbody.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnAngleOffset = 90,
	MotionController = true,
	Members = {
		Mass = 700,
		LightsTable = "angleway",
		CustomWheels = true,
		CustomSuspensionTravel = 5,
		NoDoorSound = true,
		CustomWheelModel = "models/tiggomods/gta/vc/angelwb.mdl",
		CustomWheelModel_R = "models/tiggomods/gta/vc/angelwf.mdl",
		OnSpawn = function(self)
			REN.L4D2SimfphysInit(self, "moto")
		end,
		LPMountRear = Vector(-59.1, 0, -0.27),
		LPRotateRear = Angle(-15, 0, 0),
		CustomGostsW = {
			[1] = true,
			[3] = true
		},
		Attachments = {
			{
				model = "models/tiggomods/gta/vc/angelhandlebars.mdl",
				color = color_white,
				pos = Vector(15, 0, 19.5),
				ang = Angle(-22, 0, 0)
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-54, -7.79, -9),
				ang = Angle(-90, 0, 0)
			},
			{
				pos = Vector(-54, 7.79, -9),
				ang = Angle(-90, 0, 0)
			}
		},
		CustomWheelPosFL = Vector(26.5, 0, -7),
		CustomWheelPosFR = Vector(26.5, -23, -7),
		CustomWheelPosRL = Vector(-47, 0, -7),
		CustomWheelPosRR = Vector(-47, -23, -7),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 1, 0),
		CustomSteerAngle = 35,
		SeatOffset = Vector(-26, 0, 30.5),
		SeatPitch = 5,
		SeatYaw = 90,
		Trunk = 0,
		FrontHeight = 10,
		FrontConstant = 12000,
		FrontDamping = 1000,
		FrontRelativeDamping = 12,
		RearHeight = 10,
		RearConstant = 12000,
		RearDamping = 1000,
		MotoHoldType = true,
		RearRelativeDamping = 15,
		TurnSpeed = 8,
		MaxGrip = 50,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 5,
		BulletProofTires = true,
		IdleRPM = 600,
		LimitRPM = 3500,
		PeakTorque = 130,
		PowerbandStart = 650,
		PowerbandEnd = 700,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		FuelType = FUELTYPE_ELECTRIC,
		FuelTankSize = 80,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "iggomods/gta/vc/bikes/freeway.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "tiggomods/gta/vc/bikes/freeway.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		Sound_High = "",
		Sound_Throttle = "",
		snd_horn = "left4dead/vehicles/apbag_horn.wav",
		DifferentialGear = 0.7,
		Gears = {-0.01, 0, 0.1, 0.2}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_angelbody", V)