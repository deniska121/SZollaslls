-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\barrels\\590_eft_barrel_v4.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Name = "Спортивный ствол"
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/590_dqr/870_bg_5.mdl")
ATTACHMENT.Icon = Material("icon/bg5.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 6
	weapon.Bullet.Spread = 0.065
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.2
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.2
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
end