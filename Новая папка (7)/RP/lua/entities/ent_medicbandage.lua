AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "MedicBandage"
ENT.Category = "HealingItems"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/healthvial.mdl")
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
    caller:EmitSound("bandage/medicheal.wav")

    if SERVER then
        caller:SetHealth(math.min(caller:Health() + 5, caller:GetMaxHealth()))
    end

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