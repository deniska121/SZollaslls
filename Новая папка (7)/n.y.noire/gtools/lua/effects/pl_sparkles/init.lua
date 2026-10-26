--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/pl_sparkles/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local cl = Color(255, 0, 0, 25)
local Blood = {
	"decals/blood2",
	"decals/blood7",
	"decals/blood3",
	"decals/blood8"
}

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Position = data:GetOrigin()
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	local emitter = ParticleEmitter(data:GetOrigin())

	for i = 1, 5 do
		local particle = emitter:Add(Blood[math.random(1, 4)], self.Position - self.Forward * 4, cl)
		particle:SetVelocity(10 * VectorRand() + 10 * VectorRand() + 10 * VectorRand())
		particle:SetGravity(Vector(0, 0, -500))
		particle:SetAirResistance(0)
		particle:SetDieTime(1)
		particle:SetStartSize(5)
		particle:SetEndSize(0)
		particle:SetStartLength(0)
		particle:SetEndLength(105)
		particle:SetRoll(math.Rand(180, 480))
		particle:SetRollDelta(math.Rand(-1, 1))
		particle:SetCollide(true)

		if i == 1 and math.random(3) == 3 then
			particle:SetCollideCallback(function()
				local tr = {}
				tr.start = particle:GetPos()
				tr.endpos = particle:GetPos() + particle:GetAngles():Forward() * 50
				tr.filter = particle
				tr = util.TraceLine(tr)
				util.Decal("Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			end)
		end
	end

	emitter:Finish()
end

--end
function EFFECT:Think()
	return false
end

function EFFECT:Render()
end