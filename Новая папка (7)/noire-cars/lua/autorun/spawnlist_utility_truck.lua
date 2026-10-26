local V = {
	Name = "Пикап Infra Maintaince",
	Model = "models/left4dead/vehicles/utility_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0,0,-10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Industrial",
	FLEX = {
		Trailers = {
			outputPos = Vector(-102.9,0,18),
			outputType = "ballsocket"
		}
	},
	
	Members = {
		Mass = 2700,
		
		EnginePos = Vector(100,0,33),
		
		LightsTable = "utility_truck",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_utility_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_utility_truck_rear.mdl",
		
		CustomWheelPosFL = Vector(72,34,13),
		CustomWheelPosFR = Vector(72,-34,13),
		CustomWheelPosRL = Vector(-49,41,13),
		CustomWheelPosRR = Vector(-49,-41,13),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(7,-20,55),
		SeatPitch = 5,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountRear = Vector(-100.9,18.8,25),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorPresets = {
			Color(255,255,255),
			Color(185,185,185),
			Color(200,145,45),
			Color(215,165,75),
		},
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(18,-18,22),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-100,28,15),
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
		PeakTorque = 150,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-18,45,27),
		FuelType = 2,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/utility_truck_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/utility_truck_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/utility_truck_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/utility_truck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/utility_truck_horn.wav",
		
		DifferentialGear = 0.37,
		Gears = {-0.14,0,0.09,0.17,0.28,0.4,0.65}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_utility_truck", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(98.3,27.1,32.8),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(98.3,-27.1,32.8),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-101.1,40.4,24.9),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-101.1,-40.4,24.9),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(98.3,27.1,32.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(98.3,-27.1,32.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(98.3,27.1,32.8),size = 100,material = "l4d/corona"},
		{pos = Vector(98.3,-27.1,32.8),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-101.1,40.4,24.9),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-101.1,-40.4,24.9),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		}
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(98.1,34.8,32.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(101.9,27.4,24.9),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(-101.1,33.7,24.9),
				material = "l4d/corona",
				size = 100,
				color = Color(255,0,0,150),
			},
		},
		Right = {
			{
				pos = Vector(98.1,-34.8,32.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(101.9,-27.4,24.9),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-101.1,-33.7,24.9),
				material = "l4d/corona",
				size = 100,
				color = Color(255,0,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[6] = "",
			},
			Brake = {
				[4] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[4] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}
list.Set( "simfphys_lights", "utility_truck", light_table)