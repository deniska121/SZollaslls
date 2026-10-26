--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/sw_rain/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- SW.RainRadius				= 500 	-- Radius of rain effect.
-- SW.RainCount				= 20 	-- Amount of particles in rain effect. Make this smaller to increase performance.
-- SW.RainDieTime				= 3 	-- Time in seconds until rain vanishes.
-- SW.StormRadius				= 500 	-- Radius of storm effect.
-- SW.StormCount				= 120 	-- Amount of particles in storm effect. Make this smaller to increase performance.
-- SW.StormDieTime				= 1 	-- Time in seconds until rain vanishes.
-- SW.RainHeightMax			= 300 	-- Maximum height to make rain.
-- SW.SnowRadius				= 1200 	-- Radius of snow effect.
-- SW.SnowCount				= 20 	-- Amount of particles in snow effect. Make this smaller to increase performance.
-- SW.SnowDieTime				= 5 	-- Time in seconds until snow vanishes.
-- SW.SnowHeightMax			= 200 	-- Maximum height to make snow.
-- SW.BlizzardRadius			= 1000 	-- Radius of blizzard effect.
-- SW.BlizzardCount			= 30 	-- Amount of particles in blizzard effect. Make this smaller to increase performance.
-- SW.BlizzardDieTime			= 2 	-- Time in seconds until blizzard vanishes.
-- SW.BlizzardHeightMax		= 100 	-- Maximum height to make blizzard snow.
-- SW.LeaveSnowOnGround		= true	-- Leave snow on the ground (true/false).
-- SW.RainOnScreen				= true 	-- Show rain on screen (true/false).
-- SW.RainOnScreenMinSize		= 20 	-- Minimum size of the raindrops on screen.
-- SW.RainOnScreenMaxSize		= 40 	-- Maximum size of the raindrops on screen.
-- SW.RainSplashes 			= true 	-- Make rain splash particle effect (true/false).
-- SW.RainSmoke 				= true 	-- Make rain steam particle effect (true/false).
-- SW.ThunderMinDelay 			= 10	-- Minimum delay in seconds to cause lightning/thunder while stormy.
-- SW.ThunderMaxDelay 			= 30 	-- Maximum delay in seconds to cause lightning/thunder while stormy.
-- SW.LightningEnabled			= true 	-- Enable lightning flashes (true/false).
-- SW.ColormodEnabled			= true 	-- Enable colormod when it's cloudy (true/false).
-- SW.ColormodIndoors			= true	-- Enable colormod when there's a roof over your head (true/false).
-- SW.VolumeMultiplier			= 1 	-- Volume (0-1) sounds should play at. Change it if the rain's too loud!
-- SW.FogDayDensity			= 1		-- Fog max density (0-1) during the day.
-- SW.FogNightDensity			= 0.4	-- Fog max density (0-1) during the night.
-- SW.FogIndoors				= true	-- Enable fog when you have a roof over your head (true/false).
-- SW.FogSpeed					= 0.01	-- Speed at which fog appears and disappears (default 0.01). Decrease to make fog changes slower.

function EFFECT:Init(data)
	local s = data:GetScale() or 0.1

	if (SW.Emitter3D) then
		if (SW.Emitter2D:GetNumActiveParticles() + SW.Emitter3D:GetNumActiveParticles() > SW.MaxParticles) then return end
		local n = SW.RainCount

		if (s == 1) then
			n = SW.StormCount
		end

		for i = 1, n do
			local r = math.random(0, SW.RainRadius)

			if (s == 1) then
				r = math.random(0, SW.StormRadius)
			end

			local t = math.Rand(-math.pi, math.pi)
			local pos = data:GetOrigin() + Vector(math.cos(t) * r, math.sin(t) * r, math.min(SW.RainHeightMax, SW.HeightMin))

			if (DarkRP.IsOutside(pos)) then
				local p = SW.Emitter3D:Add("simpleweather/water_drop", pos)

				if (s == 1) then
					p:SetVelocity(Vector(200 + math.random(-50, 50), 200 + math.random(-50, 50), -1000))
				else
					p:SetVelocity(Vector(0, 0, -700))
				end

				p:SetAngles(p:GetVelocity():Angle() + Angle(90, 0, 90))

				if (s == 1) then
					p:SetDieTime(SW.StormDieTime)
				else
					p:SetDieTime(SW.RainDieTime)
				end

				p:SetStartAlpha(255)
				p:SetStartSize(4)
				p:SetEndSize(4)
				p:SetColor(255, 255, 255)
				p:SetCollide(true)

				p:SetCollideCallback(function(p, pos, norm)
					local n
					local cvar = 1

					if (cvar == 1) then
						n = 60
					elseif (cvar == 2) then
						n = 30
					elseif (cvar == 3) then
						n = 10
					elseif (cvar == 4) then
						n = 1
					end

					if (SW.RainSplashes and render.GetDXLevel() > 90 and math.random(1, n) == 1) then
						local ed = EffectData()
						ed:SetOrigin(pos)
						util.Effect("sw_rainsplash", ed)
					end

					p:SetDieTime(0)
				end)

				p:SetThinkFunction(function(p, pos)
					if (bit.band(util.PointContents(p:GetPos()), CONTENTS_WATER) == CONTENTS_WATER) then
						p:SetDieTime(0)
					end

					p:SetNextThink(CurTime() + 0.05)
				end)

				p:SetNextThink(CurTime() + 0.05)
			end
		end
	end

	-- if (not SW.RainSmoke) then return end

	if (SW.Emitter2D) then
		local n = 6

		if (s == 1) then
			n = 2
		end

		if (math.random(1, n) == 1) then
			local r = math.random(0, SW.RainRadius)

			if (s == 1) then
				r = math.random(0, SW.StormRadius)
			end

			local t = math.Rand(-math.pi, math.pi)
			local pos = data:GetOrigin() + Vector(math.cos(t) * r, math.sin(t) * r, math.min(SW.RainHeightMax, SW.HeightMin))

			if (DarkRP.IsOutside(pos) and bit.band(util.PointContents(pos), CONTENTS_WATER) ~= CONTENTS_WATER) then
				local p = SW.Emitter2D:Add("simpleweather/rainsmoke", pos)

				if (s == 1) then
					p:SetVelocity(Vector(200 + math.random(-50, 50), 200 + math.random(-50, 50), -1500))
				else
					p:SetVelocity(Vector(0, 0, -700))
				end

				if (s == 1) then
					p:SetDieTime(SW.StormDieTime)
				else
					p:SetDieTime(SW.RainDieTime)
				end

				p:SetStartAlpha(6)
				p:SetEndAlpha(0)
				p:SetStartSize(166)
				p:SetEndSize(166)
				p:SetColor(150, 150, 200)
				p:SetCollide(true)

				p:SetCollideCallback(function(p, pos, norm)
					p:SetDieTime(0)
				end)

				p:SetThinkFunction(function(p, pos)
					if (bit.band(util.PointContents(p:GetPos()), CONTENTS_WATER) == CONTENTS_WATER) then
						p:SetDieTime(0)
					end

					p:SetNextThink(CurTime() + 0.05)
				end)

				p:SetNextThink(CurTime() + 0.05)
			end
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end