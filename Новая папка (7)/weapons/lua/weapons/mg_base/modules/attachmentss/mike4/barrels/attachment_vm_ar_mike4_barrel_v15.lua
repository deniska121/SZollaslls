-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\barrels\\attachment_vm_ar_mike4_barrel_v15.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Оперативник"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mike4/attachment_vm_ar_mike4_barrel_v15.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike4/icon_attachment_ar_mike4_barrel_v15.vmt")

ATTACHMENT.CosmeticChange = true

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end