--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/entities/mc_jammer.lua
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
ENT.PrintName = "Jammer"
ENT.Author = "Mactavish"
ENT.Category = "McPhone"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 1, "Active")
	self:NetworkVar("Int", 0, "DamageLimit")
end

if CLIENT then return end

function ENT:Initialize()

	self:SetModel("models/mc_phone/jammer.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self.Sound = CreateSound(self, "mcphone/jammer_loop.wav")
	self.Sound:SetSoundLevel(40)
	self.Sound:PlayEx( 0.5, 100 )

	self:SetDamageLimit(McPhone.Config.JammerHealth)

	self.LiveTime = CurTime() + McPhone.Config.JammerLiveTime
	
	self:SetActive(true)
	
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	table.insert(McPhone.EP1.Jammers, self)
	
end

function ENT:BreakJammer()

	self:SetActive(false)
	if self.Sound then
		self.Sound:Stop()
		self.Sound = nil
	end
	self:EmitSound( "ambient/levels/citadel/weapon_disintegrate1.wav", 55, 100, 2)

	local ef = EffectData()
	ef:SetOrigin( self:GetPos() )
	util.Effect( "cball_bounce", ef )

	timer.Simple(20, function()
		if IsValid(self) then self:Remove() end
	end)
end

function ENT:OnRemove()
	table.RemoveByValue(McPhone.EP1.Jammers, self)
	if self.Sound then
		self.Sound:Stop()
		self.Sound = nil
	end
end

function ENT:OnTakeDamage(data)
	if McPhone.Config.DestructibleJammer and self:GetActive() then
		local damage = data:GetDamage()
		self:SetDamageLimit( self:GetDamageLimit() - damage )
		if self:GetDamageLimit() < 1 then self:BreakJammer() return end
	end
end