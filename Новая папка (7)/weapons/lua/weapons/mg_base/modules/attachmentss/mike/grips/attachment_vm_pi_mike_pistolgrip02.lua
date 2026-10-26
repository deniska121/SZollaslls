-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike\\grips\\attachment_vm_pi_mike_pistolgrip02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pistolgrip"
ATTACHMENT.Name = "Облегчённая рукоять"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_pistolgrip02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_pistolgrip02.vmt")
ATTACHMENT.UseJunk = "parts_all"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.05
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.05
    weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 0.95
end