--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/police_mp5.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "mwb_mp5"
SWEP.PrintName = "MP5"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.IconOverride = "entities/mwb_mp5.png"

SWEP.Customization = {
	{"att_ammo", "attachment_vm_sm_mpapa5_mag", "attachment_vm_sm_mpapa5_mag_xmag"},
	{"attachment_vm_sm_mpapa5_stock", "attachment_vm_sm_mpapa5_stock_fullstock", "attachment_vm_sm_mpapa5_stock_nostock"},
	{"attachment_vm_sm_mpapa5_receiver_v2", "attachment_vm_sm_mpapa5_receiver"},
	{"norail", "rail_mount_mp5"},
	{"attachment_vm_sm_mpapa5_barrel", "attachment_vm_sm_mpapa5_barrel_suppressor"},
	{"att_sight", "att_vm_minireddot01",  "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
}
