-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\stock\\m500_stock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "M500 Wood Stock"
ATTACHMENT.Model = Model("models/590_dqr/stock_m500s.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_stock_wood.vmt")

ATTACHMENT.AttachmentBodygroups = {
	["tag_psg"] = 1,
	["tag_stock"] = 1
}

ATTACHMENT.VElement = {
	Bone = "tag_sling",
	Position = Vector(0, 0, 0),
	Angles = Angle(0, 0, 0),
	Offsets = {}
}

-- local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

-- function ATTACHMENT:PostProcess(weapon)
-- 	BaseClass.PostProcess(self, weapon)
-- 	weapon:SetGripPoseParameter2("grip_back_offset")
-- end