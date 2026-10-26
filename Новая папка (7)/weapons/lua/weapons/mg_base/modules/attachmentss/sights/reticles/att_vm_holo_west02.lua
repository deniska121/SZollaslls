-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\reticles\\att_vm_holo_west02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_sight_1x"
ATTACHMENT.Name = "Голограф"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_holo_west02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/reticles/icon_attachment_holo_west02.vmt")

ATTACHMENT.Reticle = {
	Material = Material("viper/mw/reticles/reticle_reflex_default3"),
	Size = 800,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle"
}

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 1
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 1
}