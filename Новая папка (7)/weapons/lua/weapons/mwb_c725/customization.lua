-- "addons\\weapons\\lua\\weapons\\mwb_c725\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.charlie725.fire.s")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_Shotgun2.Outside"),
				Reflection = Sound("Reflection_ARSUP.Outside")
			},
			Inside = {
				Layer = Sound("Reflection_ARSUP.Inside"),
				Reflection = Sound("Reflection_ShotgunSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

function SWEP:doDBStats()
	self.Primary.TrailingSound = Sound("wpn_shotgun_fire_lyr")
	self.ParticleEffects.MuzzleFlash = "AC_muzzle_shotgun_db"
end

SWEP.Customization = {
	{"attachment_vm_sh_charlie725_barrel", "attachment_vm_sh_charlie725_barrel_sawnoff", "attachment_vm_sh_charlie725_barrel_mid", "attachment_vm_sh_charlie725_barrel_long"},
	{"attachment_vm_sh_charlie725_guard"},
	{"attachment_vm_sh_charlie725_stock", "attachment_vm_sh_charlie725_stocklight", "attachment_vm_sh_charlie725_stock_sawnoff", "attachment_vm_sh_charlie725_stocktactical"},
}