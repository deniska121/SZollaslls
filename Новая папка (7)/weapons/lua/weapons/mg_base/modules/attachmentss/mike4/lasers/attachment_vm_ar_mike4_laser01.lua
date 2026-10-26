-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\lasers\\attachment_vm_ar_mike4_laser01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_laser01"
ATTACHMENT.AttachmentBodygroups ={
    ["tag_laser_hide"] = 1
}


ATTACHMENT.BonemergeToCategory = {"Стволы"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
        weapon.LaserAimAngles = Angle(-0.3, 0.05, -45)
        weapon.LaserAimPos = Vector(-2, 0, 0)
end 