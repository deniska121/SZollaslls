-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\slides\\att_vm_pi_golf18_slide.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/att/glock/glock18c_slide.mdl")
ATTACHMENT.Name = "Автоматический ствол"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Firemodes[1].Name = "Full Auto"
	weapon.Primary.Automatic = true
	weapon.Primary.RPM = 1200
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.9
	weapon.PrintName = "Glock 18C"

	weapon.Firemodes = {
		[1] = {
			Name = "Full Auto",
			OnSet = function() return "Firemode_Auto" end
		},
		[2] = {
			Name = "Semi Auto",
			OnSet = function(s)
				s.Primary.Automatic = false
				return "Firemode_Semi"
			end
		},
	}
end

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_reargrip_golf") and mat == "glock_17" then return path, "glock_17silver" end
	return path, mat
end