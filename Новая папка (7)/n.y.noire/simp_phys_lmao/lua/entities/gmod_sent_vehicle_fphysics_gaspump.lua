--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/entities/gmod_sent_vehicle_fphysics_gaspump.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Заправка"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "User")
	self:NetworkVar("Bool", 0, "Active")

	if SERVER then
		self:NetworkVarNotify("Active", self.OnActiveChanged)
	end
end

if CLIENT then
	local cable = Material("cable/cable")

	function ENT:Draw()
		self:DrawModel()
		if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 50000 then return end
		local ply = self:GetUser()
		local startPos = self:LocalToWorld(Vector(-3.52, -28.9, 97.18))
		local p2 = self:LocalToWorld(Vector(-2.52, -30.9, -23.18))
		local p3 = self:LocalToWorld(Vector(3.52, -17.9, -10.18))
		local endPos = self:LocalToWorld(Vector(5.3, -17.6, 27.7))

		if IsValid(ply) then
			local id = ply:LookupAttachment("anim_attachment_rh")
			local attachment = ply:GetAttachment(id)
			if not attachment then return end
			endPos = (attachment.Pos + attachment.Ang:Forward() * -3 + attachment.Ang:Right() * 2 + attachment.Ang:Up() * -3.5)
			p3 = endPos + attachment.Ang:Right() * 5 - attachment.Ang:Up() * 20
		end

		for i = 1, 12 do
			local active = IsValid(ply)
			local de = active and 1 or 2

			if (not active and i > 1) or active then
				local sp = DarkRP.BernsteinBezier(startPos, p2, p3, endPos, (i - de) / 12)
				local ep = DarkRP.BernsteinBezier(startPos, p2, p3, endPos, i / 12)
				render.SetMaterial(cable)
				render.DrawBeam(sp, ep, 1.2, 1, 1, Color(100, 100, 100, 255))
			end
		end
	end

	return
end

function ENT:Use(ply)
	if not self:GetActive() then
		if not ply.gas_InUse then
			ply.usedFuel = 0
			self:SetActive(true)
			self:SetUser(ply)
			local wep = ply:Give("weapon_simfillerpistol")
			wep.MainEnt = self
			ply:SelectWeapon("weapon_simfillerpistol")
			ply.gas_InUse = true
			local weapon = ply:GetActiveWeapon()

			if IsValid(weapon) and weapon:GetClass() == "weapon_simfillerpistol" then
				weapon:SetFuelType(FUELTYPE_PETROL)
			end
		end
	else
		if ply == self:GetUser() then
			ply:StripWeapon("weapon_simfillerpistol")
			self:SetActive(false)
			self:SetUser(NULL)
			ply.gas_InUse = false
		end
	end
end

function ENT:OnActiveChanged(name, old, new)
	if new == old then return end

	if new then
		if self.sound then
			self.sound:Stop()
			self.sound = nil
		end

		self.sound = CreateSound(self, "vehicles/crane/crane_idle_loop3.wav")
		self.sound:PlayEx(0, 0)
		self.sound:ChangeVolume(0.4, 2)
		self.sound:ChangePitch(90, 3)
		self.PumpEnt:SetNoDraw(true)
	else
		self.PumpEnt:SetNoDraw(false)

		if self.sound then
			self.sound:ChangeVolume(0, 2)
			self.sound:ChangePitch(0, 3)
		end
	end
end

function ENT:Initialize()
	self:SetModel("models/unioncity2/props_unioncity/gaspump_712.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetMaterial("gbskins/gaspump_712")
	local PObj = self:GetPhysicsObject()
	if not IsValid(PObj) then return end
	PObj:EnableMotion(false)
	self.PumpEnt = ents.Create("prop_dynamic")
	self.PumpEnt:SetModel("models/props_equipment/gas_pump_p13.mdl")
	self.PumpEnt:SetPos(self:LocalToWorld(Vector(-0.3, -17.6, 36.7)))
	self.PumpEnt:SetAngles(self:LocalToWorldAngles(Angle(0, 180, 0)))
	self.PumpEnt:SetMoveType(MOVETYPE_NONE)
	self.PumpEnt:Spawn()
	self.PumpEnt:Activate()
	self.PumpEnt:SetNotSolid(true)
	self.PumpEnt:DrawShadow(false)
	self.PumpEnt:SetParent(self)
end

function ENT:Think()
	if CLIENT then return end
	self:NextThink(CurTime() + 0.5)
	local ply = self:GetUser()

	if IsValid(ply) then
		local Dist = (ply:GetPos() - self:GetPos()):Length()

		if ply.pumping and self.sound then
			if ply.pumping > CurTime() then
				self.sound:ChangePitch(255, 1)
			else
				ply.pumping = nil
				self.sound:ChangePitch(90, 2)
			end
		end

		if ply:Alive() then
			if ply:InVehicle() then
				if ply:HasWeapon("weapon_simfillerpistol") then
					ply:StripWeapon("weapon_simfillerpistol")
				end

				ply.gas_InUse = false
				self:Disable()
			else
				if ply:HasWeapon("weapon_simfillerpistol") then
					if ply:GetActiveWeapon():GetClass() ~= "weapon_simfillerpistol" or Dist >= 100 then
						ply:StripWeapon("weapon_simfillerpistol")
						ply.gas_InUse = false
						self:Disable()
					end
				else
					ply.gas_InUse = false
					self:Disable()
				end
			end
		else
			ply.gas_InUse = false
			self:Disable()
		end
	end

	if not IsValid(ply) and self:GetActive() then
		self:SetActive(false)
		self:SetUser(NULL)
	end

	return true
end

function ENT:Disable()
	self:SetUser(NULL)
	self:SetActive(false)
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end

	local ply = self:GetUser()

	if IsValid(ply) then
		ply.gas_InUse = false

		if ply:Alive() and ply:HasWeapon("weapon_simfillerpistol") then
			ply:StripWeapon("weapon_simfillerpistol")
		end
	end
end