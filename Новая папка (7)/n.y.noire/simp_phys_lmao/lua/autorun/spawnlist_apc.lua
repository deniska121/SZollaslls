--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_apc.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "APC",
	Model = "models/left4dead/vehicles/apc_body.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 5525,
		MaxHealth = 7525,
		EnginePos = Vector(39.7, 77.4, 99.5),
		LightsTable = "apc",
		CustomWheels = true,
		NoAlarmClose = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			ent:SetNW2Int("_direction_", 0)
			ent:SetNW2Int("__SetBuoyancyRatio__", 1)
			ent:SetNW2Bool("_can_swim__", true)
			ent:SetNW2Bool("_isboat", false)
			--local RanCol = Color(math.random(25,100),math.random(25,100),math.random(25,100))
			--ent:SetColor(RanCol)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			ent.fdoorstate = 0
			REN.L4D2SimfphysInit(ent, "apc") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1

			local function dooranim()
				local ply = ent:GetDriver()
				if not IsValid(ent) then return end
				if not IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
				if not ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI

				if (ent.PressedKeys and ent.PressedKeys["Lock"]) and IsValid(ent:GetDriver()) then
					if ent.fdoornum == 0 and not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 1
						ent.fdoorstate = 0
						sound.Play("left4dead/vehicles/apc_rear_open.wav", ent:GetPos())
						ent:PlayAnimation("open")

						--ent.doormdl:SetNotSolid(true)
						timer.Simple(5, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end)
					elseif not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 0
						ent.fdoorstate = 1
						sound.Play("left4dead/vehicles/apc_rear_close.wav", ent:GetPos())
						ent:PlayAnimation("close")

						--ent.doormdl:SetNotSolid(false)
						timer.Simple(3, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end)
					end
				end
			end

			dooranim()
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		IsArmored = true,
		BulletProofTires = true,
		CustomWheelModel = "models/left4dead/vehicles/wheel_apc.mdl",
		CustomWheelPosFL = Vector(89, 70.5, 35),
		CustomWheelPosFR = Vector(89, -70.5, 35),
		CustomWheelPosML = Vector(-10.7, 70.5, 36),
		CustomWheelPosMR = Vector(-10.7, -70.5, 36),
		CustomWheelPosRL = Vector(-106.3, 70.5, 35),
		CustomWheelPosRR = Vector(-106.3, -70.5, 35),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 35,
		SeatOffset = Vector(90, -21, 126),
		SeatPitch = 10,
		SeatYaw = 90,
		ExitCheck = 90,
		EnterDist = 13800,
		ExhaustPositions = {
			{
				pos = Vector(39.7, 75, 106),
				ang = Angle(125, 90, 0),
			},
			{
				pos = Vector(39.7, 79, 94.6),
				ang = Angle(125, 90, 0),
			},
			{
				pos = Vector(39.7, -75, 106),
				ang = Angle(125, -90, 0),
			},
			{
				pos = Vector(39.7, -79, 94.6),
				ang = Angle(125, -90, 0),
			},
		},
		PassengerSeats = {
			{
				pos = Vector(112, -21, 75),
				ang = Angle(0, -90, 0)
			},
			{
				pos = Vector(7.6, -28, 70),
				ang = Angle(0, 0, 0),
				nosound = true
			},
			{
				pos = Vector(7.6, 28, 70),
				ang = Angle(0, 180, 0),
				nosound = true
			},
			{
				pos = Vector(-87.1, 41.2, 70),
				ang = Angle(0, 180, 0),
				nosound = true
			},
			{
				pos = Vector(-87.1, -41.2, 70),
				ang = Angle(0, 0, 0),
				nosound = true
			},
			{
				pos = Vector(-120.8, 41.2, 70),
				ang = Angle(0, 180, 0),
				nosound = true
			},
			{
				pos = Vector(-120.8, -41.2, 70),
				ang = Angle(0, 0, 0),
				nosound = true
			},
		},
		SitChangeBlock = {
			[0] = true,
			[1] = true,
		},
		ExitPoint = Vector(-200, 0, 55),
		ExitIgnore = {
			[0] = true,
			[1] = true,
		},
		Attachments = {
			{
				model = "models/left4dead/vehicles/apc_trim.mdl",
				color = Color(255, 255, 255, 255),
				pos = Vector(0, 0, 0),
				ang = Angle(0, 0, 0)
			},
		},
		FrontHeight = 25,
		Trunk = 300,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 100,
		RearHeight = 25,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 100,
		TurnSpeed = 3,
		MaxGrip = 150,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 100,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(-57.7, -73.8, 52.4),
		FuelType = 2,
		FuelTankSize = 230,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/apc_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/apc_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/apc_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/apc_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		snd_horn = "left4dead/vehicles/hmmwv_horn.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		DifferentialGear = 0.08,
		Gears = {-0.35, 0, 0.16, 0.35, 0.55}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_apc", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(167.1, 66, 65.2),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(167.1, -66, 65.2),
	R_HeadLampAng = Angle(0, 0, 0),
	Headlight_sprites = {
		{
			pos = Vector(167.1, 66, 65.2),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(167.1, -66, 65.2),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(167.1, 66, 65.2),
			size = 100,
		},
		{
			pos = Vector(167.1, -66, 65.2),
			size = 100,
		},
		{
			pos = Vector(133.6, 41, 128),
			size = 150,
		},
		{
			pos = Vector(133.6, 41, 128),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(133.6, -41, 128),
			size = 150,
		},
		{
			pos = Vector(133.6, -41, 128),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(164.8, 69.8, 75.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(164.8, -69.8, 75.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[9] = "",
				[8] = "",
			},
			Brake = {
				[9] = "",
				[8] = "",
			},
			Reverse = {
				[9] = "",
				[8] = "",
			},
			Brake_Reverse = {
				[9] = "",
				[8] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Brake = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Brake_Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
		},
		on_highbeam = {
			Base = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "apc", light_table)

local V2 = {
	Name = "Army Truck",
	Model = "models/left4dead/vehicles/army_truck.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-159, 0, 24.7),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 2525,
		EnginePos = Vector(161, 0, 62),
		LightsTable = "army_truck",
		CustomWheels = true,
		NoAlarmClose = true,
		CustomSuspensionTravel = 1.5,
		EnterDist = 6800,
		OnSpawn = function(ent)
			local RanSkin = math.random(0, 1)
			ent:SetSkin(RanSkin)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent.ChangeRate = 1
			REN.L4D2SimfphysInit(ent, "armytruck") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1

			local function Approach(Target)
				local now = CurTime()
				local timepassed = now - ent.LastThink
				ent.LastThink = now
				ent.fdoorstate = math.Approach(ent.fdoorstate, Target, ent.ChangeRate * timepassed)
			end

			local function dooranim()
				local ply = ent:GetDriver()
				if not IsValid(ent) then return end
				if not IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
				if not ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI

				if (ent.PressedKeys and ent.PressedKeys["Lock"]) and IsValid(ent:GetDriver()) then
					if ent.fdoornum == 0 and not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 1
						ent.fdoorstate = 0
						ent.LastThink = CurTime()
						sound.Play("left4dead/vehicles/ambulance_rear_open.wav", ent:GetPos())

						--ent.doormdl:SetNotSolid(true)
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end)
					elseif not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 0
						ent.fdoorstate = 1
						ent.LastThink = CurTime()
						sound.Play("left4dead/vehicles/ambulance_rear_close.wav", ent:GetPos())

						--ent.doormdl:SetNotSolid(false)
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end)
					end
				end

				if ent.fdoorMoving then
					Approach(ent.fdoornum)
					ent:SetPoseParameter("rear_door", ent.fdoorstate)
				end
			end

			dooranim()
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheel_army_truck.mdl",
		CustomWheelPosFL = Vector(129, 50.2, 28),
		CustomWheelPosFR = Vector(129, -50.2, 28),
		CustomWheelPosRL = Vector(-101.2, 50.2, 30),
		CustomWheelPosML = Vector(-38.7, 50.2, 30),
		CustomWheelPosMR = Vector(-38.7, -50.2, 30),
		CustomWheelPosRR = Vector(-101.2, -50.2, 30),
		Trunk = 300,
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 35,
		SeatOffset = Vector(32, -23, 108),
		SeatPitch = 10,
		SeatYaw = 90,
		ExhaustPositions = {
			{
				pos = Vector(91.5, -56.7, 146.7),
				ang = Angle(-90, 35, 0),
			},
			{
				pos = Vector(91.5, -56.7, 146.7),
				ang = Angle(-90, 35, 0),
			},
		},
		PassengerSeats = {
			{
				pos = Vector(55, -23, 67),
				ang = Angle(0, -90, 0)
			},
		},
		FrontHeight = 16,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 50,
		RearHeight = 16,
		RearConstant = 25000,
		RearDamping = 1000,
		RearRelativeDamping = 50,
		TurnSpeed = 3,
		MaxGrip = 80,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		BulletProofTires = true,
		IdleRPM = 1000,
		LimitRPM = 5000,
		PeakTorque = 65,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = false,
		FuelFillPos = Vector(98, 40.5, 70.3),
		FuelType = 2,
		FuelTankSize = 130,
		PowerBias = -1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/armytruck_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/armytruck_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/armytruck_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/armytruck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/armytruck_horn.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		DifferentialGear = 0.15,
		Gears = {-0.25, 0, 0.08, 0.22, 0.36, 0.44, 0.62}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_army_truck", V2)

local light_table2 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(160.3, 50.4, 58.6),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(160.3, -50.4, 58.6),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-165.7, 42.4, 59.6),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-165.7, -42.4, 59.6),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(160.3, 50.4, 58.6),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(160.3, -50.4, 58.6),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(152.7, -59.8, 62.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(152.7, 59.8, 62.6),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-154.4, -56.3, 57.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-154.4, 56.3, 57.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-163.5, -51.1, 54.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-163.5, 51.1, 54.7),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(14, 53.5, 69),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-144.5, 53.5, 69),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(14, -53.5, 69),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(-144.5, -53.5, 69),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(160.3, 50.4, 58.6),
			size = 100,
		},
		{
			pos = Vector(160.3, -50.4, 58.6),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-165.7, 42.4, 59.6),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-165.7, -42.4, 59.6),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-165.7, 42.4, 59.6),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-165.7, -42.4, 59.6),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(159.3, 51, 72),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-158.3, 35.2, 46.7),
				size = 50,
				color = Color(255, 135, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(159.3, -51, 72),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-158.3, -35.2, 46.7),
				size = 50,
				color = Color(255, 135, 0, 150),
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
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "army_truck", light_table2)

local V5 = {
	Name = "A.R.V.",
	Model = "models/left4dead/vehicles/swat.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, -10),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 3500,
		EnginePos = Vector(130, 0, 50),
		LightsTable = "swat",
		IsArmored = true,
		NoAlarmClose = true,
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		CustomWheelModel = "models/left4dead/vehicles/wheel_swat_front.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_swat_rear.mdl",
		CustomWheelPosFL = Vector(92, 48, 20),
		CustomWheelPosFR = Vector(92, -48, 20),
		CustomWheelPosRL = Vector(-87, 48, 20),
		CustomWheelPosRR = Vector(-87, -48, 20),
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 12),
		CustomSteerAngle = 30,
		SeatOffset = Vector(20, -33, 95),
		SeatPitch = 10,
		SeatYaw = 90,
		HasBullhorn = true,
		ForceAlarm = true,
		snd_starter = "left4dead/vehicles/swat_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/swat_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/swat_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/swat_stop.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		PassengerSeats = {
			{
				pos = Vector(40, -33, 55),
				ang = Angle(0, -90, 0)
			},
			{
				pos = Vector(40, -11, 55),
				ang = Angle(0, -90, 0),
				exitcheck = 75,
			},
			{
				pos = Vector(0, -42, 55),
				ang = Angle(0, 0, 0)
			},
			{
				pos = Vector(0, 42, 55),
				ang = Angle(0, 180, 0)
			},
			{
				pos = Vector(-40, -42, 55),
				ang = Angle(0, 0, 0)
			},
			{
				pos = Vector(-40, 42, 55),
				ang = Angle(0, 180, 0)
			},
			{
				pos = Vector(-80, -42, 55),
				ang = Angle(0, 0, 0)
			},
			{
				pos = Vector(-80, 42, 55),
				ang = Angle(0, 180, 0)
			},
		},
		ExitPoint = Vector(-200, 0, 35),
		ExitIgnore = {
			[0] = true,
			[1] = true,
			[2] = true,
		},
		SitChangeBlock = {
			[0] = true,
			[1] = true,
			[2] = true,
		},
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
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 35,
		BulletProofTires = true,
		IdleRPM = 1200,
		LimitRPM = 5000,
		PeakTorque = 140,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		FuelFillPos = Vector(23, 53, 31),
		FuelType = 2,
		FuelTankSize = 120,
		PowerBias = 1,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/swat_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/swat_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/swat_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 3,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/swat_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/swat_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		DifferentialGear = 0.3,
		Gears = {-0.15, 0, 0.06, 0.15, 0.23, 0.4, 0.6}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_swat", V5)

local cl_a = Color(0,0,0,0)
local cl_r = Color(255, 0, 0, 255)

local light_table5 = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(122, 36, 44),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(122, -36, 44),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-151, 42, 38),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-151, -42, 38),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(118, 36, 44),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(118, -36, 44),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(72.3, 0, 107.5),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(72.3, 0, 107.5),
			size = 40,
			color = Color(255, 155, 0, 50),
		},
		{
			pos = Vector(71.4, 9.5, 107.5),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(67.8, 36, 107.5),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(71.4, -9.5, 107.5),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(67.8, -36, 107.5),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(118, 36, 44),
			size = 100,
		},
		{
			pos = Vector(118, -36, 44),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-150, 42, 38),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-150, -42, 38),
			size = 50,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-148.7, 6.2, 108.3),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(-148.7, 15.5, 108.3),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(-148.7, 42, 108.3),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(-148.7, -6.2, 108.3),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(-148.7, -15.5, 108.3),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
		{
			pos = Vector(-148.7, -42, 108.3),
			size = 40,
			color = Color(255, 155, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-150, 35.5, 38),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-150, -35.5, 38),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	ems_sounds = {"left4dead/vehicles/swat_siren_yelp.wav", "left4dead/vehicles/swat_siren_hilo.wav"},
	ems_sprites = {
		--FRONT LIGHTBAR LEFT
		{
			pos = Vector(65.6, 9, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.07
		},
		{
			pos = Vector(65.6, 29, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.07
		},
		{
			pos = Vector(57, 9, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.07
		},
		{
			pos = Vector(57, 29, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.07
		},
		--FRONT LIGHTBAR RIGHT
		{
			pos = Vector(65.6, -9, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.07
		},
		{
			pos = Vector(65.6, -29, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.07
		},
		{
			pos = Vector(57, -9, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.07
		},
		{
			pos = Vector(57, -29, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.07
		},
		--REAR LIGHTBAR LEFT
		{
			pos = Vector(-148, 9, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.08
		},
		{
			pos = Vector(-148, 29, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.08
		},
		{
			pos = Vector(-139, 9, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.08
		},
		{
			pos = Vector(-139, 29, 118),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.08
		},
		--REAR LIGHTBAR RIGHT
		{
			pos = Vector(-148, -9, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.08
		},
		{
			pos = Vector(-148, -29, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.08
		},
		{
			pos = Vector(-139, -9, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.08
		},
		{
			pos = Vector(-139, -29, 118),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.08
		},
		--FRONT LIGHTBAR
		{
			pos = Vector(140.5, 10.5, 51.5),
			size = 80,
			Colors = {cl_r, cl_a, cl_r, cl_a, cl_r, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a,},
			Speed = 0.07
		},
		{
			pos = Vector(140.5, -10.5, 51.5),
			size = 80,
			Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a, cl_r, cl_r,},
			Speed = 0.07
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(121, 36, 36),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-150, 42, 38),
				size = 50,
				color = cl_r,
			},
		},
		Right = {
			{
				pos = Vector(121, -36, 36),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-150, -42, 38),
				size = 50,
				color = cl_r,
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[6] = "",
			},
			Brake = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
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
	}
}

list.Set("simfphys_lights", "swat", light_table5)