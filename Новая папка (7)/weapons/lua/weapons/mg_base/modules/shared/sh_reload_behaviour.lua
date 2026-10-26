AddCSLuaFile()

function SWEP:CanReload()
    if (self:IsCustomizing()) then return false end
    if (CurTime() < self:GetNextPrimaryFire()) then return false end
    if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
    if (CurTime() < self:GetNextSprintTime()) then return false end
    if (CurTime() < self:GetNextMeleeTime()) then return false end
    if (CurTime() < self:GetNextFiremodeTime()) then return false end
    if (self:GetOwner():KeyDown(IN_ATTACK)) then return false end
    if (CurTime() < self:GetNextReloadTime() and self:GetHasFilledMag()) then return false end
    if (self:Ammo1() <= 0) then return false end
    if (self:GetOwner():KeyDown(IN_USE)) then return false end
    if (self:IsDrawing()) then return false end
    
    -- ПРОВЕРКА НА НАЛИЧИЕ МАГАЗИНА
    if self.HasMag == false then
        return false
    end
    
    return true
end

function SWEP:CanInspect()
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
    if (self.CanChamberRound and self:GetHasPumped()) then 
        return self:GetMaxClip1() + 1 
    end
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

    -- ЕСЛИ НЕТ МАГАЗИНА - НЕЛЬЗЯ ПЕРЕЗАРЯДИТЬСЯ
    if self.HasMag == false then
        if (CT > self:GetNextInspectTime() and self:CanInspect()) then
            if (IsFirstTimePredicted()) then
                self:PlayViewModelAnimation("Inspect")
            end
            self:SetNextInspectTime(CT + self:GetAnimLength("Inspect"))
        end
        return
    end

    if self:Clip1() >= self:GetMaxClip1WithChamber() then
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

    if (IsFirstTimePredicted()) then
        self:PlayViewModelAnimation(seqIndex, fromFallback)
    end

    self.m_bReloaded = true
end

function SWEP:ChooseReloadAnim()
    if (self.Animations["Reload_Start"] ~= nil) then return "Reload_Start" end
    if (self:Clip1() <= 0 and self.Animations["Reload_Empty"]) then return "Reload_Empty" end
    return "Reload"
end

function SWEP:ReloadBehaviourModule()
    if not self:GetIsReloading() then return end

    if (self.Animations["Reload_Loop"] ~= nil) then
        if (CurTime() > self:GetNextMagTime() and not self:GetHasFilledMag()) then
            if self:Ammo1() > 0 and self:Clip1() < self:GetMaxClip1WithChamber() then
                self:SetClip1(self:Clip1() + 1)
                self:GetOwner():RemoveAmmo(1, self:GetPrimaryAmmoType())
            end
            self:SetHasFilledMag(true)
        end

        if (CurTime() > self:GetNextReloadTime()) then
            if self:Clip1() >= self:GetMaxClip1WithChamber() or self:Ammo1() <= 0 then
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

        if self:Clip1() < self:GetMaxClip1WithChamber() then
            local amount = math.min(self:GetMaxClip1WithChamber() - self:Clip1(), self:Ammo1())
            self:SetClip1(self:Clip1() + amount)
            self:GetOwner():RemoveAmmo(amount, self:GetPrimaryAmmoType())
        end
        
        self:SetHasFilledMag(true)
    end
end

function SWEP:EndReload()
    if (self:Clip1() <= 0) then self:SetIsReloading(false) return end

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
    end
    self:SetIsReloading(false)
end

function SWEP:CanPump()
    return not self:GetIsHolstering() and not self:IsDrawing() and self:Clip1() > 0 and not self:GetIsReloading() and CurTime() > self:GetNextMeleeTime() and self.Animations["Rechamber"] ~= nil and (self:GetOwner():KeyDown(IN_ATTACK))
end
