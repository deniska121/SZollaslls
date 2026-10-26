local V = {
	Name = "'69 Roadrunner",
	Model = "models/left4dead/vehicles/69sedan.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 2200,
		
		EnginePos = Vector(80,0,35),
		
		LightsTable = "69sedan",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel2.mdl",
		CustomWheelPosFL = Vector(77.5,38,7),
		CustomWheelPosFR = Vector(77.5,-38,7),
		CustomWheelPosRL = Vector(-58,38,7),
		CustomWheelPosRR = Vector(-58,-38,7),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(4,-16,45),
		SeatPitch = -4,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(116,0,12.4),
		LPMountRear = Vector(-121.9,0,20.2),
		LPRotateRear = Angle(15,0,0),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "left4dead/vehicles/sedan_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/sedan_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/sedan_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/sedan_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(8,-16,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-31,16,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-31,-16,15),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-118,18.8,12),
				ang = Angle(90,180,0),
			},
			{
				pos = Vector(-118,-18.8,12),
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
		PeakTorque = 130,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-75,-46,37.5),
		FuelType = 1,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/sedan_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/sedan_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/sedan_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/sedan_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.18,0,0.095,0.15,0.23,0.37,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_69sedan", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(112,37.3,26.5),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(112,-37.3,26.5),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-120,30,28),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-120,-30,28),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(112,37.3,26.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(112,-37.3,26.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		
		{
			pos = Vector(112,29.5,26.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(112,-29.5,26.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(112,29.5,26.5),size = 100,material = "l4d/corona"},
		{pos = Vector(112,-29.5,26.5),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-120,30,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,22,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,14,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,-14,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,-22,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,-30,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-120,30,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,22,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,14,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,-14,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,-22,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-120,-30,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-120,35.5,28),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(-120,-35.5,28),
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
	}
	
}
list.Set( "simfphys_lights", "69sedan", light_table)