-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\sights\\attachment_vm_ar_mike4_carryhandle.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_sight"
ATTACHMENT.Name = "Прицел-рукоять"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mike4/attachment_vm_ar_mike4_carryhandle.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike4/icon_attachment_ar_mike4_carryhandle.vmt")

ATTACHMENT.Bodygroups = {
	["tag_sight"] = 2
}

ATTACHMENT.AttachmentBodygroups = {
	["sight"] = 2
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
end