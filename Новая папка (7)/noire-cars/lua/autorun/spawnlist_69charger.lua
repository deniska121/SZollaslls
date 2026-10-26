local V = {
	Name = "'69 Charger",
	Model = "models/left4dead/vehicles/69charger.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Civilian",

	Members = {
		Mass = 2200,
		
		EnginePos = Vector(80,0,35),
		
		LightsTable = "69charger",
		
		--[[OnSpawn = function(ent)
			if file.Exists( "autorun/__simfphys_randys_extra_functions.lua", "LUA" ) then --check if the shared LUA addon is mounted
				REN.SimfphysInit(ent) --name of car "ent"
			end
		end,
		
		OnDelete = function(ent)
			if file.Exists( "autorun/__simfphys_randys_extra_functions.lua", "LUA" ) then --check if the shared LUA addon is mounted
				REN.Delete(ent) --MUST call on EVERY car that uses my functions
			end
		end,]]
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel2.mdl",
		CustomWheelPosFL = Vector(73,36,10),
		CustomWheelPosFR = Vector(73,-36,10),
		CustomWheelPosRL = Vector(-67,36,10),
		CustomWheelPosRR = Vector(-67,-36,10),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-4,-15,48),
		SeatPitch = -4,
		SeatYaw = 90,
		
		ModelInfo = {
			Skin = 1,
		},
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(114,0,16.6),
		LPMountRear = Vector(-121.3,0,20.6),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		snd_starter = "left4dead/vehicles/cobra_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/cobra_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/cobra_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/cobra_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(4,-17,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-32,16,15),
				ang = Angle(0,-90,10)
			},
			{
				pos = Vector(-32,-16,15),
				ang = Angle(0,-90,10)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-123,18,15),
				ang = Angle(90,180,0),
			},
			{
				pos = Vector(-123,-18,15),
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
		
		IdleRPM = 700,
		LimitRPM = 6000,
		PeakTorque = 135,
		PowerbandStart = 1500,
		PowerbandEnd = 4800,
		Turbocharged = false,
		Supercharged = true,
		
		FuelFillPos = Vector(-88.8,-35.4,42.8),
		FuelType = 1,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/charger_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/charger_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/charger_high.wav",
		Sound_HighPitch = 0.9,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/charger_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 1,
		
		--
		snd_horn = "left4dead/vehicles/sedan_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.18,0,0.095,0.15,0.23,0.37}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_69charger", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(111,32,28),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(111,-32,28),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-123.5,30,33),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-123.5,-30,33),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(111,32,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(111,-32,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		
		{
			pos = Vector(111,24,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(111,-24,28),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(111,24,28),size = 100,material = "l4d/corona"},
		{pos = Vector(111,-24,28),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-123.5,30,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,22,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,14,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,-14,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,-22,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,-30,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-123.5,30,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,22,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,14,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,-14,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,-22,33),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-123.5,-30,33),
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
				pos = Vector(-123,33,33),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(-123,-33,33),
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
				[3] = "",
			},
			Brake = {
				[5] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "",
				[3] = "",
			},
			Brake_Reverse = {
				[5] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	}
	
}
list.Set( "simfphys_lights", "69charger", light_table)