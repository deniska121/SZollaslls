-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\charlie725\\stock\\attachment_vm_sh_charlie725_stockstable.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Снайперский приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/charlie725/attachment_vm_sh_charlie725_stockstable.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/charlie725/icon_attachment_sh_charlie725_stockstable.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.85
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.85
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.85
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.85
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.85
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.85
	weapon.Cone.Shake = weapon.Cone.Shake * 0.1
	weapon.Recoil.Punch = 0.6

	weapon.HolsterData = weapon.HolsterDataBack
	weapon.SlotType = 1
end