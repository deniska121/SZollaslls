local V = {
	Name = "Пожарная машина (Ladder)",
	Model = "models/left4dead/vehicles/fire_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0,0,70),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Government",

	Members = {
		Mass = 6500,
		
		EnginePos = Vector(217,0,-23.6),
		
		LightsTable = "l4d_fire_truck",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_fire_truck.mdl",
		
		CustomWheelPosFL = Vector(138,43,-53),
		CustomWheelPosFR = Vector(138,-43,-53),
		CustomWheelPosML = Vector(-80,43,-47),
		CustomWheelPosMR = Vector(-80,-43,-47),		
		CustomWheelPosRL = Vector(-138,43,-50),
		CustomWheelPosRR = Vector(-138,-43,-50),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,0),		
		
		CustomSteerAngle = 50,
		
		SeatOffset = Vector(160,-32,38),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		HasAirbrakes = true,
		
		HasBullhorn = true,
		
		PolRadioSound = "Simf_PolRadio",
		
		snd_starter = "left4dead/vehicles/fire_truck_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/fire_truck_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/fire_truck_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/fire_truck_stop.wav",
		snd_bullhorn = "left4dead/vehicles/fire_truck_horn.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		ExhaustPositions = {
			{
				pos = Vector(21,-48,-57.9),
				ang = Angle(-90,90,0),
			},
			{
				pos = Vector(21,48,-57.9),
				ang = Angle(-90,-90,0),
			},
		},
		
		PassengerSeats = {
			{
				pos = Vector(170,-32,-22),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(90,32,-22),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(90,-32,-22),
				ang = Angle(0,-90,0)
			},
		},
		
		FrontHeight = 16,
		FrontConstant = 50000,
		FrontDamping = 2000,
		FrontRelativeDamping = 5,
		
		RearHeight = 16,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 5,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 100,
		
		TurnSpeed = 3,
		
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 45,
		BulletProofTires = false,
		
		IdleRPM = 1100,
		LimitRPM = 5000,
		PeakTorque = 125,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		
		FuelFillPos = Vector(48.4,-37,-24.6),
		FuelType = 2,
		FuelTankSize = 170,
		
		PowerBias = -1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "left4dead/vehicles/fire_truck_idle.wav",
		Sound_IdlePitch = 0.8,
		
		Sound_Mid = "left4dead/vehicles/fire_truck_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 35,
		Sound_MidFadeOutRate = 0.3,
		
		Sound_High = "left4dead/vehicles/fire_truck_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 35,
		Sound_HighFadeInRate = 0.3,
		
		Sound_Throttle = "left4dead/vehicles/fire_truck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		
		snd_horn = "left4dead/vehicles/flatnose_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.14,
		Gears = {-0.15,0,0.15,0.22,0.29,0.37,0.49,0.6,0.79}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_fire_truck", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(217,33,-25.5),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(217,-33,-25.5),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-245,42.4,-31.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-245,-42.4,-31.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(217,33,-25.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(217,-33,-25.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		
		{
			pos = Vector(217,26,-25.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(217,-26,-25.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(217,26,-25.5),size = 100,material = "l4d/corona"},
		{pos = Vector(217,-26,-25.5),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-245,42.4,-31.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-245,-42.4,-31.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-245,42.4,-25.4),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-245,-42.4,-25.4),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-245,42.4,-19.2),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-245,-42.4,-19.2),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
	},
	
	ems_sounds = {"left4dead/vehicles/fire_truck_siren_wail.wav","left4dead/vehicles/fire_truck_siren_yelp.wav"},
	ems_sprites = {
		--main front row red 1
		{
			pos = Vector(188,25.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,255),
						Color(255,0,0,0),
					},
			Speed = 0.5
		},
		{
			pos = Vector(188,-25.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.5
		},
		--main front row white
		{
			pos = Vector(180,34.2,41.2),
			material = "l4d/corona",
			size = 100,
			Colors = {
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
					},
			Speed = 0.1
		},
		{
			pos = Vector(180,-34.2,41.2),
			material = "l4d/corona",
			size = 100,
			Colors = {
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
					},
			Speed = 0.1
		},
		--main front row red 2
		{
			pos = Vector(170,43.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		{
			pos = Vector(170,-43.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		--left side row reds
		{
			pos = Vector(107,41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.075
		},
		{
			pos = Vector(95,41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.075
		},
		--left side row whites
		{
			pos = Vector(101,41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
					},
			Speed = 0.075
		},
		{
			pos = Vector(89,41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
					},
			Speed = 0.075
		},
		--right side row reds
		{
			pos = Vector(107,-41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.075
		},
		{
			pos = Vector(95,-41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.075
		},
		--right side row whites
		{
			pos = Vector(101,-41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
					},
			Speed = 0.075
		},
		{
			pos = Vector(89,-41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {
						
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
					},
			Speed = 0.075
		},
		--left side red 1
		{
			pos = Vector(214,52.2,-46.6),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		{
			pos = Vector(-115.6,33.2,24.2),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		--left side red 2
		{
			pos = Vector(14.4,33.2,24.2),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.11
		},
		--right side red 1
		{
			pos = Vector(214,-52.2,-46.6),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		{
			pos = Vector(-115.6,-33.2,24.2),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		--right side red 2
		{
			pos = Vector(14.4,-33.2,24.2),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.11
		},
		--front red 1
		{
			pos = Vector(217,25.9,-18.8),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		{
			pos = Vector(217,-25.9,-18.8),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.1
		},
		--front red 2
		{
			pos = Vector(241.7,42.1,-46.8),
			material = "l4d/corona",
			size = 160,
			Colors = {
						Color(255,0,0,60),
						Color(255,0,0,80),
						Color(255,0,0,100),
						Color(255,0,0,120),
						Color(255,0,0,140),
						Color(255,0,0,160),
						Color(255,0,0,180),
						Color(255,0,0,200),
						Color(255,0,0,220),
						Color(255,0,0,240),
						Color(255,0,0,255),
						Color(255,0,0,240),
						Color(255,0,0,220),
						Color(255,0,0,200),
						Color(255,0,0,180),
						Color(255,0,0,160),
						Color(255,0,0,140),
						Color(255,0,0,120),
						Color(255,0,0,100),
						Color(255,0,0,80),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
					},
			Speed = 0.02
		},
		{
			pos = Vector(241.7,-42.1,-46.8),
			material = "l4d/corona",
			size = 160,
			Colors = {
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,60),
						Color(255,0,0,80),
						Color(255,0,0,100),
						Color(255,0,0,120),
						Color(255,0,0,140),
						Color(255,0,0,160),
						Color(255,0,0,180),
						Color(255,0,0,200),
						Color(255,0,0,220),
						Color(255,0,0,240),
						Color(255,0,0,255),
						Color(255,0,0,240),
						Color(255,0,0,220),
						Color(255,0,0,200),
						Color(255,0,0,180),
						Color(255,0,0,160),
						Color(255,0,0,140),
						Color(255,0,0,120),
						Color(255,0,0,100),
						Color(255,0,0,80),
						Color(255,0,0,60),
					},
			Speed = 0.02
		},
		--back whites
		{
			pos = Vector(-252.6,-41.4,-44.6),
			material = "l4d/corona",
			size = 70,
			Colors = {
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
					},
			Speed = 0.11
		},
		{
			pos = Vector(-252.6,41.4,-44.6),
			material = "l4d/corona",
			size = 70,
			Colors = {
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,0),
						Color(255,255,255,255),
						Color(255,255,255,0),
						Color(255,255,255,255),
					},
			Speed = 0.11
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(217,32.8,-18.9),
				material = "l4d/corona",
				size = 70,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-246,42.8,-38.8),
				material = "l4d/corona",
				size = 70,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(217,-32.8,-18.9),
				material = "l4d/corona",
				size = 70,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-246,-42.8,-38.8),
				material = "l4d/corona",
				size = 70,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[7] = "",
				[6] = "",
				[3] = "",
			},
			Brake = {
				[7] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[7] = "",
				[6] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[7] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "",
			},
			Brake = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "",
			},
			Brake = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
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
	},
}
list.Set( "simfphys_lights", "l4d_fire_truck", light_table)