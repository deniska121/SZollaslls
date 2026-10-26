--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_pickup_78.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "78 Ford",
	Model = "models/left4dead/vehicles/pickup_truck_78.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2650,
		EnginePos = Vector(104, 0, 47),
		LightsTable = "pickup78",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "pickup78")
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
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-107, 37, 39)), ent:LocalToWorld(Vector(-17, -37, 65)))) do
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
		brokenglass = "pickup_trucks_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_78.mdl",
		CustomWheelPosFL = Vector(69, 36.8, 17),
		CustomWheelPosFR = Vector(69, -36.8, 17),
		CustomWheelPosRL = Vector(-66, 36.8, 17),
		CustomWheelPosRR = Vector(-66, -36.8, 17),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		LPMountFront = Vector(114.8, 0, 29.8),
		LPMountRear = Vector(-115.2, 0, 29.8),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(-1, -22, 70),
		SeatPitch = 0,
		SeatYaw = 90,
		Trunk = 0,
		PassengerSeats = {
			{
				pos = Vector(6, -22, 40),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(6, -5, 40),
				ang = Angle(0, -90, 10),
				exitcheck = 80
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-108, 25, 26),
				ang = Angle(140, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 50000,
		FrontDamping = 2500,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 50000,
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
		FuelFillPos = Vector(-38, -45, 39.5),
		FuelType = 2,
		FuelTankSize = 100,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/pickup78_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/pickup78_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/pickup78_high.wav",
		Sound_HighPitch = 1.4,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/pickup78_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		snd_start = "cars/engines/start_2.wav",
		start_del = 5,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/pickup78_horn.wav",
		DifferentialGear = 0.4,
		Gears = {-0.18, 0, 0.080, 0.13, 0.2, 0.35, 0.65, 0.75}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_pickup_78", V)
local V2 = table.Copy(V)
V2.Name = "78 Ford (Old)"
V2.Model = "models/left4dead/vehicles/pickup_truck_b_78.mdl"
V2.Members.LPMountRear = Vector(-116.8, 0, 29)
V2.Members.LightsTable = "pickup78_b"
list.Set("simfphys_vehicles", "sim_fphys_l4d_pickup_b_78", V2)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(105.5, 34.7, 48.5),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(105.5, -34.7, 48.5),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-116.2, 44.5, 46.7),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-116.2, -44.5, 46.7),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(100.5, 34.7, 48.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(100.5, -34.7, 48.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(100.5, -34.7, 48.5),
			size = 100,
		},
		{
			pos = Vector(100.5, 34.7, 48.5),
			size = 100,
		},
		{
			pos = Vector(113.3, 18.2, 45.4),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(113.3, 18.2, 45.4),
			size = 150,
		},
		{
			pos = Vector(113.3, -18.2, 45.4),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(113.3, -18.2, 45.4),
			size = 150,
		},
		{
			pos = Vector(-17.6, 25, 97.3),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-17.6, 25, 97.3),
			size = 150,
		},
		{
			pos = Vector(-17.6, -25, 97.3),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-17.6, -25, 97.3),
			size = 150,
		},
		{
			pos = Vector(-17.6, 11.4, 97.3),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-17.6, 11.4, 97.3),
			size = 150,
		},
		{
			pos = Vector(-17.6, -10.4, 97.3),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-17.6, -10.4, 97.3),
			size = 150,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-116.2, 44.5, 46.7),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-116.2, -44.5, 46.7),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-116.2, 44.5, 46.7),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-116.2, -44.5, 46.7),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-116.2, 43, 44.7),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-116.2, -43, 44.7),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[5] = "",
				[6] = "",
				[1] = "",
			},
			Brake = {
				[2] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[1] = "",
			},
			Reverse = {
				[2] = "",
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[1] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[1] = "",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[1] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	}
}

list.Set("simfphys_lights", "pickup78", light_table)

light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(105.5, 34.7, 48.5),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(105.5, -34.7, 48.5),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-116.2, 44.5, 46.7),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-116.2, -44.5, 46.7),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(100.5, 34.7, 48.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(100.5, -34.7, 48.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(100.5, -34.7, 48.5),
			size = 100,
		},
		{
			pos = Vector(100.5, 34.7, 48.5),
			size = 100,
		},
		{
			pos = Vector(113.3, -18.2, 45.4),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(113.3, -18.2, 45.4),
			size = 150,
		},
		{
			pos = Vector(-17.6, 25, 97.3),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-17.6, 25, 97.3),
			size = 150,
		},
		{
			pos = Vector(-17.6, -25, 97.3),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-17.6, -25, 97.3),
			size = 150,
		},
		{
			pos = Vector(-17.6, -10.4, 97.3),
			size = 50,
			color = Color(255, 255, 255, 255),
		},
		{
			pos = Vector(-17.6, -10.4, 97.3),
			size = 150,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-116.2, 44.5, 46.7),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-116.2, -44.5, 46.7),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-116.2, 44.5, 46.7),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-116.2, -44.5, 46.7),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-116.2, 43, 44.7),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-116.2, -43, 44.7),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	SubMaterials = {
		off = {
			Base = {
				[3] = "",
				[5] = "",
				[6] = "",
				[2] = "",
			},
			Brake = {
				[3] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[2] = "",
			},
			Reverse = {
				[3] = "",
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[3] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[2] = "",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[2] = "",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "",
			},
		},
		on_highbeam = {
			Base = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
	}
}

list.Set("simfphys_lights", "pickup78_b", light_table)