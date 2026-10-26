-- "addons\\weapons\\lua\\weapons\\mwb_tec9\\customization.lua"
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
	{"att_ammo", "attachment_vm_pi_tec9_mag"},
	{"att_bolt", "attachment_vm_pi_tec9_bolt"},
}