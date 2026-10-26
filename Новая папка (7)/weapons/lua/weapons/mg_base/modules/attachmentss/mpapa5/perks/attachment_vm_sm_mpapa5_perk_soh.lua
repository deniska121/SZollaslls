-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\perks\\attachment_vm_sm_mpapa5_perk_soh.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_perk_soh"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Reload = weapon.Animations.Reload_Fast
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Fast                
    weapon.Animations.Reload_Xmag = weapon.Animations.Reload_Xmag_Fast
    weapon.Animations.Reload_Empty_Xmag = weapon.Animations.Reload_Empty_Xmag_Fast
    weapon.CanChamberRound = true
end