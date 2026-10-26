-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\ammo\\att_ammo_default.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_ammo"
ATTACHMENT.Name = "Default"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_ammo.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    weapon.Projectile = nil
    weapon.Primary.TrailingSound = nil
end