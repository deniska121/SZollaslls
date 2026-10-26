AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bandage"
ENT.Category = "HealingItems"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/bandageroll.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if not IsValid(caller) or not caller:IsPlayer() then return end
    if caller:GetNWFloat("bandage_locktime", 0) > CurTime() then return end
    if not (Bleeds and Bleeds[caller]) then return end

    Bleeds[caller] = nil
    caller:SetNWFloat("BleedTime", 0)
    caller:EmitSound("bandage/heal.mp3")
    if IsValid(self) then self:Remove() end

    local dur = 3
    local now = CurTime()
    caller:SetNWFloat("bandage_locktime", now + dur)
    caller:SetNWFloat("bandage_starttime", now)
    caller:SetNWFloat("bandage_duration", dur)
    caller:SetNWAngle("bandage_lockang", caller:EyeAngles())
    caller:SetNWBool("bandage_active", true)
    caller:SetNWString("bandage_seq", "crouchshoottocrouchd")

    timer.Simple(1.3, function()
        if IsValid(caller) then
            caller:SetNWString("bandage_seq", "drop")
        end
    end)

    timer.Simple(dur, function()
        if IsValid(caller) then
            caller:SetNWFloat("bandage_locktime", 0)
            caller:SetNWBool("bandage_active", false)
            caller:SetNWString("bandage_seq", "")
        end
    end)
end

if CLIENT then
    hook.Add("InputMouseApply", "immersivecameralmao", function(cmd, x, y, ang)
        if LocalPlayer():GetNWFloat("bandage_locktime", 0) > CurTime() then
            return true
        end
    end)

    hook.Add("CalcView", "immersivecameralmao", function(ply, pos, ang, fov)
        if IsValid(ply) and ply:Alive() and ply:GetNWFloat("bandage_locktime", 0) > CurTime() then
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

    hook.Add("CalcMainActivity", "immersivecameralmao", function(ply)
        if IsValid(ply) and ply:GetNWFloat("bandage_locktime", 0) > CurTime() then
            local seqname = ply:GetNWString("bandage_seq", "")
            if seqname ~= "" then
                local seq = ply:LookupSequence(seqname)
                if seq and seq >= 0 then
                    return ACT_HL2MP_IDLE, seq
                end
            end
        end
    end)

    hook.Add("UpdateAnimation", "immersivecameralmao", function(ply)
        if IsValid(ply) and ply:GetNWFloat("bandage_locktime", 0) > CurTime() then
            local seqname = ply:GetNWString("bandage_seq", "")
            if seqname ~= "" then
                local seq = ply:LookupSequence(seqname)
                if seq and seq >= 0 then
                    ply:SetSequence(seq)
                    return true
                end
            end
        end
    end)

    hook.Add("DrawOverlay", "immersivecameralmao", function()
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end
        local lt = ply:GetNWFloat("bandage_locktime", 0)
        local ct = CurTime()
        if lt <= ct then return end

        local dur = ply:GetNWFloat("bandage_duration", 1)
        local rem = lt - ct
        local pct = math.Clamp(1 - (rem / dur), 0, 1)

        local w, h = ScrW(), ScrH()
        local bw, bh = 300, 20
        local bx = (w - bw) / 2
        local by = (h - bh) / 2 + 40

        draw.RoundedBox(4, bx, by, bw, bh, Color(0, 0, 0, 150))
        draw.RoundedBox(4, bx + 2, by + 2, (bw - 4) * pct, bh - 4, Color(255, 200, 0, 220))
    end)
end

hook.Add("StartCommand", "immersivecameralmao", function(ply, cmd)
    if IsValid(ply) and ply:GetNWFloat("bandage_locktime", 0) > CurTime() then
        cmd:ClearMovement()
        cmd:SetForwardMove(0)
        cmd:SetSideMove(0)
        cmd:SetUpMove(0)

        local lockAng = ply:GetNWAngle("bandage_lockang", Angle(0, 0, 0))
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

hook.Add("SetupMove", "immersivecameralmao", function(ply, mv, cmd)
    if IsValid(ply) and ply:GetNWFloat("bandage_locktime", 0) > CurTime() then
        local buttons = mv:GetButtons()
        buttons = bit.bor(buttons, IN_DUCK)
        buttons = bit.band(buttons, bit.bnot(IN_JUMP))
        buttons = bit.band(buttons, bit.bnot(IN_SPEED))
        mv:SetButtons(buttons)
    end
end)