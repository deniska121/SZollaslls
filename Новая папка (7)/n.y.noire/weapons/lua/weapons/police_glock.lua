--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/police_glock.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "mwb_glock17"
SWEP.PrintName = "Glock 17"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.IconOverride = "entities/mwb_glock17.png"

SWEP.Customization = {
	{"att_ammo", "att_vm_pi_golf17_mag", "att_vm_pi_golf17_mag_xmags", "att_vm_pi_golf17_mag_xmagslrg"},
	{"att_vm_pi_golf17_slide", "none2", "att_vm_pi_golf17_slide_light"},
	{"att_laser", "att_vm_laser01_pstl", "att_vm_laser03_pstl"},
	{"att_vm_pi_golf17def"},
	{"att_miscellaneous", "att_reargrip_golf"},
	{"att_muzzle", "att_vm_silencer04_pstl"},
}