local V = {
	Name = "Автобусниксыншалавы",
	Model = "models/left4dead/vehicles/bus.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Сервисы",
	SpawnOffset = Vector(0,0,10),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Services",

	Members = {
		Mass = 3525,
		
		EnginePos = Vector(-214,-32.6,137.1),
		
		LightsTable = "l4d_bus",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheel_bus_f.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheel_bus_r.mdl",
		
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			
			ent.rdoornum = 0
			ent.rdoorMoving = false
			
			ent.fdoorstate = 0
			ent.rdoorstate = 0
			ent.LastThink = 0
			ent.LastThink2 = 0
			ent.ChangeRate = 1
		end,
		
		OnTick = function(ent)
			local function Approach(Target)
				local now = CurTime()
				local timepassed = now - ent.LastThink
				ent.LastThink = now

				ent.fdoorstate = math.Approach( ent.fdoorstate, Target, ent.ChangeRate * timepassed )
			end
			
			local function Approach2(Target)
				local now = CurTime()
				local timepassed = now - ent.LastThink2
				ent.LastThink2 = now

				ent.rdoorstate = math.Approach( ent.rdoorstate, Target, ent.ChangeRate * timepassed )
			end
			
			local ply = ent:GetDriver()
			
			if !IsValid(ent) then return end
			if !IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
			if !ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI
			
			local function dooranim()
				if ply:KeyDown( 1 ) and IsValid(ent:GetDriver()) then
					if ent.fdoornum == 0 and not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 1
						ent.fdoorstate = 0
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/bus_fdoor_open.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					elseif not ent.fdoorMoving then
						ent:SetPoseParameter( "front_door", ent.fdoorstate)
						ent.fdoorMoving = true
						ent.fdoornum = 0
						ent.fdoorstate = 1
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/bus_fdoor_close.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					end
				end
				
				if ent.fdoorMoving then
					Approach(ent.fdoornum)
					ent:SetPoseParameter( "front_door", ent.fdoorstate)
				end
				
				if ply:KeyDown( 2048 ) and IsValid(ent:GetDriver()) then
					if ent.rdoornum == 0 and not ent.rdoorMoving then
						ent.rdoorMoving = true
						ent.rdoornum = 1
						ent.rdoorstate = 0
						ent.LastThink2 = CurTime()
						sound.Play( "left4dead/vehicles/bus_rdoor_open.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.rdoorMoving = false
							end
						end )
					elseif not ent.rdoorMoving then
						ent.rdoorMoving = true
						ent.rdoornum = 0
						ent.rdoorstate = 1
						ent.LastThink2 = CurTime()
						sound.Play( "left4dead/vehicles/bus_rdoor_close.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.rdoorMoving = false
							end
						end )
					end
				end
				
				if ent.rdoorMoving then
					Approach2(ent.rdoornum)
					ent:SetPoseParameter( "rear_door", ent.rdoorstate)
				end
				
				if IsValid(ply) then
					if ply:GetInfoNum( "cl_simfphys_bus_safety_brakes", 0 ) == 1 then
						if ent.rdoorstate > 0.1 or ent.fdoorstate > 0.1 then
							ent.PressedKeys["joystick_handbrake"] = 1
						end
					end
				end
			end
			
			local ConVarValue = ply:GetInfoNum( "cl_simfphys_bus_safety_brakes", 0 )
			
			if ConVarValue == 1 then
				if ent.ForwardSpeed < 100 then
					dooranim()
				end
			else
				dooranim()
			end
		end,
		
		CustomWheelPosFL = Vector(148.3,46.8,10),
		CustomWheelPosFR = Vector(148.3,-46.8,10),
		CustomWheelPosRL = Vector(-98.9,39,10),
		CustomWheelPosRR = Vector(-98.9,-39,10),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,35),
		
		CustomSteerAngle = 50,
		
		SeatOffset = Vector(177,-27,118),
		SeatPitch = 10,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(239.5,0,35),
		LPMountRear = Vector(-237.7,-31.2,41.4),
		LPGroup = Plates_L4D,
		
		AllowRandomColors = true,
		RandomColorMin = 10,
		RandomColorMax = 100,
		
		RandomBodygroups = {
			{
				number = 4,
				max = 3,
			},
			{
				number = 5,
				min = 1,
				max = 2,
			},
		},
		
		AllowRandomSkins = true,
		RandomSkinRange = {0,1},
		
		HasAirbrakes = true,
		
		snd_starter = "left4dead/vehicles/bus_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/bus_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/bus_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/bus_stop.wav",
		snd_reverse_beep = "left4dead/vehicles/bus_rev_beep.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(161,-37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(161,37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(128,-37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(128,37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(96,-37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(96,37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(54,-36,58),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(14,-36,58),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(54,36,58),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(14,36,58),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-26,-37,58),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-26,37,58),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-67,-37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-67,37,58),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-107,-37,58),
				ang = Angle(0,90,0)
			},
			{
				pos = Vector(-107,37,58),
				ang = Angle(0,90,0)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-214,-32.6,137.1),
				ang = Angle(90,180,0),
			},
			{
				pos = Vector(-214,-32.6,137.1),
				ang = Angle(90,180,0),
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
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 100,
		
		TurnSpeed = 3,
		
		MaxGrip = 62,
		Efficiency = 1,
		GripOffset = 1.5,
		BrakePower = 35,
		
		IdleRPM = 800,
		LimitRPM = 5000,
		PeakTorque = 80,
		PowerbandStart = 1500,
		PowerbandEnd = 3000,
		Turbocharged = false,
		Supercharged = true,
		
		FuelFillPos = Vector(-200,51.3,37.1),
		FuelType = 2,
		FuelTankSize = 120,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,

		
		Sound_Idle = "left4dead/vehicles/bus_idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "left4dead/vehicles/bus_low.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 2,
		Sound_MidFadeOutRPMpercent = 40,
		Sound_MidFadeOutRate = 0.5,
		
		Sound_High = "left4dead/vehicles/bus_high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1.5,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.5,
		
		Sound_Throttle = "left4dead/vehicles/bus_throttle.wav",
		Sound_ThrottlePitch = 1,
		Sound_ThrottleVolume = 5,
		
		--
		snd_horn = "left4dead/vehicles/bus_horn.wav",
		snd_bloweron = "left4dead/vehicles/bus_turbo.wav",
		snd_bloweroff = "common/null.wav",
		
		DifferentialGear = 0.35,
		Gears = {-0.075,0,0.055,0.125,0.2,0.275,0.375}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_bus", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(240.4,35.2,38.3),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(240.4,-35.2,38.3),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-238.1,39,62.5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-238.1,-39,62.5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(240.4,35.2,38.3),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(240.4,-35.2,38.3),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(177.5,51.6,46.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(177.5,-51.6,46.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(115,51.6,54.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(0,51.6,54.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-163.4,51.6,54.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(115,-51.6,54.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(0,-51.6,54.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-130.8,-51.6,46.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-130.8,51.6,46.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(238.7,10.4,124.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(238.7,0,124.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(238.7,-10.4,124.4),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(240.4,26.1,38.3),size = 100,material = "l4d/corona"},
		{pos = Vector(240.4,-26.1,38.3),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-238.1,39,62.5),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-238.1,-39,62.5),
			material = "l4d/corona",
			size = 80,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-227,32.7,129.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-227,0,131.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-227,-32.7,129.7),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-238.1,39,71.4),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-238.1,-39,71.4),
			material = "l4d/corona",
			size = 100,
			color = Color(255,0,0,150),
		},
	},
	Reverselight_sprites = {
		{
			pos = Vector(-238.1,0,81.3),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(240.3,30.7,44.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(239,31,118.4),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(229.7,51.7,61.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-227.4,51.7,61.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-238.1,38.9,54.9),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(240.3,-30.7,44.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(239,-31,118.4),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(229.7,-51.7,61.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-227.4,-51.7,61.6),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-238.1,-38.9,54.9),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[2] = "",
				[4] = "",
				[5] = "",
				[3] = "",
			},
			Brake = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
				[3] = "",
			},
			Reverse = {
				[2] = "",
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[2] = "",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
		},
		on_lowbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "",
				[3] = "",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
				[3] = "",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "",
			},
		},
		on_highbeam = {
			Base = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[2] = "models/left4dead/vehicles/4carz1024_lights_on",
				[4] = "models/left4dead/vehicles/4carz1024_lights_on",
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[3] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		turnsignals = {
			left = {
				[6] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
			right = {
				[7] = "models/left4dead/vehicles/4carz1024_lights_on"
			},
		},
	}
}
list.Set( "simfphys_lights", "l4d_bus", light_table)