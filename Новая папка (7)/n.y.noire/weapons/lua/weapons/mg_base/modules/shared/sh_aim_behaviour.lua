--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_aim_behaviour.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

local sens = CreateClientConVar("noire_swep_sense", 0.8, true, false)
local asens = CreateClientConVar("noire_swep_aimsense", 0.5, true, false)

function SWEP:CanPlayAimDownAnim()
	return not self:GetIsReloading() and not self:IsDrawing() and not self:GetIsHolstering() and not self:GetIsSprinting() and CurTime() > self:GetNextSprintTime() and CurTime() > self:GetNextFiremodeTime() and CurTime() > self:GetNextMeleeTime() and CurTime() > self:GetNextPrimaryFire() and not self:IsCustomizing()
end

function SWEP:CanPlayAimUpAnim()
	return not self:GetIsReloading() and not self:IsDrawing() and not self:GetIsHolstering() and not self:GetIsSprinting() and CurTime() > self:GetNextSprintTime() and CurTime() > self:GetNextFiremodeTime() and CurTime() > self:GetNextMeleeTime() and CurTime() > self:GetNextPrimaryFire()
end

function SWEP:CanAim()
	return not self:GetIsHolstering() and not self:GetIsSprinting() and not self.m_bWallBlock and (not self:GetOwner():KeyDown(IN_USE) or (self:GetOwner():KeyDown(IN_USE) and self:GetAimDelta() > 0)) and CurTime() > self:GetNextSprintTime() and CurTime() > self:GetNextMeleeTime() and not (self.CanDisableAimReload and self:GetIsReloading())
end

function SWEP:AimBehaviourModule()
	if (CLIENT and game.SinglePlayer()) then return end

	self:SetToggleAim(self:GetOwner():KeyDown(IN_ATTACK2))

	if (self:CanAim() and self:GetToggleAim()) then
		self:StopCustomizing()

		if (not self:GetIsAiming() and self:CanPlayAimUpAnim()) and IsFirstTimePredicted() then
			self:PlayViewModelAnimation("Ads_In")
		end

		self:SetIsAiming(true)
		local speed = 1 / self:GetAnimLength("Ads_In")
		self:SetAimDelta(math.Round(math.min(self:GetAimDelta() + speed * FrameTime(), 1), 4))
	else
		if (self:GetIsAiming() and self:CanPlayAimDownAnim()) and IsFirstTimePredicted() then
			self:PlayViewModelAnimation("Ads_Out")
		end

		self:SetIsAiming(false)
		local speed = 1 / self:GetAnimLength("Ads_Out")
		self:SetAimDelta(math.Round(math.max(self:GetAimDelta() - speed * FrameTime(), 0), 4))
	end

	--aim mode
	self:AimModeModule()
	--breathe
	self:BreathingModule()
end

function SWEP:CanChangeAimMode()
	return (self:GetSight() ~= nil and self:GetSight().ReticleHybrid ~= nil) or (self:GetLaser() ~= nil and self.LaserAimAngles ~= nil and self.LaserAimPos ~= nil)
end

function SWEP:AimModeModule()
	if (self:GetAimMode() > 0) then
		local len = self:GetAnimLength("Ads_In") * 0.5

		if (self:GetSight() ~= nil and self:GetSight().ReticleHybrid ~= nil and self:GetSight().ReticleHybrid.OnAnimation ~= nil) then
			len = self:GetAnimLength(self:GetSight().ReticleHybrid.OnAnimation)
		end

		local speed = 1 / len
		self:SetAimModeDelta(math.min(self:GetAimModeDelta() + speed * FrameTime(), 1))
	else
		local len = self:GetAnimLength("Ads_Out") * 0.5

		if (self:GetSight() ~= nil and self:GetSight().ReticleHybrid ~= nil and self:GetSight().ReticleHybrid.OffAnimation ~= nil) then
			len = self:GetAnimLength(self:GetSight().ReticleHybrid.OffAnimation)
		end

		local speed = 1 / len
		self:SetAimModeDelta(math.max(self:GetAimModeDelta() - speed * FrameTime(), 0))
	end

	if (not self:GetIsAiming()) then return end
	local bCanChange = (self:GetSight() ~= nil and self:GetSight().ReticleHybrid ~= nil) or self:GetLaser() ~= nil
	bCanChange = bCanChange and not self:GetIsReloading() and CurTime() > self:GetNextPrimaryFire()

	if (self:GetOwner():KeyPressed(IN_USE) and bCanChange) then
		if (not self:GetAimModeUsePressed()) then
			self:SetAimModeUsePressed(true)
			self:SetNextAimModeTime(CurTime() + 0.5)
		elseif (self:GetAimModeUsePressed() and CurTime() < self:GetNextAimModeTime()) then
			self:SetAimModeUsePressed(false)
			self:SetAimMode(self:GetAimMode() + 1)
			local count = 0

			if (self:CanChangeAimMode()) then
				count = count + 1
			end

			if (self:GetAimMode() > count) then
				self:SetAimMode(0)

				if (self:GetSight() ~= nil and self:GetSight().ReticleHybrid ~= nil and self:GetSight().ReticleHybrid.OnAnimation ~= nil) then
					if (IsFirstTimePredicted()) then
						self:PlayViewModelAnimation(self:GetSight().ReticleHybrid.OnAnimation)
					end

					self:SetNextPrimaryFire(CurTime() + self:GetAnimLength(self:GetSight().ReticleHybrid.OnAnimation))
				end

				self:EmitSound("Canted.Off")
			else
				if (self:GetSight() ~= nil and self:GetSight().ReticleHybrid ~= nil and self:GetSight().ReticleHybrid.OffAnimation ~= nil) then
					if (IsFirstTimePredicted()) then
						self:PlayViewModelAnimation(self:GetSight().ReticleHybrid.OffAnimation)
					end

					self:SetNextPrimaryFire(CurTime() + self:GetAnimLength(self:GetSight().ReticleHybrid.OffAnimation))
				end

				self:EmitSound("Canted.On")
			end
		end
	end

	if (CurTime() >= self:GetNextAimModeTime()) then
		self:SetAimModeUsePressed(false)
	end
end

function SWEP:BreathingModule()
--	if (self:GetSight() ~= nil and self:GetSight().Optic ~= nil and self:GetAimModeDelta() <= self.m_hybridSwitchThreshold and GetConVar("mgbase_sv_breathing"):GetInt() > 0) then
		local mul =  self.Cone.Shake + 0.1
		local aimvec = math.Clamp(self:GetAimDelta(), 0.1, 1)

		if (self:GetIsAiming() and not self:GetHasRunOutOfBreath()) then
			if self:GetOwner():KeyDown(IN_SPEED) and self:GetOwner():getDarkRPVar("deoxygen") and self:GetOwner():getDarkRPVar("deoxygen") < 30 then
				mul = 0.05
				self:SetBreathingDelta(math.max(self:GetBreathingDelta() - FrameTime() * (MCR.HasTatoo(self:GetOwner(), "b8") and 0.2 or 0.3), 0))
				if (self:GetBreathingDelta() <= 0) then
					self:SetHasRunOutOfBreath(true)
				end
			elseif self:GetBreathingDelta() < 1 then
				self:SetHasRunOutOfBreath(true)
			end
		elseif self:GetBreathingDelta() < 1 then
			self:SetHasRunOutOfBreath(true)
		end

		if self:GetHasRunOutOfBreath() then
			mul = self.Cone.Shake + (3 * (1 - self:GetBreathingDelta()))
			self:SetBreathingDelta(math.min(self:GetBreathingDelta() + FrameTime() * 0.2, 1))

			if (self:GetBreathingDelta() >= 1) then
				self:SetHasRunOutOfBreath(false)
			end
		end

		if (self:GetOwner():getDarkRPVar("deoxygen") and self:GetOwner():getDarkRPVar("deoxygen") >= 30) then
			mul = self.Cone.Shake + 3
			--aimvec = math.Clamp(aimvec, 0.1, 1)
		end

		local pitch = math.sin(CurTime() * 3) * math.cos(CurTime() * 1.5)
		local yaw = math.cos(CurTime() * 1.5) * math.sin(CurTime() * 0.75)
		local ang = Angle(pitch * 0.2, yaw * 0.2, 0)
		ang:Mul(aimvec * mul)
		self:SetBreathingAngle(ang)
	-- else
	-- 	self:SetBreathingAngle(self.ZeroAngle)
	-- end
end

function SWEP:AdjustMouseSensitivity()
	local mul = Lerp(self:GetAimModeDelta(), self.Zoom.FovMultiplier, 0.9)

	hipSens = math.Clamp(sens:GetFloat(), 0.1, 1)

	return Lerp(self:GetAimDelta(), hipSens, mul * math.Clamp(asens:GetFloat(), 0.1, 0.5))
end