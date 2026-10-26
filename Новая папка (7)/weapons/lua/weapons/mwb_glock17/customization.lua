-- "addons\\weapons\\lua\\weapons\\mwb_glock17\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("weap_golf21_sup_plr")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("weap_smg_sup_fire_plr_atmo_ext2"),
				Reflection = Sound("Reflection_ARSUP.Outside")
			},
			Inside = {
				Layer = Sound("weap_pistol_sup_fire_plr_atmo_int1"),
				Reflection = Sound("Reflection_ARSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

SWEP.Customization = {
	{"att_ammo", "att_vm_pi_golf17_mag", "att_vm_pi_golf17_mag_xmags", "att_vm_pi_golf17_mag_xmagslrg"},
	{"att_vm_pi_romeo18_slide", "att_vm_pi_golf17_slide", "att_vm_pi_golf17_slide_light"},
	{"att_laser", "att_vm_laser01_pstl", "att_vm_laser03_pstl"},
	{"att_vm_pi_golf17def"},
	{"att_miscellaneous", "att_reargrip_golf"},
	{"att_muzzle", "att_vm_silencer04_pstl"},
}