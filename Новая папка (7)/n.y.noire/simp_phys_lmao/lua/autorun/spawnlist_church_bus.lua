--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_church_bus.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function Approach(Target, ent)
	local now = CurTime()
	local timepassed = now - ent.LastThink
	ent.LastThink = now
	ent.fdoorstate = math.Approach(ent.fdoorstate, Target, timepassed)
end

local V = {
	Name = "Тюремный автобус",
	Model = "models/left4dead/vehicles/church_bus.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3525,
		EnginePos = Vector(205, 0, 38),
		LightsTable = "cbus",
		CustomWheels = true,
		CustomSuspensionTravel = 2,
		NoDoorSound = true,
		brokenglass = "bus_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_bus2_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_bus2_r.mdl",
		OnSpawn = function(ent)
			ent:SetSkin(0)
			ent.fdoornum = 1
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent:SetPoseParameter("front_door", 1)
			ent:SetPoseParameter("rear_door", 1)
			REN.L4D2SimfphysInit(ent, "bus")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1) --name of car "ent", Has reversing beep? 0/1
			local ply = ent:GetDriver()
			if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

			if not ent.fdoorMoving and (ent.PressedKeys and ent.PressedKeys["Lock"]) then
				ent.fdoorMoving = true
				ent.fdoorstate = ent.fdoornum == 0 and 0 or 1
				ent.fdoornum = ent.fdoornum == 0 and 1 or 0
				ent.LastThink = CurTime()
				ent:EmitSound(ent.fdoornum == 1 and "left4dead/vehicles/bus_fdoor_open.wav" or "left4dead/vehicles/bus_fdoor_close.wav")

				timer.Simple(2, function()
					if not IsValid(ent) then return end
					ent.fdoorMoving = nil
				end)
			end

			if ent.fdoorMoving then
				Approach(ent.fdoornum, ent)
				ent:SetPoseParameter("front_door", ent.fdoorstate)
			end
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		CustomWheelPosFL = Vector(180, 47, 10),
		CustomWheelPosFR = Vector(180, -47, 10),
		CustomWheelPosRL = Vector(-98.9, 43, 10),
		CustomWheelPosRR = Vector(-98.9, -43, 10),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		LPMountFront = Vector(212.3, 0, 27),
		LPMountRear = Vector(-241.9, 36.8, 45.7),
		CustomSteerAngle = 50,
		CustomMassCenter = Vector(0, 0, 50),
		SeatOffset = Vector(88, -27, 102),
		SeatPitch = 10,
		Trunk = 0,
		SeatYaw = 90,
		EnterDist = 5800,
		PassengerSeats = {
			{
				pos = Vector(60, -35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(20, 35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(-19, -35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(-57, 35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(-96, -35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(-136, 35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(-174, -35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			},
			{
				pos = Vector(-214, 35.4, 50),
				ang = Angle(0, -90, 0),
				nosound = true
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-229, 56, 23),
				ang = Angle(90, 90, 0),
			},
			{
				pos = Vector(-229, 56, 23),
				ang = Angle(90, 90, 0),
			},
		},
		ExitPoint = Vector(125.61, -80, 21.63),
		FrontHeight = 2,
		FrontConstant = 24000,
		FrontDamping = 2500,
		FrontRelativeDamping = 4000,
		RearHeight = 2,
		RearConstant = 24000,
		RearDamping = 2500,
		RearRelativeDamping = 4000,
		TurnSpeed = 3,
		MaxGrip = 62,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 40,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 80,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		FuelFillPos = Vector(-200, 51.3, 37.1),
		FuelType = 2,
		FuelTankSize = 110,
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
		snd_horn = "simulated_vehicles/horn_2.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		DifferentialGear = 0.5,
		Gears = {-0.075, 0, 0.055, 0.125, 0.2, 0.275, 0.375}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_cbus", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(211, 44, 38),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(211, -44, 38),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-242, 37, 67),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-242, -37, 67),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(211, 44, 38),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(211, -44, 38),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(148, -14, 125),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(148, 14, 125),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(148, 0, 125.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(139, -54.4, 108),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(139, 54.4, 108),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-233, 56, 108),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-233, -56, 108),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(103, 56, 45),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(103, -56, 45),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(211, 35, 38),
			size = 100,
		},
		{
			pos = Vector(211, -35, 38),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-242, 37, 67),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-242, -37, 67),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-59.2, 57, 36.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-59.2, -57, 36.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-226.6, 57, 36.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-226.6, -57, 36.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-240.4, 7.6, 125.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-240.4, -7.6, 125.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-240.4, 0, 125.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-242, 37, 67),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-242, -37, 67),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-242, 29, 67),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-242, -29, 67),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	ems_sounds = {"common/null.wav"},
	ems_sprites = {
		{
			pos = Vector(147, 32, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 255), Color(255, 135, 66, 0),},
			Speed = 0.75
		},
		{
			pos = Vector(147, 43, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 0), Color(255, 135, 66, 255),},
			Speed = 0.75
		},
		{
			pos = Vector(147, -32, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 255), Color(255, 135, 66, 0),},
			Speed = 0.75
		},
		{
			pos = Vector(147, -43, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 0), Color(255, 135, 66, 255),},
			Speed = 0.75
		},
		{
			pos = Vector(-239, 32, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 255), Color(255, 135, 66, 0),},
			Speed = 0.75
		},
		{
			pos = Vector(-239, 43, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 0), Color(255, 135, 66, 255),},
			Speed = 0.75
		},
		{
			pos = Vector(-239, -32, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 255), Color(255, 135, 66, 0),},
			Speed = 0.75
		},
		{
			pos = Vector(-239, -43, 113),
			size = 90,
			Colors = {Color(255, 135, 66, 0), Color(255, 135, 66, 255),},
			Speed = 0.75
		},
		{
			pos = Vector(-231, 0, 133),
			size = 90,
			Colors = {Color(255, 135, 66, 255), Color(255, 135, 66, 255),},
			Speed = 0.75
		},
	},
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(185, 45, 57),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-242, 46, 67),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(185, -45, 57),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-242, -46, 67),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[6] = "",
				[7] = "",
				[8] = "",
				[9] = "",
			},
			Brake = {
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Reverse = {
				[6] = "",
				[7] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
			Brake_Reverse = {
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
			},
		},
		on_highbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
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

list.Set("simfphys_lights", "cbus", light_table)