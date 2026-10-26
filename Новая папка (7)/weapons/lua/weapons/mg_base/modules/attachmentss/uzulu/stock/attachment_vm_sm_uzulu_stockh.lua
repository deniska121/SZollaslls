-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\uzulu\\stock\\attachment_vm_sm_uzulu_stockh.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Деревянный приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/uzulu/attachment_vm_sm_uzulu_stockh.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/uzulu/icon_attachment_sm_uzulu_stockh.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.82
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.82
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Recoil.AdsMultiplier = 0
	weapon.Cone.Shake = weapon.Cone.Shake * 0.2
end