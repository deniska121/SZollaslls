-- "addons\\weapons\\lua\\weapons\\mwb_ak74u.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mwb_ak74"
SWEP.PrintName = "АКС74У"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Assault Rifles"
SWEP.Primary.RPM = 1000
SWEP.Bullet = {
	Damage = {55, 20},
	DropOffStartRange = 45,
	EffectiveRange = 80,
	Range = 150,
	Tracer = false,
	NumBullets = 1,
	PhysicsMultiplier = 1,
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.6,
		MaxCount = 3,
		Thickness = 12,
	}
}

SWEP.Primary.Sound = Sound("mw19.akilo47.smgcal2.fire")

SWEP.Customization = {
	{"att_ammo", "attachment_vm_ar_akilo47_smgmag", "att_vm_45rnd_mag_eastern"},
	{"attachment_vm_ar_akilo47_smgstock_unfolded", "attachment_vm_ar_akilo47_smgstock", "null", "null", "attachment_vm_ar_akilo47_stockno"},
	{"attachment_vm_ar_akilo47_smgbarrel", "a5", "a4", "a3", "a2", "a1"},
	{"att_bolt", "attachment_vm_ar_akilo47_bolt"},
	{"attachment_vm_ar_akilo47_receiver_v21"},
	{"att_muzzle", "null1",},
	{"norail", "rail_mount_ak"},
	{"att_sight", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
	{"att_grip", "v1", "v2", "v3", "v4"},
}