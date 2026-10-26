local V = {
	Name = "Пожарная машина (Engine)",
	Model = "models/left4dead/vehicles/fire_engine.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0,0,70),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 6000,
		EnginePos = Vector(217,0,-23.6),
		LightsTable = "l4d_fire_engine",
		
		CustomWheels = true,
		CustomSuspensionTravel = 0.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_fire_truck.mdl",
		CustomWheelPosFL = Vector(138,43,-53),
		CustomWheelPosFR = Vector(138,-43,-53),
		CustomWheelPosRL = Vector(-80,43,-47),
		CustomWheelPosRR = Vector(-80,-43,-47),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(30,0,0),		
		CustomSteerAngle = 50,
		
		-- === ИСПРАВЛЕНИЕ ОШИБКИ ===
		FastSteeringAngle = 20,            
		SteeringFadeFastSpeed = 3000,     -- Название параметра изменено на то, которое читает simfphys
		-- =========================
		
		SeatOffset = Vector(160,-32,38),
		SeatPitch = 10,
		SeatYaw = 90,
		
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
		FrontRelativeDamping = 1,
		FrontWheelMass = 100,
		
		RearHeight = 16,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 5,
		RearWheelMass = 100,
		
		TurnSpeed = 3,
		MaxGrip = 130,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 55,
		BulletProofTires = true,
		
		IdleRPM = 1100,
		LimitRPM = 5000,
		PeakTorque = 155,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		
		FuelFillPos = Vector(48.4,-37,-24.6),
		FuelType = 2,
		FuelTankSize = 170,
		
		PowerBias = 0,
		
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
		
		snd_horn = "left4dead/vehicles/fire_truck_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.14,
		Gears = {-0.35,0,0.15,0.22,0.29,0.37,0.49,0.6,0.79}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_fire_engine", V )

local light_table = {
	L_HeadLampPos = Vector(217,33,-25.5),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(217,-33,-25.5),
	R_HeadLampAng = Angle(0,0,0),
	
	L_RearLampPos = Vector(-149,42.4,-31.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-149,-42.4,-31.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {
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
			pos = Vector(-149,42.4,-31.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-149,-42.4,-31.5),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-149,42.4,-25.4),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-149,-42.4,-25.4),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-149,42.4,-19.2),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-149,-42.4,-19.2),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
	},
	
	ems_sounds = {"left4dead/vehicles/fire_truck_siren_wail.wav","left4dead/vehicles/fire_truck_siren_yelp.wav"},
	ems_sprites = {
		{
			pos = Vector(188,25.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,255), Color(255,0,0,0)},
			Speed = 0.5
		},
		{
			pos = Vector(188,-25.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,0), Color(255,0,0,255)},
			Speed = 0.5
		},
		{
			pos = Vector(180,34.2,41.2),
			material = "l4d/corona",
			size = 100,
			Colors = {Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0)},
			Speed = 0.1
		},
		{
			pos = Vector(180,-34.2,41.2),
			material = "l4d/corona",
			size = 100,
			Colors = {Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255)},
			Speed = 0.1
		},
		{
			pos = Vector(170,43.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(170,-43.2,41.2),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(107,41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.075
		},
		{
			pos = Vector(95,41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.075
		},
		{
			pos = Vector(101,41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255)},
			Speed = 0.075
		},
		{
			pos = Vector(89,41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255)},
			Speed = 0.075
		},
		{
			pos = Vector(107,-41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255)},
			Speed = 0.075
		},
		{
			pos = Vector(95,-41.2,42.4),
			material = "l4d/corona",
			size = 120,
			Colors = {Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255)},
			Speed = 0.075
		},
		{
			pos = Vector(101,-41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0)},
			Speed = 0.075
		},
		{
			pos = Vector(89,-41.2,42.4),
			material = "l4d/corona",
			size = 100,
			Colors = {Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0)},
			Speed = 0.075
		},
		{
			pos = Vector(214,52.2,-46.6),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(-152, 43, 11.5),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(5, 50.11, -21.47),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(-126, 50.11, -21.61),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(4.13, 33.2, 24.2),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255)},
			Speed = 0.11
		},
		{
			pos = Vector(214,-52.2,-46.6),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(-116.23, -43.03, 30),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(-128.34, -43.03, 30),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(-121.34, -43.03, 30),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,255), Color(255,255,255,255), Color(255,255,255,255)},
			Speed = 0.1
		},
		{
			pos = Vector(-134.34, -43.03, 30),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,255), Color(255,255,255,255), Color(255,255,255,255)},
			Speed = 0.1
		},
		{
			pos = Vector(14.4,-33.2,24.2),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255)},
			Speed = 0.11
		},
		{
			pos = Vector(217,25.9,-18.8),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(217,-25.9,-18.8),
			material = "l4d/corona",
			size = 80,
			Colors = {Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,255), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0), Color(255,0,0,0)},
			Speed = 0.1
		},
		{
			pos = Vector(241.7,42.1,-46.8),
			material = "l4d/corona",
			size = 160,
			Colors = {Color(255,0,0,60), Color(255,0,0,80), Color(255,0,0,100), Color(255,0,0,120), Color(255,0,0,140), Color(255,0,0,160), Color(255,0,0,180), Color(255,0,0,200), Color(255,0,0,220), Color(255,0,0,240), Color(255,0,0,255), Color(255,0,0,240), Color(255,0,0,220), Color(255,0,0,200), Color(255,0,0,180), Color(255,0,0,160), Color(255,0,0,140), Color(255,0,0,120), Color(255,0,0,100), Color(255,0,0,80), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60)},
			Speed = 0.02
		},
		{
			pos = Vector(241.7,-42.1,-46.8),
			material = "l4d/corona",
			size = 160,
			Colors = {Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,60), Color(255,0,0,80), Color(255,0,0,100), Color(255,0,0,120), Color(255,0,0,140), Color(255,0,0,160), Color(255,0,0,180), Color(255,0,0,200), Color(255,0,0,220), Color(255,0,0,240), Color(255,0,0,255), Color(255,0,0,240), Color(255,0,0,220), Color(255,0,0,200), Color(255,0,0,180), Color(255,0,0,160), Color(255,0,0,140), Color(255,0,0,120), Color(255,0,0,100), Color(255,0,0,80), Color(255,0,0,60)},
			Speed = 0.02
		},
		{
			pos = Vector(-157.6,-41.4,-44.6),
			material = "l4d/corona",
			size = 70,
			Colors = {Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,0), Color(255,255,255,255), Color(255,255,255,0), Color(255,255,255,255)},
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
				pos = Vector(-149,42.8,-38.8),
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
				pos = Vector(-149,-42.8,-38.8),
				material = "l4d/corona",
				size = 70,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = { [5] = "", [9] = "", [8] = "" },
			Brake = { [5] = "", [9] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "" },
			Reverse = { [5] = "", [9] = "", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
			Brake_Reverse = { [5] = "", [9] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
		on_lowbeam = {
			Base = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "", [8] = "" },
			Brake = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "" },
			Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
			Brake_Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
		on_highbeam = {
			Base = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "", [8] = "" },
			Brake = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "" },
			Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
			Brake_Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [9] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
		turnsignals = {
			left = { [4] = "models/left4dead/vehicles/4carz1024_lights_on" },
			right = { [3] = "models/left4dead/vehicles/4carz1024_lights_on" },
		},
	},
}
list.Set( "simfphys_lights", "l4d_fire_engine", light_table )