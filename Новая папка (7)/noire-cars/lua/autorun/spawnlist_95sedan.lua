local V = {
	Name = "'95 Buick",
	Model = "models/left4dead/vehicles/95sedan.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 2200,
		
		EnginePos = Vector(100,0,29),
		
		GibModels = {
			"models/left4dead/vehicles/95sedan_gib0.mdl",
		},
		
		LightsTable = "95sedan",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel4.mdl",
		CustomWheelPosFL = Vector(69,34,9),
		CustomWheelPosFR = Vector(69,-34,9),
		CustomWheelPosRL = Vector(-62,34,9),
		CustomWheelPosRR = Vector(-62,-34,9),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-6,-18,47),
		SeatPitch = -4,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(105,0,17),
		LPMountRear = Vector(-108,0,17),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "left4dead/vehicles/sedan95_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/sedan95_ignition_good.wav",
		snd_starter_bad = "vehicles/starter_generic_tail.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(-2,-18,15),
				ang = Angle(0,-90,15)
			},
			{
				pos = Vector(-37,19,15),
				ang = Angle(0,-90,15)
			},
			{
				pos = Vector(-37,-19,15),
				ang = Angle(0,-90,15)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-104,25,12),
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
		
		FuelFillPos = Vector(-73,-41,36),
		FuelType = 1,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		Sound_Idle = "left4dead/vehicles/sedan95_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/sedan95_low.wav",
		Sound_MidPitch = 1.25,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/sedan95_high.wav",
		Sound_HighPitch = 0.65,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/sedan95_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/sedan95_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.18,0,0.075,0.15,0.23,0.37,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_95sedan", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(101,31,29),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(101,-31,29),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-112,37.1,30.3),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-112,-37.1,30.3),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(101,31,29),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,255),
		},
		{
			pos = Vector(101,-31,29),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,255),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(101,26,29.5),size = 100,material = "l4d/corona"},
		{pos = Vector(101,-26,29.5),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-106,28,31),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-104,34,31),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-104,-34,31),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-106,-28,31),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-107,21,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-107.5,4,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-107.5,-4,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-107,-21,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-106,28,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-104,34,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-104,-34,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-106,-28,31),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-107,13.5,31),
			material = "l4d/corona",
			size = 50,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-107,-12.5,31),
			material = "l4d/corona",
			size = 50,
			color = Color(255,255,255,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(96,38,29),
				material = "l4d/corona",
				size = 60,
				color = Color(255,136,0,255),
			},
			{
				pos = Vector(-100,38,31),
				material = "l4d/corona",
				size = 60,
				color = Color(255,136,0,255),
			},
		},
		Right = {
			{
				pos = Vector(96,-38,29),
				material = "l4d/corona",
				size = 60,
				color = Color(255,136,0,255),
			},
			{
				pos = Vector(-100,-38,31),
				material = "l4d/corona",
				size = 60,
				color = Color(255,136,0,255),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[5] = "",
				[6] = "",
				[8] = "",
			},
			Brake = {
				[2] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[2] = "",
				[5] = "",
				[6] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[8] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[8] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
	
}
list.Set( "simfphys_lights", "95sedan", light_table)