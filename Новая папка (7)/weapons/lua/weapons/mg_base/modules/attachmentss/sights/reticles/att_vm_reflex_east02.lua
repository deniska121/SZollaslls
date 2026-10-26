-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\reticles\\att_vm_reflex_east02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_sight_1x"
ATTACHMENT.Name = "Коллиматор 'Монокль'"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_reflex_east02_lod0.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/reticles/icon_attachment_reflex_east02.vmt")

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