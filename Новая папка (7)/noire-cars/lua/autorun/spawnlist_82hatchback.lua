local V = {
	Name = "'82 Hatchback",
	Model = "models/left4dead/vehicles/82hatchback.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 1500,
		
		EnginePos = Vector(55.5,0,30),
		
		GibModels = {
			"models/left4dead/vehicles/82hatch_gib0.mdl",
			"models/left4dead/vehicles/82hatch_gib1.mdl",
			"models/left4dead/vehicles/82hatch_gib2.mdl",
			"models/left4dead/vehicles/82hatch_gib3.mdl",
			"models/left4dead/vehicles/82hatch_gib4.mdl",
			"models/left4dead/vehicles/82hatch_gib5.mdl",
		},
		
		LightsTable = "82hatchback",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel1.mdl",
		CustomWheelPosFL = Vector(55.5,33,12),
		CustomWheelPosFR = Vector(55.5,-33,12),
		CustomWheelPosRL = Vector(-53,33,13),
		CustomWheelPosRR = Vector(-53,-33,13),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(10,0,2),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-4,-16,45),
		SeatPitch = -4,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(83.8,0,14.7),
		LPMountRear = Vector(-81.4,0,31),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "left4dead/vehicles/hatch_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/hatch_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/hatch_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/hatch_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(0,-16,15),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-79,16,10),
				ang = Angle(90,180,0),
			},
		},
		
		FrontHeight = 8,
		FrontConstant = 24000,
		FrontDamping = 1000,
		FrontRelativeDamping = 800,
		
		RearHeight = 8,
		RearConstant = 24000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 25,
		
		IdleRPM = 700,
		LimitRPM = 4500,
		PeakTorque = 90,
		PowerbandStart = 1200,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-50,-40,36),
		FuelType = 1,
		FuelTankSize = 80,
		
		PowerBias = 1,

		EngineSoundPreset = 0,

		Sound_Idle = "left4dead/vehicles/hatch_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/hatch_low.wav",
		Sound_MidPitch = 1.25,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 55,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/hatch_high.wav",
		Sound_HighPitch = 0.65,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 55,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/hatch_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		snd_horn = "left4dead/vehicles/hatch_horn.wav",
		
		DifferentialGear = 0.27,
		Gears = {-0.13,0,0.13,0.32,0.5,0.85,1.1}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_82hatchback", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(81,30,29),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(81,-30,29),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-79,31.5,28.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-79,-31.5,28.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam, adjusted to fix lowbeam position
		{
			pos = Vector(82,30,29),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(82,-30,29),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(81,30,29),size = 100,material = "l4d/corona"},
		{pos = Vector(81,-30,29),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-79,33,28.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-79,-33,28.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-79,25,34),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-79,-25,34),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-79,25,28.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-79,-25,28.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,255,255,150),
		}
	},
	
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(86.5,29,21),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(74,37,29),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-79,33,33),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(86.5,-29,21),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(74,-37,29),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-79,-33,33),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[6] = "",
				[7] = ""
			},
			Brake = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		turnsignals = {
			left = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
	
}
list.Set( "simfphys_lights", "82hatchback", light_table)