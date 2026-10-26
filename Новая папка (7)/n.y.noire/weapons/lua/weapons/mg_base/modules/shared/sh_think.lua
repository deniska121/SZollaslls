--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_think.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:Think()
	self:LoadSpawnPreset()

	--fallback initialize
	if (not self.m_bInitialized and IsFirstTimePredicted()) then
		self:Initialize()
	end

	--fallback draw
	if (not self.m_bDrawn and self:IsDrawing() and (IsFirstTimePredicted() or game.SinglePlayer())) then
		self:Deploy(true)
	end

	--fallback holster
	if (not self.m_bHolstered and self:GetIsHolstering() and IsFirstTimePredicted()) then
		self:Holster(self:GetNextWeapon(), true)
	end

	--fallback reload
	if (not self.m_bReloaded and self:GetIsReloading() and IsFirstTimePredicted()) then
		self:Reload(true)
	end


	if (self.bCustomize ~= self:GetIsCustomizing() and IsFirstTimePredicted()) then
		self.bCustomize = self:GetIsCustomizing()
		self:Customize() --(true) no reason to compensate this since there's no timing, fallback logic still left in the method though.
	end

	--pumping
	if (CurTime() >= self:GetNextPrimaryFire() and self:CanPump()) and not self:GetHasPumped() then
			local anim = "Rechamber"

			if (IsFirstTimePredicted()) then
				self:PlayViewModelAnimation(anim)
			end

			self:SetNextPrimaryFire(CurTime() + self:GetAnimLength(anim))
			self:SetHasPumped(true)
	end

	--holster
	if (self:GetIsHolstering() and CurTime() >= self:GetNextHolsterTime() and IsValid(self:GetNextWeapon()) and self:GetNextWeapon() ~= self and self:GetNextWeapon() ~= self:GetOwner()) then
		self.m_bDrawn = false

		if (CLIENT and (IsFirstTimePredicted() or game.SinglePlayer())) then
			input.SelectWeapon(self:GetNextWeapon())
		end

		return
	end

	--spray
	if (CurTime() > self:GetNextPrimaryFire() + 0.15) then
		self:SetSprayRounds(0)
	end

	--cone
	local target = Lerp(self:GetAimDelta(), self.Cone.Hip, self.Cone.Ads) / GetConVar("mgbase_sv_accuracy"):GetFloat()
	self:SetCone(math.Approach(self:GetCone(), target, 4 * FrameTime()))

	if (CurTime() <= self:GetNextMeleeTime()) then
		self:SetCone(self.Cone.Max)
	end

	--reload
	self:ReloadBehaviourModule()

	--equip
	-- if (not self:IsDrawing() and self:GetNeedsToEquip()) then
	-- 	self:SetNeedsToEquip(false)
	-- end

	--wall lower (must run before aim/fire so they see the current state)
	self:UpdateWallBlock()
	--aim
	self:AimBehaviourModule()
	--sprint
	self:SprintBehaviourModule()

	--ladder
	if (self:GetOwner():GetMoveType() == MOVETYPE_LADDER and not self:IsDrawing()) then
		self:Holster(self:GetOwner())
	else
		if (self:GetIsHolstering() and self:GetNextWeapon() == self:GetOwner()) then
			self:Deploy()
		end
	end

	--holdtypes
	--new meme marine way
	self:SetShouldHoldType()
	--firemodes
	self:FiremodeBehaviourModule()
	--melee
	self:MeleeBehaviourModule()

	if (self:GetOwner():KeyDown(IN_USE) and self:GetOwner():KeyPressed(IN_ATTACK2)) then
		self:SetSafety(not self:GetSafety())
		self:SetShouldHoldType(true)
	end

	--trigger
	if (CLIENT and game.SinglePlayer()) then return end --fuck it

	if (self.Trigger ~= nil) then
		local bDown = self:GetOwner():KeyDown(IN_ATTACK)

		--[[if (!self.Primary.Automatic) then
			bDown = self:GetOwner():KeyPressed(IN_ATTACK)
		end]]
		if (bDown and self:CanTrigger()) then
			if (not self:GetIsTrigger()) then
				if (self.Trigger.PressedSound ~= nil) then
					self:EmitSound(self.Trigger.PressedSound, 10)
				end
				if self.Trigger.PressedAnimation ~= nil and IsFirstTimePredicted() then
					self:PlayViewModelAnimation(self.Trigger.PressedAnimation)
				end
			end

			self:SetIsTrigger(true)
		else
			if (CurTime() > self:GetNextPrimaryFire() or self.Primary.Automatic) then
				if (self:GetIsTrigger()) then
					if (self.Trigger.ReleasedSound ~= nil and (CurTime() > self:LastShootTime() + 0.1 or self.Trigger.PlayReleasedSoundRegardless)) then
						self:EmitSound(self.Trigger.ReleasedSound)
					end

					if (self.Trigger.ReleasedAnimation ~= nil and self:CanPlayTriggerOut()) and IsFirstTimePredicted() then
						self:PlayViewModelAnimation(self.Trigger.ReleasedAnimation)
					end

					if (not self:GetHasShotAfterTrigger() and self:CanPlayTriggerOut()) and IsFirstTimePredicted() then
						self:PlayViewModelAnimation("Idle")
					end
				end

				self:SetIsTrigger(false)
				self:SetHasShotAfterTrigger(false)
			end
		end

		if (self:GetIsTrigger()) then
			self:SetTriggerDelta(self:GetTriggerDelta() + (FrameTime() / self.Trigger.Time))

			if (self:GetTriggerDelta() >= 1) then
				if ((not self.Primary.Automatic and not self:GetHasShotAfterTrigger()) or self.Primary.Automatic) then
					self:PrimaryAttack()
					self:SetHasShotAfterTrigger(true)
				end

				if (self.Primary.Automatic and not self:GetOwner():KeyDown(IN_ATTACK)) then
					self:SetIsTrigger(false)
				end
			end
		else
			self:SetTriggerDelta(0)
		end
	end
end

function SWEP:CanTrigger()
	--[[if (self:Clip1() <= 0) then
		return false
	end]]
	if (self:IsCustomizing()) then return false end
	if (CurTime() < self:GetNextFiremodeTime()) then return false end
	if (self:GetOwner():KeyDown(IN_USE)) then return false end
	if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
	if (CurTime() < self:GetNextMeleeTime()) then return false end
	if (CurTime() < self:GetNextSprintTime()) then return false end
	--[[if (CurTime() < self:GetNextReloadTime() && self:GetHasFilledMag()) then --without this gun will make a click
		return false
	end]]

	return true
end

function SWEP:CanPlayTriggerOut()
	if (self:IsCustomizing()) then return end
	if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
	if (CurTime() < self:GetNextMeleeTime()) then return false end
	if (CurTime() < self:GetNextSprintTime()) then return false end

	return true
end