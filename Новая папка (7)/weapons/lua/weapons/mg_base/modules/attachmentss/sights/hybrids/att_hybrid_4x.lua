-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\hybrids\\att_hybrid_4x.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_hybrid"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.93
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.93
    weapon.Zoom.ViewModelFovMultiplier = weapon.Zoom.ViewModelFovMultiplier * 1.2
    weapon.Zoom.FovMultiplier = 0.4
end