--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_m4a1.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mwb_m4"
SWEP.PrintName = "Colt M4A1"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Assault Rifles"

SWEP.ViewBoneOffsets = {
	{
		Bone = "tag_holo",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	{
		Bone = "tag_reflex",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	{
		Bone = "tag_acog_2",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
}

SWEP.WorldBoneOffsets = table.Copy(SWEP.ViewBoneOffsets)

SWEP.Customization = {
	{"att_ammo", "attachment_vm_ar_mike4_mag_v15", "attachment_vm_ar_mike4_xmags", "attachment_vm_ar_mike4_xmags2", "attachment_vm_ar_mike4_mag_v5", "attachment_vm_ar_mike4_mag", "attachment_vm_ar_mike4_mag_v27"},
	{"attachment_vm_ar_mike4_barrel_def", "attachment_vm_ar_mike4_barrel_v2", "attachment_vm_ar_mike4_shortbarrel", "attachment_vm_ar_mike4_barrel_v3_alt",  "attachment_vm_ar_mike4_barrel",  "attachment_vm_ar_mike4_barsil", "attachment_vm_ar_mike4_custombarrel", "attachment_vm_ar_mike4_mike203barrel",},
	{"attachment_vm_ar_mike4_stock_def", "attachment_vm_ar_mike4_stock_v2", "attachment_vm_ar_mike4_stock", "attachment_vm_ar_mike4_customstock", "attachment_vm_ar_mike4_stockno"},
	{"attachment_vm_ar_mike4_receiver", "none2"},
	{"att_muzzle", "att_vm_silencer02"},
	{"norail", "rail_mount2"},
	{"att_sight", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision", "att_vm_scope_vz"},
	{"att_laser", "attachment_vm_ar_mike4_laser03"},
	{"att_grip", "attachment_vm_ar_mike4_angledgrip01", "attachment_vm_ar_mike4_stubbygrip01", "attachment_vm_ar_mike4_vertgrip01", "attachment_vm_ar_mike4_vertgrip03"},
	{"ar15_bolt", "attachment_vm_ar_mike16_bolt", "attachment_vm_ar_mike4_bolt"},
}