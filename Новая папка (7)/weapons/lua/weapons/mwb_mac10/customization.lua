-- "addons\\weapons\\lua\\weapons\\mwb_mac10\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("weap_uzulu_sup_fire_plr")

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
	{"att_ammo", "mac_mag_mac10"},
	{"mac10_stock_mac10", "mac10_f_stock_mac10"},
	{"att_grip_mac10", "mac_grip_mac10"},
	{"att_barrel_mac10", "mac_longmuz_mac10", "mac_sup_mac10"},
	{"att_laser_mac10", "mac10_laser01c_mac10", "mac10_laser02c_mac10", "mac10_laser03c_mac10",},
	{"att_laser_114_mac10", "mac10_laser01_mac10_2", "mac10_laser02_mac10_2", "mac10_laser03_mac10_2", "mac10_mawl_mac10"},
	{"attachment_vm_sn_mac10_0"},
}


