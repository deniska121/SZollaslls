--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/m590/pumps/590_eft_pump_590def.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_pump"
ATTACHMENT.Name = "Пластиковое цевьё"
ATTACHMENT.Model = Model("models/590_dqr/weapon_mossberg_590a1_12g_bolt_lod0_def.mdl")
ATTACHMENT.Icon = Material("icon/mwii_wpp.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.RPM = 260
	weapon.Cone.Ads = 1.2
	weapon.Recoil.Punch = 1.3
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.1
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.1
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 1.1
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.1
end