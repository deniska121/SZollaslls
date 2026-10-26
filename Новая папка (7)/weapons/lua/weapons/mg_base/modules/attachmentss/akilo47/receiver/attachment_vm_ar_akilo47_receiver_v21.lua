-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\receiver\\attachment_vm_ar_akilo47_receiver_v21.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Резонанс"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_receiver_akilo74.mdl")

ATTACHMENT.Bodygroups = {
	["receiver"] = 1
}


ATTACHMENT.CosmeticChange = true
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
end