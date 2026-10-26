-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\scharlie\\barrels\\attachment_vm_ar_scharlie_barrel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_barrel.mdl")

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_bolt") and mat == "weapon_vm_ar_scharlie_body" then
		mat = "weapon_vm_ar_scharlie_body_sar"
	end

	return path, mat
end

function ATTACHMENT:OverrideWeaponMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_bolt") and mat == "weapon_vm_ar_scharlie_body" then
		mat = "weapon_vm_ar_scharlie_body_sar"
	end

	return path, mat
end