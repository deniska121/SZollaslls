-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\barrels\\attachment_vm_ar_akilo47_smgbarcust.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол (Румыния)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_ar_akilo47_smgbarcust.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_vertgrip_akilo47.vmt")

ATTACHMENT.ExcludedCategories = {"Рукоятки"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.9
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.08
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.08
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.08
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.08
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.85
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.85
	weapon.HoldType = "RifleWithVerticalGrip"
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetGripPoseParameter("grip_vert_offset")
end