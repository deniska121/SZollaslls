--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/aristo.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_table = {
	ModernLights = false,
	L_HeadLampPos = Vector(-19.8803, 94.3804, 27.0808),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(19.8803, 94.3804, 27.0808),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-22.3954, -93.4435, 37.7488),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(22.3954, -93.4435, 37.7488),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-29.6947, 89.4463, 27.3789),
			size = 90,
			color = Color(255, 255, 230)
		},
		{
			pos = Vector(29.6947, 89.4463, 27.3789),
			size = 90,
			color = Color(255, 255, 230)
		},
		---
		{
			pos = Vector(-32.8796, 95.5483, 14.3779),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		{
			pos = Vector(-30.8796, 96.6173, 14.3154),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		{
			pos = Vector(-28.8796, 97.3093, 14.1981),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		{
			pos = Vector(-26.8796, 98.0371, 14.1668),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		{
			pos = Vector(32.8796, 95.5483, 14.3779),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		{
			pos = Vector(30.8796, 96.6173, 14.3154),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		{
			pos = Vector(28.8796, 97.3093, 14.1981),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		{
			pos = Vector(26.8796, 98.0371, 14.1668),
			size = 35,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {0, 1}
			}
		},
		---
		{
			pos = Vector(-32.6, 94.0038, 15.7021),
			size = 30,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-30.6, 94.9725, 15.1906),
			size = 30,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-28.6, 95.7181, 14.7809),
			size = 40,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-26.6, 96.4702, 14.4491),
			size = 50,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(32.6, 94.0038, 15.7021),
			size = 30,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(30.6, 94.9725, 15.1906),
			size = 30,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(28.6, 95.7181, 14.7809),
			size = 40,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(26.6, 96.4702, 14.4491),
			size = 50,
			color = Color(255, 219, 139, 80),
			OnBodyGroups = {
				[1] = {3}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(-19.8803, 94.3804, 27.0808),
			size = 60,
			color = Color(255, 219, 139, 200)
		},
		{
			pos = Vector(19.8803, 94.3804, 27.0808),
			size = 60,
			color = Color(255, 219, 139, 200)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(28.2119, -97.2266, 32.6928),
			size = 70,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-28.2119, -97.2266, 32.6928),
			size = 70,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-17.5552, -99.4644, 31.9027),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(17.5552, -99.4644, 31.9027),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(28.2119, -97.2266, 32.6928),
			size = 70,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-28.2119, -97.2266, 32.6928),
			size = 70,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-17.5552, -99.4644, 31.9027),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(17.5552, -99.4644, 31.9027),
			size = 40,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-1.0, -99.131, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(-2.0, -99.1142, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(-3.0, -99.0934, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(-4.0, -99.0816, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(-5.0, -99.059, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(-6.0, -99.0385, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(0.0, -99.1464, 44.8388),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(1.0, -99.131, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(2.0, -99.1142, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(3.0, -99.0934, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(4.0, -99.0816, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(5.0, -99.059, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		{
			pos = Vector(6.0, -99.0385, 44.8627),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {0}
			}
		},
		---
		{
			pos = Vector(-1.0, -99.3172, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(-2.0, -99.2989, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(-3.0, -99.2827, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(-4.0, -99.2633, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(-5.0, -99.2465, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(-6.0, -99.226, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(0.0, -99.3324, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(1.0, -99.3172, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(2.0, -99.2989, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(3.0, -99.2827, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(4.0, -99.2633, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(5.0, -99.2465, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
		{
			pos = Vector(6.0, -99.226, 45.8778),
			size = 15,
			color = Color(200, 0, 0, 200),
			OnBodyGroups = {
				[4] = {1}
			}
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(23.5569, -98.9117, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(24.5569, -98.6953, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(25.5569, -98.4794, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(26.5569, -98.1088, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		---
		{
			pos = Vector(-23.5569, -98.9117, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(-24.5569, -98.6953, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(-25.5569, -98.4794, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
		{
			pos = Vector(-26.5569, -98.1088, 28.5417),
			size = 20,
			color = Color(255, 255, 220, 75)
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-26.0364, 94.3018, 25.5781),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(-38.6124, 48.3921, 23.2144),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(-27.5569, -97.7076, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(-28.5569, -97.3081, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(-29.5569, -96.9053, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(-30.5569, -96.5056, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(-31.5569, -95.731, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(-32.5569, -94.7962, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(-33.2824, -93.7962, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(-33.695, -92.7962, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
		},
		Right = {
			{
				pos = Vector(26.0364, 94.3018, 25.5781),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(38.6124, 48.3921, 23.2144),
				size = 25,
				color = Color(255, 176, 46, 255)
			},
			---
			{
				pos = Vector(27.5569, -97.7076, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(28.5569, -97.3081, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(29.5569, -96.9053, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(30.5569, -96.5056, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(31.5569, -95.731, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(32.5569, -94.7962, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(33.2824, -93.7962, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
			{
				pos = Vector(33.695, -92.7962, 28.5417),
				size = 25,
				color = Color(255, 176, 46, 80)
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[7] = "",
				[8] = "",
				[9] = "",
				[12] = "",
			},
			Brake = {
				[5] = "",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "",
				[9] = "",
				[12] = "models/drift_spirits/other/lights_on",
			},
			Reverse = {
				[5] = "",
				[7] = "",
				[8] = "models/drift_spirits/other/lights_on",
				[9] = "",
				[12] = "",
			},
			Brake_Reverse = {
				[5] = "",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "models/drift_spirits/other/lights_on",
				[9] = "",
				[12] = "models/drift_spirits/other/lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "",
				[9] = "",
				[12] = "",
			},
			Brake = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "",
				[9] = "",
				[12] = "models/drift_spirits/other/lights_on",
			},
			Reverse = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "models/drift_spirits/other/lights_on",
				[9] = "",
				[12] = "",
			},
			Brake_Reverse = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "models/drift_spirits/other/lights_on",
				[9] = "",
				[12] = "models/drift_spirits/other/lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "",
				[9] = "models/drift_spirits/other/lights_on",
				[12] = "",
			},
			Brake = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "",
				[9] = "models/drift_spirits/other/lights_on",
				[12] = "models/drift_spirits/other/lights_on",
			},
			Reverse = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "models/drift_spirits/other/lights_on",
				[9] = "models/drift_spirits/other/lights_on",
				[12] = "",
			},
			Brake_Reverse = {
				[5] = "models/drift_spirits/other/lights_on",
				[7] = "models/drift_spirits/other/lights_on",
				[8] = "models/drift_spirits/other/lights_on",
				[9] = "models/drift_spirits/other/lights_on",
				[12] = "models/drift_spirits/other/lights_on",
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

list.Set("simfphys_lights", "aristo_simfphys", light_table)

local V = {
	Name = "2000 Toyota Aristo",
	Model = "models/vehicles/toyota/aristo.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 1534,
		EnginePos = Vector(0, 71.744, 39.0081),
		LightsTable = "aristo_simfphys",
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
		LPMountRear = Vector(0, -101.06, 32),
		LPRotateRear = Angle(-10, 90, 0),
		CustomSuspensionTravel = 10,
		CustomWheelModel = "models/drift_spirits/toyota/wh_aristo.mdl",
		CustomWheelPosFL = Vector(-34.0799, 68.1143, 13.4785),
		CustomWheelPosFR = Vector(34.0799, 68.1143, 13.4785),
		CustomWheelPosRL = Vector(-34.0799, -53.0965, 13.4785),
		CustomWheelPosRR = Vector(34.0799, -53.0965, 13.4785),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		CustomMassCenter = Vector(0, 0, 0),
		ModelInfo = {
			Color = Color(255, 255, 255),
		},
		ExhaustPositions = {
			{
				pos = Vector(-25.9026, -100.225, 12.5058),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {0}
				}
			},
			{
				pos = Vector(25.9026, -100.225, 12.5058),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {0}
				}
			},
			{
				pos = Vector(-25.9191, -100.985, 12.5315),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {1, 2, 3, 4}
				}
			},
			{
				pos = Vector(25.9191, -100.985, 12.5315),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {1, 2, 3, 4}
				}
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(6, -19.6, 40),
		SeatPitch = -10,
		SeatYaw = 0,
		PassengerSeats = {
			{
				pos = Vector(19.6, 14, 11.4),
				ang = Angle(0, 0, 27)
			},
			{
				pos = Vector(-19.6, -25, 11.4),
				ang = Angle(0, 0, 27)
			},
			{
				pos = Vector(19.6, -25, 11.4),
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
		RearDamping = 4000,
		RearRelativeDamping = 4000,
		TurnSpeed = 7,
		MaxGrip = 50,
		Efficiency = 1.2,
		GripOffset = -3,
		BrakePower = 35,
		IdleRPM = 900,
		LimitRPM = 8000,
		Revlimiter = true,
		PeakTorque = 100,
		PowerbandStart = 900,
		PowerbandEnd = 6500,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(-35.884, -59.3661, 38.669),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 75,
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_idle = "vehicles/sim_fphys_nfsmwcars/idle.wav",
		snd_pitch = 0.72,
		snd_low = "vehicles/sim_fphys_nfsmwcars/300/mid.wav",
		snd_low_revdown = "vehicles/sim_fphys_nfsmwcars/300/revdown.wav",
		snd_low_pitch = 0.72,
		snd_mid = "vehicles/sim_fphys_nfsmwcars/300/high.wav",
		snd_mid_gearup = "vehicles/sim_fphys_nfsmwcars/300/second.wav",
		snd_mid_geardown = "vehicles/sim_fphys_nfsmwcars/300/second.wav",
		snd_mid_pitch = 0.78,
		DifferentialGear = 0.45,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		Gears = {-0.1, 0, 0.15, 0.25, 0.35, 0.45}
	}
}

list.Set("simfphys_vehicles", "aristo_simfphys", V)