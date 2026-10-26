--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/pill_attachment_wep.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
    self:NetworkVar("Vector", 0, "WepOffset")
    self:NetworkVar("Angle", 0, "WepAng")
end

function ENT:Initialize()
    if SERVER then
        if self.attachment then
            self:Fire("setparentattachment", "anim_attachment_RH", 0)
        else
            self:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL))
        end

        self:SetRenderMode(RENDERMODE_TRANSALPHA)
    end
end

function ENT:Think()
    self:NextThink(CurTime())

    return true
end

function ENT:Draw()
    local offset = self:GetWepOffset()
    local ang = self:GetWepAng()

    if offset ~= Vector(0, 0, 0) then
        self:SetRenderOrigin(self:LocalToWorld(offset))
    end

    if ang ~= Angle(0, 0, 0) then
        self:SetRenderAngles(self:LocalToWorldAngles(ang))
    end

    self:DrawModel()
end
