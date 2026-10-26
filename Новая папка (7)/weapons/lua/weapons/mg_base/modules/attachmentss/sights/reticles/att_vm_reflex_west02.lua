-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\reticles\\att_vm_reflex_west02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_sight_1x"
ATTACHMENT.Name = "Голограф 'Вольт'"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_lm_slima_acog_optic.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/optics/icon_attachment_lm_slima_acog_holo.vmt")

ATTACHMENT.Bodygroups = {
    --["tag_sight"] = 1, -- test
    ["tag_rail"] = 1,
    --["sight"] = 1
}

ATTACHMENT.AttachmentBodygroups = {
    --["tag_sight"] = 1, -- test
    ["tag_rail"] = 1,
   -- ["sight"] = 1
}

ATTACHMENT.Reticle = {
    Material = Material("viper/mw/reticles/reticle_holo_default.vmt"),
    Size = 800,
    Color = Color(255, 255, 255, 255),
    Attachment = "reticle",
    Squash = 0.25
}