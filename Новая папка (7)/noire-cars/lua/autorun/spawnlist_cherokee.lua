-- addons\simp_phys_lmao\lua\autorun\spawnlist_cherokee.lua
local a = Color(0,0,0,0)
local b = Color(0, 0, 255, 255)
local r = Color(255, 0, 0, 255)

local V2 = {
	Name = "98 Cherokee",
	Model = "models/left4dead/vehicles/98cherokee.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3000,
		EnginePos = Vector(73.22, 0, 30),
		LightsTable = "98cherokee",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		OnSpawn = function(ent)
			if REN and REN.L4D2SimfphysInit then
				REN.L4D2SimfphysInit(ent, "pickup")
			end
		end,
		OnTick = function(ent)
			if REN and REN.L4D2SimfphysOnTick then
				REN.L4D2SimfphysOnTick(ent, 0)
			end
		end,
		OnDelete = function(ent)
			if REN and REN.L4D2Delete then
				REN.L4D2Delete(ent)
			end
		end,
		brokenglass = "pickup_trucks_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_van.mdl",
		CustomWheelPosFL = Vector(62, 32.8, 17),
		CustomWheelPosFR = Vector(62, -32.8, 17),
		CustomWheelPosRL = Vector(-64, 32.8, 17),
		CustomWheelPosRR = Vector(-64, -32.8, 17),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		LPMountFront = Vector(94.25, 0, 31.33),
		LPMountRear = Vector(-100, 0, 42),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-12, -18, 60),
		SeatPitch = 5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(-6, -18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, -18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, 18, 30),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-38, 0, 30),
				ang = Angle(0, -90, 10)
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-90, 24.11, 25),
				ang = Angle(90, 180, 0),
			},
		},
		ExitCheck = 70,
		FrontHeight = 7,
		FrontConstant = 75000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 75000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		Trunk = 50,
		TurnSpeed = 3,
		MaxGrip = 74,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 6000,
		PeakTorque = 210,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-69.81, -38.73, 50.2),
		FuelType = 2,
		FuelTankSize = 150,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/pickup_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/pickup_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/pickup_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
    	Sound_Throttle = "left4dead/vehicles/pickup_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		snd_horn = "left4dead/vehicles/pickup_horn.wav",
		DifferentialGear = 0.4,
		Gears = {-0.14, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_cherokee", V2)

local lt = {
	L_HeadLampPos = Vector(87, 28.57, 43.77),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(90, -28.57, 43.77),
	R_HeadLampAng = Angle(0, 0, 0),
	L_RearLampPos = Vector(-98, 34.45, 45.64),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-98, -34.45, 45.64),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(87, 28.57, 43.77),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(90, -28.57, 43.77),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	Headlamp_sprites = {
		{
			pos = Vector(87, 28.57, 43.77),
			size = 100,
		},
		{
			pos = Vector(90, -28.57, 43.77),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-98, 34.45, 45.64),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-98, -34.45, 45.64),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-98, -34.45, 45.64),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-98, 34.45, 45.64),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(-97, 35.11, 38.53),
				size = 50,
				color = Color(255, 17, 0, 150),
			},
			{
				pos = Vector(90, 28, 36.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(87, 34, 42.98),
				size = 50,
				color = Color(255, 208, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(-97, -35.11, 38.53),
				size = 50,
				color = Color(255, 17, 0, 150),
			},
			{
				pos = Vector(90, -28, 36.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(87, -34, 42.98),
				size = 50,
				color = Color(255, 208, 0, 150),
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
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "98cherokee", lt)