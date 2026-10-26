--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/effects/arccw_ricochet.lua
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
EFFECT.DieTime = 0
EFFECT.Color = Color(255, 255, 255)
-- EFFECT.Speed = 500

local head = Material("effects/whiteflare")
local tracer = Material("trails/smoke")

function EFFECT:Init(data)

    local start = data:GetStart()
    local hit = data:GetOrigin()

    -- self.LifeTime = (hit - start):Length() / self.Speed

    self.LifeTime = 0.25

    self.StartTime = UnPredictedCurTime()
    self.DieTime = UnPredictedCurTime() + self.LifeTime

    self.StartPos = start
    self.EndPos = hit
end

function EFFECT:Think()
    return self.DieTime > UnPredictedCurTime()
end

local function LerpColor(d, col1, col2)
    local r = Lerp(d, col1.r, col2.r)
    local g = Lerp(d, col1.g, col2.g)
    local b = Lerp(d, col1.b, col2.b)
    local a = Lerp(d, col1.a, col2.a)
    return Color(r, g, b, a)
end

function EFFECT:Render()
    local d = (UnPredictedCurTime() - self.StartTime) / self.LifeTime
    -- local endpos = self.StartPos + (d * (self.EndPos - self.StartPos))
    local endpos = self.EndPos
    local size = 1

    local col = LerpColor(d, self.Color, Color(0, 0, 0, 0))

    render.SetMaterial(head)
    render.DrawSprite(endpos, size, size, col)

    render.SetMaterial(tracer)
    render.DrawBeam(endpos, self.StartPos, size * 0.75, 0, 1, col)
end