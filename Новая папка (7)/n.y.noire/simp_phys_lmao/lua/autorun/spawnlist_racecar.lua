--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_racecar.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Jimmy Gibs Jr. Stock Car",
	Model = "models/left4dead/vehicles/racecar.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1500,
		EnginePos = Vector(80, 0, 35),
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_racecar_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_racecar_r.mdl",
		CustomWheelPosFL = Vector(79.5, 37, 11),
		CustomWheelPosFR = Vector(79.5, -37, 11),
		CustomWheelPosRL = Vector(-66, 38, 11),
		CustomWheelPosRR = Vector(-66, -38, 11),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(4, -17, 45),
		SeatPitch = -4,
		SeatYaw = 90,
		ExhaustPositions = {
			{
				pos = Vector(-125, 18.8, 12),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-125, -18.8, 12),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 2000,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		Trunk = 20,
		RearConstant = 24000,
		RearDamping = 2000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 50,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 50,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 230,
		PowerbandStart = 1000,
		PowerbandEnd = 4000,
		Turbocharged = true,
		Supercharged = false,
		FuelFillPos = Vector(-88.8, -35.4, 42.8),
		FuelType = 2,
		FuelTankSize = 250,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/racecar_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/racecar_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/racecar_high.wav",
		Sound_HighPitch = 0.8,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/racecar_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/racecar_horn.wav",
		DifferentialGear = 0.5,
		Gears = {-0.1, 0, 0.13, 0.25, 0.37, 0.55}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_racecar", V)

local V2 = {
	Name = "Jimmy Gibs' Damaged Stock Car",
	Model = "models/left4dead/vehicles/racecar_damaged.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1500,
		EnginePos = Vector(80, 0, 35),
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel2_racecar_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel2_racecar_r.mdl",
		CustomWheelPosFL = Vector(79.5, 37, 11),
		CustomWheelPosFR = Vector(79.5, -37, 11),
		CustomWheelPosRL = Vector(-66, 38, 11),
		CustomWheelPosRR = Vector(-66, -38, 11),
		CustomWheelAngleOffset = Angle(0, 90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		LightsTable = "racecar_d",
		SeatOffset = Vector(4, -17, 45),
		SeatPitch = -4,
		SeatYaw = 90,
		OnSpawn = function(ent)
			ent:SetHullHealth(800)
		end,
		ExhaustPositions = {
			{
				pos = Vector(-125, 18.8, 12),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-125, -18.8, 12),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 2000,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		Trunk = 20,
		RearConstant = 24000,
		RearDamping = 2000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 50,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 50,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 230,
		PowerbandStart = 1000,
		PowerbandEnd = 4000,
		Turbocharged = true,
		Supercharged = false,
		FuelFillPos = Vector(-88.8, -35.4, 42.8),
		FuelType = 2,
		FuelTankSize = 250,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/racecar_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/racecar_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/racecar_high.wav",
		Sound_HighPitch = 0.8,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/racecar_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/racecar_horn.wav",
		DifferentialGear = 0.5,
		Gears = {-0.1, 0, 0.13, 0.25, 0.37, 0.55}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_racecar_d", V2)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(122, 28.6, 11.4),
	L_HeadLampAng = Angle(0, -7, 0),
	R_HeadLampPos = Vector(122, -28.6, 11.4),
	R_HeadLampAng = Angle(0, 8, 0),
	Headlight_sprites = {
		{
			pos = Vector(122, 28.6, 11.4),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(122, -28.6, 11.4),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(122, 28.6, 11.4),
			size = 100,
		},
		{
			pos = Vector(122, -28.6, 11.4),
			size = 100,
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
			},
			Brake = {
				[3] = "",
			},
			Reverse = {
				[3] = "",
			},
			Brake_Reverse = {
				[3] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}

list.Set("simfphys_lights", "racecar_d", light_table)

local V3 = {
	Name = "53 Pontiac Chieftain",
	Model = "models/mafia2/potomac_indian.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 20),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1676,
		EnginePos = Vector(65, 0, 20),
		LightsTable = "potomac_indian",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		TrunkPos = function(obc, obmi, obmx) return Vector(-95.59, -0.28, 21.96) end,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "charger") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		brokenglass = "vehicle_glass2",
		CustomWheelModel = "models/mafia2/speedstone_alpha.mdl",
		CustomWheelPosFL = Vector(68, 30, 2),
		CustomWheelPosFR = Vector(68, -30, 2),
		CustomWheelPosRL = Vector(-55, 32, 4),
		CustomWheelPosRR = Vector(-55, -32, 4),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(10, 0, 2),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-1, -16, 39),
		SeatPitch = -4,
		Trunk = 28,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(6, -15, 8),
				ang = Angle(0, -90, 17)
			},
			{
				pos = Vector(-29, -15, 5),
				ang = Angle(0, -90, 17)
			},
			{
				pos = Vector(-29, 15, 5),
				ang = Angle(0, -90, 17)
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-100, 18, 2),
				ang = Angle(90, 165, 0),
				OnBodyGroups = {
					[7] = {0},
				}
			},
			{
				pos = Vector(-25, -38, 0),
				ang = Angle(90, -125, 0),
				OnBodyGroups = {
					[7] = {1},
				}
			},
			{
				pos = Vector(-28, -38, 0),
				ang = Angle(90, -125, 0),
				OnBodyGroups = {
					[7] = {1},
				}
			},
			{
				pos = Vector(-25, 38, 0),
				ang = Angle(90, 125, 0),
				OnBodyGroups = {
					[7] = {1},
				}
			},
			{
				pos = Vector(-28, 38, 0),
				ang = Angle(90, 125, 0),
				OnBodyGroups = {
					[7] = {1},
				}
			}
		},
		FrontHeight = 8,
		FrontConstant = 24000,
		FrontDamping = 1000,
		CameraDist = -310,
		CameraZ = -65,
		FrontRelativeDamping = 800,
		RearHeight = 8,
		RearConstant = 24000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 1.2,
		MaxGrip = 35,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 38,
		IdleRPM = 700,
		LimitRPM = 3800,
		PeakTorque = 90,
		PowerbandStart = 700,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-74, 40, 24),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 70,
		PowerBias = 1,
		LPMountFront = Vector(96.7,0,7.42),
		LPMountRear = Vector(-102,0,7.02),
		EngineSoundPreset = 0,
		Sound_Idle = "mafia2/V8_normal1_0.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "mafia2/V8_normal1_1.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 80,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "mafia2/V8_normal1_2.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 80,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "mafia2/V8_normal1_3.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 1,
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		snd_start = "cars/engines/start_bike_1.wav",
		start_del = 7,
		DifferentialGear = 0.5,
		Gears = {-0.12, 0, 0.1, 0.23, 0.5}
	}
}

list.Set("simfphys_vehicles", "simfphys_potomac_indian", V3)

local light_table2 = {
	L_HeadLampPos = Vector(93, 29, 25),
	L_HeadLampAng = Angle(5, 0, 0),
	R_HeadLampPos = Vector(93, -29, 25),
	R_HeadLampAng = Angle(5, 0, 0),
	L_RearLampPos = Vector(-98, 34, 19),
	L_RearLampAng = Angle(10, 180, 0),
	R_RearLampPos = Vector(-98, -34, 19),
	R_RearLampAng = Angle(10, 180, 0),
	ColoredLights = Color(247, 192, 120, 240),
	Headlight_sprites = {
		{
			pos = Vector(93, 29, 25),
			material = simfLightZ,
			size = 42,
			color = Color(247, 192, 120, 240)
		},
		{
			pos = Vector(93, -29, 25),
			material = simfLightZ,
			size = 42,
			color = Color(247, 192, 120, 240)
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(93, 29, 25),
			material = simfLightZ,
			size = 45,
			color = Color(247, 192, 120, 240)
		},
		{
			pos = Vector(93, -29, 25),
			material = simfLightZ,
			size = 45,
			color = Color(247, 192, 120, 240)
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-97, 34, 19),
			material = simfLightZ,
			size = 23,
			color = Color(255, 0, 0, 150)
		},
		{
			pos = Vector(-97, -34, 19),
			material = simfLightZ,
			size = 23,
			color = Color(255, 0, 0, 150)
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-97, 34, 19),
			material = simfLightZ,
			size = 25,
			color = Color(255, 0, 0, 180)
		},
		{
			pos = Vector(-97, -34, 19),
			material = simfLightZ,
			size = 25,
			color = Color(255, 0, 0, 180)
		},
	},
	Reverselight_sprites = {},
	DelayOn = 0.1,
	DelayOff = 0.1,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(91.02,29.01,17.7),
				size = 25,
				color = Color(255, 176, 46, 100)
			},
			{
				pos = Vector(-97, 34, 19),
				material = simfLightZ,
				size = 25,
				color = Color(255, 0, 0, 80)
			},
		},
		Right = {{
			pos = Vector(91.02,-29.01,17.7),
			size = 25,
			color = Color(255, 176, 46, 100)
		},
		{
			pos = Vector(-97, -34, 19),
			material = simfLightZ,
			size = 25,
			color = Color(255, 0, 0, 80)
		},},
	}
}

list.Set("simfphys_lights", "potomac_indian", light_table2)