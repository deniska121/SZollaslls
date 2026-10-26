-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\muzzles\\attachment_vm_bayonet_akilo47.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_muzzle"
ATTACHMENT.Name = "Штык-нож"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_bayonet_akilo47.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_bayonet_akilo47.vmt")

ATTACHMENT.BonemergeToCategory = {"Стволы"}

ATTACHMENT.ExcludedAttachments = {"attachment_vm_ar_akilo47_smgbarrel", "attachment_vm_ar_akilo47_smgbarcust"}

ATTACHMENT.AttachmentBodygroups = {
	["tag_tip"] = 1,
	["tip"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Melee = weapon.Animations.Melee_Bayonet
	weapon.Animations.Melee_Hit = weapon.Animations.Melee_Hit_Bayonet
	weapon.Animations.Melee_Hit_Bayonet.Damage = 100
end