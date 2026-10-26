-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\stock\\magpul_sga_stock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Пластиковый приклад"
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

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.1
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.2
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 1.1
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.2
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.2
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.2
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.2
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.2
	weapon.Cone.Shake = weapon.Cone.Shake * 1.3
end

-- function ATTACHMENT:PostProcess(weapon)
-- 	BaseClass.PostProcess(self, weapon)
-- 	weapon:SetGripPoseParameter2("grip_stockh_offset")
-- end