--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_apcat.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Catering Truck",
	Model = "models/left4dead/vehicles/apcat.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3500,
		EnginePos = Vector(177, 0, 53),
		LightsTable = "apcat",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "apcat")
			ent.trunklist = {}
			ent.lockedt = true
			ent.nextPress = 0
		end,
		LPMountFront = Vector(183, 0, 30),
		LPMountRear = Vector(-183.5, 51, 39),
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
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-165, -55, 50)), ent:LocalToWorld(Vector(30, 55, 150)))) do
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
			REN.L4D2Delete(ent)
		end,
		brokenglass = "bus_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_apcat_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_apcat_rear.mdl",
		CustomWheelPosFL = Vector(143, 43, 25),
		CustomWheelPosFR = Vector(143, -43, 25),
		CustomWheelPosRL = Vector(-87, 47, 25),
		CustomWheelPosRR = Vector(-87, -47, 25),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(60, -21, 91),
		SeatPitch = 10,
		SeatYaw = 90,
		ModelInfo = {
			Skin = 1,
		},
		PassengerSeats = {
			{
				pos = Vector(80, -22, 47),
				ang = Angle(0, -90, 0)
			},
		},
		ExitCheck = 70,
		FrontHeight = 16,
		FrontConstant = 38000,
		FrontDamping = 2400,
		FrontRelativeDamping = 50,
		RearHeight = 16,
		RearConstant = 38000,
		RearDamping = 2400,
		RearRelativeDamping = 50,
		TurnSpeed = 3,
		MaxGrip = 100,
		Trunk = 0,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		BulletProofTires = false,
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 110,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		FuelFillPos = Vector(50, 43, 43),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = -1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/apcat_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/apcat_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/apcat_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/apcat_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/apcat_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_bloweroff = "common/null.wav",
		DifferentialGear = 0.3,
		Gears = {-0.13, 0, 0.06, 0.15, 0.23, 0.4, 0.6}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_apcat", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(168, 44, 44),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(168, -44, 44),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-171.6, 56, 58.4),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-171.6, -56, 58.4),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(168, 44, 44),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(168, -44, 44),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(43.9, 56, 155.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(43.9, -56, 155.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(36.7, 58.9, 58.1),
			size = 40,
			color = Color(255, 100, 0, 150),
		},
		{
			pos = Vector(36.7, -58.9, 58.1),
			size = 40,
			color = Color(255, 100, 0, 150),
		},
		{
			pos = Vector(21.9, 57.7, 169.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(21.9, -57.7, 169.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(168, 44, 44),
			size = 100,
		},
		{
			pos = Vector(168, -44, 44),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-171.6, 56, 58.4),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-171.6, -56, 58.4),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-165.5, 57.7, 169.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-165.5, -57.7, 169.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-164, 59, 58),
			size = 40,
			color = Color(255, 100, 0, 150),
		},
		{
			pos = Vector(-164, -59, 58),
			size = 40,
			color = Color(255, 100, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-171.6, 56, 58.4),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-171.6, -56, 58.4),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(175, 25.7, 37.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(158.5, 47.2, 59.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-171.6, 56, 58.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(175, -25.7, 37.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(158.5, -47.2, 59.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-171.6, -56, 58.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[4] = "",
			},
			Brake = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
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

list.Set("simfphys_lights", "apcat", light_table)

local V2 = {
	Name = "Box Truck (Medium)",
	Model = "models/left4dead/vehicles/apcat2.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Промышленные",
	SpawnOffset = Vector(0, 0, 10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3500,
		EnginePos = Vector(177, 0, 53),
		LightsTable = "apcat2",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "apcat")
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
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-165, -55, 50)), ent:LocalToWorld(Vector(30, 55, 150)))) do
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
		LPMountFront = Vector(183, 0, 30),
		LPMountRear = Vector(-187.5, 51, 43),
		brokenglass = "bus_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_apcat_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_apcat_rear.mdl",
		CustomWheelPosFL = Vector(143, 43, 25),
		CustomWheelPosFR = Vector(143, -43, 25),
		CustomWheelPosRL = Vector(-87, 47, 25),
		CustomWheelPosRR = Vector(-87, -47, 25),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(60, -21, 91),
		SeatPitch = 10,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(80, -22, 47),
				ang = Angle(0, -90, 0)
			},
		},
		FrontHeight = 16,
		ExitCheck = 70,
		FrontConstant = 38000,
		FrontDamping = 2400,
		FrontRelativeDamping = 50,
		RearHeight = 16,
		RearConstant = 38000,
		RearDamping = 2400,
		RearRelativeDamping = 50,
		Trunk = 0,
		TurnSpeed = 3,
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		BulletProofTires = false,
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 110,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		FuelFillPos = Vector(50, 43, 43),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/apcat_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/apcat_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/apcat_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/apcat_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/apcat_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_bloweroff = "common/null.wav",
		DifferentialGear = 0.3,
		Gears = {-0.13, 0, 0.06, 0.15, 0.23, 0.4, 0.6}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_apcat2", V2)

local light_table2 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(168, 44, 44),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(168, -44, 44),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-175, 55, 57),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-175, -55, 57),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(168, 44, 44),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(168, -44, 44),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(48.5, 54.9, 149),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(48.5, -54.9, 149),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(41.2, 57.4, 56.6),
			size = 40,
			color = Color(255, 100, 0, 150),
		},
		{
			pos = Vector(41.2, -57.4, 56.6),
			size = 40,
			color = Color(255, 100, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(168, 44, 44),
			size = 100,
		},
		{
			pos = Vector(168, -44, 44),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-175, 55, 57),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-175, -55, 57),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-169, 56.2, 163.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-169, -56.2, 163.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-174.1, 52.2, 163.2),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-174.1, -52.2, 163.2),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-167.5, 57.5, 57),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-167.5, -57.5, 57),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-175, 55, 57),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-175, -55, 57),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(175, 25.7, 37.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(158.5, 47.2, 59.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-175, 55, 57),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(175, -25.7, 37.4),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(158.5, -47.2, 59.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-175, -55, 57),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[4] = "",
			},
			Brake = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[5] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
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

list.Set("simfphys_lights", "apcat2", light_table2)

local V3 = {
	Name = "Baggage Cart",
	Model = "models/left4dead/vehicles/apcart.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			inputPos = Vector(66.3, 0, 23),
			inputType = "ballsocket",
			outputPos = Vector(-66.7, 0, 23),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 1400.0,
		EnginePos = Vector(0, 0, 0),
		OnSpawn = function(ent)
			ent:Lock()
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/apcart_wheel.mdl",
		CustomWheelPosFL = Vector(38, 31.5, 8),
		CustomWheelPosFR = Vector(38, -31.5, 8),
		CustomWheelPosRL = Vector(-38, 31.5, 8),
		CustomWheelPosRR = Vector(-38, -31.5, 8),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 10),
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
		Trunk = 0,
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
		snd_mid_pitch = 1,
		snd_horn = "common/null.wav",
		DifferentialGear = 0,
		Gears = {-1, 0, 1}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_apcart", V3)

local V4 = {
	Name = "Baggage Tractor",
	Model = "models/left4dead/vehicles/apbag.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Другое",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-67.8, 0, 23),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 1200,
		EnginePos = Vector(65, 0, 31),
		LightsTable = "apbag",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_apbag_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_apbag_rear.mdl",
		CustomWheelPosFL = Vector(42, 24, 12),
		CustomWheelPosFR = Vector(42, -24, 12),
		CustomWheelPosRL = Vector(-27, 24, 17),
		CustomWheelPosRR = Vector(-27, -24, 17),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "apbag")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		FrontWheelRadius = 9,
		RearWheelRadius = 15,
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-45, -17, 60),
		SeatPitch = 15,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(-25, -16, 37),
				ang = Angle(0, -90, 10)
			},
		},
		FrontHeight = 8,
		Trunk = 10,
		FrontConstant = 34000,
		FrontDamping = 1000,
		FrontRelativeDamping = 800,
		RearHeight = 8,
		RearConstant = 34000,
		RearDamping = 1000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1,
		BrakePower = 35,
		IdleRPM = 700,
		LimitRPM = 3500,
		PeakTorque = 25,
		PowerbandStart = 1200,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(18, 18, 36),
		FuelType = 1,
		FuelTankSize = 45,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/apbag_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/apbag_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/apbag_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/apbag_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 0.7,
		--
		snd_horn = "left4dead/vehicles/apbag_horn.wav",
		DifferentialGear = 0.12,
		Gears = {-0.3, 0, 0.15, 0.32, 0.66}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_apbag", V4)

local light_table3 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(59, 20.2, 31.8),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(59, -20.2, 31.8),
	R_HeadLampAng = Angle(0, 0, 0),
	L_RearLampPos = Vector(-46, 24.3, 31.6),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-46, -24.3, 31.6),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(59, 20.2, 31.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(59, -20.2, 31.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(59, 20.2, 31.8),
			size = 100,
		},
		{
			pos = Vector(59, -20.2, 31.8),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-46, 24.3, 31.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-46, -24.3, 31.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-46, 17.7, 31.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-46, -17.7, 31.6),
			size = 70,
			color = Color(255, 0, 0, 150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-46, 21.2, 31.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-46, -21.2, 31.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[2] = "",
				[3] = "",
			},
			Brake = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[1] = "",
				[2] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "",
			},
			Brake = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	},
}

list.Set("simfphys_lights", "apbag", light_table3)