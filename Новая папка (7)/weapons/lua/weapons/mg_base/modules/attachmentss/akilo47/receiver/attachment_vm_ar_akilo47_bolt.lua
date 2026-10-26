-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\receiver\\attachment_vm_ar_akilo47_bolt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_bolt"
ATTACHMENT.Name = "Автоматический УСМ"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/perks/perk_icon_hipaim.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	weapon.Primary.Automatic = true
	weapon.Firemodes = {
		[1] = {
			Name = "Full Auto",
			OnSet = function() return "Firemode_Auto" end
		},
		[2] = {
			Name = "Semi Auto",
			OnSet = function(s)
				s.Primary.Automatic = false
				return "Firemode_Semi"
			end
		},
	}
end