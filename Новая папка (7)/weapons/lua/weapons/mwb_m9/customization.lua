-- "addons\\weapons\\lua\\weapons\\mwb_m9\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("MW19_M1911.Fire_S")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_Pistol_Mag_Sup.Outside"),
				Reflection = Sound("Reflection_ARSUP.Outside")
			},
			Inside = {
				Layer = Sound("Atmo_Pistol_Sup.Inside"),
				Reflection = Sound("Reflection_ARSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

SWEP.Customization = {
	{"att_ammo", "attachment_vm_pi_mike9_mag", "attachment_vm_pi_mike9_mag_diamatti"},
	{"attachment_vm_pi_mike9_receiver_v2",},
	{"attachment_vm_pi_mike9_pgrip", "attachment_vm_pi_mike9_pstlgrpcust"},
	{"attachment_vm_pi_mike9_barrel", "attachment_vm_pi_mike9_barlong", "attachment_vm_pi_mike9_barrel_black", "attachment_vm_pi_mike9_barauto"},
	{"att_muzzle", "att_vm_silencer04_pstl"},
}
