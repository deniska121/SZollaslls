-- "addons\\weapons\\lua\\weapons\\mwb_marlin\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.sbeta.fire.s")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_DMR_Sup.Outside"),
				Reflection = Sound("Reflection_Sniper.Outside")
			},
			Inside = {
				Layer = Sound("Atmo_DMR_Sup.Inside"),
				Reflection = Sound("Reflection_ShotgunSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

SWEP.Customization = {
	{"att_stock", "attachment_vm_sn_sbeta_stock_light", "attachment_vm_sn_sbeta_stock_stable"},
	{"attachment_vm_sn_sbeta_barrel", "attachment_vm_sn_sbeta_barshort", "attachment_vm_sn_sbeta_barmid", "attachment_vm_sn_sbeta_barlong"},
	{"norail", "rail_mount3"},
	{"att_sight", "att_vm_2x_west02_holo", "att_vm_2x_west02", "att_vm_reflex_02", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision", "att_vm_scope_vz"},
}