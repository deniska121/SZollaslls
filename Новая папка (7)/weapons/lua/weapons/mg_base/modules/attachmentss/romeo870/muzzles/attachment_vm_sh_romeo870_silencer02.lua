-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\muzzles\\attachment_vm_sh_romeo870_silencer02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_silencer02"
ATTACHMENT.Name = "Монолитный глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/oscar12/attachment_vm_sh_oscar12_silencer02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/oscar12/icon_attachment_sh_oscar12_silencer02.vmt")
ATTACHMENT.BonemergeToCategory = {"Стволы"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

    weapon.DistSound = ""
end 