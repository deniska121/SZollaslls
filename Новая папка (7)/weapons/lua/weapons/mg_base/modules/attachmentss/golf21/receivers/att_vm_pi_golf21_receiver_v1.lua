-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf21\\receivers\\att_vm_pi_golf21_receiver_v1.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Альтернативный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_golf21_slide.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/golf21/icon_attachment_pi_golf21_slide.vmt")

ATTACHMENT.CosmeticChange = true

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "weapon_vm_pi_golf21_body" then return "gbskins/", "glock_black" end

	return path, mat
end

function ATTACHMENT:OverrideWeaponMaterial(path, mat)
	if mat == "weapon_vm_pi_golf21_body_poly" or mat == "weapon_vm_pi_golf21_body" then return "gbskins/", "glock_black" end

	return path, mat
end