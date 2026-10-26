
local V = {
	Name = "Форд Ф250",
	Model = "models/left4dead/vehicles/pickup_dually.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",
	FLEX = {
		Trailers = {
			outputPos = Vector(-191,0,26),
			outputType = "ballsocket"
		}
	},

	Members = {
		Mass = 3000,
		
		EnginePos = Vector(116,0,42),
		
		LightsTable = "pickup_dually",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_dually_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_pickup_dually_rear.mdl",
		
		CustomWheelPosFL = Vector(85,41.8,13),
		CustomWheelPosFR = Vector(85,-41.8,13),
		CustomWheelPosRL = Vector(-118,51,13),
		CustomWheelPosRR = Vector(-118,-51,13),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(0,-24,70),
		SeatPitch = 5,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(118.2,0,24.9),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		RandomBodygroups = {
			{
				number = 1,
			},
		},
		
		snd_starter = "left4dead/vehicles/pickup78_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/pickup78_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/pickup78_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/pickup78_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(18,-22,36),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-30,22,32),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-30,-22,32),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-30,0,32),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-170,24,19),
				ang = Angle(140,180,0),
			},
		},
		
		FrontHeight = 7,
		FrontConstant = 35000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		
		RearHeight = 7,
		RearConstant = 35000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 190,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-65,-47,49),
		FuelType = 2,
		FuelTankSize = 150,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/pickup_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/pickup_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/pickup_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/pickup_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/pickup_horn.wav",
		
		DifferentialGear = 0.45,
		Gears = {-0.14,0,0.09,0.17,0.28,0.4,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_pickup_dually", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(113,36,46),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(113,-36,46),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-172,44,50),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-172,-44,50),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(113,36,46),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(113,-36,46),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(33,6,89),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(33,-6,89),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(32,-19,89),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(32,19,89),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(31,-31,88.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(31,31,88.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		
	},
	
	Headlamp_sprites = {
		{pos = Vector(113,32,46),size = 100,material = "l4d/corona"},
		{pos = Vector(113,-32,46),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-172,44,50),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-172,-44,50),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-172,44,44),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-172,-44,44),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(113,37,37),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(113,30,37),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-172,44,38),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(113,-37,37),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(113,-30,37),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-172,-44,38),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[6] = "",
			},
			Brake = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "pickup_dually", light_table)