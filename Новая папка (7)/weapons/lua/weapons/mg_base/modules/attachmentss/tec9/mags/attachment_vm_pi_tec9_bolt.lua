-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\tec9\\mags\\attachment_vm_pi_tec9_bolt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_bolt"
ATTACHMENT.Name = "Автоматический УСМ"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	weapon.Primary.Automatic = true
	weapon.Firemodes = {
		[1] = {
			Name = "Full Auto",
			OnSet = function() return "Firemode_Auto" end
		},
	}
end