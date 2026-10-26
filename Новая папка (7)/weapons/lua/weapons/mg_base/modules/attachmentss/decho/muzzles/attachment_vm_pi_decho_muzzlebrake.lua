-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\decho\\muzzles\\attachment_vm_pi_decho_muzzlebrake.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_muzzle"
ATTACHMENT.Name = "Дульный тормоз"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_decho_muzzlebrake.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/decho/icon_attachment_pi_decho_muzzlebrake.vmt")
ATTACHMENT.BonemergeToCategory = {"Стволы"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
    weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 0.85
end