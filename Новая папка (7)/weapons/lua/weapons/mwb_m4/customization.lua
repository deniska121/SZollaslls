-- "addons\\weapons\\lua\\weapons\\mwb_m4\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.mike4.fire.s")
	self.DistSound = "Reflection_AR.Sup.Distance"
	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_AR_Sup.Outside"),
				Reflection = Sound("Reflection_ARSUP.Outside")
			},
			Inside = {
				Layer = Sound("Atmo_AR_Sup.Inside"),
				Reflection = Sound("Reflection_ARSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

SWEP.Customization = {
	{"attachment_vm_ar_mike4_mag", "attachment_vm_ar_mike4_mag_v15", "attachment_vm_ar_mike4_xmags", "attachment_vm_ar_mike4_xmags2", "attachment_vm_ar_mike4_mag_v5", "attachment_vm_ar_mike4_mag_v27"},
	{"attachment_vm_ar_mike4_barrel_def", "attachment_vm_ar_mike4_barrel_v2", "attachment_vm_ar_mike4_shortbarrel", "attachment_vm_ar_mike4_barrel_v3_alt",  "attachment_vm_ar_mike4_barrel",  "attachment_vm_ar_mike4_barsil", "attachment_vm_ar_mike4_custombarrel", "attachment_vm_ar_mike4_mike203barrel",},
	{"attachment_vm_ar_mike4_stock_def", "attachment_vm_ar_mike4_stock_v2", "attachment_vm_ar_mike4_stock", "attachment_vm_ar_mike4_customstock", "attachment_vm_ar_mike4_stockno"},
	{"attachment_vm_ar_mike4_receiver_def", "attachment_vm_ar_mike4_receiver_black"},
	{"att_muzzle", "att_vm_silencer02"},
	{"norail", "rail_mount_ext"},
	{"att_sight", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
	{"att_laser", "attachment_vm_ar_mike4_laser03"},
	{"att_grip", "attachment_vm_ar_mike4_angledgrip01", "attachment_vm_ar_mike4_stubbygrip01", "attachment_vm_ar_mike4_vertgrip01", "attachment_vm_ar_mike4_vertgrip03"},
	{"ar15_bolt", "attachment_vm_ar_mike16_bolt", "attachment_vm_ar_mike4_bolt"},
}