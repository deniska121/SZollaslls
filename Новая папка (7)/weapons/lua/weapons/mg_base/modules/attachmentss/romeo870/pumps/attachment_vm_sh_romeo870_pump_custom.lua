-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\pumps\\attachment_vm_sh_romeo870_pump_custom.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pump"
ATTACHMENT.Name = "Тактическое цевьё"
ATTACHMENT.Model = Model("models/viper/mw/attachments/romeo870/attachment_vm_sh_romeo870_pump_custom.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_pump_custom.vmt")

ATTACHMENT.ExcludedCategories = {"Рукоятки"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	-- weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 1.2
	-- weapon.Animations.Rechamber.Fps = weapon.Animations.Rechamber.Fps * 1.5
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.2
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.1
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 1.1
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.2
	weapon.Primary.RPM = 350
	weapon.Animations.Rechamber.Length = 0.38
	weapon.Cone.Hip = 1.3
	weapon.Cone.Max = 7.5
end