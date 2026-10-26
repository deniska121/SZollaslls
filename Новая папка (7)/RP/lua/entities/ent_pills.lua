AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "VkysniePills"
ENT.Category = "HealingItems"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/props_lab/jar01b.mdl")
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
        Drugs[ply] = CurTime() + 50
        ply:SetNWFloat("DrugTime", CurTime())
        
        ply:ChatPrint("Мм таблетачкиии.")
        ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
        self:EmitSound("bandage/pills.wav")
        
        if SERVER then
            ply:SetArmor(math.min(ply:Armor() + 20, ply:GetMaxArmor()))
            ply:SetHealth(math.min(ply:Health() + 15, ply:GetMaxHealth()))
        end
        
        ply:EmitSound("ambient/voices/cough" .. math.random(1, 4) .. ".wav", 75, 100)

        timer.Simple(0.1, function()
            if IsValid(self) then self:Remove() end
        end)
    end
end