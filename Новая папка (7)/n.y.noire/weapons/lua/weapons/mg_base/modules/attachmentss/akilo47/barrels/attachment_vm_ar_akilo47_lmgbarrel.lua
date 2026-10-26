--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/akilo47/barrels/attachment_vm_ar_akilo47_lmgbarrel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Ствол РПК (230 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_ar_akilo47_lmgbarrel.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_lmgbarrel_akilo47.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

ATTACHMENT.ExcludedCategories = {"Рукоятки"}

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.06
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.06
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.91
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.91
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.91
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.91

	if weapon.ak74 then
		weapon.PrintName = "РПК-74"
	else
		weapon.PrintName = "РПК"
	end
end