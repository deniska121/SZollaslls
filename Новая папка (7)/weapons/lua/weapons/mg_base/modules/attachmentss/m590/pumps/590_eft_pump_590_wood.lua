-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\pumps\\590_eft_pump_590_wood.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pump"
ATTACHMENT.Name = "Деревянное цевьё"
ATTACHMENT.Model = Model("models/590_dqr/weapon_mossberg_590a1_12g_bolt_lod0_wood.mdl")
ATTACHMENT.Icon = Material("icon/wood_pp.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.RPM = 260
	weapon.Cone.Ads = 0.6
	weapon.Recoil.Punch = 0.7
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.8
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.8
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.8
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.8
end