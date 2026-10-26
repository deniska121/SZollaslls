AddCSLuaFile()

function SWEP:Think()
    self:LoadSpawnPreset()
    if (not self.m_bInitialized and IsFirstTimePredicted()) then
        self:Initialize()
    end
    if (not self.m_bDrawn and self:IsDrawing() and (IsFirstTimePredicted() or game.SinglePlayer())) then
        self:Deploy(true)
    end
    if (not self.m_bHolstered and self:GetIsHolstering() and IsFirstTimePredicted()) then
        self:Holster(self:GetNextWeapon(), true)
    end
    if (not self.m_bReloaded and self:GetIsReloading() and IsFirstTimePredicted()) then
        self:Reload(true)
    end
    if (self.bCustomize ~= self:GetIsCustomizing() and IsFirstTimePredicted()) then
        self.bCustomize = self:GetIsCustomizing()
        self:Customize()
    end
    if (CurTime() >= self:GetNextPrimaryFire() and self.CanPump and self:CanPump()) and not self:GetHasPumped() then
        local anim = "Rechamber"
        if (IsFirstTimePredicted()) then
            self:PlayViewModelAnimation(anim)
        end
        self:SetNextPrimaryFire(CurTime() + self:GetAnimLength(anim))
        self:SetHasPumped(true)
    end
    if (self:GetIsHolstering() and CurTime() >= self:GetNextHolsterTime() and IsValid(self:GetNextWeapon()) and self:GetNextWeapon() ~= self and self:GetNextWeapon() ~= self:GetOwner()) then
        self.m_bDrawn = false
        if (CLIENT and (IsFirstTimePredicted() or game.SinglePlayer())) then
            input.SelectWeapon(self:GetNextWeapon())
        end
        return
    end
    if (CurTime() > self:GetNextPrimaryFire() + 0.15) then
        self:SetSprayRounds(0)
    end
    local target = Lerp(self:GetAimDelta(), self.Cone.Hip, self.Cone.Ads) / GetConVar("mgbase_sv_accuracy"):GetFloat()
    self:SetCone(math.Approach(self:GetCone(), target, 4 * FrameTime()))
    if (CurTime() <= self:GetNextMeleeTime()) then
        self:SetCone(self.Cone.Max)
    end
    self:ReloadBehaviourModule()
    self:AimBehaviourModule()
    self:SprintBehaviourModule()
    if (self:GetOwner():GetMoveType() == MOVETYPE_LADDER and not self:IsDrawing()) then
        self:Holster(self:GetOwner())
    else
        if (self:GetIsHolstering() and self:GetNextWeapon() == self:GetOwner()) then
            self:Deploy()
        end
    end
    self:SetShouldHoldType()
    self:FiremodeBehaviourModule()
    self:MeleeBehaviourModule()
    if (self:GetOwner():KeyDown(IN_USE) and self:GetOwner():KeyPressed(IN_ATTACK2)) then
        self:SetSafety(not self:GetSafety())
        self:SetShouldHoldType(true)
    end
    if (CLIENT and game.SinglePlayer()) then return end
    if (self.Trigger ~= nil) then
        local bDown = self:GetOwner():KeyDown(IN_ATTACK)
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
    if (self:IsCustomizing()) then return false end
    if (CurTime() < self:GetNextFiremodeTime()) then return false end
    if (self:GetOwner():KeyDown(IN_USE)) then return false end
    if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
    if (CurTime() < self:GetNextMeleeTime()) then return false end
    if (CurTime() < self:GetNextSprintTime()) then return false end
    return true
end

function SWEP:CanPlayTriggerOut()
    if (self:IsCustomizing()) then return end
    if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
    if (CurTime() < self:GetNextMeleeTime()) then return false end
    if (CurTime() < self:GetNextSprintTime()) then return false end
    return true
end