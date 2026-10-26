-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\papa320\\receivers\\attachment_vm_pi_papa320_receiver_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Изысканный"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_papa320_receiver_v2.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/icon_attachment_pi_papa320_receiver_v2.vmt")
ATTACHMENT.Bodygroups = {
    ["receiver"] = 1
}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end

ATTACHMENT.CosmeticChange = true