-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\stock\\attachment_vm_sm_mpapa5_stock_nostock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Сложенный приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mpapa5/attachment_vm_sm_mpapa5_stock_nostock.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mpapa5/icon_attachment_sm_mpapa5_stock_nostock.vmt")

ATTACHMENT.AttachmentBodygroups = {
	["tag_stock_hide"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Recoil.AdsMultiplier = 1
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.26
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.26
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.26
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.26
	weapon.Cone.Shake = weapon.Cone.Shake * 3
end