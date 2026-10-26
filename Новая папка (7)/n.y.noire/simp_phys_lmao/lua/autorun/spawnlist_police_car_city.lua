--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_police_car_city.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Полицейский перехватчик",
	Model = "models/left4dead/vehicles/police_car_city.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2000,
		EnginePos = Vector(104, 0, 30),
		LightsTable = "police_city",
		NoAlarmClose = true,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "crownvic") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_policecar.mdl",
		CustomWheelPosFL = Vector(73.3, 33.8, 9),
		CustomWheelPosFR = Vector(73.3, -33.8, 9),
		CustomWheelPosRL = Vector(-58.5, 33.8, 9),
		CustomWheelPosRR = Vector(-58.5, -33.8, 9),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		Trunk = 40,
		CustomSteerAngle = 30,
		SeatOffset = Vector(-2, -17, 48),
		SeatPitch = 0,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(8, -17, 15),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-34, 17, 16),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-34, -17, 16),
				ang = Angle(0, -90, 10)
			},
		},
		SitChangeBlock = {
			[0] = true,
			[1] = true,
		},
		ExhaustPositions = {
			{
				pos = Vector(-104.5, 18.8, 13),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 7,
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
		BrakePower = 65,
		IdleRPM = 800,
		LimitRPM = 5500,
		PeakTorque = 130,
		PowerbandStart = 1500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-75, -39, 32.8),
		FuelType = 1,
		FuelTankSize = 100,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/vic_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/vic_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "vehicles/sim_fphys_nfsmwcars/egt/mid.wav", --vehicles/sim_fphys_nfsmwcars/egt/high.wav
		Sound_HighPitch = 0.9,
		Sound_HighVolume = 1.01,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/vic_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		snd_horn = "simulated_vehicles/horn_2.wav",
		DifferentialGear = 0.5,
		Gears = {-0.18, 0, 0.095, 0.15, 0.23, 0.37, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_police_city", V)

local cl_a = Color(0,0,0,0)
local cl_b = Color(255, 0, 0, 255)
local cl_bl = Color(0, 0, 255, 255)
local cl_r = Color(255, 0, 0, 255)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(109.1, 27.7, 29.1),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(109.1, -27.7, 29.1),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-104.8, 32.3, 35.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-104.8, -32.3, 35.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(109.1, 27.7, 29.1),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(109.1, -27.7, 29.1),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(109.1, 27.7, 29.1),
			size = 100,
		},
		{
			pos = Vector(109.1, -27.7, 29.1),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-104.8, 32.3, 35.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-104.8, -32.3, 35.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-104.8, 32.3, 35.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-104.8, -32.3, 35.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-67, 0, 46.4),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-107.2, 10.7, 33.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {0},
			}
		},
		{
			pos = Vector(-107.2, -10.7, 33.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {0},
			}
		},
		{
			pos = Vector(-95.1, 10.7, 71.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {1},
			}
		},
		{
			pos = Vector(-95.1, -10.7, 71.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {1},
			}
		}
	},
	ems_sounds = {"left4dead/vehicles/vic_police_wail.wav", "left4dead/vehicles/vic_police_yelp.wav"},
	ems_codes = 3,
	ems_sprites = {
		{
			pos = Vector(-6, 7, 71.5),
			size = 80,
			ucode = 2,
			Colors = {cl_r, cl_a,},
			Speed = 0.30
		},
		{
			pos = Vector(-6, -7, 71.5),
			size = 80,
			ucode = 2,
			Colors = {cl_a, cl_b,},
			Speed = 0.30
		},
		{
			pos = Vector(-12.6, 21, 71.5),
			size = 80,
			Colors = {cl_b, cl_a, cl_b, cl_a, cl_b, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.05
		},
		{
			pos = Vector(-12.6, -21, 71.5),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a, cl_r, cl_a,},
			Speed = 0.05
		},
		{
			pos = Vector(-20.15, -25.8, 66),
			size = 40,
			Colors = {cl_r, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.10
		},
		{
			pos = Vector(-20.15, 25.8, 66),
			size = 40,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a,},
			Speed = 0.10
		},
		{
			pos = Vector(-20.87, 3.15, 65.3),
			size = 40,
			Colors = {cl_r, cl_a, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-20.87, 9, 65.3),
			size = 40,
			Colors = {cl_a, cl_r, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-20.87, 15.5, 65.3),
			size = 40,
			Colors = {cl_a, cl_a, cl_r, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-20.87, 21.3, 65.3),
			size = 40,
			Colors = {cl_a, cl_a, cl_a, cl_r,},
			Speed = 0.15
		},
		{
			pos = Vector(-20.87, -3.15, 65.3),
			size = 40,
			Colors = {cl_r, cl_a, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-20.87, -9, 65.3),
			size = 40,
			Colors = {cl_a, cl_r, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-20.87, -15.5, 65.3),
			size = 40,
			Colors = {cl_a, cl_a, cl_r, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-20.87, -21.3, 65.3),
			size = 40,
			Colors = {cl_a, cl_a, cl_a, cl_r,},
			Speed = 0.15
		},
		{
			pos = Vector(-3, 0, 71.5),
			size = 80,
			ucode = 3,
			Colors = {color_white, cl_a, color_white, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.05
		},
		{
			pos = Vector(117, 12.5, 28.2),
			size = 40,
			ucode = 2,
			Colors = {cl_b, cl_b, cl_a, cl_a, cl_b, cl_b, cl_a, cl_a, cl_b, cl_b, cl_a, cl_b, cl_a, cl_b, cl_a, cl_b, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.07
		},
		{
			pos = Vector(117, -12.5, 28.2),
			size = 40,
			ucode = 2,
			Colors = {cl_a, cl_a, cl_r, cl_r, cl_a, cl_a, cl_r, cl_r, cl_a, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a, cl_r,},
			Speed = 0.07
		},
		{
			pos = Vector(-63.25, -20.1, 45.5),
			size = 60,
			ucode = 2,
			Colors = {cl_b, cl_a, cl_b, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.05
		},
		{
			pos = Vector(-63.25, 20.1, 45.5),
			size = 60,
			ucode = 2,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_b, cl_a, cl_b, cl_a, cl_a, cl_a,},
			Speed = 0.05
		},
		{
			pos = Vector(109.1, 27.7, 29.1),
			size = 70,
			ucode = 3,
			Colors = {cl_a, cl_a, cl_a, cl_a, color_white, cl_a, color_white},
			Speed = 0.1
		},
		{
			pos = Vector(109.1, -27.7, 29.1),
			size = 70,
			ucode = 3,
			Colors = {cl_a, cl_a, cl_a, cl_a, color_white, cl_a, color_white},
			Speed = 0.1
		},
		{
			pos = Vector(-67, 0, 46.4),
			size = 60,
			ucode = 3,
			Colors = {cl_r, cl_a, cl_r, cl_a, cl_r, cl_a, cl_a, cl_a},
			Speed = 0.1
		},
		{
			pos = Vector(-107.2, 10.7, 33.8),
			size = 60,
			ucode = 3,
			Colors = {cl_a, cl_a, cl_a, cl_a, color_white, cl_a, color_white},
			Speed = 0.1,
			OnBodyGroups = {
				[1] = {0},
			}
		},
		{
			pos = Vector(-107.2, -10.7, 33.8),
			size = 60,
			ucode = 3,
			Colors = {color_white, cl_a, color_white, cl_a, cl_a, cl_a, cl_a},
			Speed = 0.1,
			OnBodyGroups = {
				[1] = {0},
			}
		},
		{
			pos = Vector(-95.1, 10.7, 71.8),
			size = 60,
			ucode = 3,
			Colors = {cl_a, cl_a, cl_a, cl_a, color_white, cl_a, color_white},
			Speed = 0.1,
			OnBodyGroups = {
				[1] = {1},
			}
		},
		{
			pos = Vector(-95.1, -10.7, 71.8),
			size = 60,
			ucode = 3,
			Colors = {color_white, cl_a, color_white, cl_a, cl_a, cl_a, cl_a},
			Speed = 0.1,
			OnBodyGroups = {
				[1] = {1},
			}
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(101.4, 37.8, 29),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-104.8, 32.3, 35.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(101.4, -37.8, 29),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-104.8, -32.3, 35.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[6] = "",
				[5] = "",
				[10] = "",
				[11] = "",
			},
			Brake = {
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "",
			},
			Reverse = {
				[6] = "",
				[5] = "",
				[10] = "",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "police_city", light_table)

local V2 = {
	Name = "Полицейская машина супервайзера",
	Model = "models/left4dead/vehicles/police_car_city2.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2000,
		EnginePos = Vector(104, 0, 30),
		LightsTable = "police_city2",
		CustomWheels = true,
		NoAlarmClose = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "crownvic") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheel_policecar.mdl",
		CustomWheelPosFL = Vector(73.3, 33.8, 9),
		CustomWheelPosFR = Vector(73.3, -33.8, 9),
		CustomWheelPosRL = Vector(-58.5, 33.8, 9),
		CustomWheelPosRR = Vector(-58.5, -33.8, 9),
		Trunk = 40,
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-2, -17, 48),
		SeatPitch = 0,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(8, -17, 15),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-34, 17, 16),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-34, -17, 16),
				ang = Angle(0, -90, 10)
			},
		},
		SitChangeBlock = {
			[0] = true,
			[1] = true,
		},
		ExhaustPositions = {
			{
				pos = Vector(-104.5, 18.8, 13),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 7,
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
		BrakePower = 65,
		IdleRPM = 800,
		LimitRPM = 5500,
		PeakTorque = 130,
		PowerbandStart = 1500,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-75, -39, 32.8),
		FuelType = 1,
		FuelTankSize = 100,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/vic_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/vic_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "vehicles/sim_fphys_nfsmwcars/egt/mid.wav", --vehicles/sim_fphys_nfsmwcars/egt/high.wav
		Sound_HighPitch = 0.9,
		Sound_HighVolume = 1.01,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/vic_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		snd_horn = "simulated_vehicles/horn_2.wav",
		DifferentialGear = 0.5,
		Gears = {-0.18, 0, 0.095, 0.15, 0.23, 0.37, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_police_city2", V2)

local light_table2 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(109.1, 27.7, 29.1),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(109.1, -27.7, 29.1),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-104.8, 32.3, 35.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-104.8, -32.3, 35.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(109.1, 27.7, 29.1),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(109.1, -27.7, 29.1),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(109.1, 27.7, 29.1),
			size = 100,
		},
		{
			pos = Vector(109.1, -27.7, 29.1),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-104.8, 32.3, 35.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-104.8, -32.3, 35.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-104.8, 32.3, 35.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-104.8, -32.3, 35.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-67, 0, 46.4),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-107.2, 10.7, 33.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {0},
			}
		},
		{
			pos = Vector(-107.2, -10.7, 33.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {0},
			}
		},
		{
			pos = Vector(-95.1, 10.7, 71.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {1},
			}
		},
		{
			pos = Vector(-95.1, -10.7, 71.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = {
				[1] = {1},
			}
		}
	},
	ems_sounds = {"left4dead/vehicles/vic_police_wail.wav", "left4dead/vehicles/vic_police_yelp.wav"},
	ems_sprites = {
		--main flashers
		{
			pos = Vector(-11.5, -15, 70),
			size = 120,
			Colors = {cl_a, cl_a, cl_r, cl_r, cl_a, cl_a, cl_r, cl_r,},
			Speed = 0.15
		},
		{
			pos = Vector(-11.5, 15, 70),
			size = 120,
			Colors = {cl_bl, cl_bl, cl_a, cl_a, cl_bl, cl_bl, cl_a, cl_a,},
			Speed = 0.15
		},
		--side reds
		{
			pos = Vector(-6.9, -19.4, 64),
			size = 20,
			Colors = {cl_a, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-6.8, 2.6, 64),
			size = 20,
			Colors = {cl_a, cl_a, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-15.8, 2.6, 64),
			size = 20,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_r, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-15.8, 19.6, 64),
			size = 20,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_r,},
			Speed = 0.15
		},
		--side blues
		{
			pos = Vector(-6.8, -2.6, 64),
			size = 20,
			Colors = {cl_bl, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-6.9, 19.6, 64),
			size = 20,
			Colors = {cl_a, cl_bl, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-15.8, -2.6, 64),
			size = 20,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_bl, cl_a, cl_a, cl_a,},
			Speed = 0.15
		},
		{
			pos = Vector(-15.8, -19.6, 64),
			size = 20,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_bl, cl_a, cl_a,},
			Speed = 0.15
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(101.4, 37.8, 29),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-104.8, 32.3, 35.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(101.4, -37.8, 29),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-104.8, -32.3, 35.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[6] = "",
				[5] = "",
				[10] = "",
				[11] = "",
			},
			Brake = {
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "",
			},
			Reverse = {
				[6] = "",
				[5] = "",
				[10] = "",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on",
				[11] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "police_city2", light_table2)