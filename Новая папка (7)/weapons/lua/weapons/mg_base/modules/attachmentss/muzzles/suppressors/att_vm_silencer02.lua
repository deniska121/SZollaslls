-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\muzzles\\suppressors\\att_vm_silencer02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_muzzle"
ATTACHMENT.Name = "Глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_silencer02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/muzzle/icon_attachment_silencer02.vmt")

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
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.99
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.99
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.98
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.98
	weapon.DistSound = ""
	weapon.Resource = weapon.Resource * 2
	weapon:doSuppressorStats()
end