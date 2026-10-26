--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_deliveryvan.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "Delivery Van",
	Model = "models/left4dead/vehicles/deliveryvan.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2500,
		EnginePos = Vector(127, 0, 46),
		LightsTable = "deliveryvan",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_dvan_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_dvan_r.mdl",
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "deliveryvan")
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
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-135, -45, 26)), ent:LocalToWorld(Vector(25, 45, 110)))) do
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
		CustomWheelPosFL = Vector(86, 42.8, 10),
		CustomWheelPosFR = Vector(86, -42.8, 10),
		CustomWheelPosRL = Vector(-76.5, 37.5, 10),
		CustomWheelPosRR = Vector(-76.5, -37.5, 10),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		LPMountFront = Vector(132.5, -36, 20),
		LPMountRear = Vector(-145.2, 40, 97),
		Trunk = 0,
		CustomSteerAngle = 30,
		SeatOffset = Vector(45, -26, 78),
		SeatPitch = 0,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(52, -26, 48),
				ang = Angle(0, -90, 10)
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-45.2, -47, 5.4),
				ang = Angle(125, 270, 0),
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
		MaxGrip = 70,
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
		FuelFillPos = Vector(-45, 48, 16.5),
		FuelType = 2,
		FuelTankSize = 110,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/deliveryvan_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/deliveryvan_low.wav",
		Sound_MidPitch = 1.5,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/deliveryvan_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/deliveryvan_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/deliveryvan_horn.wav",
		DifferentialGear = 0.5,
		Gears = {-0.2, 0, 0.075, 0.15, 0.23, 0.35, 0.5}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_deliveryvan", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(112, 31.8, 42.8),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(112, -31.8, 42.8),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-145.2, 42.2, 59.8),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-145.2, -42.2, 59.8),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(126.7, 35.5, 48.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(126.7, -35.5, 48.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(117.7, 48.5, 35.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(117.7, -48.5, 35.2),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(74.5, 35.9, 110),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(74.5, -35.9, 110),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(74.5, 9.8, 110),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(74.5, -9.8, 110),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(74.5, 0, 110),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(126.7, 35.5, 48.8),
			size = 100,
		},
		{
			pos = Vector(126.7, -35.5, 48.8),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-145.2, 42.2, 59.8),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, -42.2, 59.8),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, -41.8, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, 41.8, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, 16, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, -16, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, 6, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, -6, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-136.2, 48, 109.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-136.2, -48, 109.4),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-127.5, 48, 23),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-127.5, -48, 23),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-145.2, 42.2, 59.8),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, 43, 37.8),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, -43, 37.8),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, -41.8, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, 41.8, 110.1),
			size = 40,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.2, -42.2, 59.8),
			size = 60,
			color = Color(255, 0, 0, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(126.7, 35.5, 39.2),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(117.7, 48.5, 41),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.2, 42.2, 48.8),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(126.7, -35.5, 39.2),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(117.7, -48.5, 41),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.2, -42.2, 48.8),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[6] = "",
				[5] = "",
			},
			Brake = {
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[6] = "",
				[5] = ""
			},
			Brake_Reverse = {
				[6] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "deliveryvan", light_table)