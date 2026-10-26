-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike\\grips\\attachment_vm_pi_mike_pistolgrip01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pistolgrip"
ATTACHMENT.Name = "Утяжелённая рукоять"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_pistolgrip01.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_pistolgrip01.vmt")
ATTACHMENT.UseJunk = "parts_all"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
    weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.9
    weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.9
end