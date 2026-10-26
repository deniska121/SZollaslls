--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_ambulance.lua
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
	Name = "Скорая помощь",
	Model = "models/left4dead/vehicles/ambulance.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2000,
		EnginePos = Vector(112, 0, 41),
		LightsTable = "ambulance",
		EMS_car = true,
		CustomWheels = true,
		NoAlarmClose = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheelambulance.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheelambulance2.mdl",
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorstate = 1
			ent.LastThink = 0
			REN.L4D2SimfphysInit(ent, "van") --name of car "ent", name of the audio bank
			local stretcher = ents.Create("ent_stretcher")
			stretcher:SetPos(ent:LocalToWorld(Vector(-100,0,40)))
			stretcher:Spawn()
			stretcher:Hook(ent)
			stretcher.MainEnt = ent
			ent:DeleteOnRemove(stretcher)
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
				ent:EmitSound(ent.fdoornum == 1 and "left4dead/vehicles/ambulance_rear_open.wav" or "left4dead/vehicles/ambulance_rear_close.wav")

				timer.Simple(2, function()
					if not IsValid(ent) then return end
					ent.fdoorMoving = nil
				end)
			end

			if ent.fdoorMoving then
				Approach(ent.fdoornum, ent)
				ent:SetPoseParameter("rear_door", ent.fdoorstate)
				-- ent:SetPoseParameter("left_door", ent.fdoorstate)
				-- ent:SetPoseParameter("right_door", ent.fdoorstate)
			end
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelPosFL = Vector(84, 37.5, 10),
		CustomWheelPosFR = Vector(84, -37.5, 10),
		CustomWheelPosRL = Vector(-72.5, 44, 10),
		CustomWheelPosRR = Vector(-72.5, -44, 10),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 20),
		CustomSteerAngle = 30,
		SeatOffset = Vector(48, -19, 64),
		SeatPitch = -4,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(52, -18, 37),
				ang = Angle(0, -90, 17)
			},
			{
				pos = Vector(-110, 45, 48),
				ang = Angle(0, 180, 0),
				nosound = true
			},
			{
				pos = Vector(-110, -45, 48),
				ang = Angle(0, 0, 0),
				nosound = true
			},
		},
		SitChangeBlock = {
			[0] = true,
			[1] = true,
		},
		ExitPoint = Vector(-200, 0, 35),
		ExitCheck = 70,
		ExitIgnore = {
			[0] = true,
			[1] = true,
		},
		ExhaustPositions = {
			{
				pos = Vector(-148, -31, 14),
				ang = Angle(90, 180, 0),
			},
			{
				pos = Vector(-148, -31, 14),
				ang = Angle(90, 180, 0),
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
		TurnSpeed = 3,
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		Trunk = 0,
		LimitRPM = 5000,
		PeakTorque = 120,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-100, 56, 37.6),
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
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		DifferentialGear = 0.5,
		Gears = {-0.13, 0, 0.095, 0.15, 0.23, 0.4, 0.7}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_ambulance", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(112, 31.8, 42.8),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(112, -31.8, 42.8),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-152.4, 44.1, 27.8),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-152.4, -44.1, 27.8),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(112, 31.8, 42.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(112, -31.8, 42.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(57, 0, 90.5),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(57, 12.8, 90),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(57, -12.8, 90),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(31.6, 45.5, 104.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(31.6, -45.5, 104.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(20.9, 57, 104.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(20.9, -57, 104.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(112, 31.8, 42.8),
			size = 100,
		},
		{
			pos = Vector(112, -31.8, 42.8),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-152.4, 44.1, 27.8),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-152.4, -44.1, 27.8),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-140.2, 57, 104.2),
			size = 20,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-140.2, -57, 104.2),
			size = 20,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-149.7, 42.6, 104.2),
			size = 20,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-149.7, -42.6, 104.2),
			size = 20,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-149.7, 4.4, 104.2),
			size = 20,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-149.7, -4.4, 104.2),
			size = 20,
			color = Color(255, 178, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-152.4, 44.1, 27.8),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-152.4, -44.1, 27.8),
			size = 60,
			color = Color(255, 0, 0, 150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-152.4, 46.4, 27.8),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-152.4, -46.4, 27.8),
			size = 60,
			color = Color(255, 255, 255, 150),
		}
	},
	ems_sounds = {"left4dead/vehicles/van_ambulance_wail.wav", "left4dead/vehicles/van_ambulance_hilo.wav"},
	ems_sprites = {
		{
			pos = Vector(44.5, 19, 100),
			size = 180,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0),},
			Speed = 0.30
		},
		{
			pos = Vector(44.5, -19, 100),
			size = 180,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.30
		},
		{
			pos = Vector(45.5, 26.4, 93.5),
			size = 60,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0),},
			Speed = 0.07
		},
		{
			pos = Vector(45.5, -3.4, 93.5),
			size = 60,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0),},
			Speed = 0.07
		},
		{
			pos = Vector(45.5, -26.4, 93.5),
			size = 60,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.07
		},
		{
			pos = Vector(45.5, 3.4, 93.5),
			size = 60,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.07
		},
		{
			pos = Vector(32, 45.4, 97.2),
			size = 80,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.05
		},
		{
			pos = Vector(32, -45.4, 97.2),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.05
		},
		{
			pos = Vector(-150, 42.4, 89.7),
			size = 80,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.07
		},
		{
			pos = Vector(-150, -42.4, 89.7),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.07
		},
		{
			pos = Vector(-140, 57.8, 96.8),
			size = 80,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0),},
			Speed = 0.15
		},
		{
			pos = Vector(21, 57.8, 96.8),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.15
		},
		{
			pos = Vector(-140, -57.8, 96.8),
			size = 80,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0),},
			Speed = 0.15
		},
		{
			pos = Vector(21, -57.8, 96.8),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.15
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(111, 32, 35),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(104, 44.5, 42.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-152.4, 49, 27.8),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(111, -32, 35),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(104, -44.5, 42.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-152.4, -49, 27.8),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[6] = "",
			},
			Brake = {
				[5] = "",
				[6] = "",
			},
			Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "ambulance", light_table)