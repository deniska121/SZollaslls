--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/golf17/slides/att_vm_pi_golf18_slide.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/att/glock/glock18c_slide.mdl")
ATTACHMENT.Name = "Автоматический ствол"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Firemodes[1].Name = "Full Auto"
	weapon.Primary.Automatic = true
	weapon.Primary.RPM = 1200
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.9
	weapon.Bullet.Penetration.Thickness = weapon.Bullet.Penetration.Thickness * 0.7
	weapon.Bullet.Penetration.MaxCount = 2
	weapon.PrintName = "Glock 18C"

	weapon.Firemodes = {
		[1] = {
			Name = "Full Auto",
			OnSet = function() return "Firemode_Auto" end
		},
		[2] = {
			Name = "Semi Auto",
			OnSet = function(s)
				s.Primary.Automatic = false
				return "Firemode_Semi"
			end
		},
	}
end

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_reargrip_golf") and mat == "glock_17" then return path, "glock_17silver" end
	return path, mat
end