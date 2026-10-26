--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mike4/receiver/attachment_vm_ar_mike16_bolt.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_bolt"
ATTACHMENT.Name = "УСМ М16"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/perks/perk_icon_wounding.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	weapon.Primary.Automatic = false
	weapon.Primary.BurstRounds = 3
	weapon.Primary.BurstDelay = 0.3
	weapon.Primary.RPM = 1200
	weapon.Firemodes = {
		[1] = {
			Name = "3rnd Burst",
			OnSet = function() return "Firemode_Auto" end
		},
		[2] = {
			Name = "Semi Auto",
			OnSet = function(s)
				s.Primary.Automatic = false
				s.Primary.BurstRounds = 1
				return "Firemode_Semi"
			end
		},
	}

	if weapon:HasAttachment("attachment_vm_ar_mike4_barrel") then
		weapon.PrintName = "M16A1"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_mike203barrel") or weapon:HasAttachment("attachment_vm_ar_mike4_barsil") then
		weapon.PrintName = "M16A2"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_custombarrel") then
		weapon.PrintName = "M16A3"
		if weapon:HasAttachment("attachment_vm_ar_mike4_receiver") then
			weapon.PrintName = "M16A4"
		end
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_barrel_v2") then
		weapon.PrintName = "Colt M4 RIS"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_shortbarrel") then
		weapon.PrintName = "Mk 18 Mod 0"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_barrel_v3_alt") then
		weapon.PrintName = "XM177E2"
	else
		weapon.PrintName = "Colt M4"
	end
end