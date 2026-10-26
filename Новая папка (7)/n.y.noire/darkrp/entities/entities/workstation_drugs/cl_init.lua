--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_drugs/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

function ENT:Initialize()
	self.emitter = ParticleEmitter(self:GetPos() + Vector(0,0,45))
end

function ENT:Explode()
	if self.emitter then
		pos = self:GetPos()

		for i = 1, 30 do
			local particle = self.emitter:Add("particle/particle_smokegrenade", pos + Vector(0,0,45))
			particle:SetVelocity(VectorRand() * 400)
			particle:SetDieTime(math.random(20,50))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetColor(100, 200, 255)
			particle:SetStartSize(math.Rand(50, 70))
			particle:SetEndSize(math.Rand(130, 220))
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-1, 1))
			particle:SetAirResistance(20)
			particle:SetCollide(true)
			particle:SetBounce(0.1)
			particle:SetGravity(VectorRand() * 100)
		end
	end
end

net.Receive("Drugs.Explode", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	ent:Explode()
end)