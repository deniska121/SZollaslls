-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\lasers\\att_vm_flash_pstl.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_laser"
ATTACHMENT.Name = "Фонарь"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_laser01.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/laser/icon_attachment_laser01.vmt")

ATTACHMENT.Laser = {}

ATTACHMENT.Flashlight = {
    FlashlightMaterial = Material("effects/flashlight001.vmt"),
    Color = Color(255, 255, 255, 255),
    Attachment = "laser"
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

    weapon.Cone.Hip = weapon.Cone.Hip * 0.9
    weapon.Cone.Ads = weapon.Cone.Ads * 0.9
    weapon.Cone.Increase = weapon.Cone.Increase * 0.9
end 