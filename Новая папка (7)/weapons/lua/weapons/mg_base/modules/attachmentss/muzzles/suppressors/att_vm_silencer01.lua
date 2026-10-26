-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\muzzles\\suppressors\\att_vm_silencer01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_muzzle"
ATTACHMENT.Name = "Глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_silencer_east01.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/muzzle/icon_attachment_silencer_east01.vmt")

ATTACHMENT.BonemergeToCategory = {"Стволы"}

ATTACHMENT.AttachmentBodygroups = {
	["tag_tip"] = 1,
	["muzzle"] = 1,
	["tip"] = 1
}

ATTACHMENT.Bodygroups = {
	["tag_tip"] = 1,
	["muzzle"] = 1,
	["tip"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.02
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.02
	weapon.Resource = weapon.Resource * 2
	weapon.DistSound = ""
	weapon:doSuppressorStats()
end