-- "addons\\simfphys_crownvic_unmarked\\lua\\autorun\\spawnlist_crownvic_unmarked.lua"

local V = {
	Name = "2004 Victoria (Unmarked)",
	Model = "models/left4dead/vehicles/crownvic.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2000,
		EnginePos = Vector(104, 0, 30),
		LightsTable = "crownvic2",
		NoAlarmClose = true,
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_policecar.mdl",
		CustomWheelPosFL = Vector(73.3, 33.8, 9),
		CustomWheelPosFR = Vector(73.3, -33.8, 9),
		CustomWheelPosRL = Vector(-58.5, 33.8, 9),
		CustomWheelPosRR = Vector(-58.5, -33.8, 9),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		SeatOffset = Vector(-2, -17, 48),
		SeatPitch = 0,
		SeatYaw = 90,
		
		-- Установка стандартного цвета при спавне (черный)
		ModelInfo = {
			Color = Color(20, 20, 20),
		},
		
		Attachments = {
			{
				model = "models/cityrp/vic_light.mdl",
				pos = Vector(15, 10, 58.1),
				ang = Angle(185, 2, 4)
			},
			{
				model = "models/cityrp/vic_light.mdl",
				pos = Vector(15, -10, 58.1),
				ang = Angle(185, 2, -4)
			},
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
		Trunk = 55,
		
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
		Sound_High = "left4dead/vehicles/vic_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.5,
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

list.Set("simfphys_vehicles", "sim_fphys_l4d_crownvic_pol", V)

local light_table = {
	L_HeadLampPos = Vector(109.1, 27.7, 29.1),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(109.1, -27.7, 29.1),
	R_HeadLampAng = Angle(0, 0, 0),
	
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
			OnBodyGroups = { [1] = {0} }
		},
		{
			pos = Vector(-107.2, -10.7, 33.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = { [1] = {0} }
		},
		{
			pos = Vector(-95.1, 10.7, 71.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = { [1] = {1} }
		},
		{
			pos = Vector(-95.1, -10.7, 71.8),
			size = 60,
			color = Color(255, 255, 255, 150),
			OnBodyGroups = { [1] = {1} }
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
			Base = { [3] = "", [2] = "", [7] = "", [8] = "" },
			Brake = { [3] = "", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "" },
			Reverse = { [3] = "", [2] = "", [7] = "", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
			Brake_Reverse = { [3] = "", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
		on_lowbeam = {
			Base = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "", [8] = "" },
			Brake = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "" },
			Reverse = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
			Brake_Reverse = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
		on_highbeam = {
			Base = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "", [8] = "" },
			Brake = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "" },
			Reverse = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
			Brake_Reverse = { [3] = "models/left4dead/vehicles/4carz1024_lights_on", [2] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
		turnsignals = {
			left = { [5] = "models/left4dead/vehicles/4carz1024_lights_on" },
			right = { [4] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
	}
}

local pl = light_table
local a = Color(0, 0, 0, 0)
local r = Color(255, 0, 0, 255)
local b = Color(0, 0, 255, 255)

pl.ems_sounds = {"left4dead/vehicles/pickup2004_police_wail.wav", "left4dead/vehicles/pickup2004_police_yelp.wav"}

pl.ems_sprites = {
	{
		pos = Vector(15, 10, 58.1),
		size = 70,
		Colors = {a, a, a, a, b, a, b},
		Speed = 0.1
	},
	{
		pos = Vector(15, -10, 58.1),
		size = 70,
		Colors = {b, a, b, a, a, a, a},
		Speed = 0.1
	},
	{
		pos = Vector(109.1, 27.7, 29.1),
		size = 70,
		Colors = {a, a, a, a, color_white, a, color_white},
		Speed = 0.1
	},
	{
		pos = Vector(109.1, -27.7, 29.1),
		size = 70,
		Colors = {a, a, a, a, color_white, a, color_white},
		Speed = 0.1
	},
	{
		pos = Vector(-67, 0, 46.4),
		size = 60,
		Colors = {r, a, r, a, r, a, a, a},
		Speed = 0.1
	},
	{
		pos = Vector(-107.2, 10.7, 33.8),
		size = 60,
		Colors = {a, a, a, a, color_white, a, color_white},
		Speed = 0.1,
		OnBodyGroups = { [1] = {0} }
	},
	{
		pos = Vector(-107.2, -10.7, 33.8),
		size = 60,
		Colors = {color_white, a, color_white, a, a, a, a},
		Speed = 0.1,
		OnBodyGroups = { [1] = {0} }
	},
	{
		pos = Vector(-95.1, 10.7, 71.8),
		size = 60,
		Colors = {a, a, a, a, color_white, a, color_white},
		Speed = 0.1,
		OnBodyGroups = { [1] = {1} }
	},
	{
		pos = Vector(-95.1, -10.7, 71.8),
		size = 60,
		Colors = {color_white, a, color_white, a, a, a, a},
		Speed = 0.1,
		OnBodyGroups = { [1] = {1} }
	}
}

list.Set("simfphys_lights", "crownvic2", light_table)