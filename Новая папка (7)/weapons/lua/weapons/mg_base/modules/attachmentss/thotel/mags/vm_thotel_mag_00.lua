-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\thotel\\mags\\vm_thotel_mag_00.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Model = Model("models/easy/vg/attachments/thotel/vm_thotel_mag_00.mdl")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
end

ATTACHMENT.BoneHine = {
	"j_mag2",
}