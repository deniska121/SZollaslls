local V = {
	Name = "Скорая помощь",
	Model = "models/left4dead/vehicles/ambulance.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Гос департамент",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 90,
	NAKGame = "Left 4 Dead 2",
	NAKType = "Government",

	Members = {
		Mass = 2500,
		
		EnginePos = Vector(112,0,41),
		
		LightsTable = "ambulance",
		
		CustomWheels = true,
		CustomSuspensionTravel = 1.5,
		
		CustomWheelModel = "models/left4dead/vehicles/wheelambulance.mdl",
		CustomWheelModel_R = "models/left4dead/vehicles/wheelambulance2.mdl",
		
		OnSpawn = function(ent)
			ent.fdoornum = 0
			ent.fdoorMoving = false
			
			ent.rdoornum = 0
			ent.rdoorMoving = false
			
			ent.rrdoornum = 0
			ent.rrdoorMoving = false
			
			ent.fdoorstate = 0
			ent.rdoorstate = 0
			ent.rrdoorstate = 0
			ent.LastThink = 0
			ent.LastThink2 = 0
			ent.LastThink3 = 0
			ent.ChangeRate = 1
			
			--color, brightness, texture, light fov, distance
			local c = Color(255,255,255)
			local b = 8
			local tex = "effects/flashlight/soft"
			local fov = 120
			local dist = 2048
			
			ent.leftlight = ents.Create( "env_projectedtexture" )
		
			ent.leftlight:FollowBone(ent, 0)
			ent.leftlight:SetPos( ent:GetPos() ) --first set the position to the parent
			ent.leftlight:SetLocalPos( Vector(-76,59,98) ) --THEN offset the position to the desired one
			ent.leftlight:SetAngles( ent:GetAngles() + Angle(15,90,0) ) --angles can be set normally
		
			ent.leftlight:SetKeyValue( "enableshadows", 1 )
			ent.leftlight:SetKeyValue( "lightfov", fov )
			ent.leftlight:SetKeyValue( "nearz", 12 )
			ent.leftlight:SetKeyValue( "farz", dist )
			ent.leftlight:SetKeyValue( "lightcolor", Format( "%i %i %i 255", c.r * b, c.g * b, c.b * b ) )
		
			ent.leftlight:Spawn()
		
			ent.leftlight:Input( "SpotlightTexture", NULL, NULL, tex )
			
			ent.rightlight = ents.Create( "env_projectedtexture" )
			
			ent.rightlight:FollowBone(ent, 0)
			ent.rightlight:SetPos( ent:GetPos() ) --first set the position to the parent
			ent.rightlight:SetLocalPos( Vector(-76,-59,98) ) --THEN offset the position to the desired one
			ent.rightlight:SetAngles( ent:GetAngles() + Angle(15,-90,0) ) --angles can be set normally
		
			ent.rightlight:SetKeyValue( "enableshadows", 1 )
			ent.rightlight:SetKeyValue( "lightfov", fov )
			ent.rightlight:SetKeyValue( "nearz", 12 )
			ent.rightlight:SetKeyValue( "farz", dist )
			ent.rightlight:SetKeyValue( "lightcolor", Format( "%i %i %i 255", c.r * b, c.g * b, c.b * b ) )
		
			ent.rightlight:Spawn()
		
			ent.rightlight:Input( "SpotlightTexture", NULL, NULL, tex )
			
			ent.leftlight:Fire("turnoff")
			ent.rightlight:Fire("turnoff")
			
			ent.lightnum = 0
			ent.lightcooldown = false
			
			ent.lightstart = CreateSound(ent, "left4dead/vehicles/ambulance_light_start.wav" )
			ent.lightstop = CreateSound(ent, "left4dead/vehicles/ambulance_light_stop.wav" )
			ent.lightstart:SetSoundLevel( 40 )
			ent.lightstop:SetSoundLevel( 40 )
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
			
			local function Approach3(Target)
				local now = CurTime()
				local timepassed = now - ent.LastThink3
				ent.LastThink3 = now

				ent.rrdoorstate = math.Approach( ent.rrdoorstate, Target, ent.ChangeRate * timepassed )
			end
			
			local function dooranim()
				local ply = ent:GetDriver()
			
				if !IsValid(ent) then return end
				if !IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
				if !ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI
				
				if ply:KeyDown( 1 ) and ply:KeyDown( 512 ) and IsValid(ent:GetDriver()) then
					if ent.fdoornum == 0 and not ent.fdoorMoving then
						ent.fdoorMoving = true
						ent.fdoornum = 1
						ent.fdoorstate = 0
						ent.LastThink = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_open.wav", ent:GetPos())
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
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.fdoorMoving = false
							end
						end )
					end
				end
				
				if ent.fdoorMoving then
					Approach(ent.fdoornum)
					ent:SetPoseParameter( "left_door", ent.fdoorstate)
				end
				
				if ply:KeyDown( 1 ) and ply:KeyDown( 1024 ) and IsValid(ent:GetDriver()) then
					if ent.rdoornum == 0 and not ent.rdoorMoving then
						ent.rdoorMoving = true
						ent.rdoornum = 1
						ent.rdoorstate = 0
						ent.LastThink2 = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_open.wav", ent:GetPos())
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
						sound.Play( "left4dead/vehicles/ambulance_rear_close.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.rdoorMoving = false
							end
						end )
					end
				end
				
				if ent.rdoorMoving then
					Approach2(ent.rdoornum)
					ent:SetPoseParameter( "right_door", ent.rdoorstate)
				end
				
				if ply:KeyDown( 1 ) and ply:KeyDown( 16 ) and IsValid(ent:GetDriver()) then
					if ent.rrdoornum == 0 and not ent.rrdoorMoving then
						ent.rrdoorMoving = true
						ent.rrdoornum = 1
						ent.rrdoorstate = 0
						ent.LastThink3 = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_open.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.rrdoorMoving = false
							end
						end )
					elseif not ent.rrdoorMoving then
						ent.rrdoorMoving = true
						ent.rrdoornum = 0
						ent.rrdoorstate = 1
						ent.LastThink3 = CurTime()
						sound.Play( "left4dead/vehicles/ambulance_rear_close.wav", ent:GetPos())
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.rrdoorMoving = false
							end
						end )
					end
				end
				
				if ent.rrdoorMoving then
					Approach3(ent.rrdoornum)
					ent:SetPoseParameter( "rear_door", ent.rrdoorstate)
				end
			end
			
			local function lights()
				local ply = ent:GetDriver()
			
				if !IsValid(ent) then return end
				if !IsValid(ent:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
				if !ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI
				
				if ply:KeyDown( 2048 ) and IsValid(ent:GetDriver()) then
					if ent.lightnum == 0 and !ent.lightcooldown then
						ent.leftlight:Fire("turnon")
						ent.rightlight:Fire("turnon")
						ent.lightnum = 1
						ent.lightcooldown = true
						ent:SetSubMaterial( 7, "models/left4dead/vehicles/4carz1024_lights_on" )
						
						ent.lightstart:Play()
						ent.lightstop:Stop()
						
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.lightcooldown = false
							end
						end )
					elseif !ent.lightcooldown then
						ent.leftlight:Fire("turnoff")
						ent.rightlight:Fire("turnoff")
						ent.lightnum = 0
						ent.lightcooldown = true
						ent:SetSubMaterial( 7, "nil" )
						
						ent.lightstart:Stop()
						ent.lightstop:Play()
						
						timer.Simple(1, function()
							if IsValid(ent) then
								ent.lightcooldown = false
							end
						end )
					end
				end
			end
			
			lights()
			dooranim()
		end,
		
		OnDelete = function(ent)
			ent.rightlight:Remove()
			if ent.lightstart then
				ent.lightstart:Stop()
			end
			if ent.lightstop then
				ent.lightstop:Stop()
			end
		end,
		
		CustomWheelPosFL = Vector(84,37.5,10),
		CustomWheelPosFR = Vector(84,-37.5,10),
		CustomWheelPosRL = Vector(-72.5,44,10),
		CustomWheelPosRR = Vector(-72.5,-44,10),
		CustomWheelAngleOffset = Angle(0,270,0),
		
		CustomMassCenter = Vector(0,0,20),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(48,-19,64),
		SeatPitch = -4,
		SeatYaw = 90,
		
		--!!!!!!!!!!!RANDYS EXTRA FUNCTIONS!!!!!!!!!!!!!
		
		LPMountFront = Vector(115,0,25),
		LPMountRear = Vector(-150.6,0,24),
		LPGroup = Plates_L4D,
		
		PolRadioSound = "Simf_PolRadio",
		
		snd_starter = "left4dead/vehicles/van_ignition_start.wav",
		snd_starter_good = "left4dead/vehicles/van_ignition_good.wav",
		snd_starter_bad = "left4dead/vehicles/van_ignition_bad.wav",
		snd_stop = "left4dead/vehicles/van_stop.wav",
		snd_reverse_beep = "vehicles/gen_reverse.wav",
		
		--!!!!!!!!!!!END RANDYS EXTRA FUNCTIONS!!!!!!!!!!
		
		PassengerSeats = {
			{
				pos = Vector(52,-18,37),
				ang = Angle(0,-90,17)
			},
			{
				pos = Vector(-110,45,48),
				ang = Angle(0,180,0)
			},
			{
				pos = Vector(-110,-45,48),
				ang = Angle(0,0,0)
			},
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-148,-31,14),
				ang = Angle(90,180,0),
			},
			{
				pos = Vector(-148,-31,14),
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
		
		FuelFillPos = Vector(-100,56,37.6),
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
		
		DifferentialGear = 0.6,
		Gears = {-0.3,0,0.062,0.119,0.188,0.335,0.602,0.864}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_l4d_ambulance", V )

local light_table = {
	-- projected texture / lamp pos   - front
	L_HeadLampPos = Vector(112,31.8,42.8),
	L_HeadLampAng = Angle(0,0,0),
	R_HeadLampPos = Vector(112,-31.8,42.8),
	R_HeadLampAng = Angle(0,0,0),
	
	-- projected texture - rear
	L_RearLampPos = Vector(-152.4,44.1,27.8),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-152.4,-44.1,27.8),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {   -- lowbeam
		{
			pos = Vector(112,31.8,42.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(112,-31.8,42.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,238,200,150),
		},
		{
			pos = Vector(57,0,90.5),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(57,12.8,90),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(57,-12.8,90),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(31.6,45.5,104.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(31.6,-45.5,104.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(20.9,57,104.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(20.9,-57,104.2),
			material = "l4d/corona",
			size = 40,
			color = Color(255,178,0,150),
		},
	},
	
	Headlamp_sprites = {
		{pos = Vector(112,31.8,42.8),size = 100,material = "l4d/corona"},
		{pos = Vector(112,-31.8,42.8),size = 100,material = "l4d/corona"},
	},
	Rearlight_sprites = {
		{
			pos = Vector(-152.4,44.1,27.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-152.4,-44.1,27.8),
			material = "l4d/corona",
			size = 70,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-140.2,57,104.2),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-140.2,-57,104.2),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-149.7,42.6,104.2),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-149.7,-42.6,104.2),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-149.7,4.4,104.2),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
		{
			pos = Vector(-149.7,-4.4,104.2),
			material = "l4d/corona",
			size = 20,
			color = Color(255,178,0,150),
		},
	},
	Brakelight_sprites = {
		{
			pos = Vector(-152.4,44.1,27.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		},
		{
			pos = Vector(-152.4,-44.1,27.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,0,0,150),
		}
	},
	Reverselight_sprites = {
		{
			pos = Vector(-152.4,46.4,27.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		},
		{
			pos = Vector(-152.4,-46.4,27.8),
			material = "l4d/corona",
			size = 60,
			color = Color(255,255,255,150),
		}
	},
	
	ems_sounds = {"left4dead/vehicles/van_ambulance_wail.wav","left4dead/vehicles/van_ambulance_hilo.wav"},
	ems_sprites = {
		{
			pos = Vector(44.5,19,100),
			material = "l4d/corona",
			size = 180,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,255,0),
					},
			Speed = 0.30
		},
		{
			pos = Vector(44.5,-19,100),
			material = "l4d/corona",
			size = 180,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.30
		},
		{
			pos = Vector(45.5,26.4,93.5),
			material = "l4d/corona",
			size = 60,
			Colors = {	
						Color(0,0,255,255),
						Color(0,0,255,0),
						Color(0,0,255,255),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(45.5,-3.4,93.5),
			material = "l4d/corona",
			size = 60,
			Colors = {	
						Color(0,0,255,255),
						Color(0,0,255,0),
						Color(0,0,255,255),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
						Color(0,0,255,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(45.5,-26.4,93.5),
			material = "l4d/corona",
			size = 60,
			Colors = {	
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(45.5,3.4,93.5),
			material = "l4d/corona",
			size = 60,
			Colors = {	
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(32,45.4,97.2),
			material = "l4d/corona",
			size = 80,
			Colors = {	
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.05
		},
		{
			pos = Vector(32,-45.4,97.2),
			material = "l4d/corona",
			size = 80,
			Colors = {	
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
					},
			Speed = 0.05
		},
		{
			pos = Vector(-150,42.4,89.7),
			material = "l4d/corona",
			size = 80,
			Colors = {	
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(-150,-42.4,89.7),
			material = "l4d/corona",
			size = 80,
			Colors = {	
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
						Color(255,0,0,255),
						Color(255,0,0,0),
					},
			Speed = 0.07
		},
		{
			pos = Vector(-140,57.8,96.8),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,255,0),
					},
			Speed = 0.15
		},
		{
			pos = Vector(21,57.8,96.8),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.15
		},
		{
			pos = Vector(-140,-57.8,96.8),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(0,0,255,255),
						Color(0,0,255,0),
					},
			Speed = 0.15
		},
		{
			pos = Vector(21,-57.8,96.8),
			material = "l4d/corona",
			size = 80,
			Colors = {
						Color(255,0,0,0),
						Color(255,0,0,255),
					},
			Speed = 0.15
		},
	},
	
	DelayOn = 0,
	DelayOff = 0,
	
	Turnsignal_sprites = {
		Left = {
			{
				pos = Vector(111,32,35),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(104,44.5,42.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-152.4,49,27.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
		},
		Right = {
			{
				pos = Vector(111,-32,35),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(104,-44.5,42.5),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
			},
			{
				pos = Vector(-152.4,-49,27.8),
				material = "l4d/corona",
				size = 50,
				color = Color(255,136,0,150),
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
				[6] = "",
			},
			Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
			Brake_Reverse = {
				[5] = "",
				[6] = "models/left4dead/vehicles/4carz1024_lights_on",
			},
		},
		on_lowbeam = {
			Base = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
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
				[6] = "",
			},
			Brake = {
				[5] = "models/left4dead/vehicles/4carz1024_lights_on",
				[6] = "",
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
list.Set( "simfphys_lights", "ambulance", light_table)