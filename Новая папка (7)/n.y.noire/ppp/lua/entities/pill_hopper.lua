--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/pill_hopper.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Detector"
ENT.Spawnable = true
ENT.AdminSpawnable = true

if CLIENT then return end

function ENT:Initialize()
	self:SetModel("models/props_wasteland/interior_fence002e.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():Sleep()
end

local alarm = {
	["female_03"] = true,
	["female_05"] = true,
	["male_01"] = true,
	["male_03"] = true,
}

function ENT:Think()
	self:NextThink(CurTime() + 1)

	for _, ent in ipairs(ents.FindInSphere(self:GetPos(), 15)) do
		if self.last and self.last == ent then continue end
		if ent:IsPlayer() and ((not ent.LastChecked) or (ent.LastChecked <= CurTime())) then
			self.last = ent
			ent.LastChecked = CurTime() + 2
			if alarm[MCR.GetMDL(ent)] then
				self:Alarm()
			else
				self:Pass()
			end
		end
	end
end

function ENT:Alarm()
	self:EmitSound("noire/buzz2.mp3")
end

function ENT:Pass()
	self:EmitSound("unioncity2/elevator/elevator_ding.wav")
end