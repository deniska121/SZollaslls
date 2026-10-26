-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\stocks\\att_vm_stock_no.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Без приклада"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_stock_no.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/stock/icon_attachment_stock_no.vmt")

ATTACHMENT.Bodygroups = {
	["tag_stock"] = 1,
	["stock_hide"] = 1
}

ATTACHMENT.AttachmentBodygroups = {
	["tag_stock"] = 1,
	["stock_hide"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Recoil.AdsMultiplier = 1
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.5
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.5
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.5
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.5
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.25
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.25
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 1.25
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.25
	weapon.Cone.Shake = weapon.Cone.Shake * 3
end