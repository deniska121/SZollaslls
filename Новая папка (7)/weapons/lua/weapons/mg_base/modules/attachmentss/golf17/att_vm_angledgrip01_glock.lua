-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\att_vm_angledgrip01_glock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_angledgrip01"
ATTACHMENT.BonemergeToCategory = {"Barrels"}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
end