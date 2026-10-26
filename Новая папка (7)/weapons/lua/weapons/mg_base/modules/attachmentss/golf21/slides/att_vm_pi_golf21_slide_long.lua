-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf21\\slides\\att_vm_pi_golf21_slide_long.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_golf21_slide_long.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/golf21/icon_attachment_pi_golf21_slide_long.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.95
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.95
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.2
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.3
	weapon.PrintName = "Glock 41"
end

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "weapon_vm_pi_golf21_body" then return "gbskins/", "glock_black" end

	return path, mat
end

function ATTACHMENT:OverrideWeaponMaterial(path, mat)
	if mat == "weapon_vm_pi_golf21_body_poly" or mat == "weapon_vm_pi_golf21_body" then return "gbskins/", "glock_black" end

	return path, mat
end