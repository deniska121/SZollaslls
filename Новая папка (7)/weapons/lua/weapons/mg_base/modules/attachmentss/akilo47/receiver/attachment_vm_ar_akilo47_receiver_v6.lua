-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\receiver\\attachment_vm_ar_akilo47_receiver_v6.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/v_akilo47m.mdl")

ATTACHMENT.Bodygroups = {
	["receiver"] = 1
}

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "weapon_vm_ar_akilo47_fore" then
		return "gbskins/", "weapon_vm_ar_akilo74_fore"
	end

	if mat == "weapon_vm_ar_akilo47_pgrip" then
		return "gbskins/", "weapon_vm_ar_akilo74_pgrip"
	end

	if mat == "weapon_vm_ar_akilo47_stock" then
		return "gbskins/", "weapon_vm_ar_akilo74_stock"
	end

	return path, mat
end

function ATTACHMENT:OverrideWeaponMaterial(path, mat)
	if mat == "weapon_vm_ar_akilo47_pgrip" then
		return "gbskins/", "weapon_vm_ar_akilo74_pgrip"
	end

	if mat == "weapon_vm_ar_akilo47_stock" then
		return "gbskins/", "weapon_vm_ar_akilo74_stock"
	end

	return path, mat
end