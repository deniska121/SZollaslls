-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\muzzles\\suppressors\\attachment_vm_sh_oscar12_suppressor.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_silencer01"
ATTACHMENT.Name = "Облегчённый глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/oscar12/attachment_vm_sh_oscar12_suppressor.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/oscar12/icon_attachment_sh_oscar12_suppressor.vmt")

ATTACHMENT.BonemergeToCategory = {"Стволы"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.DistSound = ""
end