--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/fd3s.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_table = {
	ModernLights = true,
	L_HeadLampPos = Vector(-26.0071, 84.0643, 30.6069),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(26.0071, 84.0643, 30.6069),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-24.9948, -86.3041, 33.3497),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(24.9948, -86.3041, 33.3497),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-26.0071, 84.0643, 30.6069),
			size = 90,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
		{
			pos = Vector(26.0071, 84.0643, 30.6069),
			size = 90,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
		---
		{
			pos = Vector(-24.8937, 89.3841, 21.736),
			size = 25,
			color = Color(255, 255, 255)
		},
		{
			pos = Vector(24.8937, 89.3841, 21.736),
			size = 25,
			color = Color(255, 255, 255)
		},
		---
		{
			pos = Vector(-22.8297, 90.7216, 13.6776),
			size = 45,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {0}
			}
		},
		{
			pos = Vector(22.8297, 90.7216, 13.6776),
			size = 45,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {0}
			}
		},
		---
		{
			pos = Vector(-19.0716, 94.5992, 13.5692),
			size = 80,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(19.0716, 94.5992, 13.5692),
			size = 80,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		---
		{
			pos = Vector(-24.4096, 92.7204, 14.3401),
			size = 80,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {4}
			}
		},
		{
			pos = Vector(24.4096, 92.7204, 14.3401),
			size = 80,
			color = Color(255, 255, 255),
			OnBodyGroups = {
				[1] = {4}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(-26.0071, 84.0643, 30.6069),
			size = 25,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
		{
			pos = Vector(26.0071, 84.0643, 30.6069),
			size = 25,
			material = simfLightZ,
			color = Color(255, 255, 255)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-24.9948, -86.3041, 33.3497),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(24.9948, -86.3041, 33.3497),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-24.9948, -86.3041, 33.3497),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-20.1398, -87.7785, 33.3631),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(24.9948, -86.3041, 33.3497),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(20.1398, -87.7785, 33.3631),
			size = 30,
			color = Color(200, 0, 0, 200)
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-20.9, -92.6917, 22.0719),
			size = 25,
			color = Color(255, 255, 255, 150)
		},
		---
		{
			pos = Vector(20.9, -92.6917, 22.0719),
			size = 25,
			color = Color(255, 255, 255, 150)
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-28.9106, 88.6312, 22.1322),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-28.9106, 88.6312, 22.1322),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(-38.64, 39.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-38.6268, 38.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-38.616, 37.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-38.55, 36.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-38.5, 35.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(-29.5853, -84.6483, 33.0713),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(-29.5853, -84.6483, 33.0713),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
		},
		Right = {
			{
				pos = Vector(28.9106, 88.6312, 22.1322),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(28.9106, 88.6312, 22.1322),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(38.64, 39.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(38.6268, 38.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(38.616, 37.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(38.55, 36.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(38.5, 35.3378, 26.5161 - 0.1),
				size = 15,
				color = Color(255, 176, 46, 150)
			},
			---
			{
				pos = Vector(29.5853, -84.6483, 33.0713),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
			{
				pos = Vector(29.5853, -84.6483, 33.0713),
				size = 25,
				color = Color(255, 176, 46, 150)
			},
		},
	},
	DelayOn = 0.1,
	PoseParameters = {
		name = "vehicle_lights",
		min = 0,
		max = 1,
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[5] = "",
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on",
				[5] = "models/drift_spirits/other/lights_on",
			},
			Reverse = {
				[4] = "",
				[5] = "",
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on",
				[5] = "models/drift_spirits/other/lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "",
				[5] = "models/drift_spirits/other/lights_on",
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on",
				[5] = "models/drift_spirits/other/lights_on",
			},
			Reverse = {
				[4] = "",
				[5] = "models/drift_spirits/other/lights_on",
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on",
				[5] = "models/drift_spirits/other/lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "",
				[5] = "models/drift_spirits/other/lights_on",
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on",
				[5] = "models/drift_spirits/other/lights_on",
			},
			Reverse = {
				[4] = "",
				[5] = "models/drift_spirits/other/lights_on",
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on",
				[5] = "models/drift_spirits/other/lights_on",
			},
		},
		turnsignals = {
			left = {
				[7] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[6] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "fd3s_simfphys", light_table)

local V = {
	Name = "2001 Mazda RX-7",
	Model = "models/vehicles/mazda/rx7.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 1148,
		EnginePos = Vector(0, 58.021, 33.0713),
		LightsTable = "fd3s_simfphys",
		CustomWheels = true,
		TrunkPos = function(obc, obmi, obmx) return Vector(obc.x, obmi.y, obc.z) end,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountRear = Vector(0, -93, 19.96),
		LPRotateRear = Angle(10, 90, 0),
		CustomSuspensionTravel = 10,
		brokenglass = "vehicle_glass2",
		CustomWheelModel = "models/drift_spirits/mazda/wh_fd3s.mdl",
		CustomWheelPosFL = Vector(-34.4928, 59.5251, 15),
		CustomWheelPosFR = Vector(34.4928, 59.5251, 15),
		CustomWheelPosRL = Vector(-34.4928, -49.1846, 15),
		CustomWheelPosRR = Vector(34.4928, -49.1846, 15),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		CustomMassCenter = Vector(0, 0, 0),
		ModelInfo = {
			Color = Color(255, 255, 255),
		},
		ExhaustPositions = {
			{
				pos = Vector(20.9396, -89.0274, 13.2178),
				ang = Angle(90, -90, 0),
			},
			{
				pos = Vector(24.4246, -89.0274, 13.2178),
				ang = Angle(90, -90, 0),
			},
			{
				pos = Vector(23.4198, -90.2171, 11.7219),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {4}
				}
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(-10, -17, 41),
		SeatPitch = -10,
		SeatYaw = 0,
		PassengerSeats = {
			{
				pos = Vector(17.15, -3, 9.8),
				ang = Angle(0, 0, 27)
			}
		},
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 2500,
		FrontRelativeDamping = 2500,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 2500,
		RearRelativeDamping = 2500,
		TurnSpeed = 7,
		MaxGrip = 35,
		Efficiency = 1.2,
		GripOffset = -3,
		BrakePower = 45,
		IdleRPM = 900,
		LimitRPM = 9000,
		Revlimiter = true,
		PeakTorque = 103.5,
		PowerbandStart = 900,
		PowerbandEnd = 8000,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(-36.8043, -68.5009, 29.6004),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 76,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_idle = "vehicles/tdmcars/rx8/idle.wav",
		--snd_pitch = 0.8,
		snd_low = "vehicles/tdmcars/rx8/first.wav",
		snd_low_revdown = "vehicles/tdmcars/rx8/throttle_off.wav",
		--snd_low_pitch = 0.8,
		snd_mid = "vehicles/tdmcars/rx8/second.wav",
		snd_mid_gearup = "vehicles/tdmcars/rx8/third.wav",
		snd_mid_geardown = "vehicles/tdmcars/rx8/second.wav",
		snd_blowoff = "vehicles/sim_fphys_nfsmwcars/blowoff1.wav",
		--snd_mid_pitch = 0.8,
		DifferentialGear = 0.35,
		Gears = {-0.1, 0, 0.2, 0.3, 0.4, 0.5, 0.6}
	}
}

list.Set("simfphys_vehicles", "fd3s_simfphys", V)