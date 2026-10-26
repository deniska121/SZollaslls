local V = {
	Name = "'84 Fleetwood",
	Model = "models/left4dead/vehicles/84sedan.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 2200,
		
		EnginePos = Vector(110,0,29),
		
		LightsTable = "84sedan",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel3.mdl",
		CustomWheelPosFL = Vector(74.3,33.8,9),
		CustomWheelPosFR = Vector(74.3,-33.8,9),
		CustomWheelPosRL = Vector(-59.5,33.8,9),
		CustomWheelPosRR = Vector(-59.5,-33.8,9),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(4,-22,48),
		SeatPitch = -4,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(112.1,0,17),
		LPMountRear = Vector(-108.2,0,31),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "vehicles/starter_old.wav",
		snd_starter_good = "vehicles/starter_old_tail.wav",
		snd_stop = "left4dead/vehicles/sedan84_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(8,-22,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-31,22,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-31,-22,15),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-109.9,18.8,12),
				ang = Angle(90,180,0),
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
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 25,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 110,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-59.3,-41.5,35.2),
		FuelType = 1,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		Sound_Idle = "left4dead/vehicles/sedan84_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/sedan84_low.wav",
		Sound_MidPitch = 1.25,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/sedan84_high.wav",
		Sound_HighPitch = 0.65,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/sedan84_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		snd_horn = "left4dead/vehicles/sedan84_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.18,0,0.075,0.15,0.23,0.37,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_84sedan", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(107.7,34.3,29.7),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(107.7,-34.3,29.7),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-112,37.1,30.3),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-112,-37.1,30.3),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(107.7,34.3,29.7),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(107.7,-34.3,29.7),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		
		{
			pos = Vector(107.7,27.1,29.7),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(107.7,-27.1,29.7),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(107.7,27.1,29.7),size = 100,material = "l4d/corona"},
		{pos = Vector(107.7,-27.1,29.7),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-112,37.1,30.3),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-112,-37.1,30.3),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-112,37.1,33.3),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-112,-37.1,33.3),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(108,29,26.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(107.7,37.4,26.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(102.6,40.5,26.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-112,36.8,37.7),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(108,-29,26.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(107.7,-37.4,26.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(102.6,-40.5,26.1),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-112,-36.8,37.7),
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
				[2] = "",
			},
			Brake = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[2] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "84sedan", light_table)