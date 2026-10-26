local V = {
	Name = "2004 Краун Виктория",
	Model = "models/left4dead/vehicles/crownvic.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 2000,
		
		EnginePos = Vector(104,0,30),
		
		LightsTable = "crownvic",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_policecar.mdl",
		CustomWheelPosFL = Vector(73.3,33.8,9),
		CustomWheelPosFR = Vector(73.3,-33.8,9),
		CustomWheelPosRL = Vector(-58.5,33.8,9),
		CustomWheelPosRR = Vector(-58.5,-33.8,9),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-2,-17,48),
		SeatPitch = 0,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "left4dead/vehicles/vic_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/vic_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/vic_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/vic_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(8,-17,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-34,17,16),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-34,-17,16),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-104.5,18.8,13),
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
		PeakTorque = 100,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-75,-39,32.8),
		FuelType = 1,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/vic_idle.wav",
		Sound_IdlePitch = 0.9,
		
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
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		
		--
		snd_horn = "left4dead/vehicles/vic_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.18,0,0.095,0.15,0.23,0.37,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_crownvic", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(109.1,27.7,29.1),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(109.1,-27.7,29.1),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-104.8,32.3,35.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-104.8,-32.3,35.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(109.1,27.7,29.1),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,255),
		},
		{
			pos = Vector(109.1,-27.7,29.1),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,255),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(109.1,27.7,29.1),size = 100,material = "l4d/corona"},
		{pos = Vector(109.1,-27.7,29.1),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-104.8,32.3,35.5),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-104.8,-32.3,35.5),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-104.8,32.3,35.5),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-104.8,-32.3,35.5),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-67,0,46.4),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-107.2,10.7,33.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
			OnBodyGroups = { 
					[1] = {0},
			}
		},
		{
			pos = Vector(-107.2,-10.7,33.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
			OnBodyGroups = { 
					[1] = {0},
			}
		},
		{
			pos = Vector(-95.1,10.7,71.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
			OnBodyGroups = { 
					[1] = {1},
			}
		},
		{
			pos = Vector(-95.1,-10.7,71.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
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
				pos = Vector(101.4,37.8,29),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-104.8,32.3,35.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(101.4,-37.8,29),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-104.8,-32.3,35.5),
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
				[7] = "",
				[8] = "",
			},
			Brake = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[3] = "",
				[2] = "",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
	
}
list.Set( "simfphys_lights", "crownvic", light_table)