--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_motorhome.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Motorhome",
	Model = "models/left4dead/vehicles/motorhome01.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3000,
		EnginePos = Vector(-214, -32.6, 137.1),
		LightsTable = "motorhome",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheelf_motorhome.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheelr_motorhome.mdl",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "bus") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelPosFL = Vector(150.3, 48, 5),
		CustomWheelPosFR = Vector(148.3, -48, 5),
		CustomWheelPosRL = Vector(-85.6, 44, 5),
		CustomWheelPosRR = Vector(-85.6, -44, 5),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		LPMountFront = Vector(197, 0, 26),
		LPMountRear = Vector(-244.4, 0, 42.8),
		CustomMassCenter = Vector(0, 0, 35),
		CustomSteerAngle = 50,
		SeatOffset = Vector(125, -22, 97),
		SeatPitch = 10,
		SeatYaw = 90,
		Trunk = 0,
		PassengerSeats = {
			{
				pos = Vector(145, -22, 40),
				ang = Angle(0, -90, 0)
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-234, 42.8, 140.3),
				ang = Angle(60, 180, 0),
			},
		},
		ExitCheck = 70,
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 62,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 80,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		FuelFillPos = Vector(-76, 53, 53),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/bus_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/bus_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/bus_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/bus_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/bus_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		snd_bloweroff = "common/null.wav",
		DifferentialGear = 0.35,
		Gears = {-0.075, 0, 0.055, 0.125, 0.2, 0.275, 0.375}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_motorhome", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(194, 36, 37),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(194, -36, 37),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-244, 49, 49),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-244, -49, 49),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(194, 36, 37),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(194, -36, 37),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(167, 7.2, 132),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(167, 32.2, 132),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(167, -7.2, 132),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(167, -32.2, 132),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(166.5, 54, 39),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-66, 54, 39),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(166.5, -54, 39),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-66, -54, 39),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(194, 26, 37),
			size = 100,
		},
		{
			pos = Vector(194, -26, 37),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-244, 49, 49),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-244, -49, 49),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-242, 11.3, 126.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-242, -11.3, 126.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-246, 38.3, 29.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-246, -38.3, 29.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-244, 49, 49),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-244, -49, 49),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-244, 0, 62),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(197, 37, 25),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-244, 49, 55),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(197, -37, 25),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-244, -49, 55),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[8] = "",
				[6] = "",
				[5] = "",
			},
			Brake = {
				[4] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[5] = "",
			},
			Reverse = {
				[4] = "",
				[8] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
			},
			Brake_Reverse = {
				[4] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[5] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[5] = "",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "motorhome", light_table)