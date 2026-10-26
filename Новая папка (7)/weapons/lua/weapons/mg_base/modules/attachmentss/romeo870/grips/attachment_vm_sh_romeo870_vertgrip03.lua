-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\grips\\attachment_vm_sh_romeo870_vertgrip03.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_vertgrip03"
ATTACHMENT.AttachmentBodygroups = {
    ["tag_grip_hide"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    weapon:SetGripPoseParameter("grip_vert_offset")
end 