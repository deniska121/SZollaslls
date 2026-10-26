-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\augolf\\grips\\attachment_vm_sm_augolf_vertgrip01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_vertgrip01"
ATTACHMENT.Name = "Разложенная рукоять"
ATTACHMENT.Model = Model("models/easy/cw/attachments/sm_t9powerburst/attachment_vm_sm_t9powerburst_grip_02.mdl")
ATTACHMENT.Icon = Material("easy/cw/attachments/icons/sm_t9powerburst/icon_attachment_sm_t9powerburst_grip_02.vmt")
ATTACHMENT.Bodygroups = {
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