-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\grips\\attachment_vm_ar_akilo47_stubbygrip02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_stubbygrip02"

ATTACHMENT.BonemergeToCategory = {"Стволы"}

ATTACHMENT.AttachmentBodygroups = {
    ["handguard"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
end

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    weapon:SetGripPoseParameter("grip_vert_pro_offset")
end