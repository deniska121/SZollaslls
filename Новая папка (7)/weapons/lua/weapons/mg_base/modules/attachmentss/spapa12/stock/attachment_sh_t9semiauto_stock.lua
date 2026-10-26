-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\spapa12\\stock\\attachment_sh_t9semiauto_stock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Model = Model("models/zeron/attachment_vm_sh_t9semiauto_stock_LOD0.mdl")
ATTACHMENT.Name = "Сложенный приклад"
-- ATTACHMENT.ExcludedCategories = {"Sights"}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
ATTACHMENT.ExcludedAttachments = {"rail_mount"}

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	if (not weapon:HasAttachment("att_sight")) then
		weapon.Animations.Reload_Start = weapon.Animations.Reload_Start
		weapon.Animations.Reload_Loop = weapon.Animations.Reload_Loop
		weapon.Animations.Reload_End = weapon.Animations.Reload_End
		weapon.Animations.Reload_End_Empty = weapon.Animations.Reload_End_Empty
		weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 0.9
		weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 0.9
		weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.9
		weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.9
		weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
		weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
		weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
		weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	else
		weapon.Animations.Reload_Start = weapon.Animations.Reload_Start_Folded
		weapon.Animations.Reload_Loop = weapon.Animations.Reload_Loop_Folded
		weapon.Animations.Reload_End = weapon.Animations.Reload_End_Folded
		weapon.Animations.Reload_End_Empty = weapon.Animations.Reload_End_Empty_Folded
	end
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
end