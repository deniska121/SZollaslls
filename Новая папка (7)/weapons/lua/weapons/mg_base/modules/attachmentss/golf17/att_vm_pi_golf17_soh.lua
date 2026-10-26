-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\att_vm_pi_golf17_soh.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_perk_soh"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Fast
    weapon.Animations.Reload_XmagLrg = weapon.Animations.Reload_XmagLrg_Fast
    weapon.Animations.Reload_Empty_XmagLrg = weapon.Animations.Reload_Empty_XmagLrg_Fast
    weapon.Animations.Reload_Xmag = weapon.Animations.Reload_Xmag_Fast
    weapon.Animations.Reload_Empty_Xmag = weapon.Animations.Reload_Empty_Xmag_Fast
    weapon.Animations.Reload = weapon.Animations.Reload_Fast
    weapon.Animations.Reload_Drummag = weapon.Animations.Reload_Drummag_Fast
    weapon.Animations.Reload_Empty_Drummag = weapon.Animations.Reload_Empty_Drummag_Fast
end