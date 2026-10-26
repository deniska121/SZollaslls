--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_pickup_2004.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local V = {
	Name = "2004 Ram",
	Model = "models/left4dead/vehicles/pickup_truck_2004.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	FLEX = {
		Trailers = {
			outputPos = Vector(-160, 0, 23),
			outputType = "ballsocket"
		}
	},
	Members = {
		Mass = 2750,
		EnginePos = Vector(122, 0, 47),
		LightsTable = "pickup2004",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "pickup2004")
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
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(-140, 43, 40)), ent:LocalToWorld(Vector(-35, -43, 65)))) do
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
		CustomWheelModel = "models/left4dead/vehicles/wheel_pickup_2004.mdl",
		CustomWheelPosFL = Vector(85, 41.8, 14),
		CustomWheelPosFR = Vector(85, -41.8, 14),
		CustomWheelPosRL = Vector(-93, 41.8, 14),
		CustomWheelPosRR = Vector(-93, -41.8, 14),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		LPMountRear = Vector(-145, 0, 31.8),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 30,
		SeatOffset = Vector(5, -24, 73),
		Trunk = 0,
		SeatPitch = 5,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(18, -22, 38),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-16, 22, 38),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-16, -22, 38),
				ang = Angle(0, -90, 10)
			},
			{
				pos = Vector(-16, 0, 38),
				ang = Angle(0, -90, 10),
				exitcheck = 80,
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-132, 25, 26),
				ang = Angle(140, 180, 0),
			},
		},
		FrontHeight = 7,
		ExitCheck = 70,
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
		PeakTorque = 160,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		FuelFillPos = Vector(-38, -47, 39.5),
		FuelType = 2,
		FuelTankSize = 110,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/pickup2004_idle.wav",
		Sound_IdlePitch = 1,
		Sound_Mid = "left4dead/vehicles/pickup2004_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 60,
		Sound_MidFadeOutRate = 0.5,
		Sound_High = "left4dead/vehicles/pickup2004_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 60,
		Sound_HighFadeInRate = 0.5,
		Sound_Throttle = "left4dead/vehicles/pickup2004_throttle.wav",
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/pickup2004_horn.wav",
		DifferentialGear = 0.4,
		Gears = {-0.18, 0, 0.09, 0.17, 0.28, 0.4, 0.65}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_pickup_2004", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(117.1, 39.2, 46),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(117.1, -39.2, 46),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-145.8, 45, 44.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-145.8, -45, 44.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(117.1, 39.2, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(117.1, -39.2, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(28.9, 11.2, 90),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(28.9, 0, 90),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(28.9, -11.2, 90),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(28.9, 28.5, 88.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
		{
			pos = Vector(28.9, -28.5, 88.9),
			size = 40,
			color = Color(255, 178, 0, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(117.1, 39.2, 46),
			size = 100,
		},
		{
			pos = Vector(117.1, -39.2, 46),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-145.8, 45, 44.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.8, -45, 44.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-145.8, 45, 44.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.8, -45, 44.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-145.8, 45, 39.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-145.8, -45, 39.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(115, 46.5, 46.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.8, 45, 51.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(115, -46.5, 46.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.8, -45, 51.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[5] = "",
				[6] = ""
			},
			Brake = {
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = ""
			},
			Reverse = {
				[4] = "",
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = ""
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = ""
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = ""
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = ""
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		turnsignals = {
			left = {
				[3] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "pickup2004", light_table)
local V2 = table.Copy(V)
V2.Name = "Полицейский пикап"
V2.Model = "models/left4dead/vehicles/police_pickup_truck2.mdl"
V2.Category = "Гос департамент"
V2.Members.LightsTable = "police_pickup2"
V2.Members.NoAlarmClose = true
V2.Members.snd_horn = "simulated_vehicles/horn_2.wav"
list.Set("simfphys_vehicles", "sim_fphys_l4d_police_pickup2", V2)

light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(117.1, 39.2, 46),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(117.1, -39.2, 46),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-145.8, 45, 44.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-145.8, -45, 44.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(117.1, 39.2, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(117.1, -39.2, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(117.1, 39.2, 46),
			size = 100,
		},
		{
			pos = Vector(117.1, -39.2, 46),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-145.8, 45, 44.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.8, -45, 44.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-145.8, 45, 44.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.8, -45, 44.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-145.8, 45, 39.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-145.8, -45, 39.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	ems_sounds = {"left4dead/vehicles/pickup2004_police_wail.wav", "left4dead/vehicles/pickup2004_police_yelp.wav"},
	ems_sprites = {
		--main blue
		{
			pos = Vector(17, 13, 97),
			size = 120,
			Colors = {Color(0, 0, 255, 0), Color(0, 0, 255, 255),},
			Speed = 0.4
		},
		{
			pos = Vector(17, 24, 97),
			size = 120,
			Colors = {Color(0, 0, 255, 0), Color(0, 0, 255, 255),},
			Speed = 0.4
		},
		--main red
		{
			pos = Vector(17, -13, 97),
			size = 120,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.4
		},
		{
			pos = Vector(17, -24, 97),
			size = 120,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.4
		},
		--side blues
		{
			pos = Vector(22.6, 24.4, 90.3),
			size = 60,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(22.6, -3.4, 90.6),
			size = 60,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(11, 3.4, 90.6),
			size = 60,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(11, -24.2, 90.3),
			size = 60,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0),},
			Speed = 0.1
		},
		--side reds
		{
			pos = Vector(22.6, -24.4, 90.3),
			size = 60,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(22.6, 3.4, 90.6),
			size = 60,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(11, -3.4, 90.6),
			size = 60,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(11, 24.2, 90.3),
			size = 60,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		--front
		{
			pos = Vector(129, -17.8, 40),
			size = 60,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.07
		},
		{
			pos = Vector(129, 17.8, 40),
			size = 60,
			Colors = {Color(0, 0, 255, 255), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 255), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0), Color(0, 0, 255, 0),},
			Speed = 0.07
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(115, 46.5, 46.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.8, 45, 51.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(115, -46.5, 46.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.8, -45, 51.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[8] = "",
				[9] = "",
				[10] = ""
			},
			Brake = {
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = ""
			},
			Reverse = {
				[8] = "",
				[9] = "",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[8] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_lowbeam = {
			Base = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = ""
			},
			Brake = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = ""
			},
			Reverse = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_highbeam = {
			Base = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = ""
			},
			Brake = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = ""
			},
			Reverse = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[10] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		turnsignals = {
			left = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[11] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "police_pickup2", light_table)
local V3 = table.Copy(V)
V3.Name = "Пожарный пикап"
V3.Model = "models/left4dead/vehicles/police_pickup_truck.mdl"
V3.Category = "Гос департамент"
V3.Members.LightsTable = "police_pickup"
V3.Members.NoAlarmClose = true
V3.Members.snd_horn = "simulated_vehicles/horn_2.wav"
list.Set("simfphys_vehicles", "sim_fphys_l4d_police_pickup", V3)

light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(117.1, 39.2, 46),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(117.1, -39.2, 46),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-145.8, 45, 44.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-145.8, -45, 44.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(117.1, 39.2, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(117.1, -39.2, 46),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(117.1, 39.2, 46),
			size = 100,
		},
		{
			pos = Vector(117.1, -39.2, 46),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-145.8, 45, 44.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.8, -45, 44.5),
			size = 80,
			color = Color(255, 0, 0, 150),
		}
	},
	Brakelight_sprites = {
		{
			pos = Vector(-145.8, 45, 44.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-145.8, -45, 44.5),
			size = 100,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-145.8, 45, 39.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-145.8, -45, 39.6),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	ems_sounds = {"left4dead/vehicles/pickup2004_police_wail.wav", "left4dead/vehicles/pickup2004_police_yelp.wav"},
	ems_sprites = {
		{
			pos = Vector(28.5, 21, 94),
			size = 100,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 150), Color(255, 0, 0, 255), Color(255, 0, 0, 150), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(28.5, 10, 94),
			size = 100,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 150), Color(255, 0, 0, 255), Color(255, 0, 0, 150),},
			Speed = 0.1
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(115, 46.5, 46.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.8, 45, 51.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(115, -46.5, 46.1),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-145.8, -45, 51.5),
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
				[7] = ""
			},
			Brake = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = ""
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
		turnsignals = {
			left = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[8] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}

list.Set("simfphys_lights", "police_pickup", light_table)