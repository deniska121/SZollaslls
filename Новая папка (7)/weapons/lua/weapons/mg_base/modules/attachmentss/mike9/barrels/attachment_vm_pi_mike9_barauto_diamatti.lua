-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike9\\barrels\\attachment_vm_pi_mike9_barauto_diamatti.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Забытая классика"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike9_barauto_diamatti.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike9/icon_attachment_pi_mike9_barauto.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

ATTACHMENT.ExcludedCategories = {"Дуло"}

function ATTACHMENT:Stats(weapon)
	weapon.Primary.RPM = 1000
	weapon.Primary.BurstRounds = 3
	weapon.Primary.BurstDelay = 0.1
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.85
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.85
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.7
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.7
	weapon.Recoil.Shake = weapon.Recoil.Shake * 0.1
	BaseClass.Stats(self, weapon)
	weapon.PrintName = "Beretta 93R"

	weapon.Firemodes = {
		[1] = {
			Name = "3rnd Burst",
			OnSet = function() return "Firemode_Auto" end
		},
		[2] = {
			Name = "Semi Auto",
			OnSet = function(s)
				s.Primary.Automatic = false
				s.Primary.BurstRounds = 1
				return "Firemode_Semi"
			end
		},
	}
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetGripPoseParameter("grip_offset")
end

ATTACHMENT.CosmeticChange = true