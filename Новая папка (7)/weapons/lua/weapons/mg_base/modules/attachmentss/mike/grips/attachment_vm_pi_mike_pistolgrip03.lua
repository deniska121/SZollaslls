-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike\\grips\\attachment_vm_pi_mike_pistolgrip03.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pistolgrip"
ATTACHMENT.Name = "Резиновая рукоять"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_pistolgrip03.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_pistolgrip03.vmt")
ATTACHMENT.UseJunk = "parts_all"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
    weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 0.9
end