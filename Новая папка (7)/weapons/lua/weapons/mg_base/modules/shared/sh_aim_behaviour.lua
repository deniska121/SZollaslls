AddCSLuaFile()

function SWEP:CanPlayAimDownAnim()
    return not self:GetIsReloading() and not self:IsDrawing() and not self:GetIsHolstering() and not self:GetIsSprinting() and CurTime() > self:GetNextSprintTime() and CurTime() > self:GetNextFiremodeTime() and CurTime() > self:GetNextMeleeTime() and CurTime() > self:GetNextPrimaryFire() and not self:IsCustomizing()
end

function SWEP:CanPlayAimUpAnim()
    return not self:GetIsReloading() and not self:IsDrawing() and not self:GetIsHolstering() and not self:GetIsSprinting() and CurTime() > self:GetNextSprintTime() and CurTime() > self:GetNextFiremodeTime() and CurTime() > self:GetNextMeleeTime() and CurTime() > self:GetNextPrimaryFire()
end

function SWEP:CanAim()
    return not self:GetIsHolstering() and not self:GetIsSprinting() and (not self:GetOwner():KeyDown(IN_USE) or (self:GetOwner():KeyDown(IN_USE) and self:GetAimDelta() > 0)) and CurTime() > self:GetNextSprintTime() and CurTime() > self:GetNextMeleeTime() and not (self.CanDisableAimReload and self:GetIsReloading())
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

    self:AimModeModule()
    -- ДЫХАНИЕ УБРАНО
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


function SWEP:AdjustMouseSensitivity()
    local mul = Lerp(self:GetAimModeDelta(), self.Zoom.FovMultiplier, 0.9)
    return Lerp(self:GetAimDelta(), 1, mul)
end