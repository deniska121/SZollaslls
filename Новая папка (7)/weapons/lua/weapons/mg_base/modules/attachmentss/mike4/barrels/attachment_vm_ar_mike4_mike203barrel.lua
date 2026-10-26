-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\barrels\\attachment_vm_ar_mike4_mike203barrel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Антикварный ствол"
ATTACHMENT.Model = Model("models/att/m4/barrel_m13m203.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike4/icon_attachment_barmid_mike4.vmt")

ATTACHMENT.ExcludedCategories = {"ЛЦУ", "Рукоятки"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Cone.Hip = weapon.Cone.Hip * 0.9
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.6
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.6
end