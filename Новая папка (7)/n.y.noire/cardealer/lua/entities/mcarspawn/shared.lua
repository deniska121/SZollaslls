--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/cardealer/lua/entities/mcarspawn/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Платформы для спавна"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Debug = false

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/hunter/plates/plate3x5.mdl")
		self:SetMaterial("phoenix_storms/road")
		self:SetModelScale(1, 0)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:EnableMotion(false)
		end
	end

	function ENT:OnRemove()
		return true
	end

	function ENT:SpawnVehicle(vname, exp)
		local VehicleList = list.Get("simfphys_vehicles")
		local vehicle = VehicleList[vname]
		if (not vehicle) then return end
		exp = exp or Angle(0, 90, 0)
		local Ent = simfphys.SpawnVehicleSimple(vname, self:GetPos() + Vector(0, -200, 50), self:GetAngles() + exp)
		if not IsValid(Ent) then return end
		Ent.VehicleName = vname
		Ent.VehicleTable = vehicle
		Ent.ClassOverride = vehicle.Class

		return Ent
	end
end

function ENT:Occupied(by, exclude, spawn)
	local _min, _max = self:GetModelBounds()
	local min, max = self:LocalToWorld(_min), self:LocalToWorld(_max)
	local foundEntity = nil

	for k, v in pairs(ents.FindInBox(min, max + Vector(0, spawn and -200 or 0, 50))) do
		if not IsValid(v) or v == self then continue end

		if by then
			if type(by) == "table" then
				local found = false

				for i, j in pairs(by) do
					if v:GetClass() == j then
						found = true
					end
				end

				if not found then continue end
			else
				if v:GetClass() ~= by then continue end
			end
		end

		if exclude then
			if type(exclude) == "table" then
				local found = false

				for i, j in pairs(exclude) do
					if v:GetClass() == j then
						found = true
					end
				end

				if found then continue end
			else
				if v:GetClass() == exclude then continue end
			end
		end

		foundEntity = v
	end

	return foundEntity
end

function ENT:Draw()
	self:DrawModel()
end