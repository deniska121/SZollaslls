-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\spapa12\\stock\\attachment_sh_t9semiauto_nostock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Без приклада"
ATTACHMENT.Model = Model("models/alias/weapons/attachments/attachment_vm_sh_t9semiauto_nostock_LOD0.mdl")
ATTACHMENT.Icon = Material("vgui/attachments/icons/sh_t9semiauto/icon_attachment_sh_t9semiauto_nostock.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Recoil.AdsMultiplier = 1
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.26
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.26
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.26
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.26
	weapon.Animations.Reload_Start = weapon.Animations.Reload_Start
	weapon.Animations.Reload_Loop = weapon.Animations.Reload_Loop
	weapon.Animations.Reload_End = weapon.Animations.Reload_End
	weapon.Animations.Reload_End_Empty = weapon.Animations.Reload_End_Empty
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
end