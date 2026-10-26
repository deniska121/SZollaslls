-- "addons\\weapons\\lua\\weapons\\mwb_kar98\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.kilo98.fire.s")
	self.DistSound = "Reflection_AR.Sup.Distance"
	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_Sniper_Sup.Outside"),
				Reflection = Sound("Reflection_Sniper.Outside")
			},
			Inside = {
				Layer = Sound("Atmo_DMR_Sup.Inside"),
				Reflection = Sound("Reflection_Sniper.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

SWEP.Customization = {
	{"attachment_vm_sn_kilo98_barrel"},
	{"att_sight", "weapon_vm_scope_kilo98"},
}


