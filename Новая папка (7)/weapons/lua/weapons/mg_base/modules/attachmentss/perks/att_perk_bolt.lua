-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\perks\\att_perk_bolt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_perk"
ATTACHMENT.Name = "Bolthead"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/perks/perk_icon_bolt.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    
    if (weapon.Animations.Rechamber != nil) then
        weapon.Animations.Rechamber.Fps = weapon.Animations.Rechamber.Fps * 1.5
    end
end