--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/enter_portal.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_edit"
ENT.PrintName = "Portal"
ENT.Author = "Mac"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "SelfID", { KeyName = "SelfID", Edit = { type = "String", order = 1 } })
	self:NetworkVar("String", 1, "PortalID", { KeyName = "PortalID", Edit = { type = "String", order = 2 } })
	self:NetworkVar("Vector", 0, "ExitPoint", { KeyName = "ExitPoint", Edit = { type = "Vector", order = 3 } })
	self:NetworkVar("Bool", 0, "CheckSpase", { KeyName = "type1", Edit = { type = "Bool", order = 4 } })
	self:NetworkVar("Bool", 1, "Pointer", { KeyName = "type2", Edit = { type = "Bool", order = 5 } })
end

if CLIENT then
	function ENT:InitRenderModel()
		self.RenderModel = ClientsideModel("models/editor/spot_cone.mdl")
		self.RenderModel:SetPos(self:GetPos())
		self.RenderModel:SetParent(self)
		self.RenderModel:SetMaterial("models/cs_italy/light_orange")
		self.RenderModel:SetColor(Color(255,255,0, 100))
		self.RenderModel:SetRenderMode( RENDERMODE_TRANSCOLOR )
		self:CallOnRemove("RenderModel", function()
			SafeRemoveEntity(self.RenderModel)
		end)
	end

	function ENT:Draw()
		if not DarkRP.InRange(LocalPlayer(), self, 600) then
			if self.RenderModel and IsValid(self.RenderModel) then
				SafeRemoveEntity(self.RenderModel)
				self.RenderModel = nil
			end
			return
		end

		if self:GetPointer() then
			local Pos = self:LocalToWorld(self:OBBCenter())

			Pos.z = Pos.z + (20 + math.sin(CurTime() * 2) * 5)

			if not IsValid(self.RenderModel) then
				self:InitRenderModel()
			end

			self.RenderModel:SetPos(Pos)
			self.RenderModel:SetAngles(Angle(-90,0,0))
			return
		end

		if self.RenderModel and IsValid(self.RenderModel) then
			SafeRemoveEntity(self.RenderModel)
			self.RenderModel = nil
		end

		self:DrawModel()
	end

	return
end

function ENT:Initialize()
	local model = self:GetModel()

	if not model or model == "models/error.mdl" then
		model = "models/props_c17/door01_left.mdl"
	end

	self:SetModel(model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DrawShadow(false)

	self:SetSelfID("")
	self:SetPortalID("")
	self:SetExitPoint(Vector(0, 0, 0))
	self:SetCheckSpase(false)
	self:SetPointer(false)
end

local ta = Angle(0,90,0)

local extras = {
	["tattoo"] = function(self, ply)
		for k,v in ipairs(ents.FindInSphere(GAMEMODE.Config.TattooSalon, 30)) do
			if IsValid(v) and v:IsPlayer() then
				self:EmitSound("doors/door_locked2.wav")
				return
			end
		end

		self:EmitSound("doors/wood_move1.wav")

		DarkRP.UIEffect(ply, "blackScreen", {true, true})

		DarkRP.ForceAnimation(ply, "open_door_towards_right", 1.6)
		timer.Simple(2, function()
			if not IsValid(ply) then return end
			ply:SetEyeAngles(ta)
			ply:SetRenderAngles(ta)
			ply:SetPos(GAMEMODE.Config.TattooSalon)
			DarkRP.UIEffect(ply, "tattoomenu", {false, true})
		end)

		timer.Simple(2.5, function()
			if not IsValid(ply) then return end
			ply:SetDarkRPVar("sa", 13)
			ply:SetNWBool("SitAnyG_", true)
			ply.LastSit = CurTime() + 1

			DarkRP.UIEffect(ply, "blackScreen", {false, true})

			ply:SetEyeAngles(ta)
			ply:SetRenderAngles(ta)
		end)
	end,
}

function ENT:Use(ply)
	if self.UseDelay and self.UseDelay > CurTime() then return end
	self.UseDelay = CurTime() + 2

	if extras[self:GetSelfID()] then
		extras[self:GetSelfID()](self, ply)
		return
	end

	if self.portalid == "" then
		self:EmitSound("doors/door_locked2.wav")
	end

	if not self.portal or not IsValid(self.portal) or self.portal:GetClass() ~= "enter_portal" or (self.portalid ~= self:GetPortalID()) then
		self.portalid = self:GetPortalID()

		if self.portalid == "" then return end

		for k,v in pairs(ents.FindByClass("enter_portal")) do
			if v:GetSelfID() == self.portalid then
				self.portal = v
				break
			end
		end
	end

	if not self.portal:GetExitPoint() then return end

	if not self.portal:GetCheckSpase() then
		for _, v in ipairs(ents.FindInSphere(self.portal:GetExitPoint(), 20)) do
			if IsValid(v) and v:IsPlayer() then
				self:EmitSound("doors/default_locked.wav")
				self.portal:EmitSound("doors/default_locked.wav")
				return
			end
		end
	end

	self:EmitSound("doors/wood_move1.wav")
	self.portal:EmitSound("doors/wood_move1.wav")
	DarkRP.UIEffect(ply, "blackScreen", {true, true})
	ply:Freeze(true)
	DarkRP.ForceAnimation(ply, "open_door_towards_right", 3)
	timer.Simple(1.5, function()
		if not IsValid(ply) then return end

		local POS = self.portal:GetExitPoint()
		if self.portal:GetCheckSpase() then
			POS = GAMEMODE:FindEmptyPos(POS, {ply}, 600, 30, Vector(16, 16, 64))
		end
		ply:SetPos(POS)
		ply:SetEyeAngles(Angle(0,self.portal:GetAngles().y,0))
		DarkRP.UIEffect(ply, "blackScreen", {false, true})
		ply:Freeze(false)

		local wp = ply:GetActiveWeapon()

		if IsValid(wp) and wp:GetClass() == "keys" and IsValid(wp.EntHolding) then
			wp.EntHolding:SetPos(POS + Vector(0,0,25))
		end
	end)

	timer.Simple(1.6, function()
		if not IsValid(self) or not IsValid(self.portal) then return end
		self:EmitSound("doors/wood_stop1.wav")
		self.portal:EmitSound("doors/wood_stop1.wav")
	end)
end

concommand.Add("portal_set", function(ply, cmd, args)
	if ply:EntIndex() ~= 0 and not ply:HasAdminAccess("rp_commands") then
		return
	end

	local target = ply:GetEyeTrace().Entity
	if IsValid(target) and target:GetClass() == "enter_portal" then
		target:SetExitPoint(ply:GetPos())
	end
end)