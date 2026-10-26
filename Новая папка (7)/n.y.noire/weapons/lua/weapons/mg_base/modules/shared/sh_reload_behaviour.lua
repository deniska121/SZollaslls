--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_reload_behaviour.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:CanReload()
	if (self:IsCustomizing()) then return false end
	if (CurTime() < self:GetNextPrimaryFire()) then return false end
	if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
	if (CurTime() < self:GetNextSprintTime()) then return false end
	if (CurTime() < self:GetNextMeleeTime()) then return false end
	if (CurTime() < self:GetNextFiremodeTime()) then return false end
	--if self:GetMalfunction() then return true end
	if (self:GetOwner():KeyDown(IN_ATTACK)) then return false end
	if (CurTime() < self:GetNextReloadTime() and self:GetHasFilledMag()) then return false end --avoid people from reloading after they canceled their reloads
	if (self:Ammo1() <= 0) and not self.UseMags and not self.UseINV then return false end
	if (self:GetOwner():KeyDown(IN_USE)) then return false end
	if (self:IsDrawing()) then return false end

	return true
end

function SWEP:CanInspect()
	--if self:GetMalfunction() then return false end
	if (self:IsCustomizing()) then return false end
	if (CurTime() < self:GetNextPrimaryFire()) then return false end
	if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
	if (CurTime() < self:GetNextSprintTime()) then return false end
	if (CurTime() < self:GetNextMeleeTime()) then return false end
	if (CurTime() < self:GetNextFiremodeTime()) then return false end
	if (self:GetOwner():KeyDown(IN_USE)) then return false end
	if (self:GetAimDelta() > 0) then return false end
	if (self:GetIsSprinting()) then return end
	if (self:IsDrawing()) then return false end

	return true
end

function SWEP:GetMaxClip1WithChamber()
	if (self.CanChamberRound and self:GetHasPumped()) then return self:GetMaxClip1() + 1 end

	return self:GetMaxClip1()
end

function SWEP:Reload(fromFallback)
	local CT = CurTime()
	fromFallback = fromFallback or false

	if self:GetMalfunction() and self.MalfunctionAnimation then
		if SERVER and self.gunstate and self.gunstate > 0 then
			self:SetClip1(math.max(self:Clip1() - 1, 0))
			self:SetMalfunction(false)
			self:SetNextPrimaryFire(CurTime() + 0.1)

			if self.MalfunctionAnimation then
				self:PlayViewModelAnimation(self.MalfunctionAnimation["anim"], nil, self.MalfunctionAnimation["skip_cycle"], true)
				self:SetNextPrimaryFire(CurTime() + self.MalfunctionAnimation["next"])
			else
				self:PlayViewModelAnimation("Jog_Out", nil, nil, true)
			end
		end
		return
	end

	local bCanChamberReload = self.UseMags or self:Clip1() < self:GetMaxClip1WithChamber()

	if ((not bCanChamberReload or self:Ammo1() <= 0 and not self.UseMags and not self.UseINV) or (self.UseMags and not self:GetOwner():HaveMag(self.UseMags)) or (self.UseINV and not self:GetOwner():HasBullets(self.UseINV))) then
		if (CT > self:GetNextInspectTime() and self:CanInspect()) then
			if (IsFirstTimePredicted()) then
				self:PlayViewModelAnimation("Inspect")
			end

			self:SetNextInspectTime(CT + self:GetAnimLength("Inspect"))
		end

		return
	end

	if (not fromFallback and not self:CanReload()) then return end
	local seqIndex = self:ChooseReloadAnim()

	self:SetIsReloading(true)

	local length = self:GetAnimLength(seqIndex)
	local magLength = self:GetAnimLength(seqIndex, self.Animations[seqIndex].MagLength)

	self:SetNextReloadTime(CT + length)
	self:SetNextPrimaryFire(CT + length)
	self:SetNextMagTime(CT + magLength)
	self:SetHasFilledMag(false)
	self:SetBurstRounds(0)

	if (self.ReloadRechambers) then
		self:SetHasPumped(true)
	end

	if (self.EmptyReloadRechambers and seqIndex == "Reload_Empty") then
		self:SetHasPumped(true)
	end

	if (self.Animations.Rechamber == nil) then
		self:SetHasPumped(true)
	end

	self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.HoldTypes[self.HoldType].Reload)

	local magt = self.Unloader["load_cycle"] and self:HasAttachment("att_ammo")

	if magt then
		self:SetNextMagTime(CT)
	end

	if (IsFirstTimePredicted()) then
		self:PlayViewModelAnimation(seqIndex, fromFallback, magt and self.Unloader["load_cycle"])
	end

	self.m_bReloaded = true
end

function SWEP:ChooseReloadAnim()
	if (self.Animations["Reload_Start"] ~= nil) then return "Reload_Start" end
	if (self:Clip1() <= 0 and self.Animations["Reload_Empty"]) then return "Reload_Empty" end

	return "Reload"
end

function SWEP:ResetRevolv(clip)
	self.CurRevolve = 1
	self.RevolveData = {}

	for i = 1, self.RevolveRounds do
		self.RevolveData[i] = clip >= i
	end

	self:SetMalfunction(false)
end

function SWEP:RevolvProgress(add)
	self.CurRevolve = self.CurRevolve + add

	if self.CurRevolve < 1 then
		self.CurRevolve = self.RevolveRounds
	end

	if self.CurRevolve > self.RevolveRounds then
		self.CurRevolve = 1
	end
end

function SWEP:RevolvRandom()
	self.CurRevolve = math.random(self.RevolveRounds)
	if not self.RevolveData[self.CurRevolve] then
		self:SetMalfunction(true)
	end
end

function SWEP:ReloadBehaviourModule()
	if not self:GetIsReloading() then return end

	if (self.Animations["Reload_Loop"] ~= nil) then
		if (CurTime() > self:GetNextMagTime() and not self:GetHasFilledMag()) then
			if self:Clip1() == 0 then
				self.nodropmag = nil
			end

			self:SetClip1(self:Clip1() + 1)

			if self.RevolveRounds then
				self:ResetRevolv(self:Clip1())

				if self.ReloadBulletBG and CLIENT then
					self.m_ViewModel:SetBodygroup(3, self:Clip1())
					self.m_ViewModel:SetBodygroup(4, self:Clip1())
				end
			end

			if self.UseINV then
				if SERVER then
					local nodrop
					self.DefaultMag, nodrop = self:GetOwner():RemoveAnyBullet(self.UseINV)
					if nodrop then self.nodropmag = true end
				end
			else
				self:GetOwner():SetAmmo(self:Ammo1() - 1, self:GetPrimaryAmmoType())
			end

			self:SetHasFilledMag(true)
		end

		if (CurTime() > self:GetNextReloadTime()) then
			local maxClip = self.Primary.ClipSize

			if (self:GetHasPumped()) then
				maxClip = self:GetMaxClip1WithChamber()
			end

			if not self.UseINV and (self:Clip1() >= maxClip or self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) <= 0) then
				self:EndReload()

				return
			end

			if self.UseINV and (self:Clip1() >= maxClip or not self:GetOwner():HasBullets(self.UseINV)) then
				self:EndReload()

				return
			end

			if (IsFirstTimePredicted()) then
				self:PlayViewModelAnimation("Reload_Loop")
			end

			self:SetNextReloadTime(CurTime() + self:GetAnimLength("Reload_Loop"))
			self:SetNextMagTime(CurTime() + self:GetAnimLength("Reload_Loop", self.Animations["Reload_Loop"].MagLength))
			self:SetHasFilledMag(false)
			self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.HoldTypes[self.HoldType].Reload)
		end
	else
		if (CurTime() > self:GetNextReloadTime()) then
			self:SetIsReloading(false)
			self.m_bReloaded = false
		end

		if (CurTime() <= self:GetNextMagTime() or self:GetHasFilledMag()) then return end

		if CLIENT then return end

		if self.EjectOnReload and self.EjectCaseNum and self.EjectCaseNum > 0 then
			self:EjectDataCases(self.ShellsId, self.EjectCaseNum)
			self.EjectCaseNum = 0
			return
		end

		if self.UseMags then
			local mag, class, nodrop = self:GetOwner():RemoveAnyMag(self.UseMags)

			if mag then
				if (self.CanChamberRound and self:Clip1() > 0) then
					mag = mag + 1
				end

				--if self:Clip1() - 1 > 0 then
					self:GetOwner():AddMag(self.DefaultMag, math.max(self:Clip1() - (self.CanChamberRound and 1 or 0), 0), self.nodropmag)
				--end

				self:SetClip1(mag)

				if self.RevolveRounds then
					self:ResetRevolv(self:Clip1())
				end

				self.nodropmag = nodrop

				if self.DefaultMag ~= class then
					local mgs = self.UseMags[class]
					self.DefaultMag = class

					if not isbool(mgs) then
						self:Attach(mgs[1], mgs[2])
						net.Start("mgbase_customize_att_cl", false)
						net.WriteEntity(self)
						net.WriteInt(mgs[1], 8)
						net.WriteInt(mgs[2], 8)
						net.WriteBool(true)
						net.Broadcast()
					end
				end

				self:SetHasFilledMag(true)
			end
		else
			local maxClip = self:GetMaxClip1()

			if (self:Clip1() > 0) then
				maxClip = self:GetMaxClip1WithChamber()
			end

			local bul = self.UseINV and self:GetOwner():HasBullets(self.UseINV) or self:Ammo1()
			local ammoNeeded = math.min(maxClip - self:Clip1(), bul)
			self:SetClip1(self:Clip1() + ammoNeeded)

			if self.RevolveRounds then
				self:ResetRevolv(self:Clip1())
			end

			if self.UseINV and SERVER then
				self.DefaultMag, self.nodropmag = self:GetOwner():RemoveAnyBullet(self.UseINV, ammoNeeded)
			else
				self:GetOwner():SetAmmo(self:Ammo1() - ammoNeeded, self:GetPrimaryAmmoType())
			end

			--self:SetHasPumped(true)
			self:SetHasFilledMag(true)
		end
	end
end

function SWEP:EndReload()
	if (self:Clip1() <= 0) then return end --dont want to cancel reload if im out of ammo

	if (self.Animations["Reload_End"] ~= nil) then
		if (not self:GetHasPumped() and self:Clip1() > 0 and self.Animations["Reload_End_Empty"] ~= nil) then
			if (IsFirstTimePredicted()) then
				self:PlayViewModelAnimation("Reload_End_Empty")
			end

			self:SetNextPrimaryFire(CurTime() + self:GetAnimLength("Reload_End_Empty"))
			if not self.ReloadUnchamber then self:SetHasPumped(true) end
		else
			if (IsFirstTimePredicted()) then
				self:PlayViewModelAnimation("Reload_End")
			end

			self:SetNextPrimaryFire(CurTime() + self:GetAnimLength("Reload_End"))
		end

		self:SetIsReloading(false)
	end
end

function SWEP:CanPump()
	return not self:GetIsHolstering() and not self:IsDrawing() and self:Clip1() > 0 and not self:GetIsReloading() and CurTime() > self:GetNextMeleeTime() and self.Animations["Rechamber"] ~= nil and (self:GetOwner():KeyDown(IN_ATTACK))
end