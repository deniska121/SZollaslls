-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\papa320\\barrels\\attachment_vm_pi_papa320_slide_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "attachment_vm_pi_papa320_slide"
ATTACHMENT.Name = "Изысканный"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_papa320_slide_v2.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/icon_attachment_pi_papa320_slide.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end

ATTACHMENT.CosmeticChange = true