-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\cpapa\\barrels\\att_vm_pi_cpapa_barrel_long.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_cpapa_barrel_long.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/cpapa/icon_attachment_pi_cpapa_barrel_long.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    
    weapon.Cone.Hip =  weapon.Cone.Hip * 0.9
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
    weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.08
    weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.08
end