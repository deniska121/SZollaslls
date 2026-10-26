-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\base\\att_base.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
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