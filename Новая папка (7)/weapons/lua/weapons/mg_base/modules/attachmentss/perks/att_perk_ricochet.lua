-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\perks\\att_perk_ricochet.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_perk"
ATTACHMENT.Name = "Ricochet"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/perks/perk_icon_ricochet.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    
    if (weapon.Bullet != nil) then
        weapon.Bullet.Ricochet = true
    end
end