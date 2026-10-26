--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/chaser.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_table = {
	ModernLights = false,
	L_HeadLampPos = Vector(-19.4827, 97.3282, 24.7169),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(19.4827, 97.3282, 24.7169),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-28.8688, -99.8057, 30.0598),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(28.8688, -99.8057, 30.0598),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-26.7196, 95.2278, 24.8189),
			size = 60,
			color = Color(255, 255, 230, 225)
		},
		{
			pos = Vector(26.7196, 95.2278, 24.8189),
			size = 60,
			color = Color(255, 255, 230, 225)
		},
		---
		{
			pos = Vector(-33.0154, 94.5212, 12.4155),
			size = 35,
			color = Color(255, 219, 139, 150),
			OnBodyGroups = {
				[1] = {0, 2}
			}
		},
		{
			pos = Vector(-31.0154, 96.0351, 12.2067),
			size = 35,
			color = Color(255, 219, 139, 150),
			OnBodyGroups = {
				[1] = {0, 2}
			}
		},
		{
			pos = Vector(-29.0154, 97.5444, 12.0639),
			size = 35,
			color = Color(255, 219, 139, 150),
			OnBodyGroups = {
				[1] = {0, 2}
			}
		},
		{
			pos = Vector(33.0154, 94.5212, 12.4155),
			size = 35,
			color = Color(255, 219, 139, 150),
			OnBodyGroups = {
				[1] = {0, 2}
			}
		},
		{
			pos = Vector(31.0154, 96.0351, 12.2067),
			size = 35,
			color = Color(255, 219, 139, 150),
			OnBodyGroups = {
				[1] = {0, 2}
			}
		},
		{
			pos = Vector(29.0154, 97.5444, 12.0639),
			size = 35,
			color = Color(255, 219, 139, 150),
			OnBodyGroups = {
				[1] = {0, 2}
			}
		},
		---
		{
			pos = Vector(27.2804, 100.764, 10.9273),
			size = 20,
			color = Color(255, 255, 230, 255),
			OnBodyGroups = {
				[1] = {4}
			}
		},
		{
			pos = Vector(-27.2804, 100.764, 10.9273),
			size = 20,
			color = Color(255, 255, 230, 255),
			OnBodyGroups = {
				[1] = {4}
			}
		},
		{
			pos = Vector(31.703, 99.5436, 11.5442),
			size = 20,
			color = Color(255, 255, 230, 255),
			OnBodyGroups = {
				[1] = {4}
			}
		},
		{
			pos = Vector(-31.703, 99.5436, 11.5442),
			size = 20,
			color = Color(255, 255, 230, 255),
			OnBodyGroups = {
				[1] = {4}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(-19.4827, 97.3282, 24.7169),
			size = 60,
			color = Color(255, 255, 220, 225)
		},
		{
			pos = Vector(19.4827, 97.3282, 24.7169),
			size = 60,
			color = Color(255, 255, 220, 225)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-23.6791, -100.893, 29.9595),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-28.8688, -99.8057, 30.0598),
			size = 50,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(23.6791, -100.893, 29.9595),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(28.8688, -99.8057, 30.0598),
			size = 50,
			color = Color(200, 0, 0, 200)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-23.6791, -100.893, 29.9595),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-28.8688, -99.8057, 30.0598),
			size = 50,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(23.6791, -100.893, 29.9595),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(28.8688, -99.8057, 30.0598),
			size = 50,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-1.0, -101.421, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(-2.0, -101.435, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(-3.0, -101.447, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(-4.0, -101.456, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(-5.0, -101.47, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(-6.0, -101.472, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(-7.0, -101.471, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(0.0, -101.409, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(1.0, -101.421, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(2.0, -101.435, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(3.0, -101.447, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(4.0, -101.456, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(5.0, -101.47, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(6.0, -101.472, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
		{
			pos = Vector(7.0, -101.471, 42.2233),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[6] = {0}
			}
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(20.5328, -100.822, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(21.5328, -100.653, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(22.5328, -100.498, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(23.5328, -100.338, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		---
		{
			pos = Vector(-20.5328, -100.822, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(-21.5328, -100.653, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(-22.5328, -100.498, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(-23.5328, -100.338, 33.1246),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-33.1491, 92.0851, 24.7196),
				size = 60,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(-24.5328, -100.166, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(-25.5328, -100.021, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(-26.5328, -99.8635, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(-27.5328, -99.6522, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(-28.5328, -99.2706, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(-29.5328, -98.7237, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
		},
		Right = {
			{
				pos = Vector(33.1491, 92.0851, 24.7196),
				size = 60,
				color = Color(255, 176, 46, 200)
			},
			---
			{
				pos = Vector(24.5328, -100.166, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(25.5328, -100.021, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(26.5328, -99.8635, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(27.5328, -99.6522, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(28.5328, -99.2706, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
			{
				pos = Vector(29.5328, -98.7237, 33.1246),
				size = 20,
				color = Color(255, 176, 46, 70)
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[2] = "", --hb
				[3] = "", --lb
				[8] = "", --b1
				[9] = "", --rv
				[14] = "", --b2
			},
			Brake = {
				[2] = "", --hb
				[3] = "", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "", --rv
				[14] = "models/drift_spirits/other/lights_on", --b2
			},
			Reverse = {
				[2] = "", --hb
				[3] = "", --lb
				[8] = "", --b1
				[9] = "models/drift_spirits/other/lights_on", --rv
				[14] = "", --b2
			},
			Brake_Reverse = {
				[2] = "", --hb
				[3] = "", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "models/drift_spirits/other/lights_on", --rv
				[14] = "models/drift_spirits/other/lights_on", --b2
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "", --rv
				[14] = "", --b2
			},
			Brake = {
				[2] = "", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "", --rv
				[14] = "models/drift_spirits/other/lights_on", --b2
			},
			Reverse = {
				[2] = "", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "models/drift_spirits/other/lights_on", --rv
				[14] = "", --b2
			},
			Brake_Reverse = {
				[2] = "", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "models/drift_spirits/other/lights_on", --rv
				[14] = "models/drift_spirits/other/lights_on", --b2
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/drift_spirits/other/lights_on", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "", --rv
				[14] = "", --b2
			},
			Brake = {
				[2] = "models/drift_spirits/other/lights_on", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "", --rv
				[14] = "models/drift_spirits/other/lights_on", --b2
			},
			Reverse = {
				[2] = "models/drift_spirits/other/lights_on", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "models/drift_spirits/other/lights_on", --rv
				[14] = "", --b2
			},
			Brake_Reverse = {
				[2] = "models/drift_spirits/other/lights_on", --hb
				[3] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b1
				[9] = "models/drift_spirits/other/lights_on", --rv
				[14] = "models/drift_spirits/other/lights_on", --b2
			},
		},
		turnsignals = {
			left = {
				[6] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[7] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "chaser_simfphys", light_table)

local V = {
	Name = "98 Toyota Chaser",
	Model = "models/vehicles/toyota/chaser.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 1355,
		EnginePos = Vector(0, 71.3827, 36.1886),
		LightsTable = "chaser_simfphys",
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
		LPMountRear = Vector(0, -100.47, 30.73),
		LPRotateRear = Angle(-10, 90, 0),
		CustomSuspensionTravel = 10,
		CustomWheelModel = "models/drift_spirits/toyota/wh_chaser.mdl",
		CustomWheelPosFL = Vector(-32.8871, 66.8538, 10.9261),
		CustomWheelPosFR = Vector(32.8871, 66.8538, 10.9261),
		CustomWheelPosRL = Vector(-32.8871, -56.3305, 10.9261),
		CustomWheelPosRR = Vector(32.8871, -56.3305, 10.9261),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		CustomMassCenter = Vector(0, 0, 0),
		ModelInfo = {
			Color = Color(255, 255, 255),
		},
		ExhaustPositions = {
			{
				pos = Vector(23.1794, -99.9749, 9.64834),
				ang = Angle(90, -60, 0),
				OnBodyGroups = {
					[3] = {0, 2}
				}
			},
			{
				pos = Vector(21.3726, -101.579, 11.3313),
				ang = Angle(90, -60, 0),
				OnBodyGroups = {
					[3] = {1}
				}
			},
			{
				pos = Vector(23.188, -103.333, 8.92664),
				ang = Angle(90, -60, 0),
				OnBodyGroups = {
					[3] = {3}
				}
			},
			{
				pos = Vector(-2.63445, -102.207, 10.1126),
				ang = Angle(90, -60, 0),
				OnBodyGroups = {
					[3] = {4}
				}
			},
			{
				pos = Vector(2.63445, -102.207, 10.1126),
				ang = Angle(90, -120, 0),
				OnBodyGroups = {
					[3] = {4}
				}
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(8, -18.3, 40),
		SeatPitch = -10,
		SeatYaw = 0,
		PassengerSeats = {
			{
				pos = Vector(16.3, 14.5, 12),
				ang = Angle(0, 0, 27)
			},
			{
				pos = Vector(16.3, -28, 12),
				ang = Angle(0, 0, 20)
			},
			{
				pos = Vector(-16.3, -28, 12),
				ang = Angle(0, 0, 20)
			}
		},
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 3500,
		ExitCheck = 80,
		FrontRelativeDamping = 3500,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 3500,
		RearRelativeDamping = 3500,
		TurnSpeed = 7,
		MaxGrip = 35,
		Efficiency = 1.2,
		GripOffset = -3,
		BrakePower = 45,
		IdleRPM = 900,
		LimitRPM = 8000,
		Revlimiter = true,
		PeakTorque = 113,
		PowerbandStart = 900,
		PowerbandEnd = 7000,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(-35.7978, -68.8831, 34.5943),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 70,
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_idle = "vehicles/sim_fphys_nfsmwcars/idle.wav",
		snd_pitch = 0.77,
		snd_low = "vehicles/sim_fphys_nfsmwcars/300/mid.wav",
		snd_low_revdown = "vehicles/sim_fphys_nfsmwcars/300/revdown.wav",
		snd_low_pitch = 0.77,
		snd_mid = "vehicles/sim_fphys_nfsmwcars/300/high.wav",
		snd_mid_gearup = "vehicles/sim_fphys_nfsmwcars/300/second.wav",
		snd_mid_geardown = "vehicles/sim_fphys_nfsmwcars/300/second.wav",
		snd_mid_pitch = 0.8,
		DifferentialGear = 0.45,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		Gears = {-0.1, 0, 0.15, 0.25, 0.35, 0.45, 0.55}
	}
}

list.Set("simfphys_vehicles", "chaser_simfphys", V)

local light_table2 = {
	ModernLights = false,
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(95.64, 30.91, 22.25),
	L_HeadLampAng = Angle(17, 0, 0),
	R_HeadLampPos = Vector(95.64, -30.91, 22.25),
	R_HeadLampAng = Angle(10, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-105, 20.71, 31.95),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-105, -20.71, 31.95),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(90,26.6,20.62),
			material = simfLightZ,
			size = 70,
			color = Color(235, 254, 255),
		},
		{
			pos = Vector(90,-26.6,20.62),
			material = simfLightZ,
			size = 70,
			color = Color(235, 254, 255),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(92.07,23.2,20.13),
			size = 100,
			material = simfLightZ,
			color = Color(235, 254, 255),
		},
		{
			pos = Vector(92.07,-23.2,20.13),
			size = 100,
			material = simfLightZ,
			color = Color(235, 254, 255),
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-93.85,27.22,31.22),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-93.85,-27.22,31.22),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-97.17,19.99,31.16),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-97.17,-19.99,31.16),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-96.54,24.68,28.03),
			material = simfLightZ,
			size = 40,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-96.54,-24.68,28.03),
			material = simfLightZ,
			size = 40,
			color = Color(255, 255, 255, 255),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(84.26,32.84,20.57),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-94.14,28.9,27.71),
				material = simfLightZ,
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(84.26,-32.84,20.57),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-94.14,-28.9,27.71),
				material = simfLightZ,
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[1] = "", --hb
				[4] = "", --lb
				[8] = "", --b2
				[9] = "", --b1
				[10] = "", --rev
			},
			Brake = {
				[1] = "", --hb
				[4] = "", --lb
				[8] = "models/drift_spirits/other/lights_on", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "", --rev

			},
			Reverse = {
				[1] = "", --hb
				[4] = "", --lb
				[8] = "", --b2
				[9] = "", --b1
				[10] = "models/drift_spirits/other/lights_on", --rev

			},
			Brake_Reverse = {
				[1] = "", --hb
				[4] = "", --lb
				[8] = "models/drift_spirits/other/lights_on", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "models/drift_spirits/other/lights_on", --rev
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "", --rev
			},
			Brake = {
				[1] = "", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "", --rev

			},
			Reverse = {
				[1] = "", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "models/drift_spirits/other/lights_on", --rev

			},
			Brake_Reverse = {
				[1] = "", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "models/drift_spirits/other/lights_on", --rev
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/drift_spirits/other/lights_on", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "", --rev
			},
			Brake = {
				[1] = "models/drift_spirits/other/lights_on", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "", --rev

			},
			Reverse = {
				[1] = "models/drift_spirits/other/lights_on", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "models/drift_spirits/other/lights_on", --rev

			},
			Brake_Reverse = {
				[1] = "models/drift_spirits/other/lights_on", --hb
				[4] = "models/drift_spirits/other/lights_on", --lb
				[8] = "models/drift_spirits/other/lights_on", --b2
				[9] = "models/drift_spirits/other/lights_on", --b1
				[10] = "models/drift_spirits/other/lights_on", --rev
			},
		},
		turnsignals = {
			left = {
				[3] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[2] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "audi_a4", light_table2)

local V2 = {
	Name = "2004 Audi A4",
	Model = "models/vehicles/audi/red_hd_a4.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1600,
		EnginePos = Vector(77.5, 0, 25),
		LightsTable = "audi_a4",
		CustomWheels = true,
		--TrunkPos = function(obc, obmi, obmx) return Vector(obc.x, obmi.y, obc.z) end,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "audi_a4aa")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		CustomSuspensionTravel = 10,
		CustomWheelModel = "models/vehicles/audi/a4_wheel.mdl",
		CustomWheelPosFL = Vector(61.11, 32.1, 5),
		CustomWheelPosFR = Vector(61.11, -32.1, 5),
		CustomWheelPosRL = Vector(-58, 32.1, 5),
		CustomWheelPosRR = Vector(-58, -32.1, 5),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		LPMountRear = Vector(-98.1, 0, 26.5),
		LPRotateRear = Angle(-12, 0, 0),
		LPMountFront = Vector(103.5, 0, 11.06),
		PassengerSeats = {
			{
				pos = Vector(2, -16.5, 4),
				ang = Angle(0, -90, 12)
			},
			{
				pos = Vector(-32, 16.5, 5),
				ang = Angle(0, -90, 12),
			},
			{
				pos = Vector(-32, -16.5, 5),
				ang = Angle(0, -90, 12),
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-95.61, 21.49, 4.95),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-95.61, -21.49, 4.95),
				ang = Angle(90, 180, 0),
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(1, -16.5, 34),
		SeatPitch = -10,
		SeatYaw = 90,
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 3500,
		ExitCheck = 80,
		FrontRelativeDamping = 3500,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 3500,
		RearRelativeDamping = 3500,
		TurnSpeed = 7,
		MaxGrip = 33,
		Efficiency = 1.2,
		GripOffset = 0,
		BrakePower = 45,
		IdleRPM = 900,
		LimitRPM = 8000,
		Revlimiter = true,
		PeakTorque = 115,
		PowerbandStart = 900,
		PowerbandEnd = 7000,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(-71.87, -35.87, 29.72),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 70,
		PowerBias = 0,
		EngineSoundPreset = 10,
		DifferentialGear = 0.45,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		Gears = {-0.1, 0, 0.15, 0.25, 0.35, 0.45, 0.55}
	}
}

list.Set("simfphys_vehicles", "audi_a4", V2)