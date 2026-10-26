-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\optics\\att_vm_scope_vz.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_optic_10x"
ATTACHMENT.Name = "Снайперский прицел"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_scope_vz.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/optics/icon_attachment_scope_vz.vmt")

ATTACHMENT.Bodygroups = {
    --["tag_sight"] = 1, -- test
    ["tag_rail"] = 1,
    ["tag_top_rail"] = 1,
    --["sight"] = 2
}

ATTACHMENT.AttachmentBodygroups = {
    --["tag_sight"] = 1, -- test
    ["tag_rail"] = 1,
   -- ["sight"] = 2
}

ATTACHMENT.Optic = {
    LensHideMaterial = Material("viper/MW/attachments/attachment_vm_scope_vz_lens.vmt"),
    HideModel = Model("models/viper/mw/attachments/weapon_vm_scope_vz_lens_hide.mdl"),
    LensBodygroup = "lens",
    FOV = 5,
    ParallaxSize = 700, --a value of zero means 1:1 size with the end of the optic
    Thermal = false
}

ATTACHMENT.Reticle = {
    Material = Material("viper/mw/reticles/reticle_int_default.vmt"),
    Size = 500,
    Color = Color(255, 255, 255, 255),
    Attachment = "reticle",
    Parallaxing = 800,
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Zoom.ViewModelFovMultiplier = weapon.Zoom.ViewModelFovMultiplier * 0.9
end