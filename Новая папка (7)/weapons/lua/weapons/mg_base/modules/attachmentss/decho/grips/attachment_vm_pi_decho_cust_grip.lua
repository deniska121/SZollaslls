-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\decho\\grips\\attachment_vm_pi_decho_cust_grip.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_grip"
ATTACHMENT.Name = "Резиновая рукоять"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_decho_cust_grip.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/decho/icon_attachment_pi_decho_pistolgrip_tape_v2.vmt")
ATTACHMENT.UseJunk = "parts_all"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.8
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.8
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.7
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.7
end