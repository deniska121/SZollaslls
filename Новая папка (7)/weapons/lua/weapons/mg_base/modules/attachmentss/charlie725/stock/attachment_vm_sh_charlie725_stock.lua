-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\charlie725\\stock\\attachment_vm_sh_charlie725_stock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Стандартный приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/charlie725/attachment_vm_sh_charlie725_stock.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/charlie725/icon_attachment_sh_charlie725_stocktactical.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.9
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.9
	weapon.Cone.Shake = weapon.Cone.Shake * 0.3
	weapon.Recoil.Punch = 0.7

	weapon.HolsterData = weapon.HolsterDataBack
	weapon.SlotType = 1
end