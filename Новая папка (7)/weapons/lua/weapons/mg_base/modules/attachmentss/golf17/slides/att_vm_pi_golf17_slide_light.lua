-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\slides\\att_vm_pi_golf17_slide_light.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_pi_golf21_slide"
ATTACHMENT.Name = "Удлиненная затворная рама"
ATTACHMENT.Model = Model("models/att/glock/glock17l_slide.mdl")
ATTACHMENT.UseJunk = "parts_all"
ATTACHMENT.ExcludedCategories = {"Дуло"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.25
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.35
	weapon.PrintName = "Glock 17L"
end

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_reargrip_golf") and mat == "glock_17" then return path, "glock_17silver" end
	return path, mat
end