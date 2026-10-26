--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/achievement_awarded/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--------------------
-- STBase
-- By Spacetech
--------------------
-- Balloon pop without sound
-- + Some tweaks
function EFFECT:Init(data)
	local vOffset = data:GetOrigin()
	local Emitter = ParticleEmitter(vOffset, true)

	for i = 1, 64 do
		local Pos = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1))
		local Particle = Emitter:Add("particles/balloon_bit", vOffset + (Pos * 4))

		if (Particle) then
			Particle:SetVelocity(Pos * 175)
			Particle:SetLifeTime(0)
			Particle:SetDieTime(3)
			Particle:SetStartAlpha(255)
			Particle:SetEndAlpha(255)
			local Size = math.Rand(0.2, 1)
			Particle:SetStartSize(Size)
			Particle:SetEndSize(0)
			Particle:SetRoll(math.Rand(0, 360))
			Particle:SetRollDelta(math.Rand(-2, 2))
			Particle:SetAirResistance(0)
			Particle:SetGravity(Vector(0, 0, -300))
			Particle:SetColor(math.random(255), math.random(255), math.random(255))
			Particle:SetCollide(true)
			Particle:SetAngleVelocity(Angle(math.Rand(-160, 160), math.Rand(-160, 160), math.Rand(-160, 160)))
			Particle:SetBounce(1)
			Particle:SetLighting(false)
		end

		local spark = Emitter:Add("effects/yellowflare", vOffset + (Pos * 4))

		if (spark) then
			spark:SetVelocity(Pos * 75)
			spark:SetLifeTime(0)
			spark:SetDieTime(3)
			spark:SetStartAlpha(255)
			spark:SetEndAlpha(255)
			local Size = math.Rand(10, 15)
			spark:SetStartSize(Size)
			spark:SetEndSize(0)
			spark:SetRoll(math.Rand(0, 360))
			spark:SetRollDelta(math.Rand(-2, 2))
			spark:SetAirResistance(0)
			spark:SetGravity(Vector(0, 0, -200))
			spark:SetColor(math.random(255), math.random(255), math.random(255))
			spark:SetCollide(true)
			spark:SetAngleVelocity(Angle(math.Rand(-160, 160), math.Rand(-160, 160), math.Rand(-160, 160)))
			spark:SetBounce(1)
			spark:SetLighting(false)
		end
	end

	Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end