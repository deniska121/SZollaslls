-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sbeta\\perks\\attachment_vm_sn_sbeta_perk_bolt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_perk_bolt"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Reload_End_Empty.Fps = weapon.Animations.Reload_End_Empty.Fps * 1.5
end 