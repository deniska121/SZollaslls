-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\thotel\\grips\\vm_thotel_fg_00.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_grip"
ATTACHMENT.Model = Model("models/easy/vg/attachments/thotel/vm_thotel_fg_00.mdl")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
end




