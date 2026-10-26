-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\receiver\\attachment_vm_ar_mike4_receiver_black.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Альтернативный ресивер (A2)"
ATTACHMENT.Model = Model("models/att/m4/a2_receiver.mdl")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.LaserAimAngles = Angle(0, 0, 0)
	weapon.LaserAimPos = Vector(0, 6, 0)
end

ATTACHMENT.Laser = {}