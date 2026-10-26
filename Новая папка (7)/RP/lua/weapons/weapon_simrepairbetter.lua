AddCSLuaFile()

SWEP.Category = "simfphys"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.ViewModel = "models/props_c17/tools_wrench01a.mdl"
SWEP.WorldModel = "models/props_c17/tools_wrench01a.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 53
SWEP.Weight = 42
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.HoldType = "slam"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

if CLIENT then
    SWEP.PrintName = "Vehicle Repair Tool"
    SWEP.Purpose = "repairs simfphys vehicles"
    SWEP.Author = "yetg"
    SWEP.Slot = 1
    SWEP.SlotPos = 9
    SWEP.IconLetter = "k"
    
    hook.Add("InputMouseApply", "rep_mouse_lock_cl", function(cmd, x, y, ang)
        if LocalPlayer():GetNWFloat("RepLockTime", 0) > CurTime() then
            return true
        end
    end)
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end

function SWEP:OwnerChanged()
end

function SWEP:Think()
    local ply = self:GetOwner()
    if IsValid(ply) then
        if ply:GetNWFloat("RepLockTime", 0) > CurTime() then
            if self:GetHoldType() ~= "normal" then self:SetHoldType("normal") end
        else
            if self:GetHoldType() ~= "slam" then self:SetHoldType("slam") end
        end
    end
end

function SWEP:PrimaryAttack()
    local ply = self:GetOwner()
    if not IsValid(ply) then return end
    if ply:GetNWFloat("RepLockTime", 0) > CurTime() then return end

    local tr = ply:GetEyeTrace()
    local ent = tr.Entity
    if not IsValid(ent) then return end

    local cls = ent:GetClass():lower()
    local is_v = cls == "gmod_sent_vehicle_fphysics_base"
    local is_w = cls == "gmod_sent_vehicle_fphysics_wheel"

    if not is_v and not is_w then return end
    if (tr.HitPos - ply:GetPos()):Length() > 100 then return end

    local dur = 8
    if is_v then
        local hp = ent:GetCurHealth()
        local mx = ent:GetMaxHealth()
        if hp >= mx then 
            return 
        end
        dur = 8 + (1 - math.Clamp(hp / mx, 0, 1)) * 27
    elseif is_w then
        if not ent:GetDamaged() then
            return 
        end
    end

    if SERVER then
        ply:SetNWFloat("RepLockTime", CurTime() + dur)
        ply:SetNWFloat("RepLockDuration", dur)
        ply:SetNWAngle("RepLockAngles", ply:EyeAngles())

        local snds = {
            "physics/metal/metal_box_impact_bullet1.wav",
            "physics/metal/metal_box_impact_bullet2.wav",
            "physics/metal/metal_box_impact_bullet3.wav",
            "weapons/357/357_reload1.wav"
        }
        
        local tk = math.floor(dur / 1.2)
        timer.Create("rep_snd_" .. ply:EntIndex(), 1.2, tk, function()
            if not IsValid(ply) or not IsValid(ent) then return end
            ply:EmitSound(snds[math.random(#snds)], 65, 100, 0.35, CHAN_AUTO)
        end)

        timer.Simple(dur, function()
            if not IsValid(ply) or not IsValid(ent) then return end
            if ply:GetActiveWeapon() ~= self then return end

            if is_v then
                ent:SetCurHealth(ent:GetMaxHealth())
                ent:SetOnFire(false)
                ent:SetOnSmoke(false)
                
                net.Start("simfphys_lightsfixall")
                net.WriteEntity(ent)
                net.Broadcast()
                
                ent:OnRepaired()
                hook.Run("simfphysOnRepaired", ent)
                
                if istable(ent.Wheels) then
                    for i = 1, table.Count(ent.Wheels) do
                        local wh = ent.Wheels[i]
                        if IsValid(wh) then wh:SetDamaged(false) end
                    end
                end
            elseif is_w then
                ent:SetDamaged(false)
            end
        end)
    end
end

function SWEP:DrawHUD()
    local ply = LocalPlayer()
    if ply:InVehicle() then return end

    local lt = ply:GetNWFloat("RepLockTime", 0)
    local ct = CurTime()

    if lt > ct then
        local dur = ply:GetNWFloat("RepLockDuration", 1)
        local rem = lt - ct
        local pct = math.Clamp(1 - (rem / dur), 0, 1)

        local w, h = ScrW(), ScrH()
        local bw, bh = 300, 20
        local bx = (w - bw) / 2
        local by = (h - bh) / 2 + 40

        draw.RoundedBox(4, bx, by, bw, bh, Color(0, 0, 0, 150))
        draw.RoundedBox(4, bx + 2, by + 2, (bw - 4) * pct, bh - 4, Color(255, 128, 0, 220))
    end
end

function SWEP:SecondaryAttack()
    return false
end

function SWEP:Deploy()
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:DrawWorldModel()
    local ply = self:GetOwner()
    if IsValid(ply) then
        local bn = ply:LookupBone("ValveBiped.Bip01_R_Hand")
        if bn then
            local pos, ang = ply:GetBonePosition(bn)
            if pos and ang then
                ang:RotateAroundAxis(ang:Forward(), 100)
                ang:RotateAroundAxis(ang:Right(), 80)
                ang:RotateAroundAxis(ang:Up(), 10)
                pos = pos + ang:Forward() * 4.5 + ang:Right() * 1.5 + ang:Up() * -1.5
                self:SetRenderOrigin(pos)
                self:SetRenderAngles(ang)
                self:SetupBones()
                self:DrawModel()
                return
            end
        end
    end
    self:DrawModel()
end

hook.Add("StartCommand", "rep_movement_lock", function(ply, cmd)
    if ply:GetNWFloat("RepLockTime", 0) > CurTime() then
        cmd:ClearMovement()
        cmd:SetForwardMove(0)
        cmd:SetSideMove(0)
        cmd:SetUpMove(0)
        
        local lockAng = ply:GetNWAngle("RepLockAngles", Angle(0, 0, 0))
        if lockAng and lockAng ~= Angle(0, 0, 0) then
            cmd:SetViewAngles(lockAng)
        end

        local buttons = cmd:GetButtons()
        buttons = bit.bor(buttons, IN_DUCK)
        buttons = bit.band(buttons, bit.bnot(IN_JUMP))
        buttons = bit.band(buttons, bit.bnot(IN_SPEED))
        cmd:SetButtons(buttons)
    end
end)

hook.Add("SetupMove", "rep_movement_freeze", function(ply, mv, cmd)
    if ply:GetNWFloat("RepLockTime", 0) > CurTime() then
        mv:SetMaxClientSpeed(0)
        mv:SetMaxSpeed(0)
        mv:SetVelocity(Vector(0, 0, 0))
        
        local buttons = mv:GetButtons()
        buttons = bit.bor(buttons, IN_DUCK)
        buttons = bit.band(buttons, bit.bnot(IN_JUMP))
        buttons = bit.band(buttons, bit.bnot(IN_SPEED))
        mv:SetButtons(buttons)
    end
end)

hook.Add("CalcView", "RepairImmersiveView", function(ply, pos, ang, fov)
    if ply:Alive() and ply:GetNWFloat("RepLockTime", 0) > CurTime() then
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

hook.Add("CalcMainActivity", "RepairAnimOverride", function(ply)
    if ply:GetNWFloat("RepLockTime", 0) > CurTime() then
        local seq = ply:LookupSequence("roofidle1")
        if seq and seq >= 0 then 
            return ACT_HL2MP_IDLE, seq 
        end
    end
end)

hook.Add("UpdateAnimation", "RepairAnimUpdateOverride", function(ply)
    if ply:GetNWFloat("RepLockTime", 0) > CurTime() then
        local seq = ply:LookupSequence("roofidle1")
        if seq and seq >= 0 then
            ply:SetSequence(seq)
            return true
        end
    end
end)