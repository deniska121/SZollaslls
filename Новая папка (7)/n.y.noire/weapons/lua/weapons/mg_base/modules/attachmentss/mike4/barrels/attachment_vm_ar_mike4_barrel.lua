--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mike4/barrels/attachment_vm_ar_mike4_barrel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол A1"
ATTACHMENT.Model = Model("models/att/m4/barrel_m16a1.mdl")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
ATTACHMENT.ExcludedCategories = {"ЛЦУ", "Рукоятки"}

ATTACHMENT.AttachmentBodygroups = {
	["ris"] = 1,
	["tag_grip_hide"] = 1,
	["tag_laser_hide"] = 1,
}

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.95
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.95
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.1
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.1
	weapon.Resource = weapon.Resource * 2
end