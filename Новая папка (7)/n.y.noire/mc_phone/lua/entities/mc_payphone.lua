--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/entities/mc_payphone.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "PayPhone"
ENT.Author = "Mactavish"
ENT.Category = "McPhone"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AdminSpawnable = false
ENT.Editable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "StatIdle")
	self:NetworkVar("String", 0, "Number", { KeyName = "number",	Edit = { type = "title", order = 4 } })
end

if CLIENT then
	return
end

function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate025x05.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetMaterial("null")
	self:DrawShadow(false)
	self.IsPayPhone = true
	--local phys = self:GetPhysicsObject()
	--phys:Wake()
	self:SetStatIdle(true)
end

net.Receive("McPhone.PayPhone", function(ln, ply)
	local ent = net.ReadEntity()

	if ent and IsValid(ent) and ent.IsPayPhone then
		ent:SetStatIdle(true)
		ply.McPayPhone = nil
		ent:EmitSound("mc_phone/payphone_out.wav")
	end
end)

function ENT:Use(ply)
	if ((self.nextUse or 0) < CurTime()) then
		self.nextUse = CurTime() + 1
	else
		return
	end

	if not self:GetStatIdle() then return end
	if ply:getDarkRPVar("McPhone.Active") and ply:getDarkRPVar("McPhone.Active") > 0 then return end
	if not McPhone.CanUsePhone(ply, true) then return end
	if self:GetPos():DistToSqr(ply:GetPos()) > 5000 then return end
	self:SetStatIdle(false)
	ply.McPayPhone = self
	self:EmitSound("mc_phone/payphone_in.wav")
	McPhone.SetCallStatus(ply, 3)
	net.Start("McPhone.PayPhone")
	net.WriteEntity(self)
	net.Send(ply)
end