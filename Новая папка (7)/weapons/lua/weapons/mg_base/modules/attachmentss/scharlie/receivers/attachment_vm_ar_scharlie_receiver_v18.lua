-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\scharlie\\receivers\\attachment_vm_ar_scharlie_receiver_v18.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Гадюка"

ATTACHMENT.CosmeticChange = true
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_receiver_v18.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/scharlie/icon_attachment_ar_scharlie_receiver.vmt")
ATTACHMENT.Bodygroups = {
    ["receiver"] = 1
}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    -- weapon.Animations.Reload = weapon.Animations.Reload_Railcrust
    -- weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Railcrust
    -- weapon.Animations.Reload_Fast = weapon.Animations.Reload_Fast_Railcrust
    -- weapon.Animations.Reload_Empty_Fast = weapon.Animations.Reload_Empty_Fast_Railcrust
    -- weapon.Animations.Equip = weapon.Animations.Equip_Railcrust
    -- weapon.ViewModelOffsets.Aim.Pos = weapon.ViewModelOffsets.Aim.Pos + Vector(0, 0, 1.65)
    -- weapon.ViewModelOffsets.Aim.Angles = weapon.ViewModelOffsets.Aim.Angles + Angle(0, 0, 0)
end