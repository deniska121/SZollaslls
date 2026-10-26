-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\muzzles\\suppressors\\att_vm_oil_filter_suppressor.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_muzzle"
ATTACHMENT.Name = "Самодельный глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_oil_filter_suppressor.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/muzzle/icon_attachment_oil_filter_suppressor.vmt")

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
	weapon.Resource = weapon.Resource * 7
	weapon.DistSound = ""
	weapon:doSuppressorStats()
end

function ATTACHMENT:OverrideMaterial(path, mat)
	return "phoenix_storms/trains/", "track_plateside"
end