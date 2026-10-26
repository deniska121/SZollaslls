-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\tec9\\mags\\attachment_vm_pi_tec9_mag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Model = Model("models/weapons/cs2/tec9/attachment_vm_pi_tec9_mag.mdl")

ATTACHMENT.BulletList = {
	[0] = {"j_ammo_02"},
	[1] = {"j_ammo_03"},
	[2] = {"j_ammo_04"},
	[3] = {"j_ammo_05"},
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
end