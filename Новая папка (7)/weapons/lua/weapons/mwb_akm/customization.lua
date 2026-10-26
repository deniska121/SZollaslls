-- "addons\\weapons\\lua\\weapons\\mwb_akm\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.akilo47.fire.suppressed")
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

function SWEP:doSmgStats()
end


SWEP.Customization = {
	{"att_ammo", "attachment_vm_ar_akilo47_mag", "attachment_vm_ar_akilo47_mag_v2", "attachment_vm_ar_akilo47_xmags", "attachment_vm_ar_akilo47_xmags_v21", "attachment_vm_ar_akilo47_drum_mag"},
	{"attachment_vm_ar_akilo47_stock", "attachment_vm_ar_akilo47_lmgstock", "attachment_vm_ar_akilo47_smgstock_unfolded", "attachment_vm_ar_akilo47_smgstock", "attachment_vm_ar_akilo47_stockno"},
	{"attachment_vm_ar_akilo47_barrel", "attachment_vm_ar_akilo47_custombarrel", "attachment_vm_ar_akilo47_lmgbarrel_grip", "attachment_vm_ar_akilo47_lmgbarrel", "attachment_vm_ar_akilo47_smgbarcust"},
	{"att_bolt", "attachment_vm_ar_akilo47_bolt"},
	{"attachment_vm_ar_akilo47_receiver_v2"},
	{"att_muzzle", "att_vm_silencer05"},
	{"norail", "rail_mount_ak"},
	{"att_sight", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
	{"att_grip", "attachment_vm_ar_akilo47_angledgrip01", "attachment_vm_ar_akilo47_stubbygrip01", "attachment_vm_ar_akilo47_vertgrip01", "attachment_vm_ar_akilo47_vertgrip03"},
}
