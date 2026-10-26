-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\augolf\\rails\\attachment_vm_sm_augolf_arrail.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_rail"
ATTACHMENT.Name = "Крепление для прицела"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/augolf/icon_attachment_sm_augolf_arrail.vmt")

ATTACHMENT.Bodygroups = {
	["tag_rail_upper"] = 2,
	["tag_sight"] = 3
}

ATTACHMENT.ExcludedAttachments = {"attachment_vm_sm_augolf_lmgrail"}

ATTACHMENT.CosmeticChange = true
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.PrintName = "AUG A2"
end