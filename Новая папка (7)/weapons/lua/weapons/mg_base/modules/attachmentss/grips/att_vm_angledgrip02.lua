-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\grips\\att_vm_angledgrip02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_grip"
ATTACHMENT.Name = "Облегчённая тактическая рукоятка"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_angledgrip02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/grips/icon_attachment_angledgrip02.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.08
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.08
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.08
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.08
	weapon.Recoil.Horizontal[1] = self:ChangeRecoil(weapon.Recoil.Horizontal[1], 1.02)
	weapon.Recoil.Horizontal[2] = self:ChangeRecoil(weapon.Recoil.Horizontal[2], 1.02)
	weapon.Recoil.Vertical[1] = self:ChangeRecoil(weapon.Recoil.Vertical[1], 1.02)
	weapon.Recoil.Vertical[2] = self:ChangeRecoil(weapon.Recoil.Vertical[2], 1.02)
end