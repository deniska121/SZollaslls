AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "AntiDrug(PlaceHolder)"
ENT.Category = "HealingItems"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/props_junk/garbage_plasticbottle001a.mdl")
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
    
    
    if Drugs then Drugs[ply] = nil end
    if Horrors then Horrors[ply] = nil end
    if Horrors2 then Horrors2[ply] = nil end


    ply:SetNWFloat("DrugTime", 0)
    ply:SetNWFloat("HorrorTime", 0)
    ply:SetNWFloat("HorrorDuration", 0)
    ply:SetNWFloat("Horror2Time", 0)
    ply:SetNWFloat("Horror2Duration", 0)
    
    ply:ChatPrint("Вкусняшка.")
    ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
    self:EmitSound("bandage/slurp.wav")
    
 
    ply:EmitSound("ambient/voices/cough" .. math.random(1, 4) .. ".wav", 75, 100)
    
   
    timer.Simple(1.2, function()
        if IsValid(ply) and ply:Alive() then
            ply:EmitSound("ambient/voices/cough" .. math.random(1, 4) .. ".wav", 75, 100)
        end
    end)
    
    timer.Simple(0.1, function()
        if IsValid(self) then self:Remove() end
    end)
end