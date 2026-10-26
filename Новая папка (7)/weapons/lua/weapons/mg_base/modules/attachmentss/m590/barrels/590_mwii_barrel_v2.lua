-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\barrels\\590_mwii_barrel_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Name = "Укороченный тактический ствол"
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/590_dqr/att_vm_p13_sh_mbravo_barlgtshort_v0_lod0.mdl")
ATTACHMENT.Icon = Material("icon/mwii_bs.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 5
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.45
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.45
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.15
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.15
	weapon.Bullet.Spread = 0.09

	if not weapon:HasAttachment("mwii_590_no_stock") then
		weapon.PrintName = "Mossberg 590 Riot"
	end
end