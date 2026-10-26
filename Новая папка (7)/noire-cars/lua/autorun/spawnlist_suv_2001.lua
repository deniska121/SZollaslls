local V = {
	Name = "2001 Блейзер",
	Model = "models/left4dead/vehicles/suv_2001.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 2650,
		
		EnginePos = Vector(104,0,47),
		
		LightsTable = "suv2001",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_78.mdl",
		CustomWheelPosFL = Vector(69,36.8,17),
		CustomWheelPosFR = Vector(69,-36.8,17),
		CustomWheelPosRL = Vector(-66,36.8,17),
		CustomWheelPosRR = Vector(-66,-36.8,17),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-1,-22,63),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(108,0,26),
		LPRotateFront = Angle(10,0,0),
		LPMountRear = Vector(-119.5,-2.1,25.6),
		LPRotateRear = Angle(10,0,0),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "left4dead/vehicles/pickup78_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/pickup78_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/pickup78_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/pickup78_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(6,-22,30),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-108,25,22),
				ang = Angle(140,180,0),
			},
		},
		
		FrontHeight = 7,
		FrontConstant = 50000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		
		RearHeight = 7,
		RearConstant = 50000,
		RearDamping = 2500,
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
		PeakTorque = 150,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-38,-45,39.5),
		FuelType = 2,
		FuelTankSize = 100,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/pickup78_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/pickup78_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/pickup78_high.wav",
		Sound_HighPitch = 1.4,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/pickup78_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/pickup78_horn.wav",
		
		DifferentialGear = 0.4,
		Gears = {-0.18,0,0.080,0.13,0.2,0.35,0.65,0.75}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_suv_2001", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(105.5,34.7,43.5),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(105.5,-34.7,43.5),
	R_HeadLampAng = Angle(8,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-116.2,42.5,39.7),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-116.2,-42.5,39.7),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(105.5,34.7,43.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(105.5,-34.7,43.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(105.5,-34.7,43.5),size = 100,material = "l4d/corona"},
		{pos = Vector(105.5,34.7,43.5),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-116.2,42.5,39.7),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-116.2,-42.5,39.7),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-116.2,42.5,39.7),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-116.2,-42.5,39.7),
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
				pos = Vector(105.5,34.7,37.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-116.2,42.5,41.7),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,255),
			},
		},
		Right = {
			{
				pos = Vector(105.5,-34.7,37.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-116.2,-42.5,41.7),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,255),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[4] = "",
			},
			Brake = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "suv2001", light_table)