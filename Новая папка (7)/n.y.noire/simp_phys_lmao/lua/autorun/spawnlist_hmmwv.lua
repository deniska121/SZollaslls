--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_hmmwv.lua
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

local lang_pd = {
	[-1] = "Передний привод",
	[0] = "Полный привод",
	[1] = "Задний привод",
}

local V = {
	Name = "HMMWV",
	Model = "models/left4dead/vehicles/hmmwv.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-105, 0, 28),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 2150,
		MaxHealth = 4250,
		EnginePos = Vector(100, 0, 42.5),
		LightsTable = "hmmwv",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		IsArmored = true,
		NoAlarmClose = true,
		BulletProofTires = true,
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent.trunklist = {}
			REN.L4D2SimfphysInit(ent, "van") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
			local ply = ent:GetDriver()
			if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

			if (ent.PressedKeys and ent.PressedKeys["flgts"]) and (not ent.LastPS or ent.LastPS < CurTime()) then
				ent.LastPS = CurTime() + 1
				local power = ent:GetPowerDistribution()
				power = power + 1

				if power > 1 then
					power = -1
				end

				if power == 0 then
					ent:SetMaxTorque(90)
				else
					ent:SetMaxTorque(130)
				end

				DarkRP.UIEffect(ply, "DoorLock", {lang_pd[power]})

				ent:SetPowerDistribution(power)
				ent:EmitSound("vcmod/handbrake.wav")
			end

			if not ent.fdoorMoving and (ent.PressedKeys and ent.PressedKeys["Lock"]) then
				ent.fdoorMoving = true
				ent.fdoorstate = ent.fdoornum == 0 and 0 or 1
				ent.fdoornum = ent.fdoornum == 0 and 1 or 0
				ent.LastThink = CurTime()
				ent:EmitSound(ent.fdoornum == 1 and "left4dead/vehicles/ambulance_rear_open.wav" or "left4dead/vehicles/ambulance_rear_close.wav")

				if ent.fdoornum == 0 then
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-46.26, -34.06, 79.24)), ent:LocalToWorld(Vector(-108.92, 33.67, 39.92)))) do
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

				timer.Simple(5, function()
					if not IsValid(ent) then return end
					ent.fdoorMoving = nil
				end)
			end

			if ent.fdoorMoving then
				Approach(ent.fdoornum, ent)
				ent:SetPoseParameter("rear_door", ent.fdoorstate)
			end
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheel_hmmwv.mdl",
		CustomWheelPosFL = Vector(77.4, 43, 10),
		CustomWheelPosFR = Vector(77.4, -43, 10),
		CustomWheelPosRL = Vector(-71.9, 43, 10),
		CustomWheelPosRR = Vector(-71.9, -43, 10),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(4, -34, 62),
		SeatPitch = 0,
		Trunk = 0,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(10, -31, 31),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-34, 31, 31),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-34, -31, 31),
				ang = Angle(0, -90, 10)
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
		TurnSpeed = 3,
		MaxGrip = 70,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 90,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-52, -48.25, 46.6),
		FuelType = 2,
		FuelTankSize = 95,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/hmmwv_idle.wav",
		Sound_IdlePitch = 1.2,
		Sound_Mid = "left4dead/vehicles/hmmwv_low.wav",
		Sound_MidPitch = 1.2,
		Sound_MidVolume = 1.6,
		Sound_MidFadeOutRPMpercent = 70,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/hmmwv_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 1.9,
		Sound_HighFadeInRPMpercent = 70,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/hmmwv_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 3,
		snd_horn = "left4dead/vehicles/hmmwv_horn.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		snd_start = "cars/engines/start_truck.wav",
		DifferentialGear = 0.15,
		Gears = {-0.35, 0, 0.15, 0.22, 0.29, 0.37, 0.49, 0.6, 0.79}
	}
}

local V2 = table.Copy(V)
V2.Model = "models/left4dead/vehicles/hmmwv_civ.mdl"
V2.Name = "HMMWV Conversion"
V2.NAKType = "Премиум"
V2.Category = "Премиум"
V2.Members.LightsTable = "hmmwv_civ"
V2.Members.LPMountFront = Vector(103.36, 0, 28)
V2.Members.LPMountRear = Vector(-108.92, -42, 54.34)
list.Set("simfphys_vehicles", "sim_fphys_l4d_hmmwv", V)
list.Set("simfphys_vehicles", "sim_fphys_l4d_hmmwv_civ", V2)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(102.8, 23.4, 41.3),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(102.8, -23.4, 41.3),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-109.1, 37.3, 44.7),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-109.1, -37.3, 44.7),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(102.8, 23.4, 41.3),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(102.8, -23.4, 41.3),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(93, 49.4, 45.7),
			size = 40,
			color = Color(255, 136, 0, 150),
		},
		{
			pos = Vector(93, -49.4, 45.7),
			size = 40,
			color = Color(255, 136, 0, 150),
		},
		{
			pos = Vector(-101.6, 50.6, 37.2),
			size = 40,
			color = Color(255, 136, 0, 150),
		},
		{
			pos = Vector(-101.6, -50.6, 37.2),
			size = 40,
			color = Color(255, 136, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(102.8, 23.4, 41.3),
			size = 100,
		},
		{
			pos = Vector(102.8, -23.4, 41.3),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-109.1, 37.3, 44.7),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-109.1, -37.3, 44.7),
			size = 70,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-109.1, 37.3, 44.7),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-109.1, -37.3, 44.7),
			size = 60,
			color = Color(255, 0, 0, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(102.4, 42.4, 45.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-109, 45.6, 39.7),
				size = 50,
				color = Color(255, 0, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(102.4, -42.4, 45.7),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-109, -45.6, 39.7),
				size = 50,
				color = Color(255, 0, 0, 150),
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
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
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

local light_table2 = table.Copy(light_table)

light_table2.SubMaterials = {
	off = {
		Base = {
			[5] = "",
			[8] = "",
		},
		Brake = {
			[5] = "",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Reverse = {
			[5] = "",
			[8] = "",
		},
		Brake_Reverse = {
			[5] = "",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
	},
	on_lowbeam = {
		Base = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Brake = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Brake_Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
	},
	on_highbeam = {
		Base = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Brake = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Brake_Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
	},
	turnsignals = {
		left = {
			[7] = "models/left4dead/vehicles/4carz1024_lights_on"
		},
		right = {
			[6] = "models/left4dead/vehicles/4carz1024_lights_on"
		},
	},
}

list.Set("simfphys_lights", "hmmwv", light_table)
list.Set("simfphys_lights", "hmmwv_civ", light_table2)