--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/ae86.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_table = {
	ModernLights = false,
	L_HeadLampPos = Vector(-21.5226, 86.1312, 29.8973),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(21.5226, 86.1312, 29.8973),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-23.8402, -86.8064, 31.059),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(23.8402, -86.8064, 31.059),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-21.5226, 86.1312, 29.8973),
			size = 70,
			material = simfLightZ,
			color = Color(255, 255, 230, 255)
		},
		---
		{
			pos = Vector(21.5226, 86.1312, 29.8973),
			size = 70,
			material = simfLightZ,
			color = Color(255, 255, 230, 255)
		},
		---
		{
			pos = Vector(-18.8929, 89.9416, 22.1188),
			size = 20,
			color = Color(255, 176, 46, 255),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(18.8929, 89.9416, 22.1188),
			size = 20,
			color = Color(255, 176, 46, 255),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		---
		{
			pos = Vector(-18.569, 89.716446, 22.3621),
			size = 20,
			color = Color(255, 176, 46, 255),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(18.569, 89.716446, 22.3621),
			size = 20,
			color = Color(255, 176, 46, 255),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		---
		{
			pos = Vector(-26.0856, 89.3834, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(-27.0856, 89.2939, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(-28.0856, 88.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(-28.9373, 87.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(-29.789, 86.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(-30.153, 85.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(-30.4717, 84.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(-30.7202, 83.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		---
		{
			pos = Vector(26.0856, 89.3834, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(27.0856, 89.2939, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(28.0856, 88.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(28.9373, 87.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(29.789, 86.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(30.153, 85.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(30.4717, 84.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		{
			pos = Vector(30.7202, 83.9671, 22.1188),
			size = 20,
			color = Color(255, 255, 230, 50),
			OnBodyGroups = {
				[1] = {1, 2}
			}
		},
		---
		{
			pos = Vector(-20.8112, 89.5787, 15.1538),
			size = 40,
			color = Color(255, 255, 0, 200),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(20.8112, 89.5787, 15.1538),
			size = 40,
			color = Color(255, 255, 0, 200),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		---
		{
			pos = Vector(22.341, 86.5612, 13.9248),
			size = 60,
			color = Color(255, 255, 230, 255),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-22.341, 86.5612, 13.9248),
			size = 60,
			color = Color(255, 255, 230, 255),
			OnBodyGroups = {
				[1] = {3}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(-21.5226, 86.1312, 29.8973),
			size = 30,
			material = simfLightZ,
			color = Color(255, 255, 230, 100)
		},
		---
		{
			pos = Vector(21.5226, 86.1312, 29.8973),
			size = 30,
			material = simfLightZ,
			color = Color(255, 255, 230, 100)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-23.8402, -86.8064, 31.059),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(23.8402, -86.8064, 31.059),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-23.8402, -86.8064, 31.059),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(23.8402, -86.8064, 31.059),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-14.7233, -87.6357, 31.059),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(14.7233, -87.6357, 31.059),
			size = 60,
			color = Color(200, 0, 0, 200)
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-19.9519, -87.3235, 30.2489),
			size = 30,
			color = Color(255, 255, 220, 150)
		},
		{
			pos = Vector(19.9519, -87.3235, 30.2489),
			size = 30,
			color = Color(255, 255, 220, 150)
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-28.124, -85.5805, 31.1151),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(-30.8634, 78.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(-30.9302, 79.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(-30.8151, 80.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(-30.3358, 81.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(-30.0417, 82.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(-29.7758, 83.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(-29.4148, 84.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(-28.8561, 85.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			---
			{
				pos = Vector(-19.569, 89.6652, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-20.569, 89.6047, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-21.569, 89.5376, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-22.569, 89.482, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-23.569, 89.4093, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-24.569, 89.317, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			---
			{
				pos = Vector(-20.0856, 89.8228, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(-21.0856, 89.7554, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(-22.0856, 89.6895, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(-23.0856, 89.6236, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(-24.0856, 89.5511, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(-25.0856, 89.4673, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
		},
		Right = {
			{
				pos = Vector(28.124, -85.5805, 31.1151),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(30.8634, 78.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(30.9302, 79.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(30.8151, 80.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(30.3358, 81.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(30.0417, 82.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(29.7758, 83.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(29.4148, 84.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			{
				pos = Vector(28.8561, 85.378, 27.8578),
				size = 20,
				color = Color(255, 176, 46, 125)
			},
			---
			{
				pos = Vector(19.569, 89.6652, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(20.569, 89.6047, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(21.569, 89.5376, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(22.569, 89.482, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(23.569, 89.4093, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(24.569, 89.317, 22.3621),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			---
			{
				pos = Vector(20.0856, 89.8228, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(21.0856, 89.7554, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(22.0856, 89.6895, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(23.0856, 89.6236, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(24.0856, 89.5511, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
			{
				pos = Vector(25.0856, 89.4673, 22.1188),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1, 2}
				}
			},
		},
	},
	DelayOn = 0.1,
	PoseParameters = {
		name = "headlights",
		min = 0,
		max = 1,
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "", -- low
				[5] = "", -- br 1
				[7] = "", -- br 2
				[8] = "", -- rev
			},
			Brake = {
				[4] = "", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "models/drift_spirits/other/lights_on", -- br 2
				[8] = "", -- rev
			},
			Reverse = {
				[4] = "", -- low
				[5] = "", -- br 1
				[7] = "", -- br 2
				[8] = "models/drift_spirits/other/lights_on", -- rev
			},
			Brake_Reverse = {
				[4] = "", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "models/drift_spirits/other/lights_on", -- br 2
				[8] = "", -- rev
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "", -- br 2
				[8] = "", -- rev
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "models/drift_spirits/other/lights_on", -- br 2
				[8] = "", -- rev
			},
			Reverse = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "", -- br 2
				[8] = "models/drift_spirits/other/lights_on", -- rev
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "models/drift_spirits/other/lights_on", -- br 2
				[8] = "models/drift_spirits/other/lights_on", -- rev
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "", -- br 2
				[8] = "", -- rev
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "models/drift_spirits/other/lights_on", -- br 2
				[8] = "", -- rev
			},
			Reverse = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "", -- br 2
				[8] = "models/drift_spirits/other/lights_on", -- rev
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", -- low
				[5] = "models/drift_spirits/other/lights_on", -- br 1
				[7] = "models/drift_spirits/other/lights_on", -- br 2
				[8] = "models/drift_spirits/other/lights_on", -- rev
			},
		},
		turnsignals = {
			left = {
				[6] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[9] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "ae86_simfphys", light_table)

local V = {
	Name = "83 Toyota Trueno",
	Model = "models/vehicles/toyota/ae86.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 800,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountRear = Vector(0,-87.69,29),
		LPRotateRear = Angle(0,90,0),
		EnginePos = Vector(0, 60.7239, 37.0885),
		LightsTable = "ae86_simfphys",
		CustomWheels = true,
		CustomSuspensionTravel = 2,
		CustomWheelModel = "models/drift_spirits/toyota/wh_ae86.mdl",
		CustomWheelPosFL = Vector(-31.601633, 55.268799, 17.0107),
		CustomWheelPosFR = Vector(31.601633, 55.268799, 17.0107),
		CustomWheelPosRL = Vector(-31.601633, -48.411339, 17.0107),
		CustomWheelPosRR = Vector(31.601633, -48.411339, 17.0107),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		CustomMassCenter = Vector(0, 0, 0),
		ModelInfo = {
			Color = Color(146, 146, 146),
		},
		ExhaustPositions = {
			{
				pos = Vector(-20.5426, -88.1508, 11.7941),
				ang = Angle(90, -90, 0),
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(1, -14.8, 40),
		SeatPitch = -10,
		SeatYaw = 0,
		TrunkPos = function(obc, obmi, obmx)
			return Vector(obc.x, obmi.y, obc.z)
		end,
		PassengerSeats = {
			{
				pos = Vector(14.5, 8, 12),
				ang = Angle(0, 0, 27)
			},
			{
				pos = Vector(-14.5, -35, 12),
				ang = Angle(0, 0, 17),
				nosound = true,
				noenter = true,
				noexit = true
			},
			{
				pos = Vector(14.5, -35, 12),
				ang = Angle(0, 0, 17),
				nosound = true,
				noenter = true,
				noexit = true
			}
		},
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 1500,
		FrontRelativeDamping = 1500,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 1500,
		RearRelativeDamping = 1500,
		TurnSpeed = 3,
		MaxGrip = 32,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 45,
		IdleRPM = 900,
		LimitRPM = 8000,
		Revlimiter = true,
		PeakTorque = 73,
		PowerbandStart = 1000,
		PowerbandEnd = 7500,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(32.2078, -66.7852, 29.3395),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 50,
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_idle = "vehicles/sim_fphys_nfsmwcars/evo/idle.wav",
		snd_pitch = 0.85,
		snd_low = "vehicles/sim_fphys_nfsmwcars/evo/mid.wav",
		snd_low_revdown = "vehicles/sim_fphys_nfsmwcars/evo/revdown.wav", -- это всё звук
		snd_low_pitch = 0.75,
		snd_mid = "vehicles/sim_fphys_nfsmwcars/evo/high.wav",
		snd_mid_gearup = "vehicles/sim_fphys_nfsmwcars/evo/second.wav",
		snd_mid_geardown = "vehicles/sim_fphys_nfsmwcars/evo/second.wav",
		snd_mid_pitch = 0.75,
		snd_blowoff = "vehicles/sim_fphys_nfsmwcars/blowoff1.wav",
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		DifferentialGear = 0.35,
		Gears = {-0.1, 0, 0.15, 0.25, 0.35, 0.45, 0.55}
	}
}
list.Set("simfphys_vehicles", "ae86_simfphys", V)

local light_table3 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(98.18,26.4,21.33),
	L_HeadLampAng = Angle(17, 0, 0),
	R_HeadLampPos = Vector(98.18,-26.4,21.33),
	R_HeadLampAng = Angle(10, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-89.85,24.97,27.94),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-89.85,-24.97,27.94),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(98.18,26.4,21.33),
			material = simfLightZ,
			size = 70,
			color = Color(234, 247, 255),
		},
		{
			pos = Vector(98.18,-26.4,21.33),
			material = simfLightZ,
			size = 70,
			color = Color(234, 247, 255),
		},
	}, -- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(101.44,19.54,21.6),
			size = 100,
			material = simfLightZ,
			color = Color(234, 247, 255),
		},
		{
			pos = Vector(101.44,-19.54,21.6),
			size = 100,
			material = simfLightZ,
			color = Color(234, 247, 255),
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-89.86,26.03,27.84),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-89.86,-26.03,27.84),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-89.86,26.03,27.84),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-89.86,-26.03,27.84),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-89.82,19.46,28.15),
			material = simfLightZ,
			size = 70,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-89.82,-19.46,28.15),
			material = simfLightZ,
			size = 70,
			color = Color(255, 0, 0, 255),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-89.53,20.04,30.44),
			material = simfLightZ,
			size = 40,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-89.53,-20.04,30.44),
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
				pos = Vector(94.04,31.85,20.95),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-87.81,28.39,32.72),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(94.04,-31.85,20.95),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-87.81,-28.39,32.72),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "", --b1
				[6] = "", --b2
				[12] = "", --lb
				[13] = "", --hb
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "models/drift_spirits/other/lights_on", --b2
				[12] = "", --lb
				[13] = "", --hb
			},
			Reverse = {
				[4] = "", --b1
				[6] = "", --b2
				[12] = "", --lb
				[13] = "", --hb
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "models/drift_spirits/other/lights_on", --b2
				[12] = "", --lb
				[13] = "", --hb
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "", --hb
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "models/drift_spirits/other/lights_on", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "", --hb
			},
			Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "", --hb
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "models/drift_spirits/other/lights_on", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "", --hb
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "models/drift_spirits/other/lights_on", --hb
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "models/drift_spirits/other/lights_on", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "models/drift_spirits/other/lights_on", --hb
			},
			Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "models/drift_spirits/other/lights_on", --hb
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[6] = "models/drift_spirits/other/lights_on", --b2
				[12] = "models/drift_spirits/other/lights_on", --lb
				[13] = "models/drift_spirits/other/lights_on", --hb
			},
		},
		turnsignals = {
			left = {
				[5] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[7] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}
list.Set("simfphys_lights", "bmw_m3", light_table3)

local Vn = {
	Name = "2002 BMW M3",
	Model = "models/vehicles/bmw/bmw_m3.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1950,
		EnginePos = Vector(82.25,0,27),
		LightsTable = "bmw_m3",
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		CustomWheelModel = "models/vehicles/bmw/m3_wheel.mdl",
		CustomWheelPosFL = Vector(72, 33.7, 6),
		CustomWheelPosFR = Vector(72, -33.7, 6),
		CustomWheelPosRL = Vector(-50, 33.7, 6),
		CustomWheelPosRR = Vector(-50, -33.7, 6),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 40,
		Trunk = 30,
		LPMountRear = Vector(-89.7,0,29),
		LPRotateRear = Angle(-12, 0, 0),
		SeatOffset = Vector(0, -18, 39),
		SeatPitch = -5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(7, -17, 7),
				ang = Angle(0, -90, 22)
			},
			{
				pos = Vector(-32, 15, 7),
				ang = Angle(0, -90, 12),
				nosound = true,
				noenter = true,
				noexit = true
			},
			{
				pos = Vector(-33, -15, 7),
				ang = Angle(0, -90, 12),
				nosound = true,
				noenter = true,
				noexit = true
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-88.46,-12.62,7.62),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-88.46,12.62,7.62),
				ang = Angle(90, 180, 0),
			},
		},
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 4000,
		FrontRelativeDamping = 4000,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 3500,
		RearRelativeDamping = 3500,
		TurnSpeed = 12,
		MaxGrip = 53,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 50,
		IdleRPM = 600,
		LimitRPM = 7500,
		Revlimiter = false,
		PeakTorque = 200,
		PowerbandStart = 850,
		PowerbandEnd = 6500,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(-67.58,-35.62,27.49),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 62,
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_pitch = 1,
		snd_idle = "vehicles/sim_fphys_nfsmwcars/c6/idle.wav",
		snd_low = "vehicles/sim_fphys_nfsmwcars/c6/mid.wav",
		snd_low_revdown = "vehicles/sim_fphys_nfsmwcars/c6/revdown.wav", -- это всё звук
		snd_low_pitch = 0.65,
		snd_mid = "vehicles/sim_fphys_nfsmwcars/c6/high.wav",
		snd_mid_gearup = "vehicles/sim_fphys_nfsmwcars/c6/second.wav",
		snd_mid_geardown = "vehicles/sim_fphys_nfsmwcars/c6/second.wav",
		snd_mid_pitch = 0.65,
		snd_backfire = "vehicles/sim_fphys_nfsmwcars/backfire.wav",
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2, 0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.725, 0.850,}
	}
}
list.Set("simfphys_vehicles", "bmw_m3", Vn)