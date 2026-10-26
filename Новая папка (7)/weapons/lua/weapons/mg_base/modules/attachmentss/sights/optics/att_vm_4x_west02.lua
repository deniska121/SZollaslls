-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\optics\\att_vm_4x_west02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_optic_4x"
ATTACHMENT.Name = "Профессиональная оптика"
ATTACHMENT.Model = Model("models/zeron/atts/attachment_vm_vzscope_t901.mdl")
ATTACHMENT.Icon = Material("easy/cw/attachments/icons/nato/icon_attachment_optic_dualzoom_t9.vmt")

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
}

ATTACHMENT.Optic = {
	LensHideMaterial = Material("viper/MW/attachments/attachment_vm_4x_west_lens.vmt"),
	HideModel = Model("models/zeron/atts/attachment_vm_vzscope_t901_hide.mdl"),
	LensBodygroup = "lens",
	FOV = 7,
	ParallaxSize = 600, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Reticle = {
	Material = Material("zeron/reticles/susatmlt.vmt"),
	Size = 3000,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	--Offset = Vector(-0, -0, 0),
	Parallaxing = 1200,
}

ATTACHMENT.ReticleHybrid = {
	Material = Material("null"),
	Size = 1500,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	Offsets = {
		pos = Vector(0, 0, -0.8),
		ang = Angle(),
	}
}