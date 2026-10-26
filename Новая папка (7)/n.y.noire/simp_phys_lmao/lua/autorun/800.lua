--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/800.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V2 = {
	Name = "2005 Porsche Cayman S",
	Model = "models/red_hd_caymans/caymans.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1385,
		TrunkPos = function(obc, obmi, obmx)
			return Vector(72.93,0,24.74)
		end,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountRear = Vector(-103,0,14),
		LPRotateRear = Angle(0,0,0),
		EnginePos = Vector(-82.46,0,20),
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		LightsTable = "cayman_simfphys",
		CustomWheels = true,
		Trunk = 15,
		CustomSuspensionTravel = 10,
		brokenglass = "wdamage",
		CustomWheelModel = "models/red_hd_caymans/red_hd_caymans_wheel.mdl",
		CustomWheelPosFL = Vector(45, 32.5, 8.5),
		CustomWheelPosFR = Vector(45, -32.5, 8.5),
		CustomWheelPosRL = Vector(-64, 34, 8.5),
		CustomWheelPosRR = Vector(-64, -34, 8.5),
		glassmats = {
			[13] = true,
			[14] = true,
			[15] = true,
			[16] = true,
		},
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		ExhaustPositions = {
			{
				pos = Vector(-100.64,2,5.95),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-100.64,-2,5.95),
				ang = Angle(90, 180, 0),
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(-16, -17.2, 36),
		SeatPitch = -10,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(-11, -17.2, 0),
				ang = Angle(0, -90, 22)
			}
		},
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 1000,
		FrontRelativeDamping = 1000,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 1000,
		RearRelativeDamping = 1000,
		TurnSpeed = 1.4,
		MaxGrip = 50,
		Efficiency = 1.2,
		GripOffset = -3,
		BrakePower = 35, -- сила торможения
		IdleRPM = 800, -- мин. кол-во оборотов
		LimitRPM = 8000, -- макс. кол-во оборотов
		Revlimiter = true, -- Если true - Когда стрелка спидометра доходит до красного обозначения, она не проходит дальше, если false - это игнорируется
		PeakTorque = 145, -- крутящий момент
		PowerbandStart = 900, -- какие обороты на нейтральной передаче
		PowerbandEnd = 7000, -- ограничение по оборотам
		Turbocharged = false, -- турбо false = нет, true = да
		Supercharged = false, -- супер заряд
		Backfire = true, -- стреляющий выхлоп
		FuelFillPos = Vector(36.13,-36,27.93), -- положение заправки
		FuelType = FUELTYPE_PETROL, -- тип топлива
		FuelTanksize = 64, -- размер бака
		PowerBias = 1, -- привод. 1 - задний, 0 - полный, -1 - передний
		EngineSoundPreset = -1,
		snd_pitch = 1,
		snd_idle = "vehicles/sim_fphys_por_cayman_s/idle.wav",
		snd_low = "vehicles/sim_fphys_nfsmwcars/s/mid.wav",
		snd_low_revdown = "vehicles/sim_fphys_nfsmwcars/s/revdown.wav", -- это всё звук
		snd_low_pitch = 0.7,
		snd_mid = "vehicles/sim_fphys_nfsmwcars/s/high.wav",
		snd_mid_gearup = "vehicles/sim_fphys_nfsmwcars/s/second.wav",
		snd_mid_geardown = "vehicles/sim_fphys_nfsmwcars/s/second.wav",
		snd_mid_pitch = 0.7,
		snd_backfire = "vehicles/sim_fphys_nfsmwcars/backfire.wav",
		start_del = -2,
		DifferentialGear = 0.4,
		Gears = {-0.2, 0, 0.2, 0.315, 0.43, 0.545, 0.66, 0.775}
	}
}
list.Set("simfphys_vehicles", "cayman_simfphys", V2)

local ring = Material("l4d/ringlight")

local light_table2 = {
	ModernLights = true,
	L_HeadLampPos = Vector(68.67,29.43,25.19),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(68.67,-29.43,25.19),
	R_HeadLampAng = Angle(0, 0, 0),
	L_RearLampPos = Vector(-90.14,28.14,26.03),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(-90.14,-28.14,26.03),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(62.67,29.43,24.19),
			size = 8,
			material = ring,
			color = Color(250, 250, 255, 255)
		},
		{
			pos = Vector(62.67,-29.43,24.19),
			size = 8,
			material = ring,
			color = Color(250, 250, 255, 255)
		},
		{
			pos = Vector(65.67,29.43,25.19),
			size = 35,
			color = Color(250, 250, 255, 255)
		},
		{
			pos = Vector(65.67,-29.43,25.19),
			size = 35,
			color = Color(250, 250, 255, 255)
		},
		{
			pos = Vector(83.69,24.99,11.15),
			size = 25,
			color = Color(250, 250, 255, 255)
		},
		{
			pos = Vector(83.69,-24.99,11.15),
			size = 25,
			color = Color(250, 250, 255, 255)
		},
	},
	FogLight_sprites = {
		{
			pos = Vector(83.69,24.99,11.15),
			size = 35,
			color = Color(250, 250, 255, 255)
		},
		{
			pos = Vector(83.69,-24.99,11.15),
			size = 35,
			color = Color(250, 250, 255, 255)
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(65.67,29.43,25.19),
			size = 55,
			color = Color(250, 250, 255, 255)
		},
		{
			pos = Vector(65.67,-29.43,25.19),
			size = 55,
			color = Color(250, 250, 255, 255)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-86.28,34.34,23.85),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-88.67,32.77,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-90.7,31.26,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-92.47,28.59,23.79),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-94.22,25.72,23.82),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-95.55,23.45,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		--
		{
			pos = Vector(-86.28,-34.34,23.85),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-88.67,-32.77,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-90.7,-31.26,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-92.47,-28.59,23.79),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-94.22,-25.72,23.82),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-95.55,-23.45,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-86.28,34.34,23.85),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-88.67,32.77,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-90.7,31.26,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-92.47,28.59,23.79),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-94.22,25.72,23.82),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-95.55,23.45,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		--
		{
			pos = Vector(-86.28,-34.34,23.85),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-88.67,-32.77,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-90.7,-31.26,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-92.47,-28.59,23.79),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-94.22,-25.72,23.82),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-95.55,-23.45,23.89),
			size = 40,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,6,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,7.26,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,-7.26,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,4,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,2,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,0,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,-6,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,-4,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
		{
			pos = Vector(-70.1,-2,35.1),
			size = 25,
			color = Color(170, 0, 0, 150)
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-90.6,26.34,26.61),
			size = 50,
			color = Color(255, 255, 255, 183),
		},
		{
			pos = Vector(-90.6,-26.34,26.61),
			size = 50,
			color = Color(255, 255, 255, 183),
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(72.9,24.03,21.24),
				size = 40,
				color = Color(248, 113, 22)
			},
			{
				pos = Vector(-85.03,33.75,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-87.41,32.16,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-89.65,29.36,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-86.27,32.87,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-88.66,30.92,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(60.64,37.04,18.59),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
		},
		Right = {
			{
				pos = Vector(72.9,-24.03,21.24),
				size = 40,
				color = Color(248, 113, 22)
			},
			{
				pos = Vector(-85.03,-33.75,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-87.41,-32.16,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-89.65,-29.36,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-86.27,-32.87,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(-88.66,-30.92,26),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			{
				pos = Vector(60.64,-37.04,18.59),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
		},
	},
}
list.Set("simfphys_lights", "cayman_simfphys", light_table2)