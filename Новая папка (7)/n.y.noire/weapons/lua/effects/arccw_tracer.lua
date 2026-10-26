--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/effects/arccw_tracer.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

EFFECT.StartPos = Vector(0, 0, 0)
EFFECT.EndPos = Vector(0, 0, 0)
EFFECT.StartTime = 0
EFFECT.LifeTime = 0.2
EFFECT.LifeTime2 = 0.2
EFFECT.DieTime = 0
EFFECT.Color = Color(255, 255, 255)
EFFECT.Speed = 5000
local bulcl = Color(255, 117, 37)
local tracer = Material("effects/yellowflare")
--local tracer = Material("effects/smoke_trail")
local smoke = Material("trails/smoke")

function EFFECT:Init(data)
	local hit = data:GetOrigin()
	local wep = data:GetEntity()
	if not IsValid(wep) then return end
	local speed = data:GetScale()
	local start = (wep.GetTracerOrigin and wep:GetTracerOrigin()) or data:GetStart()

	-- if GetConVar("arccw_fasttracers"):GetBool() then
	-- local fx = EffectData()
	-- fx:SetOrigin(hit)
	-- fx:SetEntity(wep)
	-- fx:SetStart(start)
	-- fx:SetScale(4000)
	-- util.Effect("tracer", fx)
	-- self:Remove()
	-- return
	-- end
	if speed > 0 then
		self.Speed = speed
	end

	self.LifeTime = (hit - start):Length() / self.Speed
	self.StartTime = UnPredictedCurTime()
	self.DieTime = UnPredictedCurTime() + math.max(self.LifeTime, self.LifeTime2)
	self.StartPos = start
	self.EndPos = hit
	self.Color = bulcl
end

function EFFECT:Think()
	return self.DieTime > UnPredictedCurTime()
end

function EFFECT:Render()
	local d = (UnPredictedCurTime() - self.StartTime) / self.LifeTime

	local startpos = self.StartPos + (d * 0.1 * (self.EndPos - self.StartPos))
	local endpos = self.StartPos + (d * (self.EndPos - self.StartPos))
	local size = 1

	render.SetMaterial(tracer)
	render.DrawBeam(endpos, startpos, size, 0, 1, self.Color)
end