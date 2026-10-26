-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\slides\\att_vm_pi_golf17_slide.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/att/glock/glock_slide.mdl")
ATTACHMENT.Name = "Удлиненный ствол"
ATTACHMENT.UseJunk = "parts_all"
ATTACHMENT.AttachmentBodygroups = {
	["barrel"] = 1,
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.1
end

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_reargrip_golf") and mat == "glock_17" then return path, "glock_17silver" end
	return path, mat
end