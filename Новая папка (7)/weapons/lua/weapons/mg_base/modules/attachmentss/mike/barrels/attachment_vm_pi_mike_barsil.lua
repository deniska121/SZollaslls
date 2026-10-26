-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike\\barrels\\attachment_vm_pi_mike_barsil.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Интегрированный глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_barsil.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_barsil.vmt")

ATTACHMENT.ExcludedCategories = {"Дуло"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.1
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Cone.Hip = weapon.Cone.Hip * 0.9
	weapon.DistSound = ""
	weapon:doSuppressorStats()
	weapon.PrintName = "ПБ"
end