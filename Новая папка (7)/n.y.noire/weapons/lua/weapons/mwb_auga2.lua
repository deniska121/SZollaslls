--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_auga2.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mwb_aug"
SWEP.PrintName = "AUG A2"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Assault Rifles"

SWEP.Customization = {
	{"att_ammo","attachment_vm_sm_augolf_armag"},
	{"att_grip","attachment_vm_sm_augolf_vertgrip01"},
	{"attachment_vm_sm_augolf_arbarrel", "attachment_vm_sm_augolf_lmgbarrel", "attachment_vm_sm_augolf_smgbarrel"},
	{"att_muzzle", "att_vm_silencer01"},
	{"att_sight", "att_vm_minireddot01", "att_vm_reflex_east01", "att_vm_holo_east01", "att_vm_holo_west01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision", "att_vm_scope_vz"},
}

SWEP.ViewBoneOffsets = {
	{
		Bone = "tag_scope",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0.17)
	}
}

SWEP.WorldBoneOffsets = table.Copy(SWEP.ViewBoneOffsets)

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 3, 0.1)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Inspection = {
		Bone = "tag_sling",
		X = {
			[0] = {
				Pos = Vector(0, -2, 2),
				Angles = Angle(30, 0, -30)
			},
			[1] = {
				Pos = Vector(0, 2, 0),
				Angles = Angle(-10, 0, 0)
			}
		},
		Y = {
			[0] = {
				Pos = Vector(0, 0, -2),
				Angles = Angle(-10, 20, 0)
			},
			[1] = {
				Pos = Vector(3, 0, 5),
				Angles = Angle(10, -20, 0)
			}
		}
	},
	RecoilMultiplier = 0.25,
	KickMultiplier = 0.2,
	AimKickMultiplier = 0.75
}