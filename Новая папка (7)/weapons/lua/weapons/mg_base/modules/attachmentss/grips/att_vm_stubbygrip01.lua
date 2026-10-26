-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\grips\\att_vm_stubbygrip01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_grip"
ATTACHMENT.Name = "Вертикальная рукоятка (мини)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_vertgrip_stubby01.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/grips/icon_attachment_vertgrip_stubby01.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

    weapon.Recoil.Horizontal[1] = self:ChangeRecoil(weapon.Recoil.Horizontal[1], 0.9)
    weapon.Recoil.Horizontal[2] = self:ChangeRecoil(weapon.Recoil.Horizontal[2], 0.9)
    weapon.HoldType = "RifleWithVerticalGrip"
end