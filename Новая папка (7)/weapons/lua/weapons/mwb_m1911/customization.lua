-- "addons\\weapons\\lua\\weapons\\mwb_m1911\\customization.lua"
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
	{"att_ammo", "attachment_vm_pi_mike1911_v1_mag", "sw4506_mag"},
	{"attachment_vm_pi_mike1911_v21_receiver", "sw4506_receiver"},
	{"attachment_vm_pi_mike1911_v1_slide", "sw4506_slide"},
	{"att_muzzle", "att_vm_silencer02_pstl"},
}