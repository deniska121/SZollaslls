--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/base/att_magazine_dual.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--Class for VElements that have two magazines in their animations
ATTACHMENT.Base = "att_magazine"

ATTACHMENT.VElement2 = {
    Bone = "j_mag2",
    Position = Vector(),
    Angles = Angle(),
    Offsets = {}
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Init(weapon)
    BaseClass.Init(self, weapon)

    if (CLIENT) then
        self.m_Model2 = ClientsideModel(self.Model, weapon.RenderGroup)
        self.m_Model2:SetRenderMode(weapon.RenderMode)
        self.m_Model2:SetMoveType(MOVETYPE_NONE)
        self.m_Model2:SetOwner(weapon.m_ViewModel)
        self.m_Model2.bAttachmentRenderOverride = self.RenderOverride

        self.m_Model2:FollowBone(weapon.m_ViewModel, weapon:LookupBoneCached(weapon.m_ViewModel, self.VElement2.Bone))

        --hack to move element
        local oldve = table.Copy(self.VElement)
        local oldModel = self.m_Model

        self.VElement = table.Copy(self.VElement2)
        self.m_Model = self.m_Model2
        weapon:MoveVElement(weapon.m_ViewModel, self)

        self.VElement = oldve
        self.m_Model = oldModel
    end
end

function ATTACHMENT:OnRemove(weapon)
    BaseClass.OnRemove(self, weapon)

    if (CLIENT) then
        if (IsValid(self.m_Model2)) then
            self.m_Model2:Remove()
        end
    end
end

function ATTACHMENT:Render(weapon)
    BaseClass.Render(self, weapon)

    if (IsValid(self.m_Model2)) then
    --    self.m_Model2:DrawModel()
    end
end