-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\barrels\\590_mwii_barrel_v1.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Name = "Увеличенный нарезной ствол"
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/590_dqr/att_vm_p13_sh_mbravo_barlong_v0_lod0.mdl")
ATTACHMENT.Icon = Material("icon/mwii_bl.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 5
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.8
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.8
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.82
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.82
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.8
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.8
	weapon.Bullet.Spread = 0.045
	weapon.Bullet.EffectiveRange = 25
end