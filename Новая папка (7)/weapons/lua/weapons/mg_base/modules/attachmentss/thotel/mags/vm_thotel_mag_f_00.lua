-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\thotel\\mags\\vm_thotel_mag_f_00.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = ".45 ACP 30 Rounds Fast Mags"
ATTACHMENT.Model = Model("models/easy/vg/attachments/thotel/vm_thotel_mag_f_00.mdl")
ATTACHMENT.Icon = Material("easy/vg/attachments/icons/thotel/thotel_mag_f_00_lod0.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    weapon:SetGripPoseParameter("grip_fmag_offset")
end

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Primary.ClipSize = 30
    weapon.Shell = "mwb_shelleject_45"
    weapon.Animations.Reload = weapon.Animations.Reload_Fast
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Fast
    weapon.Animations.Reload_Grip = weapon.Animations.Reload_Fast
    weapon.Animations.Reload_Empty_Grip = weapon.Animations.Reload_Empty_Fast
end