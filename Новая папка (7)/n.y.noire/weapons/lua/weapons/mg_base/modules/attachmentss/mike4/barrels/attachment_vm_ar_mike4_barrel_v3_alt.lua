--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mike4/barrels/attachment_vm_ar_mike4_barrel_v3_alt.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол (115 мм)"
ATTACHMENT.Model = Model("models/att/m4/barrel_ar15_short.mdl")
ATTACHMENT.ExcludedCategories = {"ЛЦУ", "Рукоятки"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.AlternateGrips = true
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.13
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.13
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.3
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.3
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.8
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.65
end