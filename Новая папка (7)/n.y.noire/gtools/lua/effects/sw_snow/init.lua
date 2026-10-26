--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/sw_snow/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

SW.SnowHeightMax = 700 -- Maximum height to make snow.
SW.SnowRadius = 1200 -- Radius of snow effect.
SW.SnowCount = 20 -- Amount of particles in snow effect. Make this smaller to increase performance.
SW.SnowDieTime = 15 -- Time in seconds until snow vanishes.
SW.MaxParticles = 4500 -- Maximum number of particles to create at any one time.

function EFFECT:Init(data)
	if (SW.Emitter2D) then
		if (SW.Emitter2D:GetNumActiveParticles() + SW.Emitter3D:GetNumActiveParticles() > SW.MaxParticles) then return end

		for i = 1, SW.SnowCount do
			local r = math.random(0, SW.SnowRadius)
			local t = math.Rand(-math.pi, math.pi)
			local pos = data:GetOrigin() + Vector(math.cos(t) * r, math.sin(t) * r, SW.SnowHeightMax)

			if DarkRP.IsOutside(pos) then
				local p = SW.Emitter2D:Add("particle/particle_smokegrenade", pos)
				p:SetVelocity(Vector(20 + math.random(-5, 5), 20 + math.random(-5, 5), -80))
				p:SetRoll(math.random(-360, 360))
				p:SetDieTime(SW.SnowDieTime)
				p:SetStartAlpha(200)
				p:SetStartSize(1)
				p:SetEndSize(1)
				p:SetColor(255, 255, 255)
				p:SetCollide(true)
			end
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end