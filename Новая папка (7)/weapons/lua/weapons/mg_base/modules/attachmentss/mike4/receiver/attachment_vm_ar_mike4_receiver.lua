-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\receiver\\attachment_vm_ar_mike4_receiver.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mike4/attachment_vm_ar_mike4_receiver.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike4/icon_attachment_ar_mike4_receiver.vmt")
ATTACHMENT.Name = "Альтернативный ресивер"
ATTACHMENT.CosmeticChange = true
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
end