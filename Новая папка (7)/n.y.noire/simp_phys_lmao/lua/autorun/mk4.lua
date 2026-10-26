--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/mk4.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_table = {
	ModernLights = false,
	L_HeadLampPos = Vector(-19.6269, 91.8387, 28.0001),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(19.6269, 91.8387, 28.0001),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-22.3954, -93.4435, 37.7488),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(22.3954, -93.4435, 37.7488),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-29.1572, 87.6874, 27.2597),
			size = 30,
			color = Color(255, 255, 230, 200)
		},
		---
		{
			pos = Vector(29.1572, 87.6874, 27.2597),
			size = 30,
			color = Color(255, 255, 230, 200)
		},
		---
		{
			pos = Vector(-29.7754, 92.2854, 20.0585),
			size = 20,
			color = Color(255, 255, 230, 175),
			OnBodyGroups = {
				[1] = {0}
			}
		},
		{
			pos = Vector(29.7754, 92.2854, 20.0585),
			size = 20,
			color = Color(255, 255, 230, 175),
			OnBodyGroups = {
				[1] = {0}
			}
		},
		---
		{
			pos = Vector(-29.7754 - 0.156, 92.2854 + 0.2014, 20.0585 - 0.0312),
			size = 20,
			color = Color(255, 255, 230, 175),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(29.7754 + 0.156, 92.2854 + 0.2014, 20.0585 - 0.0312),
			size = 20,
			color = Color(255, 255, 230, 175),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		---
		{
			pos = Vector(-28.8612, 95.1601, 22.3865),
			size = 25,
			color = Color(255, 255, 230, 125),
			OnBodyGroups = {
				[1] = {2}
			}
		},
		{
			pos = Vector(28.8612, 95.1601, 22.3865),
			size = 25,
			color = Color(255, 255, 230, 125),
			OnBodyGroups = {
				[1] = {2}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(-19.6269, 91.8387, 28.0001),
			size = 60,
			color = Color(255, 255, 230, 220)
		},
		{
			pos = Vector(19.6269, 91.8387, 28.0001),
			size = 60,
			color = Color(255, 255, 230, 220)
		},
		---
		{
			pos = Vector(-25.1445, 89.5895, 27.5479),
			size = 40,
			color = Color(255, 255, 230, 175)
		},
		{
			pos = Vector(25.1445, 89.5895, 27.5479),
			size = 40,
			color = Color(255, 255, 230, 175)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(22.3954, -93.4435, 37.7488),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-22.3954, -93.4435, 37.7488),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(22.3954, -93.4435, 37.7488),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(17.4913, -94.3732, 37.7488),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-22.3954, -93.4435, 37.7488),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-17.4913, -94.3732, 37.7488),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-6.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-5.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-4.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-3.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-2.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-1.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(0.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(1.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(2.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(3.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(4.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(5.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(6.0, -92.924, 43.8627),
			size = 15,
			color = Color(200, 0, 0, 200)
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-12.8267, -94.8546, 37.7488),
			size = 40,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(12.8267, -94.8546, 37.7488),
			size = 40,
			color = Color(255, 255, 230, 100)
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-28.4176, 92.9381, 20.0278),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(-27.4176, 93.4184, 19.946),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(-26.4176, 93.909, 19.8949),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(-25.4176, 94.3944, 19.8234),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(-24.4176, 94.9008, 19.8132),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			---
			{
				pos = Vector(-37.237, 79.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(-37.57, 78.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(-38.0377, 77.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(-38.4858, 76.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(-38.7046, 75.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			---
			{
				pos = Vector(-28.4176 - 0.156, 92.9381 + 0.2014, 20.0278 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(-27.4176 - 0.156, 93.4184 + 0.2014 - 0.5, 19.946 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(-26.4176 - 0.156, 93.909 + 0.2014 - 0.5, 19.8949 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(-25.4176 - 0.156, 94.3944 + 0.2014 - 0.5, 19.8234 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(-24.4176 - 0.156, 94.9008 + 0.2014 - 0.5, 19.8132 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			---
			{
				pos = Vector(-27.8612, 95.9272, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			{
				pos = Vector(-26.8612, 96.6401, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			{
				pos = Vector(-25.8612, 97.3207, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			{
				pos = Vector(-24.8612, 97.8645, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			---
			{
				pos = Vector(-37.237 - 0.0972, 79.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(-37.57 - 0.0972, 78.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(-38.0377 - 0.0972, 77.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(-38.4858 - 0.0972, 76.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(-38.7046 - 0.0972, 75.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			---
			{
				pos = Vector(-26.9359, -92.1664, 37.6995),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
		},
		Right = {
			{
				pos = Vector(28.4176, 92.9381, 20.0278),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(27.4176, 93.4184, 19.946),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(26.4176, 93.909, 19.8949),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(25.4176, 94.3944, 19.8234),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			{
				pos = Vector(24.4176, 94.9008, 19.8132),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			---
			{
				pos = Vector(37.237, 79.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(37.57, 78.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(38.0377, 77.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(38.4858, 76.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			{
				pos = Vector(38.7046, 75.5596, 21.489),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {0, 1, 2}
				}
			},
			---
			{
				pos = Vector(28.4176 + 0.156, 92.9381 + 0.2014, 20.0278 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(27.4176 + 0.156, 93.4184 + 0.2014 - 0.5, 19.946 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(26.4176 + 0.156, 93.909 + 0.2014 - 0.5, 19.8949 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(25.4176 + 0.156, 94.3944 + 0.2014 - 0.5, 19.8234 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			{
				pos = Vector(24.4176 + 0.156, 94.9008 + 0.2014 - 0.5, 19.8132 - 0.0312),
				size = 20,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			---
			{
				pos = Vector(27.8612, 95.9272, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 80),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			{
				pos = Vector(26.8612, 96.6401, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 80),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			{
				pos = Vector(25.8612, 97.3207, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 80),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			{
				pos = Vector(24.8612, 97.8645, 22.3865),
				size = 25,
				color = Color(255, 176, 46, 80),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			---
			{
				pos = Vector(37.237 + 0.0972, 79.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(37.57 + 0.0972, 78.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(38.0377 + 0.0972, 77.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(38.4858 + 0.0972, 76.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			{
				pos = Vector(38.7046 + 0.0972, 75.5596 - 0.6556, 21.489 + 0.6082),
				size = 15,
				color = Color(255, 176, 46, 125),
				OnBodyGroups = {
					[1] = {4}
				}
			},
			---
			{
				pos = Vector(26.9359, -92.1664, 37.6995),
				size = 40,
				color = Color(255, 176, 46, 255)
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[2] = "", -- b2
				[3] = "", -- b1
				[5] = "", -- rv
				[11] = "", -- lb
				[12] = "", -- hb
			},
			Brake = {
				[2] = "models/drift_spirits/other/lights_on", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "", -- rv
				[11] = "", -- lb
				[12] = "", -- hb
			},
			Reverse = {
				[2] = "", -- b2
				[3] = "", -- b1
				[5] = "models/drift_spirits/other/lights_on", -- rv
				[11] = "", -- lb
				[12] = "", -- hb
			},
			Brake_Reverse = {
				[2] = "models/drift_spirits/other/lights_on", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "models/drift_spirits/other/lights_on", -- rv
				[11] = "", -- lb
				[12] = "", -- hb
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "", -- hb
			},
			Brake = {
				[2] = "models/drift_spirits/other/lights_on", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "", -- hb
			},
			Reverse = {
				[2] = "", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "models/drift_spirits/other/lights_on", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "", -- hb
			},
			Brake_Reverse = {
				[2] = "models/drift_spirits/other/lights_on", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "models/drift_spirits/other/lights_on", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "", -- hb
			},
		},
		on_highbeam = {
			Base = {
				[2] = "", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "models/drift_spirits/other/lights_on", -- hb
			},
			Brake = {
				[2] = "models/drift_spirits/other/lights_on", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "models/drift_spirits/other/lights_on", -- hb
			},
			Reverse = {
				[2] = "", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "models/drift_spirits/other/lights_on", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "models/drift_spirits/other/lights_on", -- hb
			},
			Brake_Reverse = {
				[2] = "models/drift_spirits/other/lights_on", -- b2
				[3] = "models/drift_spirits/other/lights_on", -- b1
				[5] = "models/drift_spirits/other/lights_on", -- rv
				[11] = "models/drift_spirits/other/lights_on", -- lb
				[12] = "models/drift_spirits/other/lights_on", -- hb
			},
		},
		turnsignals = {
			left = {
				[4] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[6] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "mk4_simfphys", light_table)

local V = {
	Name = "93 Toyota Supra",
	Model = "models/vehicles/toyota/mk4.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 1374,
		EnginePos = Vector(0, 65.7511, 38.8449),
		LightsTable = "mk4_simfphys",
		CustomWheels = true,
		CustomSuspensionTravel = 10,
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
		CustomWheelModel = "models/drift_spirits/toyota/wh_mk4.mdl",
		CustomWheelPosFL = Vector(-33.5688, 57.898, 15.4582),
		CustomWheelPosFR = Vector(33.5688, 57.898, 15.4582),
		CustomWheelPosRL = Vector(-33.5688, -56.0569, 15.4582),
		CustomWheelPosRR = Vector(33.5688, -56.0569, 15.4582),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		CustomMassCenter = Vector(0, 0, 0),
		LPMountRear = Vector(0, -99.54, 27.72),
		LPRotateRear = Angle(0, 90, 0),
		ModelInfo = {
			Color = Color(255, 255, 255),
		},
		ExhaustPositions = {
			{
				pos = Vector(-23.7676, -96.6677, 15.0861),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[5] = {0, 1, 2, 4}
				}
			},
			{
				pos = Vector(-23.5752, -98.9567, 13.6852),
				ang = Angle(85, -110, 0),
				OnBodyGroups = {
					[5] = {3}
				}
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(-8, -16.1, 44),
		SeatPitch = -10,
		SeatYaw = 0,
		PassengerSeats = {
			{
				pos = Vector(14.5, -2, 12.7),
				ang = Angle(0, 0, 27)
			}
		},
		StrengthenSuspension = false,
		FrontHeight = 7,
		FrontConstant = 30000,
		FrontDamping = 3500,
		FrontRelativeDamping = 3500,
		RearHeight = 7,
		RearConstant = 30000,
		RearDamping = 3500,
		RearRelativeDamping = 3500,
		TurnSpeed = 7,
		MaxGrip = 42.5,
		Efficiency = 1.2,
		GripOffset = -3,
		BrakePower = 37.5,
		IdleRPM = 900,
		LimitRPM = 10000,
		Revlimiter = true,
		PeakTorque = 130,
		PowerbandStart = 900,
		PowerbandEnd = 9000,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(37.6621, -75.3307, 34.4225),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 70,
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_idle = "vehicles/tdmcars/supra/idle.wav",
		snd_pitch = 0.9,
		snd_low = "vehicles/tdmcars/supra/first.wav",
		snd_low_revdown = "vehicles/tdmcars/supra/throttle_off.wav",
		snd_low_pitch = 0.9,
		snd_mid = "vehicles/tdmcars/supra/second.wav",
		snd_mid_gearup = "vehicles/tdmcars/supra/third.wav",
		snd_mid_geardown = "vehicles/tdmcars/supra/second.wav",
		snd_mid_pitch = 0.9,
		snd_blowoff = "vehicles/sim_fphys_nfsmwcars/blowoff3.wav",
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		DifferentialGear = 0.35,
		Gears = {-0.1, 0, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65}
	}
}

list.Set("simfphys_vehicles", "mk4_simfphys", V)

--local ring = Material("l4d/ringlight")

local light_tablen = {
	ModernLights = false,
	L_HeadLampPos = Vector(-20.6537, 95.128, 28.7736),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(20.6537, 95.128, 28.7736),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-29.2078, -95.7229, 40.1249),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(29.2078, -95.7229, 40.1249),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-32.4587, 87.0295, 29.21),
			size = 60,
			color = Color(255, 247, 192, 200),
			OnBodyGroups = {
				[4] = {0, 2}
			}
		},
		{
			pos = Vector(32.4587, 87.0295, 29.21),
			size = 60,
			color = Color(255, 247, 192, 200),
			OnBodyGroups = {
				[4] = {0, 2}
			}
		},
		{
			pos = Vector(-27.423, 90.3486, 29.21),
			size = 60,
			color = Color(255, 247, 192, 200),
			OnBodyGroups = {
				[4] = {0, 2}
			}
		},
		{
			pos = Vector(27.423, 90.3486, 29.21),
			size = 60,
			color = Color(255, 247, 192, 200),
			OnBodyGroups = {
				[4] = {0, 2}
			}
		},
		{
			pos = Vector(-29.1029, 90.6221, 29.2644),
			size = 50,
			color = Color(255, 247, 192, 255),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(29.1029, 90.6221, 29.2644),
			size = 50,
			color = Color(255, 247, 192, 255),
			OnBodyGroups = {
				[4] = {1}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(20.6537, 95.128, 28.7736),
			size = 70,
			color = Color(255, 247, 192, 235),
			OnBodyGroups = {
				[4] = {0, 2}
			}
		},
		{
			pos = Vector(-20.6537, 95.128, 28.7736),
			size = 70,
			color = Color(255, 247, 192, 235),
			OnBodyGroups = {
				[4] = {0, 2}
			}
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(29.17,-96.09,36.9),
			size = 23,
			color = Color(170, 0, 0, 255)
		},
		{
			pos = Vector(-29.17,-96.09,36.9),
			size = 23,
			color = Color(170, 0, 0, 255)
		},
		{
			pos = Vector(-29.17,-96.09,36.9),
			size = 23,
			color = Color(170, 0, 0, 255)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(29.17,-96.09,36.9),
			size = 23,
			color = Color(170, 0, 0, 255)
		},
		{
			pos = Vector(-29.17,-96.09,36.9),
			size = 23,
			color = Color(170, 0, 0, 255)
		},
		{
			pos = Vector(-29.17,-96.09,36.9),
			size = 23,
			color = Color(170, 0, 0, 255)
		},
		{
			pos = Vector(-2.5,-97.87,41.09),
			size = 12,
			color = Color(255, 0, 0, 255)
		},
		{
			pos = Vector(0,-97.87,41.09),
			size = 12,
			color = Color(255, 0, 0, 255)
		},
		{
			pos = Vector(2.5,-97.87,41.09),
			size = 12,
			color = Color(255, 0, 0, 255)
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-11.54,-100.41,23),
			size = 40,
			color = Color(255, 255, 250, 255),
			OnBodyGroups = {
				[2] = {0, 1, 3}
			}
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-20.68, -98.1032, 35.8766),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(-37.3749, 39.2321, 31.5796),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(-28.1385, 95.0104, 20.2174),
				size = 35,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			---
			{
				pos = Vector(-28.5968, 95.3471, 20.9302),
				size = 25,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			---
			{
				pos = Vector(-28.2275, 93.7128, 20.4714),
				size = 15,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			---
			{
				pos = Vector(-28.7167, 95.5643, 20.8386),
				size = 25,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {3}
				}
			},
		},
		Right = {
			{
				pos = Vector(20.68, -98.1032, 35.8766),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(37.3749, 39.2321, 31.5796),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(28.1385, 95.0104, 20.2174),
				size = 35,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {0}
				}
			},
			---
			{
				pos = Vector(28.5968, 95.3471, 20.9302),
				size = 25,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {1}
				}
			},
			---
			{
				pos = Vector(28.2275, 93.7128, 20.4714),
				size = 15,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {2}
				}
			},
			---
			{
				pos = Vector(28.7167, 95.5643, 20.8386),
				size = 25,
				color = Color(255, 176, 46, 255),
				OnBodyGroups = {
					[1] = {3}
				}
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "", --b1
				[5] = "", --b2
				[21] = "", --lb
				[22] = "", --hb
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "models/drift_spirits/other/lights_on", --b2
				[21] = "", --lb
				[22] = "", --hb
			},
			Reverse = {
				[4] = "", --b1
				[5] = "", --b2
				[21] = "", --lb
				[22] = "", --hb
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "models/drift_spirits/other/lights_on", --b2
				[21] = "", --lb
				[22] = "", --hb
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "", --hb
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "models/drift_spirits/other/lights_on", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "", --hb
			},
			Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "", --hb
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "models/drift_spirits/other/lights_on", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "", --hb
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "models/drift_spirits/other/lights_on", --hb
			},
			Brake = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "models/drift_spirits/other/lights_on", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "models/drift_spirits/other/lights_on", --hb
			},
			Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "models/drift_spirits/other/lights_on", --hb
			},
			Brake_Reverse = {
				[4] = "models/drift_spirits/other/lights_on", --b1
				[5] = "models/drift_spirits/other/lights_on", --b2
				[21] = "models/drift_spirits/other/lights_on", --lb
				[22] = "models/drift_spirits/other/lights_on", --hb
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

list.Set("simfphys_lights", "r34_simfphys", light_tablen)

local Vn = {
	Name = "99 Nissan Skyline",
	Model = "models/vehicles/nissan/r34.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 1421,
		EnginePos = Vector(0, 67.5452, 38.8945),
		LightsTable = "r34_simfphys",
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		TrunkPos = function(obc, obmi, obmx) return Vector(obc.x, obmi.y, obc.z) end,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		LPMountRear = Vector(0,-100.78,21.09),
		LPRotateRear = Angle(0, 90, 0),
		CustomWheelModel = "models/drift_spirits/nissan/wh_r34.mdl",
		CustomWheelPosFL = Vector(-34.1796, 59.8548, 14.8513),
		CustomWheelPosFR = Vector(34.1796, 59.8548, 14.8513),
		CustomWheelPosRL = Vector(-34.1796, -58.9833, 14.8513),
		CustomWheelPosRR = Vector(34.1796, -58.9833, 14.8513),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		CustomMassCenter = Vector(0, 0, 0),
		ExhaustPositions = {
			{
				pos = Vector(-16.6672, -99.176, 11.7605),
				ang = Angle(90, -90, 0),
			},
			{
				pos = Vector(-20.9641, -99.176, 11.7605),
				ang = Angle(90, -90, 0),
			},
		},
		CustomSteerAngle = 40,
		Trunk = 40,
		SeatOffset = Vector(-2.7, 16.7, 42),
		SeatPitch = -10,
		SeatYaw = 0,
		PassengerSeats = {
			{
				pos = Vector(-17.7, 3, 9),
				ang = Angle(0, 0, 27)
			}
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
		MaxGrip = 40,
		Efficiency = 1,
		GripOffset = -3,
		BrakePower = 40,
		IdleRPM = 900,
		LimitRPM = 10000,
		Revlimiter = true,
		PeakTorque = 180,
		PowerbandStart = 900,
		PowerbandEnd = 8000,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(36.5847, -75.3857, 36.3788),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 65,
		PowerBias = 0,
		EngineSoundPreset = 9,
		DifferentialGear = 0.35,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		Gears = {-0.1, 0, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65},
	}
}

list.Set("simfphys_vehicles", "r34_simfphys", Vn)