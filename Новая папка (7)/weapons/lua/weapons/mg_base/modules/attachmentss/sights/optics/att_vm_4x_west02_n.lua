-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\optics\\att_vm_4x_west02_n.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_optic_4x"
ATTACHMENT.Name = "Профессиональная оптика"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_4x_west02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/optics/icon_attachment_4x_west02.vmt")

ATTACHMENT.Bodygroups = {
    --["tag_sight"] = 1, -- test
    ["tag_rail"] = 1,
    --["sight"] = 2
}

ATTACHMENT.AttachmentBodygroups = {
    --["tag_sight"] = 1, -- test
    ["tag_rail"] = 1,
    --["sight"] = 2
}

ATTACHMENT.Optic = {
    LensHideMaterial = Material("viper/MW/attachments/attachment_vm_4x_west02_lens.vmt"),
    HideModel = Model("models/viper/mw/attachments/attachment_vm_4x_west02_hide.mdl"),
    LensBodygroup = "lens",
    FOV = 7,
    ParallaxSize = 20, --a value of zero means 1:1 size with the end of the optic
    Thermal = false
}

ATTACHMENT.Reticle = {
    Material = Material("viper/mw/reticles/reticle_vzscope_default.vmt"),
    Size = 900,
    Color = Color(255, 255, 255, 255),
    Attachment = "reticle",
    Parallaxing = 1200,
}