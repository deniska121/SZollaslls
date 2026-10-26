--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/golf17/slides/att_vm_pi_golf17_slide_light.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_vm_pi_golf21_slide"
ATTACHMENT.Name = "Удлиненная затворная рама"
ATTACHMENT.Model = Model("models/att/glock/glock17l_slide.mdl")
ATTACHMENT.UseJunk = "parts_all"
ATTACHMENT.ExcludedCategories = {"Дуло"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.9
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.9
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.25
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.35
	weapon.Bullet.Penetration.Thickness = weapon.Bullet.Penetration.Thickness * 1.1
	weapon.Bullet.Penetration.MaxCount = 4
	weapon.PrintName = "Glock 17L"
end

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_reargrip_golf") and mat == "glock_17" then return path, "glock_17silver" end
	return path, mat
end