-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\slides\\att_vm_pi_golf18_slide_light.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_pi_golf21_slide"
ATTACHMENT.Model = Model("models/att/glock/glock19_slide.mdl")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	--weapon.Animations.Draw.Fps = 30
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.3
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.9
	weapon.PrintName = "Glock 19"
end

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_reargrip_golf") and mat == "glock_17" then return path, "glock_17silver" end
	return path, mat
end