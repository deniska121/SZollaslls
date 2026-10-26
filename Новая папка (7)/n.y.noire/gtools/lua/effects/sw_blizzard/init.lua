--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/sw_blizzard/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function EFFECT:Init( data )

	local target = data:GetEntity()
	local Emitter = ParticleEmitter(data:GetOrigin(), true)

	for i = 1, 10 do
		if target and target:IsValid() and target:IsPlayer() and target:Alive() then
			local effect = Emitter:Add("particle/particle_smokegrenade", self:GetTracerShootPos( data:GetOrigin(), data:GetEntity():GetActiveWeapon(), data:GetAttachment() ))
			effect:SetVelocity(target:GetAimVector() * 400)
			effect:SetDieTime(math.Rand(0.5, 1.1))
			effect:SetStartAlpha(0)
			effect:SetEndAlpha(math.Rand(50,150))
			effect:SetStartSize(math.Rand(1, 5))
			effect:SetEndSize(math.Rand(35, 40))
			effect:SetRoll( math.Rand(0, 360) )
			effect:SetRollDelta(math.Rand(-1, 1))
			effect:SetGravity(VectorRand() * 100)
			effect:SetCollide(true)
			effect:SetBounce(0.1)
			effect:SetAirResistance(20)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end