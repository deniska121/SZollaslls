local V = {
	Name = "Armored Rescue Vehicle (NYPD ESU)",
	Model = "models/left4dead/vehicles/swat.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0,0,-10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Government",

	Members = {
		Mass = 3500,
		
		EnginePos = Vector(130,0,50),
		
		LightsTable = "swat",
		
		IsArmored = true,
		BulletProofTires = true,
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_swat_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_swat_rear.mdl",
		
		CustomWheelPosFL = Vector(92,48,20),
		CustomWheelPosFR = Vector(92,-48,20),	
		CustomWheelPosRL = Vector(-87,48,20),
		CustomWheelPosRR = Vector(-87,-48,20),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,12),		
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(20,-33,95),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		HasBullhorn = true,
		
		ForceAlarm = true,
		
		snd_starter = "left4dead/vehicles/swat_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/swat_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/swat_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/swat_stop.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(40,-33,55),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(40,-11,55),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(0,-42,55),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(0,42,55),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-40,-42,55),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-40,42,55),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-80,-42,55),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-80,42,55),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-120,-42,55),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-120,42,55),
				ang = Angle(0,180,0)
			},
		},
		
		FrontHeight = 16,
		FrontConstant = 38000,
		FrontDamping = 2400,
		FrontRelativeDamping = 50,
		
		RearHeight = 16,
		RearConstant = 38000,
		RearDamping = 2400,
		RearRelativeDamping = 50,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 25,
		BulletProofTires = false,
		
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 140,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		
		FuelFillPos = Vector(23,53,31),
		FuelType = 2,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/swat_idle.wav",
		Sound_IdlePitch = 0.8,
		
		Sound_Mid = "left4dead/vehicles/swat_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/swat_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/swat_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		
		snd_horn = "left4dead/vehicles/swat_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.3,
		Gears = {-0.15,0,0.06,0.15,0.23,0.4,0.6}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_swat", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(122,36,44),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(122,-36,44),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-151,42,38),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-151,-42,38),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(118,36,44),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(118,-36,44),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},

		{
			pos = Vector(72.3,0,107.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(72.3,0,107.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,50),
		},
		{
			pos = Vector(71.4,9.5,107.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(67.8,36,107.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(71.4,-9.5,107.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(67.8,-36,107.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(118,36,44),size = 100,material = "l4d/corona"},
		{pos = Vector(118,-36,44),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-150,42,38),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-150,-42,38),
			material = "l4d/corona",
			size = 50,
			color = Color(255,0,0,150),
		},

		{
			pos = Vector(-148.7,6.2,108.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(-148.7,15.5,108.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(-148.7,42,108.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(-148.7,-6.2,108.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(-148.7,-15.5,108.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
		{
			pos = Vector(-148.7,-42,108.3),
			material = "l4d/corona",
			size = 40,
			color = Color(255,155,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-150,35.5,38),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-150,-35.5,38),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
	},
	ems_sounds = {"left4dead/vehicles/swat_siren_yelp.wav","left4dead/vehicles/swat_siren_hilo.wav"},
	ems_sprites = {
		--FRONT LIGHTBAR LEFT
		{
			pos = Vector(65.6,9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(65.6,29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(57,9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(57,29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.07
		},
		
		--FRONT LIGHTBAR RIGHT
		{
			pos = Vector(65.6,-9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
					},
			Speed = 0.07
		},
		{
			pos = Vector(65.6,-29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
					},
			Speed = 0.07
		},
		{
			pos = Vector(57,-9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
					},
			Speed = 0.07
		},
		{
			pos = Vector(57,-29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
					},
			Speed = 0.07
		},
		
		--REAR LIGHTBAR LEFT
		{
			pos = Vector(-148,9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
					},
			Speed = 0.08
		},
		{
			pos = Vector(-148,29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
					},
			Speed = 0.08
		},
		{
			pos = Vector(-139,9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
					},
			Speed = 0.08
		},
		{
			pos = Vector(-139,29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
					},
			Speed = 0.08
		},
		
		--REAR LIGHTBAR RIGHT
		{
			pos = Vector(-148,-9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.08
		},
		{
			pos = Vector(-148,-29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.08
		},
		{
			pos = Vector(-139,-9,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.08
		},
		{
			pos = Vector(-139,-29,118),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.08
		},
		
		--FRONT LIGHTBAR
		{
			pos = Vector(140.5,10.5,51.5),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,255),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(140.5,-10.5,51.5),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,0,0),
						Color(0,0,255,255),
						Color(0,0,255,255),
					},
			Speed = 0.07
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(121,36,36),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-150,42,38),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
			},
		},
		Right = {
			{
				pos = Vector(121,-36,36),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-150,-42,38),
				material = "l4d/corona",
				size = 50,
				color = Color(255,0,0,255),
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
				[6] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
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
list.Set( "simfphys_lights", "swat", light_table)