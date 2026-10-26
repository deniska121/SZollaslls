-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\scharlie\\barrels\\attachment_vm_ar_scharlie_barrel_pdw.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_barrel_pdw.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/scharlie/icon_attachment_ar_scharlie_barrel_pdw.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.85
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.85
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.1
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
	weapon.PrintName = "FN MK 17 CQC"
end

function ATTACHMENT:OverrideWeaponMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_bolt") and mat == "weapon_vm_ar_scharlie_body" then
		mat = "weapon_vm_ar_scharlie_body_sar"
	end

	return path, mat
end