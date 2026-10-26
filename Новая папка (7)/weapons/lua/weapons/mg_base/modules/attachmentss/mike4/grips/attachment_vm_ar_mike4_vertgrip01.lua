-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\grips\\attachment_vm_ar_mike4_vertgrip01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_vertgrip01"
ATTACHMENT.AttachmentBodygroups = {
    ["tag_grip_hide"] = 1
}
ATTACHMENT.BonemergeToCategory = {"Стволы"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)

    if (weapon.AlternateGrips) then 
        weapon:SetGripPoseParameter("grip_barshort_gripvert_offset") 
    else
        weapon:SetGripPoseParameter("grip_gripvert_offset")
    end
end