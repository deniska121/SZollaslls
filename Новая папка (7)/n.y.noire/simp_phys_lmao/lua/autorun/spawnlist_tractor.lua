--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_tractor.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Tractor (Small)",
	Model = "models/left4dead/vehicles/tractor.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-67.8, 0, 23),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 1200,
		EnginePos = Vector(44.5, -0.25, 95.5),
		LightsTable = "tractor",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "tractor") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheel_tractor_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_tractor_rear.mdl",
		CustomWheelPosFL = Vector(68, 7.3, 12),
		CustomWheelPosFR = Vector(68, -7.3, 12),
		Trunk = 0,
		CustomWheelPosRL = Vector(-50.3, 34.25, 30),
		CustomWheelPosRR = Vector(-50.3, -34.25, 30),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		FrontWheelRadius = 11.5,
		RearWheelRadius = 29,
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-72, 0, 77),
		SeatPitch = 15,
		SeatYaw = 90,
		ModelInfo = {
			Skin = 1,
		},
		ExhaustPositions = {
			{
				pos = Vector(44.5, -0.25, 95.5),
				ang = Angle(90, -90, 0),
			},
			{
				pos = Vector(44.5, -0.25, 95.5),
				ang = Angle(90, -90, 0),
			},
		},
		FrontHeight = 8,
		EnterDist = 6800,
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
		GripOffset = 1,
		BrakePower = 35,
		IdleRPM = 700,
		LimitRPM = 3500,
		PeakTorque = 25,
		PowerbandStart = 1200,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(18, 18, 36),
		FuelType = 1,
		FuelTankSize = 35,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/tractor_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/tractor_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1.5,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/tractor_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/tractor_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 1,
		--
		snd_horn = "left4dead/vehicles/racecar_horn.wav",
		DifferentialGear = 0.07,
		Gears = {-0.18, 0, 0.18, 0.32}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_tractor", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(-30, 30, 63),
	L_HeadLampAng = Angle(15, 0, 0),
	R_HeadLampPos = Vector(-30, -30, 63),
	R_HeadLampAng = Angle(8, 0, 0),
	Headlight_sprites = {
		{
			pos = Vector(-30, 30, 63),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(-30, -30, 63),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(-30, 25, 63),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(-30, -25, 63),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(-30, 25, 63),
			size = 100,
		},
		{
			pos = Vector(-30, -25, 63),
			size = 100,
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
			},
			Brake = {
				[1] = "",
			},
			Reverse = {
				[1] = "",
			},
			Brake_Reverse = {
				[1] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}

list.Set("simfphys_lights", "tractor", light_table)

local V2 = {
	Name = "Tractor",
	Model = "models/left4dead/vehicles/tractor01.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 4000,
		EnginePos = Vector(44.5, -0.25, 95.5),
		LightsTable = "tractor01",
		CustomWheels = true,
		Trunk = 0,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "tractor01") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheel_tractor01_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_tractor01_rear.mdl",
		CustomWheelPosFL = Vector(64, 49, 14),
		CustomWheelPosFR = Vector(64, -49, 14),
		CustomWheelPosRL = Vector(-96, 67, 35),
		CustomWheelPosRR = Vector(-96, -67, 35),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		FrontWheelRadius = 32,
		RearWheelRadius = 53,
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-110, 0, 115),
		SeatPitch = 15,
		SeatYaw = 90,
		ExhaustPositions = {
			{
				pos = Vector(-5.3, -50, 173.6),
				ang = Angle(90, -45, 0),
			},
			{
				pos = Vector(-5.3, -50, 173.6),
				ang = Angle(90, -45, 0),
			},
		},
		EnterDist = 51800,
		ExitCheck = 90,
		FrontHeight = 8,
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
		GripOffset = 1,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 3500,
		PeakTorque = 100,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(4.5, -25, 55.6),
		FuelType = 2,
		FuelTankSize = 135,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/tractor01_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/tractor01_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1.5,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/tractor01_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/tractor01_throttle.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 1,
		--
		snd_horn = "left4dead/vehicles/tractor01_horn.wav",
		DifferentialGear = 0.08,
		Gears = {-0.23, 0, 0.18, 0.35, 0.5}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_tractor01", V2)

local light_table2 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(115.7, 14, 72.6),
	L_HeadLampAng = Angle(15, 0, 0),
	R_HeadLampPos = Vector(115.7, -14, 72.6),
	R_HeadLampAng = Angle(8, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-129.3, 59, 110.6),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-129.3, -59, 110.6),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(115.7, 14, 72.6),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(115.7, -14, 72.6),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Rearlight_sprites = {
		{
			pos = Vector(-129.3, 59, 110.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-129.3, -59, 110.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-129.3, 53, 110.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-129.3, -53, 110.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		}
	},
	Headlamp_sprites = {
		{
			pos = Vector(115.7, 14, 72.6),
			size = 100,
		},
		{
			pos = Vector(115.7, -14, 72.6),
			size = 100,
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[2] = "",
			},
			Brake = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[2] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}

list.Set("simfphys_lights", "tractor01", light_table2)