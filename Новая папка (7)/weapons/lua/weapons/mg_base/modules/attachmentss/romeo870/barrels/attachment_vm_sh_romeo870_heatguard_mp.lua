-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\barrels\\attachment_vm_sh_romeo870_heatguard_mp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Радиаторный ствол (180 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/romeo870/attachment_vm_sh_romeo870_heatguard_mp.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_heatguard.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Cone.Hip =  weapon.Cone.Hip * 1.2
    weapon.Cone.Ads =  weapon.Cone.Ads * 1.2
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.07
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.07
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
end