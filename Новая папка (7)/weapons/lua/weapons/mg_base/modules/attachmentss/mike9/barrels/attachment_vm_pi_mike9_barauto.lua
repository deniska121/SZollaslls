-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike9\\barrels\\attachment_vm_pi_mike9_barauto.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Соревновательный ствол"
ATTACHMENT.Model = Model("models/zaihny/mw23/attachments/mike93/attachment_vm_jup_pi_mike93_bar_longhvy_000.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike9/icon_attachment_pi_mike9_barauto.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

ATTACHMENT.ExcludedCategories = {"Дуло"}
ATTACHMENT.UseJunk = "parts_all"

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.12
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.12
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.7
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.7
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.7
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.7
	weapon.Cone.Hip =  weapon.Cone.Hip * 0.9
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.85
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.85
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.7
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.7
end