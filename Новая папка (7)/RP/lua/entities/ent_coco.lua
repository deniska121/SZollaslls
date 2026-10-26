AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Пакетик"
ENT.Category = "HealingItems"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/srcocainelab/ziplockedcocaine.mdl")
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
    if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() then return end
    
    Cocai = Cocai or {}

    if not Cocai[ply] and not (Drugs and Drugs[ply]) then
        Cocai[ply] = CurTime() + 180
        ply:SetNWFloat("CocoTime", CurTime())
        ply:SetNWFloat("CocoDur", 180)
        
        ply:ChatPrint("Тут могла бы быть его фраза но мне чота лен")
        ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
        self:EmitSound("bandage/pills.wav")
    end
end