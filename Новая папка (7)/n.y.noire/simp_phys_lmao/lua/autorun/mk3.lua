--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/mk3.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local light_tables = {
	ModernLights = false,
	L_HeadLampPos = Vector(-23.7136, 93.2803, 32.4491),
	L_HeadLampAng = Angle(180, -90, 0),
	R_HeadLampPos = Vector(23.7136, 93.2803, 32.4491),
	R_HeadLampAng = Angle(180, -90, 0),
	L_RearLampPos = Vector(-24.323, -96.0485, 32.7187),
	L_RearLampAng = Angle(0, -90, 0),
	R_RearLampPos = Vector(24.323, -96.0485, 32.7187),
	R_RearLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(-23.7136, 93.2803, 32.4491),
			size = 70,
			material = simfLightZ,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {0, 1, 2}
			}
		},
		{
			pos = Vector(23.7136, 93.2803, 32.4491),
			size = 70,
			material = simfLightZ,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {0, 1, 2}
			}
		},
		---
		{
			pos = Vector(-26.1405, 95.5611, 13.8884),
			size = 60,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(26.1405, 95.5611, 13.8884),
			size = 60,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		---
		{
			pos = Vector(25.948, 82.3179, 31.7242),
			size = 40,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(21.7, 82.735, 31.7242),
			size = 40,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-25.948, 82.3179, 31.7242),
			size = 40,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-21.7, 82.735, 31.7242),
			size = 40,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		---
		{
			pos = Vector(-28.2122, 95.6778, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(-29.2122, 95.287, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(-30.2122, 94.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 125),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(-31.339, 93.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 150),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(-32.224, 92.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 125),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(-32.7579, 91.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(-33.4257, 90.91, 25.5478),
			size = 18,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		---
		{
			pos = Vector(28.2122, 95.6778, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(29.2122, 95.287, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(30.2122, 94.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 125),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(31.339, 93.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 150),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(32.224, 92.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 125),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(32.7579, 91.91, 25.5478),
			size = 20,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		{
			pos = Vector(33.4257, 90.91, 25.5478),
			size = 18,
			color = Color(255, 176, 46, 100),
			OnBodyGroups = {
				[1] = {0, 3}
			}
		},
		---
		{
			pos = Vector(22.9766, 99.3777, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(23.9766, 99.0397, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(24.9766, 98.6931, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(25.9766, 98.3233, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(26.9766, 97.9606, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(27.9766, 97.5869, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(28.9766, 97.0589, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(29.9766, 96.3763, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(30.9766, 95.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(31.5766, 94.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(32.1037, 93.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(32.5469, 92.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		---
		{
			pos = Vector(-22.9766, 99.3777, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-23.9766, 99.0397, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-24.9766, 98.6931, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-25.9766, 98.3233, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-26.9766, 97.9606, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-27.9766, 97.5869, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-28.9766, 97.0589, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-29.9766, 96.3763, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-30.9766, 95.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-31.5766, 94.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-32.1037, 93.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
		{
			pos = Vector(-32.5469, 92.6547, 21.3867),
			size = 18,
			color = Color(255, 255, 220, 50),
			OnBodyGroups = {
				[1] = {1}
			}
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(-23.7136, 93.2803, 32.4491),
			size = 20,
			material = simfLightZ,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {0}
			}
		},
		{
			pos = Vector(23.7136, 93.2803, 32.4491),
			size = 20,
			material = simfLightZ,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {0}
			}
		},
		---
		{
			pos = Vector(25.948, 82.3179, 31.7242),
			size = 15,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(21.7, 82.735, 31.7242),
			size = 15,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-25.948, 82.3179, 31.7242),
			size = 15,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
		{
			pos = Vector(-21.7, 82.735, 31.7242),
			size = 15,
			color = Color(255, 255, 220),
			OnBodyGroups = {
				[1] = {3}
			}
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(15.986, -96.5586, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(24.323, -96.0485, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-15.986, -96.5586, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-24.323, -96.0485, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(15.986, -96.5586, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(24.323, -96.0485, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
		---
		{
			pos = Vector(-15.986, -96.5586, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
		{
			pos = Vector(-24.323, -96.0485, 32.7187),
			size = 90,
			color = Color(200, 0, 0, 200)
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-26.7264, -96.1917, 30.596),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(-27.7264, -96.0734, 30.596),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(-26.7264, -95.8216, 32.4535),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(-27.7264, -95.7015, 32.4535),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(-26.7264, -95.4412, 34.2976),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(-27.7264, -95.3262, 34.2976),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		---
		{
			pos = Vector(26.7264, -96.1917, 30.596),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(27.7264, -96.0734, 30.596),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(26.7264, -95.8216, 32.4535),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(27.7264, -95.7015, 32.4535),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(26.7264, -95.4412, 34.2976),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
		{
			pos = Vector(27.7264, -95.3262, 34.2976),
			size = 13,
			color = Color(255, 255, 230, 100)
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-28.7264, -95.8896, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-29.7264, -95.7257, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-30.7264, -95.4674, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-31.7264, -95.1017, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-32.7264, -94.6151, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-33.7264, -93.8316, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			---
			{
				pos = Vector(-28.7264, -95.5103, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-29.7264, -95.3188, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-30.7264, -95.0544, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-31.7264, -94.6914, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-32.7264, -94.1622, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-33.7264, -93.2259, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			---
			{
				pos = Vector(-28.7264, -95.1284, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-29.7264, -94.9308, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-30.7264, -94.6396, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-31.7264, -94.3037, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-32.7264, -93.5656, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			---
			{
				pos = Vector(-18.2122, 97.8917, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {3}
				}
			},
			{
				pos = Vector(-19.2122, 97.682, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {3}
				}
			},
			{
				pos = Vector(-20.2122, 97.5324, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-21.2122, 97.2993, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-22.2122, 97.0665, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-23.2122, 96.837, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-24.2122, 96.5959, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-25.2122, 96.3727, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-26.2122, 96.1315, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(-27.2122, 95.9009, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			---
			{
				pos = Vector(-37.7121, 73.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-38.0077, 74.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-37.8833, 75.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-37.7045, 76.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-37.3765, 77.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-36.7403, 78.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
		},
		Right = {
			{
				pos = Vector(28.7264, -95.8896, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(29.7264, -95.7257, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(30.7264, -95.4674, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(31.7264, -95.1017, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(32.7264, -94.6151, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(33.7264, -93.8316, 30.596),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			---
			{
				pos = Vector(28.7264, -95.5103, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(29.7264, -95.3188, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(30.7264, -95.0544, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(31.7264, -94.6914, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(32.7264, -94.1622, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(33.7264, -93.2259, 32.4535),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			---
			{
				pos = Vector(28.7264, -95.1284, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(29.7264, -94.9308, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(30.7264, -94.6396, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(31.7264, -94.3037, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(32.7264, -93.5656, 34.2976),
				size = 13,
				color = Color(255, 176, 46, 100)
			},
			---
			{
				pos = Vector(18.2122, 97.8917, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {3}
				}
			},
			{
				pos = Vector(19.2122, 97.682, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {3}
				}
			},
			{
				pos = Vector(20.2122, 97.5324, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(21.2122, 97.2993, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(22.2122, 97.0665, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(23.2122, 96.837, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(24.2122, 96.5959, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(25.2122, 96.3727, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(26.2122, 96.1315, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			{
				pos = Vector(27.2122, 95.9009, 25.5478),
				size = 20,
				color = Color(255, 176, 46, 100),
				OnBodyGroups = {
					[1] = {0, 3}
				}
			},
			---
			{
				pos = Vector(37.7121, 73.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(38.0077, 74.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(37.8833, 75.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(37.7045, 76.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(37.3765, 77.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(36.7403, 78.8125, 25.5039),
				size = 15,
				color = Color(255, 176, 46, 100)
			},
		},
	},
	DelayOn = 0.1,
	PoseParameters = {
		name = "headlights",
		min = 0,
		max = 1,
	},
}

list.Set("simfphys_lights", "mk3_simfphys", light_tables)

local V = {
	Name = "90 Toyota Supra",
	Model = "models/vehicles/toyota/mk3.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 0),
	Members = {
		Mass = 1440,
		EnginePos = Vector(0, 61.2546, 37.9158),
		LightsTable = "mk3_simfphys",
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
		LPMountRear = Vector(0, -94.82, 30.92),
		LPRotateRear = Angle(-10, 90, 0),
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		CustomWheelModel = "models/drift_spirits/toyota/wh_mk3.mdl",
		CustomWheelPosFL = Vector(-33.2499, 58.8033, 13.889),
		CustomWheelPosFR = Vector(33.2499, 58.8033, 13.889),
		CustomWheelPosRL = Vector(-33.2499, -54.7163, 13.889),
		CustomWheelPosRR = Vector(33.2499, -54.7163, 13.889),
		CustomWheelAngleOffset = Angle(180, 0, 180),
		CustomMassCenter = Vector(0, 0, 0),
		ModelInfo = {
			Color = Color(255, 255, 255),
		},
		ExhaustPositions = {
			{
				pos = Vector(-23.3271, -95.9356, 12.3971),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {0, 2, 3}
				}
			},
			{
				pos = Vector(-19.2903, -95.9428, 12.3971),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {0, 2, 3}
				}
			},
			{
				pos = Vector(-24.0161, -97.6467, 12.4073),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {1}
				}
			},
			{
				pos = Vector(-19.9762, -97.645, 12.4073),
				ang = Angle(90, -90, 0),
				OnBodyGroups = {
					[3] = {1}
				}
			},
		},
		CustomSteerAngle = 35,
		SeatOffset = Vector(-2, 15.2, 41),
		SeatPitch = -10,
		SeatYaw = 0,
		PassengerSeats = {
			{
				pos = Vector(-15.2, 5, 11.5),
				ang = Angle(0, 0, 27)
			},
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
		MaxGrip = 40,
		Efficiency = 1.2,
		GripOffset = -3,
		BrakePower = 45,
		IdleRPM = 900,
		LimitRPM = 8000,
		Revlimiter = true,
		PeakTorque = 113.5,
		PowerbandStart = 900,
		PowerbandEnd = 6100,
		Turbocharged = false,
		Supercharged = false,
		Trunk = 35,
		Backfire = false,
		BulletProofTires = false,
		FuelFillPos = Vector(37.2977, -72.2957, 31.9347),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 70,
		PowerBias = 1,
		EngineSoundPreset = -1,
		snd_idle = "vehicles/tdmcars/supra/idle.wav",
		snd_pitch = 0.85,
		snd_low = "vehicles/tdmcars/supra/first.wav",
		snd_low_revdown = "vehicles/tdmcars/supra/throttle_off.wav",
		snd_low_pitch = 0.85,
		snd_mid = "vehicles/tdmcars/supra/second.wav",
		snd_mid_gearup = "vehicles/tdmcars/supra/third.wav",
		snd_mid_geardown = "vehicles/tdmcars/supra/second.wav",
		snd_mid_pitch = 0.85,
		snd_blowoff = "vehicles/sim_fphys_nfsmwcars/blowoff3.wav",
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		DifferentialGear = 0.35,
		Gears = {-0.1, 0, 0.2, 0.3, 0.40, 0.50, 0.6}
	}
}

list.Set("simfphys_vehicles", "mk3_simfphys", V)

local V2 = {
	Name = "2005 Mustang Convertible",
	Model = "models/ats/vehicles/mustang.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1564,
		EnginePos = Vector(102.37, -0.88, 9.95),
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LightsTable = "ats_mustang",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		brokenglass = "vehicle_glass2",
		CustomWheelModel = "models/ats/vehicles/wheel/car/generic/17in.mdl",
		CustomWheelPosFL = Vector(68.11, 33.7, -8),
		CustomWheelPosFR = Vector(68.11, -33.7, -8),
		CustomWheelPosRL = Vector(-44.16, 33.7, -8),
		CustomWheelPosRR = Vector(-44.16, -33.7, -8),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 1),
		CustomSteerAngle = 35,
		SeatOffset = Vector(-5, -16, 23),
		SeatPitch = 10,
		noglass = true,
		LPMountRear = Vector(-89.69, -1, -0.84),
		LPRotateRear = Angle(0, 0, 0),
		Trunk = 20,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(4, -17, -9),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-27, 14, -9),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-27, -14, -9),
				ang = Angle(0, -90, 10)
			},
		},
		FrontHeight = 8,
		FrontConstant = 30000,
		FrontDamping = 2000,
		FrontRelativeDamping = 800,
		RearHeight = 8,
		RearConstant = 30000,
		RearDamping = 2000,
		RearRelativeDamping = 800,
		TurnSpeed = 1.4,
		MaxGrip = 40,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 45,
		BulletProofTires = false,
		IdleRPM = 800,
		LimitRPM = 5750,
		PeakTorque = 165,
		PowerbandStart = 2700,
		PowerbandEnd = 5000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(-59.56, 34.29, 16.34),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 60,
		PowerBias = 1,
		EngineSoundPreset = 14,
		snd_horn = "ats/vehicles/horns/horn_car_09.wav",
		DifferentialGear = 0.35,
		Gears = {-0.075, 0, 0.075, 0.17, 0.29, 0.41, 0.58}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_ats_mustang", V2)

local light_table2 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(90.34, 29.19, 6.23),
	L_HeadLampAng = Angle(17, 0, 0),
	R_HeadLampPos = Vector(90.34, -29.19, 6.23),
	R_HeadLampAng = Angle(10, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-85.72, 18.66, 13.43),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-85.72, -18.66, 13.43),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(90.34, 29.19, 6.23),
			material = simfLightZ,
			size = 70,
			color = Color(255, 238, 200, 255),
		},
		{
			pos = Vector(90.34, -29.19, 6.23),
			material = simfLightZ,
			size = 70,
			color = Color(255, 238, 200, 255),
		},
	}, -- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(99.64, 14.44, 6.92),
			size = 100,
			material = simfLightZ
		},
		{
			pos = Vector(99.64, -14.44, 6.92),
			size = 100,
			material = simfLightZ
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-85.72, 18.66, 13.43),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-85.72, -18.66, 13.43),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-84.58, 23.14, 12.98),
			material = simfLightZ,
			size = 70,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-84.58, -23.14, 12.98),
			material = simfLightZ,
			size = 70,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-84.46, 0, 19.76),
			material = simfLightZ,
			size = 70,
			color = Color(255, 0, 0, 255),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-86.15, 18.45, 8.57),
			material = simfLightZ,
			size = 40,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-86.15, -18.45, 8.57),
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
				pos = Vector(94.85, 31.26, -1.84),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-83.28, 27.65, 13.13),
				material = simfLightZ,
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(94.85, -31.26, -1.84),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-83.28, -27.65, 13.13),
				material = simfLightZ,
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
	}
}

list.Set("simfphys_lights", "ats_mustang", light_table2)

local V3 = {
	Name = "2005 Mustang GT",
	Model = "models/vehicles/ford/mustanggt.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Премиум",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1600,
		EnginePos = Vector(70.84,3.46,25.32),
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LightsTable = "mustang",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/vehicles/ford/mustanggt_wheel.mdl",
		CustomWheelPosFL = Vector(65.11, 33.7, 8),
		CustomWheelPosFR = Vector(65.11, -33.7, 8),
		CustomWheelPosRL = Vector(-57, 33.7, 8),
		CustomWheelPosRR = Vector(-57, -33.7, 8),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 0, 1),
		CustomSteerAngle = 35,
		SeatOffset = Vector(-18, -18, 39),
		SeatPitch = 10,
		LPMountRear = Vector(-104.79, 0, 17),
		LPRotateRear = Angle(0, 0, 0),
		Trunk = 30,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(-1, -19, 7),
				ang = Angle(0, -90, 12)
			},
			{
				pos = Vector(-37, 17, 7),
				ang = Angle(0, -90, 12),
				nosound = true,
				noenter = true,
				noexit = true
			},
			{
				pos = Vector(-37, -17, 7),
				ang = Angle(0, -90, 12),
				nosound = true,
				noenter = true,
				noexit = true
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-101.72,25.87,8.94),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-101.3,-26.26,8.43),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 8,
		FrontConstant = 30000,
		FrontDamping = 2000,
		FrontRelativeDamping = 800,
		RearHeight = 8,
		RearConstant = 30000,
		RearDamping = 2000,
		RearRelativeDamping = 800,
		TurnSpeed = 1.4,
		MaxGrip = 45,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 45,
		BulletProofTires = false,
		IdleRPM = 800,
		LimitRPM = 5750,
		PeakTorque = 165,
		PowerbandStart = 2700,
		PowerbandEnd = 5000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(-79.74,37.41,30.17),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 60,
		PowerBias = 1,
		EngineSoundPreset = 14,
		snd_horn = "ats/vehicles/horns/horn_car_09.wav",
		DifferentialGear = 0.35,
		Gears = {-0.17, 0, 0.075, 0.17, 0.29, 0.41, 0.58, 0.62}
	}
}

list.Set("simfphys_vehicles", "mustanggt", V3)

local light_table3 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(95.64,30.91,22.25),
	L_HeadLampAng = Angle(17, 0, 0),
	R_HeadLampPos = Vector(95.64,-30.91,22.25),
	R_HeadLampAng = Angle(10, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-105,20.71,31.95),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-105,-20.71,31.95),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(89.64,30.91,22.25),
			material = simfLightZ,
			size = 70,
			color = Color(255, 238, 200, 255),
		},
		{
			pos = Vector(89.64,-30.91,22.25),
			material = simfLightZ,
			size = 70,
			color = Color(255, 238, 200, 255),
		},
	}, -- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(98.38,15.82,22.27),
			size = 100,
			material = simfLightZ
		},
		{
			pos = Vector(98.38,-15.82,22.27),
			size = 100,
			material = simfLightZ
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-98.73,20.56,32.14),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-98.73,-20.56,32.14),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-98.73,20.56,32.14),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-98.73,-20.56,32.14),
			material = simfLightZ,
			size = 60,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-98.66,25.75,32.29),
			material = simfLightZ,
			size = 70,
			color = Color(255, 0, 0, 255),
		},
		{
			pos = Vector(-98.66,-25.75,32.29),
			material = simfLightZ,
			size = 70,
			color = Color(255, 0, 0, 255),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-98.51,21.05,27.66),
			material = simfLightZ,
			size = 40,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-98.51,-21.05,27.66),
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
				pos = Vector(93.8,33.16,13.18),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-96.36,31.24,31.47),
				material = simfLightZ,
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(93.8,-33.16,13.18),
				material = simfLightZ,
				size = 50,
				color = Color(255, 135, 0, 255),
			},
			{
				pos = Vector(-96.36,-31.24,31.47),
				material = simfLightZ,
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[3] = "", --rev
				[4] = "", --b1
				[0] = "", --b2
				[11] = "", --11
				[12] = "", --12
			},
			Brake = {
				[3] = "", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "models/drift_spirits/other/lights_on", --b2
				[11] = "", --11
				[12] = "", --12
			},
			Reverse = {
				[3] = "models/drift_spirits/other/lights_on", --rev
				[4] = "", --b1
				[0] = "", --b2
				[11] = "", --11
				[12] = "", --12
			},
			Brake_Reverse = {
				[3] = "models/drift_spirits/other/lights_on", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "models/drift_spirits/other/lights_on", --b2
				[11] = "", --11
				[12] = "", --12
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "", --b2
				[11] = "", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
			Brake = {
				[3] = "", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "models/drift_spirits/other/lights_on", --b2
				[11] = "", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
			Reverse = {
				[3] = "models/drift_spirits/other/lights_on", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "", --b2
				[11] = "", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
			Brake_Reverse = {
				[3] = "models/drift_spirits/other/lights_on", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "models/drift_spirits/other/lights_on", --b2
				[11] = "", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
		},
		on_highbeam = {
			Base = {
				[3] = "", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "", --b2
				[11] = "models/drift_spirits/other/lights_on", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
			Brake = {
				[3] = "", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "models/drift_spirits/other/lights_on", --b2
				[11] = "models/drift_spirits/other/lights_on", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
			Reverse = {
				[3] = "models/drift_spirits/other/lights_on", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "", --b2
				[11] = "models/drift_spirits/other/lights_on", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
			Brake_Reverse = {
				[3] = "models/drift_spirits/other/lights_on", --rev
				[4] = "models/drift_spirits/other/lights_on", --b1
				[0] = "models/drift_spirits/other/lights_on", --b2
				[11] = "models/drift_spirits/other/lights_on", --11
				[12] = "models/drift_spirits/other/lights_on", --12
			},
		},
		turnsignals = {
			left = {
				[2] = "models/drift_spirits/other/lights_on"
			},
			right = {
				[1] = "models/drift_spirits/other/lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "mustang", light_table3)