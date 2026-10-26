--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/services/lua/effects/vfire_smoke_plume.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function EFFECT:Init(data)
	-- Get our data
	local pos = data:GetOrigin()
	local dir = data:GetNormal()
	local mag = data:GetMagnitude()
	local ent = data:GetEntity()
	-- Should we LOD ourselves?
	local LOD

	if IsValid(ent) and ent.LOD ~= nil then
		LOD = ent.LOD
	else
		LOD = vFireGetLOD(pos)
	end

	local smokeCount = mag * 2
	local pe = ParticleEmitter(pos)

	for i = 1, smokeCount do
		local p = pe:Add(table.Random(list.Get("vFireSmoke")), pos)
		local pull = 30 * i / smokeCount
		p:SetLifeTime(0)
		p:SetDieTime(3)
		p:SetStartSize(0)
		p:SetEndSize(10 * pull)
		p:SetStartAlpha(math.random(100, 255))
		p:SetEndAlpha(0)
		local d = math.random(0, 200)
		p:SetColor(255 - d, 255 - d, math.random(235, 250) - d)
		p:SetLighting(true)
		local upAdd = math.Rand(0.5, 1.5)
		local newDir = Vector(dir.x, dir.y, dir.z + upAdd)
		p:SetVelocity(newDir * 50)
		p:SetGravity(newDir * 1 * pull)
		p:SetAirResistance(math.random(10, 15))
		p:SetCollide(true)
		p:SetRollDelta(math.Rand(-0.5, 0.5))
	end

	pe:Finish()
end

function EFFECT:Render()
end

function EFFECT:Think()
	return false
end