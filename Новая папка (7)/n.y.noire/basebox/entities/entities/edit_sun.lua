--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/entities/edit_sun.lua
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
ENT.PrintName = "C4"
ENT.Author = "Mac"
ENT.Spawnable = false
ENT.AdminSpawnable = false

if CLIENT then return end

function ENT:Initialize()
	self:SetModel("models/mark2580/gtav/barstuff/champ_bucket.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	--	self.Entity:SetModelScale( 0.5, 0 )
	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Hit = false
	self:SetDTFloat(0, math.Rand(0.5, 1.3))
	self:SetDTFloat(1, math.Rand(0.3, 1.2))
end

function ENT:SetupDataTables()
	self:DTVar("Float", 0, "RotationSeed1")
	self:DTVar("Float", 1, "RotationSeed2")
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true
	self:EmitSound("ambient/explosions/explode_2.wav")
	local detonate = ents.Create("env_explosion")
	detonate:SetPos(self:GetPos())
	detonate:SetKeyValue("iMagnitude", "2000")
	detonate:SetKeyValue("iRadiusOverride", "800")
	detonate:Spawn()
	detonate:Activate()
	detonate:Fire("Explode", "", 0)
	local shake = ents.Create("env_shake")
	shake:SetPos(self:GetPos())
	shake:SetKeyValue("amplitude", "2000")
	shake:SetKeyValue("radius", "1000")
	shake:SetKeyValue("duration", "2.5")
	shake:SetKeyValue("frequency", "255")
	shake:SetKeyValue("spawnflags", "4")
	shake:Spawn()
	shake:Activate()
	shake:Fire("StartShake", "", 0)

	self:Remove()
end

function ENT:OnTakeDamage(dmginfo)
	self:Explode()
end

function ENT:PhysicsCollide(data, physobj)
	if data.HitEntity and IsValid(data.HitEntity) and (data.HitEntity:IsWorld() or data.HitEntity:GetClass()) and (data.Speed > 300 and data.DeltaTime > 0.2) then
		self:Explode()
	end
end

function ENT:Touch(ent)
	if IsValid(ent) and not self.Stuck then
		if ent == self.C4Owner then return false end

		if ent:IsNPC() or ent:IsVehicle() then
			self:SetSolid(SOLID_NONE)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetParent(ent)
			self.Stuck = true
			self.Hit = true
		end
	end
end

function ENT:Use(activator, caller)
end

function ENT:Think()
end