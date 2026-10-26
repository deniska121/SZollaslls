-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\hybrids\\att_vm_hybrid_eastern02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_hybrid_3x"
ATTACHMENT.Name = "Гибридный прицел-миди (3.0x)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_hybrid_east02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/hybrid/icon_attachment_hybrid_east02_lw.vmt")

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
	LensHideMaterial = Material("viper/MW/attachments/reticle_ui_stencil.vmt"),
	HideModel = Model("models/viper/mw/attachments/attachment_vm_hybrid_east02_hide.mdl"),
	LensBodygroup = "lens",
	FOV = 7,
	ParallaxSize = 600, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Reticle = {
	Material = Material("viper/mw/reticles/reticle_acog_default3.vmt"),
	Size = 650,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle"
}

ATTACHMENT.ReticleHybrid = {
	Material = Material("viper/mw/reticles/reticle_holo_default.vmt"),
	Size = 800,
	Color = Color(255, 255, 255, 200),
	OnAnimation = "HybridOn",
	OffAnimation = "HybridOff",
	Attachment = "reticle2"
}