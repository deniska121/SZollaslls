--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_taxi.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V3 = {
	Name = "Такси",
	Model = "models/left4dead/vehicles/taxi_old.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2000,
		EnginePos = Vector(104, 0, 30),
		LightsTable = "taxi_old",
		CustomWheels = true,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "95sedan") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountRear = Vector(-106, 0, 33),
		LPRotateRear = Angle(-9, 0, 0),
		CustomSuspensionTravel = 1.5,
		brokenglass = "default",
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
		ModelInfo = {
			Color = Color(213, 178, 83, 255),
		},
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
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 100,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-75, -39, 32.8),
		FuelType = FUELTYPE_PETROL,
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
		Sound_High = "left4dead/vehicles/vic_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/vic_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		--
		snd_horn = "left4dead/vehicles/vic_horn.wav",
		DifferentialGear = 0.5,
		Gears = {-0.25, 0, 0.095, 0.15, 0.23, 0.37, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_taxi_old", V3)

local light_table3 = {
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
			color = Color(255, 238, 200, 255),
		},
		{
			pos = Vector(109.1, -27.7, 29.1),
			size = 70,
			color = Color(255, 238, 200, 255),
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
				[5] = "",
				[4] = "",
				[8] = "",
				[9] = "",
			},
			Brake = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
			Reverse = {
				[5] = "",
				[4] = "",
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "taxi_old", light_table3)