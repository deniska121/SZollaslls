--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/entities/mc_antenna.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--╔═╗╔═╦═══╦═══╦╗─────────────────╔╗──────────────────────────╔╗───╔╗───
--║║╚╝║║╔═╗║╔═╗║║────────────────╔╝╚╗─────────────────────────║║──╔╝║───
--║╔╗╔╗║║─╚╣╚═╝║╚═╦══╦═╗╔══╗╔══╦╗╠╗╔╬══╦═╗╔══╦╦══╦═╗─╔══╦══╦══╣║╔╗╚╗║───
--║║║║║║║─╔╣╔══╣╔╗║╔╗║╔╗╣║═╣║║═╬╬╬╣║║║═╣╔╗╣══╬╣╔╗║╔╗╗║╔╗║╔╗║╔═╣╚╝╝─║║───
--║║║║║║╚═╝║║──║║║║╚╝║║║║║═╣║║═╬╬╬╣╚╣║═╣║║╠══║║╚╝║║║║║╚╝║╔╗║╚═╣╔╗╗╔╝╚╗──
--╚╝╚╝╚╩═══╩╝──╚╝╚╩══╩╝╚╩══╝╚══╩╝╚╩═╩══╩╝╚╩══╩╩══╩╝╚╝║╔═╩╝╚╩══╩╝╚╝╚══╝──
--───────────────────────────────────────────────────║║─────────────────
--────────────────────────── By Mactavish ──────────────────────────────
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cell phone tower"
ENT.Author = "Mactavish"
ENT.Category = "McPhone"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Damageable")
	self:NetworkVar("Bool", 1, "Destroyed")
	self:NetworkVar("Int", 0, "DamageLimit")
end

if CLIENT then return end

function ENT:Initialize()
	self:SetModel("models/mc_phone/tower.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetDamageable(McPhone.Config.DestructibleTowers)
	self:SetDamageLimit(McPhone.Config.TowerHealth)
	self:SetDestroyed(false)
	self.DamageTime = 0
	self.DestroyTime = 0
	local phys = self:GetPhysicsObject()
	phys:Wake()
	table.insert(McPhone.EP1.Towers, self)
end

function ENT:OnRemove()
	table.RemoveByValue(McPhone.EP1.Towers, self)
end

function ENT:Repair()
	self:SetDestroyed(false)
	self:SetDamageLimit(McPhone.Config.TowerHealth)
	self.DestroyTime = 0
	self:SetSkin(0)
end

function ENT:Destroy()
	self:SetDestroyed(true)
	self:SetDamageLimit(0)
	self.DestroyTime = CurTime() + McPhone.Config.TowerRepairTime
	self:SetSkin(2)
	self:EmitSound("ambient/levels/labs/electric_explosion4.wav")
	local exp_pos = self:LocalToWorld(Vector(0, 0, 70))

	timer.Simple(0.1, function()
		if IsValid(self) then
			local ef = EffectData()
			ef:SetOrigin(exp_pos)
			util.Effect("cball_explode", ef)
		end
	end)
end

function ENT:OnTakeDamage(data)
	if not self:GetDamageable() or self:GetDestroyed() then return end
	local pos = self:WorldToLocal(data:GetDamagePosition())

	if pos and pos.z > 55 then
		local damage = data:GetDamage()
		if damage < 5 then return end
		self:SetDamageLimit(self:GetDamageLimit() - damage)

		if self:GetDamageLimit() <= McPhone.Config.TowerHealth / 2 then
			self:SetSkin(1)
		end

		if self:GetDamageLimit() <= 0 then
			self:Destroy()
		else
			self.DamageTime = CurTime() + McPhone.Config.TowerRepairTime
			self:EmitSound("ambient/energy/spark" .. math.random(1, 6) .. ".wav")
			local ef = EffectData()
			ef:SetOrigin(data:GetDamagePosition())
			util.Effect("cball_bounce", ef)
		end
	end
end