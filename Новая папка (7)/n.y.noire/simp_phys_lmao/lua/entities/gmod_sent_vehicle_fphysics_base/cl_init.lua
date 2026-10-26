--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/entities/gmod_sent_vehicle_fphysics_base/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

function ENT:Initialize()
	self.sitnpc = {}
	self.npcinfo = {}
	self.sounds = {}
	self.SmoothRPM = 0
	self.OldDist = 0
	self.PitchOffset = 0
	self.OldActive = false
	self.OldGear = 0
	self.OldThrottle = 0
	self.FadeThrottle = 0
	self.SoundMode = 0
	self.DamageSnd = CreateSound(self, "simulated_vehicles/engine_damaged.wav")
	self.EngineSounds = {}

	local tbl = list.Get("simfphys_vehicles")[self:GetSpawn_List()]
	self.VehicleName = tbl.Name
	self.VHL = tbl.Members or false
end

function ENT:Think()
	local curtime = CurTime()

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 23000000 then
		self:NextThink(curtime)

		return true
	end

	local Active = self:GetActive()
	local Throttle = self:GetThrottle()
	local LimitRPM = self:GetLimitRPM()
	self:ManageSounds(Active, Throttle, LimitRPM)
	self.RunNext = self.RunNext or 0

	if self.RunNext < curtime then
		self:ManageEffects(Active, Throttle, LimitRPM)
		self:CalcFlasher()
		self.RunNext = curtime + 0.06
	end

	self:SetPoseParameters(curtime)
	self:NextThink(curtime)

	return true
end

function ENT:CalcFlasher()
	self.Flasher = self.Flasher or 0
	local flashspeed = self.turnsignals_damaged and 0.06 or 0.0375
	self.Flasher = self.Flasher and self.Flasher + flashspeed or 0

	if self.Flasher >= 1 then
		self.Flasher = self.Flasher - 1
	end

	self.flashnum = math.min(math.abs(math.cos(math.rad(self.Flasher * 360)) ^ 2 * 1.5), 1)
	if not self.signal_left and not self.signal_right then return end
	if self:GetBattery() <= 15 then return end
	if LocalPlayer() == self:GetDriver() then
		local fl_snd = self.flashnum > 0.9

		if fl_snd ~= self.fl_snd then
			self.fl_snd = fl_snd

			if fl_snd then
				self:EmitSound("simulated_vehicles/sfx/flasher_on.ogg")
			else
				self:EmitSound("simulated_vehicles/sfx/flasher_off.ogg")
			end
		end
	end
end

function ENT:GetFlasher()
	self.flashnum = self.flashnum or 0

	return self.flashnum
end

function ENT:SetPoseParameters(curtime)
	self.sm_vSteer = self.sm_vSteer and self.sm_vSteer + (self:GetVehicleSteer() - self.sm_vSteer) * 0.3 or 0
	self:SetPoseParameter("vehicle_steer", self.sm_vSteer)

	if not istable(self.pp_data) then
		self.ppNextCheck = self.ppNextCheck or curtime + 0.5

		if self.ppNextCheck < curtime and not self.CustomWheels then
			self.ppNextCheck = curtime + 0.5
			net.Start("simfphys_request_ppdata", true)
			net.WriteEntity(self)
			net.SendToServer()
		end
	else
		if not self.CustomWheels then
			for i = 1, table.Count(self.pp_data) do
				local Wheel = self.pp_data[i].entity

				if IsValid(Wheel) then
					local addPos = Wheel:GetDamaged() and self.pp_data[i].dradius or 0
					local Pose = (self.pp_data[i].pos - self:WorldToLocal(Wheel:GetPos()).z + addPos) / self.pp_data[i].travel
					self:SetPoseParameter(self.pp_data[i].name, Pose)
				end
			end
		end
	end

	self:InvalidateBoneCache()
end

function ENT:GetEnginePos()
	if self.VHL and self.VHL.EnginePos then return self:LocalToWorld(self.VHL.EnginePos) end

	return self:GetPos()
end

function ENT:GetRPM()
	local RPM = self.SmoothRPM and self.SmoothRPM or 0

	return RPM
end

function ENT:DamageEffects()
	local smoke = self:GetEngineTemp() > 85

	if self:GetEngineHP() < 35 and self:GetRPM() > 0 then
		self:CreateLoopingSound("damaged_eng", "cars/engines/run_damaged_2.wav", 65):Play()
	elseif self.sounds["damaged_eng"] then
		self:StopLoopSounds("damaged_eng")
	end

	if self.wasSmoke ~= smoke then
		self.wasSmoke = smoke

		if smoke then
			self.smokesnd = CreateSound(self, "cars/engines/run_damaged_1.wav")
			self.smokesnd:PlayEx(0.1, 90)
		else
			if self.smokesnd then
				self.smokesnd:Stop()
			end
		end
	end

	if smoke then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetEnginePos())
		effectdata:SetEntity(self)
		util.Effect("simfphys_engine_smoke", effectdata)
	end
end

function ENT:ManageEffects(Active, fThrottle, LimitRPM)
	self:DamageEffects()
	Active = Active and (self:GetFlyWheelRPM() ~= 0)
	if not Active then return end
	if not self.ExhaustPositions then return end
	local Scale = fThrottle * (0.2 + math.min(self:GetRPM() / LimitRPM, 1) * 0.8) ^ 2

	for i = 1, table.Count(self.ExhaustPositions) do
		if self.ExhaustPositions[i].OnBodyGroups then
			if self:BodyGroupIsValid(self.ExhaustPositions[i].OnBodyGroups) then
				local effectdata = EffectData()
				effectdata:SetOrigin(self.ExhaustPositions[i].pos)
				effectdata:SetAngles(self.ExhaustPositions[i].ang)
				effectdata:SetMagnitude(Scale)
				effectdata:SetEntity(self)
				util.Effect("simfphys_exhaust", effectdata)
			end
		else
			local effectdata = EffectData()
			effectdata:SetOrigin(self.ExhaustPositions[i].pos)
			effectdata:SetAngles(self.ExhaustPositions[i].ang)
			effectdata:SetMagnitude(Scale)
			effectdata:SetEntity(self)
			util.Effect("simfphys_exhaust", effectdata)
		end
	end
end

-- local BrakeLoopSound = "car/wheels/rig_brake_disc_1.wav"
-- local BrakeReleaseSound = "car/wheels/rig_brake_release.wav"
-- local BrakeSqueakSound = "car/wheels/brake_squeak_1.wavcar"
function ENT:ManageSounds(Active, fThrottle, LimitRPM)
	local FlyWheelRPM = self:GetFlyWheelRPM()
	local IdleRPM = self:GetIdleRPM()
	local IsCruise = self:GetIsCruiseModeOn()
	local CurDist = (LocalPlayer():GetPos() - self:GetPos()):Length()
	local Throttle = IsCruise and math.Clamp(self:GetThrottle() ^ 3, 0.01, 0.7) or fThrottle
	local Gear = self:GetGear()
	local Clutch = self:GetClutch()
	local FadeRPM = LimitRPM * 0.5
	local FT = FrameTime()
	local Rate = 3.33 * FT
	Active = Active and (FlyWheelRPM ~= 0)
	self.ForwardSpeed = self:GetVelocity():LengthSqr()
	self.FadeThrottle = self.FadeThrottle + math.Clamp(Throttle - self.FadeThrottle, -Rate, Rate)
	self.PitchOffset = self.PitchOffset + ((CurDist - self.OldDist) * 0.23 - self.PitchOffset) * 0.5
	self.OldDist = CurDist
	self.SmoothRPM = self.SmoothRPM + math.Clamp(FlyWheelRPM - self.SmoothRPM, -0.972 * FT * LimitRPM, 1.66 * FT * LimitRPM)
	self.OldThrottle2 = self.OldThrottle2 or 0

	if self.VHL.snd_brake then
		if self:GetIsBraking() and math.abs(self.ForwardSpeed) > 10000 then
			if self.brakeLoop then
				self.brakeLoop:ChangeVolume(math.min(math.abs(self.ForwardSpeed) - 10000, 700000) / 700000)
				self.brakeLoop:ChangePitch(100)

				if not self.brake_squeak then
					if self.brakeLoop:GetVolume() > 0.3 and self.VHL.snd_brake_squeak then
						self:EmitSound(self.VHL.snd_brake_squeak)
					end

					self.brake_squeak = true
				end
			else
				self.brakeLoop = CreateSound(self, self.VHL.snd_brake)
				self.brakeLoop:PlayEx(0, 0)
			end
		else
			if self.brakeLoop and self.brakeLoop:GetVolume() > 0 then
				self.brakeLoop:ChangeVolume(0)
			end
		end
	end

	if not self:GetIsBraking() and self.brake_squeak then
		self.brake_squeak = nil

		if self.VHL.snd_brake_release then
			self:EmitSound(self.VHL.snd_brake_release)
		end
	end

	if Throttle ~= self.OldThrottle2 then
		self.OldThrottle2 = Throttle

		if Throttle == 0 and self.SmoothRPM > LimitRPM * 0.6 then
			self:Backfire()
		end
	end

	if self:GetRevlimiter() and LimitRPM > 2500 and (self.SmoothRPM >= LimitRPM - 200) and self.FadeThrottle > 0 then
		self.SmoothRPM = self.SmoothRPM - 0.2 * LimitRPM
		self.FadeThrottle = 0.2
		self:Backfire()
	end

	if Active ~= self.OldActive then
		local preset = self:GetEngineSoundPreset()
		local UseGearResetter = self:SetSoundPreset(preset)
		self.SoundMode = UseGearResetter and 2 or 1
		self.OldActive = Active

		if Active then
			local MaxHealth = self:GetMaxHealth()
			local Health = self:GetHullHealth()

			if Health <= (MaxHealth * 0.6) then
				self.DamageSnd:PlayEx(0, 0)
			end

			if self.SoundMode == 2 then
				self.HighRPM = CreateSound(self, self.EngineSounds["HighRPM"])
				self.LowRPM = CreateSound(self, self.EngineSounds["LowRPM"])
				self.Idle = CreateSound(self, self.EngineSounds["Idle"])
				self.HighRPM:PlayEx(0, 0)
				self.LowRPM:PlayEx(0, 0)
				self.Idle:PlayEx(0, 0)
			else
				local IdleSound = self.EngineSounds["IdleSound"]
				local LowSound = self.EngineSounds["LowSound"]
				local HighSound = self.EngineSounds["HighSound"]
				local ThrottleSound = self.EngineSounds["ThrottleSound"]

				if IdleSound then
					self.Idle = CreateSound(self, IdleSound)
					self.Idle:PlayEx(0, 0)
				end

				if LowSound then
					self.LowRPM = CreateSound(self, LowSound)
					self.LowRPM:PlayEx(0, 0)
				end

				if HighSound then
					self.HighRPM = CreateSound(self, HighSound)
					self.HighRPM:PlayEx(0, 0)
				end

				if ThrottleSound then
					self.Valves = CreateSound(self, ThrottleSound)
					self.Valves:PlayEx(0, 0)
				end
			end
		else
			self:SaveStopSounds()
		end
	end

	if not Active then return end
	local Volume = 0.25 + 0.25 * ((self.SmoothRPM / LimitRPM) ^ 1.5) + self.FadeThrottle * 0.5
	local Pitch = math.Clamp((20 + self.SmoothRPM / 50 - self.PitchOffset) * self.PitchMulAll, 0, 255)

	if self.DamageSnd then
		self.DamageSnd:ChangeVolume((self.SmoothRPM / LimitRPM) * 0.6 ^ 1.5)
		self.DamageSnd:ChangePitch(100)
	end

	if self.SoundMode == 2 then
		if self.FadeThrottle ~= self.OldThrottle then
			self.OldThrottle = self.FadeThrottle

			if self.FadeThrottle == 0 and Clutch == 0 and self.SmoothRPM >= FadeRPM and IsCruise ~= true then
				if self.LowRPM then
					self.LowRPM:Stop()
				end

				self.LowRPM = CreateSound(self, self.EngineSounds["RevDown"])
				self.LowRPM:PlayEx(0, 0)
			end
		end

		if Gear ~= self.OldGear and Clutch ~= 1 then
			if self.SmoothRPM >= FadeRPM and Gear > 3 then
				if self.OldGear < Gear then
					if self.HighRPM then
						self.HighRPM:Stop()
					end

					self.HighRPM = CreateSound(self, self.EngineSounds["ShiftUpToHigh"])
					self.HighRPM:PlayEx(0, 0)

					if self.SmoothRPM > LimitRPM * 0.6 and math.random(0, 4) >= 3 then
						timer.Simple(0.4, function()
							if not IsValid(self) then return end
							self:Backfire()
						end)
					end
				else
					if self.FadeThrottle > 0 then
						if self.HighRPM then
							self.HighRPM:Stop()
						end

						self.HighRPM = CreateSound(self, self.EngineSounds["ShiftDownToHigh"])
						self.HighRPM:PlayEx(0, 0)
					end
				end
			else
				if self.OldGear > Gear and self.FadeThrottle > 0 and Gear >= 3 then
					if self.HighRPM then
						self.HighRPM:Stop()
					end

					self.HighRPM = CreateSound(self, self.EngineSounds["ShiftDownToHigh"])
					self.HighRPM:PlayEx(0, 0)
				else
					if self.HighRPM then
						self.HighRPM:Stop()
					end

					if self.LowRPM then
						self.LowRPM:Stop()
					end

					self.HighRPM = CreateSound(self, self.EngineSounds["HighRPM"])
					self.LowRPM = CreateSound(self, self.EngineSounds["LowRPM"])
					self.HighRPM:PlayEx(0, 0)
					self.LowRPM:PlayEx(0, 0)
				end
			end

			self.OldGear = Gear
		end

		self.Idle:ChangeVolume(math.Clamp(math.min((self.SmoothRPM / IdleRPM) * 3, 1.5 + self.FadeThrottle * 0.5) * 0.7 - self.SmoothRPM / 2000, 0, 1))
		self.Idle:ChangePitch(math.Clamp(Pitch * 3, 0, 255))
		self.LowRPM:ChangeVolume(math.Clamp(Volume - (self.SmoothRPM - 2000) / 2000 * self.FadeThrottle, 0, 1))
		self.LowRPM:ChangePitch(math.Clamp(Pitch * self.PitchMulLow, 0, 255))
		local hivol = math.max((self.SmoothRPM - 2000) / 2000, 0) * Volume
		self.HighRPM:ChangeVolume(self.FadeThrottle < 0.4 and hivol * self.FadeThrottle or hivol * self.FadeThrottle * 2.5)
		self.HighRPM:ChangePitch(math.Clamp(Pitch * self.PitchMulHigh, 0, 255))
	else
		if Gear ~= self.OldGear then
			if self.SmoothRPM >= FadeRPM and Gear > 3 and Clutch ~= 1 and self.OldGear < Gear and self.SmoothRPM > LimitRPM * 0.6 and math.random(0, 4) >= 3 then
				timer.Simple(0.4, function()
					if not IsValid(self) then return end
					self:Backfire()
				end)
			end

			self.OldGear = Gear
		end

		local IdlePitch = self.Idle_PitchMul
		self.Idle:ChangeVolume(math.Clamp(math.min((self.SmoothRPM / IdleRPM) * 3, 1.5 + self.FadeThrottle * 0.5) * 0.7 - self.SmoothRPM / 2000, 0, 1))
		self.Idle:ChangePitch(math.Clamp(Pitch * 3 * IdlePitch, 0, 255))
		local LowPitch = self.Mid_PitchMul
		local LowVolume = self.Mid_VolumeMul
		local LowFadeOutRPM = LimitRPM * (self.Mid_FadeOutRPMpercent / 100)
		local LowFadeOutRate = LimitRPM * self.Mid_FadeOutRate
		self.LowRPM:ChangeVolume(math.Clamp((Volume - math.Clamp((self.SmoothRPM - LowFadeOutRPM) / LowFadeOutRate, 0, 1)) * LowVolume, 0, 1))
		self.LowRPM:ChangePitch(math.Clamp(Pitch * LowPitch, 0, 255))
		local HighPitch = self.High_PitchMul
		local HighVolume = self.High_VolumeMul
		local HighFadeInRPM = LimitRPM * (self.High_FadeInRPMpercent / 100)
		local HighFadeInRate = LimitRPM * self.High_FadeInRate
		self.HighRPM:ChangeVolume(math.Clamp(math.Clamp((self.SmoothRPM - HighFadeInRPM) / HighFadeInRate, 0, Volume) * HighVolume, 0, 1))
		self.HighRPM:ChangePitch(math.Clamp(Pitch * HighPitch, 0, 255))
		local ThrottlePitch = self.Throttle_PitchMul
		local ThrottleVolume = self.Throttle_VolumeMul
		self.Valves:ChangeVolume(math.Clamp((self.SmoothRPM - 2000) / 2000, 0, Volume) * (0.2 + 0.15 * self.FadeThrottle) * ThrottleVolume)
		self.Valves:ChangePitch(math.Clamp(Pitch * ThrottlePitch, 0, 255))
	end
end

function ENT:Backfire(damaged)
	if not self:GetBackFire() and not damaged then return end
	if not self.ExhaustPositions then return end
	local expos = self.ExhaustPositions

	for i = 1, table.Count(expos) do
		if math.random(1, 3) >= 2 or damaged then
			local Pos = expos[i].pos
			local Ang = expos[i].ang - Angle(90, 0, 0)

			if expos[i].OnBodyGroups then
				if self:BodyGroupIsValid(expos[i].OnBodyGroups) then
					local effectdata = EffectData()
					effectdata:SetOrigin(Pos)
					effectdata:SetAngles(Ang)
					effectdata:SetEntity(self)
					effectdata:SetFlags(damaged and 1 or 0)
					util.Effect("simfphys_backfire", effectdata)
				end
			else
				local effectdata = EffectData()
				effectdata:SetOrigin(Pos)
				effectdata:SetAngles(Ang)
				effectdata:SetEntity(self)
				effectdata:SetFlags(damaged and 1 or 0)
				util.Effect("simfphys_backfire", effectdata)
			end
		end
	end
end

local Mat = CreateMaterial("simfphysdamage", "VertexLitGeneric", {
		["$basetexture"] = "models/player/player_chrome1",
	})

function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 6000000 then return end

	if self:GetHull() < 0.9 then
		render.ModelMaterialOverride(Mat)
		render.SetBlend((1 - self:GetHull() + 0.1) * 0.8)
		self:DrawModel()
		render.ModelMaterialOverride()
		render.SetBlend(1)
	end

	if not self.npcinfo or not self.VHL then return end

	for k, v in pairs(self.npcinfo) do
		if not IsValid(self.sitnpc[k]) and self.VHL.PassengerSeats and self.VHL.PassengerSeats[v.sit] then
			self.sitnpc[k] = ClientsideModel("models/cityrp/pm/normal/" .. v.gn .. "_0" .. v.model .. ".mdl", RENDERGROUP_OPAQUE)
			self.sitnpc[k]:ResetSequence("sit")
			self.sitnpc[k]:DrawModel()
			self.sitnpc[k]:SetParent(self)
			self.sitnpc[k]:SetPos(self:LocalToWorld(self.VHL.PassengerSeats[v.sit].pos) + Vector(0, 0, 7))
			self.sitnpc[k]:SetAngles(self:GetAngles() + self.VHL.PassengerSeats[v.sit].ang + Angle(0, 90, 0))
			MCR.SetMatID(self.sitnpc[k], v.gn, "top", v.top)
			MCR.SetMatID(self.sitnpc[k], v.gn, "pants", v.pants)
		end
	end

	for k, v in pairs(self.sitnpc) do
		if IsValid(v) and v:GetParent() == NULL then
			v:SetParent(self)
		end
	end
end

function ENT:SetSoundPreset(index)
	local vehiclelist = list.Get("simfphys_vehicles")[self:GetSpawn_List()] or false

	if vehiclelist and not self.ExhaustPositions then
		self.ExhaustPositions = vehiclelist.Members.ExhaustPositions
	end

	if index == -1 then
		if vehiclelist then
			local soundoverride = self:GetSoundoverride()
			local data = string.Explode(",", soundoverride)

			if soundoverride ~= "" and data[1] == "1" then
				self.EngineSounds["Idle"] = data[4]
				self.EngineSounds["LowRPM"] = data[6]
				self.EngineSounds["HighRPM"] = data[2]
				self.EngineSounds["RevDown"] = data[8]
				self.EngineSounds["ShiftUpToHigh"] = data[10]
				self.EngineSounds["ShiftDownToHigh"] = data[9]
				self.PitchMulLow = data[7]
				self.PitchMulHigh = data[3]
				self.PitchMulAll = data[5]
			else
				local idle = vehiclelist.Members.snd_idle or ""
				local low = vehiclelist.Members.snd_low or ""
				local mid = vehiclelist.Members.snd_mid or ""
				local revdown = vehiclelist.Members.snd_low_revdown or ""
				local gearup = vehiclelist.Members.snd_mid_gearup or ""
				local geardown = vehiclelist.Members.snd_mid_geardown or ""
				self.EngineSounds["Idle"] = idle ~= "" and idle or false
				self.EngineSounds["LowRPM"] = low ~= "" and low or false
				self.EngineSounds["HighRPM"] = mid ~= "" and mid or false
				self.EngineSounds["RevDown"] = revdown ~= "" and revdown or low
				self.EngineSounds["ShiftUpToHigh"] = gearup ~= "" and gearup or mid
				self.EngineSounds["ShiftDownToHigh"] = geardown ~= "" and geardown or gearup
				self.PitchMulLow = vehiclelist.Members.snd_low_pitch or 1
				self.PitchMulHigh = vehiclelist.Members.snd_mid_pitch or 1
				self.PitchMulAll = vehiclelist.Members.snd_pitch or 1
			end
		else
			local ded = "common/bugreporter_failed.wav"
			self.EngineSounds["Idle"] = ded
			self.EngineSounds["LowRPM"] = ded
			self.EngineSounds["HighRPM"] = ded
			self.EngineSounds["RevDown"] = ded
			self.EngineSounds["ShiftUpToHigh"] = ded
			self.EngineSounds["ShiftDownToHigh"] = ded
			self.PitchMulLow = 0
			self.PitchMulHigh = 0
			self.PitchMulAll = 0
		end

		if self.EngineSounds["Idle"] ~= false and self.EngineSounds["LowRPM"] ~= false and self.EngineSounds["HighRPM"] ~= false then
			self:PrecacheSounds()

			return true
		else
			self:SetSoundPreset(0)

			return false
		end
	end

	if index == 0 then
		local soundoverride = self:GetSoundoverride()
		local data = string.Explode(",", soundoverride)

		if soundoverride ~= "" and data[1] ~= "1" then
			self.EngineSounds["IdleSound"] = data[1]
			self.Idle_PitchMul = data[2]
			self.EngineSounds["LowSound"] = data[3]
			self.Mid_PitchMul = data[4]
			self.Mid_VolumeMul = data[5]
			self.Mid_FadeOutRPMpercent = data[6]
			self.Mid_FadeOutRate = data[7]
			self.EngineSounds["HighSound"] = data[8]
			self.High_PitchMul = data[9]
			self.High_VolumeMul = data[10]
			self.High_FadeInRPMpercent = data[11]
			self.High_FadeInRate = data[12]
			self.EngineSounds["ThrottleSound"] = data[13]
			self.Throttle_PitchMul = data[14]
			self.Throttle_VolumeMul = data[15]
		else
			self.EngineSounds["IdleSound"] = vehiclelist and vehiclelist.Members.Sound_Idle or "simulated_vehicles/misc/e49_idle.wav"
			self.Idle_PitchMul = (vehiclelist and vehiclelist.Members.Sound_IdlePitch) or 1
			self.EngineSounds["LowSound"] = vehiclelist and vehiclelist.Members.Sound_Mid or "simulated_vehicles/misc/gto_onlow.wav"
			self.Mid_PitchMul = (vehiclelist and vehiclelist.Members.Sound_MidPitch) or 1
			self.Mid_VolumeMul = (vehiclelist and vehiclelist.Members.Sound_MidVolume) or 0.75
			self.Mid_FadeOutRPMpercent = (vehiclelist and vehiclelist.Members.Sound_MidFadeOutRPMpercent) or 68
			self.Mid_FadeOutRate = (vehiclelist and vehiclelist.Members.Sound_MidFadeOutRate) or 0.4
			self.EngineSounds["HighSound"] = vehiclelist and vehiclelist.Members.Sound_High or "simulated_vehicles/misc/nv2_onlow_ex.wav"
			self.High_PitchMul = (vehiclelist and vehiclelist.Members.Sound_HighPitch) or 1
			self.High_VolumeMul = (vehiclelist and vehiclelist.Members.Sound_HighVolume) or 1
			self.High_FadeInRPMpercent = (vehiclelist and vehiclelist.Members.Sound_HighFadeInRPMpercent) or 26.6
			self.High_FadeInRate = (vehiclelist and vehiclelist.Members.Sound_HighFadeInRate) or 0.266
			self.EngineSounds["ThrottleSound"] = vehiclelist and vehiclelist.Members.Sound_Throttle or "simulated_vehicles/valve_noise.wav"
			self.Throttle_PitchMul = (vehiclelist and vehiclelist.Members.Sound_ThrottlePitch) or 0.65
			self.Throttle_VolumeMul = (vehiclelist and vehiclelist.Members.Sound_ThrottleVolume) or 1
		end

		self.PitchMulLow = 1
		self.PitchMulHigh = 1
		self.PitchMulAll = 1
		self:PrecacheSounds()

		return false
	end

	if index > 0 then
		local clampindex = math.Clamp(index, 1, table.Count(simfphys.SoundPresets))
		self.EngineSounds["Idle"] = simfphys.SoundPresets[clampindex][1]
		self.EngineSounds["LowRPM"] = simfphys.SoundPresets[clampindex][2]
		self.EngineSounds["HighRPM"] = simfphys.SoundPresets[clampindex][3]
		self.EngineSounds["RevDown"] = simfphys.SoundPresets[clampindex][4]
		self.EngineSounds["ShiftUpToHigh"] = simfphys.SoundPresets[clampindex][5]
		self.EngineSounds["ShiftDownToHigh"] = simfphys.SoundPresets[clampindex][6]
		self.PitchMulLow = simfphys.SoundPresets[clampindex][7]
		self.PitchMulHigh = simfphys.SoundPresets[clampindex][8]
		self.PitchMulAll = simfphys.SoundPresets[clampindex][9]
		self:PrecacheSounds()

		return true
	end

	return false
end

function ENT:PrecacheSounds()
	for index, sound in pairs(self.EngineSounds) do
		if not isbool(sound) then
			if file.Exists("sound/" .. sound, "GAME") then
				util.PrecacheSound(sound)
			else
				self.EngineSounds[index] = "common/null.wav"
			end
		end
	end
end

function ENT:GetVehicleInfo()
	return self.VehicleInfo
end

function ENT:SaveStopSounds()
	if self.HighRPM then
		self.HighRPM:Stop()
	end

	if self.LowRPM then
		self.LowRPM:Stop()
	end

	if self.Idle then
		self.Idle:Stop()
	end

	if self.Valves then
		self.Valves:Stop()
	end

	if self.DamageSnd then
		self.DamageSnd:Stop()
	end

	if IsValid(self.brakeLoop) then
		self.brakeLoop:Stop()
	end
end

function ENT:OnRemove()
	self:SaveStopSounds()

	if self.smokesnd then
		self.smokesnd:Stop()
	end

	for _, snd in pairs(self.sounds) do
		snd:Stop()
	end

	for k, v in pairs(self.sitnpc) do
		if IsValid(v) then
			v:Remove()
		end
	end

	if self.firesnd then
		self.firesnd:Stop()
	end
end

net.Receive("simfphys_addclpass", function()
	local ent = net.ReadEntity()
	local data = net.ReadTable()

	if IsValid(ent) then
		ent:SetCLPass(data)
	end
end)

net.Receive("simfphys_removeclpass", function()
	local ent = net.ReadEntity()
	local data = net.ReadInt(6)

	if IsValid(ent) then
		ent:RemoveCLPass(data)
	end
end)

local cl = Color(207, 66, 0, 200)
local cl2 = Color(0, 107, 207, 200)

hook.Remove("PostDrawTranslucentRenderables", "test", function(bDepth, bSkybox)
	if (bSkybox) then return end

	for k, v in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
		render.SetColorMaterial()
		render.DrawSphere(v:LocalToWorld(v:GetTrunkPosition()), 30, 30, 30, cl)
		render.DrawSphere(v:LocalToWorld(v:OBBMaxs()), 10, 30, 30, cl2)
		render.DrawSphere(v:LocalToWorld(v:OBBMins()), 10, 30, 30, cl2)
		render.DrawSphere(v:LocalToWorld(v:OBBCenter()), 20, 30, 30, cl2)
	end
end)