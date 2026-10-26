AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "BadPills"
ENT.Category = "HealingItems"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/props_lab/jar01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    
    if SERVER then
        self:SetUseType(SIMPLE_USE)
    end

    local p = self:GetPhysicsObject()
    if p:IsValid() then 
        p:Wake() 
    end
end

function ENT:Use(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    
    Horrors2 = Horrors2 or {}

    if not Horrors2[ply] and not (Drugs and Drugs[ply]) then
        Horrors2[ply] = CurTime() + 48
        ply:SetNWFloat("Horror2Time", CurTime())
        ply:SetNWFloat("Horror2Duration", 48)
        
        ply:ChatPrint("СУКА Я УБИТЫЙ")
        ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
        self:EmitSound("bandage/pills.wav")
        
        ply:EmitSound("ambient/voices/cough" .. math.random(1, 4) .. ".wav", 75, 100)
        
        timer.Simple(0.1, function()
            if IsValid(self) then self:Remove() end
        end)
    end
end