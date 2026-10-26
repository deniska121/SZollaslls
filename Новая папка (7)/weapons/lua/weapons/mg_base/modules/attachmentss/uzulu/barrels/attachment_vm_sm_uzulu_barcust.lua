-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\uzulu\\barrels\\attachment_vm_sm_uzulu_barcust.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Радиаторный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/uzulu/attachment_vm_sm_uzulu_barcust.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/uzulu/icon_attachment_sm_uzulu_barrel_v13.vmt")
ATTACHMENT.UseJunk = "parts_all"

ATTACHMENT.ExcludedCategories = {"Дуло"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.2
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.6
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.92
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.92
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.94
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.94
	weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 0.9
	weapon.Resource = weapon.Resource * 0.85
end