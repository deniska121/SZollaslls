local V = {
	Name = "Фургон Infra Maintaince",
	Model = "models/left4dead/vehicles/van_m.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Industrial",

	Members = {
		Mass = 2000,
		
		EnginePos = Vector(112,0,41),
		
		LightsTable = "van",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			
			ent.fdoorstate = 0
			ent.LastThink = 0
			ent.ChangeRate = 1
			
			--[[ent.doormdl = ents.Create( "prop_physics" )
			ent.doormdl:SetModel( "models/left4dead/vehicles/van_door.mdl" )
			
			ent.doormdl:SetPos( ent:GetPos() )
			ent.doormdl:SetAngles( ent:GetAngles() )
			ent.doormdl.DoNotDuplicate = true
			ent.doormdl:SetSolid( 6 )
			ent.doormdl:SetParent( ent ) --new method
			ent.doormdl:Spawn()]] --This solution doesn't work for physics objects, only players
			--TODO: implement a solution that blocks physics objects too
		end,
		
		OnTick = function(ent)
			local function Approach(Target)
				local now = CurTime()
				local timepassed = now - ent.LastThink
				ent.LastThink = now

				ent.fdoorstate = math.Approach( ent.fdoorstate, Target, ent.ChangeRate * timepassed )
			end
			
			local function dooranim()
				local ply = ent:GetDriver()
			
				if !IsValid(ent) then return end
				if !IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
				if !ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI
				
				if ply:KeyDown( 1 ) and IsValid(ent:GetDriver()) then
					if ent.fdoornum == 0 and not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 1
						ent.fdoorstate = 0
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_open.wav", ent:GetPos())
						--ent.doormdl:SetNotSolid(true)
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					elseif not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 0
						ent.fdoorstate = 1
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_close.wav", ent:GetPos())
						--ent.doormdl:SetNotSolid(false)
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					end
				end
				
				if ent.fdoorMoving then
					Approach(ent.fdoornum)
					ent:SetPoseParameter( "rear_door", ent.fdoorstate)
				end
			end
			
			dooranim()
		end,
		
		CustomWheelModel = "models/left4dead/vehicles/wheelambulance.mdl",
		
		CustomWheelPosFL = Vector(84,37.5,12),
		CustomWheelPosFR = Vector(84,-37.5,12),
		CustomWheelPosRL = Vector(-62,37.5,12),
		CustomWheelPosRR = Vector(-62,-37.5,12),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,10),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(48,-19,64),
		SeatPitch = -4,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(115.4,0,23.5),
		LPMountRear = Vector(-115.5,-1.3,21.4),
		LPGroup = Plates_L4D,
		
		RandomBodygroups = {
			{
				number = 1,
			},
			{
				number = 2,
			},
		},
		
		snd_starter = "left4dead/vehicles/van_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/van_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/van_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/van_stop.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(52,-18,37),
				ang = Angle(0,-90,17)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-108,-20,14),
				ang = Angle(90,180,0),
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
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 3,
		
		MaxGrip = 42,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 25,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 120,
		PowerbandStart = 1500,
		PowerbandEnd = 4000,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-33,44,27.6),
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
		Gears = {-0.13,0,0.095,0.15,0.23,0.4,0.7}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_van_m_e", V )

local V2 = {}
V2.Name = "Фургон Infra Maintaince 2"
V2.Model = V.Model
V2.Class = V.Class
V2.Category = V.Category
V2.SpawnOffset = V.SpawnOffset
V2.SpawnAngleOffset = V.SpawnAngleOffset
V2.NAKGame = V.NAKGame
V2.NAKType = V.NAKType

local V2Members = {}
for k,v in pairs(V.Members) do
	V2Members[k] = v
end
V2.Members = V2Members
V2.Members.Attachments = {
	{
		model = "models/props_c17/metalladder001.mdl",
		pos = Vector(-85,-18,95.5),
		ang = Angle(90,0,0)
	},
	{
		model = "models/props_debris/wood_board03a.mdl",
		pos = Vector(-20,22,93.5),
		ang = Angle(90,0,0)
	},
	{
		model = "models/props_debris/wood_board03a.mdl",
		pos = Vector(-20,16,95.5),
		ang = Angle(90,-180,0)
	},
	{
		model = "models/props_debris/wood_board03a.mdl",
		pos = Vector(-20,12,93.5),
		ang = Angle(90,0,0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97,27,41),
		ang = Angle(0,0,0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97,27,44),
		ang = Angle(0,180,0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97,27,47),
		ang = Angle(0,90,0)
	},
	{
		model = "models/props_junk/TrafficCone001a.mdl",
		pos = Vector(-97,27,50),
		ang = Angle(0,0,0)
	},
	{
		model = "models/props_lab/partsbin01.mdl",
		pos = Vector(28,0,50),
		ang = Angle(0,180,0)
	},
	{
		model = "models/props_wasteland/barricade001a.mdl",
		pos = Vector(-11,-17,45),
		ang = Angle(0,6,0)
	},
},
list.Set( "simfphys_vehicles", "sim_fphys_l4d_van_m", V2 )