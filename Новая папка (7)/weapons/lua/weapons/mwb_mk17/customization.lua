-- "addons\\weapons\\lua\\weapons\\mwb_mk17\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.scharlie.fire.s")
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
	{"att_ammo", "attachment_vm_ar_scharlie_mag", "attachment_vm_ar_scharlie_mag_dmr", "attachment_vm_ar_scharlie_mag_v18", "attachment_vm_ar_scharlie_mmags", "attachment_vm_ar_scharlie_xmags"},
	{"attachment_vm_ar_scharlie_barrel", "attachment_vm_ar_scharlie_barrel_pdw", "attachment_vm_ar_scharlie_barrel_mid", "attachment_vm_ar_scharlie_barrel_long"},
	{"attachment_vm_ar_scharlie_stock", "attachment_vm_ar_scharlie_stock_light", "attachment_vm_ar_scharlie_stock_dmr"},
	{"att_muzzle","att_vm_silencer01"},
	{"norail", "rail_mount3"},
	{"att_sight", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision", "att_vm_scope_vz"},
	{"att_laser", "attachment_vm_ar_scharlie_laser03"},
	{"att_grip", "attachment_vm_ar_scharlie_angledgrip01", "attachment_vm_ar_scharlie_stubbygrip01", "attachment_vm_ar_scharlie_vertgrip01", "attachment_vm_ar_scharlie_vertgrip03"},
	{"att_bolt", "attachment_vm_ar_akilo47_bolt"},
}