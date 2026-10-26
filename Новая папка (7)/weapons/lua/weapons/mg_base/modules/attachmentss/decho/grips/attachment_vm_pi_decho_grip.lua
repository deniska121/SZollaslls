-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\decho\\grips\\attachment_vm_pi_decho_grip.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_grip"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_decho_grip.mdl")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

end