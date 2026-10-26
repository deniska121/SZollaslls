-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mac10\\mags\\mac_mag_mac10.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Model = Model("models/mac_mag_mw.mdl")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
        weapon.Primary.ClipSize = 30
        weapon.Animations.Reload = weapon.Animations.Reload_Xmag
        weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Xmag
        weapon.Animations.Reload_Fast = weapon.Animations.Reload_Xmag_Fast
        weapon.Animations.Reload_Empty_Fast = weapon.Animations.Reload_Empty_Xmag_Fast
end