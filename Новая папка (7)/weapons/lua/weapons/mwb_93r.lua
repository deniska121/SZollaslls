-- "addons\\weapons\\lua\\weapons\\mwb_93r.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mwb_m9"
SWEP.PrintName = "Beretta 93R"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Pistols"
SWEP.NoUserAttachs = true

SWEP.Customization = {
	{"att_ammo", "attachment_vm_pi_mike9_mag", "attachment_vm_pi_mike9_mag_diamatti"},
	{"attachment_vm_pi_mike9_receiver_diamatti", "null"},
	{"attachment_vm_pi_mike9_pstlgrpcust_diamatti", "null", "null1"},
	{"attachment_vm_pi_mike9_barauto_diamatti", "null"},
	{"att_muzzle", "null"},
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(-1.2, 0, 0),
		Pos = Vector(0.01, 0, -0.294)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Inspection = {
		Bone = "tag_pistol_offset",
		X = {
			[0] = {
				Pos = Vector(0, 2, -2),
				Angles = Angle(30, 0, -30)
			},
			[1] = {
				Pos = Vector(0, 0, 0),
				Angles = Angle(0, 0, 0)
			}
		},
		Y = {
			[0] = {
				Pos = Vector(2, 0, 0),
				Angles = Angle(-30, -30, 0)
			},
			[1] = {
				Pos = Vector(-4, 0, 0),
				Angles = Angle(0, 30, 0)
			}
		}
	},
	RecoilMultiplier = 1,
	KickMultiplier = 1
}