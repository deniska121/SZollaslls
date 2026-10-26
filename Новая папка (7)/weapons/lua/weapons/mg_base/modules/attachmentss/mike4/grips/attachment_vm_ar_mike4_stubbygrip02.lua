-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\grips\\attachment_vm_ar_mike4_stubbygrip02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_stubbygrip02"
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
        weapon:SetGripPoseParameter("grip_gripvertpro_offset")
    end
end