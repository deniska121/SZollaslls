-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\mags\\attachment_vm_ar_mike4_mag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mike4/attachment_vm_ar_mike4_stanag20mag.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike4/icon_attachment_ar_mike4_mag.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Primary.ClipSize = 20
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.1
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1
    weapon.Animations.Reload = weapon.Animations.Reload_Fast
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Fast
end

ATTACHMENT.BulletList = {
    [1] = {"j_bullet_attachment_016"},
    [2] = {"j_bullet_attachment_015"},
    [3] = {"j_bullet_attachment_014"},
    [4] = {"j_bullet_attachment_013"},
    [5] = {"j_bullet_attachment_012"},
    [6] = {"j_bullet_attachment_011"},
    [7] = {"j_bullet_attachment_010"}
}