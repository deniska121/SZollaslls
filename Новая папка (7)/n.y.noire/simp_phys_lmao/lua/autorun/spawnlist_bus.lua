--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_bus.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function Approach(Target, ent)
	if not ent.fdoorstate or not Target then return end
	local now = CurTime()
	local timepassed = now - ent.LastThink
	ent.LastThink = now
	ent.fdoorstate = math.Approach(ent.fdoorstate, Target, timepassed)
end

local V = {
	Name = "Автобус (Городской)",
	Model = "models/left4dead/vehicles/bus.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3525,
		EnginePos = Vector(-214, -32.6, 137.1),
		LightsTable = "l4d_bus",
		CustomWheels = true,
		NoLockSounds = true,
		NoAlarmClose = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_bus_f.mdl",
		brokenglass = "bus_glass",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_bus_r.mdl",
		OnSpawn = function(ent)
			ent.fdoornum = 1
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent.fdoorMoving = true
			ent:SetPoseParameter("front_door", 1)
			ent:SetPoseParameter("rear_door", 1)
			REN.L4D2SimfphysInit(ent, "bus") --name of car "ent", name of the audio bank
			ent:SetColor(Color(20, 20, 39))
			ent:SetSkin(1)
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1) --name of car "ent", Has reversing beep? 0/1
			if not IsValid(ent) or not ent.fdoorstate or not ent.fdoornum then return end

			if ent.lastlock == nil or ent.lastlock ~= ent:GetIsVehicleLocked() then
				ent.lastlock = ent:GetIsVehicleLocked()
				ent.fdoornum = ent.lastlock and 0 or 1
				ent.fdoorMoving = true
				--ent.fdoorstate = ent.fdoornum == 0 and 0 or 1
				ent.LastThink = CurTime()
				ent:EmitSound(ent.fdoornum == 1 and "left4dead/vehicles/bus_fdoor_open.wav" or "left4dead/vehicles/bus_fdoor_close.wav")
			end

			if ent.fdoorMoving then
				Approach(ent.fdoornum, ent)
				ent:SetPoseParameter("front_door", ent.fdoorstate)
				ent:SetPoseParameter("rear_door", ent.fdoorstate)
				if ent.fdoornum == ent.fdoorstate then
					ent.fdoorMoving = nil
				end
			end
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountFront = Vector(239.5, 0, 35),
		LPMountRear = Vector(-237.7, -31.2, 41.4),
		CustomWheelPosFL = Vector(148.3, 46.8, 10),
		CustomWheelPosFR = Vector(148.3, -46.8, 10),
		CustomWheelPosRL = Vector(-98.9, 39, 10),
		CustomWheelPosRR = Vector(-98.9, -39, 10),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 35),
		CustomSteerAngle = 50,
		SeatOffset = Vector(177, -27, 118),
		SeatPitch = 10,
		SeatYaw = 90,
		Trunk = 0,
		NoDoorSound = true,
		EnterDist = 5800,
		PassengerSeats = {
			{
				pos = Vector(161, -37, 58),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(161, 37, 58),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(128, -37, 58),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(128, 37, 58),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(96, -37, 58),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(14, 36, 58),
				ang = Angle(0, 180, 0),
				nosound = true
			},
			{
				pos = Vector(-26, -37, 58),
				ang = Angle(0, 90, 0),
				nosound = true
			},
			{
				pos = Vector(-67, 37, 58),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(-107, -37, 58),
				ang = Angle(0, 90, 0),
				nosound = true
			}
		},
		ExitPoint = Vector(205, -80, 24),
		ExhaustPositions = {
			{
				pos = Vector(-214, -32.6, 137.1),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-214, -32.6, 137.1),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 62,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 80,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		FuelFillPos = Vector(-200, 51.3, 37.1),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/bus_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/bus_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/bus_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/bus_throttle.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/bus_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		DifferentialGear = 0.35,
		Gears = {-0.075, 0, 0.055, 0.125, 0.2, 0.275, 0.375}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_bus", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(240.4, 35.2, 38.3),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(240.4, -35.2, 38.3),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-238.1, 39, 62.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-238.1, -39, 62.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(240.4, 35.2, 38.3),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(240.4, -35.2, 38.3),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(177.5, 51.6, 46.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(177.5, -51.6, 46.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(115, 51.6, 54.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(0, 51.6, 54.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-163.4, 51.6, 54.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(115, -51.6, 54.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(0, -51.6, 54.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-130.8, -51.6, 46.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-130.8, 51.6, 46.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(238.7, 10.4, 124.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(238.7, 0, 124.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(238.7, -10.4, 124.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(240.4, 26.1, 38.3),
			size = 100,
		},
		{
			pos = Vector(240.4, -26.1, 38.3),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-238.1, 39, 62.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-238.1, -39, 62.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-227, 32.7, 129.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-227, 0, 131.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-227, -32.7, 129.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-238.1, 39, 71.4),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-238.1, -39, 71.4),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-238.1, 0, 81.3),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(240.3, 30.7, 44.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(239, 31, 118.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(229.7, 51.7, 61.6),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-227.4, 51.7, 61.6),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-238.1, 38.9, 54.9),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(240.3, -30.7, 44.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(239, -31, 118.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(229.7, -51.7, 61.6),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-227.4, -51.7, 61.6),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-238.1, -38.9, 54.9),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[4] = "",
				[5] = "",
				[3] = "",
			},
			Brake = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
				[3] = "",
			},
			Reverse = {
				[2] = "",
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "",
				[3] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
				[3] = "",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "l4d_bus", light_table)
local V2 = table.Copy(V)
V2.Name = "Автобус (Тур)"

V2.Members.OnSpawn = function(ent)
	ent.fdoornum = 1
	ent.fdoorstate = 0
	ent.LastThink = 0
	ent:SetPoseParameter("front_door", 1)
	ent:SetPoseParameter("rear_door", 1)
	REN.L4D2SimfphysInit(ent, "bus")
	ent:SetSkin(5)
	ent:SetBodygroup(4, 3)
	ent:SetBodygroup(2, 1)
end

list.Set("simfphys_vehicles", "sim_fphys_l4d_bus3", V2)
local V3 = table.Copy(V)
V3.Name = "Автобус (Дальний)"

V3.Members.OnSpawn = function(ent)
	ent.fdoornum = 1
	ent.fdoorstate = 0
	ent.LastThink = 0
	ent:SetPoseParameter("front_door", 1)
	ent:SetPoseParameter("rear_door", 1)
	REN.L4D2SimfphysInit(ent, "bus")
	ent:SetColor(Color(80, 78, 59))
	ent:SetSkin(2)
	ent:SetBodygroup(3, 1)
end

V3.Members.PassengerSeats = {
	{
		pos = Vector(161, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(161, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(128, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(128, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(97, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(97, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(65, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(65, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(33, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(33, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(1, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(1, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-30, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-30, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-62, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-62, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-93, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-93, 29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-125, -29, 58),
		ang = Angle(0, -90, 0)
	},
	{
		pos = Vector(-125, 29, 58),
		ang = Angle(0, -90, 0)
	},
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_bus2", V3)