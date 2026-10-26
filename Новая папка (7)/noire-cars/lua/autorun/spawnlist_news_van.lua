local V = {
	Name = "Новостной 90 Chevrolet",
	Model = "models/left4dead/vehicles/news_van.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Services",

	Members = {
		Mass = 2100,
		
		EnginePos = Vector(112,0,41),
		
		LightsTable = "van",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheelambulance.mdl",
		
		CustomWheelPosFL = Vector(84,37.5,12),
		CustomWheelPosFR = Vector(84,-37.5,12),
		CustomWheelPosRL = Vector(-62,37.5,12),
		CustomWheelPosRR = Vector(-62,-37.5,12),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,20),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(48,-19,64),
		SeatPitch = -4,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(115.4,0,23.5),
		LPMountRear = Vector(-115.5,0,21.4),
		LPGroup = Plates_L4D,
		
		snd_starter = "left4dead/vehicles/van_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/van_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/van_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/van_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(52,-18,37),
				ang = Angle(0,-90,17)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-108,-20,14),
				ang = Angle(90,180,0),
			},
		},
		
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 3000,
		FrontRelativeDamping = 800,
		
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 3000,
		RearRelativeDamping = 800,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 25,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 120,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-33,44,27.6),
		FuelType = 2,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/van_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/van_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/van_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/van_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/van_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.13,0,0.095,0.15,0.23,0.4,0.7}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_news_van", V )