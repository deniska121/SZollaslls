--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/taser_dart.lua
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
ENT.PrintName = "Taser Dart"
ENT.Author = "Mac"

if (CLIENT) then return end

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetModelScale(0.05)
	self:SetMaterial("models/debug/debugwhite")
	self:SetColor(Color(100, 100, 100))
	self:SetNoDraw(true)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then
		phys:Wake()
	end

	timer.Simple(3, function()
		if (IsValid(self)) then
			self:Remove()
		end
	end)
end

function ENT:Touch(ent)
end