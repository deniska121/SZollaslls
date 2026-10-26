-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\stock\\attachment_vm_ar_mike4_stock_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mike4/attachment_vm_ar_mike4_stock_car15s.mdl")
ATTACHMENT.Name = "Сложенный приклад"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Recoil.AdsMultiplier = 0.8
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.1
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
	weapon.Cone.Shake = weapon.Cone.Shake * 2
end