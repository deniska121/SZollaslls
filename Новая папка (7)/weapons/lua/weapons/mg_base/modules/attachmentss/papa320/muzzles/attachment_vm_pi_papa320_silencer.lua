-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\papa320\\muzzles\\attachment_vm_pi_papa320_silencer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_silencer01_pstl"
ATTACHMENT.Name = "Глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_papa320_silencer.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/icon_attachment_sh_oscar12_suppressor.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.DistSound = ""
end