-- "addons\\weapons\\lua\\weapons\\police_mk20.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mwb_mk17"
SWEP.PrintName = "FN SSR"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 450
SWEP.IconOverride = "entities/mwb_mk17.png"

SWEP.Firemodes = {
	[1] = {
		Name = "Semi Auto",
		OnSet = function() return "Firemode_Semi" end
	}
}

SWEP.Customization = {
	{"att_ammo", "attachment_vm_ar_scharlie_mag", "attachment_vm_ar_scharlie_mag_dmr", "attachment_vm_ar_scharlie_mag_v18", "attachment_vm_ar_scharlie_mmags", "attachment_vm_ar_scharlie_xmags"},
	{"attachment_vm_ar_scharlie_barrel_long", "attachment_vm_ar_scharlie_barrel_pdw", "attachment_vm_ar_scharlie_barrel_mid", "a2"},
	{"attachment_vm_ar_scharlie_stock_dmr", "attachment_vm_ar_scharlie_stock_light", "a"},
	{"att_muzzle","att_vm_silencer01"},
	{"rail_mount3", "a"},
	{"att_vm_scope_vz", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision", "aa"},
	{"att_laser", "attachment_vm_ar_scharlie_laser03"},
	{"att_grip", "attachment_vm_ar_scharlie_angledgrip01", "attachment_vm_ar_scharlie_stubbygrip01", "attachment_vm_ar_scharlie_vertgrip01", "attachment_vm_ar_scharlie_vertgrip03"},
	{"att_bolt", "attachment_vm_ar_akilo47_bolt"},
}

SWEP.Bullet = {
	Damage = {80, 45}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	DropOffStartRange = 150, --in meters, damage will start dropping off after this range
	EffectiveRange = 300, --in meters, damage scales within this distance
	Range = 600, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.98, --how much damaged is multipled by when leaving a surface.
		MaxCount = 5, --how many times the bullet can penetrate.
		Thickness = 31, --in hu, how thick an obstacle has to be to stop the bullet.
	}
}