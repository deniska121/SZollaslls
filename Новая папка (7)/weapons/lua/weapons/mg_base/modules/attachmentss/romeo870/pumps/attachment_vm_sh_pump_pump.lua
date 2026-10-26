-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\pumps\\attachment_vm_sh_pump_pump.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "attachment_vm_sh_romeo870_pump"
ATTACHMENT.Name = "Раритет"
ATTACHMENT.Model = Model("models/viper/mw/attachments/romeo870/attachment_vm_sh_pump_pump.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_pump_v2.vmt")
ATTACHMENT.ExcludedCategories = {"Рукоятки", "ЛЦУ"}

ATTACHMENT.CosmeticChange = true
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
end

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    --weapon:SetGripPoseParameter("grip_vert_offset")
end 