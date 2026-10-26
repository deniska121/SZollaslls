-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\psg\\590_f1.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Training"
ATTACHMENT.Model = Model("models/590_dqr/stock_590_magpul_sga_lod0.mdl")
ATTACHMENT.Icon = Material("icon/sga.vmt")

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
-- 	weapon:SetGripPoseParameter2("grip_stockh_offset")
-- end

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "stock_590_magpul_sga_lod0" then return "m590_dqr/", "stock_590_magpul_sga_lod0_green" end

	return path, mat
end