-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike\\mags\\attachment_vm_pi_mike_xmags.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "20 Round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_xmags.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_xmags.vmt")

ATTACHMENT.BulletList = {
    [1] = {"j_bullet1"},
    [2] = {"j_bullet2"},
    [3] = {"j_bullet3"},
    [4] = {"j_bullet4"},
    [5] = {"j_bullet5"},
    [6] = {"j_bullet6"},
    [7] = {"j_bullet7"},
    [8] = {"j_bullet8"},
    [9] = {"j_bullet9"},
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Primary.ClipSize = 12
    weapon.Animations.Reload = weapon.Animations.Reload_Xmag
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Xmag
    weapon.Animations.Reload_Fast = weapon.Animations.Reload_Xmag_Fast
    weapon.Animations.Reload_Empty_Fast = weapon.Animations.Reload_Empty_Xmag_Fast
    weapon.Animations.Inspect = weapon.Animations.Inspect_Xmag
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
end