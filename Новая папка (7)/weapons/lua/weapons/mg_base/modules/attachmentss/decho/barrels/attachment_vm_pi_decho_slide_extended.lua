-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\decho\\barrels\\attachment_vm_pi_decho_slide_extended.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_decho_slide_extended.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/decho/icon_attachment_pi_decho_slide_extended.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
ATTACHMENT.UseJunk = "parts_deagle"
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.5
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.85
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.85
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.85
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.85
	weapon.DontHide = true
end