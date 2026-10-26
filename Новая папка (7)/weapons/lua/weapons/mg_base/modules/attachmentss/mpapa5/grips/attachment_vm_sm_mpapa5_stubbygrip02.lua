-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\grips\\attachment_vm_sm_mpapa5_stubbygrip02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_stubbygrip02"
ATTACHMENT.AttachmentBodygroups = {
    ["tag_grip_hide"] = 1,
    ["tag_grip_attach"] = 1
}


local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)

end

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    weapon:SetGripPoseParameter("grip_vert_offset")
end 