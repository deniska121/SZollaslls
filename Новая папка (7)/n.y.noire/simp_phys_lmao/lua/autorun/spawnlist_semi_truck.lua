--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_semi_truck.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Semi Truck",
	Model = "models/left4dead/vehicles/semi_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 5650,
		EnginePos = Vector(184, 0, 62),
		LightsTable = "semi_truck",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "semi")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1)
			REN.L4D2HandleTrailer(ent)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		Trailers = {
			outputPos = Vector(-110, 0, 50),
			outputType = "axis",
		},
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		CustomWheelPosFL = Vector(156.5, 39, 24),
		CustomWheelPosFR = Vector(156.5, -39, 24),
		CustomWheelPosRL = Vector(-135.2, 39, 30),
		CustomWheelPosML = Vector(-77.8, 39, 30),
		CustomWheelPosMR = Vector(-77.8, -39, 30),
		CustomWheelPosRR = Vector(-135.2, -39, 30),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(20, 0, -20),
		LPMountFront = Vector(187.6, 0, 24),
		LPMountRear = Vector(-174, 0, 32),
		LPGroup = Plates_L4D,
		Trunk = 0,
		CustomSteerAngle = 35,
		SeatOffset = Vector(52, -20, 110),
		SeatPitch = 10,
		SeatYaw = 90,
		EnterDist = 7800,
		ExitCheck = 70,
		ExhaustPositions = {
			{
				pos = Vector(59, 45, 158.4),
				ang = Angle(-90, 0, 0),
			},
			{
				pos = Vector(59, 45, 158.4),
				ang = Angle(-90, 0, 0),
			},
			{
				pos = Vector(59, -45, 158.4),
				ang = Angle(-90, 0, 0),
			},
			{
				pos = Vector(59, -45, 158.4),
				ang = Angle(-90, 0, 0),
			},
		},
		PassengerSeats = {
			{
				pos = Vector(72, -20, 67),
				ang = Angle(0, -90, 0)
			},
		},
		FrontHeight = 16,
		FrontConstant = 50000,
		FrontDamping = 3200,
		FrontRelativeDamping = 50,
		RearHeight = 16,
		RearConstant = 50000,
		RearDamping = 3200,
		RearRelativeDamping = 50,
		TurnSpeed = 3,
		MaxGrip = 120,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		BulletProofTires = false,
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 155,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(21.5, -49, 35.4),
		FuelType = 2,
		FuelTankSize = 130,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/semi_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/semi_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/semi_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/semi_throttle.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/semi_horn.wav",
		DifferentialGear = 0.1,
		Gears = {-0.35, 0, 0.15, 0.22, 0.29, 0.37, 0.49, 0.6, 0.79, 1, 1.5, 2.1, 3}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_semi_truck", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(183.7, 28.6, 46.5),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(183.7, -28.6, 46.5),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-174.5, 17.5, 23.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-174.5, -17.5, 23.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(183.7, 35.5, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(183.7, -35.5, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(183.7, 28.6, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(183.7, -28.6, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(54.9, 47, 44.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(54.9, -47, 44.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(99, -29.3, 115.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(99, 29.3, 115.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(99, 8.3, 115.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(99, -8.3, 115.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(99, 0, 115.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(100.3, 38.3, 45.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(86.6, 39.4, 44.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(73.1, 40.3, 44.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(45, 46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(30, 46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(15.8, 46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(0, 46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(100.3, -38.3, 45.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(86.6, -39.4, 44.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(73.1, -40.3, 44.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(45, -46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(30, -46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(15.8, -46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(0, -46.7, 44.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(183.7, 28.6, 46.5),
			size = 100,
		},
		{
			pos = Vector(183.7, -28.6, 46.5),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-174.5, 17.5, 23.5),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-174.5, -17.5, 23.5),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(158.7, 43, 58),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(-174.5, 8.7, 23.6),
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(158.7, -43, 58),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-174.5, -8.7, 23.6),
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[7] = "",
			},
			Brake = {
				[4] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "",
				[7] = "",
			},
			Brake_Reverse = {
				[4] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}

list.Set("simfphys_lights", "semi_truck", light_table)

local V2 = {
	Name = "Semi Trailer",
	Model = "models/left4dead/vehicles/semi_trailer.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 1400.0,
		EnginePos = Vector(0, 0, 0),
		LightsTable = "semi_trailer",
		OnSpawn = function(ent)
			ent:Lock()
			ent.supportphys = ents.Create("prop_physics")
			ent.supportphys:SetModel("models/props_phx/construct/metal_tube.mdl")
			ent.supportphys:SetPos(ent:LocalToWorld(Vector(90, 0, 0)))
			ent.supportphys:SetAngles(ent:GetAngles())
			ent.supportphys:SetNoDraw(true)
			ent.supportphys.DoNotDuplicate = true
			ent.supportphys:Spawn()
			constraint.Weld(ent, ent.supportphys, 0, 0, 0, true, true)
		end,
		OnTick = function(ent) end,
		OnDelete = function(ent)
			if IsValid(ent.supportphys) then
				ent.supportphys:Remove()
			end
		end,
		Trailers = {
			inputPos = Vector(221, 0, 50),
			inputType = "axis",
		},
		IsTrailer = true,
		LPMountRear = Vector(-263.7, 0, 23.4),
		LPGroup = Plates_L4D,
		NoDriverSeat = true,
		CustomWheels = true,
		NoEngine = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		CustomWheelPosFL = Vector(-156.5, 40, 22),
		CustomWheelPosFR = Vector(-156.5, -40, 22),
		CustomWheelPosRL = Vector(-212.7, 40, 22),
		CustomWheelPosRR = Vector(-212.7, -40, 22),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(50, 0, 10),
		CustomSteerAngle = 60,
		SeatOffset = Vector(0, 0, 0),
		SeatPitch = 0,
		SeatYaw = 90,
		FrontHeight = 5,
		FrontConstant = 50000,
		FrontDamping = 2000,
		FrontRelativeDamping = 350,
		RearHeight = 5,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 350,
		TurnSpeed = 3,
		MaxGrip = 150,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 40,
		BulletProofTires = false,
		IdleRPM = 0,
		LimitRPM = 0,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(0, 0, 0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 0,
		EngineSoundPreset = -1,
		snd_pitch = 1,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		snd_mid_pitch = 1,
		snd_horn = "common/null.wav",
		DifferentialGear = 0,
		Gears = {-1, 0, 1}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_semi_trailer", V2)

local light_table2 = {
	-- projected texture - rear
	L_RearLampPos = Vector(-266.5, 44.6, 50.8),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-266.5, -44.6, 50.8),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(257, 52, 54.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(257, -52, 54.3),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(264.7, 49.1, 163.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(264.7, -49.1, 163.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(140, 41, 57),
			size = 100,
		},
		{
			pos = Vector(140, -41, 57),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-256.5, 53, 52.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-256.5, -53, 52.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-266.5, 8.3, 49.9),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-266.5, -8.3, 49.9),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-266.5, 44.6, 50.8),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-266.5, -44.6, 50.8),
			size = 50,
			color = Color(255, 0, 0, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		TurnBrakeLeft = {
			{
				pos = Vector(-266.5, 38.4, 50.8),
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-266.5, -38.4, 50.8),
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[1] = "",
			},
			Brake = {
				[2] = "",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
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
	},
}

list.Set("simfphys_lights", "semi_trailer", light_table2)

local V4 = {
	Name = "Box Truck (Small)",
	Model = "models/left4dead/vehicles/truck_nuke.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3000,
		EnginePos = Vector(161, 0, 37),
		LightsTable = "truck_nuke",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "truck_nuke")
			ent.trunklist = {}
			ent.lockedt = true
			ent.nextPress = 0
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1)
			local ply = ent:GetDriver()
			if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

			if (ent.PressedKeys and ent.PressedKeys["Lock"]) and ent.nextPress < CurTime() then
				ent.lockedt = not ent.lockedt
				ent.nextPress = CurTime() + 5
				ent:EmitSound(ent.lockedt and "doors/door_metal_large_close2.wav" or "doors/door_metal_gate_move1.wav")
				ent:SetBodygroup(1, ent.lockedt and 0 or 1)

				if ent.lockedt then
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-143, -55, 39)), ent:LocalToWorld(Vector(60, 55, 150)))) do
						REN.TrunkPareEnt(ent, v)
					end
				else
					for _, v in pairs(ent.trunklist) do
						if not IsValid(v) then continue end
						v:SetParent(nil)
						v:PhysicsInit(SOLID_VPHYSICS)

						if IsValid(v:GetPhysicsObject()) then
							v:GetPhysicsObject():EnableMotion(true)
						end

						v:SetPos(v:GetPos())
						v.Draged = nil
					end

					ent.trunklist = {}
				end
			end
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountFront = Vector(167.9, 0, 25),
		LPMountRear = Vector(-159.6, 50, 37),
		brokenglass = "bus_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_nuke_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_truck_nuke_rear.mdl",
		CustomWheelPosFL = Vector(112.6, 36.6, 23),
		CustomWheelPosFR = Vector(112.6, -36.6, 23),
		CustomWheelPosRL = Vector(-64.4, 41.6, 23),
		CustomWheelPosRR = Vector(-64.4, -41.6, 23),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		Trunk = 0,
		CustomSteerAngle = 30,
		SeatOffset = Vector(94, -24, 95),
		SeatPitch = 10,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(110, -25, 45),
				ang = Angle(0, -90, 0)
			},
			{
				pos = Vector(110, -2, 45),
				ang = Angle(0, -90, 0)
			},
		},
		FrontHeight = 16,
		ExitCheck = 70,
		FrontConstant = 35000,
		FrontDamping = 2400,
		FrontRelativeDamping = 50,
		RearHeight = 16,
		RearConstant = 35000,
		RearDamping = 2400,
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
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(83, 23, 30),
		FuelType = 2,
		FuelTankSize = 100,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/truck_nuke_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/truck_nuke_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/truck_nuke_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/truck_nuke_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/truck_nuke_horn.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		DifferentialGear = 0.3,
		Gears = {-0.13, 0, 0.06, 0.15, 0.23, 0.4, 0.6}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_truck_nuke", V4)

local light_table4 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(159, 35, 35),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(159, -35, 35),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-148, 54.7, 48.1),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-148, -54.7, 48.1),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(159, 35, 35),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(159, -35, 35),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(76, 54.7, 140.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(76, -54.7, 140.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(68.8, 57.7, 47.8),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(68.8, -57.7, 47.8),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(159, 27, 35),
			size = 100,
		},
		{
			pos = Vector(159, -27, 35),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-148, 54.7, 48.1),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-148, -54.7, 48.1),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-140.2, 57.7, 47.8),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-140.2, -57.7, 47.8),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-146.9, 52.6, 154.4),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-146.9, -52.6, 154.4),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-148, 54.7, 48.1),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-148, -54.7, 48.1),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(157, 42, 39.6),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(157, -42, 39.6),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[3] = "",
				[2] = "",
			},
			Brake = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Reverse = {
				[1] = "",
				[3] = "",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "truck_nuke", light_table4)