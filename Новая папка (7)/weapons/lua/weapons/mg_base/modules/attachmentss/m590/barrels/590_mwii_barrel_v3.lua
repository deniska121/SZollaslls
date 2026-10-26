-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\barrels\\590_mwii_barrel_v3.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Name = "Тактический ствол"
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/590_dqr/att_vm_p13_sh_mbravo_barhvylong02_v0_lod0.mdl")
ATTACHMENT.Icon = Material("icon/mwii_hl.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 6
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.9
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.9
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.05
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.05
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.05
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.05
	weapon.Bullet.Spread = 0.071
end