-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\uzulu\\barrels\\attachment_vm_sm_uzulu_barshort.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол (85 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/uzulu/attachment_vm_sm_uzulu_barshort.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/uzulu/icon_attachment_sm_uzulu_barshort.vmt")
ATTACHMENT.UseJunk = "parts_all"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
        weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
        weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.9
        weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.1
        weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1
        weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
        weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
end