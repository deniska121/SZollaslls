-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike\\barrels\\attachment_vm_pi_mike_barrelppk.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Преступление"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_barrelppk.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_barlight.vmt")
ATTACHMENT.CosmeticChange = true

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.Sound = Sound("pi.walterppk.fire")
	weapon.PrintName = "Walther PPK"
end