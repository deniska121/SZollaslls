-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf21\\receivers\\att_vm_pi_golf21_receiver_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Осквернитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/golf21_receiver_v2.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/golf21/icon_attachment_pi_golf21_receiver_v3.vmt")
ATTACHMENT.Bodygroups = {
    ["receiver"] = 1
}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end

ATTACHMENT.CosmeticChange = true