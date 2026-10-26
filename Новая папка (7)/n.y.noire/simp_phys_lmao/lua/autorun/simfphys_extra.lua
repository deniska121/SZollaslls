--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/autorun/simfphys_extra.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sound.Add({
	name = "REV_BEEP",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 75,
	sound = "reverse_beep.wav"
})

--basically just a reused script from my GTA 4 mod, the code is very not good probably
REN = istable(REN) and REN or {} --define table to store all functions in

function REN.ActivateHorn(self, bool)
	if not self.horn then
		self.horn = CreateSound(self, self.snd_horn or "simulated_vehicles/horn_1.wav")
		self.horn:PlayEx(0, 100)
	end

	self.HornKeyIsDown = bool
	self:ControlHorn()
end

function REN.L4D2ReverseBeep(self)
	if self:GetGear() == 1 and self:EngineActive() then
		self:CreateLoopingSound("revsound", "REV_BEEP", 75):Play()
	else
		self:StopLoopSounds("revsound")
	end
end

--handbrake noise
function REN.L4D2Handbrake(self)
	local ply = self:GetDriver()
	if not IsValid(self) then return end
	if not IsValid(self.DriverSeat) then return end --if there is no driver, end the script, otherwise it would error
	if not IsValid(self.DriverSeat:GetDriver()) then return end --if there is no driver, end the script, otherwise it would error
	if not ply:IsPlayer() then return end --checks if the driver is an actual player, not an AI
	local filter = RecipientFilter()

	if IsValid(self:GetDriver()) then
		filter:AddPlayer(ply)
	end

	self.HandbrakeSND = CreateSound(self, "left4dead/vehicles/STANDARD_HANDBRAKE.wav", filter)
	self.HandbrakeSND:SetSoundLevel(70)

	if self:GetHandBrakeEnabled() then
		if self.CanHandbrake then
			self.HandbrakeSND:Play()
		end

		self.CanHandbrake = false
	end

	if not self:GetHandBrakeEnabled() then
		self.CanHandbrake = true
	end
end

--engine shutdown
function REN.L4D2EngStop(ent, Bank)
	ent.StopEngine = function(self)
		if self:EngineActive() then
			self:EmitSound("left4dead/vehicles/" .. Bank .. "_stop.wav")
			self.EngineRPM = 0
			self.EngineIsOn = 0
			self:SetFlyWheelRPM(0)
			self:SetIsCruiseModeOn(false)
		end
	end
end

function REN.L4D2AlarmInit(self)
	self.ALRM = CreateSound(self, "left4dead/vehicles/alarms/car_alarm" .. math.random(1, 5) .. ".wav") --picks an alarm sound
	self.ALRM:SetSoundLevel(90)
	self.CurHealthGot = false
	self.ALRMon = false
	self.ALRMArmed = false
	self.CurHealthLocked = self:GetHullHealth()
	self.ALRMRnd = math.random(0, 2)
end

local function ChirpAlarmLocked(self)
	if self.NoAlarmClose then return end
	if self.ALRMRnd == 2 then
		self.ALRM:Play()
	else
		REN.ActivateHorn(self, true)
	end

	self:SetLightsEnabled(true)

	timer.Simple(0.1, function()
		if IsValid(self) then
			self:SetLightsEnabled(false)

			if self.ALRMRnd == 2 then
				self.ALRM:Stop()
			else
				REN.ActivateHorn(self, false)
			end
		end
	end)
end

local function ChirpAlarmUnLocked(self)
	if self.ALRMRnd == 2 then
		self.ALRM:Play()
	else
		REN.ActivateHorn(self, true)
	end

	timer.Simple(0.12, function()
		if IsValid(self) then
			self:SetLightsEnabled(true)

			if self.ALRMRnd == 2 then
				self.ALRM:Stop()
			else
				REN.ActivateHorn(self, false)
			end
		end
	end)

	timer.Simple(0.24, function()
		if IsValid(self) then
			if self.ALRMRnd == 2 then
				self.ALRM:Play()
			else
				REN.ActivateHorn(self, true)
			end
		end
	end)

	timer.Simple(0.36, function()
		if IsValid(self) then
			self:SetLightsEnabled(false)

			if self.ALRMRnd == 2 then
				self.ALRM:Stop()
			else
				REN.ActivateHorn(self, false)
			end
		end
	end)
end

local function TurnOffAlarm(self)
	if not self.ALRMArmed then return end

	if self.ALRMon and self.ALRM then
		self.ALRM:Stop()
	end

	if timer.Exists("L4D2_ALARM_" .. self:EntIndex()) then
		timer.Remove("L4D2_ALARM_" .. self:EntIndex())
	end

	self:SetLightsEnabled(false)
	self.ALRMon = false
	self.ALRMed = false
	self.CurHealthGot = false
end

function REN.L4D2Alarm(self, ALRMVal)
	if self:EngineActive() then return end
	if self.ALRMRnd == 0 then return end

	if self:GetIsVehicleLocked() and not IsValid(self:GetDriver()) then
		if not self.CurHealthGot then
			self.CurHealthLocked = self:GetHullHealth()
		end

		self.CurHealthGot = true

		if not self.ALRMArmed then
			ChirpAlarmLocked(self)
		end

		self.ALRMArmed = true

		if self:GetHullHealth() < self.CurHealthLocked or self.lokepiked then
			self.ALRMon = true
			self.lokepiked = nil
			if self.ALRMRnd == 2 then
				self.ALRM:Play()
			end

			if self.ALRMed then return end

			if not timer.Exists("L4D2_ALARM_" .. self:EntIndex()) then
				timer.Create("L4D2_ALARM_" .. self:EntIndex(), 1, 1, function()
					self:SetLightsEnabled(true)

					if self.ALRMRnd == 1 then
						REN.ActivateHorn(self, true)
					end

					timer.Simple(0.5, function()
						if IsValid(self) then
							self:SetLightsEnabled(false)

							if self.ALRMRnd == 1 then
								REN.ActivateHorn(self, false)
							end
						end
					end)
				end)
			end

			if not timer.Exists("L4D2_ALARM_KILL_" .. self:EntIndex()) and self.ALRMon then
				timer.Create("L4D2_ALARM_KILL_" .. self:EntIndex(), math.random(15, 25), 1, function()
					if IsValid(self) then
						TurnOffAlarm(self)
						self.ALRMed = true
					end
				end)
			end
		end
	else
		if self.ALRMArmed and not IsValid(self:GetDriver()) then
			ChirpAlarmUnLocked(self)
		end

		timer.Remove("L4D2_ALARM_KILL_" .. self:EntIndex())
		TurnOffAlarm(self)
		self.ALRMed = false
		self.ALRMArmed = false
	end
end

function REN.SetLicensePlateNumber(ent, num)
	for i = 1, 8 do
		if string.sub(num, i, i) == " " then
			ent:SetSubMaterial(i, "null")
		else
			ent:SetSubMaterial(i, "models/left4dead/vehicles/plate/" .. string.sub(num, i, i))
		end
	end
end

function REN.AttachLicensePlates(self)

	if not self.McCD_UniqueId then
		self.McCD_UniqueId = DarkRP.GenLPlate(self:EntIndex())
	end

	if self.LPMountFront then

		self.frontplt = ents.Create("prop_dynamic")
		self.frontplt:SetModel("models/cityrp/license_nyc.mdl")
		self.frontplt:SetColor(color_black)
		self.frontplt.DoNotDuplicate = true

		self.frontplt:SetAngles(self:GetAngles())

		if self.LPRotateFront then
			self.frontplt:SetAngles(self:GetAngles() + self.LPRotateFront)
		end

		self.frontplt:SetPos(self:LocalToWorld(self.LPMountFront))
		self.frontplt:SetParent(self)
		self.frontplt:Spawn()

		self:CallOnRemove("RemoveFrontLP", function(s)
			s.frontplt:Remove()
		end)

		REN.SetLicensePlateNumber(self.frontplt, self.McCD_UniqueId)

		if self.customplates then
			self.frontplt:SetSubMaterial(0, self.customplates)
		end
	end

	if self.LPMountRear then
		self.rearplt = ents.Create("prop_dynamic")
		self.rearplt:SetModel("models/cityrp/license_nyc.mdl")
		self.rearplt:SetColor(color_black)
		self.rearplt.DoNotDuplicate = true
		self.rearplt:SetAngles(self:GetAngles())
		local angles = self.rearplt:GetAngles()
		if self.LPRotateRear then angles = angles + self.LPRotateRear end
		angles:RotateAroundAxis(self.rearplt:GetUp(), 180)
		self.rearplt:SetAngles(angles)
		self.rearplt:SetPos(self:LocalToWorld(self.LPMountRear))
		self.rearplt:SetParent(self)
		self.rearplt:Spawn()
		self:CallOnRemove("RemoveRearLP", function(s)
			s.rearplt:Remove()
		end)

		REN.SetLicensePlateNumber(self.rearplt, self.McCD_UniqueId)

		if self.customplates then
			self.rearplt:SetSubMaterial(0, self.customplates)
		end
	end
end

function REN.L4D2SimfphysInit(self, Name)
	if file.Exists("sound/left4dead/vehicles/" .. Name .. "_stop.wav", "GAME") then
		REN.L4D2EngStop(self, Name)
	end

	REN.L4D2AlarmInit(self)

	timer.Simple(0.1, function() if not IsValid(self) then return end REN.AttachLicensePlates(self) end)
end

function REN.L4D2Delete(self)
	timer.Remove("L4D2_ALARM_" .. self:EntIndex())
	timer.Remove("L4D2_ALARM_KILL_" .. self:EntIndex())

	if self.ALRM then
		self.ALRM:Stop()
		self.ALRM = nil
	end

	if self.HandbrakeSND then
		self.HandbrakeSND:Stop()
		self.HandbrakeSND = nil
	end

	if self.horn then
		self.horn:Stop()
		self.horn = nil
	end

	if self.trunklist then
		for _,v in pairs(self.trunklist) do
			if not IsValid(v) then continue end
			v:SetParent(nil)
			v:PhysicsInit(SOLID_VPHYSICS)
			if IsValid(v:GetPhysicsObject()) then
				v:GetPhysicsObject():EnableMotion(true)
			end
			v:SetPos(v:GetPos())
			v.Draged = nil
		end
	end
end

function REN.L4D2SimfphysOnTick(self, RevBeep)
	REN.L4D2Handbrake(self)
	REN.L4D2Alarm(self)

	if (RevBeep == 1) then
		REN.L4D2ReverseBeep(self)
	end
end

function REN.TrunkPareEnt(ent, v)
	if not IsValid(v) or not simfphys.pikup_class[v:GetClass()] or v.Draged or v.DoNotDuplicate or IsValid(v:GetParent()) or not IsValid(v:GetPhysicsObject()) or not v:GetPhysicsObject():IsMoveable() then return end
	v.Draged = true
	v:SetMoveType(MOVETYPE_NONE)

	if IsValid(v:GetPhysicsObject()) then
		v:GetPhysicsObject():EnableMotion(false)
	end

	v:SetParent(ent)
	table.insert(ent.trunklist, v)
end

function REN.L4D2SimfphysAttachToCar(veh, owner)
	local CT = CurTime()
	if veh.LastUse and veh.LastUse > CT then return end

	veh.LastUse = CT + 2

	if veh:GetVelocity():LengthSqr() > 200 then
		veh:EmitSound("buttons/lever7.wav")
		return
	end

	local pos = veh:GetPos()

	local trace = util.TraceLine({
		start = pos + Vector(0, 0, 27),
		endpos = pos + veh:GetForward() * -250 + Vector(0, 0, 27),
		filter = veh
	})

	local ent = trace.Entity

	if not IsValid(veh.IsTowing) then
		if not IsValid(ent) or not ent.IsSimfphyscar then return end
		if IsValid(ent.Towed) then return end
		if ent.IsECPDVeh then return end

		local Driver = ent:GetDriver()
		if IsValid(Driver) then
			return
		end

		local phys = ent:GetPhysicsObject()
		if not IsValid(phys) then return end
		if phys:GetMass() > 8000 then return end
		veh.LastUse = CT + 5
		-- Everything is good, so we hook em up!
		for i = 0,1 do
			local mult = i == 0 and -1 or 1
			local orient = ent.TrunkPos and ent:GetRight() or ent:GetForward()
			local carfront = ent:NearestPoint(ent:GetPos() + Vector(0, 0, 20) + (orient * 200) * mult)
			local carfronthookpos = ent:NearestPoint(ent:GetPos() + Vector(0, 0, 20) + (orient * 105) * mult)

			if carfront:DistToSqr(pos + veh:GetForward() * -133.3848 + veh:GetUp() * 47.928) < 12000 and IsValid(veh) and IsValid(ent) and not IsValid(ent:GetDriver()) then

				local attach_tow_pos = Vector(-143.77, 0, 104.94)

				--local rope = constraint.Rope(veh, ent, 0, 0, attach_tow_pos, ent:WorldToLocal(carfronthookpos), attach_rope_lenght, 0, 0, 2, "cable/cable2", false)
				local rope, _, con = constraint.Winch( nil, veh, ent, 0, 0, attach_tow_pos, ent:WorldToLocal(carfronthookpos), 2, 1, 1, 15, 15, "l4d/cable",false, nil )
				veh.IsTowing = rope
				ent.Towed = rope
				ent.TowedCar = veh
				veh.TowedCar = ent
				con.min_length = 30
				con:SetDirection( -1 )
				veh:EmitSound("vehicles/crane/crane_magnet_grab.wav")
				ent:SetActive(true)

				if IsValid(Driver) then
					Driver:ExitVehicle()
				end
				if istable(ent.pSeat) then
					for oi = 1, #ent.pSeat do
						if IsValid(ent.pSeat[oi]) then
							local dd = ent.pSeat[oi]:GetDriver()
							if IsValid(dd) then
								dd:ExitVehicle()
							end
						end
					end
				end

				return
			end
		end
	else
		if IsValid(veh) and IsValid(veh.IsTowing) then
			--constraint.RemoveConstraints(veh, "Rope")
			veh.IsTowing:Remove()
			if IsValid(veh.TowedCar) then
				veh.TowedCar:SetGear(1)
				veh.TowedCar:SetActive(false)
			end
			veh.IsTowing = nil
			veh.TowedCar = nil
			veh:EmitSound("ambient/machines/catapult_throw.wav")
			--DarkRP.notify(owner, 1, CH_TowTruck.Config.NotificationTime, CH_TowTruck.Config.Lang["Vehicle successfully unattached!"][CH_TowTruck.Config.Language])
		end
	end
end

function REN.L4D2HandleTrailer(ent)
	local ply = ent:GetDriver()
	if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

	if IsValid(ent.Trailer) then
		local trailer = ent.Trailer
		local brakes = ent:GetIsBraking()

		if ent.PressedKeys.S == 1 then
			brakes = true
		elseif ent.PressedKeys.joystick_brake == 1 then
			brakes = true
		end

		local reverseLights = false

		if (ent.GearRatio or 0) < 0 then
			reverseLights = true
		end

		trailer:SetEMSEnabled(((not reverseLights) and brakes) and 3 or 0)
		trailer:SetLightsEnabled(ent:GetLightsEnabled())
		trailer:SetFogLightsEnabled(ent:GetFogLightsEnabled())
		trailer.PressedKeys.joystick_brake = ((reverseLights or brakes) and 1) or 0

		if trailer.PressedKeys.joystick_brake == 1 then
			trailer.PressedKeys.joystick_throttle = 0
		elseif trailer.PressedKeys.joystick_brake == 0 then
			trailer.PressedKeys.joystick_throttle = 1
		end

		trailer:ForceGear(ent.CurrentGear)
		trailer.PressedKeys.joystick_handbrake = (ent.PressedKeys.Space and 1) or (ent.PressedKeys.joystick_handbrake or 0)

		if trailer.TSMode ~= ent.TSMode then
			net.Start("simfphys_turnsignal")
			net.WriteEntity(trailer)
			net.WriteUInt(ent.TSMode or 0, 3)
			net.Broadcast()
		end

		trailer.TSMode = ent.TSMode

		if (ent.lastTick and ent.lastTick > CurTime()) or not (ent.PressedKeys and ent.PressedKeys["Lock"]) then return end
		ent.lastTick = CurTime() + 10
		ent:EmitSound("vcmod/air_brake.wav")

		trailer:SetGear(1)
		trailer:SetActive(false)
		trailer:SetEMSEnabled(0)
		trailer:SetLightsEnabled(false)
		trailer:SetFogLightsEnabled(false)
		trailer.PressedKeys.joystick_throttle = 0
		trailer.PressedKeys.joystick_brake = 0
		trailer.PressedKeys.joystick_handbrake = 0
		trailer:SetPoseParameter("trailer_braces", 0)
		ent.Trailer = nil
		trailer.AsTrailer = nil

		if IsValid(ent.soket) then
			ent.soket:Remove()
		end

		if IsValid(trailer.supportphys) then
			trailer.supportphys:SetNotSolid(false)
		end

		return
	end

	if (ent.lastTick and ent.lastTick > CurTime()) or not (ent.PressedKeys and ent.PressedKeys["Lock"]) then return end
	ent.lastTick = CurTime() + 10

	ent:EmitSound("vcmod/air_brake.wav")

	for _, car in ipairs(ents.FindInSphere(ent:LocalToWorld(ent.Trailers.outputPos), 50)) do
		if not car.IsTrailer or not car.Trailers or not car.Trailers.inputPos then continue end
		local outputPos = ent:LocalToWorld(ent.Trailers.outputPos)
		local inputPos = car:LocalToWorld(car.Trailers.inputPos)
		local targetVec = inputPos - outputPos
		targetVec:Div(2)
		local truckTargetPos = ent:GetPos()
		truckTargetPos:Add(targetVec)
		targetVec:Mul(-1)
		local trailerTargetPos = car:GetPos()
		trailerTargetPos:Add(targetVec)
		ent:SetPos(truckTargetPos)
		car:SetPos(trailerTargetPos)
		local soket = constraint.AdvBallsocket(ent, car, 0, 0, ent.Trailers.outputPos, car.Trailers.inputPos, 0, 0, 0, 0, 0, 360, 360, 360, 0, 0, 0, 0, 0)
		ent.soket = soket
		ent.Trailer = car
		car.soket = soket
		car.AsTrailer = ent
		car:SetActive(true)
		ent:EmitSound("vcmod/truck_connect.wav")
		car:SetPoseParameter("trailer_braces", 1)

		if IsValid(car.supportphys) then
			car.supportphys:SetNotSolid(true)
		end
	end
end

function REN.L4D2HandleTow(ent)
	local ply = ent:GetDriver()
	if not IsValid(ent) or not IsValid(ply) or not ply:IsPlayer() then return end

	if IsValid(ent.TowedCar) then
		local trailer = ent.TowedCar
		local brakes = ent:GetIsBraking()

		if ent.PressedKeys.S == 1 then
			brakes = true
		elseif ent.PressedKeys.joystick_brake == 1 then
			brakes = true
		end

		local reverseLights = false

		if (ent.GearRatio or 0) < 0 then
			reverseLights = true
		end

		trailer.PressedKeys.joystick_brake = ((reverseLights or brakes) and 1) or 0

		if trailer.PressedKeys.joystick_brake == 1 then
			trailer.PressedKeys.joystick_throttle = 0
		elseif trailer.PressedKeys.joystick_brake == 0 then
			trailer.PressedKeys.joystick_throttle = 1
		end

		trailer:ForceGear(ent.CurrentGear)
		trailer.PressedKeys.joystick_handbrake = (ent.PressedKeys.Space and 1) or (ent.PressedKeys.joystick_handbrake or 0)

		return
	end
end