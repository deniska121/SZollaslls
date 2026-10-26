--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/pipe_leak.lua
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
ENT.PrintName = "Pipe Leak"
ENT.Author = "Mac"
ENT.Spawnable = true
ENT.AdminSpawnable = true


if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_junk/PopCan01a.mdl")
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:DrawShadow(false)
		local phys = self:GetPhysicsObject()
		phys:EnableMotion(false)

		self:SetNoDraw( true )
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	end
	return
end

function ENT:Initialize()
	self.emitter = ParticleEmitter(self:GetPos())
	self.nextEmit = 0
	self.sound = CreateSound(self, "ambient/water/water_flow_loop1.wav")
	self.sound:SetSoundLevel(60)
	--self.sound:Play()
end

function ENT:OnRemove()
	self.sound:Stop()
end

function ENT:Think()
	if not self.sound:IsPlaying() then
		self.sound:Play()
	end

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) <= 4000000 and CurTime() > self.nextEmit then
		local v = Vector(0, 70, 550)
		v:Rotate(self:GetAngles())
		local water = self.emitter:Add("effects/splash" .. 2 ^ math.random(0, 2), self:LocalToWorld(Vector(0, 0, 0)))
		water:SetVelocity(v)
		water:SetDieTime(2)
		water:SetStartAlpha(200)
		water:SetEndAlpha(50)
		water:SetAngles(AngleRand())
		water:SetStartSize(3)
		water:SetEndSize(50)
		water:SetGravity(Vector(0, 0, -600))
		water:SetColor(255, 255, 255)
		water:SetAirResistance(0)
		water:SetCollide(true)
		self.nextEmit = CurTime() + 0.02
	end

	self:DrawModel()
end