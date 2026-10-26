--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_pickup_regcab.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "90 Ford 150",
	Model = "models/left4dead/vehicles/pickup_regcab.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-147.5, 0, 26),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 3000,
		EnginePos = Vector(116, 0, 52),
		LightsTable = "pickup_regcab",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "pickup")
			ent.trunklist = {}
			ent.lockedt = false
			ent.nextPress = 0
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
			local ply = ent:GetDriver()
			if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

			if (ent.PressedKeys and ent.PressedKeys["Lock"]) and ent.nextPress < CurTime() then
				ent.lockedt = not ent.lockedt
				ent.nextPress = CurTime() + 5
				ent:EmitSound(ent.lockedt and "vehicles/atv_ammo_open.wav" or "vehicles/atv_ammo_close.wav")

				if ent.lockedt then
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-125, 40, 27)), ent:LocalToWorld(Vector(-14, -40, 55)))) do
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
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_regcab.mdl",
		CustomWheelPosFL = Vector(85, 43, 13),
		CustomWheelPosFR = Vector(85, -43, 13),
		CustomWheelPosRL = Vector(-74, 43, 13),
		CustomWheelPosRR = Vector(-74, -43, 13),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		Trunk = 0,
		SeatOffset = Vector(0, -24, 70),
		LPMountFront = Vector(118.2, 0, 24.9),
		LPMountRear = Vector(-132.26, 25, 23.88),
		SeatPitch = 5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(18, -22, 36),
				ang = Angle(0, -90, 10)
			},
		},
		ExhaustPositions = {
			{
				pos = Vector(-125, 24, 19),
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
		FuelFillPos = Vector(-29, -47, 49),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = 1,
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
		start_del = 5,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/pickup_horn.wav",
		DifferentialGear = 0.37,
		Gears = {-0.14, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}
list.Set("simfphys_vehicles", "sim_fphys_l4d_pickup_regcab", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(113, 36, 46),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(113, -36, 46),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-172, 44, 50),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-172, -44, 50),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(113, 36, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(113, -36, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(113, 32, 46),
			size = 100,
		},
		{
			pos = Vector(113, -32, 46),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-128, 44, 50),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-128, -44, 50),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-128, 44, 44),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-128, -44, 44),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(113, 37, 37),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(113, 30, 37),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-128, 44, 38),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(113, -37, 37),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(113, -30, 37),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-128, -44, 38),
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
list.Set("simfphys_lights", "pickup_regcab", light_table)