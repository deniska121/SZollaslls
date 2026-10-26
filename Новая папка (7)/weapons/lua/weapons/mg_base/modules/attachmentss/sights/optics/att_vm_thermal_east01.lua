-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\optics\\att_vm_thermal_east01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_optic_4x"
ATTACHMENT.Name = "Термальный прицел (4.0x)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_thermal_east.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/optics/icon_attachment_thermal_east.vmt")

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 2, -- test
	["tag_rail"] = 1,
	["sight"] = 2
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 2, -- test
	["tag_rail"] = 1,
	["sight"] = 2
}

ATTACHMENT.Optic = {
	HideModel = Model("models/viper/mw/attachments/attachment_vm_thermal_east_hide.mdl"),
	LensHideMaterial = Material("viper/MW/attachments/attachment_vm_thermal_east_lens.vmt"),
	LensBodygroup = "lens",
	FOV = 7,
	ParallaxSize = 300, --a value of zero means 1:1 size with the end of the optic
	Thermal = true
}

ATTACHMENT.Reticle = {
	Material = Material("viper/mw/reticles/reticle_thermal_default2.vmt"),
	Size = 750,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle"
}