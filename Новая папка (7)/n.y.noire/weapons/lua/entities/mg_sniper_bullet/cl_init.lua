--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/entities/mg_sniper_bullet/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local BaseClass = baseclass.Get(ENT.Base)
local flareMaterial = Material("sprites/orangecore1_gmod")

ENT.bTracerOn = false

function ENT:DrawTracer()
end

function ENT:DrawBullet()
    if (!self.bTracerOn) then
        ParticleEffectAttach("bullet_sniper_smoke", PATTACH_ABSORIGIN_FOLLOW, self, 0)
        self.bTracerOn = true
    end

    if (GetViewEntity() == self:GetOwner()) then
        local angle = (self:GetPos() - EyePos()):Angle()
        angle:RotateAroundAxis(EyeAngles():Right(), 90)
        
        local dist = math.min(self:GetPos():Distance(EyePos()), 2300)

        cam.Start3D2D(self:GetPos(), angle, dist * 0.0001)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(flareMaterial)
            surface.DrawTexturedRectRotated(0, 0, 32, 32, 0)
        cam.End3D2D()
    end
end