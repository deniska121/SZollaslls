-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\stock\\attachment_vm_sm_mpapa5_stock_fullstock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Классический приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mpapa5/attachment_vm_sm_mpapa5_stock_fullstock.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mpapa5/icon_attachment_sm_mpapa5_stock_fullstock.vmt")

ATTACHMENT.AttachmentBodygroups = {
	["tag_stock_hide"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.94
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.94
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.9
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.9
	weapon.Cone.Shake = weapon.Cone.Shake * 0.5
end