-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\stock\\att_vm_romeo870_stock_heavy01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Модифицированный приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_stock_heavy.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/stock/icon_attachment_stock_medium01.vmt")

ATTACHMENT.BonemergeToCategory = {"Ресиверы"}

ATTACHMENT.AttachmentBodygroups = {
	["tag_stock"] = 1,
	["stock"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.95
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.95
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.95
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.95
	weapon.Cone.Shake = weapon.Cone.Shake * 0.9
end