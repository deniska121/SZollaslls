--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_82hatchback.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "82 Hatchback",
	Model = "models/left4dead/vehicles/82hatchback.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1500,
		EnginePos = Vector(55.5, 0, 30),
		LightsTable = "82hatchback",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "civic") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel1.mdl",
		CustomWheelPosFL = Vector(55.5, 33, 12),
		CustomWheelPosFR = Vector(55.5, -33, 12),
		CustomWheelPosRL = Vector(-53, 33, 13),
		CustomWheelPosRR = Vector(-53, -33, 13),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(10, 0, 2),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-4, -16, 45),
		SeatPitch = -4,
		SeatYaw = 90,
		ModelInfo = {
			Skin = 1,
		},
		PassengerSeats = {
			{
				pos = Vector(0, -16, 15),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-35, -16, 15),
				ang = Angle(0, -90, 10),
				nosound = true,
				noenter = true,
				noexit = true
			},
			{
				pos = Vector(-35, 16, 15),
				ang = Angle(0, -90, 10),
				nosound = true,
				noenter = true,
				noexit = true
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-79, 16, 10),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 8,
		Trunk = 18,
		FrontConstant = 24000,
		FrontDamping = 1000,
		FrontRelativeDamping = 800,
		RearHeight = 8,
		RearConstant = 24000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 700,
		LimitRPM = 4500,
		PeakTorque = 90,
		PowerbandStart = 1200,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-50, -40, 36),
		FuelType = 1,
		FuelTankSize = 80,
		PowerBias = 1,
		LPMountFront = Vector(83.8, 0, 14.7),
		LPMountRear = Vector(-81.4, 0, 31),
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/hatch_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/hatch_low.wav",
		Sound_MidPitch = 1.25,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/hatch_high.wav",
		Sound_HighPitch = 0.65,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/hatch_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		snd_horn = "left4dead/vehicles/hatch_horn.wav",
		DifferentialGear = 0.27,
		Gears = {-0.18, 0, 0.13, 0.32, 0.5, 0.85, 1.1}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_82hatchback", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(81, 30, 29),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(81, -30, 29),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-79, 31.5, 28.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-79, -31.5, 28.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(82, 30, 29),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(82, -30, 29),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam, adjusted to fix lowbeam position
	Headlamp_sprites = {
		{
			pos = Vector(81, 30, 29),
			size = 100,
		},
		{
			pos = Vector(81, -30, 29),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-79, 33, 28.5),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-79, -33, 28.5),
			size = 70,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-79, 25, 34),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-79, -25, 34),
			size = 60,
			color = Color(255, 0, 0, 150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-79, 25, 28.5),
			size = 40,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-79, -25, 28.5),
			size = 40,
			color = Color(255, 255, 255, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(86.5, 29, 21),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(74, 37, 29),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-79, 33, 33),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(86.5, -29, 21),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(74, -37, 29),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-79, -33, 33),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[6] = "",
				[7] = ""
			},
			Brake = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		turnsignals = {
			left = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "82hatchback", light_table)

local V2 = {
	Name = "94 Hatchback",
	Model = "models/noire/vehicles/94hatchback.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1300,
		EnginePos = Vector(55.5, 0, 30),
		LightsTable = "94hatchback",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "civic") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/nuke_car_wheel.mdl",
		CustomWheelPosFL = Vector(50.5, 33, 0),
		CustomWheelPosFR = Vector(50.5, -33, 0),
		CustomWheelPosRL = Vector(-55, 33, 4),
		CustomWheelPosRR = Vector(-55, -33, 4),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(10, 0, 2),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-9, -16, 39),
		SeatPitch = -4,
		SeatYaw = 90,
		ModelInfo = {
			Skin = 1,
		},
		PassengerSeats = {
			{
				pos = Vector(-3, -16, 7),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-39, -16, 7),
				ang = Angle(0, -90, 10),
				nosound = true,
				noenter = true,
				noexit = true
			},
			{
				pos = Vector(-39, 16, 7),
				ang = Angle(0, -90, 10),
				nosound = true,
				noenter = true,
				noexit = true
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-83, -15.65, 3.46),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 8,
		Trunk = 18,
		FrontConstant = 24000,
		FrontDamping = 1000,
		FrontRelativeDamping = 800,
		RearHeight = 8,
		RearConstant = 24000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 43,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 27,
		IdleRPM = 700,
		LimitRPM = 4500,
		PeakTorque = 100,
		PowerbandStart = 1200,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-33.66,36.71,21.22),
		FuelType = 1,
		FuelTankSize = 80,
		PowerBias = -1,
		LPMountRear = Vector(-81.4, 0, 25),
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/hatch_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/hatch_low.wav",
		Sound_MidPitch = 1.25,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/hatch_high.wav",
		Sound_HighPitch = 0.65,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/hatch_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		snd_horn = "left4dead/vehicles/hatch_horn.wav",
		DifferentialGear = 0.27,
		Gears = {-0.18, 0, 0.13, 0.32, 0.5, 0.85, 1.1}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_94hatchback", V2)

local light_table2 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(80.59,21.15,15.81),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(80.59,-21.15,15.81),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-81.53,26.02,26.63),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-81.53,-26.02,26.63),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(79.59,21.15,15.81),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(79.59,-21.15,15.81),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam, adjusted to fix lowbeam position
	Headlamp_sprites = {
		{
			pos = Vector(79.59,21.15,15.81),
			size = 100,
		},
		{
			pos = Vector(79.59,-21.15,15.81),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-80.53,26.02,26.63),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-80.53,-26.02,26.63),
			size = 70,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-80.53,26.02,26.63),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-80.53,-26.02,26.63),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-81.83,0,33.12),
			size = 30,
			color = Color(255, 0, 0, 150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-81.26,26.29,23.34),
			size = 40,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-81.26,-26.29,23.34),
			size = 40,
			color = Color(255, 255, 255, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-79.04,31.92,23.21),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(76.85,30.71,15.76),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(-79.04,-31.92,23.21),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(76.85,-30.71,15.76),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[7] = "", --b2
				[10] = "", --lb
				[11] = "", --b
				[12] = "" --r
			},
			Brake = {
				[7] = "models/drift_spirits/other/lights_on", --b2
				[10] = "", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "" --r
			},
			Reverse = {
				[7] = "", --b2
				[10] = "", --lb
				[11] = "", --b
				[12] = "models/drift_spirits/other/lights_on" --r
			},
			Brake_Reverse = {
				[7] = "models/drift_spirits/other/lights_on", --b2
				[10] = "", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "models/drift_spirits/other/lights_on" --r
			},
		},
		on_lowbeam = {
			Base = {
				[7] = "", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "" --r
			},
			Brake = {
				[7] = "models/drift_spirits/other/lights_on", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "" --r
			},
			Reverse = {
				[7] = "", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "models/drift_spirits/other/lights_on" --r
			},
			Brake_Reverse = {
				[7] = "models/drift_spirits/other/lights_on", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "models/drift_spirits/other/lights_on" --r
			},
		},
		on_highbeam = {
			Base = {
				[7] = "", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "" --r
			},
			Brake = {
				[7] = "models/drift_spirits/other/lights_on", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "" --r
			},
			Reverse = {
				[7] = "", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "models/drift_spirits/other/lights_on" --r
			},
			Brake_Reverse = {
				[7] = "models/drift_spirits/other/lights_on", --b2
				[10] = "models/drift_spirits/other/lights_on", --lb
				[11] = "models/drift_spirits/other/lights_on", --b
				[12] = "models/drift_spirits/other/lights_on" --r
			},
		},
		turnsignals = {
			left = {
				[9] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[8] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "94hatchback", light_table2)