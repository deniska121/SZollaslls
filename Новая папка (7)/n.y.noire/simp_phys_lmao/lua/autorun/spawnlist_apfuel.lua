--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_apfuel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Airport Fuel Truck",
	Model = "models/left4dead/vehicles/airport_fuel_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3500,
		EnginePos = Vector(212, 0, 55),
		LightsTable = "apfuel_truck",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "apcat")
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheel_bus2_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_bus2_r.mdl",
		CustomWheelPosFL = Vector(180.3, 50.7, 27),
		CustomWheelPosFR = Vector(180.3, -50.7, 27),
		CustomWheelPosRL = Vector(-107.6, 41.7, 30),
		CustomWheelPosML = Vector(-58.3, 41.7, 30),
		CustomWheelPosMR = Vector(-58.3, -41.7, 30),
		CustomWheelPosRR = Vector(-107.6, -41.7, 30),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 50,
		SeatOffset = Vector(94, -22, 105),
		SeatPitch = 10,
		SeatYaw = 90,
		EnterDist = 5800,
		PassengerSeats = {
			{
				pos = Vector(115, -21, 54),
				ang = Angle(0, -90, 0)
			},
		},
		LPMountRear = Vector(-205, 0, 21.73),
		LPMountFront = Vector(215.5, 0, 34.09),
		FrontHeight = 16,
		FrontConstant = 50000,
		FrontDamping = 2400,
		FrontRelativeDamping = 50,
		RearHeight = 16,
		RearConstant = 50000,
		RearDamping = 2400,
		Trunk = 30,
		RearRelativeDamping = 50,
		TurnSpeed = 3,
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		BulletProofTires = false,
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 90,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		FuelFillPos = Vector(-162.5, 57.5, 37.5),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = -1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/apfuel_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/apfuel_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/apfuel_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/apfuel_throttle.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/apfuel_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		DifferentialGear = 0.14,
		Gears = {-0.35, 0, 0.15, 0.22, 0.29, 0.37, 0.49, 0.6, 0.79}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_apfuel_truck", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(212.8, 35.2, 47.5),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(212.8, -35.2, 47.5),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-186.8, 53.5, 36.54),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-186.8, -53.5, 36.54),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(212.8, 35.2, 47.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(212.8, -35.2, 47.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(134.25, 0, 108.8),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(134.25, 8.5, 108.8),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(134.25, -8.5, 108.8),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(134.25, 29.2, 108.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(134.25, -29.2, 108.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(76.9, -53.5, 61.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(76.9, 53.5, 61.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-187.25, -53.5, 61.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-187.25, 53.5, 61.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(77, 0, 127.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(77, 6, 127.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(77, -6, 127.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-187.3, 0, 128.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-187.3, 6, 128.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-187.3, -6, 128.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-179.4, 21, 125.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(70.6, 21, 125.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-179.4, -21, 125.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(70.6, -21, 125.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(212.8, 28.25, 47.5),
			size = 100,
		},
		{
			pos = Vector(212.8, -28.25, 47.5),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-186.8, 53.5, 36.54),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-186.8, -53.5, 36.54),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-186.8, 46.5, 36.54),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-186.8, -46.5, 36.54),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(207.45, 48.36, 55.45),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-186.8, 49.8, 42.2),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(207.45, -48.36, 55.45),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-186.8, -49.8, 42.2),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[7] = "",
				[6] = "",
			},
			Brake = {
				[3] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Reverse = {
				[3] = "",
				[7] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[6] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
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
	},
}

list.Set("simfphys_lights", "apfuel_truck", light_table)