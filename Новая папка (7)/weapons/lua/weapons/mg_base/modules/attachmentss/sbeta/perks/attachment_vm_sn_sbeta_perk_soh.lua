-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sbeta\\perks\\attachment_vm_sn_sbeta_perk_soh.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_perk_soh"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

    weapon.Animations.Reload_Start.Fps = weapon.Animations.Reload_Start.Fps * 1.25
    weapon.Animations.Reload_Loop.Fps = weapon.Animations.Reload_Loop.Fps * 1.25
    weapon.Animations.Reload_End.Fps = weapon.Animations.Reload_End.Fps * 1.25
    weapon.Animations.Reload_End_Empty.Fps = weapon.Animations.Reload_End_Empty.Fps * 1.25
end