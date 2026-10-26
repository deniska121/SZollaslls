-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\papa220\\grips\\attachment_vm_pi_papa220_pistgriptac.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pistolgrip"
ATTACHMENT.Name = "Bruen RSH-80 Grip"
ATTACHMENT.Model = Model("models/kyo/att_vm_p27_pi_papa220_pstlgrp_tac_v0_LOD0.mdl")
ATTACHMENT.Icon = Material("models/kyo/icon/p220/icon_griptac.vmt")
ATTACHMENT.Bodygroups = {
    ["grip"] = 1
}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.9
    weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.9
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.93
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.93
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.93
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.93
end
