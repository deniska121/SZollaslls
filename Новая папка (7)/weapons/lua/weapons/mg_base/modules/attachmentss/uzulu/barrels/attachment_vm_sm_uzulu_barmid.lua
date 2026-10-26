-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\uzulu\\barrels\\attachment_vm_sm_uzulu_barmid.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол (131 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/uzulu/attachment_vm_sm_uzulu_barmid.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/uzulu/icon_attachment_sm_uzulu_barmid.vmt")
ATTACHMENT.UseJunk = "parts_all"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.4
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.6
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.94
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.94
end