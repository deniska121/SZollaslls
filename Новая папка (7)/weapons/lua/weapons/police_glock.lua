-- "addons\\weapons\\lua\\weapons\\police_glock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mwb_glock17"
SWEP.PrintName = "Glock 17"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.IconOverride = "entities/mwb_glock17.png"

SWEP.Customization = {
	{"att_vm_pi_golf17_mag", "att_vm_pi_golf17_mag_xmags", "att_vm_pi_golf17_mag_xmagslrg"},
	{"att_vm_pi_golf17_slide", "none2", "att_vm_pi_golf17_slide_light"},
	{"att_vm_laser01_pstl", "none1", "att_vm_laser03_pstl"},
	{"att_vm_pi_golf17def"},
	{"att_miscellaneous", "att_reargrip_golf"},
	{"att_muzzle", "att_vm_silencer04_pstl"},
}