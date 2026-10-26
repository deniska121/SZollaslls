-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\receivers\\attachment_vm_sm_mpapa5_receiver.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Гражданский ресивер"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mpapa5/attachment_vm_sm_mpapa5_receiver.mdl")

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if mat == "weapon_vm_sm_mpapa5_lower" then
		mat = "weapon_vm_sm_mpapa5_lower_sar"
	end

	return path, mat
end