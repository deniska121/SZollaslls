-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\slides\\att_vm_pi_romeo18_slide.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/att/glock/glock_slide.mdl")
ATTACHMENT.Name = "Заводской ствол"

ATTACHMENT.ExcludedCategories = {"Дуло"}

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_reargrip_golf") and mat == "glock_17" then return path, "glock_17silver" end
	return path, mat
end