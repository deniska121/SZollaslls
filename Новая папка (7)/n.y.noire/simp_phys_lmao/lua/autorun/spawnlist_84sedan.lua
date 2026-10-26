--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_84sedan.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "84 Fleetwood",
	Model = "models/left4dead/vehicles/84sedan.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2200,
		EnginePos = Vector(110, 0, 29),
		LightsTable = "84sedan",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "84sedan") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		LPMountFront = Vector(112.1, 0, 17),
		LPMountRear = Vector(-108.2, 0, 31),
		CustomWheelModel = "models/left4dead/vehicles/wheel3.mdl",
		CustomWheelPosFL = Vector(74.3, 33.8, 9),
		CustomWheelPosFR = Vector(74.3, -33.8, 9),
		CustomWheelPosRL = Vector(-59.5, 33.8, 9),
		CustomWheelPosRR = Vector(-59.5, -33.8, 9),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(4, -22, 48),
		SeatPitch = -4,
		SeatYaw = 90,
		ModelInfo = {
			Skin = 1,
		},
		PassengerSeats = {
			{
				pos = Vector(8, -22, 15),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(8, -5, 15),
				ang = Angle(0, -90, 10),
				exitcheck = 80
			},
			{
				pos = Vector(-31, 22, 15),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-31, -22, 15),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-31, 0, 15),
				ang = Angle(0, -90, 10),
				exitcheck = 80
			},
		},
		SitChangeBlock = {
			[0] = true,
			[1] = true,
			[2] = true,
		},
		ExhaustPositions = {
			{
				pos = Vector(-109.9, 18.8, 12),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 7,
		Trunk = 60,
		FrontConstant = 24000,
		FrontDamping = 2000,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 2000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 110,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-59.3, -41.5, 35.2),
		FuelType = 1,
		FuelTankSize = 100,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/sedan_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/sedan_low.wav",
		Sound_MidPitch = 1.25,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/sedan_high.wav",
		Sound_HighPitch = 0.65,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/sedan_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		DifferentialGear = 0.5,
		Gears = {-0.18, 0, 0.075, 0.15, 0.23, 0.37, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_84sedan", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(107.7, 34.3, 29.7),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(107.7, -34.3, 29.7),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-112, 37.1, 30.3),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-112, -37.1, 30.3),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(107.7, 34.3, 29.7),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(107.7, -34.3, 29.7),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(107.7, 27.1, 29.7),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(107.7, -27.1, 29.7),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(107.7, 27.1, 29.7),
			size = 100,
		},
		{
			pos = Vector(107.7, -27.1, 29.7),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-112, 37.1, 30.3),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-112, -37.1, 30.3),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-112, 37.1, 33.3),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-112, -37.1, 33.3),
			size = 60,
			color = Color(255, 0, 0, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(108, 29, 26.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(107.7, 37.4, 26.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(102.6, 40.5, 26.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-112, 36.8, 37.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(108, -29, 26.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(107.7, -37.4, 26.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(102.6, -40.5, 26.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-112, -36.8, 37.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
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
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "84sedan", light_table)