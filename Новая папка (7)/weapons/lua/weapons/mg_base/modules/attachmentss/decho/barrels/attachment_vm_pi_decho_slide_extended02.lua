-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\decho\\barrels\\attachment_vm_pi_decho_slide_extended02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Модифицированный ствол"
ATTACHMENT.UseJunk = "parts_all"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_decho_slide_extended02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/decho/icon_attachment_pi_decho_slide_extended02.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.1
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
end