--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/pill_jumper_headcrab.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Headcrab Jumper"
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
    if SERVER then
        --Physics
        self:SetModel("models/headcrabblack.mdl")
        self:PhysicsInit(SOLID_BBOX)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_BBOX)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self:ResetSequence(self:LookupSequence("drown"))
    end
end

function ENT:Think()
    if SERVER then
        local tr = util.QuickTrace(self:GetPos(), Vector(0, 0, -15), self)

        if tr.Hit then
            local crab = ents.Create("npc_headcrab_black")
            crab:SetPos(self:GetPos())
            crab:SetAngles(Angle(0, self:GetAngles().y, 0))
            crab:Spawn()
            self:Remove()
        end
    end

    self:NextThink(CurTime())

    return true
end
