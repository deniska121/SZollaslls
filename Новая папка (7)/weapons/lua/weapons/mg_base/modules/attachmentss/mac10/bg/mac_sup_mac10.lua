-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mac10\\bg\\mac_sup_mac10.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel_mac10"
ATTACHMENT.Name = "Заводской глушитель"
ATTACHMENT.Model = Model("models/mac_10_sup.mdl")
ATTACHMENT.Icon = Material("icon/mac_sil.vmt")

ATTACHMENT.VElement = {
	Bone = "tag_silencer",
	Position = Vector(0, -5.545, 0.135),
	Angles = Angle(0, 0, 0),
	Offsets = {}
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.DistSound = ""
	weapon:doSuppressorStats()
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.8
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.8
	weapon.Bullet.Range = weapon.Bullet.Range * 1.1
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.8
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.65
	weapon.Resource = weapon.Resource * 2.2
end