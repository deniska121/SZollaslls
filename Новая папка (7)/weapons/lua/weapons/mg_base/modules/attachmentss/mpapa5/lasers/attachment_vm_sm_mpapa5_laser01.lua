-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\lasers\\attachment_vm_sm_mpapa5_laser01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_laser01_cylinder"
ATTACHMENT.AttachmentBodygroups ={
    ["tag_laser"] = 1,
    ["tag_rail"] = 1
}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.LaserAimAngles = Angle(-0.3, 0.05, -45)
    weapon.LaserAimPos = Vector(-2, 0, 0)
end 