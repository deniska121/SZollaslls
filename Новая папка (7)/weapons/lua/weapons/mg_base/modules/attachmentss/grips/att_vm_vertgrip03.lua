-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\grips\\att_vm_vertgrip03.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_grip"
ATTACHMENT.Name = "Вертикальная рукоятка (макси)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_vertgrip_stubby02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/grips/icon_attachment_vertgrip_stubby02.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.94
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.94
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.94
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.94
    weapon.Recoil.Vertical[1] = self:ChangeRecoil(weapon.Recoil.Vertical[1], 0.9)
    weapon.Recoil.Vertical[2] = self:ChangeRecoil(weapon.Recoil.Vertical[2], 0.9)
    weapon.HoldType = "RifleWithVerticalGrip"
end