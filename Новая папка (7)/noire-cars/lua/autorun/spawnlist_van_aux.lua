local cl_a = Color(0, 0, 0, 0)
local cl_b = Color(0, 0, 255, 255)
local cl_r = Color(255, 0, 0, 255)

-- ==========================================
-- СИСТЕМА ОСВЕЩЕНИЯ И МИГАЛОК (NYPD Van)
-- ==========================================
local base_van_light = {
	L_HeadLampPos = Vector(109.1, 27.7, 29.1),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(109.1, -27.7, 29.1),
	R_HeadLampAng = Angle(0, 0, 0),
	L_RearLampPos = Vector(-104.8, 32.3, 35.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-104.8, -32.3, 35.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{pos = Vector(109.1, 27.7, 29.1), size = 70, color = Color(255, 238, 200, 150)},
		{pos = Vector(109.1, -27.7, 29.1), size = 70, color = Color(255, 238, 200, 150)},
	},
	Rearlight_sprites = {
		{pos = Vector(-104.8, 32.3, 35.5), size = 80, color = Color(255, 0, 0, 150)},
		{pos = Vector(-104.8, -32.3, 35.5), size = 80, color = Color(255, 0, 0, 150)}
	},
	Brakelight_sprites = {
		{pos = Vector(-104.8, 32.3, 35.5), size = 100, color = Color(255, 0, 0, 150)},
		{pos = Vector(-104.8, -32.3, 35.5), size = 100, color = Color(255, 0, 0, 150)},
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector(101.4, 37.8, 29), size = 50, color = Color(255, 136, 0, 150)},
		},
		Right = {
			{pos = Vector(101.4, -37.8, 29), size = 50, color = Color(255, 136, 0, 150)},
		},
	}
}

local light_tablea = table.Copy(base_van_light)
light_tablea.ems_sounds = {"left4dead/vehicles/vic_police_wail.wav", "left4dead/vehicles/vic_police_yelp.wav"}
light_tablea.ems_sprites = {
	{
		pos = Vector(38.33, -33.1, 92.5),
		size = 40,
		Colors = {cl_r, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a},
		Speed = 0.10
	},
	{
		pos = Vector(38.33, 33.1, 92.5),
		size = 40,
		Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a},
		Speed = 0.10
	},
	{
		pos = Vector(-92, 8.8, 95),
		size = 80,
		Colors = {color_white, cl_a, cl_a, cl_a},
		Speed = 0.15
	},
	{
		pos = Vector(-92, 3.3, 95),
		size = 80,
		Colors = {cl_a, cl_a, cl_r, cl_a},
		Speed = 0.15
	},
	{
		pos = Vector(-92, -3.3, 95),
		size = 80,
		Colors = {color_white, cl_a, color_white, cl_a},
		Speed = 0.15
	},
	{
		pos = Vector(-92, -8.8, 95),
		size = 80,
		Colors = {cl_a, cl_a, cl_r, cl_a},
		Speed = 0.15
	},
	{
		pos = Vector(60, 0, 95),
		size = 80,
		Colors = {color_white, cl_a, color_white, cl_a, cl_a, cl_a, cl_a, cl_a},
		Speed = 0.05
	},
	{
		pos = Vector(57, -8, 95),
		size = 80,
		Colors = {cl_b, cl_a, cl_b, cl_a, cl_b, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a},
		Speed = 0.05
	},
	{
		pos = Vector(57, 8, 95),
		size = 80,
		Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a, cl_r, cl_a},
		Speed = 0.05
	},
	{
		pos = Vector(50, -26.5, 95),
		size = 80,
		Colors = {cl_r, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a},
		Speed = 0.10
	},
	{
		pos = Vector(50, 26.5, 95),
		size = 80,
		Colors = {cl_a, cl_a, cl_a, cl_a, cl_b, cl_a, cl_b, cl_a},
		Speed = 0.10
	},
}

light_tablea.SubMaterials = {
	off = {
		Base = { [5] = "", [7] = "", [8] = "", },
		Brake = { [5] = "", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "", },
		Reverse = { [5] = "", [7] = "", [8] = "models/left4dead/vehicles/4carz1024_lights_on", },
		Brake_Reverse = { [5] = "", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on", },
	},
	on_lowbeam = {
		Base = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "", },
		Brake = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "", },
		Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on", },
		Brake_Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on", },
	},
	on_highbeam = {
		Base = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "", },
		Brake = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "", },
		Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on", },
		Brake_Reverse = { [5] = "models/left4dead/vehicles/4carz1024_lights_on", [7] = "models/left4dead/vehicles/4carz1024_lights_on", [8] = "models/left4dead/vehicles/4carz1024_lights_on", },
	},
	turnsignals = {
		left = { [6] = "models/left4dead/vehicles/4carz1024_lights_on" },
		right = { [4] = "models/left4dead/vehicles/4carz1024_lights_on" },
	},
}

list.Set("simfphys_lights", "van_nypd", light_tablea)

-- ==========================================
-- КОНФИГУРАЦИЯ ТРАНСПОРТА (NYPD Van AUX)
-- ==========================================
local AUX = {
	Name = "NYPD Van (AUX)",
	Model = "models/left4dead/vehicles/van_nypd.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2500,
		EnginePos = Vector(104, 0, 30),
		LightsTable = "van_nypd",
		NoAlarmClose = true,
		
		-- Параметры управления
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		FastSteerConeFadeSpeed = 2500,

		-- Колеса и подвеска
		CustomWheels = true,
		CustomWheelModel = "models/left4dead/vehicles/wheelambulance.mdl",
		CustomWheelPosFL = Vector(84, 37.5, 12),
		CustomWheelPosFR = Vector(84, -37.5, 12),
		CustomWheelPosRL = Vector(-62, 37.5, 12),
		CustomWheelPosRR = Vector(-62, -37.5, 12),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 10),
		LPMountFront = Vector(115.4, 0, 23.5),
		LPMountRear = Vector(-115.5, -1.3, 21.4),
		CustomSteerAngle = 30,
		CustomSuspensionTravel = 1.5,

		-- Водительское сиденье (взято из vanilla-конфига фургона)[cite: 2]
		SeatOffset = Vector(48, -19, 64),
		SeatPitch = -4,
		SeatYaw = 90,

		Trunk = 60,
		SitChangeBlock = {
			[0] = true,
			[1] = true,
			[9] = true,
		},
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent.NYPDAuxVeh = true
			ent.trunklist = {}
			ent.customplates = "models/left4dead/vehicles/plate/l4d_front0"
			
			if REN and REN.L4D2SimfphysInit then
				REN.L4D2SimfphysInit(ent, "van")
			end
			
			local count = 20
			for _, v in ipairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
				if v.NYPDAuxVeh then
					count = count + 1
				end
			end
			ent.McCD_UniqueId = "70 " .. count
		end,
		PassengerSeats = {
			{ pos = Vector(52, -22, 37), ang = Angle(0, -90, 17) },
			{ pos = Vector(12, -22, 37), ang = Angle(0, 90, 17) },
			{ pos = Vector(12, 0, 37), ang = Angle(0, 90, 17), exitcheck = 75 },
			{ pos = Vector(12, 22, 37), ang = Angle(0, 90, 17) },
			{ pos = Vector(-30, -22, 37), ang = Angle(0, -90, 17) },
			{ pos = Vector(-30, 0, 37), ang = Angle(0, -90, 17), exitcheck = 75 },
			{ pos = Vector(-30, 22, 37), ang = Angle(0, -90, 17) },
			{ pos = Vector(-76, 22, 37), ang = Angle(0, 90, 17) },
		},
		ExhaustPositions = {
			{ pos = Vector(-108, -20, 14), ang = Angle(90, 180, 0) },
		},
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 2000,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 2000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 120,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-33, 44, 27.6),
		FuelType = 2,
		FuelTankSize = 100,
		PowerBias = 1,
		EngineSoundPreset = 0,
		
		-- Звуки двигателя, гудка и тормозов из базового фургона[cite: 2]
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
		snd_brake = "cars/wheels/brake_disc_1.wav",
		snd_start = "cars/engines/start_2.wav",
		start_del = 2,
		snd_horn = "left4dead/vehicles/van_horn.wav",
		
		DifferentialGear = 0.5,
		Gears = {-0.13, 0, 0.095, 0.15, 0.23, 0.4, 0.7}
	}
}
list.Set("simfphys_vehicles", "sim_fphys_l4d_van_aux", AUX)