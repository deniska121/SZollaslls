-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\papa220\\grips\\attachment_vm_pi_papa220_pistgrip.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pistolgrip"
ATTACHMENT.Name = "Default Grip"
ATTACHMENT.Model = Model("models/kyo/att_vm_p27_pi_papa220_grip_v0_lod0.mdl")


ATTACHMENT.Bodygroups = {
    ["grip"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

end