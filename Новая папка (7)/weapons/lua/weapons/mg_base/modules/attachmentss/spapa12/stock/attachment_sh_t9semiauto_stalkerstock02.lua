-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\spapa12\\stock\\attachment_sh_t9semiauto_stalkerstock02.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Тактический приклад"
ATTACHMENT.Model = Model("models/alias/weapons/attachments/attachment_vm_sh_t9semiauto_stalker_02_LOD0.mdl")
ATTACHMENT.Icon = Material("vgui/attachments/icons/sh_t9semiauto/icon_attachment_vm_sh_t9semiauto_stalker_02.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.8
    weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.8
    weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.8
    weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.8
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
    weapon.Animations.Reload_Start = weapon.Animations.Reload_Start
    weapon.Animations.Reload_Loop = weapon.Animations.Reload_Loop
    weapon.Animations.Reload_End = weapon.Animations.Reload_End
    weapon.Animations.Reload_End_Empty = weapon.Animations.Reload_End_Empty
end

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
end