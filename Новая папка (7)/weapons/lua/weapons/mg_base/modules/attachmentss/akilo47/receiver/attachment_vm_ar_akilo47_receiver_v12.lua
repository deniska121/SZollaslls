-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\receiver\\attachment_vm_ar_akilo47_receiver_v12.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Превосходство"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_receiver_akilo47_v12.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_receiver_akilo47_v12.vmt")

ATTACHMENT.Bodygroups = {
	["receiver"] = 1
}


ATTACHMENT.CosmeticChange = true
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	if weapon.ak74 then
		weapon.PrintName = "АК100"
	else
		weapon.PrintName = "АК103"
	end
end