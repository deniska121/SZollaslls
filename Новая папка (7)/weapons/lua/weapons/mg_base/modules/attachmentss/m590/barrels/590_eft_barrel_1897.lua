-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\barrels\\590_eft_barrel_1897.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Антикварный ствол"
ATTACHMENT.Model = Model("models/590_dqr/590_bg_1897.mdl")
ATTACHMENT.Icon = Material("icon/1897.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 6
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.1
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1

	if not weapon:HasAttachment("mwii_590_no_stock") then
		weapon.PrintName = "Mossberg 500"
	end
end