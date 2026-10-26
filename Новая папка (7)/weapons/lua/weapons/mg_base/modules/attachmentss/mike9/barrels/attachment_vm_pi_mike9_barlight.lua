-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike9\\barrels\\attachment_vm_pi_mike9_barlight.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Модифицированный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike9_barlight.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike9/icon_attachment_pi_mike9_barlight.vmt")

ATTACHMENT.ExcludedCategories = {"Дуло"}
ATTACHMENT.UseJunk = "parts_all"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
    weapon.Cone.Increase = weapon.Cone.Increase * 0.5
    weapon.Cone.Hip = weapon.Cone.Hip * 0.5
end