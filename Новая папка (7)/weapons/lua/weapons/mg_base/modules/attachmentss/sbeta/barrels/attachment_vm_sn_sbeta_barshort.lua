-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sbeta\\barrels\\attachment_vm_sn_sbeta_barshort.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол (457 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/sbeta/attachment_vm_sn_sbeta_barshort.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/sbeta/icon_attachment_sn_sbeta_barshort.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Cone.Hip = weapon.Cone.Hip * 0.8
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.1
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.1
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.95
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.95
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.96
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.96
end