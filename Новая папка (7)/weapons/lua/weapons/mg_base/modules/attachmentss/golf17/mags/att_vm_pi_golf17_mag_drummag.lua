-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\golf17\\mags\\att_vm_pi_golf17_mag_drummag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "50 Round Mags"
ATTACHMENT.Model = Model("models/kyo/attachment_vm_pi_golf17_drummag.mdl")
ATTACHMENT.Icon = Material("models/kyo/icon/golf/icon_golf_drummag.vmt")

ATTACHMENT.BulletList = {
    [1] = {"j_ammo_01"},
    [2] = {"j_ammo_02"},
    [3] = {"j_ammo_03"},
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Primary.ClipSize = 50
    weapon.Animations.Reload = weapon.Animations.Reload_Drummag
    weapon.Animations.Inspect = weapon.Animations.Inspect_drum
    weapon.Animations.Inspect_empty = weapon.Animations.Inspect_empty_drum
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Drummag
    weapon.Animations.Reload_Fast = weapon.Animations.Reload_Drummag_Fast
    weapon.Animations.Reload_Empty_Fast = weapon.Animations.Reload_Empty_Drummag_Fast
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.87
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.87
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.82
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.82
    weapon.Animations.Reload.Fps = weapon.Animations.Reload.Fps * 0.87
    weapon.Animations.Reload_Empty.Fps = weapon.Animations.Reload_Empty.Fps * 0.87
    weapon.DontHide = true
end