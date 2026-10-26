-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\grips\\attachment_vm_ar_mike4_angledgrip01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_angledgrip01"
ATTACHMENT.BonemergeToCategory = {"Стволы"}
ATTACHMENT.AttachmentBodygroups = {
    ["tag_grip_hide"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)

    if (weapon.AlternateGrips) then
        weapon:SetGripPoseParameter("grip_barshort_gripang_offset") 
    else
        weapon:SetGripPoseParameter("grip_gripang_offset")
    end
end