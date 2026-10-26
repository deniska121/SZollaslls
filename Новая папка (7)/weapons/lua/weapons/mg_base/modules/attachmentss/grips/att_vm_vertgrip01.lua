-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\grips\\att_vm_vertgrip01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_grip"
ATTACHMENT.Name = "Вертикальная рукоятка"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_vertgrip02_lod0.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/grips/icon_attachment_vertgrip02.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.98
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.98
    weapon.Recoil.Vertical[1] = self:ChangeRecoil(weapon.Recoil.Vertical[1], 0.95)
    weapon.Recoil.Vertical[2] = self:ChangeRecoil(weapon.Recoil.Vertical[2], 0.95)
    weapon.HoldType = "RifleWithVerticalGrip"
end