--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/spawnlist_fire_truck.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function REN.LadderThink(ent)
	local CT = CurTime()
	if ent.usedladder and ent.usedladder > CT and ent.EngineRPM > 0 and ent:GetGear() == 2 then
		ent.EngineRPM = ent:GetEngineData().IdleRPM + 1200
	end

	local ply = ent:GetDriver()
	if not IsValid(ply) or not ply:IsPlayer() or not IsValid(ent.ladder) then return end

	if ent.LastUse and ent.LastUse > CT then return end

	if (ent.PressedKeys and ent.PressedKeys["Lock"]) and not ent.fixed_pos then
		ent.LastUse = CT + 2
		if ent:GetVelocity():LengthSqr() > 100 then
			ent:EmitSound("buttons/lever7.wav")
			return
		end

		ent.fixed_pos = true
		ent:SetBodygroup(2, 1)
		if IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():EnableMotion(false)
		end
		ent:EmitSound("vehicles/crane/crane_magnet_release.wav")
		ent.ladder:SetParent(nil)

		local pos0 = ent:LocalToWorld(Vector(-284.35,20.9,-47.64))
		local pos1 = ent:LocalToWorld(Vector(-244.02,18.14,39.79))
		ent.subladder = ents.Create("func_useableladder")
		ent.subladder:SetPos(pos0)
		ent.subladder:SetAngles(Angle(0, 0, 0))
		ent.subladder:SetKeyValue("point0", tostring(pos0))
		ent.subladder:SetKeyValue("point1", tostring(pos1))
		ent.subladder:Spawn()
		ent.subladder:Activate()
		ent:DeleteOnRemove(ent.subladder)
		return
	end

	if (ent.PressedKeys and ent.PressedKeys["Lock"]) and ent.fixed_pos then
		ent.LastUse = CT + 2

		if ent.ladder:GetOpen() ~= 0 or ent.ladder:GetClimb() ~= 0 or ent.ladder:GetRotate() ~= 0 then
			ent:EmitSound("buttons/lever7.wav")
			return
		end

		ent.fixed_pos = nil

		ent.ladder:SetParent(ent)
		ent:SetBodygroup(2, 0)
		if IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():EnableMotion(true)
		end
		ent:EmitSound("vehicles/crane/crane_magnet_release.wav")

		if IsValid(ent.subladder) then ent.subladder:Remove() end
	end
end

function REN.L4D2EngineCheck(ent)
	local prs = ent:GetNW2Int("Pressure", 0)

	if prs < 300 and (not ent.used or ent.used < CurTime()) and ent.EngineRPM > 0 and ent:GetGear() == 2 then
		ent.EngineRPM = ent:GetEngineData().IdleRPM + 1200
		ent:SetNW2Int("Pressure", math.min(prs + 1, 300))
	end
end

local V = {
	Name = "Пожарная машина (Ladder)",
	Model = "models/left4dead/vehicles/fire_truck_aerial.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 70),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 6500,
		EnginePos = Vector(217, 0, -23.6),
		LightsTable = "l4d_fire_truck",
		CustomWheels = true,
		NoAlarmClose = true,
		CustomSuspensionTravel = 1.5,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "fire_truck")
			ent:SetNW2Int("Pressure", 0)

			ent.lopen = 0

			ent.ladder = ents.Create("fire_ladder")
			ent.ladder:SetPos(ent:LocalToWorld(Vector(-170, 0, 53)))
			ent.ladder:SetAngles(ent:LocalToWorldAngles(Angle(0, 0, 0)))
			ent.ladder:Spawn()
			ent.ladder:Activate()
			ent.ladder:SetParent(ent)
			ent.ladder.engine = ent

			ent:DeleteOnRemove(ent.ladder)
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1) --name of car "ent", Has reversing beep? 0/1
			REN.L4D2EngineCheck(ent)
			REN.LadderThink(ent)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent) --MUST call on EVERY car that uses my functions
		end,
		brokenglass = "bus_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_fire_truck.mdl",
		CustomWheelPosFL = Vector(138, 43, -53),
		CustomWheelPosFR = Vector(138, -43, -53),
		CustomWheelPosML = Vector(-80, 43, -47),
		CustomWheelPosMR = Vector(-80, -43, -47),
		CustomWheelPosRL = Vector(-138, 43, -50),
		CustomWheelPosRR = Vector(-138, -43, -50),
		Trunk = 0,
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(0, 0, 0),
		CustomSteerAngle = 50,
		SeatOffset = Vector(160, -32, 38),
		SeatPitch = 10,
		SeatYaw = 90,
		ExhaustPositions = {
			{
				pos = Vector(21, -48, -57.9),
				ang = Angle(-90, 90, 0),
			},
			{
				pos = Vector(21, 48, -57.9),
				ang = Angle(-90, -90, 0),
			},
		},
		PassengerSeats = {
			{
				pos = Vector(170, -32, -22),
				ang = Angle(0, -90, 0)
			},
			{
				pos = Vector(90, 32, -22),
				ang = Angle(0, -90, 0)
			},
			{
				pos = Vector(90, -32, -22),
				ang = Angle(0, -90, 0)
			},
		},
		FrontHeight = 14,
		FrontConstant = 50000,
		FrontDamping = 2000,
		FrontRelativeDamping = 5,
		RearHeight = 14,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 5,
		TurnSpeed = 3,
		MaxGrip = 100,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 45,
		BulletProofTires = false,
		IdleRPM = 1100,
		LimitRPM = 5000,
		PeakTorque = 125,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		FuelFillPos = Vector(48.4, -37, -24.6),
		FuelType = 2,
		FuelTankSize = 170,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/fire_truck_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/fire_truck_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 35,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/fire_truck_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 35,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/fire_truck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/fire_truck_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		DifferentialGear = 0.14,
		Gears = {-0.35, 0, 0.15, 0.22, 0.29, 0.37, 0.49, 0.6, 0.79}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_fire_truck", V)

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(217, 33, -25.5),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(217, -33, -25.5),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-245, 42.4, -31.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-245, -42.4, -31.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(217, 33, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(217, -33, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(217, 26, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(217, -26, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(217, 26, -25.5),
			size = 100,
		},
		{
			pos = Vector(217, -26, -25.5),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-245, 42.4, -31.5),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-245, -42.4, -31.5),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-245, 42.4, -25.4),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-245, -42.4, -25.4),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-245, 42.4, -19.2),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-245, -42.4, -19.2),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	ems_sounds = {"left4dead/vehicles/fire_truck_siren_wail.wav", "left4dead/vehicles/fire_truck_siren_yelp.wav"},
	ems_sprites = {
		--main front row red 1
		{
			pos = Vector(188, 25.2, 41.2),
			size = 120,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.5
		},
		{
			pos = Vector(188, -25.2, 41.2),
			size = 120,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.5
		},
		--main front row white
		{
			pos = Vector(180, 34.2, 41.2),
			size = 100,
			Colors = {Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(180, -34.2, 41.2),
			size = 100,
			Colors = {Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255),},
			Speed = 0.1
		},
		--main front row red 2
		{
			pos = Vector(170, 43.2, 41.2),
			size = 120,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(170, -43.2, 41.2),
			size = 120,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		--left side row reds
		{
			pos = Vector(107, 41.2, 42.4),
			size = 120,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.075
		},
		{
			pos = Vector(95, 41.2, 42.4),
			size = 120,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.075
		},
		--left side row whites
		{
			pos = Vector(101, 41.2, 42.4),
			size = 100,
			Colors = {Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255),},
			Speed = 0.075
		},
		{
			pos = Vector(89, 41.2, 42.4),
			size = 100,
			Colors = {Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255),},
			Speed = 0.075
		},
		--right side row reds
		{
			pos = Vector(107, -41.2, 42.4),
			size = 120,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.075
		},
		{
			pos = Vector(95, -41.2, 42.4),
			size = 120,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.075
		},
		--right side row whites
		{
			pos = Vector(101, -41.2, 42.4),
			size = 100,
			Colors = {Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0),},
			Speed = 0.075
		},
		{
			pos = Vector(89, -41.2, 42.4),
			size = 100,
			Colors = {Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0),},
			Speed = 0.075
		},
		--left side red 1
		{
			pos = Vector(214, 52.2, -46.6),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(-115.6, 33.2, 24.2),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		--left side red 2
		{
			pos = Vector(14.4, 33.2, 24.2),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.11
		},
		--right side red 1
		{
			pos = Vector(214, -52.2, -46.6),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(-115.6, -33.2, 24.2),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		--right side red 2
		{
			pos = Vector(14.4, -33.2, 24.2),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255),},
			Speed = 0.11
		},
		--front red 1
		{
			pos = Vector(217, 25.9, -18.8),
			size = 80,
			Colors = {Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		{
			pos = Vector(217, -25.9, -18.8),
			size = 80,
			Colors = {Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 255), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0), Color(255, 0, 0, 0),},
			Speed = 0.1
		},
		--front red 2
		{
			pos = Vector(241.7, 42.1, -46.8),
			size = 160,
			Colors = {Color(255, 0, 0, 60), Color(255, 0, 0, 80), Color(255, 0, 0, 100), Color(255, 0, 0, 120), Color(255, 0, 0, 140), Color(255, 0, 0, 160), Color(255, 0, 0, 180), Color(255, 0, 0, 200), Color(255, 0, 0, 220), Color(255, 0, 0, 240), Color(255, 0, 0, 255), Color(255, 0, 0, 240), Color(255, 0, 0, 220), Color(255, 0, 0, 200), Color(255, 0, 0, 180), Color(255, 0, 0, 160), Color(255, 0, 0, 140), Color(255, 0, 0, 120), Color(255, 0, 0, 100), Color(255, 0, 0, 80), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60),},
			Speed = 0.02
		},
		{
			pos = Vector(241.7, -42.1, -46.8),
			size = 160,
			Colors = {Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 80), Color(255, 0, 0, 100), Color(255, 0, 0, 120), Color(255, 0, 0, 140), Color(255, 0, 0, 160), Color(255, 0, 0, 180), Color(255, 0, 0, 200), Color(255, 0, 0, 220), Color(255, 0, 0, 240), Color(255, 0, 0, 255), Color(255, 0, 0, 240), Color(255, 0, 0, 220), Color(255, 0, 0, 200), Color(255, 0, 0, 180), Color(255, 0, 0, 160), Color(255, 0, 0, 140), Color(255, 0, 0, 120), Color(255, 0, 0, 100), Color(255, 0, 0, 80), Color(255, 0, 0, 60),},
			Speed = 0.02
		},
		--back whites
		{
			pos = Vector(-252.6, -41.4, -44.6),
			size = 70,
			Colors = {Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255),},
			Speed = 0.11
		},
		{
			pos = Vector(-252.6, 41.4, -44.6),
			size = 70,
			Colors = {Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 0), Color(255, 255, 255, 255),},
			Speed = 0.11
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(217, 32.8, -18.9),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-246, 42.8, -38.8),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(217, -32.8, -18.9),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-246, -42.8, -38.8),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[7] = "",
				[6] = "",
				[3] = "",
			},
			Brake = {
				[7] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[7] = "",
				[6] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[7] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "",
			},
			Brake = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "",
			},
			Brake = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
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
	},
}

list.Set("simfphys_lights", "l4d_fire_truck", light_table)

local V2 = {
	Name = "Пожарная машина (Engine)",
	Model = "models/left4dead/vehicles/fire_engine.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0, 0, 70),
	SpawnAngleOffset = 90,
	Members = {
		Mass = 6000,
		EnginePos = Vector(217, 0, -23.6),
		LightsTable = "l4d_fire_engine",
		NoAlarmClose = true,
		OnSpawn = function(ent)
			REN.L4D2SimfphysInit(ent, "fire_truck")
			ent:SetNW2Int("Pressure", 0)
		end,
		OnTick = function(ent)
			REN.L4D2SimfphysOnTick(ent, 1)
			REN.L4D2EngineCheck(ent)
		end,
		OnDelete = function(ent)
			REN.L4D2Delete(ent)
		end,
		CustomWheels = true,
		CustomSuspensionTravel = 0.5,
		brokenglass = "bus_glass",
		CustomWheelModel = "models/left4dead/vehicles/wheel_fire_truck.mdl",
		CustomWheelPosFL = Vector(138, 43, -53),
		CustomWheelPosFR = Vector(138, -43, -53),
		CustomWheelPosRL = Vector(-80, 43, -47),
		CustomWheelPosRR = Vector(-80, -43, -47),
		Trunk = 100,
		CustomWheelAngleOffset = Angle(0, -90, 0),
		CustomMassCenter = Vector(30, 0, 0),
		CustomSteerAngle = 50,
		SeatOffset = Vector(160, -32, 38),
		SeatPitch = 10,
		SeatYaw = 90,
		ExhaustPositions = {
			{
				pos = Vector(21, -48, -57.9),
				ang = Angle(-90, 90, 0),
			},
			{
				pos = Vector(21, 48, -57.9),
				ang = Angle(-90, -90, 0),
			},
		},
		PassengerSeats = {
			{
				pos = Vector(170, -32, -22),
				ang = Angle(0, -90, 0)
			},
			{
				pos = Vector(90, 32, -22),
				ang = Angle(0, -90, 0)
			},
			{
				pos = Vector(90, -32, -22),
				ang = Angle(0, -90, 0)
			},
		},
		FrontHeight = 16,
		FrontConstant = 50000,
		FrontDamping = 2000,
		FrontRelativeDamping = 1,
		RearHeight = 16,
		RearConstant = 50000,
		RearDamping = 2000,
		RearRelativeDamping = 5,
		TurnSpeed = 3,
		MaxGrip = 130,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 55,
		BulletProofTires = true,
		IdleRPM = 1100,
		LimitRPM = 5000,
		PeakTorque = 155,
		PowerbandStart = 1600,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		DoNotStall = false,
		FuelFillPos = Vector(48.4, -37, -24.6),
		FuelType = 2,
		FuelTankSize = 170,
		PowerBias = 0,
		EngineSoundPreset = 0,
		Sound_Idle = "left4dead/vehicles/fire_truck_idle.wav",
		Sound_IdlePitch = 0.8,
		Sound_Mid = "left4dead/vehicles/fire_truck_low.wav",
		Sound_MidPitch = 1.1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 35,
		Sound_MidFadeOutRate = 0.3,
		Sound_High = "left4dead/vehicles/fire_truck_high.wav",
		Sound_HighPitch = 1.2,
		Sound_HighVolume = 2,
		Sound_HighFadeInRPMpercent = 35,
		Sound_HighFadeInRate = 0.3,
		Sound_Throttle = "left4dead/vehicles/fire_truck_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 2.5,
		snd_horn = "left4dead/vehicles/fire_truck_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_brake = "cars/wheels/rig_brake_disc_" .. math.random(2) .. ".wav",
		snd_brake_squeak = "cars/wheels/brake_squeak_" .. math.random(2) .. ".wav",
		snd_brake_release = "cars/wheels/rig_brake_release.wav",
		snd_start = "cars/engines/start_truck.wav",
		start_del = 5,
		snd_bloweroff = "common/null.wav",
		DifferentialGear = 0.14,
		Gears = {-0.35, 0, 0.15, 0.22, 0.29, 0.37, 0.49, 0.6, 0.79}
	}
}

list.Set("simfphys_vehicles", "sim_fphys_l4d_fire_engine", V2)
local alha_li = Color(0, 0, 0, 0)

light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(217, 33, -25.5),
	L_HeadLampAng = Angle(0, 0, 0),
	R_HeadLampPos = Vector(217, -33, -25.5),
	R_HeadLampAng = Angle(0, 0, 0),
	-- projected texture - rear
	L_RearLampPos = Vector(-245, 42.4, -31.5),
	L_RearLampAng = Angle(25, 180, 0),
	R_RearLampPos = Vector(-245, -42.4, -31.5),
	R_RearLampAng = Angle(25, 180, 0),
	Headlight_sprites = {
		{
			pos = Vector(217, 33, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(217, -33, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(217, 26, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
		{
			pos = Vector(217, -26, -25.5),
			size = 70,
			color = Color(255, 238, 200, 150),
		},
	},
	-- lowbeam
	Headlamp_sprites = {
		{
			pos = Vector(217, 26, -25.5),
			size = 100,
		},
		{
			pos = Vector(217, -26, -25.5),
			size = 100,
		},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-149, 42.4, -31.5),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-149, -42.4, -31.5),
			size = 70,
			color = Color(255, 0, 0, 150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-149, 42.4, -25.4),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
		{
			pos = Vector(-149, -42.4, -25.4),
			size = 60,
			color = Color(255, 0, 0, 150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-149, 42.4, -19.2),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
		{
			pos = Vector(-149, -42.4, -19.2),
			size = 60,
			color = Color(255, 255, 255, 150),
		},
	},
	ems_sounds = {"left4dead/vehicles/fire_truck_siren_wail.wav", "left4dead/vehicles/fire_truck_siren_yelp.wav"},
	ems_sprites = {
		--main front row red 1
		{
			pos = Vector(188, 25.2, 41.2),
			size = 120,
			Colors = {Color(255, 0, 0, 255), alha_li,},
			Speed = 0.5
		},
		{
			pos = Vector(188, -25.2, 41.2),
			size = 120,
			Colors = {alha_li, Color(255, 0, 0, 255),},
			Speed = 0.5
		},
		--main front row white
		{
			pos = Vector(180, 34.2, 41.2),
			size = 100,
			Colors = {color_white, alha_li, color_white, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(180, -34.2, 41.2),
			size = 100,
			Colors = {alha_li, alha_li, alha_li, color_white, alha_li, color_white,},
			Speed = 0.1
		},
		--main front row red 2
		{
			pos = Vector(170, 43.2, 41.2),
			size = 120,
			Colors = {Color(255, 0, 0, 255), alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(170, -43.2, 41.2),
			size = 120,
			Colors = {alha_li, alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li,},
			Speed = 0.1
		},
		--left side row reds
		{
			pos = Vector(107, 41.2, 42.4),
			size = 120,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.075
		},
		{
			pos = Vector(95, 41.2, 42.4),
			size = 120,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.075
		},
		--left side row whites
		{
			pos = Vector(101, 41.2, 42.4),
			size = 100,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, color_white, alha_li, color_white,},
			Speed = 0.075
		},
		{
			pos = Vector(89, 41.2, 42.4),
			size = 100,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, color_white, alha_li, color_white,},
			Speed = 0.075
		},
		--right side row reds
		{
			pos = Vector(107, -41.2, 42.4),
			size = 120,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255),},
			Speed = 0.075
		},
		{
			pos = Vector(95, -41.2, 42.4),
			size = 120,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255),},
			Speed = 0.075
		},
		--right side row whites
		{
			pos = Vector(101, -41.2, 42.4),
			size = 100,
			Colors = {alha_li, color_white, alha_li, color_white, alha_li, alha_li, alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.075
		},
		{
			pos = Vector(89, -41.2, 42.4),
			size = 100,
			Colors = {alha_li, color_white, alha_li, color_white, alha_li, alha_li, alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.075
		},
		--left side red 1
		{
			pos = Vector(214, 52.2, -46.6),
			size = 80,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(-152, 43, 11.5),
			size = 80,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(5, 50.11, -21.47),
			size = 80,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(-126, 50.11, -21.61),
			size = 80,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		--left side red 2
		{
			pos = Vector(4.13, 33.2, 24.2),
			size = 80,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255),},
			Speed = 0.11
		},
		--right side red 1
		{
			pos = Vector(214, -52.2, -46.6),
			size = 80,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(-116.23, -43.03, 30),
			size = 80,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(-128.34, -43.03, 30),
			size = 80,
			Colors = {alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(-121.34, -43.03, 30),
			size = 80,
			Colors = {alha_li, alha_li, color_white, alha_li, color_white, color_white, color_white, color_white,},
			Speed = 0.1
		},
		{
			pos = Vector(-134.34, -43.03, 30),
			size = 80,
			Colors = {alha_li, alha_li, color_white, alha_li, color_white, color_white, color_white, color_white,},
			Speed = 0.1
		},
		--right side red 2
		{
			pos = Vector(14.4, -33.2, 24.2),
			size = 80,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255),},
			Speed = 0.11
		},
		--front red 1
		{
			pos = Vector(217, 25.9, -18.8),
			size = 80,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li,},
			Speed = 0.1
		},
		{
			pos = Vector(217, -25.9, -18.8),
			size = 80,
			Colors = {Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, Color(255, 0, 0, 255), alha_li, alha_li, alha_li, alha_li, alha_li, alha_li, alha_li,},
			Speed = 0.1
		},
		--front red 2
		{
			pos = Vector(241.7, 42.1, -46.8),
			size = 160,
			Colors = {Color(255, 0, 0, 60), Color(255, 0, 0, 80), Color(255, 0, 0, 100), Color(255, 0, 0, 120), Color(255, 0, 0, 140), Color(255, 0, 0, 160), Color(255, 0, 0, 180), Color(255, 0, 0, 200), Color(255, 0, 0, 220), Color(255, 0, 0, 240), Color(255, 0, 0, 255), Color(255, 0, 0, 240), Color(255, 0, 0, 220), Color(255, 0, 0, 200), Color(255, 0, 0, 180), Color(255, 0, 0, 160), Color(255, 0, 0, 140), Color(255, 0, 0, 120), Color(255, 0, 0, 100), Color(255, 0, 0, 80), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60),},
			Speed = 0.02
		},
		{
			pos = Vector(241.7, -42.1, -46.8),
			size = 160,
			Colors = {Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 60), Color(255, 0, 0, 80), Color(255, 0, 0, 100), Color(255, 0, 0, 120), Color(255, 0, 0, 140), Color(255, 0, 0, 160), Color(255, 0, 0, 180), Color(255, 0, 0, 200), Color(255, 0, 0, 220), Color(255, 0, 0, 240), Color(255, 0, 0, 255), Color(255, 0, 0, 240), Color(255, 0, 0, 220), Color(255, 0, 0, 200), Color(255, 0, 0, 180), Color(255, 0, 0, 160), Color(255, 0, 0, 140), Color(255, 0, 0, 120), Color(255, 0, 0, 100), Color(255, 0, 0, 80), Color(255, 0, 0, 60),},
			Speed = 0.02
		},
		--back whites
		{
			pos = Vector(-157.6, -41.4, -44.6),
			size = 70,
			Colors = {alha_li, alha_li, alha_li, alha_li, alha_li, color_white, alha_li, color_white,},
			Speed = 0.11
		},
	},
	DelayOn = 0,
	DelayOff = 0,
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(217, 32.8, -18.9),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-149, 42.8, -38.8),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
		},
		Right = {
			{
				pos = Vector(217, -32.8, -18.9),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
			{
				pos = Vector(-149, -42.8, -38.8),
				size = 70,
				color = Color(255, 136, 0, 150),
			},
		},
	},
	SubMaterials = {
		off = {
			Base = {
				[5] = "",
				[9] = "",
				[8] = "",
			},
			Brake = {
				[5] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[5] = "",
				[9] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
				[8] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_highbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
				[8] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "",
			},
			Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[9] = "models/left4dead/vehicles/4carz1024_lights_on",
				[8] = "models/left4dead/vehicles/4carz1024_lights_on",
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
	},
}

list.Set("simfphys_lights", "l4d_fire_engine", light_table)