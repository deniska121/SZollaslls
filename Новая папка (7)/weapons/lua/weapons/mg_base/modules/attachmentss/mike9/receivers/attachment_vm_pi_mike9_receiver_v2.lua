-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike9\\receivers\\attachment_vm_pi_mike9_receiver_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Ресивер"
ATTACHMENT.Model = Model("models/zaihny/mw23/attachments/mike93/beretta92_rec.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike9/icon_attachment_pi_mike9_receiver.vmt")
ATTACHMENT.Bodygroups = {
    ["receiver"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end

ATTACHMENT.CosmeticChange = true