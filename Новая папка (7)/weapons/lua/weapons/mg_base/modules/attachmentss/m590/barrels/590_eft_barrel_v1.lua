-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\barrels\\590_eft_barrel_v1.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол"
ATTACHMENT.Model = Model("models/590_dqr/590_bg_2.mdl")
ATTACHMENT.Icon = Material("icon/bg2.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 5
	weapon.Bullet.Spread = 0.1
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.5
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.5
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.2
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.2
end