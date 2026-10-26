--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_suv_2001.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local a = Color(0,0,0,0)
local b = Color(255, 0, 0, 255)
local r = Color(255, 0, 0, 255)

local V = {
	Name = "2001 Blazer",
	Model = "models/left4dead/vehicles/suv_2001.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2650,
		EnginePos = Vector(104, 0, 47),
		LightsTable = "suv2001",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "pickup78") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		brokenglass = "pickup_trucks_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_78.mdl",
		CustomWheelPosFL = Vector(69, 36.8, 17),
		CustomWheelPosFR = Vector(69, -36.8, 17),
		CustomWheelPosRL = Vector(-66, 36.8, 17),
		CustomWheelPosRR = Vector(-66, -36.8, 17),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		Trunk = 70,
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-1, -22, 63),
		LPMountFront = Vector(108, 0, 26),
		LPRotateFront = Angle(10, 0, 0),
		LPMountRear = Vector(-119.5, -2.1, 25.6),
		LPRotateRear = Angle(10, 0, 0),
		SeatPitch = 0,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(6, -22, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(6, -5, 30),
				ang = Angle(0, -90, 10),
				exitcheck = 80
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-108, 25, 22),
				ang = Angle(140, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 50000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 50000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 150,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-38, -45, 39.5),
		FuelType = 2,
		FuelTankSize = 100,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/pickup78_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/pickup78_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/pickup78_high.wav",
		Sound_HighPitch = 1.4,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/pickup78_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		snd_start = "cars/engines/start_2.wav",
		start_del = 1,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/pickup78_horn.wav",
		DifferentialGear = 0.4,
		Gears = {-0.18, 0, 0.080, 0.13, 0.2, 0.35, 0.65, 0.75}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_suv_2001", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(105.5, 34.7, 43.5),
	L_HeadLampAng = Angle(15, 0, 0),
	R_HeadLampPos = Vector(105.5, -34.7, 43.5),
	R_HeadLampAng = Angle(8, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-116.2, 42.5, 39.7),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-116.2, -42.5, 39.7),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(105.5, 34.7, 43.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(105.5, -34.7, 43.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(105.5, -34.7, 43.5),
			size = 100,
		},
		{
			pos = Vector(105.5, 34.7, 43.5),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-116.2, 42.5, 39.7),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-116.2, -42.5, 39.7),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-116.2, 42.5, 39.7),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-116.2, -42.5, 39.7),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(105.5, 34.7, 37.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-116.2, 42.5, 41.7),
				size = 50,
				color = Color(255, 136, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(105.5, -34.7, 37.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-116.2, -42.5, 41.7),
				size = 50,
				color = Color(255, 136, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[4] = "",
			},
			Brake = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}

list.Set("simfphys_lights", "suv2001", light_table)

local V2 = {
	Name = "98 Cherokee",
	Model = "models/left4dead/vehicles/98cherokee.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3000,
		EnginePos = Vector(73.22, 0, 30),
		LightsTable = "98cherokee",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "pickup")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		brokenglass = "pickup_trucks_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_van.mdl",
		CustomWheelPosFL = Vector(62, 32.8, 17),
		CustomWheelPosFR = Vector(62, -32.8, 17),
		CustomWheelPosRL = Vector(-64, 32.8, 17),
		CustomWheelPosRR = Vector(-64, -32.8, 17),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		LPMountFront = Vector(94.25, 0, 31.33),
		LPMountRear = Vector(-100, 0, 42),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-12, -18, 60),
		SeatPitch = 5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(-6, -18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, -18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, 18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, 0, 30),
				ang = Angle(0, -90, 10)
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-90, 24.11, 25),
				ang = Angle(90, 180, 0),
			},
		},
		ExitCheck = 70,
		FrontHeight = 7,
		FrontConstant = 75000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 75000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		Trunk = 50,
		TurnSpeed = 3,
		MaxGrip = 74,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 6000,
		PeakTorque = 210,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-69.81, -38.73, 50.2),
		FuelType = 2,
		FuelTankSize = 150,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/pickup_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/pickup_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/pickup_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/pickup_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		snd_horn = "left4dead/vehicles/pickup_horn.wav",
		DifferentialGear = 0.4,
		Gears = {-0.14, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_cherokee", V2)

local lt = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(87, 28.57, 43.77),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(90, -28.57, 43.77),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-98, 34.45, 45.64),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-98, -34.45, 45.64),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(87, 28.57, 43.77),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(90, -28.57, 43.77),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(87, 28.57, 43.77),
			size = 100,
		},
		{
			pos = Vector(90, -28.57, 43.77),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-98, 34.45, 45.64),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-98, -34.45, 45.64),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-98, -34.45, 45.64),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-98, 34.45, 45.64),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-97, 35.11, 38.53),
				size = 50,
				color = Color(255, 17, 0, 150),
			},
			{
				pos = Vector(90, 28, 36.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(87, 34, 42.98),
				size = 50,
				color = Color(255, 208, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(-97, -35.11, 38.53),
				size = 50,
				color = Color(255, 17, 0, 150),
			},
			{
				pos = Vector(90, -28, 36.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(87, -34, 42.98),
				size = 50,
				color = Color(255, 208, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[6] = "",
			},
			Brake = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "98cherokee", lt)

local VP = {
	Name = "Полицейский внедорожник",
	Model = "models/left4dead/vehicles/cherokee_police.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3000,
		EnginePos = Vector(73.22, 0, 30),
		LightsTable = "cherokee_pol",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "pickup")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		brokenglass = "pickup_trucks_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_van.mdl",
		CustomWheelPosFL = Vector(62, 32.8, 17),
		CustomWheelPosFR = Vector(62, -32.8, 17),
		CustomWheelPosRL = Vector(-64, 32.8, 17),
		CustomWheelPosRR = Vector(-64, -32.8, 17),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-12, -18, 60),
		NoAlarmClose = true,
		SitChangeBlock = {
			[0] = true,
			[1] = true,
		},
		SeatPitch = 5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(-6, -18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, -18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, 18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, 0, 30),
				ang = Angle(0, -90, 10)
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-90, 24.11, 25),
				ang = Angle(90, 180, 0),
			},
		},
		ExitCheck = 70,
		FrontHeight = 7,
		FrontConstant = 75000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 75000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		Trunk = 50,
		TurnSpeed = 3,
		MaxGrip = 74,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 6000,
		PeakTorque = 210,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-69.81, -38.73, 50.2),
		FuelType = 2,
		FuelTankSize = 150,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/pickup_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/pickup_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/pickup_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/pickup_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		snd_horn = "simulated_vehicles/horn_2.wav",
		DifferentialGear = 0.4,
		Gears = {-0.14, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_cherokee_police", VP)

local lt2 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(87, 28.57, 43.77),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(90, -28.57, 43.77),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-98, 34.45, 45.64),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-98, -34.45, 45.64),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(87, 28.57, 43.77),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(90, -28.57, 43.77),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(87, 28.57, 43.77),
			size = 100,
		},
		{
			pos = Vector(90, -28.57, 43.77),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-98, 34.45, 45.64),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-98, -34.45, 45.64),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-98, -34.45, 45.64),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-98, 34.45, 45.64),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-97, 35.11, 38.53),
				size = 50,
				color = Color(255, 17, 0, 150),
			},
			{
				pos = Vector(90, 28, 36.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(87, 34, 42.98),
				size = 50,
				color = Color(255, 208, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(-97, -35.11, 38.53),
				size = 50,
				color = Color(255, 17, 0, 150),
			},
			{
				pos = Vector(90, -28, 36.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(87, -34, 42.98),
				size = 50,
				color = Color(255, 208, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[6] = "",
			},
			Brake = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
	ems_sounds = {"left4dead/vehicles/vic_police_wail.wav", "left4dead/vehicles/vic_police_yelp.wav"},
	ems_codes = 3,
	ems_sprites = {
		{
			pos = Vector(-6, 7, 86.5),
			ucode = 2,
			size = 80,
			Colors = {r, a},
			Speed = 0.30
		},
		{
			pos = Vector(-6, -7, 86.5),
			size = 80,
			ucode = 2,
			Colors = {a, b},
			Speed = 0.30
		},
		{
			pos = Vector(-12.6, 21, 86.5),
			size = 80,
			Colors = {b, a, b, a, b, a, a, a, a, a, a, a,},
			Speed = 0.05
		},
		{
			pos = Vector(-12.6, -21, 86.5),
			size = 80,
			Colors = {a, a, a, a, a, a, r, a, r, a, r, a,},
			Speed = 0.05
		},
		{
			pos = Vector(-20.15, -25.8, 83),
			size = 40,
			Colors = {r, a, r, a, a, a, a, a,},
			Speed = 0.10
		},
		{
			pos = Vector(-20.15, 25.8, 83),
			size = 40,
			Colors = {a, a, a, a, r, a, r, a,},
			Speed = 0.10
		},
		{
			pos = Vector(-21.87, 3.15, 80.3),
			size = 40,
			Colors = {r, a, a, a,},
			Speed = 0.15
		},
		{
			pos = Vector(-21.87, 9, 82.3),
			size = 40,
			Colors = {a, r, a, a,},
			Speed = 0.15
		},
		{
			pos = Vector(-21.87, 15.5, 82.3),
			size = 40,
			Colors = {a, a, r, a,},
			Speed = 0.15
		},
		{
			pos = Vector(-21.87, 21.3, 82.3),
			size = 40,
			Colors = {a, a, a, r,},
			Speed = 0.15
		},
		{
			pos = Vector(-21.87, -3.15, 82.3),
			size = 40,
			Colors = {r, a, a, a,},
			Speed = 0.15
		},
		{
			pos = Vector(-21.87, -9, 82.3),
			size = 40,
			Colors = {a, r, a, a,},
			Speed = 0.15
		},
		{
			pos = Vector(-21.87, -15.5, 82.3),
			size = 40,
			Colors = {a, a, r, a,},
			Speed = 0.15
		},
		{
			pos = Vector(-21.87, -21.3, 82.3),
			size = 40,
			Colors = {a, a, a, r,},
			Speed = 0.15
		},
		{
			pos = Vector(-3, 0, 86.5),
			size = 80,
			ucode = 3,
			Colors = {color_white, a, color_white, a, a, a, a, a,},
			Speed = 0.05
		},
		{
			pos = Vector(98.23,14.72,42.59),
			size = 40,
			ucode = 2,
			Colors = {b, b, a, a, b, b, a, a, b, b, a, b, a, b, a, b, a, a, a, a, a, a, a, a,},
			Speed = 0.07
		},
		{
			pos = Vector(98.23,-14.72,42.59),
			size = 40,
			ucode = 2,
			Colors = {a, a, r, r, a, a, r, r, a, a, r, r, a, a, a, a, a, a, a, r, a, r, a, r,},
			Speed = 0.07
		},
		{
			pos = Vector(-98, -34.45, 45.64),
			size = 60,
			ucode = 3,
			Colors = {a, a, a, a, r, a, r},
			Speed = 0.1,
		},
		{
			pos = Vector(-98, 34.45, 45.64),
			size = 60,
			ucode = 3,
			Colors = {r, a, r, a, a, a, a},
			Speed = 0.1,
		},
		{
			pos = Vector(87, 28.57, 43.77),
			size = 70,
			ucode = 3,
			Colors = {a, a, a, a, color_white, a, color_white},
			Speed = 0.1
		},
		{
			pos = Vector(87, -28.57, 43.77),
			size = 70,
			ucode = 3,
			Colors = {a, a, a, a, color_white, a, color_white},
			Speed = 0.1
		},
	},
}

list.Set("simfphys_lights", "cherokee_pol", lt2)

local pl = table.Copy(lt)
local V3 = table.Copy(V2)
V3.Name = "98 Cherokee (Unmarked)"
V3.Category = "Гос департамент"
V3.Members.snd_horn = "simulated_vehicles/horn_2.wav"
V3.Members.LightsTable = "cherokeepl"
V3.Members.NoAlarmClose = true

pl.ems_sounds = {"left4dead/vehicles/pickup2004_police_wail.wav", "left4dead/vehicles/pickup2004_police_yelp.wav"}
pl.ems_sprites = {
	{
		pos = Vector(15.63,-17.27,74.4),
		size = 70,
		Colors = {b, a, b, a, a, a, a},
		Speed = 0.1
	},
	{
		pos = Vector(87, 28.57, 43.77),
		size = 70,
		Colors = {a, a, a, a, color_white, a, color_white},
		Speed = 0.1
	},
	{
		pos = Vector(87, -28.57, 43.77),
		size = 70,
		Colors = {a, a, a, a, color_white, a, color_white},
		Speed = 0.1
	},
	{
		pos = Vector(-98, -34.45, 45.64),
		size = 60,
		Colors = {a, a, a, a, r, a, r},
		Speed = 0.1,
	},
	{
		pos = Vector(-98, 34.45, 45.64),
		size = 60,
		Colors = {r, a, r, a, a, a, a},
		Speed = 0.1,
	},
}

V3.Members.Attachments = {
	{
		model = "models/cityrp/vic_light.mdl",
		pos = Vector(12, -17, 74.1),
		ang = Angle(185, 2, -4)
	},
}

list.Set("simfphys_lights", "cherokeepl", pl)
list.Set("simfphys_vehicles", "sim_cherokee_police_uc", V3)