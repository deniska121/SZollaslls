-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\reticles\\att_sight_1x.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_sight_reticle"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Zoom.ViewModelFovMultiplier = weapon.Zoom.ViewModelFovMultiplier * 0.8
    weapon.Zoom.FovMultiplier = 0.9
    weapon.ViewModelOffsets.Aim.Pos = weapon.ViewModelOffsets.Aim.Pos + Vector(0, 5, 0)
end