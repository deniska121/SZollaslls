-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\muzzles\\attachment_vm_sh_romeo870_silencer03.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_silencer03"
ATTACHMENT.Name = "Глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/oscar12/attachment_vm_sh_oscar12_silencer03.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/oscar12/icon_attachment_sh_oscar12_silencer03.vmt")

ATTACHMENT.BonemergeToCategory = {"Стволы"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.DistSound = ""
end