-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\cpapa\\stocks\\att_vm_pi_cpapa_stock01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Деревянная рукоять с прикладом"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_cpapa_grip_stock.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/cpapa/icon_attachment_pi_cpapa_grip_stock.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.8
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.8
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.8
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.8
	weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 0.5
	weapon.ViewModelOffsets.Aim.Pos = weapon.ViewModelOffsets.Aim.Pos + Vector(0.15, 0, 0)
	weapon.Cone.Shake = weapon.Cone.Shake * 0.2
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetViewModel("models/viper/mw/weapons/v_357_stock.mdl")
end