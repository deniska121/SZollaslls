-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\barrels\\attachment_vm_ar_mike4_barrel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол A1"
ATTACHMENT.Model = Model("models/att/m4/barrel_m16a1.mdl")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
ATTACHMENT.ExcludedCategories = {"ЛЦУ", "Рукоятки"}

ATTACHMENT.AttachmentBodygroups = {
	["ris"] = 1,
	["tag_grip_hide"] = 1,
	["tag_laser_hide"] = 1,
}

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.95
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.95
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.1
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.1
	weapon.Resource = weapon.Resource * 2
end