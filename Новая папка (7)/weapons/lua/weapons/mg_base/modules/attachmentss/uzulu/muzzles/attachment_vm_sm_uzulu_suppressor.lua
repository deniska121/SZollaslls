-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\uzulu\\muzzles\\attachment_vm_sm_uzulu_suppressor.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_silencer04"
ATTACHMENT.Name = "Монолитный глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/uzulu/attachment_vm_sm_uzulu_suppressor.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/uzulu/icon_attachment_sm_uzulu_suppressor.vmt")

ATTACHMENT.BonemergeToCategory = {"Стволы"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.DistSound = ""
end