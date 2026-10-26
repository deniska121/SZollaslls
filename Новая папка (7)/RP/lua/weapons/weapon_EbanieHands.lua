if SERVER then
    AddCSLuaFile()
    SWEP.Weight = 5
    SWEP.AutoSwitchTo = false
    SWEP.AutoSwitchFrom = false
    util.AddNetworkString("pidle")
    util.AddNetworkString("surrtog")
    
    net.Receive("pidle", function(len, ply)
        local seq = net.ReadString()
        local cur = ply:GetNWString("HandsIdleAnim", "")
        if cur == seq then ply:SetNWString("HandsIdleAnim", "") else ply:SetNWString("HandsIdleAnim", seq) end
    end)
    
    net.Receive("surrtog", function(len, ply)
        local active = net.ReadBool()
        if active then
            ply:SetNWBool("SurrenderActive", true)
            ply:SetNWString("SurrenderAnim", "idle_all_cower")
            local seq = ply:LookupSequence("idle_all_cower")
            if seq and seq >= 0 then
                ply:SetSequence(seq)
                ply:SetCycle(0)
                ply:SetPlaybackRate(1)
            end
        else
            ply:SetNWBool("SurrenderActive", false)
            ply:SetNWString("SurrenderAnim", "")
            ply:SetNWString("HandsIdleAnim", "")
            local seq = ply:LookupSequence("idle_all_01")
            if seq and seq >= 0 then ply:SetSequence(seq) end
        end
    end)
    
    hook.Add("PlayerDeath", "surr_death", function(ply)
        if IsValid(ply) and ply:IsPlayer() then
            ply:SetNWBool("SurrenderActive", false)
            ply:SetNWString("SurrenderAnim", "")
            ply:SetNWString("HandsIdleAnim", "")
        end
    end)
    
    hook.Add("PlayerSpawn", "surr_spawn", function(ply)
        if IsValid(ply) and ply:IsPlayer() then
            ply:SetNWBool("SurrenderActive", false)
            ply:SetNWString("SurrenderAnim", "")
            ply:SetNWString("HandsIdleAnim", "")
        end
    end)
    
    hook.Add("PlayerSwitchWeapon", "surr_wpnsv", function(ply, old, new)
        if IsValid(ply) and ply:IsPlayer() and ply:GetNWBool("SurrenderActive", false) then
            ply:SetNWBool("SurrenderActive", false)
            ply:SetNWString("SurrenderAnim", "")
            ply:SetNWString("HandsIdleAnim", "")
            local seq = ply:LookupSequence("idle_all_01")
            if seq and seq >= 0 then ply:SetSequence(seq) end
        end
    end)
end

SWEP.SwayScale = 3
SWEP.BobScale = 3
SWEP.InstantPickup = true
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Grab and move stuff with your friends!"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType = "normal"
SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/props_junk/cardboard_box004a.mdl"
SWEP.UseHands = true
SWEP.AttackSlowDown = 0.5
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.ReachDistance = 60
SWEP.HomicideSWEP = true

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "NextIdle")
    self:NetworkVar("Bool", 2, "Fists")
    self:NetworkVar("Float", 1, "NextDown")
    self:NetworkVar("Bool", 3, "Blocking")
    self:NetworkVar("Bool", 4, "IsCarrying")
    self:NetworkVar("Float", 2, "TaskProgress")
    self:NetworkVar("Entity", 5, "CarryEnt")
end

function SWEP:PreDrawViewModel(vm, wep, ply)
    vm:SetMaterial("engine/occlusionproxy")
end

function SWEP:Initialize()
    self:SetNextIdle(CurTime() + 5)
    self:SetNextDown(CurTime() + 5)
    self:SetHoldType(self.HoldType)
    self:SetFists(false)
    self:SetBlocking(false)
    self.LastAttackTime = 0
end

function SWEP:Deploy()
    if not IsFirstTimePredicted() then
        self:DoBFSAnimation("fists_draw")
        if IsValid(self.Owner) then
            self.Owner:GetViewModel():SetPlaybackRate(0.1)
        end
        return
    end
    self:SetNextPrimaryFire(CurTime() + 0.1)
    self:SetFists(false)
    self:SetNextDown(CurTime())
    self:DoBFSAnimation("fists_draw")
    return true
end

function SWEP:Holster()
    if not IsValid(self) or not IsValid(self.Owner) then return true end
    if SERVER then
        if self.Owner:GetNWBool("SurrenderActive", false) then
            self.Owner:SetNWBool("SurrenderActive", false)
            self.Owner:SetNWString("SurrenderAnim", "")
            self.Owner:SetNWString("HandsIdleAnim", "")
        end
    end
    self:OnRemove()
    return true
end

function SWEP:CanPrimaryAttack()
    return true
end

local pickupWhiteList = {
    ["prop_ragdoll"] = true,
    ["prop_physics"] = true,
    ["prop_physics_multiplayer"] = true
}

function SWEP:CanPickup(ent)
    if not IsValid(ent) then return false end
    if ent:IsNPC() then return false end
    if ent:IsPlayer() then return false end
    if ent:IsWorld() then return false end
    local class = ent:GetClass()
    if CLIENT then return true end
    if ent:IsPlayerHolding() then return false end
    if IsValid(ent:GetPhysicsObject()) and ent:GetPhysicsObject():IsMotionEnabled() then return true end
    return false
end

function SWEP:SecondaryAttack()
    if not IsFirstTimePredicted() then return end
    if self:GetFists() then return end
    if SERVER then
        self:SetCarrying()
        local tr = self.Owner:GetEyeTraceNoCursor()
        if IsValid(tr.Entity) and self:CanPickup(tr.Entity) and not tr.Entity:IsPlayer() then
            local Dist = (self.Owner:GetShootPos() - tr.HitPos):Length()
            if Dist < self.ReachDistance then
                self:SetCarrying(tr.Entity, tr.PhysicsBone, tr.HitPos, Dist)
                tr.Entity.Touched = true
                self:ApplyForce()
            end
        elseif IsValid(tr.Entity) and tr.Entity:IsPlayer() then
            local Dist = (self.Owner:GetShootPos() - tr.HitPos):Length()
            if Dist < self.ReachDistance then
                sound.Play("Flesh.ImpactSoft", self.Owner:GetShootPos(), 65, math.random(90, 110))
                self.Owner:SetVelocity(self.Owner:GetAimVector() * 20)
                tr.Entity:SetVelocity(-self.Owner:GetAimVector() * 50)
                self:SetNextSecondaryFire(CurTime() + 0.25)
            end
        end
    end
end

function SWEP:ApplyForce()
    if not IsValid(self.CarryEnt) then return end
    local target = self.Owner:GetAimVector() * self.CarryDist + self.Owner:GetShootPos() + Vector(0, 0, 5)
    local phys = self.CarryEnt:GetPhysicsObjectNum(self.CarryBone)
    if IsValid(phys) then
        local TargetPos = phys:GetPos()
        if self.CarryPos then TargetPos = self.CarryEnt:LocalToWorld(self.CarryPos) end
        local vec = target - TargetPos
        local len, mul = vec:Length(), self.CarryEnt:GetPhysicsObject():GetMass()
        local StandingEnt = self.Owner:GetGroundEntity()
        local StandingOn = IsValid(StandingEnt) and ((StandingEnt == self.CarryEnt) or (StandingEnt:IsConstrained() and table.HasValue(constraint.GetAllConstrainedEntities(StandingEnt), self.CarryEnt)))
        local PlyIn = (self.CarryEnt == self.Owner:GetVehicle())
        if len > self.ReachDistance or StandingOn or PlyIn then
            self:SetCarrying()
            return
        end
        if self.CarryEnt:GetClass() == "prop_ragdoll" then mul = mul * 10 end
        vec:Normalize()
        local plyVel = self.Owner:GetVelocity()
        local avec, velo = vec * len ^ 1.5, phys:GetVelocity() - (plyVel * 2)
        local Force = (avec - velo / 2) * mul
        local ForceNormal = Force:GetNormalized()
        local ForceMagnitude = Force:Length()
        ForceMagnitude = math.Clamp(ForceMagnitude, 0, 2000)
        Force = ForceNormal * ForceMagnitude
        if self.CarryPos then
            phys:ApplyForceOffset(Force, self.CarryEnt:LocalToWorld(self.CarryPos))
        else
            phys:ApplyForceCenter(Force)
        end
        phys:ApplyForceCenter(Vector(0, 0, mul))
        phys:AddAngleVelocity(-phys:GetAngleVelocity() / 10)
    end
end

function SWEP:OnDrop()
    self:Remove()
end

function SWEP:OnRemove()
    if IsValid(self.Owner) and CLIENT and self.Owner:IsPlayer() then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then vm:SetMaterial("") end
    end
end

function SWEP:GetCarrying()
    return self.CarryEnt
end

function SWEP:SetCarrying(ent, bone, pos, dist)
    if not SERVER then return end
    if IsValid(ent) then
        self:SetNWEntity("CarryEnt", ent)
        self.CarryEnt = ent
        self.CarryBone = bone
        self.CarryDist = dist
        if not (ent:GetClass() == "prop_ragdoll") then
            self.CarryPos = ent:WorldToLocal(pos)
        else
            self.CarryPos = nil
        end
    else
        self:SetNWEntity("CarryEnt", NULL)
        self.CarryEnt = nil
        self.CarryBone = nil
        self.CarryPos = nil
        self.CarryDist = nil
    end
end

function SWEP:Think()
    if not IsValid(self.Owner) then return end
    if self.Owner:KeyDown(IN_ATTACK2) and not self:GetFists() then
        if IsValid(self.CarryEnt) then self:ApplyForce() end
    elseif self.CarryEnt then
        self:SetCarrying()
    end
    if self:GetFists() and self.Owner:KeyDown(IN_ATTACK2) then
        self:SetNextPrimaryFire(CurTime() + 0.5)
        self:SetBlocking(true)
    else
        self:SetBlocking(false)
    end
    local HoldType = "fist"
    if self:GetFists() then
        HoldType = "fist"
        local Time = CurTime()
        if self:GetNextIdle() < Time then
            self:DoBFSAnimation("fists_idle_0" .. math.random(1, 2))
            self:UpdateNextIdle()
        end
        if self:GetBlocking() then
            self:SetNextDown(Time + 1)
            HoldType = "normal"
        end
        if (self:GetNextDown() < Time) or self.Owner:KeyDown(IN_SPEED) then
            self:SetNextDown(Time + 1)
            self:SetFists(false)
            self:SetBlocking(false)
        end
    else
        HoldType = "normal"
        self:DoBFSAnimation("fists_draw")
    end
    if IsValid(self.CarryEnt) or self.CarryEnt then HoldType = "magic" end
    if self.Owner:KeyDown(IN_SPEED) then HoldType = "normal" end
    if SERVER then self:SetHoldType(HoldType) end
end

function SWEP:PrimaryAttack()
    local side = "fists_left"
    if math.random(1, 2) == 1 then side = "fists_right" end
    self:SetNextDown(CurTime() + 5)
    if not self:GetFists() then
        self:SetFists(true)
        self:DoBFSAnimation("fists_draw")
        self:SetNextPrimaryFire(CurTime() + 0.35)
        return
    end
    if self:GetBlocking() then return end
    if self.Owner:KeyDown(IN_SPEED) then return end
    if not IsFirstTimePredicted() then
        self:DoBFSAnimation(side)
        if IsValid(self.Owner) then
            self.Owner:GetViewModel():SetPlaybackRate(1.25)
        end
        return
    end
    self.LastAttackTime = CurTime()
    self.Owner:ViewPunch(Angle(0, 0, math.random(-2, 2)))
    self:DoBFSAnimation(side)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    if IsValid(self.Owner) then
        self.Owner:GetViewModel():SetPlaybackRate(1.25)
    end
    self:UpdateNextIdle()
    if SERVER then
        self.Owner:ViewPunch(Angle(0, 0, math.random(-2, 2)))
        timer.Simple(0.075, function()
            if IsValid(self) and IsValid(self.Owner) then self:AttackFront() end
        end)
    end
    self:SetNextPrimaryFire(CurTime() + 1)
    self:SetNextSecondaryFire(CurTime() + 0.35)
end

function SWEP:AttackFront()
    if CLIENT then return end
    if not IsValid(self.Owner) then return end
    self.Owner:LagCompensation(true)
    local tr = util.TraceLine({
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 55,
        filter = self.Owner
    })
    local Ent = tr.Entity
    local HitPos = tr.HitPos
    local AimVec = self.Owner:GetAimVector()
    if IsValid(Ent) then
        local SelfForce = 125
        local Mul = 1
        local hitSound = "nmrihimpact/blunt_light" .. math.random(1, 8) .. ".wav"
        if Ent:IsNPC() or Ent:IsPlayer() then
            SelfForce = 25
            sound.Play(hitSound, HitPos, 65, math.random(90, 110))
        else
            sound.Play(hitSound, HitPos, 65, math.random(90, 110))
        end
        local DamageAmt = math.random(4, 6)
        local Dam = DamageInfo()
        Dam:SetAttacker(self.Owner)
        Dam:SetInflictor(self.Weapon)
        Dam:SetDamage(DamageAmt * Mul)
        Dam:SetDamageForce(AimVec * Mul ^ 3)
        Dam:SetDamageType(DMG_CLUB)
        Dam:SetDamagePosition(HitPos)
        Ent:TakeDamageInfo(Dam)
        local Phys = Ent:GetPhysicsObject()
        if IsValid(Phys) then
            if Ent:IsPlayer() then Ent:SetVelocity(AimVec * SelfForce * 1.5) end
            Phys:ApplyForceOffset(AimVec * 5000 * Mul, HitPos)
            self.Owner:SetVelocity(-AimVec * SelfForce * 0.8)
        end
        if Ent:GetClass() == "func_breakable_surf" then
            if math.random(1, 20) == 10 then Ent:Fire("break", "", 0) end
        end
    end
    self.Owner:LagCompensation(false)
end

function SWEP:Reload()
    if not IsFirstTimePredicted() then return end
    if not (self:GetFists()) then
        if IsValid(self:GetCarrying()) then
            self:SetCarrying()
        end
    end
    self:SetFists(false)
    self:SetBlocking(false)
    self:SetCarrying()
end

function SWEP:DrawWorldModel() end

function SWEP:DoBFSAnimation(anim)
    if not IsValid(self.Owner) then return end
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
    end
end

function SWEP:UpdateNextIdle()
    if not IsValid(self.Owner) then return end
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        self:SetNextIdle(CurTime() + vm:SequenceDuration())
    end
end

function SWEP:IsEntSoft(ent)
    return ent:IsNPC() or ent:IsPlayer()
end

if CLIENT then
    SWEP.PrintName = "Руки"
    SWEP.Slot = 0
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    SWEP.ViewModelFOV = 45
    SWEP.BounceWeaponIcon = false
    
    net.Receive("surrtog", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        local active = net.ReadBool()
        ply:SetNWBool("SurrenderActive", active)
        if not active then
            ply:SetNWString("SurrenderAnim", "")
            ply:SetNWString("HandsIdleAnim", "")
            local seq = ply:LookupSequence("idle_all_01")
            if seq and seq >= 0 then ply:SetSequence(seq) end
        else
            ply:SetNWString("SurrenderAnim", "idle_all_cower")
            local seq = ply:LookupSequence("idle_all_cower")
            if seq and seq >= 0 then
                ply:SetSequence(seq)
                ply:SetCycle(0)
                ply:SetPlaybackRate(1)
            end
        end
    end)
    
    local dotMat = Material("msd/icons/dot.png", "smooth")
    
    function SWEP:DrawHUD()
        if not IsValid(self) or not IsValid(self.Owner) then return end
        if GetConVar("cl_drawhud"):GetBool() == false then return end
        if not (GetViewEntity() == LocalPlayer()) then return end
        local ply = LocalPlayer()
        local unconscious = (IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE) or ply:GetNWBool("UnconsciousInVehicle", false)
        if ply:InVehicle() or unconscious then return end
        local cx, cy = ScrW() / 2, ScrH() / 2
        local iconSize = 30
        local showHand = false
        if not self:GetFists() then
            local Tr = util.QuickTrace(self.Owner:GetShootPos(), self.Owner:GetAimVector() * self.ReachDistance, {self.Owner})
            if Tr.Hit and self:CanPickup(Tr.Entity) then
                showHand = true
                local handMat = Material("msd/icons/hand-okay.png", "smooth")
                surface.SetMaterial(handMat)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRect(cx - iconSize / 2, cy - iconSize / 2, iconSize, iconSize)
            end
        end
        local carryEnt = self:GetNWEntity("CarryEnt")
        if IsValid(carryEnt) and self.Owner:KeyDown(IN_ATTACK2) then
            local handMat = Material("msd/icons/hand-okay.png", "smooth")
            surface.SetMaterial(handMat)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRect(cx - iconSize / 2, cy - iconSize / 2, iconSize, iconSize)
            local entPos = carryEnt:GetPos() + carryEnt:OBBCenter()
            local screenPos = entPos:ToScreen()
            surface.SetDrawColor(255, 255, 255, 200)
            surface.DrawLine(cx, cy, screenPos.x, screenPos.y)
        end
        if not showHand and not (IsValid(carryEnt) and self.Owner:KeyDown(IN_ATTACK2)) then
            local dotSize = 24
            surface.SetMaterial(dotMat)
            surface.SetDrawColor(255, 255, 255, 128)
            surface.DrawTexturedRect(cx - dotSize / 2, cy - dotSize / 2, dotSize, dotSize)
        end
    end
    
    surface.CreateFont("med_font_radial", {
        font = "Roboto",
        size = 22,
        weight = 800,
        extended = true,
        antialiasing = true
    })
    
    local anims = {
        {name = "Обычная", seq = "idle_all_01"},
        {name = "Альт1", seq = "idle_all_02"},
        {name = "Горбатый", seq = "idle_all_angry"},
        {name = "Испуган", seq = "idle_all_scared"},
        {name = "Альт2", seq = "LineIdle01"},
        {name = "РучкиСкрестил1", seq = "LineIdle02"},
        {name = "Вкармашки", seq = "LineIdle04"},
        {name = "КрутойДохуя", seq = "menu_combine"},
        {name = "РучкиСкрестил2", seq = "pose_standing_01"},
        {name = "РукиНаПоясе", seq = "pose_standing_02"}
    }
    
    local function isUnc(ply)
        if not IsValid(ply) then return true end
        if not ply:Alive() then return true end
        if ply:GetNWBool("Unconscious", false) then return true end
        if IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE then return true end
        if ply:GetNWBool("UnconsciousInVehicle", false) then return true end
        return false
    end
    
    hook.Add("PlayerJump", "surr_jump", function(ply)
        if not IsValid(ply) or not ply:IsPlayer() or ply ~= LocalPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then
            net.Start("surrtog")
            net.WriteBool(false)
            net.SendToServer()
        end
    end)
    
    hook.Add("PlayerSwitchWeapon", "surr_wpn", function(ply, old, new)
        if not IsValid(ply) or not ply:IsPlayer() or ply ~= LocalPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then
            net.Start("surrtog")
            net.WriteBool(false)
            net.SendToServer()
        end
    end)
    
    hook.Add("StartCommand", "surr_move", function(ply, cmd)
        if not IsValid(ply) or not ply:IsPlayer() or ply ~= LocalPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then
            cmd:ClearMovement()
            cmd:SetForwardMove(0)
            cmd:SetSideMove(0)
            cmd:SetUpMove(0)
            local buttons = cmd:GetButtons()
            buttons = bit.band(buttons, bit.bnot(IN_JUMP))
            buttons = bit.band(buttons, bit.bnot(IN_DUCK))
            buttons = bit.band(buttons, bit.bnot(IN_SPEED))
            cmd:SetButtons(buttons)
        end
    end)
    
    hook.Add("SetupMove", "surr_freeze", function(ply, mv, cmd)
        if not IsValid(ply) or not ply:IsPlayer() or ply ~= LocalPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then
            mv:SetForwardSpeed(0)
            mv:SetSideSpeed(0)
            mv:SetUpSpeed(0)
            mv:SetMaxClientSpeed(0)
            mv:SetMaxSpeed(0)
            local buttons = mv:GetButtons()
            buttons = bit.band(buttons, bit.bnot(IN_JUMP))
            buttons = bit.band(buttons, bit.bnot(IN_DUCK))
            buttons = bit.band(buttons, bit.bnot(IN_SPEED))
            mv:SetButtons(buttons)
        end
    end)
    
    hook.Add("InputMouseApply", "surr_mouse", function(cmd, x, y, ang)
        local ply = LocalPlayer()
        if IsValid(ply) and ply:GetNWBool("SurrenderActive", false) then return true end
    end)
    
    hook.Add("CalcView", "surr_cam", function(ply, pos, ang, fov)
        if IsValid(ply) and ply:IsPlayer() and ply == LocalPlayer() and ply:GetNWBool("SurrenderActive", false) then
            local eyes = ply:LookupAttachment("eyes")
            if eyes and eyes > 0 then
                local attach = ply:GetAttachment(eyes)
                if attach and attach.Pos then
                    local bAng = attach.Ang
                    bAng:RotateAroundAxis(bAng:Right(), -10)
                    return {
                        origin = attach.Pos + bAng:Forward() * 2,
                        angles = bAng,
                        fov = fov,
                        drawviewer = true
                    }
                end
            end
        end
    end)
    
    hook.Add("CalcMainActivity", "surr_calc", function(ply)
        if IsValid(ply) and ply:IsPlayer() and ply:GetNWBool("SurrenderActive", false) then
            if not ply:Alive() or ply:Crouching() or ply:GetNWBool("Unconscious", false) or
               (IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE) or
               ply:GetNWBool("UnconsciousInVehicle", false) or ply:GetNWBool("WakeUpActive", false) or
               ply:GetNWFloat("MedLockTime", 0) > CurTime() then
                ply:SetNWBool("SurrenderActive", false)
                ply:SetNWString("SurrenderAnim", "")
                ply:SetNWString("HandsIdleAnim", "")
                return
            end
            local seq = ply:GetNWString("SurrenderAnim", "")
            if seq ~= "" then
                local id = ply:LookupSequence(seq)
                if id and id >= 0 then return ACT_HL2MP_IDLE, id end
            end
        end
    end)
    
    hook.Add("UpdateAnimation", "surr_upd", function(ply)
        if IsValid(ply) and ply:IsPlayer() and ply:GetNWBool("SurrenderActive", false) then
            if not ply:Alive() or ply:Crouching() or ply:GetNWBool("Unconscious", false) or
               (IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE) or
               ply:GetNWBool("UnconsciousInVehicle", false) or ply:GetNWBool("WakeUpActive", false) or
               ply:GetNWFloat("MedLockTime", 0) > CurTime() then
                ply:SetNWBool("SurrenderActive", false)
                ply:SetNWString("SurrenderAnim", "")
                ply:SetNWString("HandsIdleAnim", "")
                return
            end
            local seq = ply:GetNWString("SurrenderAnim", "")
            if seq ~= "" then
                local id = ply:LookupSequence(seq)
                if id and id >= 0 then
                    if ply:GetSequence() ~= id then
                        ply:SetSequence(id)
                        ply:SetCycle(0)
                        ply:SetPlaybackRate(1)
                    end
                    return true
                end
            end
        end
    end)
    
    hook.Add("CalcMainActivity", "idle_calc", function(ply)
        if not IsValid(ply) or not ply:IsPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then return end
        if ply:InVehicle() then return end
        if ply:GetInfoNum("cl_typing", 0) > 0 then return end
        if ply:Crouching() then return end
        if ply:GetNWBool("Unconscious", false) then return end
        if IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE then return end
        if ply:GetNWBool("UnconsciousInVehicle", false) then return end
        if ply:GetNWBool("WakeUpActive", false) then return end
        if ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end
        local active = ply:GetActiveWeapon()
        if not IsValid(active) then return end
        if active:GetClass() ~= "weapon_ebaniehands" then return end
        if active:GetFists() then return end
        local seq = ply:GetNWString("HandsIdleAnim", "")
        if seq ~= "" then
            local vel = ply:GetVelocity():Length2D()
            if vel < 5 then
                local lastAttack = active.LastAttackTime or 0
                if CurTime() - lastAttack > 0.5 then
                    local id = ply:LookupSequence(seq)
                    if id and id >= 0 then return ACT_HL2MP_IDLE, id end
                end
            end
        end
    end)
    
    hook.Add("UpdateAnimation", "idle_upd", function(ply)
        if not IsValid(ply) or not ply:IsPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then return end
        if ply:InVehicle() then return end
        if ply:GetInfoNum("cl_typing", 0) > 0 then return end
        if ply:Crouching() then return end
        if ply:GetNWBool("Unconscious", false) then return end
        if IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE then return end
        if ply:GetNWBool("UnconsciousInVehicle", false) then return end
        if ply:GetNWBool("WakeUpActive", false) then return end
        if ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end
        local active = ply:GetActiveWeapon()
        if not IsValid(active) then return end
        if active:GetClass() ~= "weapon_ebaniehands" then return end
        if active:GetFists() then return end
        local seq = ply:GetNWString("HandsIdleAnim", "")
        if seq ~= "" then
            local vel = ply:GetVelocity():Length2D()
            if vel < 5 then
                local lastAttack = active.LastAttackTime or 0
                if CurTime() - lastAttack > 0.5 then
                    local id = ply:LookupSequence(seq)
                    if id and id >= 0 then
                        if ply:GetSequence() ~= id then ply:SetSequence(id) end
                        return true
                    end
                end
            end
        end
    end)
    
    -- ФИКС: Добавляем проверку на существование методов в хуках
    local function safeGetFists(weapon)
        if not IsValid(weapon) then return false end
        if not weapon.GetFists then return false end
        return weapon:GetFists()
    end
    
    -- Переопределяем хуки с проверкой
    hook.Add("CalcMainActivity", "idle_calc_safe", function(ply)
        if not IsValid(ply) or not ply:IsPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then return end
        if ply:InVehicle() then return end
        if ply:GetInfoNum("cl_typing", 0) > 0 then return end
        if ply:Crouching() then return end
        if ply:GetNWBool("Unconscious", false) then return end
        if IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE then return end
        if ply:GetNWBool("UnconsciousInVehicle", false) then return end
        if ply:GetNWBool("WakeUpActive", false) then return end
        if ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end
        local active = ply:GetActiveWeapon()
        if not IsValid(active) then return end
        if active:GetClass() ~= "weapon_ebaniehands" then return end
        if not active.GetFists then return end
        if active:GetFists() then return end
        local seq = ply:GetNWString("HandsIdleAnim", "")
        if seq ~= "" then
            local vel = ply:GetVelocity():Length2D()
            if vel < 5 then
                local lastAttack = active.LastAttackTime or 0
                if CurTime() - lastAttack > 0.5 then
                    local id = ply:LookupSequence(seq)
                    if id and id >= 0 then return ACT_HL2MP_IDLE, id end
                end
            end
        end
    end)
    
    hook.Add("UpdateAnimation", "idle_upd_safe", function(ply)
        if not IsValid(ply) or not ply:IsPlayer() then return end
        if ply:GetNWBool("SurrenderActive", false) then return end
        if ply:InVehicle() then return end
        if ply:GetInfoNum("cl_typing", 0) > 0 then return end
        if ply:Crouching() then return end
        if ply:GetNWBool("Unconscious", false) then return end
        if IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE then return end
        if ply:GetNWBool("UnconsciousInVehicle", false) then return end
        if ply:GetNWBool("WakeUpActive", false) then return end
        if ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end
        local active = ply:GetActiveWeapon()
        if not IsValid(active) then return end
        if active:GetClass() ~= "weapon_ebaniehands" then return end
        if not active.GetFists then return end
        if active:GetFists() then return end
        local seq = ply:GetNWString("HandsIdleAnim", "")
        if seq ~= "" then
            local vel = ply:GetVelocity():Length2D()
            if vel < 5 then
                local lastAttack = active.LastAttackTime or 0
                if CurTime() - lastAttack > 0.5 then
                    local id = ply:LookupSequence(seq)
                    if id and id >= 0 then
                        if ply:GetSequence() ~= id then ply:SetSequence(id) end
                        return true
                    end
                end
            end
        end
    end)
end

hook.Add("EntityTakeDamage", "CancelDamageFromCarryEnt", function(target, dmginfo)
    if target:IsPlayer() then
        local Weppy = target:GetActiveWeapon()
        if IsValid(Weppy) and IsValid(Weppy.CarryEnt) then
            if (dmginfo:GetInflictor() == Weppy.CarryEnt) and (dmginfo:GetDamageType() == DMG_CRUSH) then
                return true
            end
        end
    end
end)