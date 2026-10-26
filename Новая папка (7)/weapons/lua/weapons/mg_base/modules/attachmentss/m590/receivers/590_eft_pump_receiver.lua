-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\receivers\\590_eft_pump_receiver.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Default"
ATTACHMENT.Model = Model("models/590_dqr/weapon_mossberg_590a1_12g_lod0.mdl")

ATTACHMENT.AttachmentBodygroups = {
	["tag_psg"] = 1,
	["tag_stock"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	--weapon:SetGripPoseParameter("grip_front_offset")
	weapon:SetGripPoseParameter2("grip_stockh_offset")
end