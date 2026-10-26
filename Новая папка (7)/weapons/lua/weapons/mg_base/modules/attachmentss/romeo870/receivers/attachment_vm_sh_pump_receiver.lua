-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\receivers\\attachment_vm_sh_pump_receiver.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Раритет"
ATTACHMENT.Model = Model("models/viper/mw/attachments/romeo870/attachment_vm_sh_pump_receiver.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_receiver_v2.vmt")

ATTACHMENT.ExcludedAttachments = {"attachment_vm_sh_romeo870_stock_pistolgrip", "attachment_vm_sh_romeo870_stock", "attachment_vm_sh_romeo870_stock_wood"}

ATTACHMENT.ExcludedCategories = {"Системы", "Приклады"}


ATTACHMENT.CosmeticChange = true

ATTACHMENT.AttachmentBodygroups = {
	["tag_stock"] = 1,
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetGripPoseParameter2("grip_stockh_offset")
	weapon.DoEjection = function() end
	weapon.bannedParticte = "shell_eject"
	weapon.PrintName = "Ithaca 37"
end