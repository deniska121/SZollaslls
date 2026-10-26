-- "addons\\weapons\\lua\\weapons\\mwb_m590\\customization.lua"
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

SWEP.Customization = {
	{"pump_wood_2", "590_eft_pump_590def", "590_eft_pump_870def", "590_eft_pump_590_wood", "590_mwii_pump_def",},
	{"590_eft_pump_receiver"},
	{"590_eft_barrel", "590_eft_barrel_v1", "590_eft_barrel_v3", "590_eft_barrel_v4", "590_mwii_barrel_v1", "590_mwii_barrel_v2", "590_mwii_barrel_v3", "590_eft_barrel_fg", "590_eft_barrel_1897"},
	{"m500_stock", "magpul_sga_stock", "mwii_590_no_stock"},
	{"590_base", "590_base_iro", "att_vm_oil_filter_suppressor"},
}