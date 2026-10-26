-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike9\\receivers\\attachment_vm_pi_mike9_receiver_diamatti.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Забытая классика"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike9_receiver_diamatti.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike9/icon_attachment_pi_mike9_receiver.vmt")

ATTACHMENT.ExcludedCategories = {"ЛЦУ", "Прицелы", "Рукоятки"}

ATTACHMENT.Bodygroups = {
	["receiver"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.Sound = Sound("bocw.pi_burst.fire")
	weapon.PrintName = "Beretta 93R"
end


ATTACHMENT.CosmeticChange = true