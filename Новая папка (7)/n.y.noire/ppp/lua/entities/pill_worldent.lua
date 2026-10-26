--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/pill_worldent.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Pill?"

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PillForm")
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/pills.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()

		if (phys:IsValid()) then
			phys:Wake()
		end

		self:SetUseType(SIMPLE_USE)

		if self.DarkRPItem then
			self:SetPillForm(self.DarkRPItem.pill)
		end
	end

	function ENT:Use(ply)
		ply:EmitSound("weapons/bugbait/bugbait_squeeze1.wav")
		pk_pills.apply(ply, self:GetPillForm())
		self:Remove()
	end

	function ENT:Think()
		if self:WaterLevel() > 0 then
			self:EmitSound("weapons/underwater_explode3.wav")
			self:Remove()
		end
	end
end

function ENT:Draw()
	self:DrawModel()
end