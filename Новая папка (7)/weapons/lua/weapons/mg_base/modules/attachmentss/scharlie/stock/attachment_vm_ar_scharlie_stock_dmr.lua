-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\scharlie\\stock\\attachment_vm_ar_scharlie_stock_dmr.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Снайперский приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_stock_dmr.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/scharlie/icon_attachment_ar_scharlie_stock_dmr.vmt")
-- ATTACHMENT.Bodygroups ={
--     ["tag_stock"] = 1
-- }
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.9
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.9
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.9
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.9
	weapon.Cone.Shake = weapon.Cone.Shake * 0.4

	if (weapon:HasAttachment("attachment_vm_ar_scharlie_barrel_long")) then
		weapon.PrintName = "FN SSR"
	end
end