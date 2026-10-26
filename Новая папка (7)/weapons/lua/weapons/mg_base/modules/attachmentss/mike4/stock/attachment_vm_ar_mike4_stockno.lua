-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\stock\\attachment_vm_ar_mike4_stockno.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_stock_medium01"
ATTACHMENT.Name = "Без приклада"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mike4/attachment_vm_ar_mike4_stockno.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/stock/icon_attachment_stock_no.vmt")
-- ATTACHMENT.Bodygroups ={
--     ["tag_stock"] = 1
-- }
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Recoil.AdsMultiplier = 0.5
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.26
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.26
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.26
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.26
	weapon.Cone.Shake = weapon.Cone.Shake * 3
end