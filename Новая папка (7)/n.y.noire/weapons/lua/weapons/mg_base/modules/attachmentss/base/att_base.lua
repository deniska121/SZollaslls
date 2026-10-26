--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/base/att_base.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Name = "Attachment"
ATTACHMENT.Category = "Attachments"
ATTACHMENT.Icon = Material("mg/defaultpreset")
ATTACHMENT.RenderOverride = false
ATTACHMENT.ShowOnWorldModel = true

function ATTACHMENT:Stats(weapon)
end
function ATTACHMENT:PostProcess(weapon)
end
function ATTACHMENT:Appearance(model, category)
end
function ATTACHMENT:Init(weapon)
end
function ATTACHMENT:PostInitModels(weapon)
end
function ATTACHMENT:OnRemove(weapon)
    if (CLIENT) then
        if (IsValid(self.m_Model)) then
            self.m_Model:Remove()
        end

        if (IsValid(self.m_TpModel)) then
            self.m_TpModel:Remove()
        end
    end
end

--new functionality to replace materials in model
--if returned path + mat doesn't exist on disk, default material will be applied
function ATTACHMENT:OverrideMaterial(path, mat)
    return path, mat
end

--new functionality to replace materials in weapon (viewmodel / worldmodel)
--if returned path + mat doesn't exist on disk, default material will be applied
function ATTACHMENT:OverrideWeaponMaterial(path, mat)
    return path, mat
end