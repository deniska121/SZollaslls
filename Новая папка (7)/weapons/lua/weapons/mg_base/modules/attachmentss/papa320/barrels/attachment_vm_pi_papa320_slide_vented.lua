-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\papa320\\barrels\\attachment_vm_pi_papa320_slide_vented.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Облегчённый ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_papa320_slide_vented.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/icon_attachment_pi_papa320_slide.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.02
    weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.02
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.97
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.97
end