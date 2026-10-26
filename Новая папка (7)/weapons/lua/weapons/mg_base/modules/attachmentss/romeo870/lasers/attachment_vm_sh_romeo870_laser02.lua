-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\lasers\\attachment_vm_sh_romeo870_laser02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_vm_laser02_cylinder"
ATTACHMENT.AttachmentBodygroups ={
    ["laser"] = 1
}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
        weapon.LaserAimAngles = Angle(-0.3, 0.05, -45)
        weapon.LaserAimPos = Vector(-2, 0, 0)
end 