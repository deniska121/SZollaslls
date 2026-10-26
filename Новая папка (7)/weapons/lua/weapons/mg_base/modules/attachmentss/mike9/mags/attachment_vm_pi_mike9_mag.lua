-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike9\\mags\\attachment_vm_pi_mike9_mag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike9_mag.mdl")


local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end