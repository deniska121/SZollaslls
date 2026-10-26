--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/se3p.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_table = {
	ModernLights = true,
	L_HeadLampPos = Vector(-21.7437, 86.136, 28.8913),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(21.7437, 86.136, 28.8913),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-22.0375, -89.3217, 38.7336),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(22.0375, -89.3217, 38.7336),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-21.7437, 86.136, 28.8913),
			size = 20,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
		{
			pos = Vector(21.7437, 86.136, 28.8913),
			size = 20,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
		---
		{
			pos = Vector(-21.3096, 88.3148, 18.6777),
			size = 20,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {0}
			}
		},
		{
			pos = Vector(21.3096, 88.3148, 18.6777),
			size = 20,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {0}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(-28.4229, 81.0342, 30.373),
			size = 35,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
		{
			pos = Vector(28.4229, 81.0342, 30.373),
			size = 35,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-22.0375, -89.3217, 38.7336),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(22.0375, -89.3217, 38.7336),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-31.6487, -81.5755, 39.1477),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(31.6487, -81.5755, 39.1477),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-22.0375, -89.3217, 38.7336),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(22.0375, -89.3217, 38.7336),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-3.001599, -91.277, 44.3106),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-2.001599, -91.277, 44.3106),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-1.001599, -91.277, 44.3106),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(0.001599, -91.277, 44.3106),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(1.001599, -91.277, 44.3106),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(2.001599, -91.277, 44.3106),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(3.001599, -91.277, 44.3106),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-26.4367, -86.403, 38.8731),
			size = 25,
			color = Color(255, 255, 255, 150)
		},
		{
			pos = Vector(26.4367, -86.403, 38.8731),
			size = 25,
			color = Color(255, 255, 255, 150)
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-38.2068, 70.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-38.1257, 71.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-38.0435, 72.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-37.7473, 73.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-37.3177, 74.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-36.7534, 75.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-36.2206, 76.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(-31.9269, 77.1053, 31.1573),
				size = 40,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-31.9269, 77.1053, 31.1573),
				size = 40,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(-28.7986, -85.5033, 38.9156),
				size = 30,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-28.7986, -85.5033, 38.9156),
				size = 30,
				color = Color(255, 176, 46, 150)
			},
		},
		Right = {
			{
				pos = Vector(38.2068, 70.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(38.1257, 71.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(38.0435, 72.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(37.7473, 73.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(37.3177, 74.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(36.7534, 75.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(36.2206, 76.409, 28.5589),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(31.9269, 77.1053, 31.1573),
				size = 40,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(31.9269, 77.1053, 31.1573),
				size = 40,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(28.7986, -85.5033, 38.9156),
				size = 30,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(28.7986, -85.5033, 38.9156),
				size = 30,
				color = Color(255, 176, 46, 150)
			},
		},
	},
}

list.Set("simfphys_lights", "se3p_simfphys", light_table)

local V = {
	Name = "2003 Mazda RX-8",
	Model = "models/vehicles/mazda/rx8.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 1191,
		EnginePos = Vector(0, 66.0246, 39.2701),
		LightsTable = "se3p_simfphys",
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		CustomWheelModel = "models/drift_spirits/mazda/wh_se3p.mdl",
		CustomWheelPosFL = Vector(-32.9916, 60.2342, 16.5137),
		CustomWheelPosFR = Vector(32.9916, 60.2342, 16.5137),
		CustomWheelPosRL = Vector(-32.9916, -56.8043, 16.5137),
		CustomWheelPosRR = Vector(32.9916, -56.8043, 16.5137),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		TrunkPos = function(obc, obmi, obmx) return Vector(obc.x, obmi.y, obc.z) end,
		CustomMassCenter = Vector(0, 0, 0),
		ModelInfo = {
			Color = Color(255, 255, 255),
			Bodygroups = {0, 0, 0, 0, 0, 1, 0}
		},
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		LPMountRear = Vector(0, -94.94, 26.42),
		LPRotateRear = Angle(-10, 90, 0),
		ExhaustPositions = {
			{
				pos = Vector(-27.1057, -89.3912, 17.014),
				ang = Angle(90, -90, 0),
			},
			{
				pos = Vector(27.1057, -89.3912, 17.014),
				ang = Angle(90, -90, 0),
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(-6, -16.8, 45),
		SeatPitch = -10,
		SeatYaw = 0,
		PassengerSeats = {
			{
				pos = Vector(16.8, 0, 15),
				ang = Angle(0, 0, 27)
			},
			{
				pos = Vector(-16.8, -35, 15),
				ang = Angle(0, 0, 17),
				nosound = true,
				noenter = true,
				noexit = true
			},
			{
				pos = Vector(16.8, -35, 15),
				ang = Angle(0, 0, 17),
				nosound = true,
				noenter = true,
				noexit = true
			}
		},
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 3000,
		FrontRelativeDamping = 3000,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 3000,
		RearRelativeDamping = 3000,
		TurnSpeed = 7,
		MaxGrip = 35,
		Efficiency = 1.2,
		GripOffset = -3,
		BrakePower = 45,
		IdleRPM = 900,
		LimitRPM = 9000,
		Revlimiter = true,
		PeakTorque = 98,
		PowerbandStart = 900,
		PowerbandEnd = 8000,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(-34.2238, -56.8663, 41.2105),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 61,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_idle = "vehicles/tdmcars/rx8/idle.wav",
		snd_pitch = 0.8,
		snd_low = "vehicles/tdmcars/rx8/first.wav",
		snd_low_revdown = "vehicles/tdmcars/rx8/throttle_off.wav",
		snd_low_pitch = 0.8,
		snd_mid = "vehicles/tdmcars/rx8/second.wav",
		snd_mid_gearup = "vehicles/tdmcars/rx8/third.wav",
		snd_mid_geardown = "vehicles/tdmcars/rx8/second.wav",
		snd_blowoff = "vehicles/sim_fphys_nfsmwcars/blowoff1.wav",
		snd_mid_pitch = 0.8,
		DifferentialGear = 0.35,
		Gears = {-0.1, 0, 0.15, 0.25, 0.35, 0.45, 0.55}
	}
}

list.Set("simfphys_vehicles", "se3p_simfphys", V)