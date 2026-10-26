-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\receivers\\attachment_vm_sm_mpapa5_receiver_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Военный ресивер"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mpapa5/attachment_vm_sm_mpapa5_receiver.mdl")
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