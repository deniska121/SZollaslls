--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/police_mk18.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mwb_m4a1"
SWEP.PrintName = "Mk18 Mod 1"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.IconOverride = "entities/mwb_m4a1.png"

SWEP.Customization = {
	{"att_ammo", "attachment_vm_ar_mike4_mag_v15", "attachment_vm_ar_mike4_xmags", "attachment_vm_ar_mike4_xmags2", "attachment_vm_ar_mike4_mag_v5", "attachment_vm_ar_mike4_mag", "attachment_vm_ar_mike4_mag_v27"},
	{"attachment_vm_ar_mike4_shortbarrel", "attachment_vm_ar_mike4_barrel_v2", "a", "attachment_vm_ar_mike4_barrel_v3_alt",  "attachment_vm_ar_mike4_barrel",  "attachment_vm_ar_mike4_barsil", "attachment_vm_ar_mike4_custombarrel", "attachment_vm_ar_mike4_mike203barrel",},
	{"attachment_vm_ar_mike4_stock", "2", "1", "3", "4"},
	{"attachment_vm_ar_mike4_receiver", "none2"},
	{"att_vm_silencer02", "s"},
	{"rail_mount2", "21"},
	{"att_vm_holo_west01", "att_vm_minireddot01", "11", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision", "att_vm_scope_vz"},
	{"attachment_vm_ar_mike4_laser03", "z"},
	{"att_grip", "attachment_vm_ar_mike4_angledgrip01", "attachment_vm_ar_mike4_stubbygrip01", "attachment_vm_ar_mike4_vertgrip01", "attachment_vm_ar_mike4_vertgrip03"},
	{"attachment_vm_ar_mike4_bolt", "attachment_vm_ar_mike16_bolt", "ss"},
}