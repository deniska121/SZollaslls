-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\stock\\attachment_vm_ar_akilo47_smgstock_unfolded.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Складной приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_ar_akilo74_stock.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_smgstock_unfolded_akilo47.vmt")

ATTACHMENT.AttachmentBodygroups = {
	["tag_stock"] = 1,
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.1
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.15
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.15
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 1.15
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.15
	weapon.Cone.Shake =  weapon.Cone.Shake * 1.5
end