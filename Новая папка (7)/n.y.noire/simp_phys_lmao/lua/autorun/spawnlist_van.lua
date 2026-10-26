--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_van.lua
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
	Name = "90 Chevrolet",
	Model = "models/left4dead/vehicles/van.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гражданские",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2000,
		EnginePos = Vector(112, 0, 41),
		LightsTable = "van",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent.trunklist = {}
			REN.L4D2SimfphysInit(ent, "van")
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0)
			local ply = ent:GetDriver()
			if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

			if not ent.fdoorMoving and (ent.PressedKeys and ent.PressedKeys["Lock"]) then
				ent.fdoorMoving = true
				ent.fdoorstate = ent.fdoornum == 0 and 0 or 1
				ent.fdoornum = ent.fdoornum == 0 and 1 or 0
				ent.LastThink = CurTime()
				ent:EmitSound(ent.fdoornum == 1 and "left4dead/vehicles/ambulance_rear_open.wav" or "left4dead/vehicles/ambulance_rear_close.wav")

				if ent.fdoornum == 0 then
					for k, v in pairs(ents.FindInBox(ent:LocalToWorld(Vector(20, 30, 77)), ent:LocalToWorld(Vector(-90, -30, 26)))) do
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
			REN.L4D2Delete(ent)
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheelambulance.mdl",
		CustomWheelPosFL = Vector(84, 37.5, 12),
		CustomWheelPosFR = Vector(84, -37.5, 12),
		CustomWheelPosRL = Vector(-62, 37.5, 12),
		CustomWheelPosRR = Vector(-62, -37.5, 12),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 10),
		LPMountFront = Vector(115.4, 0, 23.5),
		LPMountRear = Vector(-115.5, -1.3, 21.4),
		CustomSteerAngle = 30,
		SeatOffset = Vector(48, -19, 64),
		SeatPitch = -4,
		SeatYaw = 90,
		PassengerSeats = {
			{
				pos = Vector(52, -22, 37),
				ang = Angle(0, -90, 17)
			},
			{
				pos = Vector(52, -2, 37),
				ang = Angle(0, -90, 17),
				exitcheck = 75,
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-108, -20, 14),
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
		FuelFillPos = Vector(-33, 44, 27.6),
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
		snd_brake = "cars/wheels/brake_disc_" .. math.random(2) .. ".wav",
		snd_start = "cars/engines/start_2.wav",
		start_del = 2,
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		--
		snd_horn = "left4dead/vehicles/van_horn.wav",
		DifferentialGear = 0.5,
		Gears = {-0.13, 0, 0.095, 0.15, 0.23, 0.4, 0.7}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_van", V)

local cl_a = Color(0,0,0,0)
local cl_b = Color(0, 0, 255, 255)
local cl_r = Color(255, 0, 0, 255)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(112, 31.8, 42.8),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(112, -31.8, 42.8),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-113, 37.3, 42.6),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-113, -37.3, 42.6),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(112, 31.8, 41.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(112, -31.8, 41.8),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(112, 31.8, 41.8),
			size = 100,
		},
		{
			pos = Vector(112, -31.8, 41.8),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-113, 37.3, 46),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-113, -37.3, 46),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-113, 37.3, 46),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-113, -37.3, 46),
			size = 60,
			color = Color(255, 0, 0, 150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-113, 37.3, 39),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-113, -37.3, 39),
			size = 60,
			color = Color(255, 255, 255, 150),
		}
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(111, 32, 34),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(104, 44.5, 41.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-113, 37.3, 43),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(111, -32, 34),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(104, -44.5, 41.5),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-113, -37.3, 43),
				size = 50,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[4] = "",
				[6] = "",
				[7] = "",
			},
			Brake = {
				[4] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Reverse = {
				[4] = "",
				[6] = "",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[4] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Brake = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "",
			},
			Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
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
	}
}

list.Set("simfphys_lights", "van", light_table)
local V2 = table.Copy(V)
V2.Name = "Maintenance Van (Empty)"
V2.Model = "models/left4dead/vehicles/van_m.mdl"
V2.Category = "Сервисы"
list.Set("simfphys_vehicles", "sim_fphys_l4d_van_m_e", V2)
local light_table2 = table.Copy(light_table)

light_table2.ems_sounds = {"left4dead/vehicles/pickup2004_police_wail.wav", "left4dead/vehicles/pickup2004_police_yelp.wav"}

light_table2.ems_sprites = {
	--main blue
	{
		pos = Vector(58, 13, 93),
		size = 120,
		Colors = {cl_a, cl_b,},
		Speed = 0.4
	},
	{
		pos = Vector(58, 24, 93),
		size = 120,
		Colors = {cl_a, cl_b,},
		Speed = 0.4
	},
	{
		pos = Vector(49, 13, 93),
		size = 120,
		Colors = {cl_a, cl_b,},
		Speed = 0.4
	},
	{
		pos = Vector(49, 24, 93),
		size = 120,
		Colors = {cl_a, cl_b,},
		Speed = 0.4
	},
	--main red
	{
		pos = Vector(58, -13, 93),
		size = 120,
		Colors = {cl_r, cl_a,},
		Speed = 0.4
	},
	{
		pos = Vector(58, -24, 93),
		size = 120,
		Colors = {cl_r, cl_a,},
		Speed = 0.4
	},
	{
		pos = Vector(49, -13, 93),
		size = 120,
		Colors = {cl_r, cl_a,},
		Speed = 0.4
	},
	{
		pos = Vector(49, -24, 93),
		size = 120,
		Colors = {cl_r, cl_a,},
		Speed = 0.4
	}
}

list.Set("simfphys_lights", "van_mett", light_table2)
local VC = table.Copy(V)
VC.Name = "Van (METT)"
VC.Model = "models/left4dead/vehicles/van_m.mdl"
VC.Category = "Гос департамент"
VC.Members.snd_horn = "simulated_vehicles/horn_2.wav"
VC.Members.LightsTable = "van_mett"
VC.Members.NoAlarmClose = true

VC.Members.OnSpawn = function(ent)
	ent.fdoornum = 0
	ent.fdoorMoving = false
	ent.fdoorstate = 0
	ent.LastThink = 0
	ent.trunklist = {}
	REN.L4D2SimfphysInit(ent, "van")
	ent:SetSubMaterial(0, "models/left4dead/vehicles/van_cor")
end

VC.Members.Attachments = {
	{
		model = "models/cityrp/lightbar.mdl",
		pos = Vector(54, 0, 90),
		ang = Angle(0, 0, 0)
	},
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_van_mett", VC)
local light_tablea = table.Copy(light_table)
light_tablea.ems_sounds = {"left4dead/vehicles/vic_police_wail.wav", "left4dead/vehicles/vic_police_yelp.wav"}
light_tablea.ems_sprites = {
	{
		pos = Vector(38.33,-33.1,92.5),
		size = 40,
		Colors = {cl_r, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a,},
		Speed = 0.10
	},
	{
		pos = Vector(38.33,33.1,92.5),
		size = 40,
		Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a,},
		Speed = 0.10
	},
	{
		pos = Vector(-92,8.8,95),
		size = 80,
		Colors = {color_white, cl_a, cl_a, cl_a,},
		Speed = 0.15
	},
	{
		pos = Vector(-92,3.3,95),
		size = 80,
		Colors = {cl_a, cl_a, cl_r, cl_a,},
		Speed = 0.15
	},
	{
		pos = Vector(-92,-3.3,95),
		size = 80,
		Colors = {color_white, cl_a, color_white, cl_a,},
		Speed = 0.15
	},
	{
		pos = Vector(-92,-8.8,95),
		size = 80,
		Colors = {cl_a, cl_a, cl_r, cl_a,},
		Speed = 0.15
	},
	{
		pos = Vector(60,0,95),
		size = 80,
		Colors = {color_white, cl_a, color_white, cl_a, cl_a, cl_a, cl_a, cl_a,},
		Speed = 0.05
	},
	{
		pos = Vector(57, -8, 95),
		size = 80,
		Colors = {cl_r, cl_a, cl_r, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_a,},
		Speed = 0.05
	},
	{
		pos = Vector(57, 8, 95),
		size = 80,
		Colors = {cl_a, cl_a, cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a, cl_r, cl_a,},
		Speed = 0.05
	},
	{
		pos = Vector(50, -26.5, 95),
		size = 80,
		Colors = {cl_r, cl_a, cl_r, cl_a, cl_a, cl_a, cl_a, cl_a,},
		Speed = 0.10
	},
	{
		pos = Vector(50, 26.5, 95),
		size = 80,
		Colors = {cl_a, cl_a, cl_a, cl_a, cl_r, cl_a, cl_r, cl_a,},
		Speed = 0.10
	},
}

light_tablea.SubMaterials = {
	off = {
		Base = {
			[5] = "",
			[7] = "",
			[8] = "",
		},
		Brake = {
			[5] = "",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "",
		},
		Reverse = {
			[5] = "",
			[7] = "",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Brake_Reverse = {
			[5] = "",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
	},
	on_lowbeam = {
		Base = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "",
		},
		Brake = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "",
		},
		Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Brake_Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
	},
	on_highbeam = {
		Base = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "",
		},
		Brake = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "",
		},
		Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
		Brake_Reverse = {
			[5] = "models/left4dead/vehicles/4carz1024_lights_on",
			[7] = "models/left4dead/vehicles/4carz1024_lights_on",
			[8] = "models/left4dead/vehicles/4carz1024_lights_on",
		},
	},
	turnsignals = {
		left = {
			[6] = "models/left4dead/vehicles/4carz1024_lights_on"
		},
		right = {
			[4] = "models/left4dead/vehicles/4carz1024_lights_on"
		},
	},
}

list.Set("simfphys_lights", "van_nypd", light_tablea)
local AUX = table.Copy(V)
AUX.Name = "NYPD Van (AUX)"
AUX.Model = "models/left4dead/vehicles/van_nypd.mdl"
AUX.Category = "Гос департамент"
AUX.Members.snd_horn = "simulated_vehicles/horn_2.wav"
AUX.Members.LightsTable = "van_nypd"
AUX.Members.NoAlarmClose = true
AUX.Members.SitChangeBlock = {
	[0] = true,
	[1] = true,
	[9] = true,
}
AUX.Members.OnSpawn = function(ent)
	ent.fdoornum = 0
	ent.fdoorMoving = false
	ent.fdoorstate = 0
	ent.LastThink = 0
	ent.NYPDAuxVeh = true
	ent.trunklist = {}
	ent.customplates = "models/left4dead/vehicles/plate/l4d_front0"
	REN.L4D2SimfphysInit(ent, "van")
	local count = 20

	for _,v in ipairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
		if v.NYPDAuxVeh then
			count = count + 1
		end
	end
	ent.McCD_UniqueId = "70 " .. count
end
AUX.Members.PassengerSeats = {
	{
		pos = Vector(52, -22, 37),
		ang = Angle(0, -90, 17)
	},
	-- {
	-- 	pos = Vector(52, -2, 37),
	-- 	ang = Angle(0, -90, 17),
	-- 	exitcheck = 75,
	-- },
	{
		pos = Vector(12, -22, 37),
		ang = Angle(0, 90, 17)
	},
	{
		pos = Vector(12, 0, 37),
		ang = Angle(0, 90, 17),
		exitcheck = 75,
	},
	{
		pos = Vector(12, 22, 37),
		ang = Angle(0, 90, 17)
	},
	{
		pos = Vector(-30, -22, 37),
		ang = Angle(0, -90, 17)
	},
	{
		pos = Vector(-30, 0, 37),
		ang = Angle(0, -90, 17),
		exitcheck = 75,
	},
	{
		pos = Vector(-30, 22, 37),
		ang = Angle(0, -90, 17)
	},
	{
		pos = Vector(-76, 22, 37),
		ang = Angle(0, 90, 17)
	},
}
list.Set("simfphys_vehicles", "sim_fphys_l4d_van_aux", AUX)
local V3 = table.Copy(V2)
V3.Name = "Maintenance Van"

V3.Members.Attachments = {
	{
		model = "models/props_c17/metalladder001.mdl",
		pos = Vector(-85, -18, 95.5),
		ang = Angle(90, 0, 0)
	},
	{
		model = "models/props_debris/wood_board03a.mdl",
		pos = Vector(-20, 22, 93.5),
		ang = Angle(90, 0, 0)
	},
	{
		model = "models/props_debris/wood_board03a.mdl",
		pos = Vector(-20, 16, 95.5),
		ang = Angle(90, -180, 0)
	},
	{
		model = "models/props_debris/wood_board03a.mdl",
		pos = Vector(-20, 12, 93.5),
		ang = Angle(90, 0, 0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97, 27, 41),
		ang = Angle(0, 0, 0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97, 27, 44),
		ang = Angle(0, 180, 0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97, 27, 47),
		ang = Angle(0, 90, 0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97, 27, 50),
		ang = Angle(0, 0, 0)
	},
	{
		model = "models/props_lab/partsbin01.mdl",
		pos = Vector(28, 0, 50),
		ang = Angle(0, 180, 0)
	},
	{
		model = "models/props_wasteland/barricade001a.mdl",
		pos = Vector(-11, -17, 45),
		ang = Angle(0, 6, 0)
	},
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_van_m", V3)

local V4 = {
	Name = "News Van",
	Model = "models/left4dead/vehicles/news_van.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0, 0, 0),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 2100,
		EnginePos = Vector(112, 0, 41),
		LightsTable = "van",
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "van") --name of car "ent", name of the audio bank
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 0) --name of car "ent", Has reversing beep? 0/1
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		CustomWheelModel = "models/left4dead/vehicles/wheelambulance.mdl",
		CustomWheelPosFL = Vector(84, 37.5, 12),
		CustomWheelPosFR = Vector(84, -37.5, 12),
		CustomWheelPosRL = Vector(-62, 37.5, 12),
		CustomWheelPosRR = Vector(-62, -37.5, 12),
		CustomWheelAngleOffset = Angle(0, 270, 0),
		CustomMassCenter = Vector(0, 0, 20),
		CustomSteerAngle = 30,
		SeatOffset = Vector(48, -19, 64),
		SeatPitch = -4,
		SeatYaw = 90,
		LPMountFront = Vector(115.4, 0, 23.5),
		LPMountRear = Vector(-115.5, 0, 21.4),
		PassengerSeats = {
			{
				pos = Vector(52, -18, 37),
				ang = Angle(0, -90, 17)
			},
			{
				pos = Vector(52, -2, 37),
				ang = Angle(0, -90, 17),
				exitcheck = 75,
			}
		},
		ExhaustPositions = {
			{
				pos = Vector(-108, -20, 14),
				ang = Angle(90, 180, 0),
			},
		},
		FrontHeight = 7,
		FrontConstant = 24000,
		FrontDamping = 3000,
		FrontRelativeDamping = 800,
		RearHeight = 7,
		RearConstant = 24000,
		RearDamping = 3000,
		RearRelativeDamping = 800,
		TurnSpeed = 3,
		Trunk = 0,
		MaxGrip = 42,
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
		FuelFillPos = Vector(-33, 44, 27.6),
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
		DifferentialGear = 0.5,
		Gears = {-0.13, 0, 0.095, 0.15, 0.23, 0.4, 0.7}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_news_van", V4)