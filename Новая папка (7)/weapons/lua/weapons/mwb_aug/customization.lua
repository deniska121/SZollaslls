-- "addons\\weapons\\lua\\weapons\\mwb_aug\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.augolf.fire.s")
	self.DistSound = "Reflection_AR.Sup.Distance"
	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_SMG_Sup.Outside"),
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
	{"att_ammo","attachment_vm_sm_augolf_armag"},
	{"att_grip","attachment_vm_sm_augolf_vertgrip01"},
	{"attachment_vm_sm_augolf_arbarrel", "attachment_vm_sm_augolf_lmgbarrel", "attachment_vm_sm_augolf_smgbarrel"},
	{"att_muzzle", "att_vm_silencer01"},
	{"attachment_vm_sm_augolf_lmgrail"},
}