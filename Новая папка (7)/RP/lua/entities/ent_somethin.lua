AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "BottleOfSomethin"
ENT.Category = "HealingItems"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_plasticbottle003a.mdl")
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
    
    Drugs = Drugs or {}

    if not Drugs[ply] then
        Drugs[ply] = CurTime() + 30
        ply:SetNWFloat("DrugTime", CurTime())
        
        ply:ChatPrint("Ты выпил что-то странное.. Нахуя неизвестно.")
        ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
        self:EmitSound("bandage/slurp.wav")
        
        timer.Simple(0.1, function()
            if IsValid(self) then self:Remove() end
        end)
    end
end