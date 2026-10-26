-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\stock\\attachment_vm_ar_akilo74_stock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_ar_akilo47_stock.mdl")

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "weapon_vm_ar_akilo47_stock" then
		return "gbskins/", "weapon_vm_ar_akilo74_stock"
	end

	return path, mat
end