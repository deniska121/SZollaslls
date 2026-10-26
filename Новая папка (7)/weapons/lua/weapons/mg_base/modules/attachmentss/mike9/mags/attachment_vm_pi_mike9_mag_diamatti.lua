-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike9\\mags\\attachment_vm_pi_mike9_mag_diamatti.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "Забытая классика"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike9_mag_diamatti.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike9/icon_attachment_pi_mike9_xmagslrg.vmt")

ATTACHMENT.CosmeticChange = true

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end