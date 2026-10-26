--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_utility_truck.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Utility Truck",
	Model = "models/left4dead/vehicles/utility_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2700,
		EnginePos = Vector(100, 0, 33),
		LightsTable = "utility_truck",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_utility_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_utility_truck_rear.mdl",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "utility_truck")
			ent.trunklist = {}
			ent.lockedt = false
			ent.nextPress = 0
		end,
		LPMountRear = Vector(-100.9, 18.8, 25),
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
			local ply = ent:GetDriver()
			if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

			if (ent.PressedKeys and ent.PressedKeys["Lock"]) and ent.nextPress < CurTime() then
				ent.lockedt = not ent.lockedt
				ent.nextPress = CurTime() + 5
				ent:EmitSound(ent.lockedt and "vehicles/atv_ammo_open.wav" or "vehicles/atv_ammo_close.wav")

				if ent.lockedt then
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-98, 34, 35)), ent:LocalToWorld(Vector(27, -34, 44)))) do
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
		CustomWheelPosFL = Vector(72, 34, 13),
		CustomWheelPosFR = Vector(72, -34, 13),
		CustomWheelPosRL = Vector(-49, 41, 13),
		CustomWheelPosRR = Vector(-49, -41, 13),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		Trunk = 13,
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(7, -20, 55),
		SeatPitch = 5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(18, -18, 22),
				ang = Angle(0, -90, 10)
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-100, 28, 15),
				ang = Angle(140, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 35000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 35000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 150,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-18, 45, 27),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/utility_truck_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/utility_truck_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/utility_truck_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/utility_truck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/utility_truck_horn.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		DifferentialGear = 0.37,
		Gears = {-0.14, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_utility_truck", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(98.3, 27.1, 32.8),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(98.3, -27.1, 32.8),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-101.1, 40.4, 24.9),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-101.1, -40.4, 24.9),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(98.3, 27.1, 32.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(98.3, -27.1, 32.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(98.3, 27.1, 32.8),
			size = 100,
		},
		{
			pos = Vector(98.3, -27.1, 32.8),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-101.1, 40.4, 24.9),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-101.1, -40.4, 24.9),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(98.1, 34.8, 32.8),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(101.9, 27.4, 24.9),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(-101.1, 33.7, 24.9),
				size = 100,
				color = Color(255, 0, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(98.1, -34.8, 32.8),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(101.9, -27.4, 24.9),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-101.1, -33.7, 24.9),
				size = 100,
				color = Color(255, 0, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[6] = "",
			},
			Brake = {
				[4] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[4] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	},
}

list.Set("simfphys_lights", "utility_truck", light_table)

V = {
	Name = "Эвакуатор",
	Model = "models/left4dead/vehicles/pickup_towe.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-147.5, 0, 31.5),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 3250,
		EnginePos = Vector(116, 0, 42),
		EnterDist = 5800,
		LightsTable = "pickup_tow",
		CustomWheels = true,
		BulletProofTires = true,
		CustomSuspensionTravel = 0.1,
		OnSpawn = function(ent)
			ent:SetBodyGroups("0" .. math.random(0, 3))
			REN.L4D2SimfphysInit(ent, "pickup") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
			REN.L4D2HandleTow(ent)
			if not IsValid(ent) then return end
			local ply = ent:GetDriver()
			if not IsValid(ply) then return end
			if not ply:IsPlayer() or ply:Team() ~= 12 then return end

			if (ent.PressedKeys and ent.PressedKeys["Lock"]) then
				REN.L4D2SimfphysAttachToCar(ent, ply)
			end
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountFront = Vector(125.01, 0, 33.67),
		LPMountRear = Vector(-132.26, 25, 33.04),
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_4x4.mdl",
		CustomWheelPosFL = Vector(85, 43, 13),
		CustomWheelPosFR = Vector(85, -43, 13),
		CustomWheelPosRL = Vector(-74, 43, 13),
		CustomWheelPosRR = Vector(-74, -43, 13),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(0, -24, 80),
		SeatPitch = 5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(18, -22, 46),
				ang = Angle(0, -90, 10)
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-125, 24, 29),
				ang = Angle(140, 180, 0),
			},
		},
		FrontHeight = 5,
		FrontConstant = 24000,
		FrontDamping = 2000,
		FrontRelativeDamping = 25,
		RearHeight = 5,
		RearConstant = 24000,
		RearDamping = 2000,
		RearRelativeDamping = 25,
		Trunk = 0,
		TurnSpeed = 3,
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 60,
		IdleRPM = 800,
		LimitRPM = 4000,
		PeakTorque = 230,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-29, -47, 59),
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
		--
		snd_horn = "left4dead/vehicles/pickup_horn.wav",
		DifferentialGear = 0.4,
		Gears = {-0.14, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_pickup_tow", V)
local emsc = Color(255, 135, 66, 255)

light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(113, 36, 56),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(113, -36, 56),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-172, 44, 50),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-172, -44, 50),
	R_RearLampAng = Angle(25, 180, 0),
	ems_sounds = {"common/null.wav"},
	ems_sprites = {
		{
			pos = Vector(-17, 37, 107),
			size = 90,
			Colors = {emsc, color_transparent, emsc, color_transparent, emsc, color_transparent, emsc, color_transparent, color_transparent, color_transparent, color_transparent, color_transparent},
			Speed = 0.05
		},
		{
			pos = Vector(-17, -37, 107),
			size = 90,
			Colors = {emsc, color_transparent, emsc, color_transparent, emsc, color_transparent, emsc, color_transparent, color_transparent, color_transparent, color_transparent, color_transparent},
			Speed = 0.05
		},
	},
	Headlight_sprites = {
		{
			pos = Vector(113, 36, 56),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(113, -36, 56),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(113, 32, 56),
			size = 100,
		},
		{
			pos = Vector(113, -32, 56),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-128, 44, 60),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-128, -44, 60),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-128, 44, 54),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-128, -44, 54),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(113, 37, 47),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(113, 30, 47),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-128, 44, 48),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(113, -37, 47),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(113, -30, 47),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-128, -44, 48),
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
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[5] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
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
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
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

list.Set("simfphys_lights", "pickup_tow", light_table)

V = {
	Name = "Мусоровоз",
	Model = "models/left4dead/vehicles/trash_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 180,
	Members = {
		Mass = 6000,
		EnginePos = Vector(5.61, -146.64, 85.1),
		LightsTable = "trash_truck",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_truck_rear.mdl",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "semi") --name of car "ent", name of the audio bank
			ent:SetColor(Color(63, 67, 49))
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		LPMountFront = Vector(0, -187.79, 24.75),
		LPRotateFront = Angle(0, -90, 0),
		LPMountRear = Vector(-31.52, 237.2, 44.83),
		LPRotateRear = Angle(0, -90, 0),
		CustomWheelPosFL = Vector(39, -156.5, 27),
		CustomWheelPosFR = Vector(-39, -156.5, 27),
		CustomWheelPosRL = Vector(39, 135.2, 30),
		CustomWheelPosML = Vector(39, 77.8, 30),
		CustomWheelPosMR = Vector(-39, 77.8, 30),
		CustomWheelPosRR = Vector(-39, 135.2, 30),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		Trunk = 0,
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 35,
		SeatOffset = Vector(59, -20, 110),
		SeatPitch = 10,
		SeatYaw = 180,
		ExitCheck = 110,
		EnterDist = 9800,
		ExhaustPositions = {
			{
				pos = Vector(45.32, -59.24, 158.46),
				ang = Angle(45, 90, 0),
			},
			{
				pos = Vector(45.32, -59.24, 158.46),
				ang = Angle(45, 90, 0),
			},
			{
				pos = Vector(-45.22, -59.24, 158.8),
				ang = Angle(45, 90, 0),
			},
			{
				pos = Vector(-45.22, -59.24, 158.8),
				ang = Angle(45, 90, 0),
			},
		},
		PassengerSeats = {
			{
				pos = Vector(-20, -78, 67),
				ang = Angle(0, -180, 0)
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
		PeakTorque = 100,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(43.84, -22.94, 40.58),
		FuelType = 2,
		FuelTankSize = 130,
		PowerBias = 0,
		EngineSoundPreset = 0,
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
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
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/semi_horn.wav",
		DifferentialGear = 0.1,
		Gears = {-0.35, 0, 0.15, 0.22, 0.29, 0.37, 0.49, 0.6, 0.79, 1, 1.5, 2.1, 3}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_trash_truck", V)

light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(28.6, -183.7, 46.5),
	L_HeadLampAng = Angle(0, -90, 0),
	R_HeadLampPos = Vector(-28.6, -183.7, 46.5),
	R_HeadLampAng = Angle(0, -90, 0),
	Headlight_sprites = {
		{
			pos = Vector(35.5, -183.7, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(-35.5, -183.7, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(28.6, -183.7, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(-28.6, -183.7, 46.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(-29.3, -99, 115.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(29.3, -99, 115.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(38.3, -100.3, 45.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(39.4, -86.6, 44.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(40.3, -73.1, 44.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-38.3, -100.3, 45.1),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-39.4, -86.6, 44.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-40.3, -73.1, 44.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(28.6, -183.7, 46.5),
			size = 100,
		},
		{
			pos = Vector(-28.6, -183.7, 46.5),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(17, 179, 117.79),
			size = 90,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-17, 179, 117.79),
			size = 90,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(43, -158.7, 58),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(42, 190, 40),
				size = 120,
				color = Color(255, 136, 0, 150),
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(8.3, 179, 119),
				size = 50,
				color = Color(255, 0, 0, 255),
			},
		},
		Right = {
			{
				pos = Vector(-43, -158.7, 58),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-42, 190, 40),
				size = 120,
				color = Color(255, 136, 0, 150),
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-8.3, 179, 119),
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

list.Set("simfphys_lights", "trash_truck", light_table)

local function Approach(Target, ent)
	local now = CurTime()
	local timepassed = now - ent.LastThink
	ent.LastThink = now
	ent.fdoorstate = math.Approach(ent.fdoorstate, Target, timepassed)
end

V = {
	Name = "Maintenance Truck",
	Model = "models/left4dead/vehicles/utility_truck_m.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, -10),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-102.9, 0, 18),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 2700,
		EnginePos = Vector(100, 0, 33),
		LightsTable = "utility_truck_m",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_utility_truck_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_utility_truck_rear.mdl",
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorstate = 1
			ent.LastThink = 0
			REN.L4D2SimfphysInit(ent, "utility_truck")
			ent.trunklist = {}
			ent.lockedt = false
			ent.nextPress = 0
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1)
			local ply = ent:GetDriver()
			if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

			if (ent.PressedKeys and ent.PressedKeys["Lock"]) and ent.nextPress < CurTime() then
				ent.lockedt = not ent.lockedt
				ent.nextPress = CurTime() + 5
				ent:EmitSound(ent.lockedt and "vehicles/atv_ammo_open.wav" or "vehicles/atv_ammo_close.wav")

				if ent.lockedt then
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-98, 34, 35)), ent:LocalToWorld(Vector(27, -34, 44)))) do
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

			if not ent.fdoorMoving and (ent.PressedKeys and ent.PressedKeys["Lock"]) then
				ent.fdoorMoving = true
				ent.fdoorstate = ent.fdoornum == 0 and 0 or 1
				ent.fdoornum = ent.fdoornum == 0 and 1 or 0
				ent.LastThink = CurTime()

				timer.Simple(2, function()
					if not IsValid(ent) then return end
					ent.fdoorMoving = nil
				end)
			end

			if ent.fdoorMoving then
				if ent.fdoorstate > 0.9 then
					ent:SetBodygroup(1, 1)
				else
					ent:SetBodygroup(1, 0)
				end

				Approach(ent.fdoornum, ent)
				ent:SetPoseParameter("rear_sign", ent.fdoorstate)
			end
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelPosFL = Vector(72, 34, 13),
		CustomWheelPosFR = Vector(72, -34, 13),
		CustomWheelPosRL = Vector(-49, 41, 13),
		CustomWheelPosRR = Vector(-49, -41, 13),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(7, -20, 55),
		SeatPitch = 5,
		SeatYaw = 90,
		LPMountRear = Vector(-100.9, 18.8, 25),
		LPGroup = Plates_L4D,
		PassengerSeats = {
			{
				pos = Vector(18, -18, 22),
				ang = Angle(0, -90, 10)
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-100, 28, 15),
				ang = Angle(140, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 35000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		Trunk = 13,
		RearConstant = 35000,
		RearDamping = 2500,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		MaxGrip = 54,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 150,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-18, 45, 27),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/utility_truck_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/utility_truck_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/utility_truck_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/utility_truck_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/utility_truck_horn.wav",
		DifferentialGear = 0.37,
		Gears = {-0.14, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_utility_truck_m", V)

light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(98.3, 27.1, 32.8),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(98.3, -27.1, 32.8),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-101.1, 40.4, 24.9),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-101.1, -40.4, 24.9),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(98.3, 27.1, 32.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(98.3, -27.1, 32.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(98.3, 27.1, 32.8),
			size = 100,
		},
		{
			pos = Vector(98.3, -27.1, 32.8),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-101.1, 40.4, 24.9),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-101.1, -40.4, 24.9),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(98.1, 34.8, 32.8),
				size = 50,
				color = Color(255, 136, 0, 150),
				OnBodyGroups = {
					[1] = {0},
				}
			},
			{
				pos = Vector(101.9, 27.4, 24.9),
				size = 50,
				color = Color(255, 136, 0, 150),
				OnBodyGroups = {
					[1] = {0},
				}
			},
			--SIGN
			{
				pos = Vector(-101, 39, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 34, 103),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 29, 111),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 34, 86),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 29, 78),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 21.4, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 4.4, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -12.6, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -29.8, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
		},
		TurnBrakeLeft = {
			{
				pos = Vector(-101.1, 33.7, 24.9),
				size = 100,
				color = Color(255, 0, 0, 150),
				OnBodyGroups = {
					[1] = {0},
				}
			},
		},
		Right = {
			{
				pos = Vector(98.1, -34.8, 32.8),
				size = 50,
				color = Color(255, 136, 0, 150),
				OnBodyGroups = {
					[1] = {0},
				}
			},
			{
				pos = Vector(101.9, -27.4, 24.9),
				size = 50,
				color = Color(255, 136, 0, 150),
				OnBodyGroups = {
					[1] = {0},
				}
			},
			--SIGN
			{
				pos = Vector(-101, -39, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -34, 103),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -29, 111),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -34, 86),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -29, 78),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -21.4, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, -4.4, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 12.6, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
			{
				pos = Vector(-101, 29.8, 94),
				size = 50,
				color = Color(255, 155, 0, 100),
				OnBodyGroups = {
					[1] = {1},
				}
			},
		},
		TurnBrakeRight = {
			{
				pos = Vector(-101.1, -33.7, 24.9),
				size = 100,
				color = Color(255, 0, 0, 150),
				OnBodyGroups = {
					[1] = {0},
				}
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[4] = "",
			},
			Brake = {
				[3] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
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

list.Set("simfphys_lights", "utility_truck_m", light_table)