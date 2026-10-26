-- "addons\\weapons\\lua\\weapons\\mwb_pm\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("MW19_Makarov.Fire_S")

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
	{"att_ammo", "attachment_vm_pi_mike_mag", "attachment_vm_pi_mike_xmags", "attachment_vm_pi_mike_drummag"},
	{"att_stock", "attachment_vm_pi_mike_stockl", "attachment_vm_pi_mike_stockh"},
	{"attachment_vm_pi_mike_grip", "attachment_vm_pi_mike_pistolgrip01", "attachment_vm_pi_mike_pistolgrip02", "attachment_vm_pi_mike_pistolgrip03"},
	{"attachment_vm_pi_mike_barrel", "attachment_vm_pi_mike_barsil", "attachment_vm_pi_mike_barlight", "attachment_vm_pi_mike_barauto"},
}

-- attachment_vm_pi_mike_pistolgripppk  attachment_vm_pi_mike_barrelppk
