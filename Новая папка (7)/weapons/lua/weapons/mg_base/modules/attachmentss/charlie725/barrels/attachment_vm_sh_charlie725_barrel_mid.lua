-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\charlie725\\barrels\\attachment_vm_sh_charlie725_barrel_mid.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/charlie725/attachment_vm_sh_charlie725_barrel_mid.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/charlie725/icon_attachment_sh_charlie725_barrel_mid.vmt")

ATTACHMENT.Bodygroups = {
	["tag_grip_rail"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Animations.Reload.Fps = weapon.Animations.Reload.Fps * 0.95
	weapon.Animations.Reload_Empty.Fps = weapon.Animations.Reload_Empty.Fps * 0.95
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 2.5
	weapon.Bullet.Range = weapon.Bullet.Range * 1.6
	weapon.Bullet.Spread = 0.12
	weapon.Cone.Hip = weapon.Cone.Hip * 0.9
	weapon.HolsterData = weapon.HolsterDataBack
	weapon.SlotType = 1
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
end